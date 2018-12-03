class Favorite < ApplicationRecord
  belongs_to :user

  def net_rental_yield
    if !property_taxe.nil? && !work.nil? && !insurance.nil? && !total_rent.nil?
      net_rental_yield = ((total_rent*12)/(price + property_taxe + (work/12) + insurance))*(100)
    # elsif property_taxe && work && insurance && total_rent = nil
    else
      net_rental_yield = rendement
    end
  end

  def net_taxe_return
    if !total_rent.nil? && !monthy_loan.nil? && !rental_charges.nil?
      net_taxe_return = total_rent - monthy_loan - rental_charges
    # elsif property_taxe && work && insurance && total_rent = nil
    else
      net_rental_yield
    end
  end
end
