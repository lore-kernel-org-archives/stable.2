Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069637;
	b=rJ3LnfJ34OW0x1xpEnD9nojEydYEAU4LzdaD+WuVaRLNFo9BoDsgfU1mXdYxxnddUW7D
	 NeagXeFAGA3gVXnUhO48p+GuWDzvPxVuWRVFphe+mB1Bzt7P5fzMOSOypm26Gmz9r6qzq
	 c1tlWSbIP2SyG3zLdjy/vr6fJiImnHvdlwgwUqysvvXq2JGYzrGpVAJ3+3FZ0HNJrBExi
	 PzIuBrGxe5MC51XR841sZwD9SrEi4WU5EGdaloKxvlr8WfofKtw8l+GIqWuX8dK9kmnX7
	 O6PT8x95v9HHCvOp3aLyyg/emXWySYPmvuqF7ShDW/HpZb4in5N9rj5/k/VIgvePwcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zXjVpleUX/UUgVHHA3+E1ewAvZlUSAbbu6EQ+dmYP8E=;
	b=CkDwL+wlmD18Cu8IqPPNUs7TrCnfAB1wCxVxR61ElaRY7k68muZqbEHLN4fq050oKlc5
	 rHkA2VurE0d+ksMh5lh88TSBg891Wywt9auAom3ARqaIKhvzQVO0jpFYW44iDs4sFIdNv
	 HWRen3DPJbJeRItR+FJnsQx8S/pgw/rdhcqWz5VzKfbe2CMPAYYi9x/uZMqESvckftPaL
	 D/Rd176XcgRGqleB4o2+OHS0ukmFQEQESORnsmpxbRgLL2WE/xrCWlHvNk43b/vblTTIq
	 PLUjil3TgOGJ6D3XPeATKuOUMc92t4m6MR1GShsGzyT5EOJVe32xpVMOe66pnKurHIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ip3oouea;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B14606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ip3oouea
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea0efd636dso29092285ad.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069636; x=1793674436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zXjVpleUX/UUgVHHA3+E1ewAvZlUSAbbu6EQ+dmYP8E=;
        b=ip3oouea09/1y5Bmhm6v8ft1VxQM3AmLovPke52LO6b4H2twKhQ5WIktroxeuv3N7m
         zP0IljXUSwc3khL35a7df0xIC90Zxc9OHK8vvZisYsl/dlGvIvKCxwe94lwwK8gCLX4K
         ww3+LTi78lEiU0cW9crHqtXrtAj7El7Ssp1TYf/fD48Baxv51tZLdlmKUACHnbBilTXb
         HqJ47Da5XIRcxuc8N/0CN0mlW3u5m1ccmNPfZQmratpJVhiDxURiira4kndCxjZsDqev
         Fxmx83LSa7ECGD50Ad0B+pahwwAA9IL32vH6E90Pdt1ieXjC6+C5mVqGIMx3J21gXfcS
         bqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069636; x=1793674436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zXjVpleUX/UUgVHHA3+E1ewAvZlUSAbbu6EQ+dmYP8E=;
        b=2M2j582GhJnKbAjL6tLHNix1ERpLuhZppSBKy6Tg9Dq+9VkEA80ed9jcdiR07/OcWc
         xl6J3zUf8BbpmIb806zeLYnYjg6h40Co1RxZ8qbEWfcsc0NI9CdsfU0ksPXP6JZ+Eag6
         C7N8LwOWpaS+hPFP7bZhczq5gV0IOaD+wcYqvtXMY9ZstGRsjPx5g/1ian4HlVFXY4LG
         oxGHvKrfnHJp229PSYsyZaZ8w3PurAsjNQOMn47UQto2Fh21K6h4XzhQKDa46XfJOSOk
         Qk/5DM2enHhs9aRaPpkODbHNXI6PhJNuTX6CiOWN+qlRpl3vC8iqfwRd8MXOfBMJnWoR
         WDeQ==
X-Forwarded-Encrypted: i=1; AKwUvByRdN80bFWI9Dt8kFAG5h1aXWh2Sa+Dd+H7fBQg81J8h7Va6TkXOgdb9Y/Rs+3jOq5mLeuQNCU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeNH5e7I+tzHw4/+XH2SkmloBG/58NGRUIoUAwit+/b4lbF8tt
	4k/jHkU3I9ajdAlUJpN1f8BWksD21guxxT3kQCsGUNeplVfcuxOZsOEV
