Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713697;
	b=uLY+NqjEtjWosfBViPjzuCUGTJqHyGeD8nMdixILjNgIUJu1XQZmSNU3umkh9uhFXrEr
	 CFgAP7LQtFEYhQXyNy/SmI5AMJOL/1zg1P8EoqvBe8bQ50uucqvOoUtXBP745qsf2d5oK
	 n2AwUFy8pg5Qu4TqQsyShoLB+V40q/vT5KmwUnPDQed+S/hHOrQE3k/HPolPkOp05wqIf
	 TFw7bHGcEmk/MplJpPGhEr4ogYJuzuAZKq2htxRf8B+pQmvD0l/lFGDsOzHxDAITXqmUN
	 ctb4OZVztFMFfxTod3YsIk2+pOfHBtoiBsUBNLupIoboOu6XBu2CGaB3dRL4myIYOnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WEtxjUJNyCg5rhAThfrpDMLVSn1Y24qgWM7Wv7T5lXw=;
	b=WGMJh2vgXP24GjjIifsnBvuICUzgj2bXUZ2iCk/UaYCpJyMA7MSkrp++vbnulpcqdo92
	 2sVtSXVdGTbnwheOaGx8KVKKEYsuksz9gftuYb9uvNo1hKCQ2NWUh1Li2oURRC6uN+2Zo
	 t2ysUjhNbmLLOkqnplaXH5IWVHUa3q44YvrhTW8TzEWM6Zr95Yt8dNki/Luci0aHOxUez
	 sykceN3LEuzSedHACtQKZ24FxcOQpEG78VIadiX7dALnusKPW4jFeuNB08wzs2bfgkZYX
	 lBUMG37MI88tPyWb339YtZYHmbis24n7Lv8DwYh6uuBidQCwjU73qFBQf8346UMtefA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQiR0yjX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA02606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQiR0yjX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823581F0156D;
	Thu, 26 Nov 2026 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713697;
	bh=WEtxjUJNyCg5rhAThfrpDMLVSn1Y24qgWM7Wv7T5lXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQiR0yjX1dYyYiZPfTbsVamgbUYF6dxHTyuOqFcAEkhmPh20CrXVW48eRjsCpd1u1
	 GS7rS5OrNtsGMqPHmQgb4S5ngaqlflvDVt1LtS3LGpuZ5je8kypa66LuJ3ssQd0HyY
	 HfLa17gKc82MHWfmMRtzboPIFAByFs1iTTTKbLqdcdHb4C6x2AnUKRVsKp/kg9fgs3
	 MaA8JlFce+7ttP5uKizkwem9htsquCd63UkqVCBG/nPpP7J8g22jWu2dKoWgZ20FQd
	 cTt09zVj/WWdll5NhclsqP8o//jGFagkow+LmoKYwUKmFqxJ8OYGHSsNVGfxm7HHRt
	 M3EhC8DDmszbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: keliu <liuke94@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] iio: Directly use ida_alloc()/free()
Date: Thu, 26 Nov 2026 12:21:34 -0500
Message-ID: <20261126172128.2745277-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-repose-unboxed-3df2@gregkh>
References: <2026112508-repose-unboxed-3df2@gregkh>
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

From: keliu <liuke94@huawei.com>

[ Upstream commit 319dbcd84fd2676afb2bcfee575fbc1fce474ec3 ]

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
Link: https://lore.kernel.org/r/20220527091739.2949426-1-liuke94@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: d32bf759801e ("iio: trigger: free the trigger ID after device_del()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c    | 6 +++---
 drivers/iio/industrialio-trigger.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c52b79a86ab49..d58cc1994c80e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1651,7 +1651,7 @@ static void iio_dev_release(struct device *device)
 
 	iio_device_detach_buffers(indio_dev);
 
-	ida_simple_remove(&iio_ida, iio_dev_opaque->id);
+	ida_free(&iio_ida, iio_dev_opaque->id);
 	kfree(iio_dev_opaque);
 }
 
@@ -1694,7 +1694,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
-	iio_dev_opaque->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
+	iio_dev_opaque->id = ida_alloc(&iio_ida, GFP_KERNEL);
 	if (iio_dev_opaque->id < 0) {
 		/* cannot use a dev_err as the name isn't available */
 		pr_err("failed to get device id\n");
@@ -1703,7 +1703,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	}
 
 	if (dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id)) {
-		ida_simple_remove(&iio_ida, iio_dev_opaque->id);
+		ida_free(&iio_ida, iio_dev_opaque->id);
 		kfree(iio_dev_opaque);
 		return NULL;
 	}
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f85478742d505..bf09ddee2bf7f 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -71,7 +71,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
 
 	trig_info->owner = this_mod;
 
-	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
+	trig_info->id = ida_alloc(&iio_trigger_ida, GFP_KERNEL);
 	if (trig_info->id < 0)
 		return trig_info->id;
 
@@ -98,7 +98,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
 	mutex_unlock(&iio_trigger_list_lock);
 	device_del(&trig_info->dev);
 error_unregister_id:
-	ida_simple_remove(&iio_trigger_ida, trig_info->id);
+	ida_free(&iio_trigger_ida, trig_info->id);
 	return ret;
 }
 EXPORT_SYMBOL(__iio_trigger_register);
@@ -109,7 +109,7 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 	list_del(&trig_info->list);
 	mutex_unlock(&iio_trigger_list_lock);
 
-	ida_simple_remove(&iio_trigger_ida, trig_info->id);
+	ida_free(&iio_trigger_ida, trig_info->id);
 	/* Possible issue in here */
 	device_del(&trig_info->dev);
 }
-- 
2.53.0

