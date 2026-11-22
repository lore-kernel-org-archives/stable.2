Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341062;
	b=tFyG7b40Sw7pstaZKF9B7s31y9+ZCf5Z2f/fnReyFqoSMW40pqA14+T+cEXWtprAiily
	 yvmGv8Ejcmn5M3slrH+4wswEM1YT6Z3LGrm2IXc+BervNN/ZZTn7bV+IKL5M3B+IKVGii
	 kAEmy0xs6LFzOxGAs7Dh962FuJ0OHmiX42Jt7ePbiE5kgeZQWCUOjgKY+VPZFW8WF/s/X
	 Ybaxin0gesyCanzMAQK1S2g8gpsZ/BxGgFKd8Mazd5yPZ0ZpPHUELS1vUin8s3UC2hCSB
	 pViGkYaGMGn3kljHHLrMnbECMfJXIgp8iXKTqGxFLRtbAJmCVN0/hEyp6bRkB30k3og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=C/QI1b4vyHy9NWvjW7A46WXm9Va+yX7XVlOagVghD9E=;
	b=5sHRBpVmb9WldHO2ST6TPsZ7SELw01/+UgVCUTpGLMOJq3cCUdQuCHeyN6BhvOh58JRG
	 fgZuEviZgg5nDuAtIAgHwk3Zagt7z8mVK57qCTii2fXnYb95LdIFuRBfEW1t71iIr5E5a
	 gkjpPEcNA0SgLprhNaK7MMo9PvArdzkN1SVlFJYW7FDKau7TiOwuruCLQb/6GAv2HCE1+
	 CO6BTWI2G37Y9H55Kd0ZkU3qG4bETW+I4wCwI18UrbcWRncrpc1GEYREe9Uh+2JQQdxdY
	 bGQz49pcFehuVKapVOHxvVjH8MXU3O8eq39tDoFxOqTTgR73gIvnD/D8ee9PXMDc0Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4mHGkdM;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347E606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2347E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4mHGkdM
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so20545675e9.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795341060; x=1795945860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/QI1b4vyHy9NWvjW7A46WXm9Va+yX7XVlOagVghD9E=;
        b=C4mHGkdM4E2iWACQdBEJRZrhywFUbEG5XgkzEXbPOc/EPsXt9DyUwaaA4ndxn5lndr
         qanHAuBkJjRyD1bY2WQH/WCbYveCu3obaaJ9evHDtrM7RSYLuJ47jteycziXvjaHJi1m
         s4pQuXS1cwzM8pC5/pcMg33U7iKYf60baafFbb6Y2A30XgUHX1IAkm54G1JU4utSpnPn
         MfRnQmUukKjo1IA5+3jiI7J89J1CtWpApmsCleLS1X2E0b7Wiu9kI7sMfQKtx6DH4OAb
         bBOs81043/e8PmjN4j6JsLk9vXgEC5D+m/PdGK5tHrzmI7s0Fo1AK2r7R4JAGwUuFF6B
         olOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341060; x=1795945860;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/QI1b4vyHy9NWvjW7A46WXm9Va+yX7XVlOagVghD9E=;
        b=Y+hDoHIk8ktM227gf3rRKAnVjsPyZR/PacpSDwGfxJe+FNN25k7u6/AYDnhiq6ZMCM
         nH2g4d/miFLFIUFFbi9y+ACXZTOMOdnxGbJRC2Eb9y0AvxZOnxSe0dQVOalWC9UicQV/
         oM1lGS0pUzphau/cjIabY60upOovLB2QgtrIMnSfWuB6V8lvcVquWF8WqBrRaMGa3oce
         Iqx+4SljckGFp8eV0B3xXI9qckmzHjRsebrzODmafdhYszHlruwZRKrS1+ipZXuNwi8P
         fMd61wxdoxGZwdKb9jpmd1PC7Vqgw5qLRf8YCboNizZCIIRvXr7mLaSCV5NLh3HaqM/8
         PFqg==
X-Gm-Message-State: APuU4Z9g0lNWUlLyYTql9KVYa4/DMnYtSFmeZVoMULeZgTr0aBmnBZ0S
	fNVoKlXpELq5RARnvJ6mYkCNuWQ7gx2HjjxHowqBg1VYUCY7iePieY538sHLLKQyuFw=
