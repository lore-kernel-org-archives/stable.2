Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793075558;
	b=Sx36x5gBOWfws/s7ELIV2rp7R70AG/o1hLsgGe1wv99lAEr/uyQdrUKXVf5+/FByJy6g
	 L5FA9J7eyb6AjJplUFluo/he41fmxdtUkJJbRn6q6ZFylYfCw7pj0N7xyBe23T7WlHhH1
	 PZ8QoU9gMITuilvtHB8rB5VPv/PzpTghpZxwRdLvhuAI4rV0w9GstyuXwr31jDzAIfliw
	 NeONyqPO5LI1nWpGvp/HsJrFw512nsxZ7otl7RdCkP+PX+OXcd+hbOMh1baZeM1qqmSCV
	 Q+BSRv8E8j0skqiuFlDVEDs0UVUFV2T99fqi+nCHXs0kVsLiHt/A/HcShVbJs/DpLsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793075558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=beH3LIXHCpnBC80V4Y086Pbi9jHjOQOYfz6A2+Xry6Q=;
	b=yftTap4i23YilUA1SzN7xx+ZFBIsoAaA/x5j/7TnBnGIpTygfNg9ajTGP5F26QbFL2x3
	 7m4GsHdUTHC+3An8tUYFNGfmRj6Q42tF6T+fJCF5T38tA4VgkCmkHUfahFgS1egAf5pz6
	 Ae9AcdYlQ+KuiO0Zat8ZFtOZjhsLBnRzK/yC4t1IOfHQZvd5vTWgCibMgQ+cxCnF40Qf7
	 Z7Ub4XOwh+gPOQyg+l5kb1zJAPJ8/kkM1YkazyqAYDG1j/iXRvX85Pq2xsZwBUDlipNiM
	 eUbCTDzYh05rOpVNXyFkcEaM3yaP2/wkZ7IAEOvQfRRkvCzV059dAPLz6oKGNGXmGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XHBn4wD5;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EA606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875EA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XHBn4wD5
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2849714b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793075557; x=1793680357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=beH3LIXHCpnBC80V4Y086Pbi9jHjOQOYfz6A2+Xry6Q=;
        b=XHBn4wD5E6Ny0jCWr3JPfbWRLzwMZ5tLXNjZkT2ky54AuNd7qG4AzH4QB1vNFTdl4h
         hgxnRW/tfL1d9MeRpJnvmaoiYVWWnf62I1/ieBrqdJfWS3z8LlFr35LO4bgR82OAMypu
         aVYeApSYRWLgZzaYDU2sIXbiWYDwnAQqV22esPZmIvC7ZRQSJS8P8jUEit4b0SUQa0BD
         I8/4jlmJQ7jcPEY8xx4RxWC4jVGTo9FJjp+LTxmLYlEkQ3FFJvGhDQZLcGxVmIajjzW3
         +lffpa8VmhjNoKnp1E9KpznKg6RL0ZgweD7id9DdKFk6hi6xBojcrpYYL/OZiTXz1mR/
         Lm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793075557; x=1793680357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beH3LIXHCpnBC80V4Y086Pbi9jHjOQOYfz6A2+Xry6Q=;
        b=gMY8HtCWs65FSWGc2aO3fB23CwWBRfHDmZoPyXNqrLoql239MdLwXZEO9C4n0m3Lof
         jS7/1AdFt/nYjMFmiGHWn5leB7j5GNEug9yyATI2eD2JdgmuO29OBmQrmFf8Co9Gc12g
         F67KM2dxHnuPECNd6f823sLY6ti6vIh351ZUKEO98/EDaBzkqk0xOxkG01ecn3sv0kTl
         RIRvT16EDUpMG4XxfLH9s1BIAJRiRw+0DnwGSJsZQ/c3gGASjAT3mj8614NwDngIJWGT
         ThGPj4ZWHJ+QSCXn+rUq117MB4JayFEBkhDJ8e6Glhfwi3H4W7qlMxOjdAaeh/it+1c8
         BnHA==
