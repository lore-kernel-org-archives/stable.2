Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497885;
	b=MjnFo4c90elC6mjIHc0eYh7ZhlN8FTxHWYvVjdu8Mmzl9rnfrOeVe4d0Wl+rEh4BR1nH
	 ODJO0d+LNjS5q9Iahfwb5vYC5X2XfUyxb4infGlxRCClAtFEbxKVoXoa7TT+PdLQGwXVa
	 /Oz2TDH0EADc0NVkyN4nEHywPUxokRcyfqzeNRQbmAenqC1iOHRJfiSyzIB/8lFbbLBWY
	 YSOwU80ktCI86Sq/Iz41LoXCy5+bM22pUvZR9/IrVCKdZH6Hjkji4to5YyOoyCSF0aAkq
	 ZD8QOAQgooN7Cz4Ue+xkqXqwLu4/oW+66nG2W7ybHH3omgzQVUr8Voprfl+fqtWIcKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497885;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EUbnCTk25H/cREetncbitvhF60S/wmbBZLPLU9DM/r4=;
	b=aSWuldHgw+WJ8ea3j1GMGGc58rs8/u+0jrZMTlhV33m1Gb5X/IiDWQFtv/vUndH9al4U
	 n1kt/wbDhR9WCtXdhGdnzxL8AszX/8wN4/dzRosWfREDD82W8A6TuxiythAVjFFgVvX6T
	 8btPDRJ3Twvtj7sifOzYkXS/9q3FGvRFbsOIpbsfYhoCShaUcsCLYEOEdmLqNpxbzImca
	 l/qrEAeJFGfgCjFF1XiYRqXUtlNBmmL7kURYf/ixA4Ieo0fDWefqb4f/81JSNAoPd6eBo
	 WCeV4ArKMCAFcb8GIn9ed3wQ9wA2+m7WwbRkkhFvsHjltEIsvDPgyQrFnD9AymKKPRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IS0dH4Fe;
	arc=none smtp.remote-ip=91.218.175.173
Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C7606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B85C7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IS0dH4Fe
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g2dnbFx4/3WtLU6XELgiDkbskvVUDKsGs2lr4KoV968=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795497882; v=1; x=1796102682;
 b=IS0dH4FedNpDBmQ8dYuxofkWbRzbn7d7qcFSg1O40Vp+YlvwAAA9HJRPxp4PwqC3ksPz/YpR
 S179VFCkr5/OjQNV0mekkonJDVxbpj0Lj6Z4GeRyqiS1MUJK3fpJ1rPL+Wl/9rtYCUbMdac8DZ+
 Ngg8I33O5wJbYRWd+F32dcig=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4bed5c34e88d1cd2;
	Tue, 24 Nov 2026 05:24:42 +0000
X-Mizu-Trace-ID: 4bed5c34e88d1cd2
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 21:24:37 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: free the private ID of a memcg that never comes
 online
Message-ID: <20261124052054.GC555944@shakeel.butt@linux.dev>
References: <20261124000439.967403-1-shakeel.butt@linux.dev>
 <F39B4A81-BB17-4C5D-851E-2740EBBBBA8B@linux.dev>
 <awUTKy9tx8nWJgXf@linux.dev>
 <2FE2D209-FB57-4191-A324-F179B2394DB1@linux.dev>
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
In-Reply-To: <2FE2D209-FB57-4191-A324-F179B2394DB1@linux.dev>

On Tue, Nov 24, 2026 at 12:52:41PM +0800, Muchun Song wrote:
> 
> 
> > On Nov 24, 2026, at 12:33, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > On Tue, Nov 24, 2026 at 10:50:00AM +0800, Muchun Song wrote:
> >> 
> >> 
> >>> On Nov 24, 2026, at 08:04, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >>> 
> > [...]
> >> 
> >> The leak analysis and the fix look correct to me. However, using
> >> CSS_RELEASED here makes the private ID cleanup depend on a generic CSS
> >> teardown state, and adds an accessor solely for this failure path.
> >> 
> >> The private ID is not needed until mem_cgroup_css_online(), so could we
> >> instead reserve it at the beginning of that callback? Failures in
> >> css_create() before ->css_online() would then never own a private ID,
> >> while failures after the reservation would continue to use the existing
> >> mem_cgroup_private_id_remove() cleanup.
> >> 
> >> This would also make the private ID lifecycle more explicit: reserve and
> >> publish it during online, then drop the initial reference during offline.
> >> It would avoid both the new css_is_released() helper and special handling
> >> in mem_cgroup_css_free().
> > 
> > Thanks Muchun. Nothing needs the private ID before ->css_online(), so
> > reserving it there would work. But it moves the out-of-IDs failure from
> > ->css_alloc() to ->css_online(). By then css_create() has linked the
> > css into the parent's children list and css_idr, so mem_cgroup_iter()
> > can css_tryget() it and cache it in iter->position. A css that fails
> > online is freed without ->css_released(), so
> > invalidate_reclaim_iterators() never runs, and the free does not wait
> > for those references. Today memcg's ->css_online() fails only when a
> > small allocation fails. With the move, every mkdir on a system that is
> > out of IDs would take that path. I would rather keep failing in
> > ->css_alloc(), before anything is visible.
> > 
> > To drop the CSS_RELEASED dependency, I can test the ID's own state:
> > !memcg->private_id_objcg means the ID was never published and the memcg
> > still owns the reservation. Let me know if that works for you.
> 
> You're right. I missed that the css is visible to mem_cgroup_iter()
> before ->css_online() completes. Using private_id_objcg to track whether
> the reservation was published makes sense to me. Thanks Shakeel!
> 

Oh I just noticed that private_id_objcg is introduced in 7.4, so to
backport the fix to previous stable kernels, we will still need to use
CSS_RELEASED or something else there.
