Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515568;
	b=3dhvZocJ4oHqPsJ9T/e+Pud09nzz1cT5XX8KFoYcnuk++QqWx6UzSmSdwSY6DijJufrS
	 YhkPs2VA50HsvrBEQ8zW/azivl9flCWISSi2pveN4xPu+YZfYHUNek2sny+ykW8oqAF8y
	 3L6kpGlXNlydZ4fHpVQBO4Hcnf9EwRUA7RXO5A+xKwJ1xJ7E0MqZR1qo+rMa9KsRWlK4r
	 Vl/dhA4APILTpiwPfX4wYPYpQJpsjZRRsw2V3whwp9Rs8FjMhZxcmbzyT8wEkgkEdxvMM
	 gt9ArnyPpE7swToLEBUlLe1NpPKVIuU5Gzl8mS01NbPnpqIGo9aRGiIM1V/mvLyl57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515568;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Illegal-White:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=lsWi/+vV7HXNVefv/HtjTalVTQdcLmOCgb3JgZq0tdU=;
	b=0YyGQ9g7N0zHyPx+N4+Wu/EDBI4PjUJEPALL+TM7n3ZzE1vcHC8g7I1AgApIxHFVgj3W
	 1u06Xb7/WDmtz/DCtKPywZjW/SECbdaxzynD26F32dDLEsFhpqUUYEKH1urrVxflyYdPE
	 1fslABTdIpglo7nEpPYXCsNLjfBenXbrZLaa+6Qj4mjefYR3RDOnhu/aN8964s6R62RgJ
	 V8sC5b5/ch/HTkM0QFtIrj/OXIHK89wzHFUEvs4NUckSrsvblUM1DvyWnxzChYS5HejhS
	 /H53kTfWp0z35x8DXFODW/+plmOGY+LCwxVAupX8P+zZQ1fedZUYjXMXQ7NF/UFH7yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=oO+pji7m;
	arc=none smtp.remote-ip=23.83.222.60
Received: from flamingo.ash.relay.mailchannels.net (flamingo.ash.relay.mailchannels.net [23.83.222.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0F606A31A;
	Tue, 20 Oct 2026 16:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0A0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=oO+pji7m
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5D4144E1526;
	Tue, 20 Oct 2026 16:59:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.96.14.12])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0784D4E2152;
	Tue, 20 Oct 2026 16:59:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illegal-White: 046881b50e36c100_1792515561217_47232638
X-MC-Loop-Signature: 1792515561217:39543921
X-MC-Ingress-Time: 1792515561217
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.14.12 (trex/8.0.2);
	Tue, 20 Oct 2026 16:59:21 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4j8JY362KGz102x;
	Tue, 20 Oct 2026 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1792515560;
	bh=lsWi/+vV7HXNVefv/HtjTalVTQdcLmOCgb3JgZq0tdU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=oO+pji7mYjxFCtP5HeJroc1ODXuNr+hSmiBedjFzv+CkBkdC4rXtomtMA8pYA411L
	 Y4KYhZI9YuLsMR5JuKet/LVeKpDI1e/mvhnASaxXJlGNUtZEuCf6N9RyuJTAqhVNMy
	 svK6XA9lxXnHHQif44dKKTJpn3keotg0Fadrttv3Aen9PhLg5P7iDGeHkgh26V6+ra
	 bhATCmru40mhEIAg6PEOmw7J/5D9pdob2Xt+ncEmh/lLcAwV/v/o0yE0GqHRLSGAwc
	 clt4tfkkZtfmBLje5J4Z13wNA+k+uoq4a+VZxlqkCzEGZmHA7grLgZ2lLJ6jmI+gDF
	 cMg++eo1SGvIg==
Date: Tue, 20 Oct 2026 09:59:16 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, david@kernel.org,
	mhocko@kernel.org, ljs@kernel.org, roman.gushchin@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <20261020165916.pf4gxd2rulrqmdso@offworld>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Mon, 19 Oct 2026, Gregory Price (Meta) wrote:

>user_proactive_reclaim() limits per-node reclaim to
>gfp_zone(GFP_KERNEL), which is ZONE_NORMAL. Proactive reclaim serves no
>allocation, but that limit makes shrink_node() skip every ZONE_MOVABLE
>folio, so writing to /sys/devices/system/node/nodeN/reclaim never
>reclaims a node's movable memory. A movable-only node, such as dax/kmem
>or hotplugged memory onlined movable, reclaims nothing and fails with
>-EAGAIN.
>
>To reproduce, fill a movable-only node with clean page cache and write
>200M to its nodeN/reclaim: the write fails with -EAGAIN and the page
>cache stays. The same write to a ZONE_NORMAL node frees 200MB.
>
>Scan every zone, as memory.reclaim does.
>
>Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
>Cc: stable@vger.kernel.org
>Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

This makes sense - sorry for the trouble but at least glad to see
people using this interface.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> mm/vmscan.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/vmscan.c b/mm/vmscan.c
>index e82ba737c028d..90f7a7bf4e426 100644
>--- a/mm/vmscan.c
>+++ b/mm/vmscan.c
>@@ -8180,7 +8180,7 @@ int user_proactive_reclaim(char *buf,
> 		} else {
> 			struct scan_control sc = {
> 				.gfp_mask = current_gfp_context(gfp_mask),
>-				.reclaim_idx = gfp_zone(gfp_mask),
>+				.reclaim_idx = MAX_NR_ZONES - 1,
> 				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
> 				.priority = DEF_PRIORITY,
> 				.may_writepage = 1,
>-- 
>2.53.0-Meta
>
