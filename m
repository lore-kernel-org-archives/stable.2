Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A54D6C4C;
	Wed, 16 Sep 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574472; cv=none; b=KLlDfLfX0cSCrc8oZ87xRMmdgtlbxcw7wKcwfarIJ/v0f24QWehmic9tjDLKR2Yf7Y7Lp9F7LBcbMuK5YM3bQWY78trbbxrWiilw2ECwhUDgG5MS7+Pmx1cejkBI1Ez6c3db5MsQjf0ab1frxe20hUcKSM30E5oywBdEkVPkAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574472; c=relaxed/simple;
	bh=R4B5k5AqXUcrxQphzTH4MSde+GLbO/695mTr0w8lCKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIJ3qTryv+f/ZUIguQLDVz91ByyiMRfzBobURM7lPGplg0yvKLzp7uc+d0nU/csA46oTE8n4hgjk1I6aK0RE+bnuitkC4LqD7tTga6dNNmezZkomD1w/90V6ARSdibndyD5+58+Li4dNzuyVRQnAULHTmDi9Xg41ljkzqI6OgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnTzo8vapqTEptCA--.21477S2;
	Thu, 17 Sep 2026 00:01:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andersson@kernel.org
Cc: andi.shyti@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	rfoss@kernel.org,
	vladimir.zapolskiy@linaro.org,
	wsa@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: qcom-cci: Fix of_node reference leak in cci_probe()
Date: Wed, 16 Sep 2026 16:00:33 +0000
Message-Id: <20260916160033.2078986-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnTzo8vapqTEptCA--.21477S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr47ur1ftFy7tr1xGrWUXFb_yoW5Wr1xpa
	17GFWa9rW8XF1IgrZ2yw1DXFyFkrWrKaykCa17G3WI9FZ8JryUJr1fXryS9FZxCF9avw13
	Ja1ktFWxuFyF9FUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbtxhJUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2qqok9FkAAAs5

Every available DT child node gets an extra reference taken with
of_node_get() for the corresponding master adapter's of_node, but this
reference is only released when i2c_add_adapter() fails or on the
success path via cci_remove(). All probe failures before the adapters
are registered, memory mapping, clock setup, interrupt and reset/init
errors, return without releasing the references.

Drop the node reference taken for each configured master on the common
probe error paths and release the remaining references in the
error_i2c path via the shared cleanup label.

Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 32 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index f3ccfbbc4bea..295d5029bd68 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -575,21 +575,26 @@ static int cci_probe(struct platform_device *pdev)
 	/* Memory */
 
 	cci->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(cci->base))
-		return PTR_ERR(cci->base);
+	if (IS_ERR(cci->base)) {
+		ret = PTR_ERR(cci->base);
+		goto err_of_node;
+	}
 
 	/* Clocks */
 
 	ret = devm_clk_bulk_get_all(dev, &cci->clocks);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to get clocks\n");
-	else if (!ret)
-		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
+	if (ret < 0) {
+		ret = dev_err_probe(dev, ret, "failed to get clocks\n");
+		goto err_of_node;
+	} else if (!ret) {
+		ret = dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
+		goto err_of_node;
+	}
 	cci->nclocks = ret;
 
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
-		return ret;
+		goto err_of_node;
 
 	/* Interrupt */
 
@@ -625,10 +630,8 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 
 		ret = i2c_add_adapter(&cci->master[i].adap);
-		if (ret < 0) {
-			of_node_put(cci->master[i].adap.dev.of_node);
+		if (ret < 0)
 			goto error_i2c;
-		}
 	}
 
 	return 0;
@@ -638,15 +641,18 @@ static int cci_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(dev);
 
 	for (--i ; i >= 0; i--) {
-		if (cci->master[i].cci) {
+		if (cci->master[i].cci)
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
-		}
 	}
 error:
 	disable_irq(cci->irq);
 disable_clocks:
 	cci_disable_clocks(cci);
+err_of_node:
+	for (i = 0; i < cci->data->num_masters; i++) {
+		if (cci->master[i].cci)
+			of_node_put(cci->master[i].adap.dev.of_node);
+	}
 
 	return ret;
 }
-- 
2.34.1

