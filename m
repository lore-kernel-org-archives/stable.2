Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135412;
	b=Z3V+aGAtFNmJbRf4FyDVqxvoUThpAcVAnsKvXCpqGASvijH+Zndjv/evDemLYZId+klb
	 lbsBDWI96kSxIt0ueeBEQs0l9QfSZ3UnFJXdbWteJsTsdL9iI0jlp/WVBn6FxLXk23QcG
	 5CJclJsuRViwLuGi9XEVTq9v0oUFyuq+lGZW8F28+0uS/atk+AyzOcZ4pbzNJ0V1nskGc
	 CI+W05HOxqbWJgplm0RpS6fkH8WDj4jLKXlx3uHm4PMn0nVfQwh6FmnHdjE0kQS7rxZSI
	 YFNB9BbDByNtrCZ6+MKpk9jCFsRFEo+TpamS0h+WSf9Q+M+UIz6KGGrgjK189XrkySQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135412;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=cdRs1y/AAehQi9CrjP0m/d+HyxgJqc5pCMHkj04zq68=;
	b=WGVL/jUclqwk/nyXvxzwo+I2uERgp81wbXubB4LfQRnu3t5kn87O2vtyZ93F6DWJ4utT
	 k+jcSCesFD6VaLO0MOuk+H076kPF1c0Jibt6ROS2w9Of5+SFxPRWBPCaLCuoIiotrLMSj
	 T+th4g0M04/ttVhNnyyN+ScvTHzuP7L6nkm+v7CGbMS2cNNXr93Ahen5m+7v+gjOetzgT
	 2DkuAfkc4tu8m5K1n1z2Qj2y56kkOT6/L6zFjPWp7uiQpQTyMhspldlVgzAxZfv/HUF2B
	 QRSvWalEaloTb8LS9Z0OTuMY6fP2WKjvkv5IWFmnk9PM28/O0PZrgdL3zJe+h4ClhvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=Fx2EmbYc;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A35606A326;
	Sun,  8 Nov 2026 10:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A35606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=Fx2EmbYc
Received: from LAPTOP-99KJFSET (unknown [223.75.64.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53e3dfddc;
	Sun, 8 Nov 2026 18:56:45 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Robert Richter <rric@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH 2/3] PCI: microchip: Fix ECAM config window use-after-free
Date: Sun,  8 Nov 2026 18:56:38 +0800
Message-ID: <20261108105640.875-3-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261108105640.875-1-getshell@seu.edu.cn>
References: <20261108105640.875-1-getshell@seu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1bacdb3b703a1kunm546e4281ce69c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUlMVklLQk0eHUhIQhpNQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTE5VTU9VQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=Fx2EmbYcTelZqH92CqZdzGbSV16vLlYNdGGMORlC5U++gI3ZH1AUWAHr2Cz3rvlORmhI6JeCg5H/hOXkui3QDezjd5OC8NLDl1dMiXTwb6Zhg8YBy4EHCc6hPH7BO9Ltktkobbd2FU/XbjVPVL9t8dWEPqlMFRlZg2X9nb22qPM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=cdRs1y/AAehQi9CrjP0m/d+HyxgJqc5pCMHkj04zq68=;
	h=date:mime-version:subject:message-id:from;

mc_host_probe() calls pci_host_common_probe() but has no ->remove, so an
unbind only runs devres_release_all(): gen_pci_unmap_cfg() ->
pci_ecam_free() frees the ECAM config window while the bus tree stays
registered - only pci_remove_bus() unlinks a bus, and only
pci_host_common_remove() reaches it for a root bus.  The next config access
is a use-after-free in pci_ecam_map_bus(), which reads cfg->ops->bus_shift.
Trigger: overlay rmdir in configfs, not rmmod (builtin_platform_driver()).

Fix: add .remove = pci_host_common_remove, as pci-host-generic.c does since
commit 01fcb7f777a9 ("PCI: Add support for unbinding the generic PCI host
controller"), so pci_remove_root_bus() unlinks the bus before devres frees
cfg.  Scope: the PLDA IRQ domains it creates are not devres managed and
stay unreleased - a separate, pre-existing issue.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 24bbf93b8051..f7b75013d9fc 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -821,6 +821,7 @@ MODULE_DEVICE_TABLE(of, mc_pcie_of_match);
 
 static struct platform_driver mc_pcie_driver = {
 	.probe = mc_host_probe,
+	.remove = pci_host_common_remove,
 	.driver = {
 		.name = "microchip-pcie",
 		.of_match_table = mc_pcie_of_match,
-- 
2.50.1.windows.1

