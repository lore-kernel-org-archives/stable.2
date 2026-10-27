Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119866;
	b=bqRePCGO5LG6JTPfKMUWfCVaRwSVyvqYToT+ODHAhHsU0dew1yq5B++grWik3h2PqE5H
	 TfApQ0t4u9bOekU0v3BSdCfSMhe6SaYzaY/hnc32RRVcw/e970RLVBEGr8Y53xIKAhxJs
	 i3etzeeW0UUtRiJLZuigbxRvK/sjrWUoV2d4pogk+fSIkN0iaEbN9sOrETUz2wIIt5NiF
	 G8FiVMzKhqaF8+jaWPG+e76gylpkTYFZfNjWb98W+54wrlgOgpurJUT09pOhz1zn6A8Ky
	 cKdyrlMGmEwZ90nsVfW/UT8Dm2MHI8d8meTfy8F51LxHohOcNEJmdvkPZP3Zyl9mw/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gL6dJRyC87gSi0UJQ1axnIT4yInKJxdawRq198/IQ5k=;
	b=rCodAjy4DqoGENUf/RzqH3dRSBn2kOnS0giEE932Z3Be/QkRMQeO/7bVSrX1DztGcyPV
	 Z2zI8tqOgKamYoIevEKq/MYFF86mJy+ahZ2Il1l9JzvOQNTRe7Idg3qs1Bw3gSarvVqOu
	 Usg7vlfLVnUSSwS7i8MRhaK89+ku9WQitf9LX0ksBWvErYYrByQn36BIQ5zJXFZ071QjB
	 ijo6Q2PqjXf6UsUpks/LWI3h9r5e847eBAv5vTpSKdd7qKPlcZH3Lv0T1/kjY1cuMGlC8
	 htVhJWrEbOVVIRYafQSdIlx/QHqGxyTeReG/mIgBl6z1xqUD4V8akrVw8iIWw/qtK7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=f2AcRrWv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD8606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2AD8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=f2AcRrWv
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4a6f2825dd6so35995fac.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119865; cv=none;
        d=google.com; s=arc-20260327;
        b=Lw2/UsUR0zoVi0lnj5vCA/HJ/Oap3NTWRfasMmWr+tZrKoIrzA7obR/Z/r9ROigPSr
         12XN6dn4DcCeHV4DY4QkKLkvaTuz9kGgcR8Jv+vGuHQVnKjeAqAXXIcch8D3gWIlMRJp
         jsUQ/HD/9GQIC3Ft2YLp9v//Ol14jgby93utK7xFyeO9SE0K5atRnvl3rrmNZxxrYGoU
         HpeD7Avj9WDgUzHXE0w+UMg6Ac+ODacrVJy6M8y48K6cviEw1KPz4JVuV1h1Ba9Uq70A
         DRhyPU8j5Lmo9Y51j9Wor0Uk993BAuW6Ml+TiK5pVKS0oTKUicuOUD/VnUTGiEe6bx7i
         kqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gL6dJRyC87gSi0UJQ1axnIT4yInKJxdawRq198/IQ5k=;
        fh=QkyWH5cFLGXbBfvWnkWhIR8mXrqhtkNqeZ8fkj0OWbQ=;
        b=JURlC2Phk8hcfdmJFd6t5ZXOwPeKx84Z7WXnJeiRjsXFs2Aua0oTJy++r0L7nQLwrk
         lWT6zVokUcKWrLHnhBq+M0TU3fQprhpFO0S6i5hGbyqx1BKbZ/YGlAXX6Dr4YcdhsXUw
         hqXeAS7ljfzpeKxSMiHoxaiiaChDB5zS/STFBn9JRudnmKCrS3K+bp+Kb2F3aqUve3Lm
         6aYox4DG0INI6Uqw5d38PLgZKjLfrlxp26ILX9iPbSmQH0kfZ8waj0+6Sbeg8Kq84TPi
         S+EGt68w01k6Efo3wa1SawBzxQwHQOCw8wxYzcgAt+Ca5DYOh7oIl+Yv+cEqi6WFJ57Y
         iZiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793119865; x=1793724665; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gL6dJRyC87gSi0UJQ1axnIT4yInKJxdawRq198/IQ5k=;
        b=f2AcRrWv5oi1ivQNNe9pviZGHpfiK1uiUFT8pQSXULYzdF+YGe/NCMqF+VONT4YcMy
         USUN9cHI8CB25BG4MuVk9Uo+sUb5OqCFcD+CwWgJorVgGmS41UzAfoMStWXY2Mw0ved+
         YtxBLBoUx3LFFlM5gBvrjrGIFDDRp9GncBafYJPjQ5ySeLnXd8n9GtT16YFUqEcm4R5m
         tToxLd3MkjgAnM+DdQWCi9UkKuuGdGK9WkIWxE9cy9LuB8WtAC/q/QssIgtrXvskHXT8
         MbFY3h/OXGffCL1rDyKIQbbd2cB+SdtloBYfaQEjvYEf2UHUEs4IqjYERIFuVvj3RJB+
         svpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119865; x=1793724665;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gL6dJRyC87gSi0UJQ1axnIT4yInKJxdawRq198/IQ5k=;
        b=DfSjkbMoikkrfI9lQZd/iJVB1Xt+t2QViHJNsOp5oTUuUWoIjDJB4Hm8xGOBYNftaD
         sPA+/z6LIwZd3iomqUT7bx4LrIli0SIlo3DKHvbWjqiERY9VApJ10ORFMUt1o18K9bQJ
         zvevA43yguci10TOAdKvcCpHnPeW/O++PqHz9mYJwg+StlzaaezkEvhVoCYL18OeVpfB
         hxFiu3/tQKGPUgFUIjYiuDMx7sJiV2B6CiaH28X7P90XABnOugy0xzEO5QlZx2yyFOGD
         YAKibo2KYkIoL4wSl5fVdoerREVStuArPmhqJhcQvqdlYP5wPQ5keLT313XEet4c4kRo
         Uydw==
