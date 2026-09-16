Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCB4D794D;
	Wed, 16 Sep 2026 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574592; cv=none; b=YiVCc/rVPsXw2w+n2U3+T48LyDtOsuqgHFjq1lvE/wHsWf92FR474YBrJAdW63LwwR1bf6NCitQ00mG96juGtTF8XUXI95JjCELYSCue39oIHr/Zo7uAHyNIsy8Yu/Rkz9wYJtFwpUVG+FGZoJAqCAxWjy4mrv+MJouho8HvWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574592; c=relaxed/simple;
	bh=dXpdXVW8Lki0hnapvMsd8gJZOmqQGC9rrJXCsoUKBJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+QOjwLNyGR/ATzcy3ZskF+XChWhlPNKgd/ZGEUdPgb0MLfVlUwVPviH4Xey7cKJQ4x4OIFX+TGWpH37u7TE1Ld3gyg6gomBH/mtj0qZ/Mni36EWCp8cXyShaibUpeJPe3TPzhwz7z5CbF7iooNGsnxRhkC8nQxUS4nu+erbhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAz63vapqO1BtCA--.21364S2;
	Thu, 17 Sep 2026 00:03:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maxime.coquelin@st.com,
	patrice.chotard@foss.st.com,
	wsa@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: st: Fix clock reference leak in st_i2c_probe()
Date: Wed, 16 Sep 2026 16:02:35 +0000
Message-Id: <20260916160235.2080462-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAz63vapqO1BtCA--.21364S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWkJr43ZF4kAFWkKF48WFg_yoW8ZF4DpF
	4UWa90kFWUKFs0gr47Jw4jva4Y9ayIg3y5KFWSkwn7uas8X34DXFyfJFya9FWrArWkGanr
	Ja1DtayxAF18ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtxhJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYMA2qqok9GyQAAst

The clock obtained with of_clk_get_by_name() is never released: the
probe error paths after it, irq request failure, deglitch setup
failure and adapter registration failure, return without clk_put(),
and st_i2c_remove() does not drop the reference either.

Add a cleanup label that drops the clock reference on the probe error
paths and release the reference in the remove path.

Fixes: 85b4fab26960 ("i2c: i2c-st: Add ST I2C controller")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/busses/i2c-st.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 751ea421caaf..2049bbce3656 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -831,7 +831,7 @@ static int st_i2c_probe(struct platform_device *pdev)
 			IRQF_ONESHOT, pdev->name, i2c_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
-		return ret;
+		goto err_clk;
 	}
 
 	pinctrl_pm_select_default_state(i2c_dev->dev);
@@ -840,7 +840,7 @@ static int st_i2c_probe(struct platform_device *pdev)
 
 	ret = st_i2c_of_get_deglitch(np, i2c_dev);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	adap = &i2c_dev->adap;
 	i2c_set_adapdata(adap, i2c_dev);
@@ -857,13 +857,17 @@ static int st_i2c_probe(struct platform_device *pdev)
 
 	ret = i2c_add_adapter(adap);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	platform_set_drvdata(pdev, i2c_dev);
 
 	dev_info(i2c_dev->dev, "%s initialized\n", adap->name);
 
 	return 0;
+
+err_clk:
+	clk_put(i2c_dev->clk);
+	return ret;
 }
 
 static void st_i2c_remove(struct platform_device *pdev)
@@ -871,6 +875,7 @@ static void st_i2c_remove(struct platform_device *pdev)
 	struct st_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&i2c_dev->adap);
+	clk_put(i2c_dev->clk);
 }
 
 static const struct of_device_id st_i2c_match[] = {
-- 
2.34.1

