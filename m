Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE241A4F8;
	Tue,  1 Sep 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279459; cv=none; b=HtwtEJG8ICzkVKT940/L3vc8SobTTC5Y1OrX/9IPPXBl0XcEGe0pUjYPiGbFtuzIC8pX3UGs8rPj+DR7GoRWlpXW7DkqVpylhAIwFgD43ZoZq+MXAej8sa5i2fMY4c/fuEniKtZacmgC10lOx26N3xFdRUiVprKCW+kW68jk3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279459; c=relaxed/simple;
	bh=xFoID5dsCVdyNnoS77h4yQyZjhMsd4vvPl14vyIBDT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HrsFjTTuc0npJlcnNXD0+X4r/9r2ES8o8KkEuY3R7zmdxLFM3/LNOocYShqiAjWjAKkDlGqSjzjK0KszxwhgPE7s/+PJ+1/sUi9xjOQK15TfSQuoAloR6SL2wDbvsQ5WUCVrePEzAjef3xXXUbskkDrnwWEOO4mwiQ14ZzmSxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1EeFBQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1EeFBQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A51F000E9;
	Tue,  1 Sep 2026 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788279458;
	bh=Q/H4D9YN1A9VR8cxIJXQbn/Vltw0TakhOCAYQeeVo8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=k1EeFBQ/ooyW10zvdB0HYPv+QHoiBhb/Qbf0VthiHYhazqmrfasfY7b6hu9wW6v0l
	 Rh9yxoLn96EpSacM3n9AxoVa17eMqQXzGb7ZSGmm9385CTzdOrh2kFcHmMMy2Wk3nT
	 +rv6BPrKOBIO9JVCUxgDJqkRD4C0qv0S3w5NXcng7kbyhQZMuZ5AIjKiEgyXBv4ST2
	 D2LK3gHWVZkC04GBBjUcsn8nwACYk8utPgaLtizIBuc/Khds8NAgxIL+XjaVf2gs+A
	 mUePM3wdeWBG3OjqmRLOyd/vUjZ1i4KpbxJ5+WUWAZFJEtRINGNW3PAHhC9x9knjr5
	 ww+T7HWCCx0Pg==
Date: Tue, 1 Sep 2026 11:17:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Nika Krasnova <nika@nikableh.moe>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mark Pearson <markpearson@lenovo.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH wireless v2 1/3] wifi: iwlwifi: pcie: don't infer CSME
 presence from a failed read
Message-ID: <20260901161736.GA1883420@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901154828.GA1879052@bhelgaas>

On Tue, Sep 01, 2026 at 10:48:28AM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 31, 2026 at 06:33:30PM +0530, Navon John Lukose wrote:
> > iwl_pcie_check_me_status() decides whether WiAMT/CSME is present from two
> > register reads, without checking that either read reached the device.
> > 
> > iwl_read_prph() returns 0x5a5a5a5a when it cannot grab NIC access, and
> > that value has CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN set and
> > CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT clear. A read that never reached
> > the hardware is therefore taken as a positive statement that there is no
> > CSME, and the function returns without scheduling the recheck. That is
> > reachable at probe: iwl_pci_gen1_2_probe() carries on when
> > iwl_pcie_prepare_card_hw() fails, and iwl_pcie_check_me_status() then
> > runs against a card it cannot talk to.
> > 
> > The second read has the mirror-image problem: an all-ones
> > CSR_HW_IF_CONFIG_REG has both ME_OWN and IAMT_UP set, so a device that
> > has fallen off the bus latches me_present to 1. So does the one in
> > iwl_pcie_recheck_me_status(), which runs a second after probe with no
> > guarantee that the device is still answering.
> > 
> > me_present is never recomputed after that, and any non-zero value makes
> > iwl_trans_pcie_reset() downgrade IWL_RESET_MODE_PROD_RESET to
> > IWL_RESET_MODE_FUNC_RESET, so one bad read permanently weakens the
> > recovery. In the 0x5a5a5a5a case it goes the other way and permits a
> > product reset on a machine that may well have CSME.
> > 
> > Don't take those values as data. iwl_trans_is_hw_error_value() matches
> > 0x5a5a5a5[0-f] and 0xa5a5a5a[0-f] but not ~0, so the prph read in
> > iwl_pcie_check_me_status() needs both tests, the way
> > iwl_pcie_irq_handler() does; the two CSR reads only need the ~0 one. At
> > probe that leaves me_present at -1 (unknown) and still schedules the
> > recheck; in the recheck it keeps the previous value.
> > 
> > This does change the reset ladder in the poisoned-read case, and -1 is
> > truthy: a product reset that iwl_trans_pcie_reset() used to allow -
> > because 0x5a5a5a5a had been read as me_present = 0 - is now downgraded
> > to a function level reset. That is the conservative direction, and the 0
> > was never a reading, but it is a behaviour change and not a no-op.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")
> > Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
> > ---
> > Backport note: the bug arrived in v6.14, so the affected branches that are
> > still supported are 6.18.y, 7.1.y and 7.2.y. All three have the code in
> > pcie/gen1_2/trans.c as trans_pcie->me_present, so this applies as posted
> > with no rewrite.
> > 
> > Only if you care about anything older that has the bug - v6.14 through
> > v6.17, all EOL now: v6.16 and below have both functions in pcie/drv.c
> > (377edee91b89 "wifi: iwlwifi: pcie move gen1_2 probe to gen1_2/trans.c"
> > moved them), and v6.15 and below spell the field trans->me_present
> > (cd6d6de694e2 "wifi: iwlwifi: pcie: move ME check data to pcie" renamed
> > it). The hunks are otherwise identical; iwl_trans_is_hw_error_value()
> > exists in every affected release.
> > 
> >  .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c  | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> > index 28b276c..c6a771e 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> > @@ -4194,7 +4194,8 @@ static void iwl_pcie_recheck_me_status(struct work_struct *wk)
> >  	u32 val;
> >  
> >  	val = iwl_read32(trans_pcie->trans, CSR_HW_IF_CONFIG_REG);
> > -	trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
> > +	if (val != ~0U)
> 
> Consider using PCI_POSSIBLE_ERROR() for these tests.
> 
> > +		trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
> >  }
> >  
> >  static void iwl_pcie_check_me_status(struct iwl_trans *trans)
> > @@ -4212,15 +4213,19 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
> >  		return;
> >  
> >  	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
> > -	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
> > +	/* iwl_read_prph() returns 0x5a5a5a5a if it never reached the NIC, and
> > +	 * that value has WIAMT_KNOWN set and WIAMT_PRESENT clear
> > +	 */
> > +	if (val != ~0U && !iwl_trans_is_hw_error_value(val) &&

I wonder whether iwl_trans_is_hw_error_value() should itself check for
PCI_POSSIBLE_ERROR() internally.  Or other callers should also check.

iwlwifi has a mix of checking for 0xffffffff and ~0.  I don't know if
it can use non-PCI transports, but some of those places look like they
could use PCI_POSSIBLE_ERROR().

> > +	    (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN)) {
> >  		trans_pcie->me_present =
> >  			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
> >  		return;
> >  	}
> >  
> >  	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
> > -	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
> > -		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
> > +	if (val != ~0U && (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
> > +				  CSR_HW_IF_CONFIG_REG_IAMT_UP))) {
> >  		trans_pcie->me_present = 1;
> >  		return;
> >  	}
> > -- 
> > 2.55.0
> > 