X-Forwarded-Encrypted: i=1; AKwUvBzEtsMsqdb/EeLthGr9OrxRp3yKyRKJ7N62hGDG6SCgE7IS8Qar+7JIYzHHFbL/xjCq/zYNXRM=@vger.kernel.org
X-Gm-Message-State: AFq9FYItdrysGRVO2s4lpD9UlC0CZE/2Fqy0Zs6cvcXG/7jh0+TnbDOM
	8tePv4h9gkzUlxDmv3r3exvQs5f3DWJlfxNRCCk1ySY+NeI0AxS8YYuBqWH+wLcSS5L/fMGrpPO
	91uEwds6V3+i7VutIsGUuCQNgFm9HLbYokqAKnJ71XA==
X-Gm-Gg: AYBFou0DyPtdLI0uihnobcTqxnpan3rTYZOl9jE4zBghBd8IVqZys4WtGcAsDW9MnKV
	iP4TLJdE36yW/H7jnRZSomUytQUfwH7cahm6jD0pjJ7AkeoVr4fayElg6gw60fY7IpgzOKGi0GJ
	FzGDPGUNxbOP5i26r77X8iB+JkRWDJP6wjFu4PCzmSxezmao9FeOc5gL+WzcqEvNnBnzeBQvdN9
	nMTglC1rB0Ib9nz+J87yW6kcbttUoz56MnK+3taaFOcqsGnLJs42n3nJX02EJ7mZgQ++vpJYxHW
	oyeQv3W7irZuvX0I9YMla/89djgorv7TZuuxfJJkAD8SDuF+hMHfRDvnYvnD0UXQG3ytozz2VQ6
	cOUfHTAi5SC492UuCEv93WQGMEkggUfxgW5ZOPRDu9ShRn2HAbchyWBeiaZGq1EP0FfpGmfGsHa
	xoYsIyniB8eveciZM44c4DRcnRePLC4yQ9hK3v5SNx1zIQE5wcBZCA5A==
X-Received: by 2002:a05:6870:d889:b0:46a:c217:c56d with SMTP id
 586e51a60fabf-4a8bb1737f0mr98260fac.2.1793119864501; Tue, 27 Oct 2026
 09:51:04 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
 <20261026111032.88355-2-antoine.pichot@gmail.com> <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
In-Reply-To: <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 27 Oct 2026 16:50:48 +0000
X-Gm-Features: AclHuK-6apCrsSW-JKKLxfQ64Ax9KsC9jd8-Haw-R9qIe3JqmapOTsN1wSNV7Ks
Message-ID: <CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com>
Subject: Re: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
To: "D. Manresa" <dmanresa@gmail.com>
Cc: antoine.pichot@gmail.com, linux-media@vger.kernel.org, 
	sakari.ailus@linux.intel.com, mchehab@kernel.org, djrscally@gmail.com, 
	dan.scally@ideasonboard.com, hansg@kernel.org, 
	andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Antoine and D. Manresa

On Tue, 27 Oct 2026 at 10:27, D. Manresa <dmanresa@gmail.com> wrote:
>
> On Mon, Oct 26, 2026 at 08:10:26PM +0900, Antoine Pichot wrote:
> > Observed on a Surface Book 2, where ipu-bridge lists one link frequency,
> > 319.2 MHz, which is link_freq[1]: V4L2_CID_LINK_FREQ reads 240000000,
> > and the pixel rate and PLL registers are off the same way.

I'll agree that the link frequency isn't abided by, and your patch
does fix that. However testing on a DT based system (Raspberry Pi)
with a 24MHz extclk I'm also seeing issues.

I'm working with the datasheet from
https://static6.arrow.com/aropdfconversion/dedba0a4f2b52e9b6587341a0e31cd115a2c3a46/ov7750_ov7251_csp3_rev1f_ds_2.12.pdf

As I read it, the pixelrate is configured via PLL2. Those settings are
identical between the 2 link frequencies, so the pixel rate should be
48000000 in both cases. Without that I was getting 75fps from
libcamera when I asked for 100fps. 100 * 480 / 638.4 = 75.1fps.
The settings for PLL2 with a 24MHz extclk exactly follow the sample
PLL configuration in table 2.10 of the datasheet. For 24MHz the
multiplier is 0x28 / 40dec vs 0x32 / 50dec for 19.2MHz, resulting in
the same rate.

