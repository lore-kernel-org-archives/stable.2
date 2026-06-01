Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71396343880;
	Mon,  1 Jun 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302994; cv=none; b=sSVkanNvlTk3K0eZ5XM0wEpsBKD1xJhirb1jg9c8zD133pLz6dATxlJW7/hsmfevlTiJdWIEnjiaW6uDJriD4WtN8suyyYBAycw/ARssjVuLfFIn/USeW2jc+3gRXu7M4dAK62cGgamNvzXlAqUI/cNbD70y2JFFr0XJ70Lei6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302994; c=relaxed/simple;
	bh=TPL6+rsKbNhPyrQQTQEjlwSh9kLDLG0Y6sGr+rFpXhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igA+kamkHYKnvJS8CtlC8MhIujgp0cCrTbl2HnEYsXjE8t6NhphLrXLtzrT8yFvZ3uihl7ynlO0+Nav5Bv+i3aWQTuYT2D7GZenWlnwBIor8gdcf/rcURb52W8H0IKUzEPLZTkiZcyoO98VC3t4uioxwcy+mn2JBWP3aanl7law=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awl2Qklw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awl2Qklw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257101F00893;
	Mon,  1 Jun 2026 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302993;
	bh=CX5wVcPdVJkxD/ZKWZzIB+4vPMQ2papSJP/qE9C6oOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Awl2QklwSbEIG3Ymmd/OBdnI2yrmd9PK72eTuZp3LX9nHwhVMIzRzLGFQk6SZ1o2S
	 ncZ3w9g4e2iUbkhDsSSkC3ALcDImuEI+dTTHJiQ21HFQ5JOaKtp/167LjQSweZrhXt
	 UYrjXTkkR6ZddsE3MksHgsRv+AyJaPky0bR5MG7NrjVIrWDCyj/KOSmG3ipFJasuHg
	 zXjPhmaxA13c4/fa5npvcWvQvK3Y5inlaUNG6iv9SzD2AJzY4QMABYBi2qLdT3xt96
	 f8+vJvJ4yVZnu5Q+5NTA/ehtvPidzGijaJURJI7eSKw5rVl88J8pWiygMLPMcX4EpZ
	 GNpxzWpy33NMQ==
Date: Mon, 1 Jun 2026 09:36:25 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, jgg@ziepe.ca, 
	leon@kernel.org, david@kernel.org, shuah@kernel.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, balbirs@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-kselftest@vger.kernel.org, 
	usama.arif@linux.dev, ryan.roberts@arm.com, anshuman.khandual@arm.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs/proc/task_mmu: do not warn on seeing
 non-migration pmd entry
Message-ID: <ah1EZHWhO077k7tG@lucifer>
References: <20260530085413.1270139-1-dev.jain@arm.com>
 <20260530085413.1270139-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530085413.1270139-2-dev.jain@arm.com>

On Sat, May 30, 2026 at 08:54:11AM +0000, Dev Jain wrote:
> pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
> entry. This became false once device-private entries at the PMD level were
> added.
>
> Therefore, remove the stale migration-only assertion.
>
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

I also verified that I could trigger this locally with your test, so feel free
to add:

Tested-by: Lorenzo Stoakes <ljs@kernel.org>

Cheers, Lorenzo

> ---
>  fs/proc/task_mmu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 1e3a15bf46f4e..58938e62154d9 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
>  			flags |= PM_SOFT_DIRTY;
>  		if (pmd_swp_uffd_wp(pmd))
>  			flags |= PM_UFFD_WP;
> -		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
>  		page = softleaf_to_page(entry);
>  	}
>
> --
> 2.43.0
>
