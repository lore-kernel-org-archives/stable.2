Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606493;
	b=ZKlq4fNGy7NTi62ljwhd7QtpQjHKbBwzaosORhT0MlC9NSCaYvgl3IWv7IXV4Sxe2q7e
	 j0VcfGSOvyalGYrvu2qzNqWKheyUbwb66lLXm3ioIhTE3/XbbcTuSyZMPAhNSYuyNmlzV
	 uwg06ODdk9HjWV1Khj1rQ54Xdc9NMLINmS0fOWh5Wfb4KWEFDQTeEIuwqHsJKtJ0g/xz6
	 s0ibkUSQSnJqFcPg0gaHmhVT4n8KyNzAuSNhAmxHQqSB1W5iIC2GlsqZVSZnYapeoEHoR
	 giiL+yGrWFVwNcNyy8y0XrDEcqx+ULXVfgXAAivq0e/HxQEJWTFDW4X2xOyrAGZ8lsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tRhNWivZSw3mIS21gLSttP0TksdvFQvMGJw8Ec1v+p8=;
	b=UPqg6e0Y3cWmk/rpCSrVH2XoYoAUrO47Zjz2qWl1fCoeDyRNHVXzkiOKmEKaIWyEV7Wu
	 7Jml4obwqhupwRRcOUuL9W3JP+/FRfbtmo8RkPzWyASBC7L9B85juur8CO4ATSM7ETsm1
	 nCf8wcUVXaRQPxxXzLK3mK2H0Z+PSYnzZ6BxdwllK4KEDjhIx8XqZJdbJZco+BHTwWZYb
	 8cZlUG8Fd78Ku5IDUN2C0tngngNKQFhDgngsJsf4CrPfv7pAZqePXZWD7nRo0tDaK3wc2
	 cfipmrb/IIapA49sb3HyxiZOYEL5FVHNQdVnX3raKNYEoUj5CNML4OF7VjiKWHbKcdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--powenkao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Y/OrJfNg";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE96606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CE96606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--powenkao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y/OrJfNg
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso6416146a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795606492; x=1796211292; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tRhNWivZSw3mIS21gLSttP0TksdvFQvMGJw8Ec1v+p8=;
        b=Y/OrJfNgJLRf215hhyTK7rfkSb5aZTlD1R14iTqTF9km4ls8rJnhaaFdcwwE4WHjXd
         7FpVRKQ1Yy/fm/COa5H/L4HdP0ubZAH6OPQ6VX1GF078CiDZ18OLhQ4ROJqav3HVBQlH
         I47vNqs+ACXXYRJUKJUzwPvgeG4mJGPpnSIJpwW3McWi+jFS15/G+AgTDnV5fEP6h+li
         vy5n6c+KYQGMEW1IJ4zP1zZgV5amrb/2ED1Ge8r1Yk95ouN6O+5QpvSOketdAO1Xu0EZ
         vHi2iSRmsd2HWMlzNtW8wHv1j5nkPH4M3qt3rfp5j8yOjVSa1XODUcntXAsa43EwPbql
         8LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606492; x=1796211292;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRhNWivZSw3mIS21gLSttP0TksdvFQvMGJw8Ec1v+p8=;
        b=XvBS1OP5WI5Vgvo0vDuA2glgyIoptlAveX/CWlym+R2L5yClrmTuiIFqDVlGjtC66r
         /60sOPNBgydVYoLdmKS3HBS1iyB8JKSlNc6qWNf35X/yqCu4/LJJ2oNP19/SPWzE7ASs
         n/o6Bt3Kux0Cr01o3fHhNoa3lQTrmvAfZJc3t3bGGsqykwspn23wXf0QVs817jTMMJHM
         /huy8YaZG4E2/cKyPXMRiLN5u7EoHQHu0+DHqmL3n0CN7yZnApMTbyMfd3UewqXYLAhZ
         1vThthcZ3zkaE3zhBfHa21uVUw/iZC/+1Ly18mNURFecBjkwWpe8mq6UoKKUySoXYsev
         bpVg==
