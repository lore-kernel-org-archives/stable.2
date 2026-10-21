Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792587396;
	b=YmWVlzNp1GwoGv6SLTW1t8yteCCNBmCRSfmuSGgk9pKPYwC6r4iOyDY2uVR4iWDM046G
	 5FSiqCllLTlqeiU8PCWgs8L5wqNCwuLBMGelNmBNI1G6EeGV0uFhIV3ZPGJSuYql+HeLL
	 HqPT7og+Zs2R0nK/tZFAq8MaU+z51GMmROgdUghf962sEHo41P/B4JGtos7UJVBzuo1/C
	 lN5fLiaQm7P5j6EvqNKbVw7nfgDPOHP83UumW9TI1D5HeJ8kD+IWrIBMIcoHJYz8Rd9vI
	 jYdWhBPocA6LfHTf5rw1HLU5zHeQiVTmuwHHkxEClsMdcOERX7PSNcp1Bhd9Y4BGY4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=qi1H/TWXxLLxbGzzn39MIG1qXo5ZarlUhDNNloP8fkw=;
	b=MZ4/UdH/09TjLytqixnpvj5SfY3/6WtByHHKyn0u11cvIC0TJDgFuj/TCEKla/PF5n2/
	 t/GAvVVwB0HfAPlnKN8K6i3jAuSLvy/L8UAcY0a3LL3GUK8GSp6sMAhYkGWllEUrzg+rN
	 dBCJg6Pm9zRGkFOjlmYGATbiod9m6ktIbi0rxDtotAOueRta6vBDRrM2Id1PllDy0Sf4L
	 SIk+4erkRl/tBWBmr2K2BN+0d63jPGKxb+mLKhtPJtjZeWljO+Ur6dHItRUYzwJyJbWrC
	 UD4EgsVC2/qSRCiVu6gdR/ktOok5rcB8scjmGSXkhn9ZQbiBJM8+vKIRn1/ebidIrPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eaWpfOtj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004F606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A004F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eaWpfOtj
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15dd124bbe7so1244890c88.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792587395; cv=none;
        d=google.com; s=arc-20260327;
        b=ZoJYg+UQWr0q+iz/We8HYjXe1FIpodLfWmXF89blHfZlFlL88cjQE5g6fhno7q//Sg
         20cgpqnbZrOQFqN5wMUa+XKeREueFOlzoN5beWFFjD4DMWYer+XA7PYdLeDX0KFgGJ/n
         jb/j2IyhXG3ecr+xQQKWTpY7XjiimIjGZVGGGuClkEdkfhtYKdNsAdHb56NOZXza8T/z
         0emnGgXqlhismuCPlxScHwq2rJSpXjKi8c6zuKZnYBL0fAy5VIuwCrTqdPTLKE/RuwsH
         y7GWisjnjweVcRi7NQZ8wLek/oycRFJ9XTMTqSMVEdgvipmiM7v26RktP6LSPUn8Ndhx
         lweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qi1H/TWXxLLxbGzzn39MIG1qXo5ZarlUhDNNloP8fkw=;
        fh=HhwkARkJ0KFwpIMyrtePqsyqPxYYm83IQhSv5jxZRAs=;
        b=qIO4c3G+5xTp8yhkjFFK/EYX/kKd5Tu5rQ4AHAVqpQai8rQd5Xz2ru2x/rKJuZAfkN
         2QJgdrJpRVt6IRFONecwmLsa61LswvIvrHKT3r569V5oLaQcKnQep5qBd5UETW0TduKa
         RN61E41gA9rGEj3MkfRDese6CzIXw2R1VY5KNEcI1MVZkHO75LPZO1FSlo0OBgPYQlbk
         tIGsH9QtYG3ZUMhWkcnHgR/tbymTrZh4x5s6iCSvr3ZK9dATkTRP5u2u7Vy7eTBEh/3n
         eiIDkVlUvoVKCm818kl2MlZm/n5RRTbb013UY+RVDmpJ18jiZ38IULWkHP25rzey4LpO
         wqGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587395; x=1793192195; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qi1H/TWXxLLxbGzzn39MIG1qXo5ZarlUhDNNloP8fkw=;
        b=eaWpfOtjLbTltFIYf/0HgsAaZYh4+RqTlDSj7tec+v7r59/ApehwoK1nURlUiXfZZI
         6SvUMBsUq/rYIJ2m4EYj6MpF0D1fd4QbbPIdCzTMB2srLqC/nLlzHhK00lWQmivmySbJ
         2Yb3ypiJ5ZMEkdeNof/W6HbNryu+jNzZTG4mWM55NSpjQhv4wtN5CyFbL4N9dwmf+7Zo
         bhTwsJwPdOwmCyT8NIOy+c/QJFqiHwkOBt+KczPiwoiQMZGJnBqjgZn3jSxc2Pv98IJs
         YkQyd+++KsorzGb0n0lCa3AplzuhYkXMK+wkdLmfACy4Wtj976iBqGlnhCg3MzVIelkZ
         QQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587395; x=1793192195;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qi1H/TWXxLLxbGzzn39MIG1qXo5ZarlUhDNNloP8fkw=;
        b=hDy73DksLUKqnIz8iP6LANcM9mMDFfj4+3L3n6pLVN048p3KOEwcBKFf9N5XwuyZ9i
         N71xPh7lXBD3VbRCSmMjdxG010xl58+66MeXct57PYchdTPlQUTLMesg2LKX32RT8EeS
         H1K27bptvqhAUxt/cysh1LsxjD3OOdW5SXsz6z8T7rugNjRdwmQwcgUoXNwyVt2aW8So
         nNjt0Jf/TUMSSqCt3AV1E0ILr2pWshIp8B7eyh9Yxn+bfQ1QnvvBS/NirRPP2GcBO+k1
         ljvMhbiM+szRl0j0/q197cGiojdFpjheNjMrdysC8LGkEwH1tEAyRJfwDt2yV8h4i6Sh
         dB1w==
