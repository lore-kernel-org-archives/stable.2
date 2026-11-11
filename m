Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417676;
	b=HDOCsh/7pMjFfI3XIAn1PpFNiDrf+ymYo3hi+Y2Ch5x9pf7DUNnbQbBKxNTm/sZCBJWH
	 R0M2r8apUml89tFQHPg9Zd8wIS0IMAlZnBGLwwj8J5HF1UfZ0mCV/8CES7TD9RhIIVP8D
	 WsX94TBJxCesvpn45J+c9lsEnNES2hn+dkfYEPD659bXqWyb7tUkTM1RzmTR9GZ58LnPF
	 h3aFnnaZOSO+flPZPshEqMb4C2rInu6UfJgcLfBsnddtO8Cu33OclfgqYkYVyy8/pN94L
	 egZEtASSldCPAtnqUS0Jyf6xMxuqIvGKDvGYsHrXPA/F3xjRfUVkCuhdRgjg37TRSOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AKs9Bq1KjPccAx9nuTC/RQwvD+9uS4xwtSevlDBDrT8=;
	b=e18P+nAOOMrpytWQt9+c8xJvPvufAw4vbJ2j9IKfudWgI0olPxjAY7MLRcZ1x8ofc6f5
	 1TsZzXYlzs5oC+ThwajGnzoS1joHweTkNWHAtedyxqd0zwlSlJPK1sBFai2IKX2Z+Vrd0
	 HePpRZynNHxvbcWlCGxuzlxotYYd7m1/04qgITB0kLUBAlJK4qQbi5y8xPRkeMcn9HnmE
	 swGZc68BCS4rP1XiKtLsJ8V68caYKTOb1xaY5+4vpSf7Zm21Ca/u7lu8S4m+m8Nme+blJ
	 mSX9UsiTapLbMTfVW5wrAQ7MyYSlgcszE7xPOoJc+Qkil+chhg22u8pFtWXfVzWyL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYR6m9Xe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A9606A88A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYR6m9Xe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F4D1F00A0E;
	Wed, 11 Nov 2026 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417675;
	bh=AKs9Bq1KjPccAx9nuTC/RQwvD+9uS4xwtSevlDBDrT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dYR6m9XeFSbSBZz1BOEFLjSLjYYtVnXgQPQcnlexVwTqsc6pvE6Kju2f+CNBAdk81
	 Np5bIc7rEtV/lhgwUl31ppiO76IZL3c6Ayagfd2WMzttgXkgTcE5qMCk24tl1Vf9jc
	 bJP5z2+p1laAiS7mYK/UaCUZrvAoOVCdNaHGXvxqR6AGEMaj9YV3kPfH6ekIgaEcW6
	 PmXPJjhl+7Lu3DCU/1Pt/nNi3qpB8uBy68Gn6EnivVvJCSeoUbK4WC6W9Ff8kHFsj8
	 8lE5i3UHHKP0gNsG7x3u8Ps3SFqyEfiv0xl+zxWNn7nkm84iZhIVpiy4MzY4o/fwV6
	 2A5B/Zkws6V9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] media: ipu6: Fix firmware config leak on stream start
Date: Wed, 11 Nov 2026 12:21:13 -0500
Message-ID: <20261111172105.3535158-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111172105.3535158-1-sashal@kernel.org>
References: <20261107050352-failed-7.3-d3d9bc694fe0@kernel.org>
 <20261111172105.3535158-1-sashal@kernel.org>
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

From: David Carlier <devnexen@gmail.com>

[ Upstream commit d3d9bc694fe087c672c3ad5871984dc45cd9f425 ]

ipu6_isys_fwcom_cfg_init() runs on every first stream start and allocates
the firmware config and queue configs with devm, so each STREAMON/STREAMOFF
cycle leaks them. They are only needed until ipu6_fw_com_prepare() has
copied them, so free them right after. Also check the return value, an
allocation failure would otherwise make ipu6_fw_com_prepare() dereference
a NULL queue config.

