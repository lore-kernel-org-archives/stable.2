Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4743364926;
	Mon, 22 Jun 2026 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119848; cv=none; b=cMwMd7lb8+Ek0w6wJVtdHjjzsFHDzvQLss95i6EA4X40lP/M/ZujLBDugx7NMrVIL3R3Fsa75CJDYTpVHrRzYIjfUMgr6tNagSwzInxDMGD189zIDRIbp2suvqkpJOTJFzwe2pl7Ixg5PpZm410DCZM8L4Ax2HCktEYXt2NC9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119848; c=relaxed/simple;
	bh=rgPgS+rozau0j3ArPejTT1t3tjsTz/IhrdmcUKLNNE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZB2IHFhYefi40U6lxExVwzUoPq2QFK9ISAwK+PdhW1LmrUCniRweER/WG4G0daxj82VJ+Cz8inr5Ymr72D3ccB6LS99vvEQb9kYZfE5HJwq6Qfk55Fx27MrGA2DPIEnoq8snh2DuLTWhHoXSqJ+MGjzsz0eSmbWROYc2NjnqOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZghvcoDL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZghvcoDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3k
	K32/vHWiIp0p2hsLBCLlspGf3JIL+RZ3PSx08mCdo=; b=ZghvcoDLz62mC2pGCi
	0fRvzNA7x7vlOXUwPvBkb2iGpJD174xmvGveeV2kdEa2X6+8NyEP8K2rUNwh8tvt
	Gnk/jxGNEX70w30vEi6KJ1ZQGMM4mL85qELfeRbFXEThffB48EL+hjK+p9zoCXqa
	8FVctT3eiKmww3P0Eq9Yo0IeQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC337Jl_Thq92UUDg--.60250S2;
	Mon, 22 Jun 2026 17:16:23 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	subhransu.s.prusty@intel.com,
	vkoul@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] AsoC: intel: sst: fix PCI device reference leak on probe failure
Date: Mon, 22 Jun 2026 17:16:20 +0800
Message-Id: <20260622091620.897478-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgC337Jl_Thq92UUDg--.60250S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkJr48ury7tF45GF1kuFg_yoW8Jw1rpa
	n7Wa9Fgr9YgFWFkayDtayxXFn5GFWYvr45Gr47Jw13uw10qrWrG3srJrWUWFW7CrW8GFyF
	qw4DtrWIvr1rKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyE_tUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QdBr2o4-WcZmgAA3P

intel_sst_probe() takes a reference to the PCI device with pci_dev_get().
If sst_platform_get_resources() fails afterwards, the probe error path
cleans up the driver context but does not drop the PCI device reference.

Add a pci_dev_put() error path for failures after pci_dev_get().

Fixes: f533a035e4da ("ASoC: Intel: mrfld - create separate module for pci part")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 sound/soc/intel/atom/sst/sst_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
index 22ae2d22f121..44bb11c69490 100644
--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ b/sound/soc/intel/atom/sst/sst_pci.c
@@ -130,13 +130,15 @@ static int intel_sst_probe(struct pci_dev *pci,
 	sst_drv_ctx->pci = pci_dev_get(pci);
 	ret = sst_platform_get_resources(sst_drv_ctx);
 	if (ret < 0)
-		goto do_free_drv_ctx;
+		goto do_put_pci;
 
 	pci_set_drvdata(pci, sst_drv_ctx);
 	sst_configure_runtime_pm(sst_drv_ctx);
 
 	return ret;
 
+do_put_pci:
+	pci_dev_put(sst_drv_ctx->pci);
 do_free_drv_ctx:
 	sst_context_cleanup(sst_drv_ctx);
 	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
-- 
2.25.1