X-Forwarded-Encrypted: i=1; AKwUvBx/UBAsV2tVyPhzR2tj3yqjYxjM8qPak8eKJWSev9LiO6PIFch5NZWHzLhdOvlzxmIN3TTrpzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIIuWHk2thJvZXy5Mh8PFzwkOPOSAf0C0mK+CrKLg9P+XAFKwI
	T/uAg+E2vFsbTWDVs3gZhDufBRgPJyT2tVXIKkiGbByW6o8Jazf4+UM7UldxhMpzUOEzDCK8pN2
	uQRySAP772NFJBDfgOPnaVsJ+Umg5hc4=
X-Gm-Gg: AYBFou0RQrHNldfHSCJlFLGYUB9otRr4y7GyZNDAISDskit/J/YDF3XtpVxAMA0gL0B
	G7oZ7rN+SilYJLqEPX7el6TdfK8IB4x8/SJA/shakwYU9JkxFEN+9MC0y7V+ffMWetWQ3BziMzu
	XklcPbOqfLe/KU5Pw7B2OyZsxupl0ekhOu2Un9jhN6t4VbNFxRQKi21RNjr1HC0SOt/jCPuhjCf
	HQkO+XensTnzIHDiuv/3v++pDCJTvn10MKJFOigjr4MF48jYaGKyFxyMXEfWUdjjBRM4AU8vVU+
	OSrETPpOrALcT28AzOZ0M43b+ogmX+0u5ZT1Mxe+pjhry+Y1gN0mBmwqxDTWhNFGaO1FmAKrWc/
	BcC9DjKcHwV1UzyYNvX5WewmZj9JmDWYL7HyriJkWpu7pL1X06CMBCmBO4cxgd0qeLtDxc9MNc/
	RczKauRJVyPJ8by1A8gSg=
