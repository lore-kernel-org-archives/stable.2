Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F22C21C4;
	Wed, 24 Jun 2026 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283277; cv=none; b=q7oS6VXui604hvtg2kqVBduvQZ5+S6RUMWwBwgI/wZfHBLgV44eCiq0IIcyQsEANdoHC41H8kCNSLKz9hHKb4Sk1yc/xHnHj3S41PZloO+CYi8ueOZR7A5trcSlBmvH1icttLnrHpr4Uts7B5xN3ar6y1z3MTablJB3j3apzsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283277; c=relaxed/simple;
	bh=i2BxvXb72VyyGu+9IadTzfII1x2eMeQngylrWDWjNLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mel9FU/GD786lgGwMW50TDw6fWiwPSUnsYX8pSTlwDAtjM2Au1cm+e85vw6nhpX0TzxWJMuM8cIvNO7wbcm+M4nugYznLvPYZr9TTrWpnHOEFH+f4X/vOMQJuLuFG+xXzPIjiR4llPjHLXB8CLYZeBfqCzFgYoiXP5oxaXaGuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mZsUdyTj; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mZsUdyTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yc
	783U1/w1TTHei2tenQ9uyoFUUdnrX8GZhw6iJxE6Y=; b=mZsUdyTjRlPcAHBH35
	q68cmiHz0VESHKHv3tdSLsA5e1bQzQOtay4fur1oMQmNcKoLLhTpx787fxZ6xeiO
	7WSE+tuDnZiIKkkq++NoZ5w+RfrOaDSeSGzd0P9kPMUaGnjXZMXaYDOL4wBPnD7n
	X9wOYbgvVWdWeARzkYTL4qjAo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3PxfNeztq2aV9EA--.35891S2;
	Wed, 24 Jun 2026 14:40:15 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ricardo.farrington@cavium.com,
	felix.manlunas@cavium.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: liquidio: fix BAR resource leak on PF number failure
Date: Wed, 24 Jun 2026 14:40:13 +0800
Message-Id: <20260624064013.2809570-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3PxfNeztq2aV9EA--.35891S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWrGrW5tw1rWrWDXFyDGFg_yoW8Zr17pr
	y7Ja98Cr97Jr45ta1DtF18Jas8Gws29345Kr93J3WSyr1DZrWvgFy8tF1IgrZrK395AF42
	yFW7Aa1rC3WUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRNTm3UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Q976Wo7e88vjAAA32

If cn23xx_get_pf_num() fails, the function returns without
unmapping either BAR. Unmap both BARs before returning from
the error path.

Found by manual code review.

Fixes: 0c45d7fe12c7 ("liquidio: fix use of pf in pass-through mode in a virtual machine")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Modify the commit message.
 - Introduce goto unwind path to do the cleanup. Thanks, Simon!
---
 .../cavium/liquidio/cn23xx_pf_device.c         | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 75f22f74774c..06b4424e778e 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1163,18 +1163,14 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
 	if (octeon_map_pci_barx(oct, 1, MAX_BAR1_IOREMAP_SIZE)) {
 		dev_err(&oct->pci_dev->dev, "%s CN23XX BAR1 map failed\n",
 			__func__);
-		octeon_unmap_pci_barx(oct, 0);
-		return 1;
+		goto err_unmap_bar0;
 	}
 
 	if (cn23xx_get_pf_num(oct) != 0)
-		return 1;
+		goto err_unmap_bar1;
 
-	if (cn23xx_sriov_config(oct)) {
-		octeon_unmap_pci_barx(oct, 0);
-		octeon_unmap_pci_barx(oct, 1);
-		return 1;
-	}
+	if (cn23xx_sriov_config(oct))
+		goto err_unmap_bar1;
 
 	octeon_write_csr64(oct, CN23XX_SLI_MAC_CREDIT_CNT, 0x3F802080802080ULL);
 
@@ -1205,6 +1201,12 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
 	oct->coproc_clock_rate = 1000000ULL * cn23xx_coprocessor_clock(oct);
 
 	return 0;
+
+err_unmap_bar1:
+	octeon_unmap_pci_barx(oct, 1);
+err_unmap_bar0:
+	octeon_unmap_pci_barx(oct, 0);
+	return 1;
 }
 EXPORT_SYMBOL_GPL(setup_cn23xx_octeon_pf_device);
 
-- 
2.25.1

