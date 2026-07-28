Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BADF3290D0
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253560; cv=none; b=gZzN9PJNCgIAhjjDshE5cLNJDpy+DFYoSbrbr2zZZan3Dhbg5NWBreKS/qS4LOGI9ton31rgi4DFIm9frxdhZKVih5OtT5tv83ApTDWTCdhFWLjKIv3phCdSyG5iQdk4Wv7UF+qqmU4rcufWRiaFTePrRo5rmKbr6y0yTx7DZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253560; c=relaxed/simple;
	bh=VDo4it9UlR4Ioy8LhcAXVYqM6+ETaNhl9l00CrRvZx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LodpB1nWSIeG+9cja1/wEVsYP1RKoWPII35GxsSZRx+UQpmyZyC9asLYGER7BlESfH7gtp07DUHZg1zQ1nEawA56We7GdNi7sMFAbvJv+hNBpaILK/g/0ynqvkqLD5rw0zyPddB15HGR01toh34SqkKv2ZfaiObhw/pvwNF4fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxJc9hF/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxJc9hF/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so315a91.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253558; x=1785858358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MWiV0+CUdqlaiqVq42BuBLs9iZw1MGlogw86iDmjrO8=;
        b=mxJc9hF/zxbWGE1gS/oggdyOMS7wlw+pFNLjGvnVgvNO343noTPL824nJTMleJx+w6
         VSHzF+n1jCyzI72lbMkvwdPoIoYHEYr8XKQBypdjRTrp8zuOmNcwxqiwWeTouHkkLlKx
         kRwIHoSOQHBdZkKBSh5iuyK8V7lio6nL764IOr6y9SPuBVq+wa5CgdS7QV34mJU5nuPG
         hIxJwqPPeLaYkG9VZ5sX3jgSrr8COOmb7xMaWZ6uAqlMusQ3ca/NHr3ap2r5iVMT0w6+
         PX+zeeU+EcNGQf64EEgU6ET9LxUxyBbQXucAnBDuflXHYAQfRM1GcCn5ynSSLSmtIVso
         VlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253558; x=1785858358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWiV0+CUdqlaiqVq42BuBLs9iZw1MGlogw86iDmjrO8=;
        b=DOCjFIWwvXEnrojju45aYq1zo5KSFTcB6LxO+b/8Y6SsPPuF9fkoPpfAtbdKB/915r
         gOdFMd8TYhCcyNULS2vHYt1K5fiAxsGzQeHtU5LekVLn0CMs9o6l0sBFeTqKImAmx7K8
         9fKybMYKn0rrW2aGEVTdO3ncjzGfRiyUC01sbWy5fBX9nSG19+Hv/GGupnIq4rrYQcDP
         3UEi5St7/S3Rw2FUYJcGvTDtBod3edC1BVG29zd1tOOKtI5JWOBW6+YwN2K6wwuv/z1P
         gF6yYzTnW76HYKLLz+Ym5jlDhlUdNBDmKOgXtzf9DJqetT/x7vozPvcvtbdZvD2Fkl91
         FPAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYOfr+boyx2fJEUwjh2O2nmTsFxjE6W/Nb8RcSpy8eqrj81xlpLcfS8EMvR0K7D9r7+uiocmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmjyZZpsEaBuW7ACjFuXTSRdGrP6k2o3+DItonAQ0bvvePt8Zt
	kB8ZVPdsRYT4d9erI1Bn15iUT+4ToFdw+ShU09GyLN/PKKANnxySXLPn
