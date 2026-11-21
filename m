Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795237718;
	b=l6/e7vPwZCsB8C3ukBhlmiwIxuPXlSdYNeXa5mfOtFW4eI9J9YAuOaX0oeRJYCJKWrOs
	 BAoa1xlJgWvUlYXglAAMWie89E6zvmiTi1KXNwvmGVQ41H3utkEQ+AUYsNQvg/NbSfy31
	 Ms/6x9e6BACptVonVdh3HyEzYYviSE8UdYagPzCJCIgHzIjj8dTOlErUGyiZPMAujH0Wq
	 G1cXVkGOtFO29edJufwFjmB0zTUKyMIv7RNvCD0yJbTUMnpgtId87J6BLh1JAA0EA58xX
	 viO7ElrzQrNEsY36lF0gPeRE65eS7V47eK0AG0Er47wVxfVU6RKoPRSQyPfyAcyoh2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795237718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Bb3283Kau2Gv+8vqVQKXj4fop71Bdd6l4YGCq/10EcE=;
	b=gDXU5+AgR1Ge4TSsyHjWhoYwPTYKR3ZOmFBEOiej2CDvNPOmVk3VdJ2mRv7Uc4oFr2Zu
	 AR26OJeB+x8tjPw0ow4IJ1K5Qs5ibeOtcKhZGI8K2qNojAxc3FKvzXimeuH1cX4K5alrL
	 15Bogy0jK79AhLEYab38BgP7Isza6UaV/NKGD/m2WC0+rXIlY261S2f7Hy71cCyQEBp3u
	 +Gq9OFEy447Rp3QXx+GyxWXpQcWdrnq0GiJ519xC+ppcSWUDp9rvE4ZmLlqegQOzpArgG
	 8QUGL5sBDjV0Ylqf/42+q3gndFZByY6n76cTcGvRrMRmm856Kp9yiDw/73I4I1QMldA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gq8cZIzf;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF8606A695
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 05:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BBF8606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gq8cZIzf
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b413997581so1471675a91.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795237715; x=1795842515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bb3283Kau2Gv+8vqVQKXj4fop71Bdd6l4YGCq/10EcE=;
        b=gq8cZIzf+Qb7sTo4hGDzb7GED1vLLhFGQihjRYcVKITQeqp+NTPJHitWdZnbtmQSnq
         Cc98oclcQyO8R4unTqH3fqB1+SSxBLQYG1ylnURgzL7zhcYgqAVh7zzpYsHzc1nks+9P
         clRRk7K3aTudSZ9DCOuP8L2ACsxJV5M1DCpj6gd+DAk36TUMQHNCuVawsqQ1XJsUK0S2
         gcEM/DvyFWEhc7e9pGD2WRR2om4/CTSbcxVpjaGTFBHeEAETEWKFzYhdQCoAjHj9yHNZ
         nH2/yGWEG0Ih0VbDoXVwdeS6ukJkPg7g92VnhBWXj8E4jFDOSE5IeJOvBMk2uaCi5hiB
         Qhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795237715; x=1795842515;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bb3283Kau2Gv+8vqVQKXj4fop71Bdd6l4YGCq/10EcE=;
        b=ICZmse8aRM8AFV0Ns8hqD4YjDwvMDhlhkj+xC92BlRwKvmvTtnYP/Nn/vCiTG4eKtz
         c4PmqBnXBbYWodacyg+cfcUMQ0JvALu1A1GXvUDHSqzJdpl5xQ83lTMyDRvqOy+7Lgg7
         dHSRAWQfFj3dy42CuIxcr7eRGf6jCU5fARD+asSiq06Cm7RanstdQsNnaomqAyu+SfZ8
         HWx6SGh0tlEa44N4zSWjYs81aYsBFoSYFtWiv4KSoUINUR3FBn4poqyvaP5tmqfqc8Zq
         7IlNtK3xRpjRGyO9h/FFUro/0ME7uBpImcim5kk9zt+0wpczn5L+yf5YPJ6WrCHnFKM+
         s6eQ==
X-Forwarded-Encrypted: i=1; AL+hErFpOKAP1SrBad4bAA2Zq8Gxs+EbXacxkdJPbpnGbDmnlALoglF+dBZUKl47mZnmdZE/+p1zN+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6CdJElMJebzbWZgyCL94mCMe9nT5iALzZnSaZyFZPgMsiJonh
	bhkUVgOIURRZAFVAHqYr4hbHvqsDfq5qtmdCJ+Fx/0etK+QW2jwqXwWr
