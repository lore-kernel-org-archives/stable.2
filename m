Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552559;
	b=g9tPCGVzLoHlhgksEo7FVmxsFhnUplRl6NpA/LyKKvkM72YCXqnRNgoBC0EY3vT1tSvq
	 GF/hPPXbzjLHdhdGxLIhEaQoFFip885vTrcdRrMl/Rf9Gs18zOjdjNCdZYLljcJI+hzSg
	 ZK1RlHeellh0+1yeckJoGhgD1ss+IHo2uXb2i2FtWbtNH2Tl5vL2tZIU3IVAhaZFHDhEl
	 z/eGL8/Zzt2TpYqHJbW/F2Sa1Pn8JZPbsXPMWC40OFM+IjnkLv1A4KGFxxn5LIi0PBwPC
	 Vbf2wpVwus07Pj7onQFti6TV2bp+/7e+YGGkaBc7YB6fheGjE+j8XxMf7qikpprNirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XtFWlbgnPsv+xMGjc1zYtIiAplG9xUtxF0LjSyLU5tw=;
	b=ub+vnmEQksngiY3dErTxa7isKkiGEortPkc6daBulk01Vw2jtQ9KLfGdDzYHsRGjENo8
	 Lo1mOKt8GDRw1GjExIveAWP8r0XhYKPumxTDyTiP/4dFKojvx+5K0hP8tQrmiV+tMDykd
	 WKnRA73Rz7q2lk4F7EO6MgSt7aiTWipjVWeI2T0eDWToGm4Xt7awGqQebAmY4PMnIgLjW
	 ur2/VQ50PXIn7LjOUQG+ODDtdkpc9X5MAZJBcYsfeO0WRz5ddUao2LT4NIjbKJvhPnsQS
	 z1E+Put27IMYNP7RCH7bHmSpheX/2y60hyduw3L0E9erJ51MYlRVJhnkIMy/vo8WFQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j4x5/Vh8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD2606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4x5/Vh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5570F1F000CA;
	Tue, 24 Nov 2026 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552559;
	bh=XtFWlbgnPsv+xMGjc1zYtIiAplG9xUtxF0LjSyLU5tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4x5/Vh8Alt+FqcrMVegK4zjXeAOL3LJz+goOFQ//mSqLXHdqbFxX6ScMPYAYKD/V
	 GxcRFJwgsmAFH3hiadxDStn9CbVjAXrLEe+FJrmEtYdN5dSKVZDy8ED8CcYOabN3g1
	 BPL5tW8bcqxKRYlBShk60u4SBvM+50uMTiJOA72zjllR2YCnsXI/KrVBbxDc+qR9js
	 wLxHGfMyQDpOWqUl27Tvq1DmYCy2+P0TyiOGdXeh2OEVgkYKBKPugC0Tsu07wAYM0p
	 tDn5u4bxkjjoQgIqiQJx0IAb7vrFQ6+ye9OVexD2QGuT1rrW9XzRdyqO6LclW41xQv
	 a2/kA+eShxshg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
Date: Tue, 24 Nov 2026 15:35:56 -0500
Message-ID: <20261124203514.2613883-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112405-unbitten-moodiness-756c@gregkh>
References: <2026112405-unbitten-moodiness-756c@gregkh>
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
[ sashal: Uses zonelist_zone() to read the zone once in the MPOL_BIND case of mempolicy_slab_node(), since there is no MPOL_PREFERRED_MANY case in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c6c5682c334b0..4caf2f37f57ef 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1933,6 +1933,7 @@ unsigned int mempolicy_slab_node(void)
 
 	case MPOL_BIND: {
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -1943,7 +1944,8 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->v.nodes);
-		return z->zone ? zone_to_nid(z->zone) : node;
+		zone = zonelist_zone(z);
+		return zone ? zone_to_nid(zone) : node;
 	}
 
 	default:
-- 
2.53.0

