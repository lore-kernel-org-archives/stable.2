Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793300819;
	b=u5+TS6Wwc1/UvhdWb3MuZXWUPJH1u/wKzrwADMKfb0npodj72h3iXW3cES0s7QbmuUNx
	 r9KCNlx4EEu0LucdzU73PWs73OUANKYkFqXXXB2Vw2Zv8rhJM1LhuzBJLTi+C4B1hsdB5
	 3P6dtYZ3GEUbqWhZBtnlxp/WXUZPjWyOCrrAKL8yUglQpq/VPjHrF/uSCfv6qDa0QsSRp
	 qbcw/OiAaqgNLm+9g5U+8kjn9IwBGlYmYZtAtEZtiLIiIJy7kdCnl9P+qRTYRl4EQZekO
	 2G933d5tc9Jj9JOohYQGeIF6xpL/KQUcr0DRJW65D78fBxmz9veV6ScPe8Fd2z/iEvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rWF5af6pEo6EMA5BmrOrM6NUXFElHsCaPEA1nqKLyVg=;
	b=vjPZuydFT6JK0xFsN1YavPeflJsXjscthwyUmI2xWunZTzw2qz0RnVXwdymmrQrf52dN
	 C/H4yqGSoOCEss+BsN2ed/iDZaOHbtooM2s0h/OsacPk+8LteD9x85/HVIdjgNtel8nlc
	 GY8FKN4f57QZjeUbGsINA8jCZdLxT/8ay3WP9q29j1KfZoQX1g1dARMOjxtAUJgS6x8CM
	 ibinikJWNSqEKW8YibwWDn2FZSNqtWtX7/t80Hb8ZoS7G16S2uudeNk/s05utKV1MGHCG
	 rqVkoBSnGJtqYW64vBi9dV8HuzwHdxCz0Aw+a61HuSh+CoT14S8TfVOuHLosDkx41qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C05E606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C05E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93a40a9a01aso130980685a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793300808; cv=none;
        d=google.com; s=arc-20260327;
        b=nGGJ510pG5cEaO2hVNnTHjPBwWrgDLDUezDe+HqaaXyNwyq3YqRwnctoadjvbE74Sp
         OTN3kfViGW50wtXM5Lnt1ftuhPXGZ8CJ7hq2xLZGvlczTm634OkQoA3H1JfNAe3wYVNN
         F6Yx842ltGkobGEWRU2X77oUpuu3njF8NnKi7sXnii+lxSLhGi/G3JzEP2rldROifFvU
         KyK84ahLvgejgsKvwWS4ZL/aTthu4FGJICyHr6NUYgdUrv6+RlapuwwlJg7DWZSwBBRV
         7fctmRd+VrDObmXQJuxdUn2nkitrn2ZFHE0CuewPlagnBamZSPnYP3hJslHhg+GfrAeP
         MwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rWF5af6pEo6EMA5BmrOrM6NUXFElHsCaPEA1nqKLyVg=;
        fh=7HjWocFcn3Ejbki0YkUUOlEysNkDycnGQ/VxJb2XK5Q=;
        b=m4YmB3zbFV2dvjBM82vBUsJsvzaWFHb0yhnVjPwpHfG2pA3RMhp8gJdrN4G7YCf9pK
         PJvPLBIjKA3zoQPePJtFgvqjXOmgsNI+SacTZb5fnrFSG849lKGiJcbkrpbdYMSSberq
         hUE78s9uWX5++mWxEHth/gErVJOdu8IelSlVMOykRo0NszxKDXAiND1Vs51A5fdspQJI
         wZvcrngXRV3PI5ZJWYRYvPVlmTTFzGmWBh1ptXL498dB5H4fISIEHsY+KvIIJiqeqKSq
         1zjzSEmY6cS4wo6I0YqQBPUHEeVqeQyOoelPqo+97dZ/ooLeRx+w5YBkCONt0gnPKvw6
         qFgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793300808; x=1793905608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWF5af6pEo6EMA5BmrOrM6NUXFElHsCaPEA1nqKLyVg=;
        b=fq3P/m36lKgYONgkNlKcJ2n9q0rQ0cY5YBE2kgtoKPzSV52E2ZypteL0Z0QDoMPJDy
         MqKYMU7nlRPyMwaBc/K4f63oDt7/GI+zLotT2jdIqr/cn8LWVvuM5S3NB16IEWb50Pzx
         szMF1kAongd8ARPufQSofgIaIR9PWT/MTiHGTkaaQbRddlhNy7GlPdAGkm4RAWEycbhX
         QJhWQIf+HMbAuwyqCmZMQPYm89pOlKwV3HFOJ+XMI0+QJZfITDfaTys8G1Ibtw0xQq8s
         1vl7SKsV6+wyBk9JEIELtxaZyuCIfxnbr8H2iSAVdFHO7TBOnR78aXvzviLBRpQcjY8x
         RFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300808; x=1793905608;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rWF5af6pEo6EMA5BmrOrM6NUXFElHsCaPEA1nqKLyVg=;
        b=Y66zH4LQhPvMHizoBiYnDz7qJebXvYIflHwavNPoTj6H9SWAONbNiruNJ+zeYj661I
         ZRnCefs1oqCW3s6tm1qGktoJlzrqgpL/r/MUB9axCoYt2aH8IUhkUv8QOKue++/YhHsO
         FrMoPI5VEs/eSoKHM6/uaTLZXLerVd7sqAnFDLE0+yomcrkUMuTnjIOeAX/NSYnaC0TE
         AIGeGTCTXi8avWyyu+I45YzpSPT42yrsD7ihqGr2Z2L2nrQZ/yTsCIv01spkjQKbjFdJ
         kubF4o8rK0tnpsdvNXl0mcamFbJkdHm1/tXLeGTmDtqmtHNs6yXESy8h9NWGX1N7dTvP
         Skwg==
