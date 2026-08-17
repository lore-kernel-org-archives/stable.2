Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46113790B;
	Mon, 17 Aug 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976383; cv=none; b=KqZeQNRZ7BDcf3X9hevNaXFcf7LP8yQGjx8rVR8u4cIgRuQBCGN1a91NOTVjGWXfrr0bptMWPcle50FAWYK+CFAOc3NyJii4nULjdSMab4RJx77HMXao7fX6fAp6ndv2bnyD11FJ9Qav37lvvKGajeFCbC2/OhGFc6w5s4ebh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976383; c=relaxed/simple;
	bh=wFjMkwNzD0MkcwjMsosJyUd/Nv0TSFeDQvV2pfyy/2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvibYQSLOQaJFLE40zT80NKz/mzCilnyWRGrJD2e+eZyfPpp+w706KQor8F2fO7b1oV81d9i6Qec8uahBo6AKTvUh+QRH0a2KfaxPDhRWmT1nYfrYiT4T5W082tAkJ5FCXjnDPyR0IFWX+57RkDHmY4KnKXhzQ/nL3Ckw2wGtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=JFxNiL8a; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="JFxNiL8a"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a46bcac2;
	Mon, 17 Aug 2026 22:19:26 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] PCI: lock upstream bridge in pci_try_reset_function()
Date: Mon, 17 Aug 2026 22:19:18 +0800
Message-Id: <20260817141918.1339057-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01017702103a1kunm977dbc31e5a12
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh9IVhgfTksfGEhMSRoaQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JFxNiL8aObPsS/hvbodcMpc+WfLLuxDLtTvSBv7JY6c50gIfPeOf/MU4jFJJClZH/NKHxZ9kRhOvh1vR+MCQ7ZDFlwDq4G4v5IXfCSw4P6/xJJaitrVYAHidlONDRvTySFb//wAfogvxSxPZoLi0W0AFaV/8x7y5/L2UjzdZaG0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=KsWNXm34QWy2edEe3VEVsLIefGNOea2JY0sch1o1NMo=;
	h=date:mime-version:subject:message-id:from;

pci_try_reset_function() may fall back to a secondary-bus reset below
an upstream bridge. Unlike pci_reset_function(), it only trylocks the
target device, so bridge configuration access is left unlocked across
that reset path.

Mirror pci_reset_function() and trylock the upstream bridge before the
device. This keeps bridge config access serialized on the secondary-bus
reset fallback and avoids the unlocked secondary bus reset warning.

Fixes: 61cf16d8bd38 ("PCI: Add pci_try_reset_function(), pci_try_reset_slot(), pci_try_reset_bus()")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/pci/pci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e128696d5b76..6da8ac8a2459 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5342,20 +5342,33 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
  */
 int pci_try_reset_function(struct pci_dev *dev)
 {
+	struct pci_dev *bridge;
 	int rc;
 
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
-	if (!pci_dev_trylock(dev))
+	bridge = pci_upstream_bridge(dev);
+	if (bridge && !pci_dev_trylock(bridge))
 		return -EAGAIN;
 
+	if (!pci_dev_trylock(dev))
+		goto out_unlock_bridge;
+
 	pci_dev_save_and_disable(dev);
 	rc = __pci_reset_function_locked(dev);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
+	if (bridge)
+		pci_dev_unlock(bridge);
+
 	return rc;
+
+out_unlock_bridge:
+	if (bridge)
+		pci_dev_unlock(bridge);
+	return -EAGAIN;
 }
 EXPORT_SYMBOL_GPL(pci_try_reset_function);
 
-- 
2.34.1
