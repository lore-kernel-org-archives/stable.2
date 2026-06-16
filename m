Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815D2356C6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639586; cv=none; b=d2Oy6iC/s9cca1iRD3Of24I7nVMOXhpdnABBnGzGezejPz1acMOTfl5JV4+4eoCyDPjlfKx5lwkBz1FGKz4OAsDf1yRmyCtfKbnjkdhhrnuBrCn69BLoMhS3xH1FWwO60Gt/1tGzhYjcxd/8NLdSSJBb9X58GSpcwzQ44NkXi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639586; c=relaxed/simple;
	bh=VXXM4mTnU8yhc3S3zFQ7bDb0OeV4hFxBLeGiVNP4ew4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY+ZBGH8tlSzvSBqfOw3ZJU6lSJAiHSWhRor4hjbU0Og34WlevYTuh8VIxeFHYUxwcu/VYIVkuRdOfScZZ6n8bylHALCW29cMGZ0vRL+y5L+k/0pkM73YsH9MOe+3R7eDvrnq9mR0sOwaOLRBefesXz0kY4kqORTaex6vmjFKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irV1ZscY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irV1ZscY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2480E1F000E9;
	Tue, 16 Jun 2026 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639584;
	bh=lHA3uLrrSwaW3LocPor+zs9OT5Xt0ChI1FmESRGEBfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=irV1ZscY30L+q2gqklzuE/CQ8F8eyMczzupfr2STjI1cnOBJYqa9vLpBuH1EdCYb7
	 ffX9B/CVptATevVusXW8XlndsVngb12QGLFnDZfsNgoRM7PKOBriitUraDf6ucxz3T
	 5gnKpBlPEepLo9tVCsORH3QcloLsjXZ8bddu3vKcSN+rKIeNJqK9A8W9hMwjyyC4Wq
	 VxYdiLFmh0BuNR5zfSIQwvphg2poGBf6vxkRKEtxd6Ts4iZnD5HP0k1v+7QGLzDX7H
	 aara2nDbm/u/3iKnfEj/JL8f5qSm0Hs3vBBlgpaZ4/njDO7zBxQHYJ0/FCVHI+JfMi
	 R8tU4U+NPG+jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date: Tue, 16 Jun 2026 15:53:01 -0400
Message-ID: <20260616195302.3526937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061532-proponent-wife-a132@gregkh>
References: <2026061532-proponent-wife-a132@gregkh>
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
index e83c1c7b34c258..fad9654a8ee1c4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -214,6 +214,7 @@ struct fastrpc_channel_ctx {
 	struct list_head users;
 	struct miscdevice miscdev;
 	struct kref refcount;
+	u64 dma_mask;
 };
 
 struct fastrpc_user {
@@ -1662,6 +1663,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	spin_lock_init(&data->lock);
-- 
2.53.0

