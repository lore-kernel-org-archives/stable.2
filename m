Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B463AEF5F
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275461; cv=none; b=RSpip20KDhpFsUxf8rYf1MYskfKMRXpR0o/eAtZY1wWdg094qw2aYc+E9xJedY0sqWFop86vBlvqYZzpA7Udql2c4HxeFMif7GHRjUPoskSnySUxbUJa1zL3V2+Sj0SlN8y++y1bL+8Lz84SSLR3c7+KaEDi53ki3nChB6Eo7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275461; c=relaxed/simple;
	bh=bCSGhR4DxbYBnc1MiMyq1DyDQDRo3jRJWoVzeOkDWWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYDYywVtqNqyFknKT1InW1+8adMuq0gAXms0bqB3d7BcR3VKVbOO3qwzDiWA/HXiFt5cNvjAJAnjobQd7nX/qPhJWAhugGQ27zQsWTkS45kUCHbhYTRhW3H7rkV7gCDrwNmjAxTV709xjEUq8J2USYuav2WWFBDSCSLxAe+BDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFdZB3+C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFdZB3+C"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so19955155e9.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784275458; x=1784880258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4OAkmNxhp6Rm8jcMCdidsG/dyC+Qqj5a9o/3Z1ag28=;
        b=iFdZB3+Cm2GpWNpsuUM1eDhlXJOxRFsPqYIUJ/tQ+vdcqBQEeCYMkWHX8hsMy8Am+2
         FJWlK5GW+m82eM1d35ziLpuWT1bTTMPP6aXVbLGANLEHmfUkTdht4Zy8L2GhR66neilc
         ywrjWwc0Q8N/cdeQ+jkmrrbYnyAnstq95HOD0md4UfY1+TyRGSmYetP8qW8Yvq83xkvr
         aDC5R4ZsGHqAe4XiJnTmtjX0+B4/N5h9H/f1GQ7ISSSgkQzPca5Ipn6IPZF4lxO6ILZz
         xBvG10++OdT0sqdW2c2bpGeVvg6er7FAn60NAQ6rAMyVuujmUz1yqKUgLRtbd+Xbh/d9
         8LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784275458; x=1784880258;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4OAkmNxhp6Rm8jcMCdidsG/dyC+Qqj5a9o/3Z1ag28=;
        b=sHZFH4FZzMrCMi1VBw/pjs3IFg59hjnlENlr0C/9W+azVs3lnfG3p9kBkrTBvP83mJ
         N7rGoyHb905D72gQDwsQTO/W2eVgtueDfuLW7aOeNt9V7TmORjFuFd8ZA+eia7u00xER
         O2gqgIv2ZUOQVjfgwzM+LvqNh1iuZiLlnJRzD/s0GopfkXped7sYbiospZSRibmN9Hgs
         F2N0T5HYJKdKmAzRTt7NOzVHuHaWj/dZH5PWaSwz1L+jM8luXOjvHTY9DiNaWY4GpODk
         7JxuuTMq4jmk/Zpy116OClLQoBZUYjPy5+q8lcuDRlxIXezHn0xlfip6DYf8/bINwIMW
         I84Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp/kQdsFKzFNbcbNSFJTSVMrJZ0g1PMljqplxNFKUr+3Fw9/VVi9beGWPKGXy0W1STNxxT4geo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QTire0ZdvGCwLWwIjy4gznvdsl6yoIWKOEwHshIVnnoYPF+h
	5swR9yTer/4/tYPSRSGYKTOcHaNfv93wjtW9IEJ0JJ1DcTmdixpNXZbB
X-Gm-Gg: AfdE7ckMQmvyVsfQ+d0auOKxM4hO88J1c0SJue8Gqf5+oBykawUvX3Wqu8FB9ksADcO
	lopFp2FPZ9Th8l02D5JlhlO/D13y5jl4XU3ciwbZTp1io4ekYCO6Ql1XRPdVe9V4/4B7O7gkBox
	iqeAZmQ62kCJNaN7b17NhE1plSS9ITea1tQJ0ZGCcEnyDnN80tjWJRjglgd0osJp4QL0x2X/CC7
	UiZ7ZCbJM19K1ghshT2d7vvI9B67D9slBrCWBgiPydGuAhuIGdE3JDvYDk3mBClvBYW3siR/rJq
	66FRzzWCOnpXKkMuZtrTyMkFHdhvEvVajGOwQr3267cdUUm+3SR1hxRlafRaF/W8YaBj/K6uwHB
	bNPvYxyNDgWWiz/AU3Gw5ktGU1YpN+f/T5kR+ftv5Qk2OEJZ+9TlbYkArFm34NgxbDNvKgKnx2x
	fLGZaXXI95znmWRYCebP5t/t6W10YLL+Y1Y9hJSwM=
X-Received: by 2002:a05:600c:4e88:b0:493:ee4d:5c5d with SMTP id 5b1f17b1804b1-4954a40be25mr16065435e9.31.1784275457797;
        Fri, 17 Jul 2026 01:04:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2f210csm30955275e9.15.2026.07.17.01.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:04:17 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:04:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: wangdich9700@163.com
Cc: tiwai@suse.de, broonie@kernel.org, wangdicheng@kylinos.cn,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: fsl_easrc: Use div64_u64 for 64-by-64
 division
Message-ID: <20260717090415.07b0e46c@pumpkin>
In-Reply-To: <20260717070252.525545-4-wangdich9700@163.com>
References: <20260717070252.525545-1-wangdich9700@163.com>
	<20260717070252.525545-4-wangdich9700@163.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 15:02:51 +0800
wangdich9700@163.com wrote:

> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> Fix a compiler warning about do_div() truncating a 64-bit divisor:

It's not a compiler warning.

> 
> sound/soc/fsl/fsl_easrc.c:2061:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> 
> do_div() truncates the divisor to 32 bits, but val1 is u64 and may
> exceed the 32-bit range after (u64)in_rate << frac_bits >> 12 with
> frac_bits up to 39. Use div64_u64() to perform a proper 64-by-64
> division and avoid potential truncation.
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
> ---
>  sound/soc/fsl/fsl_easrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index 114a6c0b6b73..d0bbe9f71e36 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -2058,7 +2058,7 @@ static int fsl_easrc_m2m_calc_out_len(struct fsl_asrc_pair *pair, int input_buff
>  		/* right shift 12 bit to make ratio in 32bit space */
>  		val2 = (u64)in_samples << (frac_bits - 12);
>  		val1 = val1 >> 12;
> -		do_div(val2, val1);
> +		val2 = div64_u64(val2, val1);

Are you sure the domain of val1 can exceed 32 bits?
There is a comment in the patch block that implies otherwise.

	David

>  		out_samples = val2;
>  
>  		out_length = out_samples * out_width * channels;

