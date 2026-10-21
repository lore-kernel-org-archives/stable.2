Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585901;
	b=EpufamDVDhsadIO+1ywMO64Gp5JJC1waFInT2TLrZianfzKNyTX0Luin96l2+qp016My
	 8FbPyly0/pfMS7R1mRMNyCC6sZ3LUtss6j2AzZtRgKzuPvmxS5cyS8ASHWYDZvjZhf3bU
	 AzHV8oIS2ruzO/q2egLnOnifXhDvEZNLG5zwRNp6VN8jMm0XzuefKEweTmnk5vhG2G2Vq
	 Cnq0xAlng9bt+NjYaujyKteNBGuLSiBoJWC9poeoKkxb41rGicUbO10MMp8emhgjL/eQt
	 EPtjdhtMlUssvfvBftggJ4YznXaIRYeE4JudOVs+8Yc0quh8W3yBT/bZo6ZrD5G00RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585901;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Qd4BaSzD1LGTx2Y2uGB3Eo4kEo7F1O6DGIb4zjdHo44=;
	b=pqHkFfCi9EjEPm1bYhfSvj/kR5S48FNx7brlaZX2S+FtC+WBvLXICA2SFg8vTPu2zmmp
	 8/rgNrmrhFxEZGkiHK1DqNk96+YDZX6OW0NJvSWjmhgF/m2fioK4BUbv3bQ+Z9arbIDF3
	 xUPlRTFLqUv/zB+2QhHrty3WPO0B8Efn0yQSO4o/ZUOIzV9hXIKrn5ZC0ya9kyicW5vGE
	 WRRlNC85o/dZ3DyGYX7nmkmbixKVXAu2rIanlSWp085DUGeiBiiUKip35XjecmSpj4wAs
	 jqEeh7S5RpPN7R/NGakhU0F8COeE+R6SvNj/PxAC1GuxM/nbL9xHV9Aq1/RjdpD32Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LLGp4/+8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB26606A319;
	Wed, 21 Oct 2026 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLGp4/+8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD001F000C4;
	Wed, 21 Oct 2026 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585901;
	bh=Qd4BaSzD1LGTx2Y2uGB3Eo4kEo7F1O6DGIb4zjdHo44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LLGp4/+8kHfG3XaY9MW48NgLFV00TpK3bldoGF2u2IsEIe01KBpuQWuKk7hhMBjPQ
	 JKhplgPH506WX1RmYtr3rcCl5N1uZ3qTepV2ikpQMkVY9e3Rsunc0Eq+MV8UYICgn2
	 DHLP8HxsWjiTqDwOpxdHXt/gUcT33tnpkmWF+YtKYxsdJKFQq7GCA3942trBjm19N8
	 /taG2iuEYzP4vgcD+YuryfApu1ijzfHoWtl8LIF55gFLsjNC10D0UMsrFWJD9psn61
	 n+W38tnK2hhNLZ/93IcvdfnskEbM2fDBJ7wzh1SGJTF7dvupS3I395I70Ei5C3wXO2
	 aAGqtsDFdVveQ==
Date: Wed, 21 Oct 2026 13:31:32 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, 
	david@kernel.org, mhocko@kernel.org, dave@stgolabs.net, roman.gushchin@linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <atiwhEIudhnK0pmQ@gremlin>
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

Seems sensible to me, and since it's become the review of the ages (TM) let's
try and get some kind of tag record here :P

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e82ba737c028d..90f7a7bf4e426 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -8180,7 +8180,7 @@ int user_proactive_reclaim(char *buf,
>  		} else {
>  			struct scan_control sc = {
>  				.gfp_mask = current_gfp_context(gfp_mask),
> -				.reclaim_idx = gfp_zone(gfp_mask),
> +				.reclaim_idx = MAX_NR_ZONES - 1,
>  				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
>  				.priority = DEF_PRIORITY,
>  				.may_writepage = 1,
> --
> 2.53.0-Meta
>

--
Cheers, Lorenzo
