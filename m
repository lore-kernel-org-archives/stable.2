Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C93EBF18;
	Mon, 29 Jun 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731382; cv=none; b=ujLzXyT/zp26CvSjz8r8S8ZV4bCyn6ZX1jgxMLLEOqYtm9E2eRU7YL0KPGNVR8b9zN/vDalPb3lN2rhYny/UHFYh2e95dUeDqtBXiHJgOv6pFH/AVDo4hxtQM8OSiqr2XLZNoWW0sFABYzXDwsca9+wCLbhznIUKf45NCNyTvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731382; c=relaxed/simple;
	bh=rGwNdljfUqpsoyHEnEHB/eMCZkpIPirWx5+5+J1bEYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qAMoif8CHi+waks5WLRMw8OFPTYNC5JDITyXWX/4tvAUPGrXVOCDNf+F2L5wEJ2dMDx6IC7gt96O8HGjEUxJNazo15aoaMHDDRQR/fsIdZk0iFYF/i8Q3p4KKREjxpI3ODAN0JEQ3xkxTqVW/tmHqUA3e8LKTfudnjcVOzszD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=df47r3hm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="df47r3hm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782731381; x=1814267381;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rGwNdljfUqpsoyHEnEHB/eMCZkpIPirWx5+5+J1bEYQ=;
  b=df47r3hmukiNMSjy/CKJaekTU52Earc+Ef1uDWkc7R0hprwhE6hZDNPc
   opb06DwXX0Td7qHlLrS9JZDn2TtPD8wEf/xhLunIxhggd65sRdhGurxZ9
   RHs096jXQ5dNnTHGnk8ZuvFwClNuZNuV2QBhD37MnnwLAXklaKPZ1qwsI
   0QCX8y4uZArJMzgX5OF2PC12vo5l7GUUeRJ1Ia+T/Vb3+xNx1HgKJ9oLs
   qGOFJOOZXxUr0DKC3VSLVf0ewFB81plnb4/MPEFDP9hBgJbHdbIVAXKJV
   nCxeruifNKJWbcpz5Xz9O/Ou/ntvD4lTPwBQs/6tBCHXPk1C+JqRKZ+SV
   g==;
X-CSE-ConnectionGUID: whbA3Ne5SmuQ/U0Rkt+3AA==
X-CSE-MsgGUID: hb2MxaGZQ2aYvWxQrxtoIA==
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="226994157"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:09:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 29 Jun 2026 04:09:35 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 29 Jun 2026 04:09:31 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 29 Jun 2026 16:39:26 +0530
Subject: [PATCH v2 01/10] media: microchip-isc: fix awb_mutex and lock
 lifecycle
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-balki-isc-prefix-fixes-v1-v2-1-3b120cc3742f@microchip.com>
References: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
In-Reply-To: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
To: Eugen Hristev <ehristev@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.3

isc_async_complete() initialised awb_mutex and isc->lock only after an
early error return, and the teardown was inconsistent:

 - isc_async_unbind() destroyed awb_mutex before cancelling awb_work,
   which takes it;
 - a failed .complete() destroyed both locks, then the v4l2-async core
   unbinds the subdev and isc_async_unbind() destroyed awb_mutex again;
 - isc->lock was destroyed only on the .complete() error path, so the
   normal unbind path leaked it.

Initialise both locks before the first error return, make unbind the
single teardown site (cancel the work, then destroy both locks) and
drop the destroys from the .complete() error path.

Fixes: 314c96e5203d ("media: atmel: atmel-isc-base: use mutex to lock awb workq from streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 drivers/media/platform/microchip/microchip-isc-base.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index a7cdc743fda7..45a7af779323 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1703,10 +1703,11 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
 {
 	struct isc_device *isc = container_of(notifier->v4l2_dev,
 					      struct isc_device, v4l2_dev);
-	mutex_destroy(&isc->awb_mutex);
 	cancel_work_sync(&isc->awb_work);
+	mutex_destroy(&isc->awb_mutex);
 	video_unregister_device(&isc->video_dev);
 	v4l2_ctrl_handler_free(&isc->ctrls.handler);
+	mutex_destroy(&isc->lock);
 }
 
 struct isc_format *isc_find_format_by_code(struct isc_device *isc,
@@ -1758,6 +1759,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	int ret = 0;
 
 	INIT_WORK(&isc->awb_work, isc_awb_work);
+	mutex_init(&isc->lock);
+	mutex_init(&isc->awb_mutex);
 
 	ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);
 	if (ret < 0) {
@@ -1767,8 +1770,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	isc->current_subdev = container_of(notifier,
 					   struct isc_subdev_entity, notifier);
-	mutex_init(&isc->lock);
-	mutex_init(&isc->awb_mutex);
 
 	init_completion(&isc->comp);
 
@@ -1841,8 +1842,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	video_unregister_device(vdev);
 
 isc_async_complete_err:
-	mutex_destroy(&isc->awb_mutex);
-	mutex_destroy(&isc->lock);
 	return ret;
 }
 

-- 
2.34.1

