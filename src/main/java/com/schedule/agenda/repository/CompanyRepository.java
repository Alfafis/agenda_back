package com.schedule.agenda.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.schedule.agenda.model.Company;

@Repository
public interface CompanyRepository extends JpaRepository<Company, Long> {
  // Se necessário, adicione métodos personalizados aqui
}