X-Received: by 2002:a05:7022:698e:b0:18b:755:ae06 with SMTP id
 a92af1059eb24-190a7661e5bmr3619854c88.37.1792587394516; Wed, 21 Oct 2026
 05:56:34 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-sv105c-retry-set-interface-v1-1-ab2f08bc3fcb@gmail.com>
 <20261019111712.GP595565@killaraus.ideasonboard.com> <449eb143-37a8-4044-a071-63fe495c0213@kernel.org>
 <20261019112726.GR595565@killaraus.ideasonboard.com> <CAAquLuDc==WsbOYTfuKV2tspTSQAvB7kg2r2aqbE2rs3tYx2LA@mail.gmail.com>
 <d2d5e53a-ba8b-4b66-8e15-0c45e08e0f3f@kernel.org> <20261019123803.GA855235@killaraus.ideasonboard.com>
 <CAAquLuBW3MaBZgxQt_Kr7L2jGQf6mXarRtKi729-44DqwC=CnA@mail.gmail.com> <f4c591d0-304a-49d6-8892-d28124767a55@kernel.org>
In-Reply-To: <f4c591d0-304a-49d6-8892-d28124767a55@kernel.org>
From: Ostashow Constantine <ostashow@gmail.com>
Date: Wed, 21 Oct 2026 15:56:22 +0300
X-Gm-Features: AclHuK9yOMjxMFyx5SOlfInswV2iCdARQUgVp5qEBKbxa42As5kbuxjFSrB3VSM
Message-ID: <CAAquLuAepobWS5N7CzwO4po2g+=CmtqDPZ9D1VQQiWfJFi6S7Q@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE for
 SVBONY SV105C
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans,

On 21-Oct-26 12:26, Hans de Goede wrote:
> I wonder if it helps if you insert a fsleep(3000) here on the RPi case?
>
> So that is sleep between the Configure Endpoint and the actual SET_INTERFACE
> ctrl urb being send out.

It doesn't help. usbcore is built into the Pi kernel, so I put the
delay in a small test module instead. It has a kprobe on
usb_control_msg() that does mdelay() only for SET_INTERFACE with
alt != 0 on this camera. In usb_set_interface() that call comes right
after usb_hcd_alloc_bandwidth(), so the delay lands between the
Configure Endpoint completion and the SETUP. It was busy-waiting,
not fsleep(), but the timing on the bus is the same.

xhci-hcd trace events with a 3 ms delay, 5 stream starts:

  Configure Endpoint queued
  +0.25 ms    Configure Endpoint completed, Success
  +3.1 ms     SET_INTERFACE alt 6 Setup Stage queued
  +0.9 ms     Transfer Event on the Status Stage TRB, followed by
              Reset Endpoint, Configure Endpoint (Drop), Configure
              Endpoint (Add)
  retry       again 3.1 ms after Configure Endpoint, Success

The first attempt failed in 4 of the 5 traced starts, and the fifth
completed after 260 ms. So with 3 ms between Configure Endpoint and
the SETUP, the failure looks just as it does without the delay.

Without tracing, MJPEG 1920x1080, auto exposure, blocks of 10 starts
with the delay settings alternating:

  no delay      35/40 first attempts failed
  3 ms          32/40
  20 ms         29/30

Today the failure rate is much higher than in my earlier series, with
or without the delay. Every failed start recovered with the retry,
including the retries that also had the 3 ms delay in front of them.

> Can you try the camera on the RPi without involving the USB2 hub, or
> are all ports routed through the hub ?

All of them go through the hub. The VL805's USB 2.0 root hub has a
single port, and the VIA hub (2109:3431) is behind it. All four USB-A
ports are on that hub:

  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/1p, 480M
      |__ Port 001: Dev 002, Class=Hub, Driver=hub/4p, 480M
          |__ Port 004: Dev 003, Class=Video, Driver=uvcvideo, 480M

The only port not on that hub is the USB-C port, which is on the
BCM2711's DWC2 controller and not on xHCI at all. I can try it in host
mode if that would tell you something useful, but it wouldn't separate
the VL805 from its hub.

Regards,
Constantine
