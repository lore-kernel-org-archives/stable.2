Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683E37B3F2;
	Wed,  3 Jun 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482623; cv=none; b=EOq7+agrQVsNLNtVLZEOwrLaUe5FTR+Ug/6tApN08mGKE86kmcmYuBLWAyZv9F96ujcrGWhrFttzcOfoRsBolDuAeJ75FBYvlG2uDb8+sWcb/yeaULSYHDssNkL8+kXJHTaAnYzej/w5PoJ3QHU65ZBeG//1/8xqwJjgGLT+J0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482623; c=relaxed/simple;
	bh=xMlusd9uRyxcXfY45ObphDezxkL8OZjPHme6LpHvDzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3WCP7ugVmjOyD8NLd+NDGSuD9t9pQqMX76uGUSpT2Q4JJnoU2AueZ6pbnaPHrFO5cMxp3pXDO+dHxCZ+f8nUvI8tTq8a73svjxl5cIgU7LwDvWJ/5ybbbaTCWAHmsYjsCcU1pOQXlvf51iEe89rDFuTkjGfVbf/WiAeVFaX8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3GdI6AiBq7OGDAA--.3631S2;
	Wed, 03 Jun 2026 18:30:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ata: ahci_brcm: fix refcount leak in brcm_ahci_probe()
Date: Wed,  3 Jun 2026 10:30:08 +0000
Message-Id: <20260603103008.3741481-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3GdI6AiBq7OGDAA--.3631S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZw17CrW5ur1DXFy3tFW7twb_yoW8Jr1rpr
	W3CFZFyr45Wr4rJF4jyr18Z3WS9anxtFy7Kr4qy392v3ySq34UXr4ayFWqgF4Dtry8G3y5
	ZFsrJr1fuF1DtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5ku4UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8HA2of-pAPUgAAsE

When reset_control_deassert() fails in brcm_ahci_probe(), the
function returns without calling reset_control_rearm() on the
previously asserted shared reset control. This leaves the
triggered count incremented, leaking the reset control reference.

All other error paths after the reset_control_reset() call properly
reach the out_reset label which performs the rearm. Rework the
deassert error path to go through out_reset to restore the
triggered count and ensure the reference is released properly.

Cc: stable@vger.kernel.org
Fixes: 1a0600d112e3 ("ata: ahci_brcm: Perform reset after obtaining resources")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/ata/ahci_brcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 38c63d73d210..b58343f027cf 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -492,7 +492,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		return ret;
 	ret = reset_control_deassert(priv->rcdev_ahci);
 	if (ret)
-		return ret;
+		goto out_reset;
 
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
-- 
2.34.1

