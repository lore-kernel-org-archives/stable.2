Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512664BC018;
	Tue, 21 Jul 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629747; cv=none; b=f0ogxd1cXuAhvszzCCd4E/o4joTAsgfwNFGNx1Gujkofb6qbPbPsnKn14HGb/LPGGZXkD9TVJJ/L2rY6GarD8dFCs1SuQzgrWHRqSEC81lcPExd+Tkay7Y8775cuVoa45Csz4qSXCtMgz3dteFzJQ2siuY17qSgNqLcyZGvbMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629747; c=relaxed/simple;
	bh=rGwNdljfUqpsoyHEnEHB/eMCZkpIPirWx5+5+J1bEYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cPq7EemjPYYQ6ZluGA3/f6x22Ur6+9d/jL9RLE4b7JKKVr/Rk4bg+txlZgZvwq0h7mJpWI7P489nSQTvGTD8pUeNl3lHjmMlruURB3V9RZ38Ibi/tK9FYD10NZ8LFjUXh6EqXkecFfdSN3XkRaBoO0G6ATPyx+/8QsjY18dauHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0TYqbv6w; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0TYqbv6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784629745; x=1816165745;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rGwNdljfUqpsoyHEnEHB/eMCZkpIPirWx5+5+J1bEYQ=;
  b=0TYqbv6w054x3hEYMr122wlAl+b1jiNJBMRK751HKRqy0nsUyNdlTwF7
   yAMRmmitaeL1/4e8nHkWR3Y/n17IY1w2nSyQYALHJfOWYzqOZgIomVfvs
   sZXRO4bF+gg8YLsmq22Fdq9GLcvc+1NhK6h60047VNwNf/iW4A/8bRTsl
   5s8F6fEyae9YFLyV/epLuBegvkURFDeXMGhIzIqljbrfDCzKHlpldwOKy
   t2v1VoftSqTt6i2BO11LTxggPuKa6ihS6fEW3z6F8Hpwv0KMLob0dhU8T
   hKlyEhN63c74rUJRCCdItChmsLHsxWYcyxi2J3yZ/p34bSH/CrK63PMHG
   Q==;
X-CSE-ConnectionGUID: uoxf5opsQI+ASVhY5cugPA==
X-CSE-MsgGUID: DwHQARPJROOo2BH/ejpIOw==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="60065784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2026 03:29:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 21 Jul 2026 03:29:03 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 21 Jul 2026 03:29:00 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Tue, 21 Jul 2026 15:58:55 +0530
Subject: [PATCH v3 01/10] media: microchip-isc: fix awb_mutex and lock
 lifecycle
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-balki-isc-prefix-fixes-v1-v3-1-ffe10640a2d9@microchip.com>
References: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
In-Reply-To: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
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

