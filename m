Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792450379;
	b=4xOtrcESt0zLe3Hxzy+LhL1LtqqaXGVuT7ffGwM/YAAAdy3xPFl1XDp5+o+TqCJL2dEu
	 EtMaZcXeyYBdd21UDbU72Y5T9ZtGED3Du4keIo/pt8ARPOUphaED10zn7X1lbLSwtDlsp
	 +6kY7jWZbzMdXQBGH4wkXaZK+Bt63JM2EPLEIfNkDfUnoZR8KNKL3rqy2G6JYR0pv5Zpi
	 ngSLSLB9bGUlOfyM4n9P5m6cZfSlEkl06XRZ1CZOGZPQjwy45nv6a+11fJ6iABtme86Lq
	 7S5pn57sdpBvPL/wPuceDdhvwCm6l0aCJbM5xtJHk3XHZvWF28Ae3HWk5kbugyn17lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450379;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2yzfANdr008P3OVCzU9Slqrea3vsmMtQ/W75M6H3iYI=;
	b=TZ6B+ph+KPbz2+FKgU+b2vXagEFJJ4yqvjrA0Nw8c6mRXMp12zOZFTQl0KQnPcrD4/qR
	 aUcKFM3hFx0IFLNPvluDcTe9nt5TlpnTPx+tuIGskwp09NH2QgxRMPYRmx91N00HbXTuu
	 tkZSXCEc7hnFOM1WZjHeerSHw6/zTwiEUle9sk2Mh54i6T8jg8hhoqWPmNuL0YoewHhYI
	 PIIh2+sedcl06IMJYmOROWTGmIZxKFg9+KCLf8r5MDwBDA+pjwnVUZEhcDCbFf9EwnzD+
	 jhd7IMdHwYOUnGCPaGOQZce/n/7ngWRPpuyPJJOg4pk3Lzmqq9LHc9kePvi+2/b9S9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVr0n8Mm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6429606A319;
	Mon, 19 Oct 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVr0n8Mm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E071F000C4;
	Mon, 19 Oct 2026 22:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792450378;
	bh=2yzfANdr008P3OVCzU9Slqrea3vsmMtQ/W75M6H3iYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVr0n8Mmw41qLps0hPYUwOQVtio9j47QXYqxs5PvDuTeRUq8I01TyHbkgNTC5n0ue
	 vIRxlIzZRcVXb3AYRa4WN97A9VSZuE2s5h+mY8ZptvvAt2JycMdy+CO02xAx7UQDRq
	 Np+w9zZT14YEEwIsgN3s3wxJ6ZXoUrukHQFFl3zKcW38xPR4c2v4PKiMSZcogFkDuV
	 RPl7rypS5NsmEPNWjNQVuJEeJN6XKXrcucN3FmlaFiWxbQtwkL5oPcyxcdNKwYP664
	 pbPOf4OKHQsqQyx/fKHMm50PiFGB/7DEdWcrmEMgufbxmJ/wzrTq7UfgU9bKuvPK6C
	 GskwvCtoCt5YA==
Date: Mon, 19 Oct 2026 22:52:56 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, 
	david@kernel.org, mhocko@kernel.org, ljs@kernel.org, dave@stgolabs.net, 
	roman.gushchin@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <atafPDtIstZZ2byw@google.com>
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

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
