Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879608;
	b=T7EnnrtCQpMgBNBo6N4aFh6gu2SHwNAqxvA7N15Z9oyhNqrFTQLGj45teK70NX50TAf1
	 SR+BJa4QZxcItKWKYHQ3305rxL9k4ZQW9DuMkhic0bm/pg6vYOHoAArVTVpK3QtySbvrx
	 4bEhZoJ4VI/vFNLggnK+ZEfYjHMTFz4pXcwCRC/pWjONAe4ma7p/4QX9BLkM2hF24xuc2
	 uz450TezzoUtI+leBKjMGOQ9ZvJwvcOIS09KItY+RbpjZEUfrWdk9T96fa5C42dblCxHD
	 hcyTQeG3FoZZFt+TgafBVe+6Sl+eynG7p0t0a1WXOEwYxYRSHlswBrMD2wQ1LT051xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HxeQRAzqUAVtmjjD5cM+lfc+nv6xOYi7h4CqR5Xxty4=;
	b=neABLmYyPmB0JbLcOrRkXX5BvojOa3G57agiKCPAAUeAHkU298YFbNptrKnNVN97KHah
	 /3WrL/uJAl0KJqK9EFHFq+aBhw3bigaXMFCQJNK5Tg9b6D/W0NunU8RQigTfZcRT2j/qk
	 ZOLVWnVpSOTzTYg+yeB2hV6Van2q6XLx+PQUl6FB10N42mszz2xMEKyVSvyMED1j7O5z4
	 N6rEtPOELr/nq549R8tTN2YJzuW6wBxvl2yXIJ4eB8zSxoZDLUiL2WESK3BS7wLEHZRDo
	 F9YwaBXfSbOxDmWIgHhBCLMkbwkt6OpmwtGHnMl3WtW64t9bKsXZAAaJr4D4hrssKWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z+Ennp60;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDF606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 22:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DDF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z+Ennp60
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so17971175e9.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879607; x=1793484407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HxeQRAzqUAVtmjjD5cM+lfc+nv6xOYi7h4CqR5Xxty4=;
        b=Z+Ennp60zU5xjSD/H6r9yrndkA9jr5apGRTkqmpoOq0yZ7TQqQlYL+U2Lmzo9xQ7sc
         0nd6KgEou+zir8J/tRqBuJQWv/BbiAy2tq6mBXySukRsiAqV8NLpTHwq4kBNFGAmcr4L
         //p0uSQYaDIdfMp7g8RqtkXBJU4Klktt9NsWi3ACZUeaRuIESS4unXuQwHvvY7wtVK9Y
         3rIZs9av2N42gHP5UntG/ZWh639NBLP434WI5If0fISDH8MhDFNaoiC8fkZrGsnG5yC3
         CkRRAMS9rZVJxzKHX/3GCvcrxvclHhBOlNCap3QMkU0LKu45KEeVucx5GbYLJvdQar2f
         l83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879607; x=1793484407;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxeQRAzqUAVtmjjD5cM+lfc+nv6xOYi7h4CqR5Xxty4=;
        b=XKYTm/ysQQ9ecBq20tTFHatl+B8dR1vQysrYlQDAjzMPe5Tc3Z5gsUmL8o/xTlt9OH
         +19R4MXpMRvfBGniGdV43m5IkThlW6HBWBQuaBAwsDzyqS2d3d9csMK+lYDklFEVmSj1
         KHUJOJh79N2l2wdPTcIy7+Qe5v4cA0BhqzgfoD1Lrr4duKm6nfrO5+95y4dXDNsGJetY
         cP4BNVVaz5n1EFTMkcM9R8qtZ1yEX6s+Ul1n34DHnmffHiBaAE6TEwx6ximZW3hIu0Oy
         NYJsKzN8eEzyVKzkLeynIgX/AIjhwjTdRdCXoixSMTVasAh2YbS9bo8c3mcIKI5O4+Ho
         RMxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxT1rhV6A6A49sEUMGpgiQFETWsL1f7aYnvlz0ZXm+65rV/OGQhPpqnFFHWGcOE+yDljNFDW4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgrr7wijS6WaO2jD832u7Hl5cWyqcp7wmrwXXcfwX4Ot2TfFp7
	5Dy9C+69AqV/kJVDnfkAaT2A3OrkkFAzrkGVAa95yp915rNpm8Ap46oI
