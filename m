Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611A241C8C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791940672; cv=none; b=G7rofjWEMtTciuC+/K/iMzWmxVQozALj9s72HFmN2p+M3ArEqJngqftMzwNfD5FzBDu1eaBJUxwZCGyq22/czoTqqWcwZmwXjr0i5ZUWtGFOZkpRK8f34Qq37pVekarl+ivL0b0P6MwdBHPfgvj3vkDV9HjyTJe5Y2VyZeNBaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791940672; c=relaxed/simple;
	bh=dTeaZTYjh3Da0EGl3MZT03sejCIC00zGRC7FFkABpZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXV9TEJ+zg6gozLb1wZQEMpC62eRmQ5kXVpMBKXGwjebWxkyDEcPKdJ1ibd5KJ0/e+aKgtzoQhulySwNZl3GEMwg+NZ3UTo3uepsBLd7rnj/lTxzAL+lErjxozm/nqXRWmn8nJXxDdvV0dGjd5jSfG1ORERJvXZf7+fLvnFP5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ph5O351+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph5O351+"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd3310348d2so2597623a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791940670; x=1792545470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaUwbOoWaVCKFdXaFwbJuanAHleTOgajImBJaewsajc=;
        b=ph5O351+rZAor2+Y+7yoIaSTEY+7mQTScy6hw2yFhnSUi+lXiZDlY4OsJxe5qiRUer
         1wzWQqJe8c4iCWqkZDFs6up2KDkPjtIYbLrEEkR5o8a26WHIds4iJgiqGgwaNLbNmnU7
         Hwtu0/ADA6iopFUZa6s+o0qEFXBDfZVFXI7FIKbJvedpsBbYkXGCCzwr7EYrnHZMoFo6
         ig5vdfLDllySJ7vYsCnpYm+SsPbaNZrObt5S6ZTOb568PC58imOiinZJdK18S6pDD5t0
         20zTid0gpn5VK7beik3yuVgyFvFhjBEDTzSwM9riTOF4N1D1bcd9hjwSDV9etCUCUZNX
         GMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791940670; x=1792545470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaUwbOoWaVCKFdXaFwbJuanAHleTOgajImBJaewsajc=;
        b=qXfwbBuL+hEumF2jDSye3KPqmKTuWqzMg7LDPhHUktylUbx6a7UEBsNJNCvXkpx8E0
         qnautXJi4Ucs9cJ6GxjxIcF0nfyry42ZLE5mVqVON3IdAkva8xbOR7hTCOfOSsRWw1BW
         pR57PBljRzAouTlGk+T0uJ9OhOtWIA60BGGeNw9Ui3NnVCcTfcPXXfHGwtPuSw4Dh2rT
         rwC1sjQRKAdaZJTXn3YVUrtyIox7U4/hSyuXQi5n1J4nl2kflOyUZnIlM1EW2hMr9uUG
         rLrCCGTgMFAdA07zhZC/CY0QBfWKpva7Da/buCGgJ0p8AktbAZ9x7rDNBK8a2BIddZTj
         6KkA==
X-Forwarded-Encrypted: i=1; AKwUvByXJ8HreK/bCkZKUDFPYUduWxuA1hokfGtW0L8kfAYA8SxAg7zHDiYyXGDE5cj/pTPNlKvoFwQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLOMuuBYaGzYzrOad+aCa3/Bmczk5VFwYcGV2xJ/1+SQ0GwrP5
	1h6FIDcbj+XGOZwXv8OCdtU65xwHzLHJ6SBHZgBEs973QaGCWqS0958B
X-Gm-Gg: AYBFou1vWkvVpsqBUMX1TIUxN7oUnXdlZ7dpCFeN2tCbfkPd072X5T9CyC/X2oiYN1v
	JJFJI88EVO4UmzRC67bCJcqhTyhsmItPimqiqeJvdh4lO1vFfL8SoNkUI1BSLGqfC3hyqYtS1kL
	fXLFf7K5hOxHdjk/HUnjmafxMi35F1kASqZ5/JImgkK5w4an7Ls8D8rkXWHJrcbhnEKQ5uuCJPW
	REVX5OkQbq02cS+/uvHswuFukqESfekXZR6BA1kYuAxC+d948H16OvVzU9hnRjPIyWaSXrT2hNV
	slynGcXgrkOx0ZnUdqcmIYo1m0xltu4+RRc6wM1QvgCPHhnLx96VmFXBbPDL+cf8xCUWczaN+zt
	/+zSD3S8kL0m+YrjuXZDJD9IvLblV8w8uZfOTh5LYGf3YSkZ0Md5XtOWuUBMTypqNdAPFCmmK5y
	Bm1P4AE0rh2/s0bJuATtk+BhbQfi0b6Nx8z4UYjrg2zMmXC/8oNL3b+CKp1Rncnp98DKeBJ2bER
	N1+zBu2+VeT5/V5gFJ2Quasv71iCf/OCyIOTPdFJ83qAqWvSU3DfmZA7L/CmK4a9gNk5vdRBwiL
	LHZGi+CK6/SZq4FQnxJEipUgqwX8ZPj02qyZv6mBs+qd1V0q
