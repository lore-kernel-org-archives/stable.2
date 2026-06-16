Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1C349CF0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636750; cv=none; b=Zp1AMs7zMLR7+Cz2SfJqB5zOpme56YxWAXlmhVN/Io0WtOT5mLFyAIviRmo54dYs6YSmwmh6ngsqkLlebp4HhFei9fKT0r1fbNPOo5eG/ybVvU1B4lCKi50ZnRHllOQxfL6Vt5jqIF+9V0nWIrM0xnh9mDf7Apv9LRwOWi4LJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636750; c=relaxed/simple;
	bh=amcjJBednlEFh2IL+uqwHkzw0/CkQWJMvhfwS/bscaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P81TmEoDNNsA3ia5jD38gjOx/Mf5Um4eqjyUdBocaZrwHWD1sIk1aGkTTsX5p0JTegKfs/BpwFuxrHiWGys7U9IYbyeQoOvpNUh1ituQ9mo2CbKh+PvH2xb64r7fWPcSj76XIzQ5XY8gYuH+sFW5gy1rNPnRkKekoMeNQxxWT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEEPP6J2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEEPP6J2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781CB1F00A3A;
	Tue, 16 Jun 2026 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781636749;
	bh=RrsFyihJ62VXemfbCsMt66zPcZy6ph/A+GD+WJPcF98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEEPP6J2qZRCjYH64/+i+uLEAhXUyIGkBVCKxvnvqrbeDIAeWsA1zt5L21eCrMYmE
	 g6SRMrl54Tek15asMNhpCgca9oJJuBJ0JfskGBlfcbojbwiiGqXIcLg6WFTwNeIEQd
	 L4OK3wI3gI6cYaJ/moOCiAwraEcGtvGj+4IKncpWluFG4x/UOZRoiVlLKAGlf9Atam
	 kgIHBA+xsrFzKBoPXkC+19y1Se+CKd852jvzUPQ5UHRGi10mBGUn0uw6Oh6Uuz931O
	 JsuZn7qXFMTxJSWojCT/fFi0OxJSPdJ0Sv1I5Sx9UuzgSVJB+L2wzHMMq6+buwmMuk
	 DMEnBwMLhacag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
Date: Tue, 16 Jun 2026 15:05:46 -0400
Message-ID: <20260616190546.3486929-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616190546.3486929-1-sashal@kernel.org>
References: <2026061529-portable-excusable-b916@gregkh>
 <20260616190546.3486929-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

[ Upstream commit 5401fb4fe10fac6134c308495df18ed74aebb9c4 ]

A NULL pointer dereference was observed on Hawi at boot when the DSP
sends a glink message before fastrpc_rpmsg_probe() has completed
initialization:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
  pc : _raw_spin_lock_irqsave+0x34/0x8c
  lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
  ...
  Call trace:
   _raw_spin_lock_irqsave+0x34/0x8c (P)
   fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
   qcom_glink_native_rx+0x538/0x6a4
   qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]

The faulting address 0x178 corresponds to the lock variable inside
struct fastrpc_channel_ctx, confirming that cctx is NULL when
fastrpc_rpmsg_callback() attempts to take the spinlock.

There are two issues here. First, dev_set_drvdata() is called before
spin_lock_init() and idr_init(), leaving a window where the callback
can retrieve a valid cctx pointer but operate on an uninitialized
spinlock. Second, the rpmsg channel becomes live as soon as the driver
is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
is called at all, resulting in dev_get_drvdata() returning NULL.

Fix both issues by moving all cctx initialization ahead of
dev_set_drvdata() so the structure is fully initialized before it
becomes visible to the callback, and add a NULL check in
fastrpc_rpmsg_callback() as a guard against any remaining window.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204528.116920-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d3f2d42ae95908..0af6341963fa61 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2149,7 +2149,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -2157,6 +2156,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 	if (err)
@@ -2223,6 +2223,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.53.0

