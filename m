Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049343;
	b=RJMS4T02PYTJX9wA5FXMzwIhNTp+uzGK4PezcpgdWPCtmmUbvEVQtj4zLL1nGUaib68n
	 9S3l/ZSTzyTtidWPcahds4r6avWGulh3/rBoKcfUpgO1lbTB97DMNSW2dNiHDMNyWjVIV
	 2bVVx0haf6Lueg9PvUU9J1pn8P/5zSdXYQcZonmNWXMbUZN+RmmTXRb0HizLEFY+BPBto
	 4DxeyHSx8N2cnyhEWRqAE59ztr05zMyRDuLOF8nrmittr1JW4bY/8WyVGy8vH7N7SvPwg
	 TFKny0qX+vDFZC4tE+cnNPQjLrCHVH9YRmKX+jJhGygunOR1XWA74KjmxImC74NCKQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ep6qJisYKOX/GMVLzPifah0CT6L24bXDjvGDEmvUBJQ=;
	b=g68whjdPV1ITJ6Rqq7GQMtbr2N7JzeVoJVBc3aU48RV4L2YMMRNJSpnaNdpcIxceERx0
	 UrP6ba7ZOz2ufYTf87sYt0JLen/FjcXFALV2semA4PSmiWkBXYf2VFo321OkZymZ06l7V
	 nkxiPewc4+WcFGuP8PNImiaHIubproqXbyBqIChZmG2phz8HKXT0mHVG5ylX6X8cad5Ps
	 NLB8EgUfEY1QHPF+Ol8UlSlUuFm7vjPuSXrWwv6FfHRNT2bwCpEeNUQs1W4fFruwOaHk/
	 J5jaDFlRWR2kNRwYuWAJlzrIAyn010u8hsrIlj/MEWbvkVrAAE6bZkKBIStrKs9eRgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8De3DLc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8De3DLc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5011F0089F;
	Sat,  7 Nov 2026 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049342;
	bh=ep6qJisYKOX/GMVLzPifah0CT6L24bXDjvGDEmvUBJQ=;
	h=From:To:Cc:Subject:Date;
	b=G8De3DLc8vS0RlL5XoEsWF3NdHEXgGdsLFCVQOpjCxdoKntepbN4+gTT0zUXJJKIM
	 FL0xUSIsL2nz8AxEcqqwJBwS9FFokSwrTl7mnhZwXWFBUc9A6CVcJv5W00bUrKujaK
	 SKUkwtOL3gMYZXaMc034cXl3ZbXzOtH5Xnt44LvHyhOn9CoW0dGzKTPcjYExoJlZeD
	 MCm1KoJ5Ta43u0Znzv7eS2GCUgjK5ZYlNYiS1xXyc2SX0V8Zus+TaFYq5mOirc1OwF
	 Rv5T6FpyoEVmbAayEBG+JYnqObweiij198I/HLDFRxWwgHkLWnPZ8vbheF4ffy4OXJ
	 S9x9PaR9u752Q==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: stm: stm32_i2s: request IRQ after regmap initialization" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:21 -0500
Message-ID: <20261107060220-failed-5.15-1b207c85551f@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1b207c85551fd74854d632116849295b2305245f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060220-failed-5.15-1b207c85551f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




