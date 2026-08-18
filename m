Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AC38E8B8;
	Tue, 18 Aug 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042266; cv=none; b=NDdUdbhJxzwxVPzhKimF0ib6sozU6CXlseQECzAhxah2mt76ZI8ffxpVO1Cmdfk7HljuOR24emdYigb46ZNTwtLNe71f38XHWZxoFxP2rN9lz/PPBjaXuww1LiksvTgW+KXLqVWm4PT0mGlJG66JQhRfZg7245eAVtwQaHpr8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042266; c=relaxed/simple;
	bh=FGuXiPKOOqlAUG7Xkonnp++yI8Q/umMV4clf2uyCVkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhsRkYjPukZwV3eyh3OCLpnJngu1gLFF+Je1dcV6H7GwhP089PbR3fzPavJmh6O8EjXh51dAj2qqypz6LcldW6QapLLQJSnTDQEvPAIPOeO9bzOjJ3LafCToz39YXfJTpI2FP/Mm5DKL1uJ+VwW8ZxxARUak3vfYBtqZmnHOLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bzKtS+ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bzKtS+ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C6A1F000E9;
	Tue, 18 Aug 2026 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787042264;
	bh=sB29a7zPO3bvYEvzTvcfyhz4wMWiAfzmngR5D4xl6bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzKtS+jifSoNQw5Sa1Gg5OHsojjR6BgHYNfNLLh/dVMsoldtNibel8iPaJvKTQ77T
	 xarVmfaKOEuoiD0wXRFNOtPIAX/Fy/QX9nPBodaQ6macY9LMRwrrhiTaEZ3vhsacJy
	 JBgSqRTyqPLQyJeuKj8IHznxXGN3uwWreCU4VoOg=
Date: Tue, 18 Aug 2026 10:36:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vaibhav Nagare <nagarevaibhav@gmail.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>
Subject: Re: [PATCH] usb: ehci: fix QTD list corruption in qh_completions
Message-ID: <2026081833-stoppage-charting-dcc9@gregkh>
References: <20260818083323.2270580-1-vnagare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818083323.2270580-1-vnagare@redhat.com>

On Tue, Aug 18, 2026 at 02:03:23PM +0530, Vaibhav Nagare wrote:
> In qh_completions(), when completing a URB at a URB boundary
> (last->urb != urb), ehci_urb_done() is called which drops ehci->lock
> via usb_hcd_giveback_urb() for the completion callback. While the lock
> is dropped, a concurrent ehci_urb_dequeue() (e.g. from a TX timeout
> recovery) can modify the QTD list, making the 'tmp' pointer saved by
> list_for_each_safe() stale. Continuing iteration with a stale pointer
> leads to list_del() corruption and a kernel panic:
> 
>     list_del corruption. prev->next should be ff27e4e01aefa580,
>     but was ff27e4e01aefa1c0
>     kernel BUG at lib/list_debug.c:51!
>     Call Trace:
>       qh_completions+0x28f/0x640
>       ehci_work.part.0+0x1d5/0x330
>       ehci_irq+0x3d2/0x490
> 
> This was observed on systems with an HPE iLO5 Virtual NIC (cdc_ncm)
> where repeated NETDEV WATCHDOG TX timeouts trigger concurrent URB
> unlinks that race with the qh_completions lock-drop window.
> 
> Fix this by freeing the completed QTD and restarting the list scan
> via the existing rescan label after ehci_urb_done(). This is safe
> because already-processed QTDs have been removed via list_del() and
> the list is strictly shrinking, guaranteeing forward progress.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>

Does not match your From: line.

> ---
>  drivers/usb/host/ehci-q.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index ba37a9fcab92..c715648e97ab 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -328,7 +328,16 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
>  		if (last) {
>  			if (likely (last->urb != urb)) {
>  				ehci_urb_done(ehci, last->urb, last_status);
> -				last_status = -EINPROGRESS;
> +				/*
> +				 * ehci_urb_done() drops ehci->lock for the
> +				 * completion callback. The QTD list may have
> +				 * been modified (e.g. by URB unlink during
> +				 * TX timeout recovery). The 'tmp' saved by
> +				 * list_for_each_safe() may be stale.
> +				 * Free last and restart the scan.
> +				 */

Did a LLM write this?

thanks,

greg k-h
