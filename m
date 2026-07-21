Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213F3BAD9F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624860; cv=none; b=quUVHCimrGR45CNbFzgA5iz5wtZM2NVhHxgaDsfFYqdgux44uHuH89fREIYz0kYop+/mCO5fmuWmfhFdvaWjzmd8f1JZlhHhZf/WlzW0H/u+AyxIMIHU7M4aX5y5+yFJPMcz5ln6joh9oICV4KUlD1JferXEyYAwVcQmTspd740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624860; c=relaxed/simple;
	bh=HOdTTSHWjTqq8NYkYPKiwH/2dHWhPWH7YL0klrOHUt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vk6vJJm1+hn5eUa1xRL6/CrmPQEMgHLE2Gq1l0/mKg5Ofm7XBfRLNwVpMP5ZqugHoB2Wza1P3m/jEwcElG8kaLf1etN3X9MHGDUsJ1Zqin0LWlClFa+CZvbNpW+ib7WbnJGwB7FY24haXam9Hyn9asVzLhBh8KMWmjDAZR7aFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YRmDBZW7; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YRmDBZW7"
Message-ID: <afa30b9a-07fb-4f21-973a-72bc7ceeb9e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784624856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8B7ZA8PRL4G3MTz0Gig1fWiNo+K9n9cS6NpKqjVtJw=;
	b=YRmDBZW7fripgkv7jluCqgS2R/bz7N2GCFou+dZuq4I9w1/wmZdNyGxLI5kTSMEkrFj616
	DYYQIzEp99IIUecvMfYvU8bOx+M9jZ8fFQZs2WyrtRgvtTQRcFS+MvpwJjyzffG50JS6bG
	q29C+Ig/BRTNIaDEknsRWzqvl0dloJc=
Date: Tue, 21 Jul 2026 17:07:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5.15.y] netfilter: nf_tables: restore set elements when
 delete set fails
