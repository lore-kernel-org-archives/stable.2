Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096807;
	b=w878JX1VmOFoGn1hIGLoq8yh6C13haKje2IVNXo8Jv1zF7h5ep4vPJPPWe53w/tJ0bhI
	 6IWkyvKEUFIIYxSwVH1jJiJYVhjvL1T114wPta+dr9iX8VFkCQnMw2RRTWpxpVOCyWLK0
	 OFvqvNzQNdAab/OXxn74Dsgii238Z7FftdTA6AElMWqZiJV0pS5hktSNteafl5ohj1BJT
	 xpTneu+kMFuGcUxHw+8jqv0usjcflXtDeO+s2gavEpIHJmC7zLXY96cJpNpyuvhYxK7GF
	 r4DyCwKolMxrKoQamYvPHsnhUajkJcK35a6lpLdMZ68ir5czFxB+u5y2enw38ZY2i/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096807;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=POzvAe7QGGr/0bL2el8rav1+Sb6N+ML+fOUxzpGMHxk=;
	b=BXpjep3J8IM4z+XYwL4Q2W7yn47aTxaTmyyfsr/jQPPFbKqg004JnfoxGGnBoQdulrZ8
	 uIzANzbcztUhc9/ox1E6qspr2ayGgwpqZWBIQ5EJEPFWVFyw11A+tdfxo1v667wpA35Bd
	 QthC+nsl72lQ/ous+io9G2ycaFfNEWWiBMKn3icEHUdY9xa8M8vSF2AyaqV2ik6CmS6w1
	 xeH32KALQdfGJb1FCCfwkcRkXJqkWzZcEQuoZt1LUO7m3shkZmeL17XH7TshTSH/qbXPy
	 EkpR/xoQr4Zcpow9lV9L8mxFp/OKPT0LM29DgQ6HgetxR9yNgsBoBxSrttdNNw+kKmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3D606A334
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E3D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso30883695e9.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096806; x=1793701606;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POzvAe7QGGr/0bL2el8rav1+Sb6N+ML+fOUxzpGMHxk=;
        b=HfMyTezJ7dv5SzbupjJGV0OqmafaJShXen1e4LNGLqf/VtmXTz5dbud/UTxKXnWUJt
         7Ce6pBPUVSmi3AWUn3dPdu+BHGoerpgf4QYqkuqtPLPAZXMHsoR0tSG4lX8NNHgUk8u+
         x01yDy7QVLTKUgT1OlqvJx37R7zdr/t7gfyw+KCERCstZZx1VQc3QL9T70Pce8xJdopr
         MtOPkBS90xELqc/bD763BgHyj7j0MQrgflHlO7Q23D2ZIADJJLlM3OMmyZ1cPN4t+EZW
         bk8Zu7DoU46PjRqY29xOcsALVap0JE0K9evJ3GOOcXEtZUB+GgTA1EqxFwSFdlAsHuo1
         01og==
X-Forwarded-Encrypted: i=1; AKwUvBwrKG9B73sw5thLkJo8xK5+CrY7QGtmf80Q6VuuPXJQwPA2qAFpaEJgNub3OxVfOV8VbFnLxUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLx9Sfsd6joX9D1ThLQnA6W2wVTtbk6NyG88Zw7e680/unYxvJM
	H9ylD3dZMVQC8odmsH/7Ogp2+dhHZyp0n4YzhwZIHb5L8AY3GFo2U6I=
X-Gm-Gg: AYBFou1EjpIeSxjHERlGxTrFC9gwatXpdza2y2h5qb+nLXRjLuztSy2B7UnpGO4l3kx
	7Cx6Bid1R+sN5QQYSPht2ixbidD64E2gP7kXFZhOJodYRoDKfuGhZWDQLur352D2DgSBE/SSFYG
	P1ics1lyxuTlHsbw6hlGXuJ5CxOzGBoN/WD1FSH4YH7qTEvjuIhew4uRT+fZ6awdbZWAEhlYcWG
	SOfLSiPvhjZ23VUZ5sPaOcsTbyIN/KVcLQpuDiqXHDjsAPpsJuyUbRLzRhnIwpky1HBrdcw90xE
	ePXiXxhvJMO8OLF9Pr4A7YRJzlXijWzWw8lj1UlIJpZD9rEyLGLKgQvVNZ/zhMHLKrfoNLQntrX
	6ReXDs261vG2LFMdwbaZnalvrITZF+q51H5gderBBuKRJWOXaEyOf2G/GIyoziiyDbwU23gmlAT
	HEs7psHJIwM4jNM2RpY7HGxu/7FNNFFTdnJ867YyPWixIG2+GnS9s2upOicxffZu5FldFduuZpj
	MkwcxH5pojhPg6gmiroBr2oP5B2MB6yfLeW0Q21uwhlemkv2IvnTDutti2t0fPKL9EeSU4c50pC
	m9Q0fVJXepVn8tSIv6GtDbjfibpRBWjMnoUm0QY=
