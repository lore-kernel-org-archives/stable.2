Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964762;
	b=NF/Z8nBVoKhdJl2UwEGxJO3hsyFjOZ2lT00/jDbBXB3jGV5vXDO0ITG5gqqt8y0TgN6n
	 9BIgJlWnEzoHca56JX1gTt3Azj4hW/YxPRcwwI9KaxCQgSPics9I2um0MqJVsdE5Pq1yM
	 Dz4mhCP2GU9uOWrKFg2F7DIGBYIbBtSp/m5D1+fCbpQuSZM5daT+700Ejsb5YbHrQnMiP
	 slDuZkUTsNQzi3U8XOfHMk208mYKO30C2yv4TUQulTLkiK3hLdxmqfZ9m2Glo1BiNLWhh
	 uKZG7y4W7WS8PrL2Ab7/MGYyK/Uv9xae0il9uUv0U0hAsjsQOdlcxVCTa5PiBrveT4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964762;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=VwYktvc9ZuSAG/AWyoWRNsgxr2Z6jBVkd5OucG0+82I=;
	b=z35d0EBcWmv99xz+uWreh9OwaWMLeVqWHnegGGPiBffbJs4OCzDusz8DSXB671dBliiT
	 x9MKL61cjq5yyAm1GMKjpIT7/Nd/aG0k4dI3DJvdW06TComlzH6WjRjhnc+HYWr6mT0kb
	 EfT5rU+4FQ0BkNDO16VO5u+SwfSI9UknVWfMfsFTinD2s2IvyeNdJtK4F1JMD4v+odmkw
	 sVkaPOUrJ9rEKIX0owejYmCZBjQus+L1IpwFJhaGu7r1XsXn4dhis2PklV+Blb0xzSQxl
	 DnSrlzXhhYStc2V/M13xZioIi7zrngAQ9V11RgxGmAS25JWAI9TNfXwtrWNyn+N+9rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DoMeES90;
	arc=none smtp.remote-ip=95.215.58.38
Received: from mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005B606D81A
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A005B606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DoMeES90
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zs6GksGR9IOQ4D/rhKg8wscXt05dWTxmDSpfW/B3uBQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793964759; v=1; x=1794569559;
 b=DoMeES90T0KlvlofMfpO9JNvNCzwOeQ0XHGUPM64HvNAFrnyzeKp230bcGHxKp1R1HWdswxY
 +W/sVH5WITNWHz53R71MB0OO8asJf3GuNXs79JtwYQuE8Dp1dmfTensk10ECTc9xVTFZF6kOtnD
 pGnE+NpjPuFzPZjL4otVq1kU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 798429e814f04345;
	Fri, 06 Nov 2026 11:32:39 +0000
X-Mizu-Trace-ID: 798429e814f04345
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfca2a2af4so2785e87.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:32:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw7+nzWZTTvflvW9nvyTk1fgPrAqN9hKrLeH3apLzGbUhjWuS/sqQnRz+pQf3fRSPkjm9W26kQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z98uhyuIs+jgadzRN3xI7V+tGyVZ4w7nxtA2CzMlsuTR9CDh4mI
	uagEgWwxhPtIXMtF9KQc40+Vgk5fKhcdKmAgZbk3zM5ze2HJXdJ6cSKwkPhuVqBqYwQUD73QA2E
	JFqw6QOBgwZ68loe/AQPwbnTc23uFCMZkniUDE4Fe
X-Received: by 2002:a05:6512:3c84:b0:5c0:1b9:2de8 with SMTP id
 2adb3069b0e04-5c006378923mr59625e87.0.1793964754169; Fri, 06 Nov 2026
 03:32:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-hyp-pool-and-map-v2-0-44a6ca90190b@cs.columbia.edu> <20261105-hyp-pool-and-map-v2-1-44a6ca90190b@cs.columbia.edu>
In-Reply-To: <20261105-hyp-pool-and-map-v2-1-44a6ca90190b@cs.columbia.edu>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 6 Nov 2026 11:31:57 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxXpA6sCrSmwRJBA=YKGfNP4zs-THhheRHTaq2BfYY-Lw@mail.gmail.com>
X-Gm-Features: AclHuK9gc8zZSVttdzXS2GHVj1w7PkDDqC-dBzIEQ_RXvW813sjnQFEQOIIR5dE
Message-ID: <CA+EHjTxXpA6sCrSmwRJBA=YKGfNP4zs-THhheRHTaq2BfYY-Lw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: arm64: Compute hyp early-allocation and pool
 sizes in 64 bits
To: xuheng@cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Xuheng,

On Thu, 05 Nov 2026 22:59:48 +0000, Xuheng Li <xuheng@cs.columbia.edu> wrote:
> hyp_early_alloc_contig() and hyp_pool_init() both take a page count as
> an unsigned int and compute the size in bytes as nr_pages << PAGE_SHIFT
> in 32 bits.  For 4 GiB or more (nr_pages >= 2^20 with 4 KiB pages) the
> shift overflows.

Mostafa (Cc'd) posted a fix for the same truncation in July [1],
widening the parameters to unsigned long instead. Would you be OK
picking up his patch for v3, keeping him as the author and your
description and tags?

> Two of the regions that pKVM carves out at boot are sized from the
> amount of memory: hyp_s1_pgtable_pages() for the hyp page tables (hpool)
> and host_s2_pgtable_pages() for the host stage-2 pool both provision
> page-granular tables for all of memory, about one page per 2 MiB of
> RAM, so they reach 4 GiB on a machine with about 2 TiB of RAM.  Arm
> systems of that size exist, for example AWS Graviton4 x8g.metal-48xl
> instances (3 TiB) and Ampere Altra Max servers (up to 4 TiB per
> socket).

Could you also list the hyp vmemmap here? It's sized the same way and
overflows at 2 TiB too.

> On such a machine, divide_memory_pool() gets a truncated hyp page-table
> region from hyp_early_alloc_contig(), so the host stage-2 region and the
> FF-A proxy pages that follow it start inside the range that hpool will
> own.  hyp_pool_init() then attaches all nr_pages pages of each pool to
> its free lists, so hpool and host_s2_pool share pages and the same page
> can be handed out twice, for example as a hyp stage-1 table and as a
> host stage-2 table.  hyp_pool_init() also derives range_end and
> max_order from the truncated size, so most of each pool is treated as
> external order-0 pages; on a host whose IPA size makes the host stage-2
> PGD a multi-page allocation (for example a 42-bit PARange), that
> allocation fails and host_s2_zalloc_pages_exact() uses the NULL result.

Could you describe here what actually happens? I think pKVM init fails
before any page is handed out twice. Just below 2 TiB, hyp_pool_init()
for host_s2_pool hits the BUG_ON() in hyp_set_page_refcounted() on
hpool's page-table pages, and from 2 TiB up hyp_back_vmemmap() zeroes
the new hyp page tables while they're being built.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260715150125.2798116-1-smostafa@google.com/
