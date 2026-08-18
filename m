Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0A3AAF71
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787019019; cv=none; b=aCp0F2fMSQ4eAdkZ6YHAEtqU3jTTtitfpL57+M0XdxmNtDiBjifsxDQzKt2MQ5RQk3cGx4GDarRRN2hJqZZNtlB/1X4kNkJcqIiu8R+MxnG1PSXHTZfWsD1aRbLgBRPSymfRsxNFzz/xGAZX5/z5vr5L1pKOjLguhmLBvXVE6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787019019; c=relaxed/simple;
	bh=Ix1zjxj4eYL9/VS5Wq53zDMooCyEsxJIqXZutJWL2yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jo1cUmycMGwf6yAwqDRNfwPo+6ZkUiC0iIpuE+lEsA0hrXud/W/Pum7pHheMqE970D0U3KwWp4IC+f/3bTD9RavP/noS92lm0sDOcddPzxfN9DEXnv9/ijdEXTAktSMDgPepW/TOYatEM/n/GY6neSJV1Ijx5DevAHOwgbrph0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=wdE9TJpb; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=LKhHjpOZ; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="wdE9TJpb";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="LKhHjpOZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1787019016;
	bh=Ix1zjxj4eYL9/VS5Wq53zDMooCyEsxJIqXZutJWL2yA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wdE9TJpbR+kCy3XJuJgu80IDBB/Y3iYGJiSlEfVvnCiUEsiYHAy4Lv2oPt2wurl1p
	 Qe6WOoEoUTcGAqmfyMITUJsvqtcwOJXfffSOzDIDAFUbSDeizCYsGEqi4mwkUP7xzP
	 xYKNgsn8QxneTMeppzQknnb2VpNcGqLfKJDrZ2Gs2CJzYiLMZu6Ym/rhhYZSYfLbpy
	 Rt4yT01sRRSA4Ae3++J8OayFbQ5LMT1uEI5vOVrD4LolCAP7FqAgB9E+p3yHs4cBT+
	 GxX0SjOTG0Rln4d93yHNWjGTBTSzFhwb52QQIWiT3qJ+nTwgtCiZZwXBXpML7luRUi
	 CAmXyLV86JtVw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id D7E2E670
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:10:16 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=LKhHjpOZ;
	dkim-atps=neutral
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 1105B670
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:10:16 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so6097928a91.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1787019015; x=1787623815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hi7xHirHoUw4IoNwrufN13NNn3nrIkfX3xAtdGuYP9I=;
        b=LKhHjpOZNbMsFttQu3DzQGJwrlDuRrRsXzxPeYzBmL5lZ1VNug2s68iF6wgTRYEOZ1
         GLqRdlxDU0gU7OS75jDeKGDgEAT/IycTaTfaKUbtVlKk3A5B+ox8p8QVz0kSwuFYncte
         HXxlPP9inoUkXLI/Kye+vlKzg2W2+aANHTrol79gLjAsZFNomQAWMGKBDp7tMC8EZYdm
         2328poiMKaSLElMgcorg0xKGyhl/g7qKEKVsHMdRP/NDhVXgQ89U5gbinSA2olYCSXTb
         /ao8Sw7QuEjqCdwcMbdLEUIYk3CIVOBvXScI19uw0ZW12AIDkNjih9FdznCimJWyis1o
         HvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787019015; x=1787623815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hi7xHirHoUw4IoNwrufN13NNn3nrIkfX3xAtdGuYP9I=;
        b=cXOJGxSooVtkTrxLHqGleOh7BzhBM3CGdgAFUpq2jB7r7m8QyInkz+hK2akSCndnqa
         J1TaqHYcbfeLOxSfC4Ad9lpWQai8WxQRGm8qZWzIqKHV6K8hzgXG2vJeDqQuA0kP39o+
         nV9+uF7wCRZBZCXr38gzqXr006jaiqq9p+Smi359jjDc/pPB4jbuaMWXYZyCJb0HDMFf
         09UdsecqA1Zu3WlUaPp+CPjERffghF2k1v5ZuKdeO8JDSOwIy0AjZpZGVxaDNzADD8yP
         wwmFIcd2xY9sQw0wLNpD7x+Z6XBy4ZzEgQfEH2AMzejw7p5RK86a2PCtqe9t380ZtmBW
         hemw==
X-Gm-Message-State: AOJu0YxOw4EKP0HR2IjdPWnPQO6LVJrIl+gdbb6DKBnYXhRckITdG0I6
	LcONmjQCd7y02zJgwxgnCMXAdjQfzInwBkAspD003SIoXVCpOdx3MaPa1rexGmgg11sDvRXiQfU
	qRuEZZNMRralbyx3ThiXzYyzQmcAiH9Y5ESzkkp0fUgCJZPrucaXtXlh2Mco=