X-Gm-Gg: AYBFou215ud8afrrE5si/s+8C3QGmICP9j491QPwQ43GJ7dxVfeJlwVgccFpO4YO8xW
	978rSrAgHjtGf2+L7xcwUffWBrPmxZNs7lSogB5U9niOWO+2bYGzCJgyfwqVBxfje+qHiBaxy/+
	PgmKkDiH6FzoSXAsAPYySKs7cTOXA6+HJ3v3kZgeEU5YVQi2pIw8Dv1w0TgKJwJsCvTLf2IsLqx
	Bko+Pj1SaUfHyI7a25iL7bDoPwKx6S6vDKgKQNtvd+uzigzA6ffKlVBsx4GBrdaDAO9zLLDTRoG
	oa8GcMdeWlDayXpooNsYsv2RtoD4pSKG+20OoE1DRdNktweuEA0EjCb7KpNeMZS+dv7lrSGb6bb
	hP2GAbv1Yqye5tKDWxa1uTLZRZ/TDrvPKXNKSvuZs2SwRnctndctZ1XXkr6z8p3NFpapJItNADh
	ZhOCvqtLPgDObyEqYOg66wgnerTmoGb5cJBx7IXoDXeeIpcqndFrOmv6gCfT88gEd2kSiXvhic2
	47jBUTgE5wg49fPD8TLWWPj7szvs5IsZGG2DP28GGD0MhDJnFGsk81+89nLlj2x
X-Received: by 2002:a05:600c:83c7:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4a35aca5824mr44913385e9.21.1792879606729;
        Sat, 24 Oct 2026 15:06:46 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm217549655e9.1.2026.10.24.15.06.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Oct 2026 15:06:46 -0700 (PDT)
Date: Sun, 25 Oct 2026 00:06:43 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Igor Putko <igorpetindev@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern
 <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>, Oliver Neukum
 <oneukum@suse.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <20261025000643.425c57ca.michal.pecio@gmail.com>
In-Reply-To: <20261024155614.2732-1-igorpetindev@gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Dupe?

https://lore.kernel.org/linux-usb/20260823125831.6ea35650.michal.pecio@gmail.com/

On Sat, 24 Oct 2026 18:56:14 +0300, Igor Putko wrote:
> When an HCD is stopped/removed (either during module unload, driver
> unbind, or an error path in probe), pending URBs are unlinked and
> completed. However, for root hubs or HCDs with giveback done in BH
> context, the work function usb_giveback_urb_bh() may still be
> executing on another CPU after __usb_hcd_giveback_urb() drops the URB
> use_count and wakes up waiters in usb_kill_urb().
>
> Since the caller may immediately free the struct usb_hcd via
> usb_put_hcd() after usb_stop_hcd() or usb_remove_hcd()

Is usb_stop_hcd() relevant here?

I placed this in usb_remove_hcd() where other works are cancelled.
This seems good enough, because no URBs (or wakeups or dead) should
exist until usb_add_hcd() completes successfully, at which point
I suppose usb_remove_hcd() must be used, not merely usb_stop_hcd().

> the running worker accesses the embedded giveback_urb_bh structure
> in its epilogue (e.g. clearing completing_ep or clearing the running
> flag) after the memory has been freed, triggering a
> slab-use-after-free write detected by KASAN.
> 
> Ensure all giveback work has fully completed in usb_stop_hcd() by
> calling flush_work() on both high and low priority BHs before
> deallocating. Also remove the misleading comment in usb_remove_hcd()
> claiming flush_work() is unneeded, and document the queue emptiness
> in the usb_stop_hcd() kerneldoc.
> 
> Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH
> workqueue") Reported-by:
> syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com Closes:
> https://syzkaller.appspotmail.com/bug?extid=a5b220cacb0618384d5a

No such domain?

Looks like you trusted an LLM ;)

> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Igor Putko <igorpetindev@gmail.com>
> ---
> v2 -> v3:
> - Remove obsolete comment in usb_remove_hcd() regarding flush_work().
> - Add comment in usb_stop_hcd() explaining why flush_work() is needed.
> - Update kerneldoc for usb_stop_hcd() to state giveback queues are empty.
> v1 -> v2:
> - Use flush_work() instead of cancel_work_sync() as suggested by Alan Stern.

But why?

Cancel costs nothing and turns potential UAF into a leak, sounds like
a win to me. I did the same thing deliberately for this exact reason.

This review bot is completely hopeless in out-of-spec and bug-vs-bug
tradeoff scenarios.

> 
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

No disagreement,

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
> +	 * Even though all URBs have been given back,

but does anyone actually believe this here?

Hundreds of drivers written over three decades, often
without linux-usb review. I don't trust them at all.

Regards,
Michal

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
