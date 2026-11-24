Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551203;
	b=c32T2NJlHt+Xz7i+d5Nyan2pPg/JGNCqjX2C2vj3jSV2A16cIMRwewPXRTkOfn7Hym56
	 cHsp+DF4ONKviUO1WJUYtQylgeQrZ4wQ9ZtqAyGc47XLh6+g0xrNywBqWHjbWfFfEPhwZ
	 S/YW++v5UF/enrV/zIzIX8qCykNDhsdc5xbFOMO88JXjvxd0AG58U+HVx0nxpWPz2DXIX
	 aiqla/jMEBUSdx6PXKcPYDjzs14oAcGwZWrdbC0VEbZEy8bJpbj3y4UKzd3Bw0X0F357o
	 kpgcxRNkPzJoiUEJ7Pck7XMvI7SWr5P7G7wpKJrqX8L0HDVhjd48re/oriPCitaDyOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DoySHs1TvFvgRzGkTUoHyGV+DXFi20sn+bQbFHGFB2I=;
	b=vihkh11yV+ChFiP0l9589zMjRyCUehGkitX6okmXJKVs4UI60h4BUa2WCYAX8XRNfoaP
	 3MPGVlulPO8/bD8C8Wojl2nmBsLKCinRVzQYRGgjij5mlT8AFfi+8IHuOJYe4wSQ8eRj6
	 ujFsvBpro1jqDteLOs8JzSwoJuU17qVjPWTQY/+Uobh3/NmK/DDT3apkHnpVnbMfmWbrV
	 yhJAimtb0zHbLygMT1R3pdwJSbYbkN/ctQJWd5Yxb+wD7MWxsGjQsJ0oPRGiLyvIGss1x
	 /TdXwfMG3/fGEiqXrNBpoHqtWJd1DqFDWbrkGSFCEZ0CS8s474el40OBRjdEpzF4xSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=im4415WK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E93606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=im4415WK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6D71F000C4;
	Tue, 24 Nov 2026 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551202;
	bh=DoySHs1TvFvgRzGkTUoHyGV+DXFi20sn+bQbFHGFB2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=im4415WKBrm0V05aeabUs29OajU0HzgjGo2kPECNINBY2vHJaty7FoHPlGorU5k24
	 rYOWayTC/pDp9kQd+v7rHva4HDnPu3eYsBzoM3ooNoeT2tC2ez7Sx+jJYwoWukxqaC
	 cY53BkPVMxvySGrIERdNy6YTRJ+awKoH6VSRIGiJxq/Iy6fuFnYgYJElOdzsoQ/Qt9
	 JsgyTdDCL5f5YJAeFYOfYVNmN6535TXBxcKWmZ92eXQt5Bqf0v60s0h7gsk9Wq/dDJ
	 HbC8AKszvVM0x8AkM86SJiEQgt8JVnObqRictTIm34rbY0YzAXfx+wfcIWQFmuzvMs
	 NuRuQ3Daqdolw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
Date: Tue, 24 Nov 2026 15:13:18 -0500
Message-ID: <20261124201253.2561038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112404-prudishly-driven-03c3@gregkh>
References: <2026112404-prudishly-driven-03c3@gregkh>
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
Depends on <20261124184032.2321147-1-sashal@kernel.org>

 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bfc94fb823608..527cb7e798471 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1915,6 +1915,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_PREFERRED_MANY:
 	{
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -1925,7 +1926,8 @@ unsigned int mempolicy_slab_node(void)
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

