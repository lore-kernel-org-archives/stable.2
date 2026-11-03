Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793711586;
	b=uMB5STl7hSQDShjT+d6DZAMx0IXmpJTq161O9aBtcEvcUtIgAWGnBtOJfaQXBwM28VEI
	 xoA3ZZNsEgSuR+DhB58hlCItz9F3qYkjZzBdOePLMBl6j+n+cFpjVdSiiCIreg5YIIW6p
	 Q7xBmPTfQiyDmuLWdimsrQTPwO9T7TB6jF3iXl2Y77OAOqV6mhbXt9rYWGI7374tMXUiv
	 b0jdIe1UfzXv7h+Lust+B2xIS4zLiy2O6DG1Wx+JcYmrspoyPeYtKVSj0Bq/6oPkNqBdj
	 fpu910vTbIilyOvvEtL8goxEJLV4R7LvcbHX5EuvqIlw4hPywVk/oMDRYZt6T9fx5PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=2icZ8zL6TGgUUS3K4DQzo0gf6WlRsL/AWMLzp7VQAlY=;
	b=ydHq1JEQiujI0Z61t77h4xBtJkvONc2CLr0z5mAKBfjmV33whgy7ey029KcchjfMebA9
	 JnkcABRIaHKa0pwBoYXIcTJjThLCm4i8p4H/Imrqwziu/T9vL4AsKPxqlGFnNDNl7R5ne
	 TBDRwhQ7C35l34/7FDNC14HNpwF49hmLTVovQciWlEgxApUKSPLTzPCHpkKRXTTTanM0a
	 EAw6k1QkrtJID5NgFq6drgwIZWzGohFnTn9UNLxEKNFF3Dfvg9r6dzKiX8xIsz4ggA1MC
	 Fff/2Cuy92EtDgk0bGiD18lg3qZgRbvzYQuxaoVAMplKgwtbxV87ZbCkVGjRM9hbK0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=W+TZGI5v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8E606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE8E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=W+TZGI5v
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-533861a59b8so61758701cf.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793711584; cv=none;
        d=google.com; s=arc-20260327;
        b=UxRY46x23zzhSkdxqpM8HZm6rhOzBbcS09JaPRBAYh1u3HYpU3ySmtnlAvd7Vq315Z
         37Zp4twRIGya3vX8ixReHU9PNKqEnB/Gr5Bk2NhxOiUaR6bp0Z2wfXSbrl1gJ4Xr3a4o
         S3tEHOQshFamIe2R6DlxHYyvM/89sYYHewHr9RXP9VlZw/qT8BZOyca8a+Xx37zb3H9n
         sf1OOGtFyRtjvZJYtINHLRdTPnf7F1LoFAqPzC01Zd6tiJy/buu0i+wvUxTAnMqmVMJA
         YiNOcAMRrwXh4EfflRe1dBl1D9Js3RZUi33ptO4JLJypdj77JMcnz5Rwm+vZ1aIpM9h9
         bLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2icZ8zL6TGgUUS3K4DQzo0gf6WlRsL/AWMLzp7VQAlY=;
        fh=Na8nqHzEDvAf9Nyl4AQyOMDLNz2RrxPIs7Eus5cAZqI=;
        b=bDP8jjSJPSRwUHxi6cs1D1TgkT+s6n2bh4P0xqtPYwsEhYXSt2laPOtMsad3yZALtG
         F/vAJrb1ah27qqvWPhZa+YS3xi59Xxjhcyel1aQhCcJjxh2AfFVbTiEejrtAMV1ZaMU7
         ZGxkp/SiPkqPpDH+iiOsJvqiy21yLmH6BmyKKByIXLVQyB4wSZJMxyzgsgcitVc04Zfj
         Fp2bn4oGuIkW2QK4ZcaHi+T9o+OOkyV3jdL9YY4UaqNSuGZApJ27/lO5d74F1wHuPkM0
         wgX4xME8XQTKTYF4rrKOcTFrVNIWgDvxYd/V5Y3l+jPN7myNYufa6ti6GqLt/8PXEvfN
         BDNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793711584; x=1794316384; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2icZ8zL6TGgUUS3K4DQzo0gf6WlRsL/AWMLzp7VQAlY=;
        b=W+TZGI5vLZXS0ByWo7DtIogkI6pO7pSJS/mY2Op4FSwOnPnLqmEGO+y6kOFNySoVff
         6hzsskAUEV6VDlUWfR9bYxw8QZM8cCzHsT6sxhQLK3GtsHrT27uc9P8PNgWo3nRz9Rli
         HIWb83bZK0sNcMTKdLCrQPGxcHWj1Pu2RhR4sUN5Euqvc4Vd7p5l2lyAaqch0aCoonU0
         L1eDkE4A2mvK3YBkVnKVeHMNo2LYu6yeSydKtS2NuDXkOlQ6vxusVvHbVq2S50rmMYJc
         GP27XI1ctLPE51XTb9JsiHKBcofQ3pZ1yk6wDAB+gWti3tIfEFGO5kH2zkgNeehKBaq9
         Ssyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711584; x=1794316384;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2icZ8zL6TGgUUS3K4DQzo0gf6WlRsL/AWMLzp7VQAlY=;
        b=r7OAQPj0jsgqeALKhNa54Brs5jGxYBgiT4VYwmuIqdEyQQ/DGiRaw2X06XtiQSejJK
         kLwebRrgIAbH0DMBJBE1FViszB2ekzmlhAmMBktE2Og+m3EmXRmGwN5Yl+pm7LfIZJ5F
         SwDdMHeMcy8CJqxhyIvpyUdFPkV7cz4QNJ2WPmZZTGpEdYZq0cUfml1WOYPMb5oX7q6i
         L/9Uxd9qCqz0skG1LwU+C7TewY7o8QP0NCyKI4WJPeeQMtmC7JTBkZazR7etLJPMRl7e
         uDYV3kO1ZSylCKDxCv22/lkpbqMvcwpXEMiZSSLGGhXOICrA5NScWjJVOrAx9R8zZVqm
         ViAg==
