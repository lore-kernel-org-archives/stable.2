Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534624;
	b=aPwwd+SLMhHAoEE5L3sGw+txf8U/sy3SyF2XYiYziJILupiLONBOjytCehPgjT17QjM1
	 CnNlYUdZ0K8wNOw7nCYUHJzgNUXBNYbMKsZLBHwg1dgxTHMRFKOCJgf4i3U729m+I6j9B
	 1+1UsKO3Rk2pkwGH/s8Q2sVfxYpSoOt+qqeQG0NH/wY8i3nPof0/3hOu7mx9GWk2OxM9D
	 UquzvwQC16rf8KHFJ+1ay6KPLAZspfp+TGnC5XeRNUOrtKxXtifDjie8c9HFxVGogGxyu
	 dTjVFUaZYFOULNihNQpIEmzE4n5Odm7LdtrJaYRTgnTof2981KvU2Mcj+l36tnSkYWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534624;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N6E3RaKWXggjGY7x4dfgYWdutlsRG1WxAecjvTljHhw=;
	b=aoCeXa4kIt47TIdPBWbsvHBqki7H8KHRNGA56c+cZpaPZBO/NZSmRERtdXWEw5YIHkgP
	 kZTIoxaNdUxPksjGgaGawgoGWAP+4d0Oo3EcvovKqTNK3SFYoZytfVGjHOw9sH4G7Qsrb
	 W7hw79HElnlEO40bX8jfKKQPq+O7M9DylZTfmUsefw66dqbGGR0m62UDiDhFv+Qc8bSE7
	 qnEV2CtwV9dWVLVjki9YgmAhVu85T8cbXVzf5BzdX+zmcuc7iX7raJ8ONZ9eFgUH3dhiY
	 JfOgP2vZFqpjJwxvALJy6hcAzjzKaEOY4HGsV8QOAIgpxWuZMiPT0a+xY4EzUhMTZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="FR/DUfFO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC0606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FR/DUfFO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08821F000C4;
	Tue, 24 Nov 2026 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534623;
	bh=N6E3RaKWXggjGY7x4dfgYWdutlsRG1WxAecjvTljHhw=;
	h=Subject:To:Cc:From:Date;
	b=FR/DUfFOFWMtlwk8aMsJEqMp8Z8rgg9O6EBZD1n8kphqk4L8C3qLMfmTUFIbchXta
	 kQDFo+I4LLjBJAyIN9AdJ2xFoVW3g+S+RPkDn8poJFKXqhZfP5+Z2uiMTwjE658xjT
	 dK3ve/ypdSuEmiabSA9DZmIpZ0fgzDVdQgLa5rqE=
Subject: FAILED: patch "[PATCH] mm/mmzone: read each zoneref slot once when filtering by" failed to apply to 6.6-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:37:16 +0100
Message-ID: <2026112416-earthling-upstroke-d7e8@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e55119ab611a0e47595db7e1d2ac1e69f7a73ff0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112416-earthling-upstroke-d7e8@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