X-Received: by 2002:a17:90a:d006:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3ab3a953313mr6789233a91.9.1791940670112;
        Tue, 13 Oct 2026 18:17:50 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac60064254sm1842593a91.4.2026.10.13.18.17.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 18:17:49 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] scsi: target: tcm_loop: fix tl_nexus use-after-free on concurrent nexus drop
Date: Wed, 14 Oct 2026 11:17:39 +1000
Message-ID: <20261014011739.45941-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcm_loop keeps the per-TPG I_T nexus in tl_tpg->tl_nexus with no lock,
refcount or RCU protection.  The configfs control path that creates and
destroys it is not serialized: configfs runs concurrent ->store() calls
in parallel (configfs_write_iter() only holds a per-open-file
buffer->mutex, and flush_write_buffer() takes frag_sem for read), so two
writers to the nexus attribute, or a writer racing the transport_status
or nexus show attribute, all touch tl_nexus concurrently.

A nexus created without linking a LUN has tl_tpg_port_count == 0, so
tcm_loop_drop_nexus() ("echo NULL > .../nexus") passes its port-count
guard and frees the nexus (target_remove_session() + kfree()) with no
lock held.  Two concurrent drops therefore both read the same tl_nexus,
both pass the guard, and both free the same se_session -> use-after-free
/ double free.  The sibling fabric drivers vhost_scsi and xen-scsiback
serialize the equivalent nexus create/drop/show with a per-TPG
tv_tpg_mutex; tcm_loop has no such lock.

KASAN, two concurrent "echo NULL > .../loopback/<wwn>/tpgt_1/nexus"
(nexus created, no LUN linked), reproduces in seconds:

  BUG: KASAN: slab-use-after-free in transport_free_session+0x12f/0x3f0
  Call Trace:
   transport_free_session+0x12f/0x3f0
   tcm_loop_drop_nexus+0x85/0xf0
   tcm_loop_tpg_nexus_store+0x392/0x580
   configfs_write_iter+0x1a7/0x250
  Allocated by task 3008:  ... tcm_loop_tpg_nexus_store <- configfs_write_iter
  Freed by task 3010:      ... tcm_loop_drop_nexus <- configfs_write_iter

Add a per-TPG tl_nexus_mutex and take it around every control-path
access to tl_nexus: tcm_loop_make_nexus(), tcm_loop_drop_nexus(),
tcm_loop_tpg_nexus_show() and the transport_status "offline" path that
dereferences tl_nexus->se_sess.  tcm_loop_drop_nexus() clears tl_nexus
under the mutex and only releases/frees the session after dropping it,
so a racing control-path caller either observes the live nexus under the
lock or sees NULL and bails -- it can no longer free it a second time.

The I/O submission path (tcm_loop_target_queue_cmd(), tcm_loop_issue_tmr())
reads tl_nexus without the mutex and is left unchanged: it can run in
atomic context, and it is already serialized against drop by
tl_tpg_port_count plus SCSI-midlayer draining (a live scsi_device keeps
tl_tpg_port_count > 0, which makes tcm_loop_drop_nexus() return -EPERM).

Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/target/loopback/tcm_loop.c | 44 +++++++++++++++++++++++-------
 drivers/target/loopback/tcm_loop.h |  3 +++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 1111111..2222222 100644
@@ -672,14 +672,18 @@
 	struct tcm_loop_nexus *tl_nexus;
 	int ret;
 
+	mutex_lock(&tl_tpg->tl_nexus_mutex);
 	if (tl_tpg->tl_nexus) {
 		pr_debug("tl_tpg->tl_nexus already exists\n");
-		return -EEXIST;
+		ret = -EEXIST;
+		goto out;
 	}
 
 	tl_nexus = kzalloc_obj(*tl_nexus);
