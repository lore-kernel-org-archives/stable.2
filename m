Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D08443AA1
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450531; cv=none; b=bEVDLpQi7KKK4b3JU+KWgCKhgJQyUO8bLkxXuMYO18IsDz4A7wszDbNSmCvaN/+/n1ocBX3UQvl3wlf0K9XY25fdZRWdxtEE1glyDlUmi88iXOKo2haa+HJ+V/TXmHxplIQo0WhWWAY04qxu9RqujXsiT+Bl1MDQTWyGSzNW7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450531; c=relaxed/simple;
	bh=ByCe5taaeGNPiH9issc0xKg2I/0aXpQoaSE/4bc8FCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShckGxyOWrOPryP4gomrSCj31ncC14T05xqvIem1AmlPVwewl7iOgVv4rcpp81R1MxjpI9jgHCPwomwxyFI/3HqoksRFGWjNTCMOF39pzSkf7L9Ws0HJzI+0tzvAc5YsT6UM/5Mr10HaDG6tdKfUM/H9chWj/3GjNvkzb3pBdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrIhw5io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrIhw5io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF631F000E9;
	Tue, 11 Aug 2026 12:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786450530;
	bh=h8L7iMHNm2GpV+3UFeQae6IiYjmyEH/BSBnKEls9vh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SrIhw5ioYYKl9wedKuZvjMaByOv+Oa4fy7sW1CEM+d/9tKq2LFhMjZ7YpHz4fz84r
	 U+hkN1XqnV0TDf4khR6FF63oNLuQjRxaJ71M3pH1Ru/nT09FBuu1j3XR7GRVOkZI7u
	 lKlq2+VOVmj4e8hCBDH5EE4oEcSiSQQcJZ2p0Gx0I1supwhzNe52EmgtfScw9V4uOx
	 PnGmoGVaycFCpIpep4yT67WZCnnH5lPgcL5aJfo0MQcIB2CjquQVT0rUWTniJEoUwT
	 pWdAk/0NdxCykyK6zHkSyHtOWGIWXbddLEbHIz84VbROi8FKzQKyxKDhn6+emyZgZT
	 g0cxGT+Mr7OVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] net: pktgen: fix proc entry use-after-free
Date: Tue, 11 Aug 2026 08:15:26 -0400
Message-ID: <20260811121526.2373725-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811121526.2373725-1-sashal@kernel.org>
References: <2026080501-smudge-pork-db82@gregkh>
 <20260811121526.2373725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit 817ff6efdb7f484ea547218e11e17d8e43daa3b4 ]

pktgen_change_name() replaces pkt_dev->entry while holding t->if_lock.
pktgen_remove_device() removes the same entry before
_rem_dev_from_if_list() takes that lock.

This allows the following interleaving:

  CPU 0 (NETDEV_CHANGENAME)       CPU 1 (kpktgend)
  if_lock(t)
  proc_remove(pkt_dev->entry)
                                  proc_remove(pkt_dev->entry)
  pkt_dev->entry = proc_create_data(...)
  if_unlock(t)

The kthread can pass the stale proc_dir_entry to proc_remove() after the
rename path has freed it. A reproducer with a widened race window reports:

  BUG: KASAN: slab-use-after-free in proc_remove+0x78/0x80
  Read of size 8 at addr ffff8881478fea70 by task kpktgend_0/67
  Call Trace:
   proc_remove+0x78/0x80
   pktgen_remove_device.isra.0+0x11c/0x4c0
   pktgen_thread_worker+0x1214/0x6bc0
   kthread+0x2c6/0x3b0
  Allocated by task 95:
   __proc_create+0x204/0x790
   proc_create_data+0x72/0xe0
   pktgen_thread_write+0xd61/0x1510
  Freed by task 28:
   kmem_cache_free+0xcb/0x3d0
   proc_free_inode+0x5b/0x80
   rcu_core+0x50a/0x1850
  The buggy address belongs to the object at ffff8881478fea00
   which belongs to the cache proc_dir_entry of size 192

Move proc_remove() into the if_lock-protected list removal helper. Keep it
before list_del_rcu() to preserve the ordering required by add_device().
The rename path must then finish replacing the entry before removal, or
it observes that the device is no longer on the list.

Fixes: 39df232f1a9b ("[PKTGEN]: fix device name handling")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260719145740.2888967-1-nicoyip.dev@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index f558e5d407821..cbb916f9edcac 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3886,6 +3886,7 @@ static void _rem_dev_from_if_list(struct pktgen_thread *t,
 	struct pktgen_dev *p;
 
 	if_lock(t);
+	proc_remove(pkt_dev->entry);
 	list_for_each_safe(q, n, &t->if_list) {
 		p = list_entry(q, struct pktgen_dev, list);
 		if (p == pkt_dev)
@@ -3915,9 +3916,6 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 	 * list to determine if interface already exist, avoid race
 	 * with proc_create_data()
 	 */
-	proc_remove(pkt_dev->entry);
-
-	/* And update the thread if_list */
 	_rem_dev_from_if_list(t, pkt_dev);
 
 #ifdef CONFIG_XFRM
-- 
2.53.0

