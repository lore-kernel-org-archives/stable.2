Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63F402429;
	Fri,  9 Oct 2026 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526176; cv=none; b=PSFTfcPjjI8CtdEdoicixAFwQdxvBEYg5Ra4gLwntRxw2iFfreDaD0XghFnjp7X0crIVDGqP8SRdQkU6WZIsOKqMgCWjn50RuF34NKPeJ7n4uThFo1kCCEGa/7ihQs8oylS2a3m6lg0OKFL8oah4FQHiCzWIk3guFLMhsqt/twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526176; c=relaxed/simple;
	bh=NOFneBJpQBjYpGhResFHfedaCbPc66X6xO0MyX1Ee34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+W2k+lxVMTTNg6fdh8WKQKkwRIzWNCfhQ0PC15+BFa64kcBNH0MciiSGn1474zCHf3iALZ554qfklENGYae3iAJos3/Vn7O7mJu89pJGfCLpgWtALVuVECcrJ9qjoEvzQc+u3fxq/SiB0HeDHdF0mdMa1KmqrqGSVWdFnD9nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWkN5Krl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWkN5Krl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7FE1F000FF;
	Fri,  9 Oct 2026 06:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526175;
	bh=HaXEEt+6oUYTgk3yLziOOP26vbiRye4IPhhc+D5Un/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HWkN5KrlKIk6OWt38SO9fMGwArGXNLm8Sc0PCX7ZgeMYOylWuJpHNU8t2FYDltQLn
	 2hKVTP6VzNHCqHXVINEqZTs/LUesNwkJVsuSfNVRWiSG6EM+asdu7XUYpBPEPDbhyg
	 xxL2L457nAJjsnW9ul382bkmFZlkcJ0BfutYNMatFDZqAAKt4pPj7uICuTiy4ojVEP
	 ugz5q4KFQCUm7kDaKATbRD/9S7WIDuKfPfrxc0hLnTMVOL+lI7sBSP7t1MeAxfaysa
	 lqZ9eoh+QQZamGuMRiYovi7Gku403d6K2cuOnrn5lClA+St/Yv/3lziXSu4nT82KA4
	 ZsIxQ2m9QprXw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, david@kernel.org,
 osalvador@suse.de, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, agordeev@linux.ibm.com,
 kevin.brodsky@arm.com, bjorn@rivosinc.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH 2/4] riscv/mm: fix hotplug page-table destructor handling
In-Reply-To: <20261008073021.2512665-3-songmuchun@bytedance.com>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-3-songmuchun@bytedance.com>
Date: Fri, 09 Oct 2026 08:09:31 +0200
Message-ID: <87jynrs8v8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Muchun Song <songmuchun@bytedance.com> writes:

> RISC-V uses the same memory-hotplug teardown code for the linear map and
> vmemmap, although their page-table pages are not always allocated in the
> same way. Late linear-map allocations run page-table constructors, while
> vmemmap and early allocations may provide constructor-free pages.
>
> The PTE path unconditionally runs the destructor, which is wrong for
> constructor-free vmemmap tables. The PMD path avoids that problem by
> using is_vmemmap as a proxy for constructor state, but that assumption
> will no longer hold once runtime vmemmap allocations use the normal
> pgalloc helpers.
>
> Page-table constructors record their state in PG_table. Centralize
> page-table freeing and use PageTable() to decide whether the destructor
> is required. Keep reserved and constructor-free pages on their existing
> freeing paths.
>
> Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/riscv/mm/init.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 857f9a55039c..429a0b015ec1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1486,10 +1486,19 @@ struct execmem_info __init *execmem_arch_setup(vo=
id)
>  #endif /* CONFIG_EXECMEM */
>=20=20
>  #ifdef CONFIG_MEMORY_HOTPLUG
> +static void __meminit free_pagetable(struct page *page)
> +{
> +	if (PageReserved(page))
> +		free_reserved_page(page);
> +	else if (PageTable(page))
> +		pagetable_dtor_free(page_ptdesc(page));
> +	else
> +		pagetable_free(page_ptdesc(page));
> +}

Is PageReserved() enought to determine if there's no dtor to run? On
rv64 your code is correct, but maybe for robustness?

  | if (PageTable(page))
  |         pagetable_dtor(page_ptdesc(page));
  |=20
  | if (PageReserved(page))
  |         free_reserved_page(page);
  | else
  |         pagetable_free(page_ptdesc(page));


Bj=C3=B6rn
