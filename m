Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74604AC147
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011611; cv=none; b=SX8ksz5pLM5+uzdmMuNtxSEO8roROdzoe5g0bjFto1dtdsodF/boo3FdSsBwKBcfGvJi0kpNCnKSeGWmS0/YoUmkaZR37rVLo4BPVmd/sJlRx11JcmC2DpLUTzjUi1gZNXWmT67pjU5PY9ghH6/cd9MSZzWmgtbvIZR/y6u9QSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011611; c=relaxed/simple;
	bh=Jevq/Wl65/kZHuIgCDUpop7cUYeLSy07MYEatyY4gvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cObuyQuJFpdnwv9Q8c+WQ/MQrvmk9m00MdAVTNnuIakcbzwrlWrX58qIXfGac+r4cWfZlVmfo1WCTcg89B6yr9ah1RUY04HIOgfo018yWv2YQBnEMpbMucHTkQvHBEvDQbB1v0+AWzNqD6VIs3gVcTDNTFcelKCGDfS/GzJKhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=gtaqyQde; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="gtaqyQde"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso28489445ad.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790011609; x=1790616409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/FXPvDnaWHJoB8L0Xa0vsn8KUukvNW6fJaWw1YDx+4=;
        b=gtaqyQdeAiX00PcUGREApX5ErWw51DcGLmY/zqlRt8pQD+6qEKzIDFNQCY3P8yyu21
         dahUpsVDYCFlFZwJoCPkgP6gA7HIHgiQQDli0cI+GoNup/bcKuS2wAGJf3JJa40TYgFI
         fWymGSJd2bXIA3hk6r/aSZU9ojRcrzJLv5F9Q0CkLVCW7vxevhrfQkNn4VBEUTI1BctU
         4HkhhXj3RDXvi5iqgySCEX7fr7BHKfRdJuN9J+m/M3EICfU3imuo0V2q34CZECbQY17q
         yn5rbQu8c8DEVJ99NUytY0+7El1IYnVeY1du8CUhF+t9aKLI5mJwxjA+TlM6ivZCOps4
         t5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790011609; x=1790616409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/FXPvDnaWHJoB8L0Xa0vsn8KUukvNW6fJaWw1YDx+4=;
        b=S3EAn26E3xu2i+tl7HofM+lNPwalCCYNIjsOE/9RygOk21w4lRhrR+RaW95Y2Shs3T
         gEBQf9ecJWepsJQz7B+GW5Mj2gKVTHlxIYYJK8V42BL9ni6iMQ/uzonMNsc+iVtffS1p
         kqZWdHxtU/nyEO03ibbO8pDAl7dM9er4WrTX2xxn8G0HgYNdFP4h60KZtXN2zHRrp/+k
         R+gWvjhhH3Kc0FcZXJNjO96hgP3loECD8lHf78+XOjqOd1NFtDDo62zh1J0yrWjFyt6Y
         H5Qd68HKD0gZ1mtPacofwIOrJCnj/osQK710OjaTF1TArIr+nHiQj7PavMD0sqrEiSHY
         C9rA==
X-Gm-Message-State: AFuF++k7XMY2FWwsY6dYtNDJ/cqADxgeFRv9AYT37BFm+VMvaB7s5edQ
	JTjoQj9tnzfGWYOcb0SNRoVwMyWZr9gSWv4/LEF4QoY34kyHo2LQtV7ak73Qh/nsA325vuGGbbs
	pUyJG
X-Gm-Gg: AYBFou3GRyIcQ7msI/QQMkgBnhIXrxi4CbvW8sqif8FCgS2bgosEVvzKZiG/y4rSdA5
	Rhpj6+JLasNvzimctv2hafaqTLAaAq/UaJtTJYQsclWD5d07blVWy93hDI8UE/m9lQucHMfhrDj
	UujUFrhrQBn6h3NMGq2tbJQ5J+IEbG1fBeZ2oyOmUv5pv1WHNs/plijmIDBLdy2qDRrw/iPTTPU
	Bm9Z/ZoBALFeSmupfGyj7h1rrhW4kRl8eO0kwEol/irPR4GV5GkuaalBZZmOXwPmJT1mgBWxfk+
	ILSHD9U5gDNG3qVQqtDTMSMoRnUUxjJXl8+j4VT2QluMmrMcVPSjkJ0mnISwiwHuSfDRAbrrmd9
	VPXRM17xhPCP0iChts7KcZz/7ZO7y10g7YfvTMntbxPNZNso6oYQ0CXjWrfb/52MC3bgJYABwCX
	7GBkszyPFo50M2omHQUSn8baJNnalJiascoO6YLe7nNXEKGKgU9X5s/0AMu0GMgCuPB2Om0eqUw
	iI1YF41V1B7tRB3wruhSgK/0JSWTbfNXA2gqewCAnsHEHEaF7X2yj+8GlsZHbeENrrrN6U=