The settings for PLL1 seem to be all over the shop if the datasheet is correct.

With a 24MHz extclk and measuring with an oscilloscope, the "240MHz
link freq" actually runs at 400MHz. The "319.2MHz link frequency" runs
at 454MHz.
If I follow the datasheet, then the 240MHz mode does fall out at 400MHz
For the 319.2MHz mode I reckon that the VCO is well out of spec -
2.128GHz when the limit is 800MHz.

The numbers for the 19.2MHz modes look sane in their ratios, but I
can't test them.
The 240MHz link freq does a prediv of 3, multiply by 75, and divider
of 1, which keeps things in range, and 19.2 / 3 * 75 / 1 = 480MPix/s,
or 240MHz.
The 319.2MHz link frequency uses a prediv of 1 and multiply by 0x85 /
133 gives a VCO frequency of 2.55GHz, when again the limit is 800MHz.
That then gets divided by 4 afterwards for a supposed result of
638.4MPix/s or 319.2MHz.

@D. Manresa it'd be worth trying using a prediv instead of (post)div:
static const struct ov7251_pll1_cfg ov7251_pll1_cfg_19_2_mhz_319_2_mhz = {
    .pre_div = 0x04,
    .mult = 0x85,
    .div = 0x01,
    .pix_div = 0x0a,
    .mipi_div = 0x05,
};

So I'll agree the patch is correct, but it'll show up other failures
that were currently masked. I'm not fussed about the 24MHz mode, but
it sounds like there are devices using the 19.2MHz / 319.2MHz mode.

(I've also noted that the driver allows V4L2_CID_VBLANK to go down to
1, when 40 or below seem to give corrupt images for me. Implementing
set_frame_interval for a raw sensor is also wrong, particularly when
V4L2_CID_VBLANK is also implemented. I'll see if I can find some time
to patch it up).

Hope that helps.
  Dave

> The diagnosis holds on a Surface Pro 7+ (IPU6 Tiger Lake, 8086:9a19).
> ipu-bridge gives this machine the same single frequency as yours:
>
>   IPU_SENSOR_CONFIG("INT347E", 1, 319200000)
>
> and unpatched, the sensor reports
>
>   link_frequency ... value=0 (240000000)
>   pixel_rate ... value=48000000
>
> exactly the mismatch you describe.
>
> Applying the patch makes this machine worse, though, and since it carries
> Cc: stable I think that is worth resolving before it goes in.
>
> The fix does not only correct a reported value: it reprograms the PLL and
> moves the link from 480 to 638.4 Mbps.
>
>                      unpatched v6.19     + this patch
>   link_frequency     0 (240000000)       1 (319200000)
>   pixel_rate         48000000            63840000
>   PLL1 0x30b1/b3/b4  0x01 / 0x4b / 0x03  0x04 / 0x85 / 0x01
>
> The IPU6 receiver here does not hold that link. 150-frame captures of the
> 640x480 30 fps mode, counting dropped buffers from v4l2-ctl and csi2-5
> error lines from dmesg (including the "callbacks suppressed" lines):
>
>   unpatched  run 1  dropped 23   csi2 errors ~7216
>   unpatched  run 2  dropped 23   csi2 errors 13277
>   unpatched  run 3  dropped 13   csi2 errors 4722
>   patched    run 1  dropped 106  csi2 errors 120788
>   patched    run 3  stalled: 50 frames, then none for 60 s
>
> The errors are DPHY fatal error, SOT sync error, inter-frame short/long
> packet discarded and frame sync error. The frames that do arrive look
> normal, so this is the link and not the image.
>
> Two things to be honest about. This unit is not a clean baseline: even
> unpatched, mainline already logs thousands of CSI-2 errors per run at
> 30 fps, and the out-of-tree Surface driver sidesteps the whole area with
> a vts_boost parameter -- at its production VTS of 3448, 15 fps, I measure
> zero CSI-2 errors. And the sample is small: three runs each, one unit.
> What makes me report it anyway is that the one-line difference was
> consistent in every run, that it introduced hard stalls I never saw
> unpatched, and that going back to a build with only that line reverted
> gave 568 consecutive frames with zero CSI-2 errors.
>
> One hypothesis tried and failed, so you do not repeat it: the out-of-tree
> Surface driver notes that the vendor runs the 319.2 MHz PLL with the MIPI
> divider at 0x01 rather than 0x05. Building this patch with mipi_div
> changed to 0x01 in the 19_2_mhz_319_2_mhz entry was worse, not better --
> 3 frames in about four minutes. So the divider alone is not the missing
> piece. The vendor path also uses VTS 522, which I did not try.
>
> So either ipu-bridge's advertised link frequency is wrong for this SKU,
> or mainline's 319.2 MHz PLL entry needs more than the index fix to be
> usable. I have the machine for a few more days and can run whatever would
> help decide which.
>
> The rest of the series tests well here; I have replied to the cover letter
> with that.
>
> D. Manresa
>
> (Written with AI assistance, directed and reviewed by me.)
>
