Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794623883;
	b=OlfA6L4w3lEBMyUurrb4qX5yiKGL/7d5UtEMCOFfAo49gAIPwROcg02CUH4vsiDp1SdF
	 qePTvohpdYWSl/Fy0eZeq8PYthfxEbY1TP+q+pWZwnDHwahygvJviAje8XBwmB5HhQ4Qq
	 k51qGrsrv9h3wy2/CR/wH5eOeaNa+qEHsWS5lvH5hpGwEUXWSMP1k0uZn8vcNBo0UYAuE
	 ayWcaOKQ8AAwjnDO3ydu42BLkMGkwz7nfDYcNvrGfT0E4UUkTnPy5oE2++QxYHwRzecfO
	 t9n1bZH7nFYwsGAMWsZfYXdf+pn2rQ/IiC59ZLy4CGNFZbDG4v4z/nvpYC1rM1b/G2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623883;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=Fr+/kMFmCLsGicg9T6i0NCPKmoj+tnWS7HQ+lz/d99c=;
	b=PyCBD+r+x2a0nlY37XsmAK4jZOgp6MVMPbsD9zsFkmFI6x446/tHPWZN24u6AZDZ77uT
	 0eDRn0kCvglchl7PRpb3G/4PeodcLp1BCHr9rePBXWTV2QRlXCFOIt7ex39nDv1w4WcgI
	 +cBTckM/5AZi4mZ5GpTwMIFxrIrRyU59QXQ6eS73lgDo3PEtR5SVViLCc1+RMvwVDu5ju
	 vZu8LRo9Bz2hCNvo8vcoprJ8LvE4M5ax07TP5YxdlR80ZURm8xP8yN45j8yvH1/JeMCEB
	 ndsIXx//ORPLfdvaPtv2yCdAkKKQsMz8QvJF1eAaDbgA+FUBmAi00zp3riu4TEV+8ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lYS9V1pB;
	arc=none smtp.remote-ip=95.215.58.22
Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4711606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 02:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4711606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lYS9V1pB
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LhWKw0hIjCAzkLgAvL9lXHI28yxzDvFvC+TmaniYtwk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794623879; v=1; x=1795228679;
 b=lYS9V1pBgRBdEL86Jb0hDCWN+xlxZHDRoQM5lC/+u9DSSJLBi5tsKmfTT4GGn4kfenE0Pu/o
 avTDRINzxymWiJnK0a8CdG6rdPiVhy1/pHBnFo02P23dEaI8WchVhHH7zyY/pbTrhAS6OPJnZi6
 Ag35eZsQ0eJFQLFXOFnHQnUM=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 9baa0a0f2146f049;
	Sat, 14 Nov 2026 02:37:59 +0000
X-Mizu-Trace-ID: 9baa0a0f2146f049
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages
 with PMDs
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261030115326.1005755-1-songmuchun@bytedance.com>
Date: Sat, 14 Nov 2026 10:37:38 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Pavithra <pavrampu@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEAC0390-4347-401E-BB52-9D9BA3E93FDE@linux.dev>
References: <20261030115326.1005755-1-songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Oct 30, 2026, at 19:53, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> PowerPC radix vmemmap population can reuse an existing PMD mapping for
> a device DAX range marked HVO-enabled. The reused mapping is ordinary:
> its tail struct pages are not remapped to the shared tail page.
>=20
> Leaving the section marked HVO-enabled makes memmap_init_zone_device()
> treat the range as optimized and skip initializing real tail struct =
pages
> that remain in use. This first triggers a zone mismatch warning, then
> faults while initializing the pageblock flags:
>=20
>  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>  Call Trace:
>    memmap_init_zone_device+0x164/0x430
>    memremap_pages+0x43c/0x93c
>    devm_memremap_pages+0x3c/0xa4
>    dev_dax_probe+0x264/0x3d0
>    dax_bus_probe+0x140/0x1c8
>=20
>  BUG: Kernel NULL pointer dereference on read at 0x00001400
>    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>    memmap_init_zone_device+0x358/0x430
>=20
> Without these diagnostics, the uninitialized metadata remains latent =
until
> userspace accesses the device DAX range and triggers a later panic.
>=20
> Mark the section non-HVO when reusing a PMD mapping so its state =
matches
> the actual vmemmap layout and core ZONE_DEVICE code initializes all =
real
> struct pages.
>=20
> The Fixes target predates the section-based vmemmap optimization
> infrastructure, so this patch cannot be applied directly to some older
> kernels. Older kernels instead need to pass the vmemmap bounds to a
> range-aware vmemmap_can_optimize() and reject optimization on PowerPC =
if
> a PMD leaf overlaps the range. This reuses the existing mapping =
normally
> and makes core ZONE_DEVICE code initialize all real tail entries.
>=20
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap =
optimization for radix")
> Cc: <stable@vger.kernel.org> # see patch description, needs a =
different fix for <=3D 7.3
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Closes: =
https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070=
429.git.ritesh.list@gmail.com
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>

Hi Andrew,

Could you pick up this?

Thanks,
Muchun


