package com.schedule.agenda.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.schedule.agenda.exception.ResourceNotFoundException;
import com.schedule.agenda.model.Company;
import com.schedule.agenda.repository.CompanyRepository;

@RestController
@RequestMapping("/api/companies")

public class CompanyController {
  @Autowired
  private CompanyRepository companyRepository;

  @GetMapping
  public List<Company> getAllCompanies() {
    return companyRepository.findAll();
  }

  @PostMapping
  public Company createCompany(@RequestBody Company company) {
    return companyRepository.save(company);
  }

  @GetMapping("/{id}")
  public Company getCompanyById(@PathVariable Long id) {
    return companyRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("Company not found with id " + id));
  }

  @PutMapping("/{id}")
  public Company updateCompany(@PathVariable Long id, @RequestBody Company companyDetails) {
    Company company = companyRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("Company not found with id " + id));

    company.setCnpj(companyDetails.getCnpj());
    company.setStatus(companyDetails.getStatus());

    return companyRepository.save(company);
  }

  @DeleteMapping("/{id}")
  public void deleteCompany(@PathVariable Long id) {
    Company company = companyRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("Company not found with id " + id));

    companyRepository.delete(company);
  }
}
