Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650571;
	b=ON/wUCS7zE4uNZl4xARIQ+TrPmeM2mBrnN+1p40WyV2REzUz23guh9/XyW0wiFSRLDfO
	 A+I/lXBEceFkSe7bKMwPvxUzBHIrWnKFitk0RKsKbTI9SNoX8hNlALwYjHF73YJ3sJz5H
	 y+py9oj5FTGDFJ/9fCRK4ZbnLPeQhmU9rCBvkrc1MsBzQ19qtvET6+sLhhAD50bviQUj9
	 buArVDSiqUQU9tfyW5bWT/y+RC145SDy1jOqGjMAakKjwCUItVLDZZcl73TQ5qwNLI9I0
	 eOUOjiRVlalQ9MXC3tRxVVbU4ls541IBe5xFLCK/R2xvHNRL3NY+XZ9bmyJk99gLytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=8MSmxvz/Uy9jUjsM7jcOMahPWugzTuF0XHssMkpFPf4=;
	b=AZIvg2kf2f34SxpXVtcjc8mdPMg1dygMlhJcYL4Va9I5hp0E0so9RKGDJBeKOIR7q0JQ
	 dLJMTimSF7l0VPOzBcyw/6zhUGUQkvQQMDGTIQAfwOVT7+RL2xZRSUikqDkB5QQMouO0l
	 hR8ZBpFlt48O2ApspxMXXQaDFzq15hQjG+kdi016gQ1YdBTfuLoOcv1EL2LANqa2dKNzy
	 SXKXl4CmCiaJUr6KqQHzB1pclE2C6jvzpjeIaMMNaL4A072GjWVfmDQThHttyeJhyG1bS
	 aR059OLaCLL/OxlPa16WOi2Soj3CLSXL1D4Q/N55DDUwab60k+9YjMdilMMBVxfkF5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="FA/mhLow";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0A606A686;
	Wed, 25 Nov 2026 23:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F0A606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FA/mhLow
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795650570; x=1827186570;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Pwd1eTPycjvX9W4eENeNt0Fu80AKwWExYRjY2yB9h4U=;
  b=FA/mhLow/VyvaI3ql78FRP5VeO9pyileb7kwfy8Qkr9h6wmtDpXZBs2G
   5O7aMdaoZUM7+unzmcQ7tkrer1ERTO2G1tU8noJRaaBgwJBEb8MXR2GsN
   AMbs+mTyWx5f/mR4UeEvIOvB5vIpg/BF5YhpGy9y9AS74xBQ6wVd3XPu9
   UEcfgQMckssfAl/jX3W0rj2T2Zc9mcdsMXmYBdX2L21bHm5OuKJhsOxg/
   UvBNYZ1lx9pETUMw6FSsDNfVREWgS2OgQfeKSFISxBnXPKawMcsw7TxHL
   ZxVjISz45GI8ExrlMatHL0/vrfVQqZvmYhj1DYwHMlyuITKp9V4pO1Atx
   A==;
X-CSE-ConnectionGUID: xmJNqnOUQySRQOqQ684Agg==
X-CSE-MsgGUID: XdubWAU5QYGNUEEaPnYGrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4597298"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4597298"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:28 -0800
X-CSE-ConnectionGUID: 3yR3WdLEQqKRmfRGJ/Pb7g==
X-CSE-MsgGUID: j9yjU/N0RIipo/kxR/qC5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11873845"
Received: from vcostago-desk.jf.intel.com (HELO [10.241.240.61]) ([10.241.240.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:28 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 25 Nov 2026 15:49:05 -0800
Subject: [PATCH v2 7/8] dmaengine: idxd: Do not release interrupt handles
 on terminate_all()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-wt-idxd-fixes-v2-7-25a4691dfb9e@intel.com>
References: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
In-Reply-To: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, 
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, stable@vger.kernel.org, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795650562; l=2871;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=Pwd1eTPycjvX9W4eENeNt0Fu80AKwWExYRjY2yB9h4U=;
 b=H0AcoYYPGhl83sj4ksOxfY2cHoMipcttTjqjBlZ6OVtht5RsAENZ2CQ70MW+G1r4ntlNfCulF
 Tkfihc8x6Z/D0QOiuJmjLVdAN1WOkCUaqfKQh8Ekc9beMgoxCjLSexd
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

idxd_dma_terminate_all() calls idxd_wq_flush_descs(), which also
releases the WQ's interrupt handle. The WQ stays enabled, but the
handle is never requested again, so the device fails every later
descriptor with "Device error 0x19" (invalid interrupt handle).
dmatest shows it on its second run on a channel.

Move the release to idxd_wq_release_int_handle(), called only from the
FLR path, which needs both. Skip a handle that is already invalid, as a
failed refresh after a revoke leaves it.

Fixes: 2a93f5747d0e ("dmaengine: idxd: Flush all pending descriptors")
Cc: stable@vger.kernel.org # 7.0.x
Reported-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 15 ++++++++++++++-
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/irq.c    |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 131138483b87..21a0c32325ea 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1349,6 +1349,16 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 }
 
 void idxd_wq_flush_descs(struct idxd_wq *wq)
+{
+	guard(mutex)(&wq->wq_lock);
+
+	if (wq->state != IDXD_WQ_ENABLED || wq->type != IDXD_WQT_KERNEL)
+		return;
+
+	idxd_flush_pending_descs(&wq->ie);
+}
+
+void idxd_wq_release_int_handle(struct idxd_wq *wq)
 {
 	struct idxd_irq_entry *ie = &wq->ie;
 	struct idxd_device *idxd = wq->idxd;
@@ -1358,7 +1368,10 @@ void idxd_wq_flush_descs(struct idxd_wq *wq)
 	if (wq->state != IDXD_WQ_ENABLED || wq->type != IDXD_WQT_KERNEL)
 		return;
 
-	idxd_flush_pending_descs(ie);
+	/* Revoked and not re-acquired, or released by an earlier FLR */
+	if (ie->int_handle == INVALID_INT_HANDLE)
+		return;
+
 	if (idxd->request_int_handles)
 		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
 	idxd_device_clear_perm_entry(idxd, ie);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ce78b9a7c641..f4aed90560e0 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -804,6 +804,7 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
 void idxd_wq_free_irq(struct idxd_wq *wq);
 int idxd_wq_request_irq(struct idxd_wq *wq);
 void idxd_wq_flush_descs(struct idxd_wq *wq);
+void idxd_wq_release_int_handle(struct idxd_wq *wq);
 
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 6a25e1fd0e62..26d75d744797 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -405,6 +405,7 @@ static void idxd_wqs_flush_descs(struct idxd_device *idxd)
 		struct idxd_wq *wq = idxd->wqs[i];
 
 		idxd_wq_flush_descs(wq);
+		idxd_wq_release_int_handle(wq);
 	}
 }
 

-- 
2.56.1

