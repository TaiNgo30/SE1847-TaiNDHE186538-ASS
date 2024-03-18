/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Vector;
import model.BillDetail;
import model.BillDetailForAdmin;

/**
 *
 * @author ducta
 */
public class ManageBillController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String service = request.getParameter("service");
        request.setAttribute("manageBill", "Yes");
        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            Vector<BillDetailForAdmin> billDetailForAdmins = (new BillDAO()).showBillDetailForAdmin();

            request.setAttribute("billDetailForAdmins", billDetailForAdmins);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("showDetailBill")) {
            int billId = Integer.parseInt(request.getParameter("billId"));
            String status = request.getParameter("status");

            Vector<BillDetail> billDetails = (new BillDAO()).showBillDetail(billId);

            request.setAttribute("status", status);
            request.setAttribute("billDetails", billDetails);

            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.startsWith("changeStatusTo")) {
            int billId = Integer.parseInt(request.getParameter("billId"));
            String statusInShowDetail = request.getParameter("statusInShowDetail");
            //check if status is done

            if (statusInShowDetail.equals("done")) {
                request.setAttribute("changeStatus", "Status of this bill is done, you can not change it!");
            } else {

                if (service.endsWith("Wait")) {
                    (new BillDAO()).updateStatus("wait", billId);
                    request.setAttribute("changeStatus", "Admin change status of Bill (ID = " + billId + ") to Wait");
                }

                if (service.endsWith("Process")) {
                    (new BillDAO()).updateStatus("process", billId);
                    request.setAttribute("changeStatus", "Admin change status of Bill (ID = " + billId + ") to Process");

                }

                if (service.endsWith("Done")) {
                    (new BillDAO()).updateStatus("done", billId);
                    request.setAttribute("changeStatus", "Admin change status of Bill (ID = " + billId + ") to Done");

                }

            }
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("filterStatus")) {
            String filter = request.getParameter("filter");
            Vector<BillDetailForAdmin> bdfas = new Vector<>();
            if (filter.equals("all")) {
                bdfas = (new BillDAO()).showBillDetailForAdmin();
            } else {
                bdfas = (new BillDAO()).showBillDetailForAdminFilterByStatus(filter);
            }
            request.setAttribute("billDetailForAdmins", bdfas);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

    }

}