X-Forwarded-Encrypted: i=1; AKwUvBw2hRdYWnxpa0wiHjCDeNVIt3yKPrQK2qfxQwvboIqGBegXiUnvFyC/+JcA6f1aVnXiZABvYCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKFnalAhtCfeujX5/s8xG36u13k7cFE5YPJSYVdVpcmAJ0ODKn
	3etzXDMsclUP3ru/GnJuZ8IKO9N2sAP5aAhgBi5BFA7ZPSIvQbIXJvvE
X-Gm-Gg: AYBFou00Z2WInQdJCDfZzStpeTMyOgy2QxVqftwnC7aG384JO2Iy8rgScCroIg7TF5+
	wlQU00TuDg52D2IYk32okI3iZ9UI44mM1QfuepvmG/4mYj1mBIX9+S7Fte7cioTj9tSvwwMlkYf
	BKoK0mJzleCf3NOEoudJ36Mlxdfwy8JP4Dj8ujHXYiPO5UU2YU9qm7k8AsciXq0B8bfodjuuoEb
	Ui++lx/K1W2F0F2PwF6VWh1DnOIJItZxqjq63sb+nlasqvJUa6TCgWL8vwOoNWVazg246ouqGM3
	INVo1HvfFnFmU3X3jXfY2fL4LLppUervu0ATMsgfGB9wQs8sK80QEZNH2wQsrOHSTDK16n4MFLh
	Pe2nBMftwLQYKAJqUunc5C8BWYyBKa9O1KCo51+k/JltB4xomm+hy6b5+R2/SvMD1sKQb9Gh/Vi
	MIqn8lmPGzaw2vIdRLry6Pw09x5EuAd30GHYSffFQssf9pKeSkthKOK+DPZkj7x2oT3SmwsX1iD
	BsYhbgpKLHQ0ipSRZSKG1cKVN/w7rssrtf4lYZjIec+eRz6P/BhT0NUiNw80R2Ps8lqFRemJC0g
	1hRdsN24ORid7TDoOIsyXfUz
X-Received: by 2002:a05:6a00:ad02:b0:881:cbb0:6a90 with SMTP id d2e1a72fcca58-8a36772bf53mr6311975b3a.58.1793075556731;
        Mon, 26 Oct 2026 21:32:36 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bb2a7e8sm1735435b3a.39.2026.10.26.21.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:32:36 -0700 (PDT)
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
Subject: [PATCH v2] ocfs2/dlm: serialize migration MLE cleanup on failure
Date: Tue, 27 Oct 2026 12:32:30 +0800
Message-Id: <pm-ocfs2-objects-candidate-0038-v6-44416f9847751914bacc@gmail.com>
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

An assertion that got there first has also made the target the owner
and cleared DLM_LOCK_RES_MIGRATING. Treating the attempt as failed at
that point would leave the lockres owned by the target while this node
still holds the other nodes' locks, so it could neither be purged nor
migrated again and would be misread by recovery. Complete our side the
way a successful migration does instead, unless recovery has taken the
lockres over in the meantime.

For a send that failed with a connection error, wait for the target to
die before deciding, while the MLE is still published. The target may
have received the packet and may still assert; an assertion that finds
no MLE for a lockres we still own is fatal in the handler. The wait is
bounded as before, and an assertion that arrives even later meets that
check as it did before this change.

Use the same cleanup for the pre-send failure, the send failure and the
target-death failure paths. The sender's in-use reference keeps the MLE
alive until its final put outside the nested locks. Successful
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
Changes in v2:
- Complete the migration instead of failing it when the finishing assert has
  already switched the owner, so the lockres is not left owned by the target
  with the other nodes' locks still held here (Sashiko review).
