Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC022126C;
	Sun,  9 Aug 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786273059; cv=none; b=mlOkHQ5wX4XJGp9ryQH0htndWLYN6ibOh4GWgYpUJ65yvVrKBY7R8qwXSmJopwLEQ05D8RlUDxRoumNeP7RTY8Qyooi7jbR/VpbsUtrzWotwLtYF4QkWhkrTa1F0wAfn4iW/UVeSVGDtFLeoJ13/uhbvzckpwLrVT7hl2Htym2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786273059; c=relaxed/simple;
	bh=/9xBOt8EOHMbNcrxavEm2r5G6A0STxDC+VqBklXY7rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKZUf1G3XEX/n/1+MMnE4wErfvs8RmkAMOqNCcOjz8JyH8Pcprx2OGbvFB6BwqWg1UyhWQUJhb5BYO+SkKh4j49GQmlYknwBEF6Y57iCCKlfArF5qn6DDS+GXdT6XQeNsL3XiuhVuonL+vcm6iZul8rCXWps49/ScEgKTGaOyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Fu22Qujl; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Fu22Qujl"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 494d2dbe3;
	Sun, 9 Aug 2026 18:57:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sashal@kernel.org,
	zilin@seu.edu.cn,
	kory.maincent@bootlin.com,
	marco.crivellari@suse.com,
	felix.manlunas@cavium.com,
	ricardo.farrington@cavium.com,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net] net: liquidio: lock upstream bridge for function reset
Date: Sun,  9 Aug 2026 18:57:15 +0800
Message-Id: <20260809105715.3669436-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fe62ba7d703a1kunm818c1f907f10d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0pLVk5KH0IZTEJJSk4ZSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Fu22QujluUyvHYndkAHIVRI0uNY3W7aKmbt6BdKI47vrQfy2C6pJd03wVhCLVdMHKM3mEhjdf97B/RRnWgo+7FpUlVUUbIOrlnknkOpTKcnRtZndgeHyVF0rbXFSdftMKKc3eq9eV+4bk4LMTuhyh9RGzrbp5QUaGd+BA2zKZiY=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=LkdFYFpIYSRp1ZW0Pc6B3HlS75N/epxvJwnJfk1OM6U=;
	h=date:mime-version:subject:message-id:from;

octeon_pci_flr() calls __pci_reset_function_locked() from probe-failure and
remove paths that already hold the endpoint device lock. Its explicit
config-space lock covers only the endpoint. If the reset uses the bus-reset
method, the PCI core writes the upstream bridge's Bridge Control register.
Without the bridge lock, that access can race with other
configuration access and emit the "unlocked secondary bus reset" warning.

Take the upstream bridge configuration access lock before the endpoint
lock, and hold both locks through pci_restore_state(). This serializes the
complete reset and state-restore sequence with PCI configuration access.

The PatchProof static-analysis tool identified this issue; manual source
inspection confirmed it in v7.1.5 and current mainline.

A source-level check found that the original reset path takes the endpoint
configuration lock without first taking the upstream bridge lock. The
patched source was checked for bridge-first acquisition, restoration while
both locks are held, and reverse-order release. A user-space POSIX-thread
model held the bridge lock in a concurrent configuration accessor. The
original reset proceeded anyway; the fixed reset waited until the accessor
released it. No live Liquidio hardware or PCI lockdep test was run.

Fixes: 70535350e26f ("liquidio: with embedded f/w, don't reload f/w, issue pf flr at exit")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 32dd9b25760e..1d566aec2d75 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -914,12 +914,15 @@ static bool fw_type_is_auto(void)
  */
 static void octeon_pci_flr(struct octeon_device *oct)
 {
+	struct pci_dev *bridge = pci_upstream_bridge(oct->pci_dev);
 	int rc;
 
-	pci_save_state(oct->pci_dev);
-
+	if (bridge)
+		pci_cfg_access_lock(bridge);
 	pci_cfg_access_lock(oct->pci_dev);
 
+	pci_save_state(oct->pci_dev);
+
 	/* Quiesce the device completely */
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
@@ -931,6 +934,7 @@ static void octeon_pci_flr(struct octeon_device *oct)
 			rc, oct->pf_num);
 
+	pci_restore_state(oct->pci_dev);
 	pci_cfg_access_unlock(oct->pci_dev);
+	if (bridge)
+		pci_cfg_access_unlock(bridge);
-
-	pci_restore_state(oct->pci_dev);
 }
-- 
2.34.1
