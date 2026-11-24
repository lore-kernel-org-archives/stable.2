Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534630;
	b=VdaNwqLDfGashOuMiCWUnIBk/a/bI9ZoPP9JomvqSkPGFbJOAij1fiZfxFABDpjH0v4K
	 Pa5E2o9vK1CbwZ+S2dweZuZ5VAx8/uCxPqgMqU9u1Bu51inkXLazZxueUAPB4LwmzL9iW
	 A5BocKsxzz05hdcurVzDrhXMgd2qmnWqRd/Nuoxku02CLQGqmEj3zRYtIzgKYCFxSbC01
	 strON0S4F+Kubt8rnKLkyNzZnpH+l778LAOMwqbatPesaNPLpD/0v2gjbi9aPc+fQYyAz
	 gdtTTPMQIGl+B8r+2DJwozv2KvMoqi9fINDmDoLepdinA57rqNhit5pHTjUhJgZNPUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534630;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8iecvydYra9drqVm2MdAp+RlgSz8U2MjBWkPeEEzTQ4=;
	b=07cnCGHLcfCn1TqN0d8JNi+jb2DqIlhgL8ftZpbZP8fywmimh0hE1La7kgYckEu7wDBV
	 whSx+4K0GipoeGAg2z6KV1ifFCmHwtulBs8vTgBInHhQeTGtJa1dJwZRk812zb9eXTyy7
	 zMFUgX3tWMQp9EF4SB8TARESt1HVzF+R+UqiRYfQzCYUq3YOey537TQmly5pB3Y3I1mpg
	 27KfA9tjJnkyK6xGjCSYOEe6TFC2egAEA3XxTgWmI/OKeB/O2e7pkwl93OD+g5poIPJgK
	 T7GtSfj7USzfmy4KfQMQ0WJ2PR4KKbAdcQEzccIJscgod1NgMxwgLhNwwWaS+yHTY2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xdV1SH1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15053606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xdV1SH1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEC61F000D1;
	Tue, 24 Nov 2026 15:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534629;
	bh=8iecvydYra9drqVm2MdAp+RlgSz8U2MjBWkPeEEzTQ4=;
	h=Subject:To:Cc:From:Date;
	b=xdV1SH1ceCFYOjkTw2v/7lfMRIZoPwe0XwtpN+fcFrhA5UKp9zlPBAe6tMKlqc0MH
	 56xnNLTZQ5iFPGg5rVY3RNqho0GMqfArMu/pVriTUJUTVuE91aykgKBrqukSEv3eV2
	 PMiSXMSBck3UL9zczXcYunPtu9PuLk7nD9IVFSOM=
Subject: FAILED: patch "[PATCH] mm/mmzone: read each zoneref slot once when filtering by" failed to apply to 5.15-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:37:17 +0100
Message-ID: <2026112417-pull-overpower-f311@gregkh>
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
git cherry-pick -x e55119ab611a0e47595db7e1d2ac1e69f7a73ff0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112417-pull-overpower-f311@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e55119ab611a0e47595db7e1d2ac1e69f7a73ff0 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Sat, 31 Oct 2026 22:13:35 -0400
Subject: [PATCH] mm/mmzone: read each zoneref slot once when filtering by
 nodemask

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

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 9cc9ef588580..65880396f104 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,13 +43,14 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref,
-				   const nodemask_t *nodes)
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
 
@@ -67,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(zonelist_zone(z), nodes))
 			z++;
 
 	return z;

