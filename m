Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534705;
	b=J3qEArIZz2RQXbTsn4LbX/llwpBNAgpKRyPJaFBCIgNgBUzwKcmZxhrhwjtH9yGsBMQu
	 0esaDkB0nP1LBjKobOXJWyN0ri5hhMxddEaroUSy32IHD2oXQzg7GH+/FPCHvWGCPbkjP
	 WelKd6ZzjvXRLAD/o1mMacXMzdOMDKaw9ZqeCmGNjQqk42hdRLL8qkbvfdCh9pyUWpEjT
	 2x30n6IWN5amwp3bpu3S0NNRCrmPCeHfYnZmy7qaG4f3+B2EuBUpW0DMMjRT3ZAtcHK6R
	 NmQHzuudgVQLnJsDOfUdB02Xz/U5oxDOaAVgfXJS4KcgS4mZSnE9kox+fC1LY5fPWnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534705;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=InVqV/vaggiU6gFEBudgv65yZvBhkR6aPNfJTeAiXDY=;
	b=fOBbMkYL82e7812P8+w/WiSPEzdBtHFhPKzTBYaUo04Y/eXrt2mATUzyqp/i+T+7dTT1
	 k3Qo3pv4zNZITUeeFXP1ZsNTyTQyhdurX2LTylFISYy87DTByaILaaGQwK062PVwidRAG
	 WXHzdNO6Jk8I3m9GRho/+q3y1QneJ+hUlq71HZ81yEUa8auoUwU0Z2OEDx/fc+85t+m9b
	 mfV2DRZrCBl1eP3H3EBgwh/BNDcvupTL5tSnJ2szme1zpXfolkEmwv3VX9GOiOpFWut4p
	 gelE3g5Gqynb2LiWO6n9AG0/o31napuV6ef53G8eHG78m798L2oV72XjXWp+7JIVuNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="wBG/JKLe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C36606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wBG/JKLe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B91F01563;
	Tue, 24 Nov 2026 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534705;
	bh=InVqV/vaggiU6gFEBudgv65yZvBhkR6aPNfJTeAiXDY=;
	h=Subject:To:Cc:From:Date;
	b=wBG/JKLejobonu8gkjpl8Zg8E4o+3ckTXI51mcRtMXzomxq4QjUofsgCNL86NDuiI
	 ScP63PXbOfkIVYsA9eoA8somhGBwM5nUYIT9kuV4KCa3AF992LU3U0LMLQ6cVewJmh
	 d9JTxTLg2X0R2SK1dViXsoMrkdRm9vKzRbm3jJJY=
Subject: FAILED: patch "[PATCH] mm/page_alloc: don't undo another isolation in" failed to apply to 6.6-stable tree
To: gourry@gourry.net,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:38:44 +0100
Message-ID: <2026112444-removable-storm-556a@gregkh>
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
git cherry-pick -x 7d9c29ed8feec8bfbe5e5f673ba2b5926da11375
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112444-removable-storm-556a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

