Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1C3DA5A8
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636749; cv=none; b=XcZWS4xH91vAMoA1er5GGCSJCw4PQr2yVGcK7ZQQ8JlM3gUiR3vPkXyZi7qbHhUVbuAF4YGawmHwan4Gb1EgPJJEjES+6EHpgXOoRUx7OC+4x2juYnhDjZP6GcggVV2eKBnWHZFubC+I0e2ucCT1gMQfmUiBZNZ8dehqZ8yJIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636749; c=relaxed/simple;
	bh=oAB7eTR4vqxZsjgKzmvwYWxCS2LYEepZIuyeXqvoh8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrlOwCRw/n5SxRqaxj71f49WUaLlF/6m+l28pxyrqIR5K9TJYwHMupDAcJ27AJxeF5h1Q3iiGud+Q9q6GtDT3/3VhrQ7V0e9BzXJ5asidOe7ihVMKzOhCvlJpjuO5UpB8eEF2hh3gKToTvL/8U2zgybjP72u1r+yKsiVcqFEb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK8HySyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK8HySyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596C1F000E9;
	Tue, 16 Jun 2026 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781636748;
	bh=zV1j8YCDZP9HDoRg9SxBRU/Cw4EJUAX2ZAd9vfHfqzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HK8HySypuy1eMM2OL5vvTawZlw8PgRV+UmqN4Cke9In0NcKXDdtgrp5RlvQXjWhWK
	 FuWMRSDvj/0ohsfqi9oqp3iFYiQddUEnKCZAfx39PAUUiEQynwseX7HdAHnT4wm8KB
	 qid9Hn7233hVidhwVONdaMBX856q5lJDdbJMv3r47WeFT7JpTEix9eVnSnT1cdGHWP
	 +NYmCgVX57GktSF8v/vz9MKF8TByug1kg12AeyuRsJq7DziLmUKyF/SBeXUFsnzbrj
	 wYKVGLSyvc/H4kEdOTsj4xH+x2mf2+HJAQdBM9OJXMs6lydlaVnWt8i59oGb6l+uZH
	 fs5h7OtKgpdiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date: Tue, 16 Jun 2026 15:05:45 -0400
Message-ID: <20260616190546.3486929-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061529-portable-excusable-b916@gregkh>
References: <2026061529-portable-excusable-b916@gregkh>
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
index 85e4a7058ea2ed..d3f2d42ae95908 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -262,6 +262,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *fdevice;
 	bool secure;
 	bool unsigned_support;
+	u64 dma_mask;
 };
 
 struct fastrpc_device {
@@ -2149,6 +2150,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	spin_lock_init(&data->lock);
-- 
2.53.0

