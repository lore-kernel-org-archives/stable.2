Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638826;
	b=nzcp+Cgy72Bsgh0wWiFH3hOviAajae3jKvMUpIZ8SVynGmQ6dM+TknWLaQ7a7pvfBduj
	 N7ONUF2U329APU7ZysUpNmoYOTudKLm4IVCam2infiUQYYD2cxh5pnSF5cXZXd6N0pn+H
	 UkXKSZmZjXW5lHgKCIt8dzqzbwQzCXCC/0BeNOQmEi0MnPF3vdvEFtbfV22yZH1YoupwP
	 Xd7IOFScTf+0KcfPO+COqFjfLjQOJvoO+WebwTTK0EBAJr9eq4Jbtd+kGr7CsqMBnGXDd
	 jqojhalY3lEeFiB/rBZcZqeQSQpIh2QEwPEEV52vjcts0Gr1/KRnUFsbIYA25xrzAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FtWaiLD+f8JJX5hI+Nls/16AS+lNKkNzrClo+6vywTo=;
	b=df5hmGpZ51be3dCM83R0xKLIALbwkCXmtjI7GO8jn4k2YqXu0oxjC24SyQ+GYjyV6rDM
	 Hrr3JcfvAz8+l48HQnoP4XNcGpx1tGprX9KGw+xNQqRfagYyuu61C1KeNB5PkwiVUY32b
	 PmqRFm4sh9zcO0R4Lh7kl9SNHCNnac7iUsSlZUEC/9+eDGjw1vp/D06kJqcUzGSjX9khd
	 OAYBVatEEjURy4Asw4bdnttPOlLkAk+dtF9CCYZpib/wmqzeDgPd6ajbJyY6ZjTacWt00
	 zCXTRK6hLZNssWPORLnVbcwsROjAEyZV8TdqoBsCABhBIyMQK60lRpbFr8aRBFKXECw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=W3fXLbuU;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203E606A592
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2203E606A592
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=W3fXLbuU
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6deb848ddd7so2496014eaf.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793638824; x=1794243624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FtWaiLD+f8JJX5hI+Nls/16AS+lNKkNzrClo+6vywTo=;
        b=W3fXLbuUCj41YRNXQ8QSL17+xIIok+s+9VAejKVy635IEGLImlDbDTcrQGhM9/0At9
         +q7LFoYt3a5s+v2cFDpAqeOeI4QJx010QfD/csw7hC4mINmPzM1oQ82HEnZngerVxdi8
         cg/7V84BX4JX9Y7CZxE+WFY+WLqLVB56oHs2Cw5spRrvwHmuMXL/l5d4UMaHxvFWSWaV
         I3isPMxMcr3O3YjBOSoFYXdwqZ5oa/bMqYNSJ1rpZWZHV1rThvr+rr9oYA8Ux34CBufD
         KGQDQPAAZyNdXYa1Fd2k+f/Z5Fzil+ZZXu/D1lTLvn9qJTxtbh9xy6ZEEX7eppCiM973
         dQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638824; x=1794243624;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FtWaiLD+f8JJX5hI+Nls/16AS+lNKkNzrClo+6vywTo=;
        b=JxwErMTTDtlFg0sC7GXmvXdJ+vH0idiaojnoqIqerYL585TBuXs8jq/r/wvQqiohin
         ZbJqxXZymKp830LDBRK3DbvXCn8pOcMwK9M5FR7bQVZ2Ye42ZrTV5BSStO6Xhzxl+7ob
         hMg32Z/zejXJrvzx8abfy3ctAPaFPpI2BmihRLU1dUqYt4lcbT+ZoimK2k+jCLcOKVRl
         U/ypS/Saf0RVDGv77E48Dtca4xogHJ9iltwPOfMzDDTbbDZ9JghhJ/HnjxVDpkOPXd3x
         x7ZArXeml3VZ8czZw8oN/E/chL8ZnprjD+6xHs3oVBBhXnkNVvWfzBGm+a9ifWUzetdV
         7uoA==
X-Forwarded-Encrypted: i=1; AKwUvBxEidNFfTISmdR6CafYBcOXBL4TKB1rOA2UkUDEopc9xI9lHZel+Ndn11v94JHfFn/TSYGlmAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNEcWzfNMtFzW3CAmslkqMLXXRWJu0l7XlODKNAuRAXLtoFDcb
	fhI+6Ed8HFJkuqCMkgxHNXfbnUXKxzaCbwAzIYr9BlBH4BozbSRh5lml8oWP5FoLp0bH83PdUag
	1+OyprNk=
