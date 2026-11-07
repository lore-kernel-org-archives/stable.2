Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047510;
	b=gdT3zlj7zuWRlDXpHX9UrOcEC5XfDjSyG5MSxYNc/HpjCyHo64dzKcPAvfANoe9mJOum
	 M5oUNtXNekJY018BNJla/G9Olxgu62k8MMyfG/8p+KwlAnm9xcBrUUg3wrtNl2FcXea+I
	 NnE/ggje3e8887PHuRZkTi9u15KXrNbYqr56EA4PrdRNhZilRwir0DOBd7lh4iZTbGOZH
	 wRlCWDJdNqZt1Q+/wEQkRAX9lxQ3S22YDUk1rCp9gXdvplQe/ppslryBtjpLmXY5O4xs2
	 vbBpllxASGTGDWpoxuz06IDAymFRLCz3Ov0Q19kYiIVBQRDNIExzvk7V27/P4x3p3OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047510;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o4rolHw2kLHwXkA4SrvY7alhnIvqoj6dYDQ5S+tE24M=;
	b=C60Qh0t0Xux28CScs8hqxBXybs4o2P6Xw1QKzLsmdM5C8PuuRz7Jene9bR5I6acfmB70
	 obQ88uQID9qlyUknG8C1IUE9qLvsg7XdBxpRzkA4/zkVhNF63gEKxb3nJkgFI4FbrjLuW
	 Pi+5oAvPq/qIx5WspRnjdGteGI3XX+dsrkHKj0r0r37we/9uC0Yg2cvnS/eJuae9pQ8xk
	 7xSOs92um8Po7QAm52wlK7j/uMLEWDDWGRy6P5CeMSTUdyBRPsG7ij9xDpF91BPg7cfL0
	 /iJ2N2/rxKkejLnIudAhEucH5J4aBZyUZ8qzPSKPHZz4PLfN1hKlq++51UxENafAW2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+jZ2703;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F7606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+jZ2703
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311A21F0089F;
	Sat,  7 Nov 2026 10:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047509;
	bh=o4rolHw2kLHwXkA4SrvY7alhnIvqoj6dYDQ5S+tE24M=;
	h=From:To:Cc:Subject:Date;
	b=j+jZ2703llTIFX9BWtQ3SDKJhuUR8MYSJ9GULJ9sSjjTE6xpubc/HJeGqnrj9O/f/
	 4dr4WPFXJjd3BF1opgT8g05VEdQdCliY5SIHH01WJQuEyJkvWbLoFVVfFHBMhmYNtL
	 wtLD+5zfslDmmJfveXi/IfKJIbeLoWks4xR6EHj40rvksznng1Xq6y86MKFj/Gx2ze
	 V7r6aFEa58nZuy1f+LiAAFm3WB4+PeifSY51l0WY+RhZNug6m1gRqs5JAIy5l95LRO
	 Sn8IZgObo6NaIgV+Mfugz2Svoa2P1olF6iWi0PF5DdFt0PMt6WvmuLOi1UJYNiudix
	 SLxUzPpilhyRw==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: stm: stm32_i2s: request IRQ after regmap initialization" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:48 -0500
Message-ID: <20261107053148-failed-6.6-1b207c85551f@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1b207c85551fd74854d632116849295b2305245f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053148-failed-6.6-1b207c85551f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1b207c85551fd74854d632116849295b2305245f Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 4 Oct 2026 00:34:51 -0400
Subject: [PATCH] ASoC: stm: stm32_i2s: request IRQ after regmap initialization

The ISR accesses the managed regmap, but probe requests the IRQ before
creating it. An early interrupt can reach an uninitialized regmap.
Reverse-order cleanup can free the regmap while the IRQ remains active.

Request the IRQ after regmap initialization so probe unwind and
removal free and synchronize it before releasing the regmap.

The teardown ordering issue was found by static analysis.

Fixes: e4e6ec7b127c ("ASoC: stm32: Add I2S driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20261004043451.1138613-1-mhun512@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index a59ad94423726..22196f789ae4a 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1197,7 +1197,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct reset_control *rst;
 	struct resource *res;
-	int irq, ret;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -1243,16 +1243,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 			return ret;
 	}
 
-	/* Get irqs */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
-			       dev_name(&pdev->dev), i2s);
-	if (ret)
-		return ret;
-
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rst))
@@ -1277,7 +1267,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1303,6 +1293,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->regmap),
 				     "Regmap init error\n");
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
+			       dev_name(&pdev->dev), i2s);
+	if (ret)
+		return ret;
+
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
 		return ret;
-- 
2.53.0




