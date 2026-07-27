Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6B42A16F;
	Mon, 27 Jul 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173472; cv=none; b=RXQX/BoBpKVYGuSTkc9rWDwxyXiSeb35Fy+buQ7DDFvLpDxACuyGWp28xlXxgYDk9fTyphe/qsiLOsT5Loen9jNf9XOwLiW6luKR6qqCSgF+pTdmzTZEVuwH+Aey77F/t2A8rp/mx0lEM5V4rvMpk6VOjIPtwDo10BMPO0Hgnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173472; c=relaxed/simple;
	bh=BGELpQYwYkawAqcdG6LRscN06nOv2YpKhru4YQQ/Zcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7Y91BjRgqcA0mleDBo5q9ytrFrGQGevjKxuftREglA2dG9fbrr7jwEL97qFl5yKg7D4H8C2H7P+DkcInNWxzwhrIyEPG8RDbek/vl5RyQm2xgeRAUYsSLClT3vnhQwWMjhe6iycx49AQjRXxUhSa1RF4aUoVOwdbpHqJ67dJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgcp/6d+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgcp/6d+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827011F00A3A;
	Mon, 27 Jul 2026 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785173468;
	bh=FeuJKdYUaVLKNBfWUd4HTmd0q5nfx0zD3ldduTDAYyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tgcp/6d+oehw4jDZPMJxHA7W9qn4aC2gFYD7gy9EXODmJCAyFVQTa1rPfhqeWoew5
	 Y8D3kgRBHTLk8wRpNYx/lh/CJbi9sGnokVUwUQcjUwKia/o3MlNovgq0U9Sh5CJHdI
	 S8vOrgAm+++TF5TjAp5Hylm17hxvbJBCRIWLYu2WlswQBrM/V2YCFIV9w1shQ1cyNm
	 i6Egn5y0+toxfqtOSQmy64WdvsRNkBL/4490Kow5eZLM+InHbK5a4m/fSsLu49so0U
	 kg402vDz5qjt3yEK3UvSg4nWOo8QBL4Srr1UqNxjCR6cOBIbNGWTvr53xdyCSRuMKZ
	 QztiFaMubtRnQ==
Message-ID: <312caaf8-1661-4437-aaac-a93bf701ccf9@kernel.org>
Date: Mon, 27 Jul 2026 19:30:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: Initialise workingset state before
 folio split
To: Matt Fleming <matt@readmodwrite.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Kairui Song <ryncsn@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>,
 syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com,
 stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
References: <20260725101419.3938406-1-matt@readmodwrite.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260725101419.3938406-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 12:14, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> xas_try_split() adds __GFP_ACCOUNT for page-cache xa_nodes, but
> __folio_split() leaves the xa_state's xa_lru unset. That lets a live,
> memcg-charged xa_node exist without being linked into the mapping's
> shadow_nodes list_lru; when reclaim later walks the list_lru it trips
> VM_WARN_ON(!css_is_dying()).
> 
> Use mapping_set_update() to install both the workingset update callback
> and the shadow_nodes list_lru on the xa_state.
> 
> Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c5b060ce82921a2fd500
> Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
> Changes in v2:
> - Move mapping_set_update() after filemap_release_folio() succeeds.
> - Add Zi Yan's Reviewed-by.
> 
> Link: https://lore.kernel.org/linux-mm/20260724195244.3715130-1-matt@readmodwrite.com/
> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b5d1e9d4463d..4ddbc72e92fd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4033,7 +4033,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		gfp_t gfp;
>  
>  		mapping = folio->mapping;
> -		min_order = mapping_min_folio_order(folio->mapping);
> +		min_order = mapping_min_folio_order(mapping);
>  		if (new_order < min_order) {
>  			ret = -EINVAL;
>  			goto out;
> @@ -4047,6 +4047,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  			goto out;
>  		}
>  
> +		mapping_set_update(&xas, mapping);
> +

It's entirely unclear when mapping_set_update() should/must be called. ... or
even what it does.

Why is it called "mapping_set_*" when, in fact, we modify the xas?

The more I look at it, the more angry it makes me :)

Can someone please try finding a better way to handle this?

E.g., can we somehow remember in the xarray that we have !dax_mapping(mapping)
&& !shmem_mapping(mapping) early, and just do the right thing from xas code? Or
is there some way we could have a mixture in the same xarray?


Anyhow, for this patch here, I guess it's fine. I am convinced nobody can say
that with confidence. Black magic.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
