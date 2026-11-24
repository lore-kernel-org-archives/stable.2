Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551909;
	b=iGLh4YVhsFOx/QfdjXT7aqYVJTsG5KAvaesAYh32y2YY4s4L6MkAlO3giS03ZmDwwH4B
	 6zMc+6WeeN7a1Ve8rjrtAx32exdONpKlpyzbrh1pMal2WC9yKgWHxKNlChzAW4bevQl38
	 NVMJoCO0pjt3YsDPvmpHqOgAkf8BktLtjPV6sYWJqQL1PT9i+WI5Pe9lLX0QrVyI3tmEt
	 Q3Hdra+xLD7v8SHpx/c3jYS5CIbrc3zGVnybukyJqs6poC5Jv9dnL8ibmW7bTbMeSmxJu
	 4DYcxjPF19iWWnsRp30UbOFY6EM/gfheiy5qkt10lvbFHtB5AWs4nvpHiNEvRaepqng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w438fEjJfYjfdXdTkLOTExQPv/1sJ4O5WiNo08B8r/c=;
	b=VgNHdk4Rpe0APoX2pVbQ7NtKAx+0F3XEkAEzPmyIvX6lWvN2zSBCWne++DhstkXEX1j9
	 V+fAieX/sLu62TCmebJNneh/KrCstPRYoa3lXwHJE+jB7UvxxwOMU5PHSSWgNpMiuiDiN
	 +/dqdXwZXVf+9/JXw773nmy6vhx99WJhbG10vkg70tBaXFlaAprrCdQEemaH86HbBEN1d
	 h9/DEjFraMPFk9H/19kR6fAwpa8RZI2I6JHNZbPi4uhxaAjEN9X2VhyFb3pIU8RCTtkbr
	 /rricKZNw4qxTDgpgo/17EUlIhBTMU9fEZXSBnedOW8fhsbh6eZj3cZ29AaJqrpgtWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzJEr+uU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12711606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzJEr+uU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B951F000D0;
	Tue, 24 Nov 2026 20:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551907;
	bh=w438fEjJfYjfdXdTkLOTExQPv/1sJ4O5WiNo08B8r/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzJEr+uUGPKJArhIkqNgQL0uq42kVJys6n0NyTsgtn8ZUcsg1Uplg/nSqBTXnV2VO
	 +HCCr8M5/y22c/gqHzJI0K7w1lrHDNGkBw2wXJfewZCqFsDNiYiPOq1zlcY+Zwp4Ze
	 PcGXSOTjgXtFeg4ExbFKk/ERzi37ZHFWgEN0XWRAYH4XjGZyKxOAeMWaMxRcyGccHV
	 3YicSDNqX1wKCBAW4/7p01hg7gA6tD+NxbTZnTxqBmmLeC6PVS4J+u1vbRP2AUpTwH
	 N/6nyFiYM9my2tQ7SwyAgWv6pjviT+xjGh8nuw3H32HIdx/8g9W5zxh8aUI6KCON6Z
	 gJJ6G7JZMpp1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mm/page_alloc: fix freeing static percpu memory
Date: Tue, 24 Nov 2026 15:25:04 -0500
Message-ID: <20261124202449.2582372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112445-kimono-cavity-bc8a@gregkh>
References: <2026112445-kimono-cavity-bc8a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit 022e7fa0f73d7c90cf3d6bea3d4e4cc5df1e1087 ]

The size of struct per_cpu_zonestat can be 0 on !SMP && !NUMA.  In that
case, zone->per_cpu_zonestats will always equal to boot_zonestats.  But in
zone_pcp_reset(), zone->per_cpu_zonestats is freed via free_percpu()
directly without checking against boot_zonestats first.  boot_zonestats
will be released by free_percpu() unexpectedly.

Link: https://lkml.kernel.org/r/20220916072257.9639-7-linmiaohe@huawei.com
Fixes: 28f836b6777b ("mm/page_alloc: split per cpu page lists and zone stats")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7bfcf81b1cb4 ("mm/page_alloc: keep the pagesets of an empty zone")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e58f3f514e640..2679420c73a0e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9484,9 +9484,11 @@ void zone_pcp_reset(struct zone *zone)
 			drain_zonestat(zone, pzstats);
 		}
 		free_percpu(zone->per_cpu_pageset);
-		free_percpu(zone->per_cpu_zonestats);
 		zone->per_cpu_pageset = &boot_pageset;
-		zone->per_cpu_zonestats = &boot_zonestats;
+		if (zone->per_cpu_zonestats != &boot_zonestats) {
+			free_percpu(zone->per_cpu_zonestats);
+			zone->per_cpu_zonestats = &boot_zonestats;
+		}
 	}
 }
 
-- 
2.53.0

