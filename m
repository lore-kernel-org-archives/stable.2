Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51412266565
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787543580; cv=none; b=qEAfpmYQZC/NryiflQh1auxlt6ACnlNy5pOfJ00Gy7dbG50kZSr3Dotczv7DZ/faWKkKBb9Ta5A8gf23zqFa+prEl/8zwviMquT9Hw6i4p0FOydjh6d83ZmCE4xOq9O0UPZqMnms+NuL2LZVOLakCeHCWDleMNNUS2NeDlm6KoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787543580; c=relaxed/simple;
	bh=xvaI6+hkPF5cHXFpF6ukM7uyine27oFBWDmOdEm5K2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUn6piYdBe4BoanagfRM4l8Eg+7KdkMu5I5WFXRQITMsiUUP1KIlr4yJtqjw+3wFLVZM2JcCZJr6L1mHfWejheUK4oPV5SZ/X5fKS7WhUFrO/qtj0rmG/fyUATfMjXPb+5RUr0ftjpHfZ01YRIGM0YSdKy+PypggVM2we2mWP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J8gfm+vJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J8gfm+vJ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9063b380982so35023546d6.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 20:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787543578; x=1788148378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+NkwZvgRmwHRjzupt0N+f3fvk1vj4jZO7Q0jmTyKYe8=;
        b=J8gfm+vJKT+dZuN+5PsuqYvrhEJ+EiNGI5OKnQZV9hjUZlub1FgYZq8JPoWnT9KN7C
         hv7ad5qKV9G/ik0oMaQQycLawlByV2HMa/LVjWXXjUGnmiXL/IZbeLGYqpmd7zoNMvsq
         +sJ1wn87Dcib/6zPNvRbcVJ/moyEO2FPu0LpoHPRM1/s91tRqB1olFnc203DKZMYDTxW
         q/F5+Vf4Kuyl3hhINOnPWG/Q+Z2w7iAZj7KasF0WmZjfWLfPgh9+mdY8F9OKXXVdf7u6
         J5mWp+NXWg1d9mXt9ZnMeHcL37YOdhZYcfyQwK1I+RW4Kkl7HZHUiAqJZBhnuyV4jJIE
         n+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787543578; x=1788148378;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NkwZvgRmwHRjzupt0N+f3fvk1vj4jZO7Q0jmTyKYe8=;
        b=IWr6XuxJmphYgmx13EC1iZUFRoCwhydSeOScFLuI20sOvOjLTTYnQTCPMmU5SsSf4w
         K/VAHV6VYk3vBtaPwbavg9NoL/oNx71XusG5WjOSkmhANtTWs7TXY5244dV28Esto9GY
         4ZExY+xVfT0/Ssfbaxy71tlOJqXP+1fnjU6DA3+JjeFbp/f0X+tJbgxtC+hwHDO6e90s
         UsQN+6gdAZ6pZjbyW9RuUGOQyTiWoT+rgLjNa7ylUlJA+H0jQmM+w3a3Zr1bDyN5yNko
         qqdNg4Xq1qkqkaCkl1jsK8wgGC+rc6EKIrznUs0Dvdlk5XvEIv8zlDWGDAFNN6YslJSu
         Ctnw==
X-Forwarded-Encrypted: i=1; AHgh+RpvZAj+zURsJttmKEuHo2NduCud3vok83eJtYqk6YvnE4FPzruBzOw3DaGhH8E1uFJo9/VsJV8=@vger.kernel.org
X-Gm-Message-State: AFuF++kdFw43L7MxMt4DyBPrkyIUC729G26yIgz9EdgObY/TOz+E0xjk
	M396QStT+EKiPMFfgh5boXmMMN1D7Enz55L57mHycIjBn17LPKKowu3cMi0Fh/0xr2U=
X-Gm-Gg: AR+sD12mP1nz3ngFtXnzF9xZZe5OTTFKIgq7Tm+atN5WHPFc0ONdCleiW2Qa4q6D99q
	yXL7L+6+p/+mq0XctQtCUPKJHBNTCqTXLJlFRLt+kfGUy8AZA8WNmd44fF4V6kjOJYf5BqfiaUw
	KpjLk32msf5BuzYz/HY9lHuwihw7b0Y07kP5rRhs2+AcQPxl594o2A5Vbiw2iOQbOPGBDfY9GFZ
	/uFlr+8a57lK60+1BfAaqrlhcTPyIhpChZ+ggI0mGFngXTVziXNFEx76Hn2RqlebrIPhlgv0AdP
	/y3psunGi+aUYN27VuMFnrKKz30wxQaQACafKjM5JC6cDo6Tw/G02CDQuXw1gmbe9zerfmWMO/g
	3mI6AmzvllB8pBWdHlCOp/iCKvzH4c2+0PZz+mNJ115Uf87EsmDuzau0hBKnDCcgatT6Ui0bUJe
	fiW6+BbWTysevyVsYno88/eYjUeFTBT9/f6x7mE1GfToDfNlrswI9L6RPjIS5U0BgJJT+Iere5F
	5vzpVLGqCT0ngFRXkDPskRaMaXcLlirneqj5IadwVMC
X-Received: by 2002:a05:6214:860a:b0:907:d89f:f9ce with SMTP id 6a1803df08f44-90c8f95710cmr155411406d6.12.1787543578189;
        Sun, 23 Aug 2026 20:52:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c9393203asm51021056d6.23.2026.08.23.20.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:52:57 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:52:55 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, edumazet@google.com, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, syzbot+0dbf6d295b3350944f0b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mempolicy: refcount the weighted interleave state
 instead of copying it
Message-ID: <aou9WUf2qU8UewL7@gourry-fedora-PF4VCD3F>
References: <20260821104043.f692421fec915c0c5bc1fbe6@linux-foundation.org>
 <20260824024117.1755899-1-gourry@gourry.net>
 <aou1Gwxk2s8Qjdm9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aou1Gwxk2s8Qjdm9@casper.infradead.org>

On Mon, Aug 24, 2026 at 04:06:03AM +0100, Matthew Wilcox wrote:
> On Sun, Aug 23, 2026 at 10:41:17PM -0400, Gregory Price wrote:
> 
> Bit of a shame to take/put a refcount on every memory allocation.  That
> seems like it might hurt (even being on a different cacheline).  Would
> it make more sense to use SRCU for this?

Bulk allocation - from some measurements it's about once per 100-pages
on average.  Looking back at the data I was getting about 41 refs per
4096 pages (16MB chunks).

Have to imagine there's other cache fighting in that stack too. 

I'm less familiar with the rules around SRCU so i shied away from it,
but I will take a look.

~Gregory
