Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD73359A89
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068697; cv=none; b=k53iJbVSqa45tOSnyA8EdEJ5PwPT7EyajXQvcso8oe+MRNRSsRCh05+ucK2a3cC73jGXK/zSVTa+Fbsga6iBmlIzxASiADwqD6yeL2ZQRdYqMS9v9ApwlbYVB7BCkGlvr7gOxFnm8w9w4woYCqnPwf7IyQRYidGFWUYczWqsfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068697; c=relaxed/simple;
	bh=EMjJvFYFUyo0jlLVoUwq56z0iM/h3bzklSv/vgkbFbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVmHv9kbt4i+yqVrPIsu/HUuJwby71EGbG0hjjsrrfCPTfqqaH7jLIkk5xvzSBpFkBPcZVbRyif8eUBp7qRn5Hr/y1UMf7dCY87DzQ3k7Umnm8qPTNstDJTbBrXlc6r/EeMk2nfWFTFGpcql8pDmen/wOeWl1iwNsmpi8NSX/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=FzK0g3hq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="FzK0g3hq"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5218927884fso46775571cf.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1787068694; x=1787673494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLFK+CS/9o2sBuETagn7m9l+5x3yjhHN6Gg3zPg3uG0=;
        b=FzK0g3hqBfL0V53wKz20DuK0UV3ivE4fpzYja7IdKK2GiYuAhxRMi2y6Qwcf5qVKNj
         HzK5cBaikEahvq8fcGIsEPglYk/14CXwOLcURlnQqFeNn4L+nTuBGIi1NXDAcXWundog
         U8OP/lFSU4GTmEnuTylgwVjfBl4c6pNtdbPnyTE/OqRGo0i+T/mFYxIPRC3fFlVdrovT
         UVe2TeCp2+Htf0Vma3jpf4SUAh3rxF0/HDE6b54FCmocBDajNLs2T7MeTLeVz0zk2ZGt
         tnq1oZ+MPepLym8ElVYV7sarl0Gav2va2lBVrOnzdlHnfyJ5Zp5xEmF+/zxj3zoJ0zSS
         gtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068694; x=1787673494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLFK+CS/9o2sBuETagn7m9l+5x3yjhHN6Gg3zPg3uG0=;
        b=aA/aTkpZ1NHbddLVjOf0nNqJG21qf+NpcKMAVh4j5J5nVKc3bxj9udyH6xIu8ux275
         3khCPWwxNdXTSAfWj/77a9R2HY/DtggIFVxF1ZwNlQceBHP5WnLUDLaJ+uiZq/ulpPKx
         Vroqs/Dyt54tEUKlR8OQWSwzEgHYUXb+f++5qifWr/t9OYI7Ob/q8WvfP288QmattrXN
         2NUs5ffx0g7Sj9ktknM8Sg6P9U7uWSQ6XufJzEcZdoGusrY/kwpT1fF/xdTeSj5FBr5r
         sZcFRa4fX/9i60L9IfUIr5+bQZygE1FHPR5gbCZHRSNnYcOezqcviRA4gGWUtHei71W9
         xexA==
X-Forwarded-Encrypted: i=1; AHgh+RpTc51rzNRF/KtbV6/WLscan5gonlblbGlm1ekNlF0kqxGWHyqqe/jcMEOYtnQgG+2UyBawahQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz398wn1xnxIjc6Zpu0MYdTDDzKVbY7vQFLE90HqdYyPobNVGe/
	yFBF/JolN4ela0aNZKVEhBh0JtOYnxkbcOXNpGxRNhqi3FUoFEMaLv5cWgQdWi7qAQ==
X-Gm-Gg: AR+sD10An02i9H1a5hxMHFH2sMc9zFlmzyjZ6O8hcuk7sKXCNaCpB60RYRjaIo5W7h3
	xycyjefHhrC+7GFq4EuiRNXBvC+AAkIW4dBP5nR0X7lTIW0O3l2v91rdfg+zua597b6SB0nb/44
	Xye483TVn1ewTYMzS5xA/O1LV2A7SAoHaMNU+ToZxgwM3lO4U/qBqdMX8IhybERioBI4oXr6JyX
	l48cmF2DsTTuEalwpNe0m0VNCG0wH3/RMtrox6VjxHqigy1Ee2O1Mc6rmq86tRltGLM/050vrOy
	goA3wGMk8JplR8a5ZIn2UeeMvk+1mVwZlq3PDZg8Bhj+ffHNjM0c0L0bM9DA5cP/A4/NwkUcUI6
	1k7QkHaUoD12mf5ZOBfTUwn+hNP14Jdy3dZ1aj5kHLMa2KDq8brrkTt5k4/BeP28FlbFSrobk0A
	Kn8hBQL2t8K+7UfAGXtR+4pUDydxklP7uQbb8m8+/bt8p41QV+rEjNpE28UNmRWKmfKut8qAcQt
	g==
X-Received: by 2002:ac8:5cd1:0:b0:52d:5e88:4246 with SMTP id d75a77b69052e-52d8534c2ffmr396037101cf.16.1787068694013;
        Tue, 18 Aug 2026 08:58:14 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::dfd8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4597568fsm34614046d6.39.2026.08.18.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:58:12 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:58:10 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Vaibhav Nagare <nagarevaibhav@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>
Subject: Re: [PATCH] usb: ehci: fix QTD list corruption in qh_completions
Message-ID: <03dec848-580a-476c-bdc4-8a8b9d2e80e9@rowland.harvard.edu>
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

This is good thing to fix, but have you considered what should happen to 
the "end" ehci_qtd pointer when the scan is restarted?

Alan Stern

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
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
> +				ehci_qtd_free(ehci, last);
> +				goto rescan;
>  			}
>  			ehci_qtd_free (ehci, last);
>  			last = NULL;
> -- 
> 2.54.0
> 
