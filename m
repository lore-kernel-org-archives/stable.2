Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135417;
	b=Bi4CWLAhDfkIT0IuVhQj4Rdrt8PjumfGe6Zauplz/BU+2emahbIBiRMU6MGO5WBVAi5R
	 BiNR3QPg5k7X1bj9ssrlwrb7OleL0AN4sJuuBNTgJkUmOU/Aj0uUh8xIPYJF8dxrhD5s4
	 ogKbEw/IHunJB+W2daHCAwBWpUDjuI5nsfoQ7K+G2YmkWALWHU7Bw/nW4UoDfBDFebzhj
	 oo5NUTPbGSwviN+Jl5ayiwIlElb6cSh7NnPL0WFCRb+wl/xCFOu1j5/PvQjHJXTi9U8qF
	 Ro60XRD6i677ZcOpwx79LH33ujYqFBfA4TE8UG0dLODcHIcuwsqtuXn2x4Fw0zy6WUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135417;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=I+5UhrKHWPFimXJb6iMkG7rTcVnU0t1KgM7myG4qjl4=;
	b=RI//6+12k+EADJliGWn7pPAHL0D9N2J3bqJT+C/lsqTxuGgdz81P2HU7RJiVLXV74Jtf
	 vx3VT35UE/DgkjccqfnIcXWgcc081NqieoNk+5C7wXrNCp31DEg1sPIzFnskzebeWY+dr
	 dLbrF3Yr13NksUq6a5k146SAvxK26IeKToy2p0dmD+lnuTFXd8xz1FB7PpEogNXX0XQtb
	 pg2VoghRsLCFMLO5gSigLTBhXadqdn2f+eYX7IXDP9Wk/2O6zyABwRtQxPFC0jfmBhn0p
	 +40y2abNPEh09ON0yzZ1zoTOEaaGq6YX0Q7cqMNveOQKytXrqONAekIEHXO3lQydtug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=JI2SHRd+;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6B606A335;
	Sun,  8 Nov 2026 10:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF6B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=JI2SHRd+
Received: from LAPTOP-99KJFSET (unknown [223.75.64.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53e3dfddd;
	Sun, 8 Nov 2026 18:56:48 +0800 (GMT+08:00)
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
Subject: [PATCH 3/3] PCI: thunder-pem, hisi, thunder-ecam: Fix ECAM config window use-after-free
Date: Sun,  8 Nov 2026 18:56:39 +0800
Message-ID: <20261108105640.875-4-getshell@seu.edu.cn>
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
X-HM-Tid: 0aa1bacdc09e03a1kunm546e4281ce6a2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTh5CVk1IT0pPGE5KTk5KTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTE5VTU9VQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=JI2SHRd+d4qXYwm/HlVVAO5CXJVIq7ZExY8nssZU4EsKtWnijZyxuQeT3JMyDaaawUk5HhslsUmnuI1fvbGCuFfURSB68wFgSs8PE152dW45g5Ocy1+xLM5ut+eMZHZkf+nCGTUjiYDkHZjEHcrbz+9eDuV4J/m07ExRzJYtfu4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=I+5UhrKHWPFimXJb6iMkG7rTcVnU0t1KgM7myG4qjl4=;
	h=date:mime-version:subject:message-id:from;

thunder-pem, hisi and thunder-ecam set .probe = pci_host_common_probe but
have no ->remove, so unbinding only runs devres_release_all():
gen_pci_unmap_cfg() -> pci_ecam_free() frees the ECAM config window while
the bus tree stays registered - only pci_remove_bus() unlinks a bus, and
only pci_host_common_remove() reaches it for a root bus.  The next config
access in pci_ecam_map_bus() reads cfg->ops->bus_shift.
Trigger: DT overlay removal of the node that supplied or enabled it.

Fix: give each driver the same .remove = pci_host_common_remove that
pci-host-generic.c got in commit 01fcb7f777a9 ("PCI: Add support for
unbinding the generic PCI host controller"), so the unlink comes first.

Fixes: f12b76e56ada ("PCI: thunder: Add PCIe host driver for ThunderX processors")
Fixes: a2ec1996098c ("PCI: hisi: Add DT almost-ECAM support for Hip06/Hip07 host controllers")
Fixes: 7b6e7ba8e81a ("PCI: thunder: Add driver for ThunderX-pass{1,2} on-chip devices")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/pci/controller/dwc/pcie-hisi.c    | 1 +
 drivers/pci/controller/pci-thunder-ecam.c | 1 +
 drivers/pci/controller/pci-thunder-pem.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 3c17897e56fc..5ed58e5db797 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -169,6 +169,7 @@ static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
 
 static struct platform_driver hisi_pcie_almost_ecam_driver = {
 	.probe  = pci_host_common_probe,
+	.remove = pci_host_common_remove,
 	.driver = {
 		   .name = "hisi-pcie-almost-ecam",
 		   .of_match_table = hisi_pcie_almost_ecam_of_match,
diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index b5b4a958e6a2..4745f5d00b5a 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -358,6 +358,7 @@ static struct platform_driver thunder_ecam_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = pci_host_common_probe,
+	.remove = pci_host_common_remove,
 };
 builtin_platform_driver(thunder_ecam_driver);
 
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 5fa037fb61dc..80cabbf263be 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -474,6 +474,7 @@ static struct platform_driver thunder_pem_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = pci_host_common_probe,
+	.remove = pci_host_common_remove,
 };
 builtin_platform_driver(thunder_pem_driver);
 
-- 
2.50.1.windows.1

