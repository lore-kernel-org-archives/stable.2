Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B93DFC8D;
	Mon,  6 Jul 2026 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321000; cv=none; b=RnSIiDSqh9MJErvw9uYxrIN6TWkERzOIwGmlf4Qv4D6DjtduZVmE4fQmxOV+Rb6zBffVoMA8YtFWz2aYzIhyae+6nImTP5rdcawT714arokFno8EqqQi9wvdzyJDpqn7FeBfdLclDaeVBT3Dqorv09dQMfvEFRGoUc4DFv52eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321000; c=relaxed/simple;
	bh=NuH8cpCJLVF+IxX9TRFldDm8Gwg05+IpaMhRPmcfNiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBpT7KNyaEn2ZrAFoiabuKLd9Zz0gph54z8Vp0Iwgn3rdIJPDXebLw8yYar21cA5oyyttlZfR+OoVi0YZoGMf3Cgla7Rzi5Ch1rfm9ux30wxoNW2nV1EV6agHEY1dy/+xnwqqYxRXpPsXkZrhj2xeNBNJ84aacDvrsEhxj27MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltJQNxvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltJQNxvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E671F00A3D;
	Mon,  6 Jul 2026 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320987;
	bh=2hQHBwjnlwqn6dPE3I0HghH4cOLWxdH4aGvpuK1BKR8=;
	h=From:To:Cc:Subject:Date;
	b=ltJQNxvtZQBcF3ikQATIetZQg6U+kzmKWAhm2jQXrLiArEMvh9MU6FDW770gd4aSL
	 1bR4GYUi7viobCEyvuK2bq4A+66F6rOUUCA3FLmDoggz8rUrIDql1t5nrwaWgyXEA9
	 mr7JM1v1wuGvVTEcuE3BrnNkFqnIwll/qJKdsbxXLbXPcvXv1QFasZDl2CvZfWESt+
	 4zzjGY83KUFRzBHahMmPcucXwjqKSen+Qt9ukjVxcQ4FDtQLRhkgv/Kd51sd9dowyu
	 7MpIeLF/8G31QkMHzoriRi5z7YBKfzaLK/VaKFKJfTNst9zyrs0a4UQdb+I29XQ905
	 Po0C/kRgStXOA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wgdFg-00000001dJ7-37Da;
	Mon, 06 Jul 2026 08:56:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-remoteproc@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH] remoteproc: scp: fix device reference leak on failed lookup
Date: Mon,  6 Jul 2026 08:56:14 +0200
Message-ID: <20260706065614.389412-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the SCP device when attempting
to look up its driver data before the driver has been bound.

Note that holding a reference to a device does not prevent its driver
data from going away.

Fixes: 63c13d61eafe ("remoteproc/mediatek: add SCP support for mt8183")
Cc: stable@vger.kernel.org	# 5.6
Cc: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/remoteproc/mtk_scp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 85a74c9ec521..436656bdfa8b 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -36,6 +36,7 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *scp_node;
 	struct platform_device *scp_pdev;
+	struct mtk_scp *scp;
 
 	scp_node = of_parse_phandle(dev->of_node, "mediatek,scp", 0);
 	if (!scp_node) {
@@ -51,7 +52,13 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
 		return NULL;
 	}
 
-	return platform_get_drvdata(scp_pdev);
+	scp = platform_get_drvdata(scp_pdev);
+	if (!scp) {
+		put_device(&scp_pdev->dev);
+		return NULL;
+	}
+
+	return scp;
 }
 EXPORT_SYMBOL_GPL(scp_get);
 
-- 
2.54.0