- On a connection error from the send, wait for the target's death before
  the MLE is dropped, so a late assert finds the MLE instead of hitting the
  handler's check (Sashiko review).

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0038-v5-5e414ac0c701d2ccd4b3@gmail.com

 fs/ocfs2/dlm/dlmmaster.c | 82 ++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 12 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 612969867ff9..a96060b87b9f 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2525,6 +2525,52 @@ static int dlm_is_lockres_migratable(struct dlm_ctxt *dlm,
  */
 
 
+/*
+ * Drop the sender's references on a migration MLE after the attempt has
+ * failed. The finishing assert from the target may already have unlinked
+ * the MLE and consumed its base reference; decide under the locks the
+ * assert handler holds, and only drop the base reference while the MLE is
+ * still hashed. Returns true when the assert got there first: the target
+ * has become the master, so the caller must complete the migration.
+ */
+static bool dlm_put_migration_mle(struct dlm_ctxt *dlm,
+				  struct dlm_master_list_entry *mle)
+{
+	bool asserted;
+
+	spin_lock(&dlm->spinlock);
+	spin_lock(&dlm->master_lock);
+	__dlm_mle_detach_hb_events(dlm, mle);
+	asserted = hlist_unhashed(&mle->master_hash_node);
+	if (!asserted) {
+		__dlm_unlink_mle(dlm, mle);
+		__dlm_put_mle(mle);
+	}
+	spin_unlock(&dlm->master_lock);
+	spin_unlock(&dlm->spinlock);
+
+	dlm_put_mle_inuse(mle);
+	return asserted;
+}
+
+/*
+ * The finishing assert switched the owner to the target and cleared
+ * DLM_LOCK_RES_MIGRATING while the attempt was failing. Complete our side
+ * as a successful migration does, unless recovery has taken the lockres
+ * over since.
+ */
+static void dlm_migrate_lockres_asserted(struct dlm_ctxt *dlm,
+					 struct dlm_lock_resource *res,
+					 u8 target)
+{
+	spin_lock(&res->spinlock);
+	if (res->owner == target)
+		dlm_remove_nonlocal_locks(dlm, res);
+	spin_unlock(&res->spinlock);
+
+	dlm_lockres_calc_usage(dlm, res);
+}
+
 static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 			       struct dlm_lock_resource *res, u8 target)
 {
@@ -2609,9 +2655,10 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 
 	if (ret < 0) {
 		if (mle_added) {
-			dlm_mle_detach_hb_events(dlm, mle);
-			dlm_put_mle(mle);
-			dlm_put_mle_inuse(mle);
+			if (dlm_put_migration_mle(dlm, mle)) {
+				dlm_migrate_lockres_asserted(dlm, res, target);
+				ret = 0;
+			}
 		} else if (mle) {
 			kmem_cache_free(dlm_mle_cache, mle);
 			mle = NULL;
@@ -2639,17 +2686,25 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 	if (ret < 0) {
 		mlog(0, "migration to node %u failed with %d\n",
 		     target, ret);
+		/*
+		 * The target may still have received everything and may
+		 * finish the migration. Give it the chance to assert, or
+		 * to die, while the MLE is still published, so that a late
+		 * assert finds the MLE instead of a lockres we still own.
+		 */
+		if (dlm_is_host_down(ret))
+			dlm_wait_for_node_death(dlm, target,
+						DLM_NODE_DEATH_WAIT_MAX);
 		/* migration failed, detach and clean up mle */
-		dlm_mle_detach_hb_events(dlm, mle);
-		dlm_put_mle(mle);
-		dlm_put_mle_inuse(mle);
+		if (dlm_put_migration_mle(dlm, mle)) {
+			dlm_migrate_lockres_asserted(dlm, res, target);
+			ret = 0;
+			goto leave;
+		}
 		spin_lock(&res->spinlock);
 		res->state &= ~DLM_LOCK_RES_MIGRATING;
 		wake = 1;
 		spin_unlock(&res->spinlock);
-		if (dlm_is_host_down(ret))
-			dlm_wait_for_node_death(dlm, target,
-						DLM_NODE_DEATH_WAIT_MAX);
 		goto leave;
 	}
 
@@ -2686,9 +2741,12 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 				     res->lockname.name, target);
 				ret = -EINVAL;
 				/* migration failed, detach and clean up mle */
-				dlm_mle_detach_hb_events(dlm, mle);
-				dlm_put_mle(mle);
-				dlm_put_mle_inuse(mle);
+				if (dlm_put_migration_mle(dlm, mle)) {
+					dlm_migrate_lockres_asserted(dlm, res,
+								     target);
+					ret = 0;
+					goto leave;
+				}
 				spin_lock(&res->spinlock);
 				res->state &= ~DLM_LOCK_RES_MIGRATING;
 				wake = 1;
