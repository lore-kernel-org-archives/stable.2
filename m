Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756D45D5F5
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981702; cv=none; b=PHBE1YKG53xJ+Y2dbEmC/RuGacctt02fvjlnnXU3rzVr4LH70k5StdMjKWClvD86yajdzrl/9axYplJFI7MzuMjHF5k+L9XS4TOmHJALlHmlJwYUEGrhGvpQg6IFn/6w5dmN4XFtIIE5auf5czxxXH4Dpl+n00oKNt1nz96EbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981702; c=relaxed/simple;
	bh=N0b8EmSEWVJczB6H2qZwDcYiZkDK6GT7hkNKj4yRWHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeAYh2YWnoXvSUEtDtHdpmRIiuWU5h3NWaGDk9gXfjHQervupeb2k1z+exuMBbafCt9sUu+0siIoZSp7qBpQ1gPnLIvHCsWzjiMy08SeLjHptnLnqKJPNbpWwrbqHebRXBS4Ya/PSVI+YKsKVPD2YbXTuBcYTlJCY4zlkdFpJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVjPJbQH; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVjPJbQH"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1934592a91.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789981701; x=1790586501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZfNRDAZYMOe8/raf1+kfme6bgo4XiPP5kMyL6mrkfE=;
        b=CVjPJbQHI+RkMEXTuT5a+DoQVzH+g5w+QFeJmSjx/uyon15H6xcOm4xetV5ybkX97N
         7mOt4IcCP8PthhpahSMIf5mtPacJtdPLqe5rHkQPMVmlUn+oST85xI83poRv5ARtTi0o
         OeJ+X/Ij+1tUnW71s6a7EHjbhcIchBbwJJhA1btukNGs9PKt8KF/xQD2RnRLfOXodERK
         y69g/8KPbeIJ3Ul8AA7gRptOnjy6XtsjzwKua6Ji4U1gGuFXWj6cmRWBwUeAz3RJwK0V
         cg5Y3NPRow0MwUTX/7D+1Sio6M78anLw2ukQTNYZeHK30kA6dj87THPx/1WI/O3GU8Dl
         Gi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981701; x=1790586501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZfNRDAZYMOe8/raf1+kfme6bgo4XiPP5kMyL6mrkfE=;
        b=auhUyx3VaX9E8768z41wy7gZ7Ni0Ex3RDsLXO0IxDRaAMM4v2I2ig5jCSJ5p2Kkhaq
         G0Mi2cL+OagA4fTi455XgqR2DU9RWJmccwTzU/xxprUwWkfvxbo4AbUOV5T3FqR/NUcl
         oSfDKlCpW4aMw54lO9hwH5C+/km8otQE/XXQTJqcrPAk930D1qNK61RBt1qui+QfEApN
         pxC8vEzmYb9a4/oHREP6uD0lF3JaAM4yVsA1Das/Rdh9ouEG1d2ZlnuATaiecf/P1gk4
         Uj2LzT5u2Ejg3KDCUgRTnCgDD0eNHlat+XxR2BITuOOJY3s+GuolVD8TGVeskh+sVBtN
         sI/g==
X-Gm-Message-State: AFuF++kveuOCdZ2U7jAd+C4zZCZ6OVKOvR7BFP0eUdLAHhuLwL1wo+y5
	LGkd3Oc1Mw34JQT+O1qN2MKpnZO9dGDuZp70K2XJJ3Uqz74MOh4oWbMN
X-Gm-Gg: AYBFou3wQxBkyHHYceCL3019j12DLy85RlQvHtCmQMF2z9/JFfUZKl6xxvOLxCVUIPb
	NBTNwOa2eigX6EM1aXeOL1behqPydcZn4vpVVxM10HPhvDeH0dCCsCxUlXUS4jmsUnS9az3wMRx
	Gry3ms7ib+QvmQsys6FU9HG9hutUF4ea1ACjvdN5/0++oPJsCUqQN3of+VlcT7K/hdQTe8n11k+
	4QIde2BI9cMe6f0f/n9Nq6xus7D1aU70g4xHPGSaxbNRlPkdFRNq5rBXk82gb+oq9Nsfc/iQnFY
	Wk80Y+cwpvXWegZNfniIGt6dKd23EeKbFRRde/A4Zdg8mTDno0bhDK4XjVW7XXw4aH+9pQxXsYj
	faWUzeOYMbgQlGbLew7VDGmvU3Mbn9X642c0H8gIuxEG4QY3mrN+QgczUdzHJS9Z6/ApPidFBfI
	uvRutJonwKt6dY0iajK0uvvHs5SWzasa3GNJd27RjIyB7aKfBctu8txA==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b6c with SMTP id 98e67ed59e1d1-39e6c6a54f7mr7862823a91.54.1789981700866;
        Mon, 21 Sep 2026 02:08:20 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm13203772a91.6.2026.09.21.02.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:08:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Steve Cho <stevecho@chromium.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vcodec: fix decoder child device leaks
Date: Mon, 21 Sep 2026 17:08:08 +0800
Message-ID: <20260921090808.336112-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_vcodec_probe() populates decoder hardware child platform devices on
platforms that support decoder subdevices. These children must be
removed with of_platform_depopulate() when they are no longer needed.

If initialization fails after the children have been populated, the
probe error path releases the parent decoder resources without
depopulating the child devices. This leaves the child platform devices
registered.

The remove path has the same issue and leaves the child devices
registered when the parent decoder driver is unbound.

Depopulate the child devices in the probe error path and in the remove
path before tearing down the remaining parent resources.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: c05bada35f01 ("media: mtk-vcodec: Add to support multi hardware decode")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index e936ed8dffba..592685ad522c 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -517,6 +517,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 err_dec_mem_init:
 	video_unregister_device(vfd_dec);
 err_reg_cont:
+	if (dev->vdec_pdata->is_subdev_supported)
+		of_platform_depopulate(&pdev->dev);
 	if (dev->vdec_pdata->uses_stateless_api)
 		media_device_cleanup(&dev->mdev_dec);
 	destroy_workqueue(dev->decode_workqueue);
@@ -569,6 +571,9 @@ static void mtk_vcodec_dec_remove(struct platform_device *pdev)
 {
 	struct mtk_vcodec_dec_dev *dev = platform_get_drvdata(pdev);
 
+	if (dev->vdec_pdata->is_subdev_supported)
+		of_platform_depopulate(&pdev->dev);
+
 	destroy_workqueue(dev->decode_workqueue);
 
 	if (media_devnode_is_registered(dev->mdev_dec.devnode)) {
-- 
2.43.0