X-Gm-Gg: AYBFou2bBgepZ9EYp8k8m1jTqxTBNmekF8FGbQtG0K73KHao9m4Nwa9c6Qbf8h6xx22
	nhwONyV2rakzqPMWhbGGymIBSRuhzPTIrW9+I/52w1tWEvrjcC9XSIXiD3+DFKV7kw1yJ4Njqzs
	bNM0C9sr9PP+ZOeoFAKHuMLB1U3zBB6r0i5p/ZK3hE0KAIn7RFm7Fq/T15Smu3kPDTeP4Sax7pe
	gVoTa7Vrlay7j2UWnMPdTALSpPkwfVCvCeVEw3J8grL5el+9smAx68sHeusCQSBCDabt9gtllwv
	jeRs6R95+Hr/+Tjf8CnVwiVDAtoknURSuuL5bL6+95CjeeHcj9lMlt6yp7Foz/0gADWqxdt1Iyz
	xH/rWTSqOVsrlLob+UKHmq2DIgiDIaVTFZaOkZz60Rs7t/oke31b05SNVYV1vgLq2IozzHrxru0
	8eXz7iuqpFBnnVTOsLRy9mKOtn2OzbXysLPgnm86ZbI9P95usNsr5dPtJJcrRdu32YOOSJQx8es
	ke5K8ZbPTC75ZmgFKP7pEIW0rXYrTpWGGcjN0e0daJpSa8gRovqXxFUucIpNM9gkeE2jZ8u
X-Received: by 2002:a17:902:f647:b0:2dd:ad74:ac1d with SMTP id d9443c01a7336-2ea9c7cedfemr76904225ad.24.1793069636290;
        Mon, 26 Oct 2026 19:53:56 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bef7d1sm2153635ad.39.2026.10.26.19.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:53:55 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2/dlm: serialize migration MLE cleanup on failure
Date: Tue, 27 Oct 2026 10:53:50 +0800
Message-Id: <pm-ocfs2-objects-candidate-0038-v5-5e414ac0c701d2ccd4b3@gmail.com>
X-Mailer: git-send-email 2.34.1
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

A migration MLE has a base reference for the mastering answer and an
in-use reference held by dlm_migrate_lockres(). The finishing assertion
consumes the base reference, but migration failure drops it again
without checking whether the assertion already consumed it.

The target queues its migration worker before it acknowledges the
ALL_DONE packet, so its finishing assertion can arrive while the sender
still waits for the status, or after dlm_send_one_lockres() has
returned a connection error for that very packet:

  Old-master sender                  Finishing assertion
  -----------------                  -------------------
  publish MLE; take in-use reference
  send ALL_DONE; wait for status
                                     take lookup reference
                                     unlink MLE
                                     put lookup and base references
  send returns a connection error
  put base reference again; free MLE
  put in-use reference; access freed MLE

dlm_assert_master_handler() holds dlm->spinlock from the MLE lookup to
the final puts, and it takes dlm->master_lock around the unlink and the
puts. Decide under the same locks: if the MLE is already unhashed, the
assertion consumed the base reference, so drop only the sender's in-use
reference. Otherwise unlink it before consuming the base reference so a
later assertion no longer finds it.

Use the same cleanup helper for the pre-send failure, the send failure
and the target-death failure paths. The sender's in-use reference keeps
the MLE alive until its final put outside the nested locks. Successful
migration retains its existing in-use-only put.

KASAN report, only the relevant frames are kept:

BUG: KASAN: slab-use-after-free in dlm_put_mle_inuse+0xce/0xe0
Read of size 8 at addr ffff8881190e3c20 by task umount/593

Call Trace:
 <TASK>
 dlm_put_mle_inuse+0xce/0xe0
 dlm_migrate_lockres+0x16af/0x20d0
 dlm_empty_lockres+0x60a/0xbd0
 dlm_unregister_domain+0x53b/0x11d0
 o2cb_cluster_disconnect+0xa5/0x110
 ocfs2_cluster_disconnect+0x73/0xc0
 ocfs2_dlm_shutdown+0x311/0x440
 ocfs2_dismount_volume+0x696/0x940
 generic_shutdown_super+0x15f/0x490
 kill_block_super+0x40/0xa0
 deactivate_locked_super+0xae/0x120
 deactivate_super+0xa2/0xc0
 cleanup_mnt+0x217/0x450
 task_work_run+0x144/0x230
 </TASK>

