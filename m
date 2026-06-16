Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745583BE17C;
	Tue, 16 Jun 2026 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610672; cv=none; b=BY6tHOGdvNkUg/KlRAGhpzavbmLy9QJ1EdDQZaBGFeetXeMhIlNzrD8TL1g/oP9E5Car2zKRSWNlPii1/Jv6RJia2T73rbWCBQuo0uc1q3JvzxTSLqntQzIezUvIV/FTGI9sZNQhLnQE2RvpPz49a24kU4Uz1ThkBHkzjMW4SH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610672; c=relaxed/simple;
	bh=rGwNdljfUqpsoyHEnEHB/eMCZkpIPirWx5+5+J1bEYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=opkVwXzrtIdza+gau4aP5vR2aNgzaJN5OWkb3iYTcz/caHuwL/i7BqFWKQaiySFkLw7Ib/Vo0Evyh2wgx4s6P4280VaiPBqFwq2CQwXHDfrVGlZABDQeln9dLchVepOvb/Ty03WSYIdjfD7p1cLQflPOLwU7NpJyNmCw53XMlyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P7FwAp+K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P7FwAp+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781610671; x=1813146671;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rGwNdljfUqpsoyHEnEHB/eMCZkpIPirWx5+5+J1bEYQ=;
  b=P7FwAp+KgWXPDQ/+cdgJUZ/n/tg3+j5VGPNKcyEquIg4bMfjF9YmgwkN
   +9HtLqmXWobHJhZgC9aNeeN9hZNKBCRjY6eCmB3+E4xw44tmSqdg47EmJ
   KDGfLYhHNbGhX4HzY9Uf8hpj0F9JdW8oI1LfRKDShuGh6svxQ8Onu1IZW
   PXzQS98ORmJKbpbTE4/cQTZF9edd4X22SSaqq5bpvHcKlI7hJmXUN+1zz
   QPqUwj36aJZLf8QrB9Gbf3VEaERTfVOCZf2t9iW1q6sMv3cb9TeXR31FM
   quJVIbmJmq1WjEi+Q98k/ewGwlo0CGwXGrSqNSuFv+1ou3YvElbMh16V0
   g==;
X-CSE-ConnectionGUID: yUrC5MyBQMuXhOtoFzS1/w==
X-CSE-MsgGUID: 0ftX+irHQjaICRLOaKwwmg==
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="59581914"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:51:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 04:51:04 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Jun 2026 04:51:01 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 16 Jun 2026 17:20:56 +0530
Subject: [PATCH 01/10] media: microchip-isc: fix awb_mutex and lock
 lifecycle
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-balki-isc-prefix-fixes-v1-v1-1-b23677fc5ab6@microchip.com>
References: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
In-Reply-To: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
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