X-Forwarded-Encrypted: i=1; AKwUvBx4Bx9HbL7nEihrPQ+Br0UFVHfN8X9RSftgggeM/bgSq47qf/tsNVDpTHe8ay6cAzMaVn86ArA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcH8CXRkZVCC5Lpngjv1CN6Ne0v74wXkVAyhKtp1aAQCYiN272
	ZfLYQ2u1CC+D5W8l+MkcwZhPbGZW3GOyQj5AcCO50BpvU4Da//w5oLGjUdXDB1bLi/CSr37o3wg
	ppkm9fahW3OXhz0Hc8L7II5aXnqkSSBdubjQ4m0/7pQ==
X-Gm-Gg: AYBFou20aJskrb0eno0iSniDVN5gZ8bnrdFJzB3+t5LkEQPojVN9zv80KxycD3ggDqN
	YvreRLQhhWDpqioubcQtUSIwCw7SEsi4NBu46zwj1uk6mzWztaj3iOc4ggP59BBo4r8iSz/La2g
	I53457xmfby7Cjmn+cVGyQJ/DgUHAIVg33I5zhUKbhOOK0D6jY/zFI4R6Eb5iN7QHOGL7QbkE4b
	3O24lCv925zfb1YjTxc1Z1FGk5o9Sk/8px8zytvvBPWiBtq4WuJqLWBhlhdp+/W0zFwC7dRdHFE
	s6eUL6eS9VquF0Uv2vn0+N98EyTPerJXK7onAF5BZJrVgULcfjwlPcRuZe5WNY09gA+ezssbtpD
	Obpw79nspAZ33S+Vi4oYxQwFlt/mMpKJFHghUZeH5WSdcjImP71dOxjvZfEeFVmiOHL1r+Dutr2
	MOEO02FElbSaxCcGkmpOnsUNRaT8vLPu/jO9Yl2r084gw4F8hAZNsWfg==
X-Received: by 2002:a05:620a:2815:b0:944:6ad:1b7f with SMTP id
 af79cd13be357-944133c303emr496752985a.32.1793300808018; Thu, 29 Oct 2026
 12:06:48 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028112154.855185-1-antoine.pichot@gmail.com> <20261028112154.855185-2-antoine.pichot@gmail.com>
In-Reply-To: <20261028112154.855185-2-antoine.pichot@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 29 Oct 2026 19:06:31 +0000
X-Gm-Features: AclHuK_Jd1_q7feVJfoLbgxqQ5EoRwMls_1DdxR9BDGkGVOV5XFZSQbDS8rlPb0
Message-ID: <CAPY8ntArdj338V8bcSxrmwKQecy-pAcCXMbkWy=qLckX=hawNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] media: i2c: ov7251: Use in-range PLL1 dividers for
 the 319.2 MHz link
