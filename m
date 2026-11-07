Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046712;
	b=mKRbaSoeKrFQUF1xZzcHIz+U8xXKgefmPzOuiZ89KzR095a9d6KYBetNI05rxJHAYUoN
	 u0VH9NYiEwpBRwb7+J5YwnVRAfvUgP7t9veH/obwNWkDJUTJ5ScsdQCLuphh2qLzAov1q
	 PIms2jl7RXSFiV9H7k08vpj/pd0QPFx2qB6t/ZtydguJ4FNawygTYDqT3N97Y1CIeLHSS
	 uZ+Y6IAI1+VHXD7flHS2Obh09zvZG/mLmdgWe7NjCaroo6xuL8oGaYspL6JeJpWdTbUjf
	 jnhyi8DgCNU/EVzqrSAZrfXP7tAwxoFqrle54TOvs9Zf745VSmE1P5lGlxz5yxeZRgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aXJuHTCSpyQg0+Ao+cnaOujxNDokkuY7zw4UbVYCWDA=;
	b=e5iA9czplmCZ4qCDWBYVlWXjC2GnUvHaZQm4vXUaFfs7haSftZzpOQIZqcpoaeSZ4WKc
	 Ws2NpL44JqPYoSejf9KmgmC0k4AndoD9XZfVEqgb/HZzJqYC50pIpsz1dRWk0OeEQ2mOc
	 Bn7gh+yN5r/iKxuApb1ae6u2UBsqQR5F2aMk2hBrYjsCJ5oUf1HLmYHKEmkPObWwqa5kd
	 ATAwz+IRu0xggtMrzKxli8RrsnSYvOuquR3jGs8PEx11YlE8UcNsVUeigaD5B0y5gFhFx
	 5fQnrw3MtK2vYmC2DakaXcfbAb6yE3+ysn+m8HAndBPonCOIH1fS6arFn1KlUcztyQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=du9PVp4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99940608361B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=du9PVp4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E081F0089F;
	Sat,  7 Nov 2026 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046712;
	bh=aXJuHTCSpyQg0+Ao+cnaOujxNDokkuY7zw4UbVYCWDA=;
	h=From:To:Cc:Subject:Date;
	b=du9PVp4ODVAjVS8m2VroOVAnyt7Mp6MoxTTsXPFkLCJEmthzvaAPm+IQ3CsYVsBsp
	 yVYC1zNSO2BTxvBXZd1YMjRQdQFZyDfBoMhCz6kkMn89y1LiGcNAAPEspAyLn0oLoj
	 RlKJ7+xm2+fSfOh+OKusGdPEFdQZj/roHnqaWAMN+FIv6BueL/EEh1/x1944EIYAnw
	 qsYfrCFaoHKEnYIQYsw0k2EKRwHB1qslWHeDxacCY85QsrFcDDGj1LvS3q52F4Q3Di
	 6misKKMiSrO6Pv+AQ/G5QP6cjctfJ6niepPSsK69gKI7dIo6gapPvr1/DipJso1vIz
	 IYlg/0uiELbsA==
From: Sasha Levin <sashal@kernel.org>
To: devnexen@gmail.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: ipu6: Fix firmware config leak on stream start" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:31 -0500
Message-ID: <20261107051831-failed-6.12-d3d9bc694fe0@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d3d9bc694fe087c672c3ad5871984dc45cd9f425
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051831-failed-6.12-d3d9bc694fe0@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d3d9bc694fe087c672c3ad5871984dc45cd9f425 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 29 Sep 2026 15:37:30 +0100
Subject: [PATCH] media: ipu6: Fix firmware config leak on stream start

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
---
 drivers/media/pci/intel/ipu6/ipu6-fw-isys.c | 34 +++++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c b/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
index f4f1cf7c86d20..56bb67869bdd0 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
@@ -208,7 +208,6 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	unsigned int max_send_queues, max_sram_blocks, max_devq_size;
 	struct ipu6_fw_syscom_queue_config *input_queue_cfg;
 	struct ipu6_fw_syscom_queue_config *output_queue_cfg;
-	struct device *dev = &isys->adev->auxdev.dev;
 	int type_proxy = IPU6_FW_ISYS_QUEUE_TYPE_PROXY;
 	int type_dev = IPU6_FW_ISYS_QUEUE_TYPE_DEV;
 	int type_msg = IPU6_FW_ISYS_QUEUE_TYPE_MSG;
@@ -218,7 +217,6 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	struct ipu6_fw_isys_fw_config *isys_fw_cfg;
 	u32 num_in_message_queues;
 	unsigned int max_streams;
-	unsigned int size;
 	unsigned int i;
 
 	max_streams = isys->pdata->ipdata->max_streams;
@@ -226,7 +224,7 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	max_sram_blocks = isys->pdata->ipdata->max_sram_blocks;
 	max_devq_size = isys->pdata->ipdata->max_devq_size;
 	num_in_message_queues = clamp(num_streams, 1U, max_streams);
-	isys_fw_cfg = devm_kzalloc(dev, sizeof(*isys_fw_cfg), GFP_KERNEL);
+	isys_fw_cfg = kzalloc_obj(*isys_fw_cfg);
 	if (!isys_fw_cfg)
 		return -ENOMEM;
 
@@ -238,15 +236,14 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
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
@@ -311,6 +308,20 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
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
 
 static int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
@@ -324,10 +335,13 @@ static int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
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




