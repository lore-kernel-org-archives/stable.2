Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534627;
	b=FbBNkf1wU6IDRDMDrQvx3LOT3UJ0Tnv/R3Q6PRe/BvQE5qHJb5BUZaClf9W4NNxv4gvS
	 znlR5xIGO2gCGSBvtNfMlMlB9kuRDv4Mr1nCzSDbr8Fb8Xsk76cnBf9GEX1S7b7VsHgQ5
	 svmSP/wO11VsIHpdQU8ZsYeMT95BkVUdTDBAgw3cxwUA0l8dp2d36n1FQ9I0XOyWyuE+C
	 IqGGAVxVmUlSLqsSiua9igEUYep1UdyE9VWCFum7EP8pz1Ix8ZZM2WKtvheWDggxQjmj1
	 3tyv6cxAcPje/kAIOSgHAd5tx4m2VvwoSY1/SSV8jbg+TZTRYZQD++5uRA/+S8VTJlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534627;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fEAqNwLGMEsyoG1IicimL8sBb+7N8Cr6kx4Ah20vMmk=;
	b=Bbm88aqU7leAhBBq31YdFImRwrglPoT9UUHDeeEtrYsjYxfMnlc3INJChjfTx4cT4zfF
	 8+QXt+SH5B6EAL5TewJYJ17ygPf5Lou2DgdHrN57ObV6FX1TCfVvEeCHVPaXuGmcwwvXt
	 oOZlqucXLBJtmCDfjHclKpBd/YHOaDzYBJEqEn6w3Ln2J6EwcrjzwGnMBFoNDU/MT/Uhm
	 +mfmwTzJt/lAWqXfalvE3D9yV+8RxUhaFHi8Kc9okeezpMmP1/Ppj4ZTyYVEYpSN4Efws
	 1LADXJ/MEii/RRjMjV1phvldPL+sUkQh3zlUZdvmgfi6/RsuIq8Nycfkqsa3jN42pCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JhHZrtD2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3902606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JhHZrtD2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECF51F000CA;
	Tue, 24 Nov 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534626;
	bh=fEAqNwLGMEsyoG1IicimL8sBb+7N8Cr6kx4Ah20vMmk=;
	h=Subject:To:Cc:From:Date;
	b=JhHZrtD2O/CVuoDKFDEPBpsBzAzNTWsOCr/OGQUPsymJ4BDqXBfsBqW/Fvm68MsZs
	 8JUwKWKSSwYbZQLdX6Ut6/WHtyB1cY+xmr7FjXPJ6OssKCKlXNKqAWQDDnoVUJ9YC7
	 bALUmha0Ey6QNNVbnlAdjVXT6W0HfMMCBzkeReTo=
Subject: FAILED: patch "[PATCH] mm/mmzone: read each zoneref slot once when filtering by" failed to apply to 6.12-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:37:16 +0100
Message-ID: <2026112416-revert-crafty-cfeb@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e55119ab611a0e47595db7e1d2ac1e69f7a73ff0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112416-revert-crafty-cfeb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

