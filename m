Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973777;
	b=qPRa+tqtNBOqkFIxQiaCuVNRvEUk0pvWsEE7Fpe15bjR1pta/Q4rcXGIDb1BZ56aUF3O
	 +LAklB2eWeGumviykUSGAoaZUL0taKBbXbwXjQtnDuIrrvQ7FZU8qYmKVWfrZHlTRZDlJ
	 XZJFXhNOmxsXNZK0DEZDhu3zquQDJsQYUuiIV59msT23B67XyLF2End3N14SNtv5NJxXk
	 nG7XlN5v7yhcrzJx/yvdteODR1R7ycaYhvdlHnpT22H5I01tUm2xVIgMVJmanvf973MEx
	 zqPChyrJLURNssKGuFOVCnv1Ht4yo/HGLTQ6x3n28fP+Y+wK6p5ur9z/ZlLvLQs1x9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mEgL0gkNdxC67fiPUJ6BbKjfka4sqNTfVjccvIe0kTw=;
	b=LclmDDFb3IaO1GxNiCAmQwS9szSngjP8fXcVvVYsoYm7dyR1fdK87sp7JIIy43sgiwkR
	 zNa43kg8JT6TiJV9CrSrWdl6UHK1tzb6knR82yQlPmHOzuQTsRAjRhDQ/C0fEnK21qah4
	 ahK4SLl/lMJhQl5SyxFCNnTuh+qEQFRRj1kv3zjW782I3Jz5S/0l62y5pIpqkVhCuhhAj
	 EYnD3ox90iUVlpaMHI1EfYuzJYqfiq1EBoi09UnJ1ETtYWCZnm8THcmPO0hQqCs6T43Kt
	 6dNuBS/unlNAnB/x/uv0X067BpFPBRuiKcuQs37Rq0fK8RC0nUutOodLfU0q+dyKDQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ouzDy6FP;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F5606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4F5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ouzDy6FP
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso34895e9.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793973776; x=1794578576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mEgL0gkNdxC67fiPUJ6BbKjfka4sqNTfVjccvIe0kTw=;
        b=ouzDy6FPW3tNNwKJxvAodqJrvJ12cwoBT+TJGg1nDZT6yggqkMRLFPgjHUlcLfR34M
         gm8VcADPZyBtg1lzlJC843lqSIHUbPiTpGzt0qQUhtommV73GgEcprHoKuwwPqnZAMSH
         GWd30DzkCIT5VpXYJxpZYUsAVaf/nrX84B54FRRgLsUWl6JuVashRsUrlctLhi8P7kCD
         qZ8ydjF4PNHR4lVPNfiu7fBD0+xwp8Dn4WK5FvfUO28qwMKThcb8BovmGqbB5G2SKG3s
         53UgAflV0ew9CFOX968SP4cPj94GUKaqxkBSg9NEGI4K22wRfUJIml9CbtgK5FeYrT72
         fuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973776; x=1794578576;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEgL0gkNdxC67fiPUJ6BbKjfka4sqNTfVjccvIe0kTw=;
        b=w1p4e6C4FWp9HPr6W5PQpLXfJb0sXFVOOTy7dQaK5Mt/uc0ilvDS7BeolrlzTH+Xmx
         YuS/FnD8XjOfqCbfC+10XPEoYQcbfmD29OFahFDjKK+eFJYZe1Kn8o4cLoPtqPldkDkp
         4/hDDXwyvWE0Mhph5lbjMU8sk/jCNhnsQvxJsYUw0iJDerNVdFgn1QMeg6mTMx0LNXoJ
         r0a2V5t0LK9dSKyvKk5NFpH+8x3cbiIV8ze8flkK3bg1NorODKBtHUa6O+N9FSrXVh1m
         iChCuU9rtVlLmiMT2i9rbHwzhgQtv2ezknhXuNYcqzntfyNGj6UxbT75FRyrGPcOsXwo
         5W4w==
X-Forwarded-Encrypted: i=1; AKwUvBz6g7AEfPBJYi9Fb3omkVKedQn/dz4RCBQH7eGRGRtUL7OWDIFlcVRVg++b8GrV3CM3QiAIQB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f+XsBvv7L2J5fRvTgM4+DMgMTDCK9uIG7znK5NtnZhm/jWTNk
	Eo9bGo7GuSYpyW+wBY/nKkS61p+4xwk+QgvtgU3WYr+ZQIPYojvrWzqMPVoO0v6Ukg==