To: Sid Kumar <sidkumar1@gmail.com>, stable@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: sashal@kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Acs <acsjakub@amazon.de>
References: <20260624213654.2762749-1-sidkumar1@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260624213654.2762749-1-sidkumar1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/25/26 5:36 AM, Sid Kumar wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
>
> [ Upstream commit e79b47a8615d42c68aaeb68971593333667382ed ]
>
> >From abort path, nft_mapelem_activate() needs to restore refcounters to
> the original state. Currently, it uses the set->ops->walk() to iterate
> over these set elements. The existing set iterator skips inactive
> elements in the next generation, this does not work from the abort path
> to restore the original state since it has to skip active elements
> instead (not inactive ones).
>
> This patch moves the check for inactive elements to the set iterator
> callback, then it reverses the logic for the .activate case which
> needs to skip active elements.
>
> Toggle next generation bit for elements when delete set command is
> invoked and call nft_clear() from .activate (abort) path to restore the
> next generation bit.
>
> The splat below shows an object in mappings memleak:
>
> [43929.457523] ------------[ cut here ]------------
> [43929.457532] WARNING: CPU: 0 PID: 1139 at include/net/netfilter/nf_tables.h:1237 nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
> [...]
> [43929.458014] RIP: 0010:nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
> [43929.458076] Code: 83 f8 01 77 ab 49 8d 7c 24 08 e8 37 5e d0 de 49 8b 6c 24 08 48 8d 7d 50 e8 e9 5c d0 de 8b 45 50 8d 50 ff 89 55 50 85 c0 75 86 <0f> 0b eb 82 0f 0b eb b3 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90
> [43929.458081] RSP: 0018:ffff888140f9f4b0 EFLAGS: 00010246
> [43929.458086] RAX: 0000000000000000 RBX: ffff8881434f5288 RCX: dffffc0000000000
> [43929.458090] RDX: 00000000ffffffff RSI: ffffffffa26d28a7 RDI: ffff88810ecc9550
> [43929.458093] RBP: ffff88810ecc9500 R08: 0000000000000001 R09: ffffed10281f3e8f
> [43929.458096] R10: 0000000000000003 R11: ffff0000ffff0000 R12: ffff8881434f52a0
> [43929.458100] R13: ffff888140f9f5f4 R14: ffff888151c7a800 R15: 0000000000000002
> [43929.458103] FS:  00007f0c687c4740(0000) GS:ffff888390800000(0000) knlGS:0000000000000000
> [43929.458107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [43929.458111] CR2: 00007f58dbe5b008 CR3: 0000000123602005 CR4: 00000000001706f0
> [43929.458114] Call Trace:
> [43929.458118]  <TASK>
> [43929.458121]  ? __warn+0x9f/0x1a0
> [43929.458127]  ? nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
> [43929.458188]  ? report_bug+0x1b1/0x1e0
> [43929.458196]  ? handle_bug+0x3c/0x70
> [43929.458200]  ? exc_invalid_op+0x17/0x40
> [43929.458211]  ? nft_setelem_data_deactivate+0xd7/0xf0 [nf_tables]
> [43929.458271]  ? nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
> [43929.458332]  nft_mapelem_deactivate+0x24/0x30 [nf_tables]
> [43929.458392]  nft_rhash_walk+0xdd/0x180 [nf_tables]
> [43929.458453]  ? __pfx_nft_rhash_walk+0x10/0x10 [nf_tables]
> [43929.458512]  ? rb_insert_color+0x2e/0x280
> [43929.458520]  nft_map_deactivate+0xdc/0x1e0 [nf_tables]
> [43929.458582]  ? __pfx_nft_map_deactivate+0x10/0x10 [nf_tables]
> [43929.458642]  ? __pfx_nft_mapelem_deactivate+0x10/0x10 [nf_tables]
> [43929.458701]  ? __rcu_read_unlock+0x46/0x70
> [43929.458709]  nft_delset+0xff/0x110 [nf_tables]
> [43929.458769]  nft_flush_table+0x16f/0x460 [nf_tables]
> [43929.458830]  nf_tables_deltable+0x501/0x580 [nf_tables]
>
> (cherry picked from commit e79b47a8615d42c68aaeb68971593333667382ed)
> [Vegard: CVE-2024-27012; fixed conflicts due to missing commits
>   0e1ea651c9717ddcd8e0648d8468477a31867b0a ("netfilter: nf_tables: shrink
>   memory consumption of set elements") and
>   9dad402b89e81a0516bad5e0ac009b7a0a80898f ("netfilter: nf_tables: expose
>   opaque set element as struct nft_elem_priv") so we pass the correct types
>   and values to nft_setelem_data_deactivate(), nft_setelem_validate(),
>   nft_set_elem_ext(), etc.]
> [acsjakub: clean cherry-pick of the commit 164936b2fc88
>   ("netfilter: nf_tables: restore set elements when delete set fails")
>   from 6.6.y. Plus, add "[ Upstream commit .." header to the message]
> [sidk: clean cherry-pick of the commit faa0deee2721
>   ("netfilter: nf_tables: restore set elements when delete set fails")
>   from 6.1.y.
>
> Fixes: 628bd3e49cba ("netfilter: nf_tables: drop map element references from preparation phase")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Signed-off-by: Sid Kumar <sidkumar1@gmail.com>




Is this patch associated with cve-2026-23111 
(https://fuzzinglabs.com/repro-cve-2026-23111/) ?


I'm verifying cve-2026-23111 in latest 5.15 stable, but I can still get 
garbled text by running 'nft list maps' like this:

table inet mytable {
     map triggermap {
         type ipv4_addr : verdict
         elements = { * : goto �,�    �����*�    ���� }      <== garbled 
text, uaf
     }
}


Does that means cve-2026-23111 is still exist in latest 5.15 ?



>
> ---
>   net/netfilter/nf_tables_api.c  | 41 ++++++++++++++++++++++++++++++----
>   net/netfilter/nft_set_bitmap.c |  4 +---
>   net/netfilter/nft_set_hash.c   |  8 ++-----
>   net/netfilter/nft_set_pipapo.c |  5 +----
>   net/netfilter/nft_set_rbtree.c |  4 +---
>   5 files changed, 42 insertions(+), 20 deletions(-)
>
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 623b776bf792..021a2a34b8a1 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -594,6 +594,12 @@ static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
>   				  const struct nft_set_iter *iter,
>   				  struct nft_set_elem *elem)
>   {
> +	struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
> +
> +	if (!nft_set_elem_active(ext, iter->genmask))
> +		return 0;
> +
> +	nft_set_elem_change_active(ctx->net, set, ext);
>   	nft_setelem_data_deactivate(ctx->net, set, elem);
>   
>   	return 0;
> @@ -619,6 +625,7 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
>   			continue;
>   
>   		elem.priv = catchall->elem;
> +		nft_set_elem_change_active(ctx->net, set, ext);
>   		nft_setelem_data_deactivate(ctx->net, set, &elem);
>   		break;
>   	}
> @@ -3522,6 +3529,9 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
>   	const struct nft_data *data;
>   	int err;
>   
> +	if (!nft_set_elem_active(ext, iter->genmask))
> +		return 0;
> +
>   	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
>   	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
>   		return 0;
> @@ -3545,19 +3555,22 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
>   
>   int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set)
>   {
> -	u8 genmask = nft_genmask_next(ctx->net);
> +	struct nft_set_iter dummy_iter = {
> +		.genmask	= nft_genmask_next(ctx->net),
> +	};
>   	struct nft_set_elem_catchall *catchall;
>   	struct nft_set_elem elem;
> +
>   	struct nft_set_ext *ext;
>   	int ret = 0;
>   
>   	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
>   		ext = nft_set_elem_ext(set, catchall->elem);
> -		if (!nft_set_elem_active(ext, genmask))
> +		if (!nft_set_elem_active(ext, dummy_iter.genmask))
>   			continue;
>   
>   		elem.priv = catchall->elem;
> -		ret = nft_setelem_validate(ctx, set, NULL, &elem);
> +		ret = nft_setelem_validate(ctx, set, &dummy_iter, &elem);
>   		if (ret < 0)
>   			return ret;
>   	}
> @@ -5032,6 +5045,11 @@ static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
>   					const struct nft_set_iter *iter,
>   					struct nft_set_elem *elem)
>   {
> +	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
> +
> +	if (!nft_set_elem_active(ext, iter->genmask))
> +		return 0;
> +
>   	return nft_setelem_data_validate(ctx, set, elem);
>   }
>   
> @@ -5126,6 +5144,13 @@ static int nft_mapelem_activate(const struct nft_ctx *ctx,
>   				const struct nft_set_iter *iter,
>   				struct nft_set_elem *elem)
>   {
> +	struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
> +
> +	/* called from abort path, reverse check to undo changes. */
> +	if (nft_set_elem_active(ext, iter->genmask))
> +		return 0;
> +
> +	nft_clear(ctx->net, ext);
>   	nft_setelem_data_activate(ctx->net, set, elem);
>   
>   	return 0;
> @@ -5144,6 +5169,7 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
>   		if (nft_set_elem_active(ext, genmask))
>   			continue;
>   
> +		nft_clear(ctx->net, ext);
>   		elem.priv = catchall->elem;
>   		nft_setelem_data_activate(ctx->net, set, &elem);
>   		break;
> @@ -5417,6 +5443,9 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
>   	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
>   	struct nft_set_dump_args *args;
>   
> +	if (!nft_set_elem_active(ext, iter->genmask))
> +		return 0;
> +
>   	if (nft_set_elem_expired(ext) || nft_set_elem_is_dead(ext))
>   		return 0;
>   
> @@ -6103,7 +6132,7 @@ static void nft_setelem_activate(struct net *net, struct nft_set *set,
>   	struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
>   
>   	if (nft_setelem_is_catchall(set, elem)) {
> -		nft_set_elem_change_active(net, set, ext);
> +		nft_clear(net, ext);
>   	} else {
>   		set->ops->activate(net, set, elem);
>   	}
> @@ -6777,9 +6806,13 @@ static int nft_setelem_flush(const struct nft_ctx *ctx,
>   			     const struct nft_set_iter *iter,
>   			     struct nft_set_elem *elem)
>   {
> +	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
>   	struct nft_trans *trans;
>   	int err;
>   
> +	if (!nft_set_elem_active(ext, iter->genmask))
> +		return 0;
> +
>   	trans = nft_trans_alloc_gfp(ctx, NFT_MSG_DELSETELEM,
>   				    sizeof(struct nft_trans_elem), GFP_ATOMIC);
>   	if (!trans)
> diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
> index 60122539fee6..028955a9cb09 100644
> --- a/net/netfilter/nft_set_bitmap.c
> +++ b/net/netfilter/nft_set_bitmap.c
> @@ -171,7 +171,7 @@ static void nft_bitmap_activate(const struct net *net,
>   	nft_bitmap_location(set, nft_set_ext_key(&be->ext), &idx, &off);
>   	/* Enter 11 state. */
>   	priv->bitmap[idx] |= (genmask << off);
> -	nft_set_elem_change_active(net, set, &be->ext);
> +	nft_clear(net, &be->ext);
>   }
>   
>   static bool nft_bitmap_flush(const struct net *net,
> @@ -223,8 +223,6 @@ static void nft_bitmap_walk(const struct nft_ctx *ctx,
>   	list_for_each_entry_rcu(be, &priv->list, head) {
>   		if (iter->count < iter->skip)
>   			goto cont;
> -		if (!nft_set_elem_active(&be->ext, iter->genmask))
> -			goto cont;
>   
>   		elem.priv = be;
>   
> diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
> index 9ea4a0990318..5a74ee4b7dfb 100644
> --- a/net/netfilter/nft_set_hash.c
> +++ b/net/netfilter/nft_set_hash.c
> @@ -196,7 +196,7 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
>   {
>   	struct nft_rhash_elem *he = elem->priv;
>   
> -	nft_set_elem_change_active(net, set, &he->ext);
> +	nft_clear(net, &he->ext);
>   }
>   
>   static bool nft_rhash_flush(const struct net *net,
> @@ -285,8 +285,6 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
>   
>   		if (iter->count < iter->skip)
>   			goto cont;
> -		if (!nft_set_elem_active(&he->ext, iter->genmask))
> -			goto cont;
>   
>   		elem.priv = he;
>   
> @@ -615,7 +613,7 @@ static void nft_hash_activate(const struct net *net, const struct nft_set *set,
>   {
>   	struct nft_hash_elem *he = elem->priv;
>   
> -	nft_set_elem_change_active(net, set, &he->ext);
> +	nft_clear(net, &he->ext);
>   }
>   
>   static bool nft_hash_flush(const struct net *net,
> @@ -669,8 +667,6 @@ static void nft_hash_walk(const struct nft_ctx *ctx, struct nft_set *set,
>   		hlist_for_each_entry_rcu(he, &priv->table[i], node) {
>   			if (iter->count < iter->skip)
>   				goto cont;
> -			if (!nft_set_elem_active(&he->ext, iter->genmask))
> -				goto cont;
>   
>   			elem.priv = he;
>   
> diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
> index 4bede370c8b8..a965444ce5c5 100644
> --- a/net/netfilter/nft_set_pipapo.c
> +++ b/net/netfilter/nft_set_pipapo.c
> @@ -1819,7 +1819,7 @@ static void nft_pipapo_activate(const struct net *net,
>   {
>   	struct nft_pipapo_elem *e = elem->priv;
>   
> -	nft_set_elem_change_active(net, set, &e->ext);
> +	nft_clear(net, &e->ext);
>   }
>   
>   /**
> @@ -2121,9 +2121,6 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
>   
>   		e = f->mt[r].e;
>   
> -		if (!nft_set_elem_active(&e->ext, iter->genmask))
> -			goto cont;
> -
>   		elem.priv = e;
>   
>   		iter->err = iter->fn(ctx, set, iter, &elem);
> diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
> index 426becaad1b9..23e4e656f7f0 100644
> --- a/net/netfilter/nft_set_rbtree.c
> +++ b/net/netfilter/nft_set_rbtree.c
> @@ -548,7 +548,7 @@ static void nft_rbtree_activate(const struct net *net,
>   {
>   	struct nft_rbtree_elem *rbe = elem->priv;
>   
> -	nft_set_elem_change_active(net, set, &rbe->ext);
> +	nft_clear(net, &rbe->ext);
>   }
>   
>   static bool nft_rbtree_flush(const struct net *net,
> @@ -618,8 +618,6 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
>   
>   		if (iter->count < iter->skip)
>   			goto cont;
> -		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
> -			goto cont;
>   
>   		elem.priv = rbe;
>   
