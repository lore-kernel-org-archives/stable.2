Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550407;
	b=NBJEILweTZjbZuOCbZ4T199DVsoY+rdQMM04qwkOv6JojTEwgInVWbFgKc6m51K1EDkO
	 XrJtpK6CWt6HEcTFRDRpIhURMzbqnVhQee7ZRqpWD2LL+2ScU/OVHB67p+HLCq1JmbJuR
	 xnyvgiM7AbkIfT915FOjCytpx4NXpkZZepQpB1TJHGrCvm9HqRA/+LrzMmRrYfEpwQrm3
	 iflQvlD/EwIA3MNeAhkdFK4WB/IYlRha8O1okmlN/7j4aEbMhYEM8M0GtNa/CEtStH2QZ
	 RekpS0koRTLjIsPiA6o5m3yjPReatFslhWMFrPnEOGMi6XVjNry0WHncw/3H33MN03A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550407;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EHYEDXXj/N/26AMMcI+zzzmQYnBdbl9Y/U++Qq+cAoo=;
	b=qZmOC478MvTug0L0k/ntts2b/zu4iXzWExtG/aAtWz7MTEEHG6dj0C/JzXZeKzeaynPh
	 pu9UHyObZN+6hSNMDGuhu6EhUIY97VWXuoEarLmbgEvMxv/eHx49I8iX+WD5+7iRez7hG
	 be+N1Dzw8Ke01J46uaqRH79R4dwnr+alKUQj1C7asvR7hVx1PNYqyBu2RS/RMYmgb54yj
	 +PkfJiEMv6hs/TGdHM4sqV+gZlc2oCy/Nh4ECe1jyPKxPFCytXnmVBxHmDNI6ZCHlXvaB
	 EivU+dibIMCvYIVUXpOXKYPLCF4yJ61AF2T73YR7wCYiRfqvfz5/pG93f029tO40rKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDhwpEkX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27510606A32C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDhwpEkX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1367C1F000C0;
	Tue, 24 Nov 2026 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550406;
	bh=EHYEDXXj/N/26AMMcI+zzzmQYnBdbl9Y/U++Qq+cAoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDhwpEkXJrmmkpbbRIzPslaLuVnH8Fc5VAngi4s2rpf9KxbkM7aLm+FzojQkJgcT5
	 G7CqfMZp3cxJyUz+o0kGN/gZCFO/nGX0G/bxZZcgZKCZINtK0IR2Pb85k6dstYaNPw
	 gkh3tkqogbLdSDhoQvymFLesdFuTFZqG8oA1VbirdFtsBSCUAWBTQpvy0V2aJxogjk
	 D1hRpvZBwTqW244IHes8Kf81vKyW3zo2SKj92V6vYZRMjLdaT88hvsTYq7KcwvHzNM
	 xO4IyVqC7ptI1uyGG9rTzt5ZxCRSvvbB0ZphM50jL8fZb+s6guLJ2K9QlEEOjcFYdn
	 Fch77q6dBRyUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
Date: Tue, 24 Nov 2026 15:00:02 -0500
Message-ID: <20261124195947.2538416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112404-smashup-salute-6590@gregkh>
References: <2026112404-smashup-salute-6590@gregkh>
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

[ Upstream commit 4cc1bcdf2e4ebcd319005ce2ea132489f6155139 ]

For a bind or preferred-many policy, mempolicy_slab_node() tests the
first matching slot's zone for NULL, then reads the slot again to look
up the zone's node. Offlining a zone's last block rebuilds the
zonelists in place, so the second read can return the terminator:

  CPU 0                             CPU 1
  mempolicy_slab_node()
    zonelist_zone(slot 4)
      = node 2 NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        slot 4 = NULL
    zonelist_node_idx(slot 4)
      zone_to_nid(NULL)

Current GCC merges the two reads, but nothing requires it. With
mm/mempolicy.o built with -fno-inline -fno-ipa-sra, holding a bound
task's slab_strict_numa allocation between the reads while a movable
block earlier in the zonelist goes offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   kmem_cache_alloc_noprof+0x294/0x610
   do_getname+0x34/0x230

mempolicy_slab_node() and zonelist_node_idx() are tail calls here, so
neither appears in the trace.

Read the slot once and use that zone.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://patch.msgid.link/20261101021340.2251928-12-gourry@gourry.net
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261124175924.2153167-1-sashal@kernel.org>

 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6da52764698d4..becdb230131d9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1916,6 +1916,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_PREFERRED_MANY:
 	{
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -1926,7 +1927,8 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->nodes);
-		return zonelist_zone(z) ? zonelist_node_idx(z) : node;
+		zone = zonelist_zone(z);
+		return zone ? zone_to_nid(zone) : node;
 	}
 	case MPOL_LOCAL:
 		return node;
-- 
2.53.0

