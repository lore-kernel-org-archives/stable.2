Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F67352022;
	Sat, 30 May 2026 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173944; cv=none; b=aWJyfkymE76/BF9OpzylsFJ+AM2QszsE7Kg0Enkk8kQ4m24xCyKnoaM4Rl89AQbBBNTGmLBfi6aHqKKkyKd+C+161/QJ0ExaclL1uBlIFbiJrs26FXkvXDkomrS8cjKwuLt2Zw/giIXxfDZoBJVhIRnzh7xZu5KuiTvy2dJg7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173944; c=relaxed/simple;
	bh=09iULX3L/L4V9t85WZL43bXoI4CBZl1LSiLCFd6Qd3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvkZ2+2dnSjaj6HFbIBCBhQ+tUe8zfZlZjxtm4L8UdYjma2ur+9I4B3D7KC90lLkOWfRibLpSAIeXc3h45PmxttAfq9dRvsyC/Np58Fux7zj73bu2d+fhgYEjNxuzlPLIzw0V1uXZMp4Ji2xdPXRytm+EtGiinyK0ztLyxevV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ8C3tFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ8C3tFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CD81F0089A;
	Sat, 30 May 2026 20:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173943;
	bh=HRxagvXZddwvmbuhDxGbZLEVAk+J9P4idy2x6+WVz8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZ8C3tFplF6YCq/OCPfKg4sV+MYF6imiRJtMOni2IGjalbF2VwpPYnuQWMBMX5ZbT
	 WykHePyyrfd07xi/c+z7UgbeU8hIxa7CJkF7dTJqQRRon0FaNa1XmNclKkD/sIz5wf
	 T2NzQsLx6Z9TSBYJUVuviwb7rtOHEg1zYXYCbSHq8Fn8DIn6MzAtDwvWLq4zyli/Xs
	 XxCOI5YmDu7YDgQxEjU6sKNYB20moG+xrZDutnBEXwKHKd7hF+R4RiTVLJmAqIObvn
	 i7jbM8dq0M9gWEbAtxYR6r8TcM1Na32ItP/7B2S8XymaOJtYGT7SSxgFpx81HtxN1o
	 IRuOmZJzWTm+w==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/4] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
Date: Sat, 30 May 2026 21:45:27 +0100
Message-ID: <20260530204528.116920-4-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204528.116920-1-srini@kernel.org>
References: <20260530204528.116920-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

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
---
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cca7489605c5..47cf3d21b51d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2460,7 +2460,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -2469,6 +2468,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 	if (err)
@@ -2542,6 +2542,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.53.0

