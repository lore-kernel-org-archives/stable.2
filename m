Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045834;
	b=ZWpoE/P8psHRBlxNgfsm0jWXwZ1K00h4ws6EmCZQ3chajjmcTqX7MOHR3vrdji1IZ8QR
	 gFjDjUYiKguZJbCIROiq9wYQNRMNVs8jc0Rk7AVZM9M82PyLgHZBhW2puQ6A28AKa45o9
	 udLo05y9NzT6CmOxu9DksGiWLnvId6csOCSZGzjb1mZHT/k5y5bGpqOUhuIW566Q/IvnL
	 flACqenb8uyP+bIylcmjf7zONxCJhUUJ7LFeMwMgbspU4uIoWCNKU/n9UlYKJuRaoWFxI
	 V5pgYPO0F5yaFz2P0EISvZm6DKn2kE7J6sIlcI17OoHn1QHmGVAg40nTm/i8Q1xOtbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045834;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YJBcsYT0D5rMhgvpcInpaHTIP/nGK56o+JErFe2HaZg=;
	b=CxwBmS3/t8ibuknKFI7/y4qn8eTpbLS2cFJH8IJoNKqv5pCeHTu25hLalRtUDwxDdv4e
	 iv/yvDqifSxAdxU5dP5wFSmRCeUMWScEq4bvSEiypmZLQIlW//OQhFCbfX1DVX6U7LFWU
	 9SpKJW2U8niTy0IoiOzBzOxf1KuClW0WvM1qv+l2HknVwomINMoRRTKqf7mA1Xu5Vq9xf
	 TaD4Az4/ePS9cjLFzEJSOVFChJ2bR2ka6v90dIMcsfd4QHsM/PWRzwkJf3U2pnXAWWmzB
	 xdhjSlLdOrj8lq8LsRma67e6wk4Ug/Z5hB2oy36JcSnUsovYvX1kGHJRkPsKRanSkng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihKrnLNj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56855606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihKrnLNj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87D01F0089F;
	Sat,  7 Nov 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045834;
	bh=YJBcsYT0D5rMhgvpcInpaHTIP/nGK56o+JErFe2HaZg=;
	h=From:To:Cc:Subject:Date;
	b=ihKrnLNjjKXQgCyurb54f3tKqvrGWGWxqdv4Oh8nefQuCYIZCfRUI0lcwtMbKeXN/
	 0hVFl6CsBlSCtYYP2W2jzFxqw7BxVLyvHUY/eXoYCwW3O2LB2MEOfLfDNXER5kOD+m
	 SNvqZaAWFQzgns4ihhnmB/FG+3uhOreCV7pMhjAF21KWhhE0DfSWYe9xAt+qVaFeoL
	 VgoIMxyUBQTrePeU25CAxxHeYZMap4JsOFB1mQ71DjoLL50jbi4f6dxylKlaMbwgZA
	 rcrRp0XfxZO25O9eh8sQwahIoQqQ0AL8YfM78Wywih+DKLCFSpqcjGcIjZjfIcdnZD
	 2AD3oyox92iJw==
From: Sasha Levin <sashal@kernel.org>
To: devnexen@gmail.com,
	sakari.ailus@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: ipu6: Fix firmware config leak on stream start" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:52 -0500
Message-ID: <20261107050352-failed-7.3-d3d9bc694fe0@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x d3d9bc694fe087c672c3ad5871984dc45cd9f425
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050352-failed-7.3-d3d9bc694fe0@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




