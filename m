Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB13BE631;
	Mon, 21 Sep 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000781; cv=none; b=l9FCD2cGyXHfQuEBd5mKRJN8VS1au1H/xrn+/7kjqbGyE2Jqqdq7fROj53QEGmzb/DUhGt0OuxJSCp6a5ZMZLXO0irf5vof1KUqWMpBnX0HS2uRX2c96K7TmvadoRtos/jOAayZruDMOFoxghF0CZfObmqfJlEIZWY2XiSx4wtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000781; c=relaxed/simple;
	bh=mp3SIzHgzjXTyT2ROhofVtctd6WZrfVD8Gqbw4AhVMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=djHyxsRZTGGcNzC3cKgI+0UXoQnZ3Ndjav/d+bwJUxTXF4NK8bTSYk7F6HYS/qQ8DK3HSaflj3l1padWNjCohgW4E9CXAyqpD3Q/mEl8OaTrkL1Hz6Q+gB5UzQ2EfThhU6glA++oo55RuR4zTx/vTe3WnpZL4sbaY+93mZST6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Rm6o13Rw; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Rm6o13Rw"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e975bb44;
	Mon, 21 Sep 2026 22:26:14 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] PCI: pciehp: Make poll mode parameter read-only
Date: Mon, 21 Sep 2026 22:26:08 +0800
Message-Id: <20260921142608.270312-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c45c3c0703a1kunm1f89033851d4c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxoaVkJLHR8fTkxKGh1CSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Rm6o13RwsZf9tAms+rS6ujTjIIyt2GZXSpiTdPZPA8UBgYBTgLkBGabe1+FXkmcYPTRp7vuMlit5tiUEXgoUwuvqKfPLSiu3ZDfFZf+2myKjrcEmVr7ahMNyYXkWDDqbCKeSngvsQVjP7LKVdCwag/0UdBvZWFujmObVD17kAdU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=wGeHVqHuI581tDU0SIFx8MRzBjVOO5nbwQIbAHzuQq4=;
	h=date:mime-version:subject:message-id:from;

pciehp_request_irq() and pciehp_free_irq() select different resources
based on the global pciehp_poll_mode parameter. The parameter is
currently writable through sysfs, so changing it while a controller is
active can make teardown stop a nonexistent polling thread or call
free_irq() for an IRQ that was not requested.

Keep the parameter available for boot and module configuration, but
prevent runtime changes to the registration mode.

Reproducer:
Boot an x86_64 guest in QEMU with a native PCIe hotplug root port and an
e1000 device, using these device options:

    -device pcie-root-port,id=rp1,chassis=1,slot=1
    -device e1000,bus=rp1

Pass pcie_ports=native pciehp.pciehp_poll_mode=1 to the guest kernel.
As root in the guest, replace the device name below with a bound pciehp
service device and run:

    dev=0000:00:1c.0:pcie004
    driver=/sys/bus/pci_express/drivers/pciehp
    echo 0 > /sys/module/pciehp/parameters/poll_mode
    echo "$dev" > "$driver/unbind"
    dmesg | grep 'Trying to free already-free IRQ'

The unfixed kernel accepts the runtime mode change and reports the warning
when the service device is removed. The fixed kernel rejects the write and
removes the device without the warning. The mode change is a deliberate
privileged test action and is not expected during ordinary operation.

Fixes: 2aeeef119995 ("pciehp: Clean up pcie_init()")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/pci/hotplug/pciehp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 2cafd3b26f344..5ce32dc7e178f 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -38,7 +38,7 @@ int pciehp_poll_time;
  * not really modular, but the easiest way to keep compat with existing
  * bootargs behaviour is to continue using module_param here.
  */
-module_param(pciehp_poll_mode, bool, 0644);
+module_param(pciehp_poll_mode, bool, 0444);
 module_param(pciehp_poll_time, int, 0644);
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
-- 
2.34.1