X-Gm-Gg: AYBFou3eVTH/G4lDNV8MJhFZYwWUpEvzJ43Yq+/+Q8reFbAOonfmyj0J6ZGpQnaq1rS
	gjNL/4RCAprVFThtRq7qmXafT8U8CcHZAY03YnOvh/k1eo0flKdE3UeYDcbkcRDZJOwTqfZSb3e
	7/MF3bJuPf+qvXGrmVWMOOZJzSV1YTrRiaW/IyS9lfxH21SN8zUxic+4izBmuWIwWawaXxLHsUV
	IFcp+BXmWTDifbuHzhwiOjoCD+HmMY59RhKBDK667cbUmqO+J74SvC7luZx3LQC6JYBJJz9Y9E+
	+gVSHngoTeWfi0tcb5JB7HYagOfBgACvobB6H4xPvkyjbfre9iO9XiYie3x0AeEQ69hCt2ATHfG
	wtScvcymiLYtQX8UYHKQeCjLM8CBN/4fZmLiKeLWWQGE9ePCSOoD30bo/Ce8m5O3TP4AENDqMD4
	LaA32Rsmnht5Awd4ZFdASdnvbuFl4vPkvGPzMsmgEW8TnpZ9jo8mCcAYidHbx/NsdxZyRbeVqXs
	jHqU6cgwOFaqL0Xe6EPbGtVmr8PQFUWSHKEC7nxwVnKQ9xqTgk/WLp+OZIdFn0FdSLJSLUgqhxM
	YIv25okmMZzDQ9jynyG0ch58Q/IFjwP0haZ0jWLdjUJhDFA=
X-Received: by 2002:a05:600c:8a17:10b0:4aa:7270:60f with SMTP id 5b1f17b1804b1-4b743f9f46fmr464815e9.1.1793973775119;
        Fri, 06 Nov 2026 06:02:55 -0800 (PST)
Received: from google.com ([35.189.193.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d609b1sm3724515f8f.8.2026.11.06.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:02:54 -0800 (PST)
Date: Fri, 6 Nov 2026 14:02:40 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: xuheng@cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: arm64: Compute hyp early-allocation and pool
 sizes in 64 bits
Message-ID: <au3eALuLVKZ1WXhp@google.com>
References: <20261105-hyp-pool-and-map-v2-0-44a6ca90190b@cs.columbia.edu>
 <20261105-hyp-pool-and-map-v2-1-44a6ca90190b@cs.columbia.edu>
 <CA+EHjTxXpA6sCrSmwRJBA=YKGfNP4zs-THhheRHTaq2BfYY-Lw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxXpA6sCrSmwRJBA=YKGfNP4zs-THhheRHTaq2BfYY-Lw@mail.gmail.com>

On Fri, Nov 06, 2026 at 11:31:57AM +0000, Fuad Tabba wrote:
> Hi Xuheng,
> 
> On Thu, 05 Nov 2026 22:59:48 +0000, Xuheng Li <xuheng@cs.columbia.edu> wrote:
> > hyp_early_alloc_contig() and hyp_pool_init() both take a page count as
> > an unsigned int and compute the size in bytes as nr_pages << PAGE_SHIFT
> > in 32 bits.  For 4 GiB or more (nr_pages >= 2^20 with 4 KiB pages) the
> > shift overflows.
> 
> Mostafa (Cc'd) posted a fix for the same truncation in July [1],
> widening the parameters to unsigned long instead. Would you be OK
> picking up his patch for v3, keeping him as the author and your
> description and tags?
> 

I was preparing v3 anyway, I can post it today.

Thanks,
Mostafa

> > Two of the regions that pKVM carves out at boot are sized from the
> > amount of memory: hyp_s1_pgtable_pages() for the hyp page tables (hpool)
> > and host_s2_pgtable_pages() for the host stage-2 pool both provision
> > page-granular tables for all of memory, about one page per 2 MiB of
> > RAM, so they reach 4 GiB on a machine with about 2 TiB of RAM.  Arm
> > systems of that size exist, for example AWS Graviton4 x8g.metal-48xl
> > instances (3 TiB) and Ampere Altra Max servers (up to 4 TiB per
> > socket).
> 
> Could you also list the hyp vmemmap here? It's sized the same way and
> overflows at 2 TiB too.
> 
> > On such a machine, divide_memory_pool() gets a truncated hyp page-table
> > region from hyp_early_alloc_contig(), so the host stage-2 region and the
> > FF-A proxy pages that follow it start inside the range that hpool will
> > own.  hyp_pool_init() then attaches all nr_pages pages of each pool to
> > its free lists, so hpool and host_s2_pool share pages and the same page
> > can be handed out twice, for example as a hyp stage-1 table and as a
> > host stage-2 table.  hyp_pool_init() also derives range_end and
> > max_order from the truncated size, so most of each pool is treated as
> > external order-0 pages; on a host whose IPA size makes the host stage-2
> > PGD a multi-page allocation (for example a 42-bit PARange), that
> > allocation fails and host_s2_zalloc_pages_exact() uses the NULL result.
> 
> Could you describe here what actually happens? I think pKVM init fails
> before any page is handed out twice. Just below 2 TiB, hyp_pool_init()
> for host_s2_pool hits the BUG_ON() in hyp_set_page_refcounted() on
> hpool's page-table pages, and from 2 TiB up hyp_back_vmemmap() zeroes
> the new hyp page tables while they're being built.
> 
> Cheers,
> /fuad
> 
> [1] https://lore.kernel.org/all/20260715150125.2798116-1-smostafa@google.com/
