Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC63D4657CF
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834536; cv=none; b=mHyEuX+91lmmKkqKymz6boOsnI/OSDZw/feehiRdeExuPXYTCT3DFGOg+MjvZvlPtZOglHhxdQ+o5Jc/ZH8E8kscpB4BDLOqcuRdoVVvebqi0wWqJJjW2Nsu/rl1ETUTdUm6T98gDwPhbqSBx3FnC/ViqRJ+g6U+fho+xo2VhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834536; c=relaxed/simple;
	bh=+Nu8T2P5J4piOI6iPNLzOouVdCkgquRY6nHCGOeDlSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hphYUBW/5c5uNvnfSfAC4hYdieqwOM1GYpMmWzLbz14moM+V0i692pRMOMAZ97/rBG0MZkOnQBsaZj965vgI50LQGIc6CgHlT2QAMe4moW4NrXaWa+lTDWOjHhVQCRth+cL2JlSMGXcvmFX07BQ1aAL4pjWj8A3a1pZqaZZ+vVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=tR9ajE1d; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="tR9ajE1d"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51a0188b92fso48530281cf.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782834533; x=1783439333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T+E4S6GTRJ9jJ/udD9Nkt2a9cnzXt0ecKVKDowSdAYc=;
        b=tR9ajE1dR3A5NMBnNqf4AYx7AGFybH5Dd/TrgdysOKnd5O5zwMAiarlTJ8VlOJ6pFH
         VUtjLkB0j96oRiAgu9CbYRqj7ZkU5YRNSfbUx7DfmvWRYP/YGPm4h0HfaSKkeyOLs+a2
         QqCtERDkuiN7FX/Nt68a4CiU8McrPG+Nd/N+h0U27tdnnk1aQJBNAp9Qy+KslS0O+MgT
         Nh5dy0CkFSmRTLxev7JfI1XEMuFM9h4Vp3JQszQu+zos+BIGi12luxvOBPgGVEVV88/D
         KWHo7qTq2KPhNrxKi+UBl1MjzJvTWLCbEOHZsSPCD2JEbt2jlcVxCzlyaAeAAEI1b2qa
         EgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834533; x=1783439333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+E4S6GTRJ9jJ/udD9Nkt2a9cnzXt0ecKVKDowSdAYc=;
        b=cJGT7tJ3jYhyutcfmd6mV9ZdKB1OjENqG3/3xZDfaTscZUYf2+263rPT0qmVKkJ1Ry
         dBO+Q7SBIAdArStNQgSeREVHMTCxJWY6mbVDn2TVXyCiMg1RqUttAAy3Uo1aBl38vqhd
         hOjvCELo6XjXgX9wFVNU4k9rCoFWE2ijb5HC8L6x2IOtp1hnEKfMft9CX0D1sHl8kMjR
         u5GRPihu6Gad7ydojXew2HZPKJ7Y/hipsShecfbg34mH6UFuh4jeiC4zx7A7nnOo+0Zs
         Cj4auRK/f+4DO/elAYgI8NQCCpXJN4FbVh6WIrSb6+O2VOMzjsBzJyEEi+CZtFAdrpfj
         nnQg==
X-Forwarded-Encrypted: i=1; AFNElJ+CYRgNBm9XW99Y08KDHM+BMmD642zFXt6Koga9G5/pLkXkPh4IIlxtNeoujHvVpqbn3pCDVOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3CbfBZfNR5RWbwk76JGWu00DlxhRcMErcht+8bQrmRbAiwmm
	aHIZLtQ2bcwkXgWxJcXnk8vF2LSkWzHmouUzWTULVtMnPAs57FnI8VBV2r120xuE1MA2MdxwSmw
	Q4pshvg==
X-Gm-Gg: AfdE7ckF7xLkoZkbulVV0UZ7hLfmMITd47TWqPLPkZGa12Y+5LSuvJAFUNg2DBM6PMX
	w0u/jr0Yt2OVTzN4rHrsl8sdzDqK9BUwHt/curKszHXLICBZyfiQU/A5/bqBWvEwRlfgqUlFpwj
	skeaw4RAO4RzAh3pjjD25CIgPIj7E+SfIUW1CijyBmzFz29WkMkkn7XYJBVq4zaU1Om2yWQpCTy
	IYc5jDPfpAIGP+7ncEnBiRSIEX82cD1Pg55M1cPUwBkfwLuvZVE/0ITHvgtWVkG41m4T4rwoyTw
	tanleO8B10vf/v6Snr7kF1qUhkwDKNZRXO1UI1M19LIY3DH6R/5teSXuu06lgwm+obM2FikmE9h
	wOBWqU6UUWBi9Z0GZI5q941syc04wCqqJCTMfxizC4qPrrBYiLSREU1Ju9iD0FIX6QKnEWEahae
	9r0CnW9smTJb1QIA==
