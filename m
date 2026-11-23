Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454382;
	b=DxMdMSPhuszX0g8kKQ7aJifEknLJhomUrh24YWH2kNuZ8KIEDSHdibsbEmfoo8CeG5d8
	 UGpB4SaJd6HMd0+o+kmkXWn30lqStM6cwIMhU1Se0sHqM5PK2tRMC1AbgPkL47s8gxDAy
	 XF8FGt0Vsk8git4OBKbG5JuS0Qt02WWXW1Wu2UyRxw/WN/oTlZEW7W9yPNwgVoH+W02Hh
	 zHJyu1L1KmnXJJZiyqAxnHVqXsjBi+IdFx0bUUUct2N67xR55deyih71AlTDbAHwKE9FV
	 2UrCF0/q9PWsLUy8f8eSYR/4n6wqtm3qgg10yMOyRuBVCrkM/31oEB4U+08MkuofZWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454382;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+FrBWwyWG2ofrr4+eX/hR4EQoleVZwLseOTkT4V6vlI=;
	b=3vhUMx0w1ek6O3MqR9SL77wL54zt3NqES3KudcICUtNXB5hsDsl7bgsla6IVeWV8RtYY
	 t3WuC3utdsceDNZ5ZzkJIOI+CgpJ2iRM0P8GB9f38N0FHrO3F8DuSNbTWpE4f5kC2pcHo
	 7fHm9ib4vEoF+T4k5wnp1OW7MS8zXwmIkEGPMJkf9aKQBjNjfeqon1IyY1JD8y8NgJAwg
	 Td6+tVMyAJhzMCmuC42ub3zC5aYSNmFAng3wPnVZMu0iPMHQS+dP4T11CcG20ZYA9aBBn
	 jJM2t7Tr/29pyjWLDSRmtHKBZozg67QNQAModtA3/UAGQ6IexSbmlTinrxnq+dFCttA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIwVVeNh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2A606A31F;
	Mon, 23 Nov 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIwVVeNh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E81F000ED;
	Mon, 23 Nov 2026 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454382;
	bh=+FrBWwyWG2ofrr4+eX/hR4EQoleVZwLseOTkT4V6vlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VIwVVeNhymyUQbQGqVW+YvmnbRNxn3o3mDgtXy2kVL1odzz+6vHr3rCL+goN9oazP
	 xs4kvt2oTdgnqOqWqY2FkW723eDXl7qikinE6Guq8722FcmwaCF694l4SS7R8+2noh
	 q+/8zFyWiI2pvGhVQgvCkQbVkvchKaeDHtHSIDkHR1oJoamLhwGxZrgnkHc7gN1h+s
	 Uf5LnSW5vBIv369w4YmF2j1ZX139ZyOivzs34UdGX/m2OgpEVzFjG1CtHzEmx0/jk/
	 FtuVbXaTY9r4923X4trQ7gXKaLBoalcTruyuAbtUUJZ7nyBctAuwnWwx14gN37jWiC
	 A47d6bJ5Vs09Q==
Date: Mon, 23 Nov 2026 17:19:30 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm/migrate_device: avoid leaking folio references
 during THP splitting
Message-ID: <awR1nOpAuZ48BXFk@gremlin>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
 <20261123163301.1568240-2-usama.arif@linux.dev>
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
In-Reply-To: <20261123163301.1568240-2-usama.arif@linux.dev>

On Mon, Nov 23, 2026 at 08:32:07AM -0800, Usama Arif wrote:
> migrate_vma_split_unmapped_folio() takes an extra folio reference because
> split_huge_pmd_address(..., true) drops one when it splits a PMD.
>
> However, migrate_vma only holds mmap_lock for reading. A concurrent
> MADV_DONTNEED can clear the migration PMD, or split it into PTE migration
> entries, before the split helper takes the PMD lock. The helper then does
> nothing and leaves the extra reference behind. folio_split_unmapped()
> fails with -EAGAIN due to the unexpected reference, and the reference is
> never dropped, so the source THP is leaked.
>
> If a THP is faulted in at the same address inside that window it is
> worse: freeze = true replaces the new folio's mappings with migration
> entries that nothing will ever remove, and drops a reference the caller
> never took.
>
> An existing migration PMD is expanded into PTE migration entries even
> with freeze = false. Use that mode and remove the extra folio_get(). The
> reference already held by migration keeps the source folio alive whether
> or not its PMD migration entry still exists.
>
> Reported-by: Zi Yan <ziy@nvidia.com>
> Closes: https://lore.kernel.org/all/DLZ48KMS7YG8.3BTM0UUU8CTU2@nvidia.com/
> Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/migrate_device.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 9e19fadfa65c67..3286bb8a4b73ee 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -920,12 +920,7 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>  	unsigned long flags;
>  	int ret = 0;
>
> -	/*
> -	 * take a reference, since split_huge_pmd_address() with freeze = true
> -	 * drops a reference at the end.
> -	 */
> -	folio_get(folio);
> -	split_huge_pmd_address(migrate->vma, addr, true);
> +	split_huge_pmd_address(migrate->vma, addr, false);
>  	ret = folio_split_unmapped(folio, 0);
>  	if (ret)
>  		return ret;
> --
> 2.53.1-Meta
>

--
Cheers, Lorenzo