X-Gm-Gg: AR+sD13SejKtvn8gp0PeBCVrXGV9fU+IdlePpWht38a4WOFdi+DVC2fnhfo+kyN80xw
	uA6qKV1srR9kS8FZDw7pcBIJuwdGXR+3fZ4Y4Mqd2G1bO0e3TpYfXOumHlrMnGFq8Udde5fN7Cm
	zEiMnn5W8hf7KPFB1lQ3cinZ6qTfO/1iFUeBrtiMcttmFEAlNE2eNNDU3t41RrfD/skBXWHLXmT
	v7iHmi9HQE3o9QHlYVUq8TCuEJFvDMblDfQXBuJYHUAsP23fcfJpLSdVBUWYkHTlffEUQiP0zmw
	ykRje2KC6PmYxn5+9RpTLV3P+uVIzOHovfGSnZWuyvgYokR66QRAKphfHJqXbZ1M7T7Qx9ClaMz
	Bsacz9+/JYGcFzWhsIM9BeF6u6y3sZZX7pTCEdglbba6QTLlf
X-Received: by 2002:a17:90b:554d:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3955a7b15e0mr5097001a91.11.1787019014973;
        Mon, 17 Aug 2026 19:10:14 -0700 (PDT)
X-Received: by 2002:a17:90b:554d:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3955a7b15e0mr5096927a91.11.1787019014405;
        Mon, 17 Aug 2026 19:10:14 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3954d2b8080sm4232945a91.4.2026.08.17.19.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:10:14 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Tue, 18 Aug 2026 02:09:35 +0000
Subject: [PATCH v6.12.y 2/2] ubi: fastmap: fix ubi->fm memory leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ubi-backports-v1-2-324d6816d2ae@atmark-techno.com>
References: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
In-Reply-To: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
To: stable@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 Liyuan Pang <pangliyuan1@huawei.com>
X-Mailer: b4 0.16-dev-a9e92
X-Developer-Signature: v=1; a=openpgp-sha256; l=5399;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=Rq6t/hYpg1RyNp9DwzyGXOvBRMwbHlqH4hMASIwQb4A=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBqg78BSbSrWtBI8J25bEZy7VSwp01/XxwlIYIU0
 +V9J17cSK+JAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCaoO/AQAKCRDyimB/1oxx
 BwzCD/4jLnvNtg6zBHE+Q7dSHaPc0f4p0IQzhtS2u3f0jxRqKaY1IeALuhVhoO6xgEAXwTMQBo/
 RTG7MCAMlIFnyasf3aIBv6TOPsqA6EjkqcCcB8faNIdyh4t0KLeP2g9IbpPxTGxrLCd1LdOFB7X
 G3NLsZvybLqRBKanzigKUc88GdXqOZfQUbRpW7xVgjXkEZRphGpmDxGQxh+NyFk9R4FL812XXGB
 32MmZ/Q3uPUhC/jJb0veyiCbQrCRdlZyj/psQXg0fwdD97kMWvst1thPDfXT3/a+aA5c24ESsof
 TxRyDMXzpLEljGFinXLAmvlipDaPppDpfGi6ZSqPEwXajSGwnxALMkdUaHBWQ/rsR7kxV1BXrNk
 w5Bw9nUY8HqI38PhwB8Ju+3KZRN8j8wYyrqh6Dg7FpfB/j+0KZiaxNxKQ0NVxUKPLaBcg+5rjTi
 LEjxcWlQzUhnLYydJoqnmkDKFD+k/T63Gf0s+U86aToGZd9V9MxlqFGja0K7b0uGBqkpjy7eeO7
 7RbKUvxBkiCp2V50OG9xmrio+/Y+Q5MbKP2HLB98CE8a4oZbLy38lXXWrXMl8eOHH6b4LVriZ7E
 9soJT7dheh7smtbp2K3EngDI2EFAT7Xd/yYlnTfMDL3CokEFikF4q07c2fj5dwnwV3d/1ZruEk5
 xhMz/oeTbMiGgpA==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107

From: Liyuan Pang <pangliyuan1@huawei.com>

The problem is that scan_fast() allocate memory for ubi->fm
and ubi->fm->e[x], but if the following attach process fails
in ubi_wl_init or ubi_read_volume_table, the whole attach
process will fail without executing ubi_wl_close to free the
memory under ubi->fm.

Fix this by add a new ubi_free_fastmap function in fastmap.c
to free the memory allocated for fm.

If SLUB_DEBUG and KUNIT are enabled, the following warning messages
will show:
ubi0: detaching mtd0
ubi0: mtd0 is detached
ubi0: default fastmap pool size: 200
ubi0: default fastmap WL pool size: 100
ubi0: attaching mtd0
ubi0: attached by fastmap
ubi0: fastmap pool size: 200
ubi0: fastmap WL pool size: 100
ubi0 error: ubi_wl_init [ubi]: no enough physical eraseblocks (4, need 203)
ubi0 error: ubi_attach_mtd_dev [ubi]: failed to attach mtd0, error -28
UBI error: cannot attach mtd0
=================================================================
BUG ubi_wl_entry_slab (Tainted: G    B      O L   ): Objects remaining in ubi_wl_entry_slab on __kmem_cache_shutdown()
-----------------------------------------------------------------------------