X-Gm-Gg: AZFdTZf9sz36xo2wnzGOZWarsk2hDvdSrtgpWKP6hgj9IVNablSJ87jb9WX8o7ySs7V
	LTDvgyGiwi3St2C3veO3m/FhjbXTlQY1lj+4u4CLHjI/UUv6vpnpjtIZOfEZaVucH15N2M9Ch1d
	XBTjM4dgUzZeyHfgvrVKmJiw4gKdXmyCFQftdCP0h8/LjpRfDdZwDyZjyMBnj8piLtKQ9uu9L8D
	SRfzrFdCYsAfm5T7zqUJK+S6wBsWWnh5KFjlqJx9rsq1s+45HQhgVhKEr/V2bArzRH9bACK/WNL
	gXIrf+1sPWHCFTsdeP5jS3lsUX+e+4GUfbwYpnp2UT5jEX6ns2w34gq5R9e+kYm01YdyL8fTaJU
	CS5K/zbOwcSTB1EQJgVoGr+EWo0NPQrIKGazpidh6zg82nvoI5321WP19MkQDFCday7cArbGx0V
	zrCP5UbWEUB1z8PepcP8sI516dE85+Y3Kkai7rA2TnLgf6FdhZVFHiI/5AiIxWYUq1scMPhGauM
	U5iL0X2h0M0BDlYG/11m64yj/BsJVfmDZi5T0BPK1umA6CLPICbvNxXhymZmANOi9b5297KiNVG
	KGYYiBZdOrOiWAW5yon6tNOQzh1pmmq84XP5QyPxiInWvtm81UL5p3xtjyAr8eeTqTDKGg==
X-Received: by 2002:a17:90b:39a7:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b41c9638b9mr4472697a91.40.1795237714620;
        Fri, 20 Nov 2026 21:08:34 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm6883300a91.8.2026.11.20.21.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:08:34 -0800 (PST)
Date: Sat, 21 Nov 2026 13:08:18 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v7 8/8] gpiolib: remove the shared GPIO proxies before
 freeing the remaining IRQs
Message-ID: <20261121050818.GC17013@rigel>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
 <20261120-gpiolib-chip-removal-v7-8-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261120-gpiolib-chip-removal-v7-8-aambrozewicz@nvidia.com>

On Fri, Nov 20, 2026 at 10:14:00AM +0200, Adrian Ambrozewicz wrote:
> gpio_shared_proxy_to_irq() returns the parent chip's IRQ, so an edge
> request on a proxy line holds an IRQ of the parent.
> 
> When the parent is removed, gpiochip_remove() frees the IRQs still
> requested on its lines before it removes the proxies in
> gpio_device_teardown_shared(). The release of a proxy line request is
> serialized only with the proxy's own removal notifier, so if
> gpiod_free_irqs() frees the IRQ between the release's irq_has_action()
> check and its free_irq(), free_irq() warns:
> 
>   Trying to free already-free IRQ 22
> 
> Remove the proxies first, so the character device on each proxy frees
> its IRQs before the rest are forcibly freed.
> 
> Reproduced on arm64 QEMU with a shared gpio-sim line and a test delay
> before the release's free_irq(): 3 of 3 runs warned; with this change,
> none.
> 
> Fixes: 1e4f6db614a3 ("gpiolib: support shared GPIOs in core subsystem code")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com?part=7
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
>  drivers/gpio/gpiolib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e0ba17a73c4b..57024a1b042b 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1461,12 +1461,12 @@ void gpiochip_remove(struct gpio_chip *gc)
>  
>  	/*
>  	 * No new interrupts can be requested through the character device now.
> -	 * Have it free the ones it holds before forcibly freeing the rest, and
> -	 * both before the irqchip and its mappings go away.
> +	 * Have it free the ones it holds, also on the shared proxies, before
> +	 * forcibly freeing the rest and removing the irqchip.
>  	 */
>  	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
> -	gpiochip_free_remaining_irqs(gc);
>  	gpio_device_teardown_shared(gdev);
> +	gpiochip_free_remaining_irqs(gc);
>  	gpiochip_irqchip_remove(gc);
>  	acpi_gpiochip_remove(gc);
>  	of_gpiochip_remove(gc);
> -- 
> 2.43.0
> 

Everything it touches was added in patch 7, so it needs a dependency note as
per my other patch comments.

Cheers,
Kent.