X-Received: by 2002:ac8:7191:0:b0:51c:147d:9bec with SMTP id d75a77b69052e-51c147d9e47mr27863881cf.6.1782834532456;
        Tue, 30 Jun 2026 08:48:52 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::883a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a265efsm21250581cf.27.2026.06.30.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:48:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:48:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: gregkh@linuxfoundation.org, linusw@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, zilin@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: free iso schedules on failed submit
Message-ID: <667e59f6-c91f-4bcc-ae70-5fc211d9e606@rowland.harvard.edu>
References: <20260630071419.349161-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630071419.349161-1-dawei.feng@seu.edu.cn>

On Tue, Jun 30, 2026 at 03:14:19PM +0800, Dawei Feng wrote:
> EHCI and FOTG210 isochronous submits build an ehci_iso_sched before
> linking the URB to the endpoint queue, and keep the staged schedule in
> urb->hcpriv until iso_stream_schedule() and the link helpers consume it.
> If the controller is no longer accessible, or usb_hcd_link_urb_to_ep()
> fails, submit jumps to done_not_linked before that handoff happens and
> leaks the staged schedule still attached to urb->hcpriv.
> 
> Free the staged schedule from done_not_linked when submit fails before
> the URB is linked and clear urb->hcpriv after the free.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> EHCI host controller with a USB isochronous device to test with, no
> runtime testing was able to be performed.
> 
> Fixes: 8de98402652c ("[PATCH] USB: Fix USB suspend/resume crasher (#2)")
> Fixes: e9df41c5c589 ("USB: make HCDs responsible for managing endpoint queues")
> Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
> Changes in v2:
> - Move negative iso_stream_schedule() cleanup to the submit failure path.
> - Clear urb->hcpriv after iso_stream_schedule() frees the schedule for an
>   immediately completed EHCI URB.

For the ehci-sched portion:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/fotg210/fotg210-hcd.c |  6 ++++--
>  drivers/usb/host/ehci-sched.c     | 11 +++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
> index 1a48329a4e08..956be5b56510 100644
> --- a/drivers/usb/fotg210/fotg210-hcd.c
> +++ b/drivers/usb/fotg210/fotg210-hcd.c
> @@ -4267,8 +4267,6 @@ static int iso_stream_schedule(struct fotg210_hcd *fotg210, struct urb *urb,
>  	return 0;
>  
>  fail:
> -	iso_sched_free(stream, sched);
> -	urb->hcpriv = NULL;
>  	return status;
>  }
>  
> @@ -4562,6 +4560,10 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
>  	else
>  		usb_hcd_unlink_urb_from_ep(fotg210_to_hcd(fotg210), urb);
>  done_not_linked:
> +	if (status < 0) {
> +		iso_sched_free(stream, urb->hcpriv);
> +		urb->hcpriv = NULL;
> +	}
>  	spin_unlock_irqrestore(&fotg210->lock, flags);
>  done:
>  	return status;
> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
> index a241337c9af8..57d07d1c2dfa 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -1623,6 +1623,7 @@ iso_stream_schedule(
>  			status = 1;	/* and give it back immediately */
>  			iso_sched_free(stream, sched);
>  			sched = NULL;
> +			urb->hcpriv = NULL;
>  		}
>  	}
>  	urb->error_count = skip / period;
> @@ -1653,8 +1654,6 @@ iso_stream_schedule(
>  	return status;
>  
>   fail:
> -	iso_sched_free(stream, sched);
> -	urb->hcpriv = NULL;
>  	return status;
>  }
>  
> @@ -1966,6 +1965,10 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
>  		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>  	}
>   done_not_linked:
> +	if (status < 0) {
> +		iso_sched_free(stream, urb->hcpriv);
> +		urb->hcpriv = NULL;
> +	}
>  	spin_unlock_irqrestore(&ehci->lock, flags);
>   done:
>  	return status;
> @@ -2343,6 +2346,10 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
>  		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>  	}
>   done_not_linked:
> +	if (status < 0) {
> +		iso_sched_free(stream, urb->hcpriv);
> +		urb->hcpriv = NULL;
> +	}
>  	spin_unlock_irqrestore(&ehci->lock, flags);
>   done:
>  	return status;
> -- 
> 2.34.1