Slab 0xffff2fd23a40cd00 objects=22 used=1 fp=0xffff2fd1d0334fd8 flags=0x883fffc010200(slab|head|section=34|node=0|zone=1|lastcpupid=0x7fff)
CPU: 0 PID: 5884 Comm: insmod Tainted: G    B      O L    5.10.0 #1
Hardware name: LS1043A RDB Board (DT)
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x18/0x28
 dump_stack+0xe8/0x15c
 slab_err+0x94/0xc0
 __kmem_cache_shutdown+0x1fc/0x39c
 kmem_cache_destroy+0x48/0x138
 ubi_init+0x1d4/0xf34 [ubi]
 do_one_initcall+0xb4/0x24c
 do_init_module+0x4c/0x1dc
 load_module+0x212c/0x2260
 __se_sys_finit_module+0xb4/0xd8
 __arm64_sys_finit_module+0x18/0x28
 el0_svc_common.constprop.0+0x78/0x1a0
 do_el0_svc+0x78/0x90
 el0_svc+0x20/0x38
 el0_sync_handler+0xf0/0x140
 normal+0x3d8/0x400
Object 0xffff2fd1d0334e68 @offset=3688
Allocated in ubi_scan_fastmap+0xf04/0xf40 [ubi] age=80 cpu=0 pid=5884
	__slab_alloc.isra.21+0x6c/0xb4
	kmem_cache_alloc+0x1e4/0x80c
	ubi_scan_fastmap+0xf04/0xf40 [ubi]
	ubi_attach+0x1f0/0x3a8 [ubi]
	ubi_attach_mtd_dev+0x810/0xbc8 [ubi]
	ubi_init+0x238/0xf34 [ubi]
	do_one_initcall+0xb4/0x24c
	do_init_module+0x4c/0x1dc
	load_module+0x212c/0x2260
	__se_sys_finit_module+0xb4/0xd8
	__arm64_sys_finit_module+0x18/0x28
	el0_svc_common.constprop.0+0x78/0x1a0
	do_el0_svc+0x78/0x90
	el0_svc+0x20/0x38
	el0_sync_handler+0xf0/0x140
	normal+0x3d8/0x400

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220744

Signed-off-by: Liyuan Pang <pangliyuan1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
(cherry picked from commit d133e30aabc7c8eb8206827f8fbe0f3679adb911)
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 drivers/mtd/ubi/attach.c     |  4 +++-
 drivers/mtd/ubi/fastmap-wl.c |  8 +-------
 drivers/mtd/ubi/ubi.h        | 12 ++++++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index adc47b87b38a..884171871d0e 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1600,7 +1600,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 
 	err = ubi_read_volume_table(ubi, ai);
 	if (err)
-		goto out_ai;
+		goto out_fm;
 
 	err = ubi_wl_init(ubi, ai);
 	if (err)
@@ -1642,6 +1642,8 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 out_vtbl:
 	ubi_free_all_volumes(ubi);
 	vfree(ubi->vtbl);
+out_fm:
+	ubi_free_fastmap(ubi);
 out_ai:
 	destroy_ai(ai);
 	return err;
diff --git a/drivers/mtd/ubi/fastmap-wl.c b/drivers/mtd/ubi/fastmap-wl.c
index 9bdb6525f128..e2bc1122bfd3 100644
--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -530,8 +530,6 @@ int ubi_is_erase_work(struct ubi_work *wrk)
 
 static void ubi_fastmap_close(struct ubi_device *ubi)
 {
-	int i;
-
 	return_unused_pool_pebs(ubi, &ubi->fm_pool);
 	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
 
@@ -540,11 +538,7 @@ static void ubi_fastmap_close(struct ubi_device *ubi)
 		ubi->fm_anchor = NULL;
 	}
 
-	if (ubi->fm) {
-		for (i = 0; i < ubi->fm->used_blocks; i++)
-			kfree(ubi->fm->e[i]);
-	}
-	kfree(ubi->fm);
+	ubi_free_fastmap(ubi);
 }
 
 /**
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 1c9e874e8ede..450a7b9a5bd7 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -970,10 +970,22 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		     struct ubi_attach_info *scan_ai);
 int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count);
 void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol);
+static inline void ubi_free_fastmap(struct ubi_device *ubi)
+{
+	if (ubi->fm) {
+		int i;
+
+		for (i = 0; i < ubi->fm->used_blocks; i++)
+			kmem_cache_free(ubi_wl_entry_slab, ubi->fm->e[i]);
+		kfree(ubi->fm);
+		ubi->fm = NULL;
+	}
+}
 #else
 static inline int ubi_update_fastmap(struct ubi_device *ubi) { return 0; }
 static inline int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
 static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
+static inline void ubi_free_fastmap(struct ubi_device *ubi) { }
 #endif
 
 /* block.c */

-- 
2.55.0.dirty