X-Gm-Gg: AZFdTZd05hUUVDS8di+jelgRWeG5CV/D6f5pyei6OIfFIX+QNxsTnvRopu5PpBp2sI1
	Fn94zwLEnJV7O0ml1pfFGnyiR0H3KhiDBH7zzgAh5AsInma3rVT61TSIoE7iKQ5mqcPnOvfdJ0K
	pHJyyWFvZq9EUm0t7/7lnVeUMbAoWeDmSrsH/ygWgXSXwand2TJm9O/pGxZlWtwtmhVbl0NYogT
	qtf6LqfrbNhkRzBY6dANVNuhshuGLdMl8HSDk40E8bylObGUZ3JConnJVqNcrTbfxGWP2Y2s2ZY
	DdkTcP94U4n4vVhREe/zUSSxttlUr80WzKaiPeEBM5Rv1VlXZI8CLHnVUq9gnAxA0ERkhjVv1+d
	ZANUp4G5E5anwe66Qma+N8yZLVdF8d/+tllzu4zls0sgWEJKV7Wmn/fwm2T0RIkFM+yLWiAbC58
	Gx59meIouwAXVHZ4el1u4Ueqy0KESsLOvzdV6/nzTLhJ4ppXarewdEYSV/n7EHkfrGGNphD9/0p
	HEX+fqjgFlE/sFS2+BBdScII2LxjVfqdH8g5gkA/PqJXB6Rd97nFd7xnMkEkg5A671YO9tIbOmL
	Ox5T4jcI6uOn11ozMt3UlTvt76YF7XNW9OCgrxMcb2w+G+raDgObOJNfhp1RmRe7fAFSdI6YOin
	X4mGBMvIjWuK/miubL2Uo2A==
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb88824a5bmr179848445e9.13.1795341060240;
        Sun, 22 Nov 2026 01:51:00 -0800 (PST)
Received: from [10.138.96.21] (62-101-160-142.telecomgroupservice.com. [62.101.160.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm218208355e9.8.2026.11.22.01.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 01:50:59 -0800 (PST)
Message-ID: <5205f6b8-66a7-4869-bc94-1c8831b1ec24@gmail.com>
Date: Sun, 22 Nov 2026 12:50:56 +0300
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
Subject: Re: [PATCH] can: mcba_usb: Fix double free of RX buffers in
 mcba_urb_unlink()
To: Alexandre Becholey <alex@becholey.ch>,
 Yasushi SHOJI <yashi@spacecubics.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: stable@vger.kernel.org, linux-can@vger.kernel.org
References: <20261119085329.539894-1-alex@becholey.ch>
Content-Language: en-US
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20261119085329.539894-1-alex@becholey.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandre,

Alexandre Becholey <alex@becholey.ch> says:
> mcba_urb_unlink() frees the RX buffers but leaves the stale pointers in
> priv->rxbuf[]. It runs from both mcba_usb_close() and
> mcba_usb_disconnect(), so once the interface has been up, the buffers
> are freed twice: on unplug after "ip link set can0 down", on unplug
> while can0 is up, or on a second up/down cycle. No special device
> behaviour is needed; on a host controller without DMA the double
> usb_free_coherent() is a double kfree().
> 

Sounds reasonable.

I wonder, tho, did you test on real HW or used emulated one via usb gadgets?

What caught my eye is that mcba_usb_open() never reallocates URBs closed 
in mcba_usb_close(). So I'd expect device to not work properly after 
second "ip link set can0 up".

Maybe it shouldn't close them at the first place?

 > Clear each rxbuf[] pointer after freeing it, which makes the 
function> safe to call twice again, as it was before commit 91c02557174b 
("can:
> mcba_usb: fix memory leak in mcba_usb").
> 
> The bug was found, and the reproducer and this fix were written, by AI
> agents (Claude Mythos and Claude Opus models). The analysis and the
> patch were reviewed by a human.
> 
> Fixes: 91c02557174b ("can: mcba_usb: fix memory leak in mcba_usb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Becholey <alex@becholey.ch>
> ---
> An emulated adapter on dummy_hcd: "ip link set can0 up/down", then
> unplug, gives a KASAN double-free in hcd_buffer_free() on v7.3.1 and
> master 9d66f26fefac; the two other sequences as well. All clean with
> the fix, and a second "ip link set up" still works.
> Reproducer available on request.
> 
>   drivers/net/can/usb/mcba_usb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> index 04170326dc7e..b40b323da9d3 100644
> --- a/drivers/net/can/usb/mcba_usb.c
> +++ b/drivers/net/can/usb/mcba_usb.c
> @@ -718,9 +718,11 @@ static void mcba_urb_unlink(struct mcba_priv *priv)
>   
>   	usb_kill_anchored_urbs(&priv->rx_submitted);
>   
> -	for (i = 0; i < MCBA_MAX_RX_URBS; ++i)
> +	for (i = 0; i < MCBA_MAX_RX_URBS; ++i) {
>   		usb_free_coherent(priv->udev, MCBA_USB_RX_BUFF_SIZE,
>   				  priv->rxbuf[i], priv->rxbuf_dma[i]);
> +		priv->rxbuf[i] = NULL;
> +	}
>   
>   	usb_kill_anchored_urbs(&priv->tx_submitted);
>   }


With regards,
Pavel Skripkin