To: Antoine Pichot <antoine.pichot@gmail.com>
Cc: linux-media@vger.kernel.org, sakari.ailus@linux.intel.com, 
	mchehab@kernel.org, hansg@kernel.org, andriy.shevchenko@linux.intel.com, 
	dan.scally@ideasonboard.com, djrscally@gmail.com, dmanresa@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Antoine

On Wed, 28 Oct 2026 at 11:22, Antoine Pichot <antoine.pichot@gmail.com> wrote:
>
> The 19.2 MHz PLL1 table for the 319.2 MHz link frequency puts a
> pre-divider of 1 before the multiplier of 133 and a divider of 4 after
> it, so the PLL1 multiplier output (the VCO) runs at 19.2 x 133 =
> 2553.6 MHz before being divided down to 638.4 MHz. The OV7750/OV7251
> datasheet (rev 2.12, table 2-11) limits it to 300 to 800 MHz.
>
> Use pre-divider 4 (register 0x30B4 = 0x04) and divider 1 (0x30B1 =
> 0x01). The multiplier output is then 4.8 x 133 = 638.4 MHz, inside the
> range, and the MIPI clock stays 638.4 Mbps, so the link frequency does
> not change. The Windows driver programs these values for the Surface
> Book 2's Windows Hello mode.
>
> On ACPI systems this table has been unreachable since it was added,
> because ov7251_check_hwcfg() selects the wrong index. The next patch
> fixes the index, so the two must go in together. With the index fix
> alone, a Surface Pro 7+ (IPU6) had CSI-2 errors in 7 of 10 150-frame
> runs, 3 of them stalls; with this change 0 of 13. A Surface Book 2
> (IPU3) streams clean with either table. Dave Stevenson measured on a
> 24 MHz Raspberry Pi board that the out-of-range tables miss their
> nominal frequency and proposed the same values. The 24 MHz tables are
> left alone because nobody in the thread can test a change to them.

I have a 24MHz module and had tested with it, which you'd acknowledged
in the previous sentence.

You've got me sidetracked into doing the cleanups, and that has
included validating the link frequencies on a 24MHz module.
I've pushed where I am to
https://github.com/6by9/linux/tree/rpi-7.3.y-ov7251. Patch "media:
ov7251: Add support for a 400MHz link freq" fixes up all the 24MHz PLL
settings. I've also done the conversion to use the V4L2 CCI library.

The cleanups do raise the question of what registers 0x3016-0x301c do,
and which of the 2 variants is preferable (60 and 90fps both use the
same values). The datasheet SC_CLKRSTx naming isn't exactly
descriptive. I don't suppose you have any information?
It would be lovely to ditch those tables / merge them into
global_init_settings, retaining ov7251_mode_info_data only to provide
backwards compatibility with those clients that use
set_frame_interval.

Feel free to pick up any or all of those patches, otherwise I'll come
along behind you and submit them.

  Dave

> Fixes: ed9566ce1946 ("media: i2c: Add support for new frequencies to ov7251")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-media/6ae0e944.b6db0abd.16b13d.d261@mx.google.com/
> Link: https://lore.kernel.org/linux-media/CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com/
> Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
> ---
>  drivers/media/i2c/ov7251.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
> index fce6344b5120..f429de5f1f7c 100644
> --- a/drivers/media/i2c/ov7251.c
> +++ b/drivers/media/i2c/ov7251.c
> @@ -174,9 +174,9 @@ static const struct ov7251_pll1_cfg ov7251_pll1_cfg_19_2_mhz_240_mhz = {
>  };
>
>  static const struct ov7251_pll1_cfg ov7251_pll1_cfg_19_2_mhz_319_2_mhz = {
> -       .pre_div = 0x01,
> +       .pre_div = 0x04,
>         .mult = 0x85,
> -       .div = 0x04,
> +       .div = 0x01,
>         .pix_div = 0x0a,
>         .mipi_div = 0x05,
>  };
> --
> 2.56.0
>
