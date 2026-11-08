Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135407;
	b=Z2qIbEbANAJ6h5zzZAp5+5y5E1xMgl0wt/SARMpzpJoihktPA9o8l2TMTE7x1UJzAhNG
	 Njmg3rywyBDso//4MvOnNVkVSK2OA0gqHamSjMIibXzHadhl+/OKYM8i86rhJlM05j5Ns
	 7WhZZkY+/ZFWBNK86/5XNNzeBexUysTUBQv7dP1fNPZ/Cu+Q9LpIQPTzSUh5Qzg7+GNBy
	 cO1QfQpN0TL4o9co1urUBE7ymy3C7UMWxtFiY34j4DdSrQYtt81nBj8uvmoqFZ9piE0tT
	 KOvVJXu1AtzjOeRJ0bmuZXYpT97OBGhtc1GxqycMISY3PsbqdC9Ex1GzB334ZRfOPpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135407;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=2EQJ24xhE/gqkBYq4fXAFxjW7usX/BJnOafpsVnIudM=;
	b=GV3g4sSgjUudlUdQi+iF/vhNlyftE2OVVdrMHk+LY5tZlvcVNcjbQo+A6x2rbaVYVBmZ
	 Q94ZZiGCVDnQNY5CkTQsyfFjPebjDOmxFLDzlggC0HI1hvwM5W2+CYoUrve0sKCt8buOU
	 Ct9wN5t6nC/sEdzOOCqPRsnLcwTJlACI5r/nyHvFztRm5dF5lW5yhG0UIl6iGE5+7V/jw
	 D3JDolGj9kZCst21fbB0WXIcPiOSiZOlCa67UdtmL16ree7+HKDgfNX93ecU63G0wbkbQ
	 64GlLa1leig/ya0UyddjlCQIj6EKql9HrPouZ3MZMcdngSVXHJbde186PeDw0uwr8yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=QYWI+OfY;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F5606A321;
	Sun,  8 Nov 2026 10:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=QYWI+OfY
Received: from LAPTOP-99KJFSET (unknown [223.75.64.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53e3dfdd9;
	Sun, 8 Nov 2026 18:56:41 +0800 (GMT+08:00)
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
Subject: [PATCH 0/3] PCI: Fix ECAM config window use-after-free in five drivers
Date: Sun,  8 Nov 2026 18:56:36 +0800
Message-ID: <20261108105640.875-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
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
X-HM-Tid: 0aa1bacda3db03a1kunm546e4281ce696
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUpJVktCHR4dSkkeHkIZHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTE5VTU9VQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=QYWI+OfYUyLjpbyMqMN5fJs14PBc1lVUJKUIdzK6W8iuOtsyYsJCCSgqQjccvS2PiQJlDRRFeyTvgLuVttsNZaLkI0Ok2Ryyo/oGoM6lwMtp2cARTfu6bJMn2vZ4kKvflKzyMhqAGmg9yT/zhPtsq6CWr8gaZpWY/I91WPLak7s=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=2EQJ24xhE/gqkBYq4fXAFxjW7usX/BJnOafpsVnIudM=;
	h=date:mime-version:subject:message-id:from;

Five PCI host controller drivers use pci_host_common_probe() or
pci_host_common_init() but install no ->remove, so unbinding frees the ECAM
config window through devres while the bus tree is still registered, and
the next config space access is a use-after-free.

Patch 1/3 is the apple driver.  CONFIG_PCIE_APPLE=m plus
module_platform_driver() means one root command, "rmmod apple_pcie", is
enough to trigger it.

This series fixes the lifetime of cfg only.  It does not make these drivers
safe to unload: apple's IRQ handlers and microchip's PLDA IRQ domains are
still not released, both pre-existing and out of scope here.

The defect was found by code review; the trigger steps are in each patch,
but no oops or KASAN report is attached, as none was measured.

Patch 3/3 is one commit for the three remaining drivers and therefore
carries three Fixes: tags; it can be split apart if you prefer.

Hongyan Xu (3):
  PCI: apple: Fix ECAM config window use-after-free
  PCI: microchip: Fix ECAM config window use-after-free
  PCI: thunder-pem, hisi, thunder-ecam: Fix ECAM config window
    use-after-free

 drivers/pci/controller/dwc/pcie-hisi.c            | 1 +
 drivers/pci/controller/pci-thunder-ecam.c         | 1 +
 drivers/pci/controller/pci-thunder-pem.c          | 1 +
 drivers/pci/controller/pcie-apple.c               | 1 +
 drivers/pci/controller/plda/pcie-microchip-host.c | 1 +
 5 files changed, 5 insertions(+)

-- 
2.50.1.windows.1

