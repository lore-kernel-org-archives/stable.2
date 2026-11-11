Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418636;
	b=Pe8OlMqy6WjsbxjchCRi1RyQiLpoFjbV+8+gJJMpX2IWEodI+xlGuZ3N/zXInlll4ZMk
	 X4YNuUPSmdTWOCqWJsAkcPo7Fh4TxYZywYsd7dX2gKUxWr0YEu7/0W4nwCLc/au+k4Vl0
	 e3Ls4bFzozB7/pqhWE+hG7Bi2X0iAYF98x/2IQz09TxoQFMR4XrGMKsM8y+WXL+t6F9KP
	 uj9Vm7qQ5f8H2asc4BKWZEYxHNw5QFBskQ9hE7efRigFVqHA7Zak0EOYCFpNuzD8IACRR
	 idYojJQFkEMLolMMM52uOd0ne2i+Oof1pHNXoEIkqX5VN/R1C/tRny0chqWu1+jsAxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4A/yii84Hr0pkSEHxfBqeIpjfn/9sKUAmcz4HwzH7bw=;
	b=0MtvXcJGYHoXMYJMRiDdQWB0Im4N8CQwFU/sB8wbZnBa6JVC/LORkcChWI3ZDXN+y07a
	 M0qLrXEMTeCXy/I3j3FiuqzwK3SOXyPhJbK4MLbX5jAjkA58GbMw6CSEknyHA8EZ+BbXQ
	 EaVnDCUyNNOaaQ7BPL9+rKPnQNg3GLBaGRdbK5oW4ydk2aKBHRrGaoAbHUplBYar2AUnp
	 wyPCi8UUolby3ZyuLMkjFM6DchMFpeXh1vU/SpfS/9ZAv7bqx1CskSvy94Uy+Cdm200Xd
	 BI50hbxe/BeoCT/UBuGLnRxLiolxLmq6cjSkpiDjM6d9YwjhaZ+xjKo1imDkxhtcWkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fd5ER+IW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28CB606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fd5ER+IW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AA91F00A05;
	Wed, 11 Nov 2026 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418635;
	bh=4A/yii84Hr0pkSEHxfBqeIpjfn/9sKUAmcz4HwzH7bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fd5ER+IWg6aBT16SvhjhQgxguA1Ulc9uEId4zE0xxOKT5ucw+yoQY1Y5GO1wYGU2c
	 NqTHkoawCMwO0D1iroZ+7uUbYLy68TJfDk2Te7Zvb+n0+gwBabqKknnxdKirRcRkCz
	 m8CNYLAI2VE4vEeng9YFX8gyNBlmZ32nMLmpPOLBmZSZPdO1N9SacGlKPEFVHo44hz
	 VZ4NBAm6MHMGbh5AYK9bh7g7BEc0bizeJp5/XaxUiMJT5n9Kx8/uCHpd30uUWmo7oA
	 Nlo6kLoILKOD3kZwsc3RH6VIyMNlHGUWrtmMND7W4W5nQVZOc/+5rpWWAAJ0T+EEe9
	 E2N9gcixnJQeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: ipu6: Fix firmware config leak on stream start
Date: Wed, 11 Nov 2026 12:37:13 -0500
Message-ID: <20261111173645.3594758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051831-failed-6.12-d3d9bc694fe0@kernel.org>
References: <20261107051831-failed-6.12-d3d9bc694fe0@kernel.org>
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
[ sashal: Adapted fwcom_cfg and isys->fwctx to existing fwcom and isys->fwcom names with cleanup inlined in the caller. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu6/ipu6-fw-isys.c | 29 ++++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c b/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
index 62ed92ff1d303..51d02649d7a74 100644
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
 
 	fwcom->input = input_queue_cfg;
 	fwcom->output = output_queue_cfg;
@@ -319,6 +316,13 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	fwcom->specific_size = sizeof(*isys_fw_cfg);
 
 	return 0;
+
+err_free_input_queue_cfg:
+	kfree(input_queue_cfg);
+err_free_fw_cfg:
+	kfree(isys_fw_cfg);
+
+	return -ENOMEM;
 }
 
 int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
@@ -332,10 +336,15 @@ int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
 	};
 	int ret;
 
-	ipu6_isys_fwcom_cfg_init(isys, &fwcom, num_streams);
+	ret = ipu6_isys_fwcom_cfg_init(isys, &fwcom, num_streams);
+	if (ret)
+		return ret;
 
 	isys->fwcom = ipu6_fw_com_prepare(&fwcom, isys->adev,
 					  isys->pdata->base);
+	kfree(fwcom.specific_addr);
+	kfree(fwcom.output);
+	kfree(fwcom.input);
 	if (!isys->fwcom) {
 		dev_err(dev, "isys fw com prepare failed\n");
 		return -EIO;
-- 
2.53.0