X-Received: by 2002:a17:902:e751:b0:2dd:c100:4246 with SMTP id d9443c01a7336-2ddc10044edmr100676145ad.42.1790011608979;
        Mon, 21 Sep 2026 10:26:48 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ff4d7sm38218495ad.74.2026.09.21.10.26.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 10:26:48 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Oded Gabbay <ogabbay@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 6.1.y] accel/habanalabs: postpone mem_mgr IDR destruction to hpriv_release()
Date: Mon, 21 Sep 2026 13:26:39 -0400
Message-ID: <20260921172640.72798-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomer Tayar <ttayar@habana.ai>

[ Upstream commit 2e8e9a895c4589f124a37fc84d123b5114406e94 ]

The memory manager IDR is currently destroyed when user releases the
file descriptor.
However, at this point the user context might be still held, and memory
buffers might be still in use.
Later on, calls to release those buffers will fail due to not finding
their handles in the IDR, leading to a memory leak.
To avoid this leak, split the IDR destruction from the memory manager
fini, and postpone it to hpriv_release() when there is no user context
and no buffers are used.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

[ Backport to 6.1.y: this tree keeps Habanalabs under drivers/misc
  rather than drivers/accel; the source change is otherwise unchanged. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and Habanalabs maintainers,

I am backporting smaller CVE backports still missing from 6.1.y.
This fix is inherited by v6.6 and every later mainline release, but 6.1.y
still has the affected code. The target-specific adjustment is described
in the bracketed note above.

Could you please queue it for 6.1.y?

Thanks,
Artem Dinaburg

CVE: CVE-2023-53353

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and 9,075 modules; the same four baseline objtool
notices appeared, with no new warnings or errors.

AI assistance: An LLM helped find, adapt, and validate this
backport; I reviewed the patch and test output.

 drivers/misc/habanalabs/common/device.c         |  9 +++++++++
 drivers/misc/habanalabs/common/habanalabs.h     |  1 +
 drivers/misc/habanalabs/common/habanalabs_drv.c |  1 +
 drivers/misc/habanalabs/common/memory_mgr.c     | 13 ++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9ee1b6abd8a051..60a9fc65845bf0 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -375,6 +375,9 @@ static void hpriv_release(struct kref *ref)
 	mutex_destroy(&hpriv->ctx_lock);
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
+	/* There should be no memory buffers at this point and handles IDR can be destroyed */
+	hl_mem_mgr_idr_destroy(&hpriv->mem_mgr);
+
 	if ((!hdev->pldm) && (hdev->pdev) &&
 			(!hdev->asic_funcs->is_device_idle(hdev,
 				idle_mask,
@@ -464,6 +467,10 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hl_release_pending_user_interrupts(hpriv->hdev);
 
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
+
+	/* Memory buffers might be still in use at this point and thus the handles IDR destruction
+	 * is postponed to hpriv_release().
+	 */
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
 
 	hdev->compute_ctx_in_release = 1;
@@ -808,6 +815,7 @@ static int device_early_init(struct hl_device *hdev)
 
 free_cb_mgr:
 	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
+	hl_mem_mgr_idr_destroy(&hdev->kernel_mem_mgr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
 free_pf_wq:
@@ -851,6 +859,7 @@ static void device_early_fini(struct hl_device *hdev)
 	mutex_destroy(&hdev->clk_throttling.lock);
 
 	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
+	hl_mem_mgr_idr_destroy(&hdev->kernel_mem_mgr);
 
 	kfree(hdev->hl_chip_info);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 257b94cec6248b..e6eabcdda1c5c0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3789,6 +3789,7 @@ const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type);
 
 void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg);
 void hl_mem_mgr_fini(struct hl_mem_mgr *mmg);
+void hl_mem_mgr_idr_destroy(struct hl_mem_mgr *mmg);
 int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 		    void *args);
 struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg,
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index ae3cab3f4aa55a..3d4eaa7327e318 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -222,6 +222,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 out_err:
 	mutex_unlock(&hdev->fpriv_list_lock);
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
+	hl_mem_mgr_idr_destroy(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
 	mutex_destroy(&hpriv->ctx_lock);
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 1936d653699ed0..93a2b9faf419fd 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -342,8 +342,19 @@ void hl_mem_mgr_fini(struct hl_mem_mgr *mmg)
 				"%s: Buff handle %u for CTX is still alive\n",
 				topic, id);
 	}
+}
 
-	/* TODO: can it happen that some buffer is still in use at this point? */
+/**
+ * hl_mem_mgr_idr_destroy() - destroy memory manager IDR.
+ * @mmg: parent unified memory manager
+ *
+ * Destroy the memory manager IDR.
+ * Shall be called when IDR is empty and no memory buffers are in use.
+ */
+void hl_mem_mgr_idr_destroy(struct hl_mem_mgr *mmg)
+{
+	if (!idr_is_empty(&mmg->handles))
+		dev_crit(mmg->dev, "memory manager IDR is destroyed while it is not empty!\n");
 
 	idr_destroy(&mmg->handles);
 }
-- 
2.39.5

