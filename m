Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534608;
	b=taAwkmF4jwhNFRg5SzwHSOc+TIACa8yXt8Z0M4nVM3x5avR6EgNUp6zsl+MVAVdN+anq
	 Qao3LoQ+BKb2iWLRcA9dsBuk/XNKYyfZyweS1bgb+iS77iG83Y/V2yvaiUpSLOmExGdUx
	 W5RlZZU+l+7uGmV4P/TnwZkJmoZEK1Z5lFjy1p5DK1+PZfVNb151sxb7sjsGxlR61ajXJ
	 Z0RvVSxCkdNQ5FhcpYxi682fBFd+RPaztqOz9Xa2CrD2kBQgLK50rIs58ni3NrDjQGPXV
	 l9qZV3r58+/Hbgu7lCmYu90I6DZThe5YDvtN95YSXg3y3fihv1wt3EYCWEFiVxSARSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534608;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=co11mwbrj0WgbOjlVgBVCShbrYXJWnS6EMZnKIsywC8=;
	b=kQ+XSJVHfliK4z8M/xS5i33jKp8i/ORPMwDUAW7go6Vb5Ka2HbPjmOqVM0DiPphWuldg
	 +N0Fk1X8Ya9SnkVo6k6CDgy75DHWwy0HEpCc0J1JTst3nIN6v2xrCV6PCx3rsrxlhiyZg
	 rAAuY3t4KSwQe4SDDmIY+Z9/xf+qLQ77B+93KbH3kYScFjnTXgZ/PXsvcsVYAxBVOkJIj
	 uG88zLO9spN8YrEgb+6zOUpFP/3fp9QKyaGXDrNRbiB2/VHUgM9HB1OWb8KouvhNBvUzg
	 yaGaJSiXJzrzIj9gu1ZVC3hEswJT6FkPhLgIJAVD7witVI5WQzfhGgxcrIn02GVu4nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="zf/Y1Y4f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E31606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zf/Y1Y4f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76831F000C4;
	Tue, 24 Nov 2026 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534607;
	bh=co11mwbrj0WgbOjlVgBVCShbrYXJWnS6EMZnKIsywC8=;
	h=Subject:To:Cc:From:Date;
	b=zf/Y1Y4fQN/4GEn/d//xawOMcyOBnrMY/s7ST9nRXBc9vfXq3WZfoqnzFS+AoQS5A
	 pWX4aIAMblnHnpSwGvuOdIBS3YiwyzdjjrkN7KxdDp2ky5c4LKuuuhyEe/owM4YYmE
	 gidtLs747+oroSRM0iKCDviDfUlr+iZn4V7mP98E=
Subject: FAILED: patch "[PATCH] mm/mempolicy: read the zoneref slot once in" failed to apply to 6.1-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:37:04 +0100
Message-ID: <2026112404-prudishly-driven-03c3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4cc1bcdf2e4ebcd319005ce2ea132489f6155139
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112404-prudishly-driven-03c3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4cc1bcdf2e4ebcd319005ce2ea132489f6155139 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Sat, 31 Oct 2026 22:13:39 -0400
Subject: [PATCH] mm/mempolicy: read the zoneref slot once in
 mempolicy_slab_node()

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

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670d..cd63c3e2c029 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2176,6 +2176,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_PREFERRED_MANY:
 	{
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -2186,7 +2187,8 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->nodes);
-		return zonelist_zone(z) ? zonelist_node_idx(z) : node;
+		zone = zonelist_zone(z);
+		return zone ? zone_to_nid(zone) : node;
 	}
 	case MPOL_LOCAL:
 		return node;

