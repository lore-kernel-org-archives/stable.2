Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403849;
	b=S9gc51IC9YiPPADaZ5benGn8Y/VXUu2fS+X5+mkGCt/FHyRXciL5fPQRZ/M9MK6Sl360
	 RZy8POlmTv88L4YBVisBCNNJ9Ne6DrBDXr2fxG3BuZKMhsM0+D6ETdaMeqtbwGLjQ4nRy
	 rIgpp1jgD6cMMLj/xlfRaiZxBAIlPLT60lEn6ZHXSx+hfXlVhSQX66hGt6BOy0A2JPjSM
	 ok5QkJ0dkXWkuUcUWDKTSSImx7o6SX6rAXCk/OA4Lu49iIhi5TyPPgW52XWNUGdayvFMJ
	 ETHpfhDMabLo8RfSdOpOiBJgg2CaLPNN3AQbxJZMrb4OjeBkD2i4pkLv4xbN8hZm1yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+z/sJOVgAS28x/o3MBGl9WUjLHrIvvzM3O5rOwm04js=;
	b=SMKwhk2FTyLVAO4xgqvdTjhH1DQgIVEMKQVeUQhhwXsxCNMtyPZGzNvGLzVRIWge7clv
	 tBwzOHM+0GqLinfP5QbmvY3fj4ag8ZSu/OZLhofbi3GRrLShIuEzFSDxSxjlCTSkNVc8Z
	 49oinpNU2miwMjiD89U2h7kSktS08/CEQ6anG10eI1gzm0O8EDISdXy7V/mcwKdUoKZzw
	 BPVoAotGRWUlv8GpaZDWP61knQz5454/fOuQHygxh/v/CpUd/37eQgT1ycdubeUJeNz44
	 DfpKYaNFC7ZUZic085aKw/lEPjmQlZPxEYpvQM6htqEbRECSM2KOHHL+thdN0w11eMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCOOE1SS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A68606A32D;
	Wed, 11 Nov 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCOOE1SS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239EB1F00A05;
	Wed, 11 Nov 2026 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403848;
	bh=+z/sJOVgAS28x/o3MBGl9WUjLHrIvvzM3O5rOwm04js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TCOOE1SSD10QWz6ETDZQQa8vMzC3OQf7QgzVHTot3DF2mHh3BGpH6oizahN+4xoIw
	 V3tUDGYYwfQVsmabwgFAkaDuZDnkhRAzjvVniXDXC3kgP/C7x4a0UowHWVHTmh4elc
	 AprsIFNdFLJQcHPmZWalSfBqHNk4MvhSfNt4SVagQIekeLaWQy5pCgDAj7UMrU20Zu
	 D3Uik2dp3cyRA39clPl+3cwOHuo3mg24zpfiZA9hCPtZfRLRbkFMFYgHLBhHzPK50r
	 8h7ykUxGXare4jcYCCOclmSEYI00dG8SFkpKA6pvK5xfrRa5Voib2AyqIlrEpk9+7c
	 gkx+KmeMqrh+g==
Date: Wed, 11 Nov 2026 13:30:38 +0000
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
Subject: Re: [PATCH 3/3] fs/proc/task_mmu: account device-private PMDs as
 present in smaps
Message-ID: <avRtypkg16mVSDxM@gremlin>
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-4-usama.arif@linux.dev>
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
In-Reply-To: <20261111113904.650722-4-usama.arif@linux.dev>

On Wed, Nov 11, 2026 at 03:38:31AM -0800, Usama Arif wrote:
> Device-private PMDs represent mapped pages, but smaps_pmd_entry()
> passes present=false to smaps_account(). That treats them like migration
> entries: mapcounts are ignored, PSS is charged in full, and exclusive
> mappings are accounted as shared.
>
> Match smaps_pte_entry() and mark device-private PMDs as present so
> smaps_account() uses mapcounts for PSS and private/shared accounting.
>
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

It feels like PMD level device private entries have been the source of a lot of
issues, maybe a good area to audit in general... :)

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c0d391186c2b8..ad97532fc1184 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1032,8 +1032,11 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	} else if (unlikely(thp_migration_supported())) {
>  		const softleaf_t entry = softleaf_from_pmd(*pmd);
>
> -		if (softleaf_has_pfn(entry))
> +		if (softleaf_has_pfn(entry)) {
> +			if (softleaf_is_device_private(entry))
> +				present = true;
>  			page = softleaf_to_page(entry);
> +		}
>  	}
>  	if (IS_ERR_OR_NULL(page))
>  		return;
> --
> 2.53.0-Meta
>

--
Cheers, Lorenzo