X-Forwarded-Encrypted: i=1; AKwUvBx13rSA/aQEzbfsG4uZrawNT1G8jiYEf05PfN0Su95UEeGKJ+UKLVOw9cn1h1h21ZIvgGnt2hc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qgznu7VzfykfrBV4w18bk8cT3LTGM4L8WfVQacrzTxRaam9bU
	UTOF6pHX+22A1URNDnUFoiRg47e/WPv8j4Qat4SP+EZhfIGY1dWtYK3hjBxJ2nYTPXQH4k9Zab4
	hMcVV4XEnUtePr8GPuQxGmW4fLiw/7PbFPPy3dL+6uA==
X-Gm-Gg: AYBFou3wOrdGBLBuNLqpdLUULQBF25AnoYf/nmC85/z4UquXH/+d7yo0OycjpHYu/dT
	vQ6c4PbkkF2X2md1qAOY4o6HDVQUzsWCSpJD6SPolrRcRbJW/JcJWBcwK1Ymr1m6vIUT7AeiYNY
	sgE9+0pB3yasuFd8yCKCm3T+tDYD3yol6HOi/3n0fNf72VEYF76rs8WcqFTfgBJJyx+H3KSc/HE
	WhZBu8XQxdMTmTepgdRw6RqQaNH4uAv3Zl8fmmcDrfQ3YoBVsMzGje0t+PAcWN6RokQ4Ywdw+Fy
	hvwBGfcHBz9M1mkzcn0fLXejCTy3zpczcLQveibCyfTYN41jLRrOIbBcF7NIdwoXjCcAXCI1C0Y
	WnQBaHwYcIOqVmwSdaE9+Bs+4JiSOwZXJ/vOQ5TJ5B5dnK/Jowv/I872m6wX1i5NpbdgOT4uhrM
	Q3FbxVIILzSCG6weRNZU1Zx+NDgLV0+XClj8d0bnayHC3q8Fp346TVyA==
X-Received: by 2002:a05:622a:5a07:b0:536:6902:db00 with SMTP id
 d75a77b69052e-542b85e857bmr221971131cf.68.1793711584049; Tue, 03 Nov 2026
 05:13:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028112154.855185-1-antoine.pichot@gmail.com>
 <20261028112154.855185-2-antoine.pichot@gmail.com> <CAPY8ntArdj338V8bcSxrmwKQecy-pAcCXMbkWy=qLckX=hawNQ@mail.gmail.com>
 <20261030142624.2235132-1-antoine.pichot@gmail.com>
In-Reply-To: <20261030142624.2235132-1-antoine.pichot@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 3 Nov 2026 13:12:46 +0000
X-Gm-Features: AclHuK_U5ble2WiVXLRC50tmd_2p41MtkynfG8ykA1QxyOsNrA5P6PF3v1U1_cE
Message-ID: <CAPY8ntCtf5ksaZdbuRYxTt5xaKvRcMHH2H_Z3fZxBG_c1m-2tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] media: i2c: ov7251: Use in-range PLL1 dividers for
 the 319.2 MHz link
