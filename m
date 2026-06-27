Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301A3161A1
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782587165; cv=none; b=bf9Ni/DiQqLMypy7Lt8/KArUoTTuLhaDA7YZTchNrjaUyJUQsl3klI2RmN+Kr73P4W51kKq3+oqZNsgaUfNqfS8LYr1uvKiwUcPNlHvhh+Ot2OWmeEsuVrF7CUbknR1DeEcrl3wvmbasglMkS64rM6Vdb5gkG2ZVdvGeLRIR4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782587165; c=relaxed/simple;
	bh=89Zjr3sigTpNO+YBK0fIaiyL/mTz7iHfnKZeTYd4owc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF4d9bHRHR/12X+bcSNwCqZnkLD92tRU1OEb93N1/L3ljxqVOhNiBbfgO2IK8NLemE0QHxarCuvyNtiSn6C6a02791dlLrX4vIMSxTGv3MUY9ra147J+aVatSkYG8587ex5K2K78lPBrfURZrX1fAB7cRmjh1reZRR67HuZ3d80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Xy4i3pxx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Xy4i3pxx"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ee88fce536so2665246d6.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782587162; x=1783191962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmvmjt9spbKklkKa1+k5Z+7yo+q1XUSyyWvIpAb5/rY=;
        b=Xy4i3pxxx5BLnN9jW+L7GFwFPCm+ws8NXbyI5R9t/wVDvCMvy1OnSiiWn+DnDWNwSK
         PSelaD0UAy/P+wYxcnNcImBmORTH3tCbQ5ziIQXgrdIoofPzL03JCUT3bnmc981Zl577
         GGKsQqF/PZFTTsOamjP5srY6VEqXtcMe7KcddatfSomRn7QuB9bzTSVVZDikTND+h2YF
         emLSZ2WMBaSuN6hmZreOpizHpxS/r1xZO6NH9N1u/KzY6rSSWYsKN4q4hC872Ln1ojOE
         lGLSHOGc/ZjPxMXrF/f5LSsDXKHP2ovrfFf7gCDKUjosajtKycJYa8UiKHGKRceHP4xj
         za7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782587162; x=1783191962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmvmjt9spbKklkKa1+k5Z+7yo+q1XUSyyWvIpAb5/rY=;
        b=pUsnCOk6RzPZggylkx/7lBuaYPTDuk0hY1OH1KnsCPZ2XGGoOQ2SuKgL2WNPEVyUdR
         3Jf78nu40sFsnS+h2jq/0b+pe+6C9KyMfm5AN4X72juMv2IR6RL/XK/3fhtwWQR64b1k
         L5g3mwl9u/FJWC/+U7E3hBUnltl7pZIIAj+brN6+nMiguUx92HD+z+Foe0RoFTAMAAAz
         EnpCrrxaq1Zzd64DDtqRFtQCc4SsAhTHfyhlFK0Qwcx0q9BgUldUDD840iVyPj6V/3Gg
         TPvGY22lLOJaEbhQ71saFg6U1IvC5zV/7JvyA+sBfomsqoI8f+zENczpcVGGI5jdWYdq
         GrAg==
X-Forwarded-Encrypted: i=1; AHgh+Rrvxirsqf5kP/W7HGVM71uKG5WG4ix+TAUcWbIH+U2MzgUncoYr18+xbpiW9AZ1AQXg+c88VMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZQP738dlkh8M1HscYUZEcBi/50uW8TzOcm3U861+LRZSEHWP
	DAX7Wqxpep1E/CYTi270GfcZjaPuG+UpeJgoY0Gv9gcJTYWBEp6NnKlTQbu+SmFTWg==
X-Gm-Gg: AfdE7clD73QSYWSqb1SnS3wthENaJSwBQDueViuTpOYFchG399nfZFxOZ0RH1kp3MV4
	txXUqfFWwyeBVntB4DsDy5dVGOGDHketU8jJyUOuFOLM4NmNHJ2Ty4V+VDn8GZfc+w1zCslAEUB
	mipRx2onLuFBhlUR5NwbvYp71d/oUgRhkttffC8+/u+MCouOJH+/7NuSlQp6eiKMIvmjzQs81HO
	KrY5MAAmrtTbb7C0+AAV29FJdcJZXdvygtgS4NonPRHnNtYiPmVp0um4xbybNHzeHhpvGCOW0Qo
	7QS56T+rd7M4jg+TmsLzCdMRw+itHRMQmbQDWTcmIW1fUZ4Dhlaz9x2HpzRkQ0DWlE0gJfTm7h7
	sNpxnCsR2K7yG13TYk39HhgUzAm2l3Y4qAaxv0jKp+48KmCjZjeu8YWDmNogNfNpaCiWSqm3Ep3
	y6wHwkukGIW6+MrO7SUqrPXs8M4EYTPbOa
X-Received: by 2002:ad4:5aeb:0:b0:8ed:a980:6b2c with SMTP id 6a1803df08f44-8eda980739bmr31745426d6.30.1782587161596;
        Sat, 27 Jun 2026 12:06:01 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82693f73sm251673806d6.44.2026.06.27.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 12:06:00 -0700 (PDT)
Date: Sat, 27 Jun 2026 15:05:57 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: gregkh@linuxfoundation.org, linusw@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, zilin@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH] usb: free iso schedules on failed submit
Message-ID: <1b80afec-0263-4e7a-8f9f-94abf15ae239@rowland.harvard.edu>
References: <20260627060207.2543749-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627060207.2543749-1-dawei.feng@seu.edu.cn>

On Sat, Jun 27, 2026 at 02:02:07PM +0800, Dawei Feng wrote:
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
>  drivers/usb/fotg210/fotg210-hcd.c | 4 ++++
>  drivers/usb/host/ehci-sched.c     | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
> index 1a48329a4e08..d92b11d488a5 100644
> --- a/drivers/usb/fotg210/fotg210-hcd.c
> +++ b/drivers/usb/fotg210/fotg210-hcd.c
> @@ -4562,6 +4562,10 @@ static int itd_submit(struct fotg210_hcd *fotg210, struct urb *urb,
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
> index a241337c9af8..33a0111cfb37 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -1966,6 +1966,10 @@ static int itd_submit(struct ehci_hcd *ehci, struct urb *urb,
>  		usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
>  	}
>   done_not_linked:
> +	if (status < 0) {
> +		iso_sched_free(stream, urb->hcpriv);
> +		urb->hcpriv = NULL;
> +	}

That's not quite optimal, because iso_stream_schedule() already calls 
iso_sched_free() whenever its return value is < 0.  You should remove 
that call now that the deallocation is being done down here.  And also 
have iso_stream_schedule() clear urb->hcpriv in the other place where it 
calls iso_sched_free().

Aside from that, this looks good.

Alan Stern

>  	spin_unlock_irqrestore(&ehci->lock, flags);
>   done:
>  	return status;
> @@ -2343,6 +2347,10 @@ static int sitd_submit(struct ehci_hcd *ehci, struct urb *urb,
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
