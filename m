Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74227382395
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600088; cv=none; b=PWL3vz0GfENB9Mqvb6VDSTPd8o7dhUu7M5Ai4DraShaKSeAq8bDlvg5KYFnyWe/kRCQBdvWAo3NXkyY/D8Orb5e5ADuImpyI/ufSJgyaQTGiLuhZpVZ7KnYUDMMJydWVcSgV6wFPwNdRwz2Z7WLG8e7KLTOzK0e2/1BWREyPrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600088; c=relaxed/simple;
	bh=KtGyNC1QCkL7BlMRUanRlye4XBsU+FKYPE4fRzLXnAE=;
	h=Mime-Version:Message-Id:From:Content-Type:To:Subject:References:
	 Cc:In-Reply-To:Date; b=EorOFOowuGIlES7ZhaUXg+wB5myVucFOMeA0jxZCvyIUwZVdLvNqr/Vt6OS6Byb711aSVNjWXJxXZyRmOxATS5omYV4tE6Nr5x5MeqiBIOEus0KO0B5zV34NWzC28pBoD0DhTTf98FL/Kfxjiuvsi4S8VDo0vd68qVH1pvEBdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=eG966JAs; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="eG966JAs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787600080; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=OH1V2XBa3EFVQaHX2pCS4ZMV/ZcmzVgpWewcrgvVAVk=;
 b=eG966JAsGTTjYKINbV/69IWhZLorf7f0553/LcXwEWmj1icPm5T2Cqh+f+q3W19lPESPIR
 U+6cKzCppq+1H7pgfNYFEWfDB6dtbylcQjqCJgNK/gDQy5zXvtjEK0OkzC/vegslDzLmVj
 YeavJ4Ifaa/fInMCzsOsbuMBzSTn50ML3FkwN802VZP7W0DAyxQ/RM+EdxkyiB9JQcngtm
 7YkXLzaJiR3vvBGqDc8SFiJETrH4VYL+C2Kq+1msyqGLosNz+dEHzmgJyrkcIaBGma6JNt
 HiCc966uicLamYmA5C7K2f1kO7Q7ZWohhJ/45FoTnglyzp+yrO4+qXFZ3uxs4g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: b4 0.14.2
Message-Id: <20260825-media-timeout-work-v1-1-ebfebbeb6c31@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
To: "Mirela Rabulea" <mirela.rabulea@nxp.com>, 
	"Mauro Carvalho Chehab" <mchehab@kernel.org>, 
	"Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, 
	"Pengutronix Kernel Team" <kernel@pengutronix.de>, 
	"Fabio Estevam" <festevam@gmail.com>, 
	"Hans Verkuil" <hverkuil@kernel.org>, "Ming Qian" <ming.qian@nxp.com>, 
	"Nicolas Dufresne" <nicolas.dufresne@collabora.com>, 
	"Benjamin Gaignard" <benjamin.gaignard@collabora.com>, 
	"Philipp Zabel" <p.zabel@pengutronix.de>, 
	"Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>, 
	"Bin Liu" <bin.liu@mediatek.com>, 
	"Matthias Brugger" <matthias.bgg@gmail.com>, 
	"AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, 
	"irui wang" <irui.wang@mediatek.com>, "kyrie wu" <kyrie.wu@mediatek.com>
Subject: [PATCH 1/3] media: nxp: imx-jpeg: cancel task_timer before freeing ctx
Received: from [192.168.9.107] ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Tue, 25 Aug 2026 03:34:38 +0800
References: <20260825-media-timeout-work-v1-0-ebfebbeb6c31@cherr.cc>
Cc: <imx@lists.linux.dev>, <linux-media@vger.kernel.org>, 
	<linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260825-media-timeout-work-v1-0-ebfebbeb6c31@cherr.cc>
X-Lms-Return-Path: <lba+26a8c9cce+f203e7+vger.kernel.org+me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Date: Tue, 25 Aug 2026 03:34:30 +0800

mxc_jpeg_device_run() arms ctx->task_timer for each job; the only place
it is cancelled is the job-completion IRQ handler. If the hardware
never completes the job, mxc_jpeg_release() frees ctx with the timer
still pending, and mxc_jpeg_device_run_timeout() then dereferences the
freed ctx -- a use-after-free.

Cancel the timer before the ctx is torn down, before taking
mxc_jpeg->lock so the cancel never waits on a worker that needs the
mutex.

Fixes: cfed9632ca8e ("media: imx-jpeg: Add a timeout mechanism for each frame")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
Assisted-by: GLM:5.3
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 725e941528848e8f224fe6a96ba7f746fc45ed63..fbb64a1ecb5189d2d7b953b99dcd7bcb54e6e20e 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2796,6 +2796,8 @@ static int mxc_jpeg_release(struct file *file)
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_file_to_ctx(file);
 	struct device *dev = mxc_jpeg->dev;
 
+	cancel_delayed_work_sync(&ctx->task_timer);
+
 	mutex_lock(&mxc_jpeg->lock);
 	if (mxc_jpeg->mode == MXC_JPEG_DECODE)
 		dev_dbg(dev, "Release JPEG decoder instance on slot %d.",

-- 
2.47.3
