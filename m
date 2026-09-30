Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23994D0CFA;
	Wed, 30 Sep 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775663; cv=none; b=HZU+byJWo2eHzd+uQnNbdEA1en2gbrT8E7Pj+3msFUJi0TxoO3MtJ33OGPS3W8X6ykRfEcl1fcalaVVA6ZOt13vzZNP+JXY/UIB9NDRIMPIcUBauX0hI6r9/X4/rcwta62leZzJShm/mRNa2v88q45RQIFYjySQx0VGVi/AqsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775663; c=relaxed/simple;
	bh=lbD+X9aOAChFMYX7v/TZxQdAsIciYs51d9tPYMS6DNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHuF6sOaTwpjV4NOz0kFBbMx+mKc1gKfc2yyWcPohdIbu5INlITdjFAVeaz1fMWASxPLVQEvwMNuu8tsGrSlQxvRoXbi5EOhnb3Q7YjUIlCs8MYVTDblDHmC7p5OjGFczlMJFd/F19sXvKpFO9DIlwoAg2hYHf4HbSIDn9Wm2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=eRJ1htHU; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="eRJ1htHU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=Lzur3DsCWAVOwV0V2L+nANQnGi0j4W6O3LvqgITvINQ=; t=1790775657; x=1791985257; 
	b=eRJ1htHUfE03Md1pvUt7aisXh8wRqE3CyOWdZeElvRvFhXfaomk6EPaVFxKkEk5ZlALdEIK/DE+
	6wUMLIAPSBfe70fFptmaVROpqKQa3H/YXYhT0+PFRKsfQsoxJlLkNnLSeR6km33ls+tm/t4r/o5O+
	g+nPR0apENIOHS/EKZEiiBeYYAiBef//6LPbCxW8NEv4BJEaFul+q0AI/i7/QAW/b9coKmldWDl+i
	q+9cPPamfkengiMM+c02+2PvlHuMBPs1D0yJTZRzfgxUtJwgAsYjG9OHoEC039iZYt4q+8W+uZMrH
	Ks4olwaFNUirp6hQO+olB6xd0Aa6E3Ym0KPQ==;
Date: Wed, 30 Sep 2026 15:40:44 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: musb: Drop the D+ pullup during system suspend
Message-ID: <20260930154044.3621523b@kemnade.info>
In-Reply-To: <20260927164145.1956429-1-tien.nguyenminh@embeddedlinux.blog>
References: <20260927164145.1956429-1-tien.nguyenminh@embeddedlinux.blog>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 23:41:45 +0700
Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog> wrote:

> When musb_suspend() clears DEVCTL, the host sees a disconnect. But VBUS
> is still there, so the controller can start a new session on its own
> and, with SOFTCONN still set, pull D+ up again while its interrupts are
> masked. The host then fails to enumerate the gadget ("unable to
> enumerate USB device") and gives up, and nothing at resume makes it try
> again. On a T113-S3 board the gadget link never survived an s2idle
> cycle.
> 
> Clear SOFTCONN once the context is saved; musb_restore_context() puts
> it back on resume. This is what the FIXME asked for, as USB can't wake
> us in time with the interrupts masked. On da8xx, which keeps the
> session over suspend, the gadget now disconnects too.
> 
> Fixes: 6fc6f4b87cb3 ("usb: musb: Disable interrupts on suspend, enable them on resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
> ---
> I found this on a T113-S3 board (sunxi, s2idle, Intel xHCI host): ssh
> over the gadget never came back after a suspend. With the patch, all 30
> cycles I ran re-enumerated after resume.
> 
> To check for regressions, I also tried a BeagleBone Black (AM335x,
> dsps glue, suspend to RAM). There the link came back after every
> resume (10 cycles without the patch, 30 with it), probably because
> am335x_phy_suspend() powers the PHY off. 

Yes, other glue layers power off the phy, too. so this issue becomes
undiscovered. I think that difference should be commented in the code
so that everybody touching this is aware of the difference.

Regards,
Andreas
> 
>  drivers/usb/musb/musb_core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 73ac25f536..272683f14d 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2825,18 +2825,24 @@ static int musb_suspend(struct device *dev)
>  
>  	spin_lock_irqsave(&musb->lock, flags);
>  
> +	musb_save_context(musb);
> +
>  	if (is_peripheral_active(musb)) {
> -		/* FIXME force disconnect unless we know USB will wake
> -		 * the system up quickly enough to respond ...
> +		/*
> +		 * We can't answer a host with the interrupts off, so drop the
> +		 * D+ pullup. musb_restore_context() puts back the state saved
> +		 * above.
>  		 */
> +		u8 power = musb_readb(musb->mregs, MUSB_POWER);
> +
> +		musb_writeb(musb->mregs, MUSB_POWER,
> +			    power & ~MUSB_POWER_SOFTCONN);
>  	} else if (is_host_active(musb)) {
>  		/* we know all the children are suspended; sometimes
>  		 * they will even be wakeup-enabled.
>  		 */
>  	}
>  
> -	musb_save_context(musb);
> -
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  	return 0;
>  }
> 
> base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14

