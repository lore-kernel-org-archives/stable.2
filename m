Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C84E7817;
	Thu, 17 Sep 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664223; cv=none; b=QiU/BVjxuncirox4BmJiOk5UlxhOv95d2QN2bIm51mPHj5hujUnMrCV8Vq4wnXLgNKvXk6XetTDSacryYjo6h23i8oVQGexKO8zrdQjrUeWAP7tFMGX+CUI2t0/1WDWNukpF+qtRjWGm/qoR01EpIvVkt7h/PkOhd+TAP9YLO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664223; c=relaxed/simple;
	bh=3wK1veyRCeHdZhVgBP1g8RgttxbvcXPCiSIoYPPHhog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZksEo1kDrb2/nf0874tFTWA0IoY7LKdtW17wS+O9wpkOhXnZ3NhbBSVt4rdDNeQBUjZNlemPDlIAkPyjJ4gigZfN6K63UKlira4cnzTrLriw0NfLMMnlOk7VbyVFvmgKKetNt3HHTxxOCB3oGHbCnuwXxvZI3YIpblHyQVu+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHdkDWG6xqLeiECA--.946S2;
	Fri, 18 Sep 2026 00:56:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Xiubo.Lee@gmail.com
Cc: broonie@kernel.org,
	festevam@gmail.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	shengjiu.wang@gmail.com,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl-asoc-card: Fix codec device leak in fsl_asoc_card_probe()
Date: Thu, 17 Sep 2026 16:56:54 +0000
Message-Id: <20260917165654.2163461-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHdkDWG6xqLeiECA--.946S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFyfXF1kKryfJw4UZrW3trb_yoW8Jr1Upw
	nIga9xGFy5Gr129a1rXrW8Zay2kryjy393Jw4Fyw4xKr9xX34FvF9aqw1YqFWftrykK34D
	ur9rtrWrXr1rZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQNA2qr9LZcAQABsM

The codec device reference taken by of_find_i2c_device_by_node() is kept
in codec_dev[] and never released, leaking the I2C client on both the
error paths and the successful registration path. The same slot also
holds the reference of_find_device_by_node() takes when the codec is a
platform device, which leaks in the same way.

Drop those references on the shared exit path.

Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 3fdc77d5968b..04adb8e76e29 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -1069,6 +1069,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	of_node_put(asrc_np);
 	of_node_put(codec_np[0]);
 	of_node_put(codec_np[1]);
+	for (codec_idx = 0; codec_idx < 2; codec_idx++)
+		put_device(codec_dev[codec_idx]);
 	if (asrc_pdev)
 		put_device(&asrc_pdev->dev);
 	put_device(&cpu_pdev->dev);
-- 
2.34.1

