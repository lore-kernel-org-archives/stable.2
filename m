Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866488;
	b=1V19iqkPnwSYepBNGrqfLk7dVUNYmHr5V5RgUwJJrYF3hfAEpdtcXNZqFeyJVYmsf3C8
	 XItlDjRs1tCpC17bdzMUdCQD1qfe8oFfF+o41/PGRY04lKrwoyYh2ek6Z1W9ApTkndQyp
	 bEH2nRPJ1Tlmbnb/cXlTNR5Cf5sIgT5qu/SE05k1Ze0Rsnwnuf+29Lb/Fq3eboL3JfmdW
	 s5MklP4dfWJv375qbA08B0a24I7hdHNv6JlU7Wj2rl1l/SZtVVmQEVqmHBQ772fPkOybC
	 E8CYhOyX9TPmgad59pB6w5Uxrth5Rha5ek/F8UPn5ghQZI02JS7Nq9ohcL5vJYcPk7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HZGm2VHNwK7IrcWUVc/yEaWLTgQRlsvvFiY8hoXSYTA=;
	b=ert1FEJNDVfKNmOLA1p3eptt/ilCx7modcfI+9Y57m+kTwHC/urfLfZQ9kqVXZlnHgSP
	 HcIXY/BJcYRzKbGQQwflzE3XHFx5JYfCLo2hQ50gQ7IqW+uNy8VK/aaekK6jjXl1/WE10
	 dVlrTNEDQMGAMh3Mz8dru6MRvAtt6hk9FbCttaZXHr8rqCzbysc8Wsf+rPnfzCL83j1hx
	 muBWjtRQ1qa6xCVPHrqVu3moDIGVgDP43qnJj8ch8T+3fsb0sPGn50tCu7ASM5p3Km+SD
	 rox7fKqf8WRZgdqxGxCPdk6Lo2DV9p2nqo08iwRcXKuWh8brvZ7Xcrqde5TePK12XAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=scIcMFgs;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21983606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21983606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=scIcMFgs
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5366ae57896so19099031cf.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792866487; x=1793471287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZGm2VHNwK7IrcWUVc/yEaWLTgQRlsvvFiY8hoXSYTA=;
        b=scIcMFgsc+uJLHXtfb4EryYJUQ0LWywirVYNvgIkXvoxkzFgXwEjiUddcF0ZjeBq/i
         ZtsgduTxgNZI4HxAnjkv4FNBKHhx5a6VjAhcNurUtXAAuRDQ7mtLQaDLNWQ1T55KUvb7
         Q4bqTItwdu52r4vx7R49J2MHxtThw+DXD35/mRnSksqQkZOJyQs2rHkBpna82bX9nS03
         DMod6/5rRRHUKYzQR3/1Qx2VG6CEAI7wouJX7OvnA5c1M3ptLhrbr7fnMr881IO5tWG2
         9k5z2i6lPJD3qFpLjvn75ZDUpOyM5TQs4D8oM5mmg61cEsoXicjzH/r6CQP/9ITapnQm
         KNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866487; x=1793471287;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZGm2VHNwK7IrcWUVc/yEaWLTgQRlsvvFiY8hoXSYTA=;
        b=D7fPLl62tztGbaQS7ZdDlle3ekSf18f92llSiMtYw9D2l+3CkO+lSdqN+j3NZcSplF
         w0WSEJV3hdsO27vELveiIaYps90Zjm8Fbk4QEhJwgR+PUQQyg0trhhatzOLl17xl50mF
         7TWbDiV0tVxF/YpfPFZzfcst7FpxZOCTlG8Higr0+tHux68XmMuvbjl9zNpN3DPI/6fi
         VqhVREsSFc4EJHxNRXR6f7GWVW4cwhKlbr7wZxuvO7xIcKLFo3/kF0De9QPzQUPGlP6N
         P/WJzwueAn9kTbUMOb2jrDaLay/Jk4azcinHwBhmI3CbBd3XATASX+hSmbJRZmAavKhS
         TLwg==
X-Forwarded-Encrypted: i=1; AKwUvBz7s/LgQiyyxTVZ0Tyo1GEU/uz2zeFjzCVC6/pnKmtY8vTrQIDGL/mEILLnmnT24npcVuw7EN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMTM0uvSD/2VMhw83k2N4j9zGQUSYt05jTcAAS6rdbiKTBzEVb
	7U+erVSgpJpeU6u1QsMHD01FUV7e/ncoJPThlHoBfR/7rYuholc+aG3IxbOCxVPTEQ==
