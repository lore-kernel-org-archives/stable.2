Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534708;
	b=3X2ofhVeurQsZ56ZqG8iBYrSIVyf33eu/ctvSUSX21MTB4U7QtUCmGlH/6XvzPtuSw/t
	 o6/lDDmJ4ZQYQ0ZFDr9P3kZTyzaPhnGqGbrfZKvDcEVDxBef2z0edEFUErJU8rhxu5DQJ
	 AnwWetV+ISaXJtaM+WVRmZnLWui/Nf2nrxfSKDJhtIS4OzPaHGBObmXkYGWbpdin3cEeF
	 J8plUxF7pa/NoIeAPjZRYMxvgbbQkIGda/iWeMQiB/53M76tZbCsKTmZINEb2zotH4Zk0
	 xylom6Nwx1o91mh93qS6fIRF4HvhLlw9OfYGLLniTvh/AKWPsBtW6t2XI7lccDUKmVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534708;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zCUFeNqYy5RXwhw1/VefdswJGLY/WLSW4+uAeWESDTM=;
	b=5EJvL16jmPYUsk47X6igsV33VB3OMSDCZ/nSiTZERhcrPBRJHsjsstEU1gpoMol8VxNI
	 1/xEmVxPkQ/7U8nydMTJEcx/1FUYzXiHKPeWullu6k3Rsdu5tX/Ma2CPOb6p9Uettverp
	 6dMCw35YHFLm/l6YSKMlOkg6ZIbN6NBNkH38kIscqz73E0zo+v82/B/F9TJvzKq0vUIJS
	 cCxUdnkLi50wzlkSq/v76wV2bANOvVWcdtKpKPVsvisAyzJ4WTOcBwvtcUC5bMI4arGl+
	 R/GNjJJYMG8fk4n1iphZQfXDTlXDv+0nzpvL0EQAYRN77Pomo01tWhyxP/qc1W4HMdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yL3vcH8j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D63606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yL3vcH8j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6741F000C4;
	Tue, 24 Nov 2026 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534708;
	bh=zCUFeNqYy5RXwhw1/VefdswJGLY/WLSW4+uAeWESDTM=;
	h=Subject:To:Cc:From:Date;
	b=yL3vcH8jmn+WxnjrJXpTZS3rt8XL8csBqzXiZGRcTGI7qADqb76F1kPqFNrtQR5bP
	 ETgQL8bM6ogqe3MY31QyCbnhUXBZi3IaL1WweMlR8oz0tN09vG44ANyKE1e3xvDW6L
	 5D2mIuKUc1CPVTJPPdJGUcbNZ/XMrMji+7MYpe6Q=
Subject: FAILED: patch "[PATCH] mm/page_alloc: don't undo another isolation in" failed to apply to 6.1-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:38:45 +0100
Message-ID: <2026112445-quartet-reseal-bdc1@gregkh>
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
git cherry-pick -x 7d9c29ed8feec8bfbe5e5f673ba2b5926da11375
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112445-quartet-reseal-bdc1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d9c29ed8feec8bfbe5e5f673ba2b5926da11375 Mon Sep 17 00:00:00 2001
From: "Gregory Price (Meta)" <gourry@gourry.net>
Date: Tue, 27 Oct 2026 00:22:02 -0400
Subject: [PATCH] mm/page_alloc: don't undo another isolation in
 alloc_contig_range

An alloc_contig_range() that overlaps a block going offline can leave
the offline spinning until it gets a signal, holding the device hotplug
lock.  When isolation fails, alloc_contig_frozen_range() undoes it over
the whole range, clearing the offline's MIGRATE_ISOLATE too:

  CPU 1 (offline_pages)               CPU 2 (alloc_contig_range)
  start_isolate_page_range()
    blocks are MIGRATE_ISOLATE
                                      start_isolate_page_range()
                                        -EBUSY on CPU 1's blocks
                                      undo_isolate_page_range()
                                        blocks are MIGRATE_MOVABLE
  test_pages_isolated()
    never succeeds again

start_isolate_page_range() fails only on a block someone else isolated,
after undoing its own, so this undo only ever clears another caller's.
Return directly, as before alloc_contig_range() went pageblock granular.

With offline_pages() parked after isolating a DIMM block and a 1G
hugetlb allocation made over it, the offline on base still loops 30s
later in 4 of 4 runs:

  offline_pages+0x5b2/0x1570
  memory_subsys_offline+0x17e/0x470
  device_offline+0x250/0x340
  state_store+0x88/0x110

With this patch the allocation still fails, and the offline completes in
3 of 3 runs.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261027042204.3741307-5-gourry@gourry.net
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6f10cc628177..cc291016ea03 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7364,9 +7364,13 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
+	/*
+	 * On failure this has undone its own isolation, and any other
+	 * isolated blocks in the range belong to someone else, e.g. offline.
+	 */
 	ret = start_isolate_page_range(start, end, mode);
 	if (ret)
-		goto done;
+		return ret;
 
 	drain_all_pages(cc.zone);
 

