Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550834;
	b=etbc9EE9HWfZc8GBT27qIzNeKjB6YrqqlWP1Ic9kYBa82hq4ZOIFoRq53t4rmT2FlGeL
	 1qSE0gbj61SX//ak0l8YBQBADbtX92k91L46PWJeTCwiPrLm3Pn55MHlZYeZmxeqBj8/S
	 DdPBqCCfDzDRFsfds/yKM3/QaswavxFlUzAstYXtVTll3IBXjU1zCJ/7ZAEYAKdSzX6g6
	 PPWNwn60+1taYJSJNpibYHghy+GN/YXhZu3oFVcyKipKcjNymLfOyX0rHc2VZIXlNyPLr
	 WFS6DbEHLe5TGl7iVatzBU7G2QWmRV3412hYxRVj84lAnqzkcNumZ5nRAnrSe4XyMjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550834;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I3OQNJHjJZxzmctdjdKtcykMnT4b8iIfVPv52D9cTQE=;
	b=TUgWiMkwfURK4Qc5672tY7NPj/TNAnsoPEBjkE9StH+eHZ5htNM1pbA3jXNKTdhz5C35
	 F0UHQRAbvXNjimmWL3jDmC94wXorPK52GIEMI3BXfhhRpzq+pWVcmcnUhlJmoqNmI4kNT
	 nh8CbRQoESXN0SDD8FnlgxPZGawo0rKt55kj3cueuXWkVkwvA5NoIUBgTxgHbkd7aufIc
	 D/ONathH9PK4giJaMOlyViHxUAHpvzZ7cEuOcq8ZcYUM3y4atuET+J+1llJQFj169NgET
	 JoV2dSyEsd5XDhs7kzG15qnfxJESdx0clKSXs8KSGy0jVwdA1dx9HYYZ0JLXfb+bOjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U424FONz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E16606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U424FONz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F0F1F000C4;
	Tue, 24 Nov 2026 20:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550834;
	bh=I3OQNJHjJZxzmctdjdKtcykMnT4b8iIfVPv52D9cTQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U424FONzKU6vMS/v3mHk8p4nAv6mujrHBLCjkqMUbjlT4LkvaGtBPRe2aOOZcXyKc
	 sRGlt6P0S+k95R6SjeoLAi/vvGsmoNGj/6YVPRCgHVqD1X99B+fClaDstugKb2RLRO
	 EcAowVm8nJKriiLXGmMPCRVTqY2HtfTqZq8/qor4XEwI3SBaJEiHrsnlAt+JRsN5ZJ
	 u8GW+J2qtyyt9R1JX+06nMlviOfJhX31vy7425ui265UaQq+WkZkw8jyXyb5gOdJhU
	 nkLoJMYAq207nqnYHCUo7Gq7g03lGtzdzaKxxfMvkeJ5khhGyD8vqGjOd1/x/AQhC8
	 dDYxiVruis1cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Tue, 24 Nov 2026 15:07:10 -0500
Message-ID: <20261124200635.2539215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112415-certainly-tiptop-f297@gregkh>
References: <2026112415-certainly-tiptop-f297@gregkh>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit e55119ab611a0e47595db7e1d2ac1e69f7a73ff0 ]

__next_zones_zonelist() tests a slot's zone for NULL, then reads the
slot again to look up the zone's node. Offlining a zone's last block
rebuilds the zonelists in place, so the second read can return the
terminator:

  CPU 0                             CPU 1
  __next_zones_zonelist(nodemask)
    zonelist_zone(slot 1) = NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    zref_in_nodemask(slot 1)
      zone_to_nid(NULL)

Current GCC and clang merge the two reads, but nothing requires it.
With mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a
nodemask allocation between the reads while the node's last movable
block goes offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   zref_in_nodemask+0x9/0x20
   __next_zones_zonelist+0x23/0x70
   prepare_alloc_pages.constprop.0+0x16c/0x190
   __alloc_frozen_pages_noprof+0xaf/0x330

Read the slot once and test that zone. A NULL zone still ends the walk.
To achieve that, rename zref_in_nodemask() to zone_in_nodemask() and
pass a zone instead of zoneref pointer.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-8-gourry@gourry.net
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Adjusted the context line because the helper still has the old one-line signature, and took upstream's const nodemask_t * post-image unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmzone.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 0c8f181d9d500..cabe38127f798 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,12 +43,14 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
+/* A NULL zone terminates the zonelist, so it ends the search. */
+static inline bool zone_in_nodemask(const struct zone *zone,
+				    const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return !zone || node_isset(zone_to_nid(zone), *nodes);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
@@ -66,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(zonelist_zone(z), nodes))
 			z++;
 
 	return z;
-- 
2.53.0

