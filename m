Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552937;
	b=Z0OG1cfGvH5P0Xpu6sfrkFzNQnsUMtv6Q91NCn1Zb9mB0F9ISFoYIDt+gi9XnlVJNiT6
	 ZoUcNlDxSVANKDg8/rsjEK6hp4hSTEH1rIobZVagDI1adEBOh1sMe2WPa7YLsru6VWMc9
	 FHeewADf3eZN0oncuFhGC5OKND7TujUzFNU8AXKJKF5d8CmTl+9ytc1rKuDcbJFQd9fgs
	 Ag877i3NoQYOe0sESv+Qm3ttSNYknzthXCfbKVEDCjRl1tNBVRgahKX56T+YARomqJ46g
	 qAowGKvX/zb3Xswsrl9X8bJv9ErBsFUGRj/2WXsLPLb1CVVf4xRfPQN+HCzEEXhLtHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mwWmbnqF1VGlsLm/PDlJK0acEp8xAzvfoOPNFiPeEJU=;
	b=iwBqZWq5o/6TRy7PFR/QILRSm2mesYbpfvboG9brT1esMWaOAeNYk83p0hlA1SGEGamz
	 fIUhn1wsHmOoSTII/7gkWAJAw0KZf0yvSNhnA++oICuehwWMXUxM3v9CV0X24XQQHslal
	 wcQjkKXsdLVMlC9vaErkTRykIAJUJTOBqd8R0eKmPf/kWgfy8i9WTYAX6GkF6bVwZhT7H
	 979nlxSGD54Q/TxledOttZ6BmwF+dBRap985BkbhE5mPzLov+YUlsF1I5JZPSXR/mLr7A
	 I+Wb4lnzAu7G8pc2kEp9dpo2R382RoxJFQhdOl1b0wd/JvBZSMD1gSHyqQzKtORHQ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ThU/BGHE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1084A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThU/BGHE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D91F000C4;
	Tue, 24 Nov 2026 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552936;
	bh=mwWmbnqF1VGlsLm/PDlJK0acEp8xAzvfoOPNFiPeEJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ThU/BGHEvENrEb2vzbWrxW7qgJzKYhNfBONMwfHquySpNFk2bnKhVYBs2nlsWFIyj
	 IP1EPA7CdYIS0y7StJuxpHmcWwzvIhAO9sCEj/f3VlEuO+AK+0W8iUbGLE8F6CQ5qR
	 NIb23Yz3gDHSsBBFYVFi+xDgoaIrJZVNemvQG7wlZ6wCDy+DabRM50YpToRalo6ezd
	 4zEIy3UNuOcyu/giQyLWq1wzr09G5wpTdHfLTbd/nhyYIyKzoyLg7LKY22BrZdrVnl
	 aMDv95F6ribY5oyfcszu41kvz8wdGy0uS/iKIIvGTDirScYe3CzqmNaXgWZqBK5aa5
	 L1Q9TOubTL/qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Tue, 24 Nov 2026 15:42:14 -0500
Message-ID: <20261124204035.2602544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112416-earthling-upstroke-d7e8@gregkh>
References: <2026112416-earthling-upstroke-d7e8@gregkh>
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
[ sashal: Replaced zref_in_nodemask() with zone_in_nodemask() taking non-const pointers, since zone_to_nid() here takes a non-const struct zone, and adjusted the loop-condition context that tested z->zone directly. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmzone.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12de..34a1d89486752 100644
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
-				(z->zone && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(zonelist_zone(z), nodes))
 			z++;
 
 	return z;
-- 
2.53.0

