Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474084;
	b=GV71jwjrzcKwVn65EMR4Oh4b+vEemLogjkwZA6JZ+J3RLbNox4wf16SZzLG4m1Ck/MgM
	 yAb2C3/ZY1FI7eQ5+pcQr2+QTHgTbMCTLttGgK3e7yxuT0VhFayPhdo5zoQWQcRR/ZDvK
	 Z8i1OJV4eJAznegCbNipkgiad1++SqcBTqVJNOrNTgYE78f5XgVJDBwZVIqWl80Y5gheo
	 lrV6DV5+ZEeR3qXbRnHDXTUBt0DYL48mfgV3oQ3Zw+IIKgRkL/WvGydULBunDthxhmL1r
	 YhezmZv79ADUAGB5UV/RqqWn7cD5sbWobdzJIqs36DrJ87NA5j9mYfFmzyUHxVeFLpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474084;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bu4BdULQIHQlhCcJutXTiMEZNYcwzWTKws8acbVlwyE=;
	b=shOcZlAiQngUm1Iao8ivdudWcYDxOnrnbbcwCR61Bmyw8n2+ltIdax1q0uQ10EJJ0AOn
	 OI671MGk2t8btL//p2XCA2ZoKemNt8PmW+izFXx5GAjV3NIy7O/IJjnyIBKyPGGcsy2Ds
	 Oo75LFVXT49uA5cdNhnK48I8Irvekqdplrj2it4MlqpN6KLidqTtISrg4CBJy8vPEjzm9
	 Y7H0vFSo/ziUJyXyiqt6wcp5GZ4cKloOHTshevhmTaJvCXeWKQxMdXwfzWVw3f0Xoajef
	 GSEF0AZ456iBI8FyANbobSbsCKlqe3anPAvlYPjmGj3rIh/i/+AXVT2F5BVr+EVy23g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZO8K1dU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5089606A8B4;
	Thu, 12 Nov 2026 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZO8K1dU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AB51F00A05;
	Thu, 12 Nov 2026 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474084;
	bh=bu4BdULQIHQlhCcJutXTiMEZNYcwzWTKws8acbVlwyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lZO8K1dUoIbaKau1/mQ2XLHj8U7HPGcOc+Jg3qG1bBjqPSXKQuPt5bBUVqkR43GNR
	 XbNj3yVFbPmlnKpom5Fxsn1EfnG8ogso6U83ClsEGmX8xmbdlboqZTq/00tV1jBWkG
	 El1lZn5FUCjN0qLn4AcbgEIKiLv26Zf5ZqQxI2rt27EuwkZ+u4hVATLH3ReQVTG5JT
	 tPYyAH++YbVOWgUKiM3fXw5bBc+Oizv+ZbST6ZIfQO5hvA3Wfzvhz4yHOWRnF0KEG4
	 lY4wumFPxplRHKvViXKZUXNXdpHNqKNUhadQoF8XC8Eyeg9BPqfr1XbjFo3WTF4Fnx
	 4oQ9xVunb02EA==
Message-ID: <3973721c-9524-4a08-9929-e88617d21961@kernel.org>
Date: Thu, 12 Nov 2026 10:00:59 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs/proc/task_mmu: account device-private PMDs as
 present in smaps
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, baolin.wang@linux.alibaba.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev
Cc: stable@vger.kernel.org
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-4-usama.arif@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261111113904.650722-4-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/26 12:38, Usama Arif wrote:
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

I think I even spelled that out somewhere at some point while touching that code
... or did I fix the smaps_pte_entry() thing at some point?

"present" is a bit misleading in general, because it's not pte_present() ...

Matches smaps_pte_entry()

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
