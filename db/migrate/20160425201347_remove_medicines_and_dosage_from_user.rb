class RemoveMedicinesAndDosageFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :medicines
    remove_column :users, :doses
  end
end