X-Forwarded-Encrypted: i=1; AL+hErF80h59iuNUdF+GUUaQDSw3S0NqNMYf5McaAL4hdC40M55BHbHHyeAP+2NCOSxRJxTtGtw9aI0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mgAqp/iZCTmiOHwknjGB6D79Xk1bfacXsuHNYZ/ReFu6DNgjn
	BHM/vvSWaxVK5dCg9eLtSpFAHJzOkiktd8YuYLRJZ663eTg7yt4UvoAOEdSg3N9VK/ocZHaz7CV
	g0ojnMcLki7IYbw==
X-Received: from pffh16-n2.prod.google.com ([2002:a05:6a00:c250:20b0:8c4:bb6e:711])
 (user=powenkao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:748e:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-4014c251613mr19030501637.25.1795606492379;
 Wed, 25 Nov 2026 03:34:52 -0800 (PST)
Date: Wed, 25 Nov 2026 19:33:59 +0800
In-Reply-To: <20261125113435.1426680-1-powenkao@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125113435.1426680-1-powenkao@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125113435.1426680-2-powenkao@google.com>
Subject: [PATCH v3 1/3] scsi: ufs: core: Remove debugfs before removing SCSI host
From: Po-Wen Kao <powenkao@google.com>
To: linux-scsi@vger.kernel.org
Cc: Konstantin Vyshetsky <vkon@google.com>, Randall Huang <huangrandall@google.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <mkp@kernel.org>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	Brian Kao <powenkao@google.com>, stable@vger.kernel.org, 
	John Garry <john.garry@linux.dev>, Li Qiang <liqiang01@kylinos.cn>, 
	HOYOUNG SEO <hy50.seo@samsung.com>, Hyeoncheol Jeong <hyenc.jeong@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

From: Brian Kao <powenkao@google.com>

ufs_debugfs_hba_exit() is currently called only from ufshcd_hba_exit(),
after scsi_remove_host() has removed hba->ufs_device_wlun. Active
debugfs write handlers (e.g. exception_event_mask) and
hba->debugfs_ee_work call ufs_debugfs_get_user_access() ->
ufshcd_rpm_get_sync(), which can dereference a NULL or freed
hba->ufs_device_wlun during unbind.

Call ufs_debugfs_hba_exit() from ufshcd_remove() alongside
ufs_sysfs_remove_nodes(), before scsi_remove_host(), so in-flight
debugfs file operations are drained while the WLUN is still present.
Switch cancel_delayed_work_sync() to disable_delayed_work_sync()
(introduced in v6.10) so an in-flight exception event cannot re-queue
debugfs_ee_work during teardown, and clear hba->debugfs_root so the
existing ufs_debugfs_hba_exit() call in ufshcd_hba_exit() remains safe
on both normal remove and probe failure paths.

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Brian Kao <powenkao@google.com>
---
 drivers/ufs/core/ufs-debugfs.c | 3 ++-
 drivers/ufs/core/ufshcd.c      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-debugfs.c b/drivers/ufs/core/ufs-debugfs.c
index 9f83628f3e2c..89753c40b27b 100644
--- a/drivers/ufs/core/ufs-debugfs.c
+++ b/drivers/ufs/core/ufs-debugfs.c
@@ -529,5 +529,6 @@ void ufs_debugfs_hba_init(struct ufs_hba *hba)
 void ufs_debugfs_hba_exit(struct ufs_hba *hba)
 {
 	debugfs_remove_recursive(hba->debugfs_root);
-	cancel_delayed_work_sync(&hba->debugfs_ee_work);
+	hba->debugfs_root = NULL;
+	disable_delayed_work_sync(&hba->debugfs_ee_work);
 }
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 56a77f4a2a6e..646359d446c3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -11027,6 +11027,7 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufs_bsg_remove(hba);
 	ufs_rpmb_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
+	ufs_debugfs_hba_exit(hba);
 	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
 	blk_mq_destroy_queue(hba->tmf_queue);
 	blk_put_queue(hba->tmf_queue);
-- 
2.56.1.839.g22a8290db9-goog

