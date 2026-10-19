Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443092;
	b=20I4hXwAEDWo3l/v+rRqJZea35RW/8XHfuFVELISnbTp3jObm5/53OzIbCFICpH6loUe
	 +mkgV2Ti9pwOuq11sR0kdKi4izhx7eyCaBSCzyRveb+EM7+e1XY/nRLd6YGKr80LQCs7B
	 Sk4She0E78+8rgB4AivnwtJpwi0fKCEPPvd+Z64v1D7zaB0w6B/W0GUQbBvpyjY53k4FG
	 on1vxMdWqVb7Dzy2chzkLKpH+2Sfs2ybbC0Mf1y8/xPXqhw9/qB7FKdZT9p6dR5we6cWv
	 L8X/UQy3sOPXWRlAqkchp01Fe+DaJz6uejEtVKa6oaqH+O5TY5VsBYVxPc2TKaKnj5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443092;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z09TlHme8s+UYlN6I8GSIiTbNEV9B18/ss/FueYOjmg=;
	b=cDabb6Unl6R0b8/HNmt/IwsByCmXQ4gHRg4GaEOb0vZwtQmXedko3DWfaVOXvrT4LlWG
	 Ft8W+JOxR6T29KEEdXQ0skJyRKDs6DWjyAiEh8MJSz/eaHMghGpw1YQM2ICqe0Xqpttkm
	 RAiwVllhsy7u35D+NkI2WW0US5yNTBT45jDPKLyC5AgLEK7jkNMRgADWFEAoCe8kaY0RR
	 xAdpjvaVNgsRVaC8KCXfZHz6Lx46IesSM07vmFIa1mSL3QZsMhHdS5mjOZ+NjbTpOkk2W
	 tZJ9i1DljQUG19cHBNDLtfBBZ5PUcTSA76oCPFk5O2jUVp7qK2eRq5zT5TQy8acWt6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCKMUP58;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C060A2618;
	Mon, 19 Oct 2026 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCKMUP58
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97921F000C4;
	Mon, 19 Oct 2026 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443091;
	bh=z09TlHme8s+UYlN6I8GSIiTbNEV9B18/ss/FueYOjmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCKMUP58RqYYAGi8f/qrT4MupGAV7Y/5KbiQx2GN7ryUsajnzax1rAUyZszN20opG
	 8TSyUYoJevEScTJN+N33VeDVqLmhdo02wuISvoi2tHkIQtEsLoV11SMCFI9f/qrcnL
	 AzZdQo4kpx0DqPNPDwXSI4f6zY9/KVFOHx9CP2WwQs999f0CEQIO7T9ZKGqxM9AUbx
	 C656DjxNOzQAKj8CWqFAOF3T7iKu8kJxeSf/o4p5pnihgRWVkpYRjRY6NpMVAAKcPK
	 3lxxoHPYwmJazhosRodJTsYxYkpaftF35bnvPmz9fWWAvJH6wtb6g/4Y/pqzDN7F1d
	 3+T825S9VgMoA==
Date: Mon, 19 Oct 2026 21:51:29 +0100
From: Harry Yoo <harry@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, 
	david@kernel.org, mhocko@kernel.org, ljs@kernel.org, dave@stgolabs.net, 
	roman.gushchin@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <ataClWf9F_zp-KDh@thinkstation>
References: <20261019185002.3428594-1-gourry@gourry.net>
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
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>

On Mon, Oct 19, 2026 at 02:50:02PM -0400, Gregory Price (Meta) wrote:
> user_proactive_reclaim() limits per-node reclaim to
> gfp_zone(GFP_KERNEL), which is ZONE_NORMAL. Proactive reclaim serves no
> allocation, but that limit makes shrink_node() skip every ZONE_MOVABLE
> folio, so writing to /sys/devices/system/node/nodeN/reclaim never
> reclaims a node's movable memory. A movable-only node, such as dax/kmem
> or hotplugged memory onlined movable, reclaims nothing and fails with
> -EAGAIN.
> 
> To reproduce, fill a movable-only node with clean page cache and write
> 200M to its nodeN/reclaim: the write fails with -EAGAIN and the page
> cache stays. The same write to a ZONE_NORMAL node frees 200MB.
> 
> Scan every zone, as memory.reclaim does.
> 
> Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
