Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A33161A1;
	Wed, 14 Oct 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970335; cv=none; b=BrFCv6eB50PLOfdb6r9A4rwQf7kc0UMjIB2f/BgAVR/EIiFWUCL6wI4kzzzSdYpd/rGglyJOoQ51b9ybhlMkCQdfefK2mfddaP9KEJXuKrQWyGezdsY1RZcCbRSI3rdF5aNn/EYhTXatQbU308vr6xQaaHhk3TymbCaOMubLPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970335; c=relaxed/simple;
	bh=pQZS8sixfnxW/xgZ/NThWJhEgVuWc07d1+NYjfRnn0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlfncSlSDt/nggPv9ZD31Ah8HPBDL3Vjym0tdZ+VrwkeyGcBpuZuBJk+CQxHw0AvC59zL26X59oeW4AHH/Gdc2l+iiPqGGLgqgIsAKR+zVdI/eyh1Sb2nh3AaZNU7+RnRjM+QXaEUr3fu5O72eyobLAGfBGUmgoWyfRF3ldqXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqCNKzQA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZihTNtwF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqCNKzQA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZihTNtwF"
Date: Wed, 14 Oct 2026 11:32:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791970332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkeUl+VzxzT+DO0p6+vHrEGJtJq4KbQpmS3VwXfHTdw=;
	b=OqCNKzQAWMvJeNNULaq7x0jAcxkLv6bx073o9Jh+hl8JcIVPflBJbxgdOvVsSU2IU75uBq
	6mcQ38CnYn1ON7ZA1IxmDBt5EeMl1fSta1AgEe18L4/jyaZpMZYm4zZF2lInA/tWf/utmS
	B3n4zwBtnXrUIi9IrGKSo9yoQsj26azJrimggsqi8owXm2lzLr8nnXc8e+sq6l7j/DsjN4
	YbC7i3cx3+QmCtp9TpyqTEy4UHVxZBdc6eTZqodl78lkrYLJothmVHXShfHtuZl12o1otL
	uhdBfI9eZk7NqVeIdlCcroZ+v7DVmE0vbxgi0XUCkn61W45+uiT6nCobHxYALA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791970332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkeUl+VzxzT+DO0p6+vHrEGJtJq4KbQpmS3VwXfHTdw=;
	b=ZihTNtwFJJdagTDMI+SVex5ythzRyICbOGf6cz08YyfmIBPUXf4nd0hZ1f15IY4XyQBR22
	OW/MLFNDkbImAfAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: pwm-ir-tx: Correct timer calculation
Message-ID: <20261014112806-018f69f0-f85a-4589-b80c-76936adfd5bf@linutronix.de>
References: <20261014-media-rc-pwm-ir-tx-v1-1-1ae862427fd2@raspberrypi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014-media-rc-pwm-ir-tx-v1-1-1ae862427fd2@raspberrypi.com>

On Wed, Oct 14, 2026 at 10:19:54AM +0100, Dave Stevenson wrote:
> Commit 44d7fb8acdf8 ("media: pwm-ir-tx: Avoid direct access to
> hrtimer clockbase") converted a loop conditional from
>                now = timer->base->get_time();
>        } while (hrtimer_get_expires_tv64(timer) < now);
> to
>        while (hrtimer_expires_remaining(timer) > 0);
> 
> hrtimer_expires_remaining returns (expires - now), so the
> change has inverted the condition.
> 
> Convert back to follow the original pattern, but using the
> proper API call.
> 
> Fixes: 44d7fb8acdf8 ("media: pwm-ir-tx: Avoid direct access to hrtimer clockbase")
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Thanks!

Cc: stable@vger.kernel.org
Closes: https://github.com/raspberrypi/linux/issues/7678
Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

For the Cc stable see:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

> ---
> Reported via https://github.com/raspberrypi/linux/issues/7678
> ---
>  drivers/media/rc/pwm-ir-tx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index 047472dc9244..bffdda489950 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -138,7 +138,7 @@ static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
>  		hrtimer_add_expires_ns(timer, ns);
>  
>  		pwm_ir->txbuf_index++;
> -	} while (hrtimer_expires_remaining(timer) > 0);
> +	} while (hrtimer_get_expires(timer) < hrtimer_cb_get_time(timer));
>  
>  	return HRTIMER_RESTART;
>  }
> 
> ---
> base-commit: d7e7bca7169873b46e857c025c10f3336c1258d8
> change-id: 20261013-media-rc-pwm-ir-tx-971c2ae8cf53
> 
> Best regards,
> -- 
> Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