To: Antoine Pichot <antoine.pichot@gmail.com>
Cc: linux-media@vger.kernel.org, sakari.ailus@linux.intel.com, 
	mchehab@kernel.org, hansg@kernel.org, andriy.shevchenko@linux.intel.com, 
	dan.scally@ideasonboard.com, djrscally@gmail.com, dmanresa@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Antoine

On Fri, 30 Oct 2026 at 14:26, Antoine Pichot <antoine.pichot@gmail.com> wrote:
>
> Hi Dave,
>
> On Thu, Oct 29, 2026 at 07:06:31PM +0000, Dave Stevenson wrote:
> > I have a 24MHz module and had tested with it, which you'd acknowledged
> > in the previous sentence.
>
> You are right, sorry. v3 replaces that sentence: the 24 MHz tables are
> left to a separate change, with your measurement cited.
>
> > I've pushed where I am to
> > https://github.com/6by9/linux/tree/rpi-7.3.y-ov7251. Patch "media:
> > ov7251: Add support for a 400MHz link freq" fixes up all the 24MHz PLL
> > settings. I've also done the conversion to use the V4L2 CCI library.
>
> Thanks. For v3 I am taking your "Move the common registers into the
> global init table" as patch 7, under your authorship, in place of my
> strobe-register patch: the strobe registers now sit in
> ov7251_global_init_setting, which answers your question on 5/7 of v1.

All good with me.

> The move has two side effects on the bus, both in the commit message:
>
> - The common registers are written at power-on instead of at every
>   stream start, so a restart within the runtime PM autosuspend delay
>   skips them. The datasheet allows it (table 2-8: software standby
>   keeps the register values).
> - Register 0x3820 holds 0x40 while the sensor streams, where it held
>   0x00 before. The flip control writes back the value probe cached,
>   and probe now caches it after the init table has written 0x40, not
>   right after the reset when it read 0x00. I poked the old value in
>   during a lit stream: brightness, picture, orientation and frame
>   rate did not change.
>
> Tested on the Book 2 against v2: the clock, timing, PLL, flip and
> strobe registers read back while streaming at 30, 60 and 90 fps are
> identical apart from 0x3820. On a sensor kept powered, a restart and
> mode switches from 30 to 90, to 60 and back to 30 fps give a correct
> first frame every time, at 90.45, 60.15 and 30.0 fps.

That all sounds good.
I hadn't noticed that the common registers were written from power on,
so thanks for checking it. It's generally when there are multiple
resolutions supported that using the reset at the start of the common
registers is of most use.

> The rest of your branch (400 MHz, CCI, HBLANK and MIN_HTS, the
> optional enable GPIO, the gain rename, the VBLANK minimum) I leave to
> you as you offered, to keep v3 to the fixes and the IR camera. I can
> test them on the Book 2 (19.2 MHz, 319.2 MHz link) when you post them.

That's fine with me. I'll leave doing any further work until your
patches land, as the CCI change is tiresome to handle conflicts with.

> Two things for that:
>
> - A data point for the VBLANK minimum. A sweep on the Book 2 in the
>   30 fps mode (exposure 400, gain 16, 20 frames per value) gives
>   normal frames down to 41, white frames from 40 to 26 and frames
>   rolled sideways from 25 to 16, both without CSI-2 errors, CRC
>   errors from 13 and a stalled receiver at 10. The same boundary as
>   on your Pi.

Great. I was expecting it to be down to timing within the pixel array
rather than the MIPI configuration, and too few blanking lines results
in things going awry. I'm happy to hear that it does the same for you.

> - At the tip of the branch (fde519da0503, "media: ov7251: Reduce
>   OV7251_TIMING_MIN_HTS"), unless I misread it, ov7251_set_vflip()
>   writes OV7251_TIMING_FORMAT2 (0x3821) rather than 0x3820, probe
>   stores the 0x3821 read in timing_format1 rather than
>   timing_format2, and the return value of devm_cci_regmap_init_i2c()
>   is not checked. In case it helps before you post.

Doh, too much copy/paste. Thanks for picking it up.
That error is actually in "media: ov7251: Convert to use V4L2 CCI
library". I've updated my local branch, but not repushed.

  Dave

> Thanks,
> Antoine
