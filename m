Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE254EBAF4
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557966; cv=none; b=A0XuhaWQLmCYq9yPFDx9v63jiHA3HCKjjhzOHuXTwl4wvhlA1XfqjVcAM4CUtGe0uKXueTarqXNgiu7FPM/M2OyFU3DWmBUQqtSXzNGCM4hHdVOar0hEZtzry9GmzI5g+uX6MRAtVb1IGspNqAnskiEvdA2YFFAlk3DUEVT8S2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557966; c=relaxed/simple;
	bh=R+3NIbEmxJLr+oMhc13WIXNbtNuk0Sei3SCThPTbyxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWEs5s0BYMovcyn4w3okOeLUrUQJHiKSltWo7ypf+e/gu1CKiCRn66lieFRi0IerwAm16S7aeVk8HA65DVLWLoHlZTtfFaiQ6LmtpZohTKz12HcQ2fc5wt7/0dQanEs7PEIQNx72ofTB2u8JJtKgrw0aGJo7HO4YaYuMT1W0hFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=VEsfktkl; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="VEsfktkl"
Received: (wp-smtpd smtp.wp.pl 41478 invoked from network); 16 Sep 2026 13:19:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1789557544; bh=J1ce+vBR72jQkw//XqeqfopumQBMFWBnvlUt11/clpA=;
          h=From:To:Cc:Subject;
          b=VEsfktklkcfel3O92dKw3IGUlHun6u9rxpNVVSFXLEDz1oSnxU+EqaVu4lb75uMnr
           WSbo0c7knJ8aE8hPcJbe0snHRsSfZ1WkEUmRg6q9YUSVSER51mtOq8v1I0B/soVDV/
           JzMT32q33Cb8MU86SxuIW+2PJqJX44q+9j4+hk1IPQCAb0lyeu1jTLDe8rH2rKAPQY
           +6a2x6hhQl5tV+fgQAoERadIYvDpJXzQ5x3H8/nEZWb9wuUPYxSTJzKAfzcSjraJNV
           eYgwDABHq/hQEdCxYXTqr7QrC3cvB5F0mckXFmySDUDER4vFcKnnG2cUpeGa820sMR
           5dv0+1T9ydlJw==
Received: from localhost (77-236-6-58.static.play.pl [77.236.6.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <lgs201920130244@gmail.com>; 16 Sep 2026 13:19:04 +0200
Date: Wed, 16 Sep 2026 13:19:04 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
	Ron Rindjunsky <ron.rindjunsky@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: 3945: free EEPROM data on remove
Message-ID: <20260916111904.GA15164@wp.pl>
References: <20260916073736.2952028-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916073736.2952028-1-lgs201920130244@gmail.com>
X-WP-MailID: eef6d4e4e276139c5143eea1506d8038
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IRMx]                               

On Wed, Sep 16, 2026 at 03:37:36PM +0800, Guangshuo Li wrote:
> il3945_pci_probe() calls il_eeprom_init(), which allocates memory for
> the EEPROM data. The probe failure paths release this allocation with
> il_eeprom_free(), but the remove path does not free it after a
> successful probe.
> 
> As a result, the EEPROM data is leaked when the PCI device is removed.
> 
> Free the EEPROM data in il3945_pci_remove() before releasing the
> mac80211 hardware structure.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 073d3f5f1b3b ("iwlwifi: changing EEPROM layout handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index cbaf250626c5..f7ca182d1494 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -3807,6 +3807,7 @@ il3945_pci_remove(struct pci_dev *pdev)
>  
>  	il_free_channel_map(il);
>  	il_free_geos(il);
> +	il_eeprom_free(il);
>  	kfree(il->scan_cmd);
>  	dev_kfree_skb(il->beacon_skb);
>  	ieee80211_free_hw(il->hw);
> -- 
> 2.43.0
> 