Allocated by task 593:
 kmem_cache_alloc_noprof+0x20b/0x5c0
 dlm_migrate_lockres+0x20e/0x20d0
 dlm_empty_lockres+0x60a/0xbd0
 dlm_unregister_domain+0x53b/0x11d0
 o2cb_cluster_disconnect+0xa5/0x110
 ocfs2_cluster_disconnect+0x73/0xc0
 ocfs2_dlm_shutdown+0x311/0x440
 ocfs2_dismount_volume+0x696/0x940

Freed by task 593:
 kmem_cache_free+0x242/0x580
 __dlm_put_mle+0x4b2/0x660
 dlm_migrate_lockres+0x1690/0x20d0
 dlm_empty_lockres+0x60a/0xbd0
 dlm_unregister_domain+0x53b/0x11d0
 o2cb_cluster_disconnect+0xa5/0x110
 ocfs2_cluster_disconnect+0x73/0xc0
 ocfs2_dlm_shutdown+0x311/0x440

The buggy address belongs to the object at ffff8881190e3c00
 which belongs to the cache o2dlm_mle of size 480
The buggy address is located 32 bytes inside of
 freed 480-byte region [ffff8881190e3c00, ffff8881190e3de0)

Fixes: 6714d8e86bf4 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ocfs2/dlm/dlmmaster.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 612969867ff9..57119b195cc1 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2525,6 +2525,27 @@ static int dlm_is_lockres_migratable(struct dlm_ctxt *dlm,
  */
 
 
+/*
+ * The finishing assert may already have unlinked the MLE and dropped its
+ * base reference. Decide under the locks the assert handler holds, and only
+ * drop the base reference here while the MLE is still hashed.
+ */
+static void dlm_put_migration_mle(struct dlm_ctxt *dlm,
+				  struct dlm_master_list_entry *mle)
+{
+	spin_lock(&dlm->spinlock);
+	spin_lock(&dlm->master_lock);
+	__dlm_mle_detach_hb_events(dlm, mle);
+	if (!hlist_unhashed(&mle->master_hash_node)) {
+		__dlm_unlink_mle(dlm, mle);
+		__dlm_put_mle(mle);
+	}
+	spin_unlock(&dlm->master_lock);
+	spin_unlock(&dlm->spinlock);
+
+	dlm_put_mle_inuse(mle);
+}
+
 static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 			       struct dlm_lock_resource *res, u8 target)
 {
@@ -2609,9 +2630,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 
 	if (ret < 0) {
 		if (mle_added) {
-			dlm_mle_detach_hb_events(dlm, mle);
-			dlm_put_mle(mle);
-			dlm_put_mle_inuse(mle);
+			dlm_put_migration_mle(dlm, mle);
 		} else if (mle) {
 			kmem_cache_free(dlm_mle_cache, mle);
 			mle = NULL;
@@ -2640,9 +2659,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 		mlog(0, "migration to node %u failed with %d\n",
 		     target, ret);
 		/* migration failed, detach and clean up mle */
-		dlm_mle_detach_hb_events(dlm, mle);
-		dlm_put_mle(mle);
-		dlm_put_mle_inuse(mle);
+		dlm_put_migration_mle(dlm, mle);
 		spin_lock(&res->spinlock);
 		res->state &= ~DLM_LOCK_RES_MIGRATING;
 		wake = 1;
@@ -2686,9 +2703,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 				     res->lockname.name, target);
 				ret = -EINVAL;
 				/* migration failed, detach and clean up mle */
-				dlm_mle_detach_hb_events(dlm, mle);
-				dlm_put_mle(mle);
-				dlm_put_mle_inuse(mle);
+				dlm_put_migration_mle(dlm, mle);
 				spin_lock(&res->spinlock);
 				res->state &= ~DLM_LOCK_RES_MIGRATING;
 				wake = 1;
