Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E84C10E4;
	Thu, 17 Sep 2026 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659452; cv=none; b=Bz3ZAyNOh+GibTypl2tVg2fJrY0Lxx1jtoLU0PQOhqfFh8fBYMLsAmwSd6h4uLMSSPvw0DY8NIv2eQ31c39ilGFbuK5aRTwlSuENkR3v1HqjuVsJy08X++5B76El1SLXcYvvSRcDB1o4QjfRNeHxZeugWW1eGD50B12dKS2Bp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659452; c=relaxed/simple;
	bh=vWycF/OkNIdJPdWa6/e7T0fw4fZdq7rOwCWBikgklag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghgZWiqgndWFfvfshR0WLSOPPLBOsvnJVQ4ybZPI49Wl/sjnlyoeWlmgSkU4YqHRqqZ8wrp6z6ul66K0pDrOqWXFVdb+S1yDj5NJ+0EkFI47ISYftrrfE7jFw+gMfsRv1zF+knFzZBvHv5KDPetpocW4Fz5Zxx6VQLQpTJFUSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHtD4pCaxqLrCDCA--.5904S2;
	Thu, 17 Sep 2026 23:37:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: haibo.chen@nxp.com,
	han.xu@nxp.com,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	yogeshgaur.83@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] spi: nxp-fspi: Fix runtime PM leak in nxp_fspi_probe()
Date: Thu, 17 Sep 2026 15:37:13 +0000
Message-Id: <20260917153713.2160743-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHtD4pCaxqLrCDCA--.5904S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFWfZr17ZryfAFWkJFb_yoWkXFg_C3
	WUuF97WrWUKr4ktFnxKr13Zr92vrZxXF1xWr4qyFWSy3yDAF1Fv3y8Zrn8Ar4xuw48Cr1D
	uF1kta47Zr1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7IU1ID73UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qr9tgrPAAAs0

pm_runtime_get_sync() increments the runtime PM usage counter even when
it fails.  If it returns an error, nxp_fspi_probe() returns without
dropping that reference, so the counter stays unbalanced.

Balance the counter with pm_runtime_put_noidle() before returning, as
nxp_fspi_remove() already does.

Fixes: 97be4b919a60 ("spi: spi-nxp-fspi: enable runtime pm for fspi")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/spi/spi-nxp-fspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1e36ae084dd8..9883e5149dc4 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1351,8 +1351,10 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* enable clock */
 	ret = pm_runtime_get_sync(f->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(f->dev);
 		return dev_err_probe(dev, ret, "Failed to enable clock");
+	}
 
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
-- 
2.34.1