X-Gm-Gg: AR+sD12Z5mUtEzY6qHMC2sl3t3lul+OxR0ZAdxBShkgiM6VKTkVUF1rsfqbUIaoRmi6
	RUTPydKQ/qoBJfH0UzaQtWfnmsHPB7xPY28miswT11j8v29+heRCdkbr6RT/iUE3Q/G+H1mFvCa
	pvBIownwK/5iZ62k2RF577R7N7rySEoJmz18uictis+THosibBcpTJAhYQFuXL3ra/VxbsdrFsJ
	tE6u7kN1BueSgZDGRcFm7mkDApRK5ZyW0Vhv0C6l3oNLUyK9mOAKFDmC9TknHmFfVEP4A6I91gI
	DaRJ0y5Ks+uGJUcFqP5GRD1Rj7y/kKGUS/XNmNpE+8veweXW+xyt5coYOcfBMj60JA18KbAcKhj
	7LdPLL+yL+rO8vH3wKWehiE2tfr6nL2kHzHUSPHPzfg57zWXFo6gb0gMg3nu+Z5sG5EBiAdt2SW
	cwpxlTzh4=
X-Received: by 2002:a17:90b:33cb:b0:38d:c74d:29c5 with SMTP id 98e67ed59e1d1-38f6a37699emr3215736a91.19.1785253558298;
        Tue, 28 Jul 2026 08:45:58 -0700 (PDT)
Received: from localhost ([172.216.252.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f056202cesm4465321a91.0.2026.07.28.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:45:57 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:45:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: fix mono image source stride
 mismatch in lynxfb_ops_imageblit()
Message-ID: <amjOr0NiY8OMNaRf@stanley.mountain>
References: <20260728131050.37032-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728131050.37032-1-meatuni001@gmail.com>

On Tue, Jul 28, 2026 at 06:10:50PM +0500, Muhammad Bilal wrote:
> sm750_hw_imageblit() advances its monochrome source pointer by
> src_delta per scanline, and computes the correct rounded-up stride
> internally as:
> 
>         bytes_per_scan = (width + start_bit + 7) / 8;
> 
> Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
> image->width >> 3. For widths not a multiple of 8 this under-counted
> the stride, so the source pointer fell further behind the real
> per-scanline layout on every line, corrupting the rendered image.
> 
> Rather than just fixing the caller's calculation, remove src_delta
> as a parameter entirely and have sm750_hw_imageblit() advance by the
> bytes_per_scan it already computes for itself. There has only ever
> been one caller, and that caller was passing an out-of-sync
> derivative of the same width/start_bit values sm750_hw_imageblit()
> already has, so keeping stride as a separate parameter served no
> purpose beyond letting the two calculations drift apart, which is
> exactly what happened here.
> 
> Rounding up, rather than down, is the direction consistent with the
> rest of the fbdev core: struct fb_image mono bitmap data (the same
> image->data this driver receives) is walked elsewhere with byte
> strides derived from a ceiling division of width by 8. The generic
> mono bit iterator in drivers/video/fbdev/core/fb_imageblit.h advances
> scanlines with "iter->data += BITS_TO_BYTES(iter->width)", and
> BITS_TO_BYTES() (include/linux/bitops.h) is a ceiling division.
> sm750_hw_imageblit()'s own "(width + start_bit + 7) / 8" is that same
> ceiling division with an added start_bit offset, so the caller's
> ">> 3" (floor) was the one calculation out of step with how this data
> layout is handled everywhere else.
> 
> Found by code review of sm750_hw_imageblit()'s internal stride
> calculation against what its only caller was passing in, and
> confirmed with a clean -Werror build. I do not have this hardware,
> so this has not been exercised at runtime on real sm750 silicon.
> 
> Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> v3: Added the version notes below, which Dan pointed out were
>     missing from v2. Added Cc: stable@vger.kernel.org, flagged by
>     Greg's patch-bot since the Fixes: tag targets an old (2015)
>     commit. Added the rounding-direction justification Dan asked
>     about, citing fb_imageblit.h's BITS_TO_BYTES() as the existing
>     kernel-wide convention for this same struct fb_image layout.
>     Moved the "no hardware" disclosure from an email reply into the
>     commit message itself, per Dan's request.

Generally the no hardware disclosure would come here under the
--- cut off line.  But I'm not going to nit pick about that, it's
fine.

I see also that the "Pitch value (in bytes)" comment supports rounding
up so this looks good to me.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


