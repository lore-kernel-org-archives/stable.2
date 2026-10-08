Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3345FFA8
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448397; cv=none; b=JVLGjHd5tuRzqoqAfEuiZh0QV25DoHogHe1cDF/u0deY6/DITuxM+O97+Ymc/moqdhHZ1cKoOecQT6Z+whoZDtZGT8w08y9lmgCtk3Yw9HUk5Nhzju0mIm7nH9Gl7SR0je0MwezA5+UHH4mgIFO4tgJwAaqsmjK+gx2iUAYSJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448397; c=relaxed/simple;
	bh=HyGwwSVmXvhmOZPb5rYhVyPJ+UvfVubhGgu9kDF0uic=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qrFc+KFHrcbFqdLfakiZWlo1r0rt4+CInaJQUmLSr+7FE0eRGj2MMaAJhgdwLU0OSsvsaCR+unlDR71BhuIGxeyDfHDqCKmv3t1QFeODRMJ2QUgBOeklUlv7n7M+qjVwSmqoJMI0IEJiF6aR6xK3LJ6dBQTELvddZKUgtIsrfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJaTmY9Q; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJaTmY9Q"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HyGwwSVmXvhmOZPb5rYhVyPJ+UvfVubhGgu9kDF0uic=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791448393; v=1; x=1792053193;
 b=BJaTmY9Q2AcNcg0Ibm4M/yFMd0jOkbvaF9GOOHOQC2F0NG/5vtTQRpNkUTdl7umzZkowp+Zg
 saCqstM8QnCXhqR6BV3oExuPa4vjItORXe5J2PfzMk0ZL5l8xXlY7kZNQe2GdUuhgcJlYN7Wbb3
 gFKgnhcpnbQTV25OLuzBl/PM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f276eb58ea604195;
	Thu, 08 Oct 2026 08:33:13 +0000
X-Mizu-Trace-ID: f276eb58ea604195
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 1/4] x86/mm: fix missing pgtable destructor for vmemmap
 tables
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261008073021.2512665-2-songmuchun@bytedance.com>
Date: Thu, 8 Oct 2026 10:32:58 +0200
Cc: akpm@linux-foundation.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org,
 david@kernel.org,
 osalvador@suse.de,
 dave.hansen@linux.intel.com,
 luto@kernel.org,
 peterz@infradead.org,
 tglx@kernel.org,
 mingo@redhat.com,
 bp@alien8.de,
 x86@kernel.org,
 hpa@zytor.com,
 catalin.marinas@arm.com,
 will@kernel.org,
 mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org,
 pjw@kernel.org,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 alex@ghiti.fr,
 linux-riscv@lists.infradead.org,
 agordeev@linux.ibm.com,
 kevin.brodsky@arm.com,
 bjorn@rivosinc.com,
 apopple@nvidia.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECC604FF-E74D-43B1-9105-A6683EEDE558@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-2-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 8, 2026, at 09:30, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
> pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
> tables.
>=20
> HugeTLB vmemmap optimization uses pte_alloc_one_kernel() when =
splitting
> a PMD. Restoring the vmemmap backing pages does not collapse the PTE
> table, so a later memory hot-remove eventually frees that table =
through
> free_pagetable(). That path currently calls pagetable_free() directly
> without decrementing NR_PAGETABLE.
>=20
> Use PageTable() to identify constructor-backed tables and run the
> matching destructor before freeing them. Keep reserved and
> constructor-free tables on their existing paths. This also prepares
> vmemmap teardown for generic runtime allocations through the normal
> pgalloc helpers.
>=20
> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> arch/x86/mm/init_64.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 70e682180291..a3ea627157ab 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1003,6 +1003,8 @@ static void __meminit free_pagetable(struct page =
*page)
> {
> 	if (PageReserved(page))
> 		free_reserved_page(page);
> + 	else if (PageTable(page))
> + 		pagetable_dtor_free(page_ptdesc(page));

Sashiko mentioned that kernel page table pages and vmemmap pages are
freed to the buddy allocator before their parent entries are cleared
and before the TLB is flushed, creating a dangling pointer window.

That's a a real but pre-existing issue, I will not fix that in this
series.

> 	else
> 		pagetable_free(page_ptdesc(page));
> }
> --=20
> 2.54.0
>=20