X-Received: by 2002:a05:600c:34c9:b0:4a2:994:575c with SMTP id 5b1f17b1804b1-4a35acb994bmr179703845e9.34.1793096805704;
        Tue, 27 Oct 2026 03:26:45 -0700 (PDT)
Received: from [127.0.1.1] (84.124.213.91.dyn.user.ono.com. [84.124.213.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f3e00asm444137735e9.0.2026.10.27.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:26:45 -0700 (PDT)
Message-ID: <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
Date: Tue, 27 Oct 2026 03:26:45 -0700 (PDT)
From: D. Manresa <dmanresa@gmail.com>
To: antoine.pichot@gmail.com, linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org, djrscally@gmail.com,
 dan.scally@ideasonboard.com, hansg@kernel.org,
 andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
In-Reply-To: <20261026111032.88355-2-antoine.pichot@gmail.com>
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
 <20261026111032.88355-2-antoine.pichot@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 26, 2026 at 08:10:26PM +0900, Antoine Pichot wrote:
> Observed on a Surface Book 2, where ipu-bridge lists one link frequency,
> 319.2 MHz, which is link_freq[1]: V4L2_CID_LINK_FREQ reads 240000000,
> and the pixel rate and PLL registers are off the same way.

The diagnosis holds on a Surface Pro 7+ (IPU6 Tiger Lake, 8086:9a19).
ipu-bridge gives this machine the same single frequency as yours:

  IPU_SENSOR_CONFIG("INT347E", 1, 319200000)

and unpatched, the sensor reports

  link_frequency ... value=0 (240000000)
  pixel_rate ... value=48000000

exactly the mismatch you describe.

Applying the patch makes this machine worse, though, and since it carries
Cc: stable I think that is worth resolving before it goes in.

The fix does not only correct a reported value: it reprograms the PLL and
moves the link from 480 to 638.4 Mbps.

                     unpatched v6.19     + this patch
  link_frequency     0 (240000000)       1 (319200000)
  pixel_rate         48000000            63840000
  PLL1 0x30b1/b3/b4  0x01 / 0x4b / 0x03  0x04 / 0x85 / 0x01

The IPU6 receiver here does not hold that link. 150-frame captures of the
640x480 30 fps mode, counting dropped buffers from v4l2-ctl and csi2-5
error lines from dmesg (including the "callbacks suppressed" lines):

  unpatched  run 1  dropped 23   csi2 errors ~7216
  unpatched  run 2  dropped 23   csi2 errors 13277
  unpatched  run 3  dropped 13   csi2 errors 4722
  patched    run 1  dropped 106  csi2 errors 120788
  patched    run 3  stalled: 50 frames, then none for 60 s

The errors are DPHY fatal error, SOT sync error, inter-frame short/long
packet discarded and frame sync error. The frames that do arrive look
normal, so this is the link and not the image.

Two things to be honest about. This unit is not a clean baseline: even
unpatched, mainline already logs thousands of CSI-2 errors per run at
30 fps, and the out-of-tree Surface driver sidesteps the whole area with
a vts_boost parameter -- at its production VTS of 3448, 15 fps, I measure
zero CSI-2 errors. And the sample is small: three runs each, one unit.
What makes me report it anyway is that the one-line difference was
consistent in every run, that it introduced hard stalls I never saw
unpatched, and that going back to a build with only that line reverted
gave 568 consecutive frames with zero CSI-2 errors.

One hypothesis tried and failed, so you do not repeat it: the out-of-tree
Surface driver notes that the vendor runs the 319.2 MHz PLL with the MIPI
divider at 0x01 rather than 0x05. Building this patch with mipi_div
changed to 0x01 in the 19_2_mhz_319_2_mhz entry was worse, not better --
3 frames in about four minutes. So the divider alone is not the missing
piece. The vendor path also uses VTS 522, which I did not try.

So either ipu-bridge's advertised link frequency is wrong for this SKU,
or mainline's 319.2 MHz PLL entry needs more than the index fix to be
usable. I have the machine for a few more days and can run whatever would
help decide which.

The rest of the series tests well here; I have replied to the cover letter
with that.

D. Manresa

(Written with AI assistance, directed and reviewed by me.)