Fixes: f625e8d7ffc1 ("media: intel/ipu6: input system ABI between firmware and driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu6/ipu6-fw-isys.c | 34 +++++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c b/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
index a65e9f1aa1042..9f5bd9c4ddf91 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
@@ -218,7 +218,6 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	unsigned int max_send_queues, max_sram_blocks, max_devq_size;
 	struct ipu6_fw_syscom_queue_config *input_queue_cfg;
 	struct ipu6_fw_syscom_queue_config *output_queue_cfg;
-	struct device *dev = &isys->adev->auxdev.dev;
 	int type_proxy = IPU6_FW_ISYS_QUEUE_TYPE_PROXY;
 	int type_dev = IPU6_FW_ISYS_QUEUE_TYPE_DEV;
 	int type_msg = IPU6_FW_ISYS_QUEUE_TYPE_MSG;
@@ -228,7 +227,6 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	struct ipu6_fw_isys_fw_config *isys_fw_cfg;
 	u32 num_in_message_queues;
 	unsigned int max_streams;
-	unsigned int size;
 	unsigned int i;
 
 	max_streams = isys->pdata->ipdata->max_streams;
@@ -236,7 +234,7 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	max_sram_blocks = isys->pdata->ipdata->max_sram_blocks;
 	max_devq_size = isys->pdata->ipdata->max_devq_size;
 	num_in_message_queues = clamp(num_streams, 1U, max_streams);
-	isys_fw_cfg = devm_kzalloc(dev, sizeof(*isys_fw_cfg), GFP_KERNEL);
+	isys_fw_cfg = kzalloc_obj(*isys_fw_cfg);
 	if (!isys_fw_cfg)
 		return -ENOMEM;
 
@@ -248,15 +246,14 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	isys_fw_cfg->num_recv_queues[type_dev] = 0;
 	isys_fw_cfg->num_recv_queues[type_msg] = 1;
 
-	size = sizeof(*input_queue_cfg) * max_send_queues;
-	input_queue_cfg = devm_kzalloc(dev, size, GFP_KERNEL);
+	input_queue_cfg = kzalloc_objs(*input_queue_cfg, max_send_queues);
 	if (!input_queue_cfg)
-		return -ENOMEM;
+		goto err_free_fw_cfg;
 
-	size = sizeof(*output_queue_cfg) * IPU6_N_MAX_RECV_QUEUES;
-	output_queue_cfg = devm_kzalloc(dev, size, GFP_KERNEL);
+	output_queue_cfg = kzalloc_objs(*output_queue_cfg,
+					IPU6_N_MAX_RECV_QUEUES);
 	if (!output_queue_cfg)
-		return -ENOMEM;
+		goto err_free_input_queue_cfg;
 
 	fwcom_cfg->input = input_queue_cfg;
 	fwcom_cfg->output = output_queue_cfg;
@@ -321,6 +318,20 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	fwcom_cfg->specific_size = sizeof(*isys_fw_cfg);
 
 	return 0;
+
+err_free_input_queue_cfg:
+	kfree(input_queue_cfg);
+err_free_fw_cfg:
+	kfree(isys_fw_cfg);
+
+	return -ENOMEM;
+}
+
+static void ipu6_isys_fwcom_cfg_free(struct ipu6_fw_com_cfg *fwcom_cfg)
+{
+	kfree(fwcom_cfg->specific_addr);
+	kfree(fwcom_cfg->output);
+	kfree(fwcom_cfg->input);
 }
 
 int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
@@ -334,10 +345,13 @@ int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
 	};
 	int ret;
 
-	ipu6_isys_fwcom_cfg_init(isys, &fwcom_cfg, num_streams);
+	ret = ipu6_isys_fwcom_cfg_init(isys, &fwcom_cfg, num_streams);
+	if (ret)
+		return ret;
 
 	isys->fwctx = ipu6_fw_com_prepare(&fwcom_cfg, isys->adev,
 					  isys->pdata->base);
+	ipu6_isys_fwcom_cfg_free(&fwcom_cfg);
 	if (!isys->fwctx) {
 		dev_err(dev, "isys fw com prepare failed\n");
 		return -EIO;
-- 
2.53.0

