Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357482;
	b=MO6VpmQmRw+BLytB62v2YINxhp123TJ9srvBmij9m5pcxw7BVx8dPXhDDU8CfCF1EO9y
	 tTIo8ax5HXVLeNpueF+CtNZya5XSWBB/XTW/d+wiEQTFUqMwepcseDF2qEPEB5MT+/8SQ
	 oJEgVm+OuUEPGJaG4lBXHCtSzxMB5cWzWKkTpsVreOBwjNiT0c4H2xVm+p3B0G7zzPwxc
	 G+pAkefv1gvCGoJCKc8JNtkyk/4/daISw+PkO65s4mN/iElhF0XTwgQEr/yvWohvT5Mr7
	 D5+MnnXkN5fkfEWmmPLzZPgxV8D+j3ZoKu+QkVFvK3dKD5sXL152EwCeLzDwZ+i2cDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hwPhW4utH1xQoos3/jgYe8fS37Oc5o3R3bndMQ+Pyl8=;
	b=dQxdnJVCosRfvh7MB057aKQqs3awe/2EM5G0NFYc56ght30h2V+2gVa8sLTn5EbM4YkL
	 SVwdOARaIMhxjNGkEGxsl2LSpn8grAdfs8tjFxRpGvKnQB328jhByCIqafcH0WFIqabcy
	 poxLzb1wzZ4KNTSAXzfSDOMWIKauEOWdCJVPAohOFWHFPCPjcQUoVuGoN3djs5NtS+IvD
	 5TPX95laaV/BRelq0j8uBNBJvkWgj53ZJLbObiRogLBwr6rufyjrFx8Hx0ydiLTXT5oPn
	 PkOtAPJJW9NlG6W63LECa415MwgeBSu43azcHagH0Q8asSJ14V286+y6LmurUKk0yIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H596soXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B3606D2B7;
	Fri, 30 Oct 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H596soXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B07D1F000C1;
	Fri, 30 Oct 2026 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357482;
	bh=hwPhW4utH1xQoos3/jgYe8fS37Oc5o3R3bndMQ+Pyl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H596soXVyEIV7BAJj9qQrg3F72bRqcpo5J3/EV5Pq/fYa4nxrV/eDPQMdonZvlPlv
	 awsbvLkmBiAujrn7FKtDZ+fhZpTTSd5sbai6rNm0lzRnJX8hdhi+SZht6/+hgMSpKp
	 dZTE+GwpIfS7+XO+OsTeVsEVa1wIi7McJwngaCc8hqF0NcTztS+XU4qIeotr20WDxm
	 RV/mv3DE9fFMlulp2hAms1vATKjy6lXOurLRD/BWyovNwmIOEGOpaAkYX/FVbDhEnn
	 3hVZTsnne2ZQQq5YL3Jfzf3yGHqGtFgQb59UiQ3OygtcrFwSHFCaSOjb5+vnY4aND5
	 cjn4Z6cRieMbg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/21] soundwire: qcom: Check clk_prepare_enable() return value
Date: Fri, 30 Oct 2026 10:46:48 +0000
Message-ID: <20261030104840.3361217-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

qcom_swrm_probe(), qcom_swrm_irq_handler(), and swrm_runtime_resume()
ignore the return value of clk_prepare_enable(ctrl->hclk) and proceed
to access controller registers even when enabling the interface clock
fails.  Also jump to err_clk when requesting the wake IRQ fails in
qcom_swrm_probe() so ctrl->hclk is disabled on error.

Check the return value of clk_prepare_enable() in all three callers and
abort register access on failure.

Fixes: 02efb49aa805 ("soundwire: qcom: add support for SoundWire controller")
Closes: https://sashiko.dev/#/bug/linux-f65cddc9-08ff-4531-9acf-76981d74d914
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/qcom.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 246bc063b850..555045b32a25 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -778,7 +778,9 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 	u32 i;
 	int devnum;
 	int ret = IRQ_HANDLED;
-	clk_prepare_enable(ctrl->hclk);
+
+	if (clk_prepare_enable(ctrl->hclk))
+		return IRQ_NONE;
 
 	ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_STATUS],
 		       &intr_sts);
@@ -1680,7 +1682,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
-	clk_prepare_enable(ctrl->hclk);
+	ret = clk_prepare_enable(ctrl->hclk);
+	if (ret)
+		goto err_init;
 
 	ctrl->dev = dev;
 	dev_set_drvdata(&pdev->dev, ctrl);
@@ -1736,7 +1740,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 						"swr_wake_irq", ctrl);
 		if (ret) {
 			dev_err(dev, "Failed to request soundwire wake irq\n");
-			goto err_init;
+			goto err_clk;
 		}
 	}
 
@@ -1805,13 +1809,15 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
+	ret = clk_prepare_enable(ctrl->hclk);
+	if (ret)
+		return ret;
+
 	if (ctrl->wake_irq > 0) {
 		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
 			disable_irq_nosync(ctrl->wake_irq);
 	}
 
-	clk_prepare_enable(ctrl->hclk);
-
 	if (ctrl->clock_stop_not_supported) {
 		reinit_completion(&ctrl->enumeration);
 		ctrl->reg_write(ctrl, SWRM_COMP_SW_RESET, 0x01);
-- 
2.56.0.317.g454f8302e1-goog

