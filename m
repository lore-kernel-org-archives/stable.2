Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC8383992;
	Wed, 19 Aug 2026 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157792; cv=none; b=sUsStf9AKh3SNK8cE5XBYln/aGF7DMst3MvaAAjRDckb9O7dDU6FvckcnMdgUtwVybMm/tAAcOJTdr0DmFnHd1LunaFmJarMUCB3ZaMMnbGJ4MJcei9zGnxvEYLArCxGcpQFutPaty22cBAq9aZX5hXWHWZuKpinWEL0Op5iyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157792; c=relaxed/simple;
	bh=5tRRbw9pO45jvvFKUYeOXwyqzJ6oSqzyYRdHv0HvWDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grl7bACZ7Uv9n8OBBbQN0PNASifbyDy7KlZwd+CpnFV9amQBaEkMzMpVoTRL1PPE1RVv6yf0A8b2ESvDgfgc/MPGHT4BN4Y5Vrzto+fV19mdiChw7Uhcui6ZN9KK12ViUyhncR5VWFeBKDTfn+S4BTLErGSLX1QgbstzSuwjvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MJ92u95q; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MJ92u95q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JzlXMqAvWif/zUbXTfuQaQU1KTl2/VS82fmRP9cwND4=; b=MJ92u95qAnlZbmpaGv5Kqw8Jlq
	rP8iWWGQRsA13ssUCb3ZIX+wAs8nWiuafbnCan22SIgDiTprh1tmEA2f9++V9qqzDepk73En8B0Eq
	CeWwCDKama6uMal7bTa1MpCkRcydJai9uH0ec1x4sO7Eg+K58lVWHBFGL3N3DzCqjoC5aWmHfzeYQ
	Vu2DU6ZppbGow7ckoT5Vg8L7Tr1odrjmRHBjWN23gGE/ozq4TqO+SFs9nvhZo0YOQCCGAgNKlevVT
	GeBF2hTLhAQzXVE4zTW/VkKvouPsgxrIY2fauDa5L73svgB/WXsmdWeS0VBSB+OO49xHOOtjYWx9u
	WMAg9wLw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwjNY-009vdC-2p;
	Wed, 19 Aug 2026 16:43:05 +0000
Date: Wed, 19 Aug 2026 09:42:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>, 
	Panagiotis Issaris <takis@issaris.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net] net/sched: account classifier filter allocations to
 memcg
Message-ID: <aoXc9DH1G6aLtC0I@gmail.com>
References: <20260819143733.57538-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819143733.57538-1-jhs@mojatatu.com>
X-Debian-User: leitao

On Wed, Aug 19, 2026 at 10:37:33AM -0400, Jamal Hadi Salim wrote:
> Allocations in the tc classifier *_change() paths (filter objects,
> per-CPU counters, and per-filter aux data) use plain GFP_KERNEL without
> __GFP_ACCOUNT, allowing unprivileged users to pin kernel memory outside
> memcg charging. The shared tcf_exts_init_ex() action array allocation in
> cls_api.c was also uncharged; this patch closes it along with the
> per-classifier filter-object/percpu/aux allocations that remain
> unaccounted.
> 
> Add GFP_KERNEL_ACCOUNT to:
> - the shared tcf_exts_init_ex() action array (cls_api.c), common to every
>   filter of every classifier (32 pointers, 256 bytes);
> - the filter-object, per-CPU-counter, and per-filter aux allocations in
>   cls_basic, cls_bpf, cls_cgroup, cls_flow, cls_flower, cls_fw,
>   cls_matchall, cls_route and cls_u32;
> - the u32_init_knode() replace-path knode allocation (cls_u32.c), which
>   allocates the same struct tc_u_knode + sel.keys on every replace of an
>   existing knode and was missed by the create-path-only conversion.
> 
> Also fix the cls_basic error path: basic_change() inserts fnew into the
> IDR before allocating the per-CPU counter. If alloc_percpu() fails the
> errout path kfree'd fnew without idr_remove, leaving a dangling pointer
> in the IDR. With GFP_KERNEL_ACCOUNT the percpu alloc becomes failable
> on demand (memcg at memory.max), making the dead path attacker-reachable
> and burning the handle permanently. Add the idr_remove on the percpu
> failure path, matching the basic_set_parms failure-path pattern.
> 
> Note: vega@nebusec.ai provided a poc for basic_cls, but it was easy to
> extend to the other classifiers.
> 
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED, CONFIG_NET_CLS_* (the classifier being used),
>   CONFIG_NET_CLS_ACT, CONFIG_MEMCG, CONFIG_USER_NS, CONFIG_NET_NS.
> - Unprivileged user in a fresh user+network namespace (unshare -Urn),
>   or root with CAP_NET_ADMIN.
> - Create a large number of tc filters (e.g. tc filter add dev lo
>   ingress ... <classifier> ...) while watching a memcg-limited cgroup:
>   system slab grows far faster than memory.current, pinning kernel
>   memory outside memcg charging.
> 
> Fixes: 0da974f4f303 ("[NET]: Conversions from kmalloc+memset to k(z|c)alloc.")
> Reported-by: vega@nebusec.ai
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
