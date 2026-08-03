Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB8400DFF
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769043; cv=none; b=nx7pRcXEUC14VogyOnbxkHPyTVI6mpqPqLCYgjYb28MvesGEW1IKvpN4uPe1DIGiKY8E4aQAItDhM0bSVXvHU941G180zga4cWoUtZUVvwZHQJquO4NPjRbM3nUceDFD3jjTtr38N0mucRileYnuHr5n/j1En3SkjU2m6DWwVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769043; c=relaxed/simple;
	bh=sJUF2UnrPqNELsMR2fGhE2BlL02YRxP+ImQptnWyR38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCvSR98mvlpvEX6cnbusqnvDCE0qozr7dgXtJGYHw1rAyY02YKuNcDzvzsEGsjudU59/W4WOosW7S8ztpUQiPSifTTq6PSkifQj0aPsBbjYWf+i2vhkGifEQJV6iCWkiADCZG3Sxipdim5Bz6QJJotgT/b2we0IhdnaSwPRkX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1DTg55O; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1DTg55O"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f904e80eeso3198572f8f.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769041; x=1786373841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=doE31CPU3agNQxp/VoBL0iESGBCUl1rgFFpxig9/S98=;
        b=Q1DTg55Owbntlw+hzW+8wHku+ILoMKsn9GIdItpV9AoA5NXWy0e4noxuabNN7pss6g
         HOHDIT5xazzHU/cwZB+j/DpWQKpPrT03wrjJPtjewkzg11nULqRkketK7Eiitsj3Sg5l
         oz5E1TCvvpowX9lfEV1Y7n6Vx6b3O53He8Mhj94qRdl2RshoT3LyZwHtbs0wYYH1hnD2
         fYpqpP3H2xQI8YfPZIssnNoomzsOOvhGq90gNu5oOPB/818TgSsINqRXEA8oNsTFvlWY
         6sI6iop4LVk+lmPkOjlPSFUFM6KR8Elal21kae+VjX+bLnH6sohgQtWykW0Hi/wsoOKw
         us/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769041; x=1786373841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doE31CPU3agNQxp/VoBL0iESGBCUl1rgFFpxig9/S98=;
        b=BGupqwV6MDJVsJ5JbF29uYmopCaXb9181UB7vn6MCIgnKqQdvYcKGI8sOf9MZzwwWB
         U+ITZGU06rbds6LZ4BJobRlveR0M9T6wLng468ktaqIpdzmNXVRP7F/TCQZOmB6fsp7l
         W5Jm4HcgVFEzOlNEzGAMA3XandivteXZeW25fp13eI/89Xz+g8JBlK5ZYGdgvHvrpum1
         Ff+Heae1BjWDraIozc31vCdAPLcUp6M4Inmyy6uo69qQdzWKCXkvRrxSLB9xLZbX0UHD
         aVIi4BCwucc+c9w9eI5KpKTTjYWwJy8W7kBUx8LZKn61AmeJzNBLcdNRiMf5e6w4SNHn
         0UkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8AJUq6vmKi1kCi2qclsZ46CwIKIvQ6oLxzrXlsp7hkSbqIqmQdyTfJ8zXhPCox5X6s3Q+8qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwVS1vs7Bm9ndmDxJksBqHrd/YoqwNVLu4IIYMzMCqaC1W6F0
	i78GEXSC1FxacocYtVqpQEqq8a0wK1NEgISv6SFyEWdKDmwosp11VPXPzXhg4+VRJ1s=
X-Gm-Gg: AR+sD13nJZCcMClxpsABT682p9RkPLaHu7Fu+uEmbqi0l8WxoIHDMXvkIr+bB1M+6vN
	tSGFbtSVLFwpwziv//73nnp64Ztx41I3soPMRxlAgO/rVROfdLyCcVCLXiVe28N3OfjT+gKeoGC
	3w9A7c+0Pi6Ar6IIzX1hKMWvXxpPTnsOmV8igCx/+GTQlMHajOT+XSaMbmtIdCMc+inS2nMEevc
	PnZfzFKHVpSBG0VUCpcNMBd02KCnrjlJREQTZl7bVOBOnZOifzR01g9F2VDP5sIF4ZuDhilana4
	oG8eaMZMK8QzuSWMSneeebCtWoi2G4X4DCRDUxs+OXTP1UNQcISOXz07UizUU7P6OfakijTgsxl
	j6C0T7ELLYrT+I3cDxvjCHEgUpF/yR/Cw8hXAbbECGoG71Wq5jMgDtL96KkaztHYx/DTtGc5q3p
	uQkFS/TEz13Vp3M1nlArRz3LbxhkXVk2pLNCLWve4J4Ebrx8/Kq6+I1VdOAkiU3ac74f3x18iQo
	1ZhpOqdI3nTKiFwjt8l1nCW6w==
X-Received: by 2002:adf:fdcd:0:b0:47f:8fc8:af01 with SMTP id ffacd0b85a97d-47fd72f1fd4mr22343046f8f.27.1785769040415;
        Mon, 03 Aug 2026 07:57:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bf7csm35015001f8f.32.2026.08.03.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:57:20 -0700 (PDT)
Date: Mon, 3 Aug 2026 15:57:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon/lru_sort: error out for >10000
 active_mem_bp
Message-ID: <20260803155715.08868ca7@pumpkin>
In-Reply-To: <20260803134034.15217-3-sj@kernel.org>
References: <20260803134034.15217-1-sj@kernel.org>
	<20260803134034.15217-3-sj@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 06:40:33 -0700
SJ Park <sj@kernel.org> wrote:

> damos_quota_score() can trigger division by zero if the target value is
> zero.  DAMON_LRU_SORT lets users set the target value for the hot memory
> scheme via active_mem_bp parameter.  It avoids setting it as the target
> value if the parameter value is zero.  However, it also sets the cold
> memory scheme with a target value that is calculated as '10000 -
> active_mem_bp + 2'.  Hence, if a user sets active_mem_bp 10002, the cold
> memory scheme's quota goal target value can be zero.  As a result,
> division by zero can be triggered.  Fix by returning an error when the
> user tries to start DAMON with >10000 active_mem_bp parameter value.
> 
> It makes no sense to set active_mem_bp with 10002.  It also requires
> module parameters write permission to reproduce the issue.  That said,
> the consequence is quite bad.
> 
> One reliable way to reproduce the issue is like below:
> 
>     # cd /sys/module/damon_lru_sort/parameters
>     # echo 1000 > wmarks_high
>     # echo 995 > wmarks_mid
>     # echo 0 > wmarks_low
>     # echo 10002 > active_mem_bp
>     # echo Y > enabled
>     # dmesg -w
>     [...]
>     [  597.421247] Oops: divide error: 0000 [#1] SMP NOPTI
>     [  597.428848] RIP: 0010:damos_quota_score+0x6f/0x480
> 
> This issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260801213028.5127-1-sj@kernel.org
> 
> Fixes: 40d98d31cd70 ("mm/damon/lru_sort: support active:inactive memory ratio based auto-tuning")
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/lru_sort.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 7e077084cb03a..3920d5042f109 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -233,6 +233,8 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
>  
>  	if (!active_mem_bp)
>  		return 0;
> +	if (10000 < active_mem_bp)

That is backwards...

> +		return -EINVAL;
>  	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
>  	if (!goal)
>  		return -ENOMEM;