X-Gm-Gg: AYBFou2CNv4Gs0UInBqSFPdZMmMPZ4rJM5Ve3USAGEtnL0e9nR4SsCYGid9rrz5CZuS
	tXlrKT00tUGISi+PK3uhJDncWV+r7ychScRC/bXXcjwsqpQpxfFxVyhgOEo2nQAINdcYO5TApYS
	ozcob97/nmx4oXjl0dRkwz4A+rGoRuUrqYh/X3GMbcLP3fCwiBHPqbE6FQsNKaQ5wJeNZfqYCCL
	Ajza920XxM+bTV2gS5Jwi+O86nzRWN1zexA4VgyMWU4+5zpvwE8ZPdr+0wNdv9OQ3WSnOVSoJqW
	96gNTGB/7mt2ikbSEMEreq7cQ66knK5wnkOsda5uciNdO8nbwdBe0xmfMTVUplpVbpah1DrP2MA
	PE9u0ub6kcBdbNPUQChn9+9F5Lil9w526HGI7sgZ3tWlMpYf1MfFPob/pXAwFEPV+vo/AgClTYO
	+qDFZnSPb3GDaQvdJh4gYSISGjfu2xSCS7W+g37llF4TPbF8ndTimVF9Mh4o7v7N8hBfcU760eH
	CBCd2mPbvebAXbS9K3pnO+IDAuxlR8I2pehlGWkve1bCO53TXIeXB2j
X-Received: by 2002:a05:622a:410e:b0:536:566e:6b52 with SMTP id d75a77b69052e-5383b5ebe08mr38603831cf.27.1792866486889;
        Sat, 24 Oct 2026 11:28:06 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd0865sm26558646d6.14.2026.10.24.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:28:06 -0700 (PDT)
Date: Sat, 24 Oct 2026 14:28:04 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Igor Putko <igorpetindev@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <c1f1a281-de3f-4966-b4a8-e9fd0b5268c2@rowland.harvard.edu>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
 <20261024155614.2732-1-igorpetindev@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024155614.2732-1-igorpetindev@gmail.com>

On Sat, Oct 24, 2026 at 06:56:14PM +0300, Igor Putko wrote:
> When an HCD is stopped/removed (either during module unload, driver
> unbind, or an error path in probe), pending URBs are unlinked and
> completed. However, for root hubs or HCDs with giveback done in BH
> context, the work function usb_giveback_urb_bh() may still be executing
> on another CPU after __usb_hcd_giveback_urb() drops the URB use_count
> and wakes up waiters in usb_kill_urb().
> 
> Since the caller may immediately free the struct usb_hcd via usb_put_hcd()
> after usb_stop_hcd() or usb_remove_hcd(), the running worker accesses
> the embedded giveback_urb_bh structure in its epilogue (e.g. clearing
> completing_ep or clearing the running flag) after the memory has been
> freed, triggering a slab-use-after-free write detected by KASAN.
> 
> Ensure all giveback work has fully completed in usb_stop_hcd() by calling
> flush_work() on both high and low priority BHs before deallocating.
> Also remove the misleading comment in usb_remove_hcd() claiming
> flush_work() is unneeded, and document the queue emptiness in the
> usb_stop_hcd() kerneldoc.
> 
> Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH workqueue")
> Reported-by: syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspotmail.com/bug?extid=a5b220cacb0618384d5a
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Igor Putko <igorpetindev@gmail.com>
> ---
> v2 -> v3:
> - Remove obsolete comment in usb_remove_hcd() regarding flush_work().
> - Add comment in usb_stop_hcd() explaining why flush_work() is needed.
> - Update kerneldoc for usb_stop_hcd() to state giveback queues are empty.
> v1 -> v2:
> - Use flush_work() instead of cancel_work_sync() as suggested by Alan Stern.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/core/hcd.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 8e8a5f59b319..f403795b17ba 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2773,6 +2773,8 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
>   * usb_stop_hcd - Halt the HCD
>   * @hcd: the usb_hcd that has to be halted
>   *
> + * The two giveback queues should be entirely empty when this runs.
> + *
>   * Stop the root-hub polling timer and invoke the HCD's ->stop callback.
>   */
>  static void usb_stop_hcd(struct usb_hcd *hcd)
> @@ -2787,6 +2789,13 @@ static void usb_stop_hcd(struct usb_hcd *hcd)
>  	/* In case the HCD restarted the timer, stop it again. */
>  	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
>  	timer_delete_sync(&hcd->rh_timer);
> +
> +	/*
> +	 * Even though all URBs have been given back, the work routine itself
> +	 * may still be finishing up and accessing the usb_hcd structure.
> +	 */
> +	flush_work(&hcd->high_prio_bh.bh);
> +	flush_work(&hcd->low_prio_bh.bh);
>  }
>  
>  /**
> @@ -3059,16 +3068,6 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>  		usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
>  	mutex_unlock(&usb_bus_idr_lock);
>  
> -	/*
> -	 * flush_work() isn't needed here because:
> -	 * - driver's disconnect() called from usb_disconnect() should
> -	 *   make sure its URBs are completed during the disconnect()
> -	 *   callback
> -	 *
> -	 * - it is too late to run complete() here since driver may have
> -	 *   been removed already now
> -	 */
> -
>  	/* Prevent any more root-hub status calls from the timer.
>  	 * The HCD might still restart the timer (if a port status change
>  	 * interrupt occurs), but usb_hcd_poll_rh_status() won't invoke
> -- 
> 2.47.3
> 