-	if (!tl_nexus)
-		return -ENOMEM;
+	if (!tl_nexus) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	tl_nexus->se_sess = target_setup_session(&tl_tpg->tl_se_tpg, 0, 0,
 					TARGET_PROT_DIN_PASS | TARGET_PROT_DOUT_PASS,
@@ -687,12 +691,15 @@
 	if (IS_ERR(tl_nexus->se_sess)) {
 		ret = PTR_ERR(tl_nexus->se_sess);
 		kfree(tl_nexus);
-		return ret;
+		goto out;
 	}
 
 	pr_debug("TCM_Loop_ConfigFS: Established I_T Nexus to emulated %s Initiator Port: %s\n",
 		 tcm_loop_dump_proto_id(tl_hba), name);
-	return 0;
+	ret = 0;
+out:
+	mutex_unlock(&tl_tpg->tl_nexus_mutex);
+	return ret;
 }
 
 static int tcm_loop_drop_nexus(
@@ -701,17 +708,23 @@
 	struct se_session *se_sess;
 	struct tcm_loop_nexus *tl_nexus;
 
+	mutex_lock(&tpg->tl_nexus_mutex);
 	tl_nexus = tpg->tl_nexus;
-	if (!tl_nexus)
+	if (!tl_nexus) {
+		mutex_unlock(&tpg->tl_nexus_mutex);
 		return -ENODEV;
+	}
 
 	se_sess = tl_nexus->se_sess;
-	if (!se_sess)
+	if (!se_sess) {
+		mutex_unlock(&tpg->tl_nexus_mutex);
 		return -ENODEV;
+	}
 
 	if (atomic_read(&tpg->tl_tpg_port_count)) {
 		pr_err("Unable to remove TCM_Loop I_T Nexus with active TPG port count: %d\n",
 		       atomic_read(&tpg->tl_tpg_port_count));
+		mutex_unlock(&tpg->tl_nexus_mutex);
 		return -EPERM;
 	}
 
@@ -719,10 +732,14 @@
 		 tcm_loop_dump_proto_id(tpg->tl_hba),
 		 tl_nexus->se_sess->se_node_acl->initiatorname);
 	/*
-	 * Release the SCSI I_T Nexus to the emulated Target Port
+	 * Clear tl_nexus under tl_nexus_mutex so a concurrent drop/show/
+	 * transport_status store cannot observe or free it a second time,
+	 * then release and free the session after dropping the lock.
 	 */
-	target_remove_session(se_sess);
 	tpg->tl_nexus = NULL;
+	mutex_unlock(&tpg->tl_nexus_mutex);
+
+	target_remove_session(se_sess);
 	kfree(tl_nexus);
 	return 0;
 }
@@ -737,12 +754,16 @@
 	struct tcm_loop_nexus *tl_nexus;
 	ssize_t ret;
 
+	mutex_lock(&tl_tpg->tl_nexus_mutex);
 	tl_nexus = tl_tpg->tl_nexus;
-	if (!tl_nexus)
+	if (!tl_nexus) {
+		mutex_unlock(&tl_tpg->tl_nexus_mutex);
 		return -ENODEV;
+	}
 
 	ret = snprintf(page, PAGE_SIZE, "%s\n",
 		tl_nexus->se_sess->se_node_acl->initiatorname);
+	mutex_unlock(&tl_tpg->tl_nexus_mutex);
 
 	return ret;
 }
@@ -861,11 +882,13 @@
 	}
 	if (!strncmp(page, "offline", 7)) {
 		tl_tpg->tl_transport_status = TCM_TRANSPORT_OFFLINE;
+		mutex_lock(&tl_tpg->tl_nexus_mutex);
 		if (tl_tpg->tl_nexus) {
 			struct se_session *tl_sess = tl_tpg->tl_nexus->se_sess;
 
 			core_allocate_nexus_loss_ua(tl_sess->se_node_acl);
 		}
+		mutex_unlock(&tl_tpg->tl_nexus_mutex);
 		return count;
 	}
 	return -EINVAL;
@@ -923,6 +946,7 @@
 	tl_tpg = &tl_hba->tl_hba_tpgs[tpgt];
 	tl_tpg->tl_hba = tl_hba;
 	tl_tpg->tl_tpgt = tpgt;
+	mutex_init(&tl_tpg->tl_nexus_mutex);
 	/*
 	 * Register the tl_tpg as a emulated TCM Target Endpoint
 	 */
diff --git a/drivers/target/loopback/tcm_loop.h b/drivers/target/loopback/tcm_loop.h
index 3333333..4444444 100644
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <target/target_core_base.h> /* struct se_cmd */
+#include <linux/mutex.h>
 
 #define TCM_LOOP_VERSION		"v2.1-rc2"
 #define TL_WWN_ADDR_LEN			256
@@ -39,6 +40,8 @@
 	struct se_portal_group tl_se_tpg;
 	struct tcm_loop_hba *tl_hba;
 	struct tcm_loop_nexus *tl_nexus;
+	/* Serializes tl_nexus accesses on the configfs control path */
+	struct mutex tl_nexus_mutex;
 };
 
 struct tcm_loop_hba {
-- 
2.43.0
