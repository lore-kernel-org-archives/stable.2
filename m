Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F804ABBA7;
	Thu, 17 Sep 2026 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659035; cv=none; b=VmRo7fIPxsNGDEKo36Bb8AhIdAubna09LBLtuC8ZFwTguFPDVa05zivlZn0bU78Cwln/xIdiqCnKmmRXTgEJGT6WttHvwenian8HvC3+ZCyHsy94WzhAxlk1yynXlnW0JID5bQ8CHeW46/OAQ+0U6sD1ROxWOGmeMva1xVImYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659035; c=relaxed/simple;
	bh=rjxjxjCm5eP3oG6tiKkX29qzR7KTYswnfa41DXHDFAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DdE49aoAhJr5p2NPxXi/Pse4GnguEgVkXyu5Ffg7e6T8kpuXgTLl7+86scJkyoac364JtPnyn5OqDcO5i6gERqd73lRmbSW4J8DTxmDN0wxehBABSgJGgFCO/k0TyCo/bWCtFxZcwRKYM0neqzU2eXlOK8u8az4Uh6xiVasN0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3qEKEB6xqk5GDCA--.5709S2;
	Thu, 17 Sep 2026 23:30:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank.Li@nxp.com
Cc: festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	peng.fan@nxp.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] soc: imx8m: Fix clock leak in imx8m_soc_prepare()
Date: Thu, 17 Sep 2026 15:30:12 +0000
Message-Id: <20260917153012.2160500-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3qEKEB6xqk5GDCA--.5709S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr45XFy3Zry5JrWxtw1rCrg_yoWDZFg_ua
	1rW3s7WrWUurZ2k34UG3yUAryq9F97Xr4xWrZFvaySkFyUZF1UuFZ0ganxKrWDXw4rJF98
	Cr18ZrW8Cr9rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42
	xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aZX5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qr9LYrTwABs0

When clk_prepare_enable() fails, imx8m_soc_prepare() jumps to err_clk,
which only undoes the iounmap.  The reference obtained by
of_clk_get_by_name() is not dropped, and imx8m_soc_probe() returns the
error without calling imx8m_soc_unprepare(), so the clock reference is
leaked.

Release it before leaving the prepare function.

Fixes: 390c01073f5d ("soc: imx8m: Cleanup with adding imx8m_soc_[un]prepare")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/soc/imx/soc-imx8m.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 77763a107edb..f4c2d5e37ec7 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -149,8 +149,10 @@ static int imx8m_soc_prepare(struct platform_device *pdev, const char *ocotp_com
 	}
 
 	ret = clk_prepare_enable(drvdata->clk);
-	if (ret)
+	if (ret) {
+		clk_put(drvdata->clk);
 		goto err_clk;
+	}
 
 	return 0;
 
-- 
2.34.1

