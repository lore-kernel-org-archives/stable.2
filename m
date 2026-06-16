Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73C3E1682
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649609; cv=none; b=cLcj5ioISXGkJo4fyn9KWWhkORoqLretVcPNNXTt77O/+Z5gmqPntl9fscfkEJEV1BHMrrIGkHL7JJjx9UqzqFOkUuoCzQL0xS6SB/dYXN54jiY8SIenUW9Q/5hlFHcOQ4tUJQFb7B2i4shr4sJpCn3KDn7GH++LDlEhu1FYsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649609; c=relaxed/simple;
	bh=Lk6WcPYU1G+u14f4VrjFD0n65ARN5VfTljDuGfMyL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHIwPS/BzeoZlZNnbDhDBZvSBfqRaiSCSU5d56Igd2js7rbt0xxsZX1cP5N5LnalLjLFsLNJrtRkNMSK3bnHE+2VXfToad0ubuQDIWL/5jr0R0tIC9FZUSI7qZ4cNG76zzE+9RsjWZSZlmRiQEcuS6lLH5NYpAUv9p77bsizdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf7cbPrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf7cbPrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD4D1F00A3D;
	Tue, 16 Jun 2026 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649608;
	bh=9T4tLGYTg+MWHVW5myX4bSoK9CMatrpLSw65cwe86mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vf7cbPrt+ozPylgPlsnTe5TBHxqvzVTKgXM2rY9biNLshYmUkoADb/iDGltzWwsya
	 qJg3SevlDC7MtB+IMLsA9h/ekWaHVOnBVWX05LnzqqjlLoSa+JFwpO7d8SEHq3C/nI
	 bLMQEnPMSznVB/IanSd8p2SK+6ISOcuEzGIfj6uIYL7p8JuwlwDZqX2K5qM58+hdfb
	 DYAXoOsPjxwDwxbVNTPBmqQdAawbpoZlBMhVcmYFmYkNkAfp1DuBl1ybGL3dBaTpcD
	 Xps7p4gTZUvpn9N+U1TXUzcwR6Mf1Mc6+oKSDpshGZwH7mAX1txKm1BppnhDnq8GI5
	 7IsV/by/yPSfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
Date: Tue, 16 Jun 2026 18:40:04 -0400
Message-ID: <20260616224004.3558667-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616224004.3558667-1-sashal@kernel.org>
References: <2026061534-unlikable-frolic-167a@gregkh>
 <20260616224004.3558667-1-sashal@kernel.org>
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
index 2f6df86881b606..b8d7764594c1c2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1660,7 +1660,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -1668,6 +1667,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 }
@@ -1715,6 +1715,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.53.0

