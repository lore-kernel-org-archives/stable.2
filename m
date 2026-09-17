Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AA4F3ECF;
	Thu, 17 Sep 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664079; cv=none; b=mOqoxq1Ul3hQOdV1bj4cBy09vm9ePriO1DkQ5U/ORHL7IZAJjs4TNJJqmYwe70ypjUhJS6BOMMzutaUE+80vvWqOfSt1soO7zFEaZv/+3X4ASMIQtfehu3I4V/2KIidWmP9EuS3kj3qjXI6uCUgri4u0CV2LJngCc7DUx0lbvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664079; c=relaxed/simple;
	bh=GahaTV1cYprA4Z37rqEEhD9QL7BlwJnxXyldrN+h4p0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pQNaX9TdYg0Xi07epEyb9uBuf7aRo1zgnTWebfoEUw4Q4W/frf9JOByIpzwfh3eBRdcLZuy9zg7ODrdP5ZgRLUzE3DgYecgPslVq43E60wRjbziKt4TEKaC9ASY1tNCFAktNbihO+Z+98xlDER/8HPGtqp/BGsfvNfAVNVSLqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADXB0JGG6xqMOCECA--.875S2;
	Fri, 18 Sep 2026 00:54:30 +0800 (CST)
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
Subject: [PATCH] ASoC: fsl-asoc-card: Fix ASRC device leak in fsl_asoc_card_probe()
Date: Thu, 17 Sep 2026 16:54:30 +0000
Message-Id: <20260917165430.2163372-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXB0JGG6xqMOCECA--.875S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurW7ZF1UCFy8Gw1rJF4fKrg_yoWkGFX_t3
	Wku3s3ZFy8Jrn2kry5Wrs8urn7urnFgay8G3yDKF18W34YqrW3Xay5tr98uFWqv3y0vwn3
	J3WDZrWrXry3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr
	1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwINA2qr9thV5wAAsW

of_find_device_by_node() returns the ASRC platform device with a
reference taken, but asrc_pdev is only used during probe to set up the
DPCM DAI links and is never released. The shared exit path already drops
the CPU device reference, so release the ASRC one there too, covering
both the error paths and the successful registration path.

Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 70a6159430ed..3fdc77d5968b 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -1069,6 +1069,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	of_node_put(asrc_np);
 	of_node_put(codec_np[0]);
 	of_node_put(codec_np[1]);
+	if (asrc_pdev)
+		put_device(&asrc_pdev->dev);
 	put_device(&cpu_pdev->dev);
 fail:
 	of_node_put(cpu_np);
-- 
2.34.1

