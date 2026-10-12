Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3F48D893;
	Mon, 12 Oct 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819148; cv=none; b=OlHRGfvoMoR8c9ZVmXZ3A1nNtCBFewaay0WMeAxlPGUxYEkHHgGGWo/GH5TwB5uDVNnNFUm40pDyFQx8scb6F5VCvoRZfWzQkP4+wrm99rLR6oSaYYaEN9qyEU3/Tn6GsUcAZlU2KndccBy5GEDjDLc/i33jDKJdQslujettzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819148; c=relaxed/simple;
	bh=9RalS/cTcqwsvzfIqCagLYWCk6dkc4dqFyKF+MlULZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLv8wS+XrJZAgrJQut6QB6D5toNwjh1y/g/jCH0BqnxiuX+lqliXbdnBy9nXETjMlR4maVUTXALAAGy5TzN3MH0N+CuuD76NVHdVUyAe/lv6kk+86bwV/LKmweOGG9BEdc6WXg54QBsu0s+YcO3VKeMGRrNXoWYZG5a8oqrQqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLfowVUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLfowVUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932731F0089C;
	Mon, 12 Oct 2026 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819147;
	bh=9RalS/cTcqwsvzfIqCagLYWCk6dkc4dqFyKF+MlULZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BLfowVUDFCXLcBE+jUBEJcCE17njSGG/cEAXjI9SvlCmRgJ0RrMUebOvIcBAL22BB
	 A5D1Ri6caBnDzMOyvw37AhfMKib7RzMuriZqCSELM5q15v3sxBzfQ8n7TqBMg1MALg
	 f3P+U+A9SBVHtbrlZkYfADTjPQJMACeNex5p7EwJsb/Q6fyY5ByM1kTOML9DLEjduS
	 vg1xLLhUq2LLv9TqJQ7596pdNj928fQNhattCPpvQEci98nbFuNBOI20aOTmMGRjbI
	 iabjxCy/wtzovR4naUlpBT1NouVwoL8cfFW609Er4QIxLWEecFqpPCxGaIiRJ9emGT
	 3iz/OYxGy2RzQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Dave Hansen <dave.hansen@intel.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@rivosinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, Muchun Song
 <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 2/4] riscv/mm: fix hotplug page-table destructor
 handling
In-Reply-To: <20261010112457.49485-3-songmuchun@bytedance.com>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-3-songmuchun@bytedance.com>
Date: Mon, 12 Oct 2026 17:32:15 +0200
Message-ID: <87ik37aq9s.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Muchun Song <songmuchun@bytedance.com> writes:

> RISC-V uses the same memory-hotplug teardown code for linear-map and
> vmemmap page tables. Late linear-map allocations run page-table
> constructors, while vmemmap and early allocations may not.
>
> free_pte_table() unconditionally calls pagetable_dtor(), corrupting
> NR_PAGETABLE accounting for constructor-free tables. free_pmd_table()
> avoids that for vmemmap using is_vmemmap, but mapping type is not a
> reliable proxy for constructor state. In particular, it becomes invalid
> once runtime vmemmap tables use the normal pgalloc helpers.
>
> Introduce free_pgtable_page() to select free_reserved_page() for reserved
> pages and pagetable_free() otherwise. The latter runs the destructor only
> when PageTable() is set, handling both constructor-backed and
> constructor-free tables.
>
> Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Nice!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