X-Gm-Gg: AYBFou0nEqP+k95OKzZE0DYoMEc7s7XkhlxHaahw+odUC+z7ziyPlVhsTHIJIyAkDH0
	hke/i5E75ncZjcqFV7lkCaFDOKfcn28dNI73jaPsf402Dys7KcUP0o7nb3Re0WehOsyOOCBhPGx
	RTQrpn1yiJn+fPt1rUs4XEkDVZ9jNzdZ2hsqT7CgMR1tQvNh6cM1HH37BsMmNPwn6K/pXU8AkdN
	6h5Bg3lWfsxEh2vFh3LGg9CVFOrNgReEQaGlOxJQMF1S6or36THaT/8wftsv47cQvyVCkFcwNSg
	lU/4Buh+a4SmEVNfH/uVtDzfzLqo/OcgkCmcCTiVDRen0TWZFEkAiUb6tVu4kVMTO3fk16pSxSr
	mzm1zkzRJ7WAd0Lwfk5pmXrnAaPai56ZRLGbOWUbXHDiVeoCA40nq3+Y8BrzCuS8XQiF6KM2ZJk
	nOK6ahr2acyDrcTwhawMp+gTL/tJRg9o3n7OKWsFMUqAHbCIPydSVfbYyxs72nJzJXjlDfHAJzx
	D66st3PWI+1NlTnnyYICh7LpwReXv4EYLEOnOEvHL9zGor+fgR/SuPLIfN2sjtmqGvhqUHtC0OU
	z3e/ratWY85gBY7wEg1brgoON3zVmWhj6L6T0w45soMzcVM7moAjf4aiC08WXPODcpyNf9H7ySP
	6dw==
X-Received: by 2002:a05:6820:8913:20b0:705:cb2d:e0d7 with SMTP id 006d021491bc7-714f238254fmr3733659eaf.26.1793638823919;
        Mon, 02 Nov 2026 09:00:23 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f? ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545bfebsm9359434a34.4.2026.11.02.09.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:00:21 -0800 (PST)
Message-ID: <6b7e13ee-ca5a-4dd7-92d2-3537369c78e8@baylibre.com>
Date: Mon, 2 Nov 2026 11:00:20 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] spi: unoptimize message when queuing it fails
To: Joseph CT Chan <jctchan@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Conor Dooley <conor.dooley@microchip.com>, linux-spi@vger.kernel.org,
 Joseph CT Chan <josephctchan@google.com>, stable@vger.kernel.org
References: <20261102163023.2574632-1-jctchan@gmail.com>
 <20261102163023.2574632-2-jctchan@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261102163023.2574632-2-jctchan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 10:30 AM, Joseph CT Chan wrote:
> From: Joseph CT Chan <josephctchan@google.com>
> 
> spi_async() and spi_sync() optimize a message before they queue it.
> When queuing then fails, the message is never finalized, but finalizing
> is the only place where the core undoes its own optimization
> (spi_finalize_current_message() calls spi_maybe_unoptimize_message()).
> So the error paths leak the split transfers and the controller's
> optimize state, and leave msg->optimized set. A caller that resends the
> message then optimizes an already optimized message.
> 
> This happens when spi_async() returns -EBUSY because another device
> holds spi_bus_lock() on the controller (for example mmc_spi), when the
> controller's message queue is stopped (-ESHUTDOWN), when the controller
> has no ->transfer() callback (-ENOTSUPP), and when __spi_sync() gets an
> error from a controller's legacy ->transfer() callback.
> 
> Call spi_maybe_unoptimize_message() on these two error paths. It only
> acts on messages the core optimized itself, so messages optimized by
> the peripheral driver and controllers that defer optimization (such as
> spi-mux) are not affected. A queued message is never unoptimized here.
> 
> Tested with KUnit (spi_core_optimize: spi_core_queue_error_test,
> added later in this series) on ARCH=um; builds with W=1 on x86_64.
> Not tested on hardware.
> 
> Assisted-by: Claude, Gemini
> Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
> Fixes: c86a918b1bdb ("spi: don't unoptimize message in spi_async()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph CT Chan <josephctchan@google.com>
> ---
>  drivers/spi/spi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 40cda0037ea5..0d36460e2c87 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4906,6 +4906,10 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
>  
>  	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
>  
> +	/* The message was not queued, so it will not be finalized. */
> +	if (ret)
> +		spi_maybe_unoptimize_message(message);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(spi_async);
> @@ -5009,6 +5013,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
>  	if (status == 0) {
>  		wait_for_completion(&done);
>  		status = message->status;
> +	} else {
> +		/* The message was not queued, so it will not be finalized. */
> +		spi_maybe_unoptimize_message(message);
>  	}
>  	message->complete = NULL;
>  	message->context = NULL;

Reviewed-by: David Lechner <dlechner@baylibre.com>

