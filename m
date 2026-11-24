Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534614;
	b=Q5Gy/OBf67zZF8NrrbyRxIHcvvvwWLqsBp3l986BuKWuDFL8LtD0NOoEmOfaOoPrQ5kM
	 3ca1BtFAGv2CtsNbkTWuvJ6Qyzkkx8mxrT2pi9KGbNK4V87vGsjJnz5lA0m7xsAnROWXW
	 cW70aPttllvllFdH3EcMEkNGugMjfGPbRrJyeCh7PT3/hNBzYlKvn9FhkVbj/DbbFD6zm
	 Ln8PcdvrwxK5HLixfuiCufWIFWcpA2/T3TNQ0wgMmrcYdGMiqer4AXvdytgCr+Awqkp3v
	 +S9OoDPtLMprT4Jv8QqAPrE3s/6kXIStjq8GHOhQK1GS9u4Mv5dmfjx1peOhRSKmdQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534614;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=r+WO1B0lMr9ricMvfn7z5wX+psybrCRyBPpYkvp8TNg=;
	b=KZfhCcdOBE3QL5g2LpuzwItL+ze10r3IUF+oZlMzFKObbfxJZ5ARw+4Pv3kW9PsONE9b
	 GY/F3ZXmWzOhQ07yV8EnbzI6wO1VhEwGnwjwn8AGev8hH4ahLI7wfTb/WHto9e0P/mqOd
	 Zftx5fsi6p48mFwBx6WjjrMoG+420kuaKaKxagVFcBLc2TofIIvOflmgaIk+yZe8ojrcY
	 BKWSKV5T2kcj1ofChFpcgPjz+U5cIMn7uB3PaCdnjnL0HxcmhBnU71CFXC1NIuEYYONZl
	 h9S2ozZAp6R87hS1YNScVzvbMUArAueC1XUKNXILh93U0Zc7zhhEUhGeSpmyHRUi24A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fmQhTAOC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4D606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fmQhTAOC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E67A1F000D4;
	Tue, 24 Nov 2026 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534614;
	bh=r+WO1B0lMr9ricMvfn7z5wX+psybrCRyBPpYkvp8TNg=;
	h=Subject:To:Cc:From:Date;
	b=fmQhTAOCbOvF/pANeydZWeSLq4wAyCz0RvwIDrNl49oo1rXJsdFMbOcuo17+XgiDx
	 CLeh1ixWIFehz/HzFieVaXbHuiBeGBHftiA2jF0bcr/MXdBwFoyjgp2I42E/I1NrzS
	 zlGIp2HeqxXvm9GvFYS9CQpKbV+RfKyJMizEBHY8=
Subject: FAILED: patch "[PATCH] mm/mempolicy: read the zoneref slot once in" failed to apply to 5.15-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:37:05 +0100
Message-ID: <2026112405-defuse-expectant-b8c2@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4cc1bcdf2e4ebcd319005ce2ea132489f6155139
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112405-defuse-expectant-b8c2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

