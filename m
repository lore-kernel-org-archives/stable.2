Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D78384CC3;
	Thu, 30 Jul 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426566; cv=none; b=tT+1N+mBN2IDm0v95FO8/KZyrG1698FwyYyNcsQ51/zPFxJOOGGw3OMArYlQIc3Z9/2YS5hd4OOPI+TDb2NbJbiCa0te+lfrF1wl9aXJsjTILa7KF58H7KdNbspOcxH/MnUIzE8NLfPwOZW8Fzi3JXFC5htS375rS5RlFRjxKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426566; c=relaxed/simple;
	bh=V0TKBlLGYANw7nCUz5N0oNVtAZl4j3yObIschgB4Mnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hVuVeWLfRlOo6QvwhuYuV26mNhCMAqAsKi7Hxt7MedRGmtQIBlrs77PBG7cc4yWXNKWz+dqi7RQZSyV/m1MST411qCXWafEbvbu6O7+vh2FkyNNxPS9VlXtuG7WLq1iuJnzYPLSaFqaECM1lTIwHLPmqnq4o8mDodsiX3/r9ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 37ff0f028c2e11f1aa26b74ffac11d73-20260730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:54575b07-6353-4687-84c7-d12c14543e89,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:85fb60ed35a2a0e7d4db69a8de10e920,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-19|2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 37ff0f028c2e11f1aa26b74ffac11d73-20260730
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1991619463; Thu, 30 Jul 2026 23:49:16 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: kees@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] lkdtm/core: fix resource leaks on module init error path
Date: Thu, 30 Jul 2026 23:49:11 +0800
Message-Id: <20260730154911.3164527-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When lkdtm_register_cpoint() fails, the out_err path only removes
debugfs but leaks the kmem_caches from lkdtm_heap_init() /
lkdtm_usercopy_init() and the lkdtm_kernel_info string, because the
kernel never calls module_exit() on init failure.

Add the missing cleanup calls to out_err.  Drop __exit from
lkdtm_heap_exit() and lkdtm_usercopy_exit() to avoid section mismatch:
these functions are now called from __init context, and .exit.text is
discarded for built-in builds.

Fixes: 039a1c42058d ("lkdtm: Relocate code to subdirectory")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

---

Changes in v2:
  - Drop __exit annotation to fix section mismatch when built-in.

 drivers/misc/lkdtm/core.c      | 3 +++
 drivers/misc/lkdtm/heap.c      | 2 +-
 drivers/misc/lkdtm/lkdtm.h     | 4 ++--
 drivers/misc/lkdtm/usercopy.c  | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index ededa32d6744..1e3a5e45e3c2 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -468,6 +468,9 @@ static int __init lkdtm_module_init(void)

 out_err:
 	debugfs_remove_recursive(lkdtm_debugfs_root);
+	lkdtm_heap_exit();
+	lkdtm_usercopy_exit();
+	kfree(lkdtm_kernel_info);
 	return ret;
 }

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 9e358d15f4fb..d01e3a3e3e3e 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -363,7 +363,7 @@ void __init lkdtm_heap_init(void)
 	b_cache = kmem_cache_create("lkdtm-heap-b", 64, 0, SLAB_NO_MERGE, NULL);
 }

-void __exit lkdtm_heap_exit(void)
+void lkdtm_heap_exit(void)
 {
 	kmem_cache_destroy(double_free_cache);
 	kmem_cache_destroy(a_cache);
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 3a57c4e5e978..e3a3e3c3e3e3 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -89,9 +89,9 @@ extern struct crashtype_category powerpc_crashtypes;
 /* Each category's init/exit routines. */
 void __init lkdtm_bugs_init(int *recur_param);
 void __init lkdtm_heap_init(void);
-void __exit lkdtm_heap_exit(void);
+void lkdtm_heap_exit(void);
 void __init lkdtm_perms_init(void);
 void __init lkdtm_usercopy_init(void);
-void __exit lkdtm_usercopy_exit(void);
+void lkdtm_usercopy_exit(void);

 /* Special declaration for function-in-rodata. */
 void lkdtm_rodata_do_nothing(void);
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 2f3c5034a3e3..e3a3e3e3e3e3 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -433,7 +433,7 @@ void __init lkdtm_usercopy_init(void)
 					   NULL);
 }

-void __exit lkdtm_usercopy_exit(void)
+void lkdtm_usercopy_exit(void)
 {
 	kmem_cache_destroy(whitelist_cache);
 }
--
2.25.1
