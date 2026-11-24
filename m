Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551861;
	b=e3tnWedN5FShBtS/cP++7tm/9H13SJJ3665b8/YEnQZj/fUrP+NYm7B9Hj1kC71KdcoL
	 mNL/+WFTSAbsxGT6NrNegh+4oTXyU92Q7U3PRn7XNo5G9n1zy5AONHUuQK5ilS4c3nvt2
	 lSuCNzo92U+ggLW9+MhT9v2geF+L3uDZqlIXn/gLZTuSNcRIpW3J0+xfTy2E9Rr4WOlHY
	 aglUIATaAo/8W8781c1ngSvYc0eOJzQ5eMZEPB08dmqPf5iqzzN1vG/3mekrM4pxmbmkT
	 r9By3KzzVvd+6WH+aYa0sodz/IKnc/6xRxuZODMMcJV/44v5oeGXlyYRplWKdjgx6GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551861;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l+P31tdmUl7pJu4oRF9ejeN49UsXt+gtiWT9u4aChS4=;
	b=pqUbciHRmoT+PRLFjljbPGt0jOIFjsuqPmSi4WM9K5IQ12+tutRiBO8rWN7BkgB/dPTd
	 pMrILRhZfZd5cs8PrgZRjwAzbM6bL61UbDCpRkCqHWAhLD4jpB7Unr0lLzgQBA64vpNZy
	 +bsslE1k9j5x8wwyb7A0VOqpQL1HdAc3Mpc7CgYi110TxiwbSj8wflGn9wBfhACwDZBC/
	 1rNzGPtr4dlNksdScntnHwto2HTVTI9Um25IdtltqbzL05MU/RwIGe/jdXSKoLarDcLub
	 /PkuPpuY1AtgpPZjUKE3EK8lUs6UU/hZh7uUUy4msQSLqM71ztKqO2DI0Q3gENNCyGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cv4RlUNl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3BB606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cv4RlUNl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD23E1F000C6;
	Tue, 24 Nov 2026 20:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551860;
	bh=l+P31tdmUl7pJu4oRF9ejeN49UsXt+gtiWT9u4aChS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cv4RlUNlDlGUrYytgPZWQkCvuFSF4bUfVFxbE8JJ4X9+vAPWUj2DsLNS/bHVkx5ju
	 /4IqunGxlE9uoMLcxA/YmSgkW/SmJHMTQ56Qy5a6T0f83fUbB/R9rXX07ObeaJ22Dr
	 VvAC9SgH8mbxUVRU3vWlTuShWPNM6ietRyr67cTCLa+WgSfj5WEsNUyJk5WEaDumr2
	 wTE8JKT8azrcrRNcjdb8L5HZ0PPOelpr6WMOFF7XZmYZvuMd+ofGGxZhddbXNlTAxQ
	 NayWWLXRL2ghumm3luneJKg7+elZO6J5V73mRR6khbPNyZZeFgj9/ECO1GVjnKYIGb
	 48Uef+zMpivHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Tue, 24 Nov 2026 15:24:18 -0500
Message-ID: <20261124202353.2574166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112416-revert-crafty-cfeb@gregkh>
References: <2026112416-revert-crafty-cfeb@gregkh>
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
[ sashal: Helper's parameters stay non-const (struct zone *zone, nodemask_t *nodes) instead of upstream's const-qualified types, because zone_to_nid() here takes a non-const zone. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmzone.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index f9baa8882fbf3..42a00132137de 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,12 +43,13 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
+/* A NULL zone terminates the zonelist, so it ends the search. */
+static inline bool zone_in_nodemask(struct zone *zone, nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return !zone || node_isset(zone_to_nid(zone), *nodes);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
@@ -66,7 +67,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(zonelist_zone(z), nodes))
 			z++;
 
 	return z;
-- 
2.53.0

