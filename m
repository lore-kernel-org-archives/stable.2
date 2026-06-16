Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C53DF00C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649608; cv=none; b=eS/lFUuNsqiOh4fLkfyduzZn95BWiEfAwTRAlnKO5mTpTEVkeUJ1/8pnqdHamM6uzikjbRs3EUA9pGtGwcr4iyHcho8QthGn1mCNRSksPXW8l7AKtE4JjduG0EZ53msWTtIDYmoumKlVeYuOe5K+i+1BNjYhfwOQxXDonvlcKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649608; c=relaxed/simple;
	bh=jxoKKTFvKrAEAU9lyPMxgu3P59Dm3EDbadQIZ3jyxQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjL7JBnsSRK+R27tb+8dOp36+PB8S00spLz2dz6UoPK3MfFT2tcme79M/j3hcytxtQ0itNHbZKNXJfvnC4131eCgs5hgdYtWKnCIrJspT7nsTF4c0WaL+uV709xbKtPWj4e/X3LQE9Ncw9qdbRtBkfw0zdSNU7VOUNNW5QXlTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oain2oZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oain2oZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99371F000E9;
	Tue, 16 Jun 2026 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649607;
	bh=q3tUUZXmU/BRUzhoKHIQUW/gatt07Apiy2JTUEuy/HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oain2oZuGwTn9MieW10nnMw1DsOamK7NpBfjEW49nvVj6vgzDDISQUDIsYeFFwmnM
	 9ZPJHZTHxigb0d1gnwsaL7AKPkMA8znFwTtLvcR3K/MgRem1GiFMO970ArJyKaYpfM
	 VgcLA2of4wPYcQlfc+EVMA5H9KLpvxxodxekO7UhShTJzrW4cBbJI1/h2EhXwLLG1G
	 auZDYu+wFdYWYPtGgO2G3A6q1hlQlB0SHYrqR2vHKeF6G1i0Sg8BxLhqz7P0st6B8i
	 gh2QkAPhmoDdT/FNYZdLTTpp/4cZIIAzzdchYbQXgA84xc1fwaJ/Oo8C2gkT55J6kV
	 /DkWftvtegN0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date: Tue, 16 Jun 2026 18:40:03 -0400
Message-ID: <20260616224004.3558667-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061534-unlikable-frolic-167a@gregkh>
References: <2026061534-unlikable-frolic-167a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 9bde43a0e2f469961e18d0a3496a9a74379c22bf ]

dma_set_mask_and_coherent only updates the mask to which the device
dma_mask pointer points to. Add a dma_mask to the channel ctx and set
the device dma_mask to point to that, otherwise the dma_set_mask will
return an error and the dma_set_coherent_mask will be skipped too.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20221125071405.148786-11-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5401fb4fe10f ("misc: fastrpc: Fix NULL pointer dereference in rpmsg callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af8412dd590ef6..2f6df86881b606 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -214,6 +214,7 @@ struct fastrpc_channel_ctx {
 	struct list_head users;
 	struct miscdevice miscdev;
 	struct kref refcount;
+	u64 dma_mask;
 };
 
 struct fastrpc_user {
@@ -1660,6 +1661,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	spin_lock_init(&data->lock);
-- 
2.53.0

