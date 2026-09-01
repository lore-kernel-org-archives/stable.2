Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB171352022;
	Tue,  1 Sep 2026 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245171; cv=none; b=h4N0nFizNJtAcFm7MFNhhuHlsd293IeztaUMVUXdG7ertPphjJaPdl7NjvxvFTUQZKBpWvJ6dJNuOlLjXsKpUfxO6Oa17obAA3HAwqx1oeE2oGZGGJP9RyUo5Qlr0HHGeJeFJHm58TXehFXpgfAQwLm264RGIlDW8dlkJdLlFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245171; c=relaxed/simple;
	bh=vG8hwiUFswpP/BGb44DmdmgeFuQmtqjRMak6ZRhW77U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=guzs+waTmV9CAumMeMJZFMj63fjZL0pkLEc/HUpJ8Qt2YjCmK5499+J3j57sOS3vpMdXkKv+qpsZsJ7hWb7MWEBRUCnC190g0zgKsVF3kfV4BMYYoMBh69AsRtiW7LSBlpKMaRoT7wZ2UDpgkMAByTv5/xadg3c+/AHkyRJNc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ELQlREv7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ELQlREv7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788245163; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WNwgnohXcpMa7shgXWCJ9xpd8rY4iBnfjmJSgYvbf8s=;
	b=ELQlREv7uOQQ/Ugq1juk0qIWkdVH/y4FLsaTJbzIF64vhX2gg52QXMLNh0CBc5jMldpcyvndrGflK+cZCiRpeqE4p5gHa7lV8eWnd3BDmf82OvQ5FTetWSyr82qcJoeiSU0xsZd2bWJ2oX3LpJdNwsVJ1MxPAD8h0I6UIjJGLGw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XA4lrWo_1788245162;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XA4lrWo_1788245162 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 14:46:03 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Darshit Shah <darnshah@amazon.de>,
	Brian Norris <briannorris@chromium.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
Date: Tue,  1 Sep 2026 14:45:54 +0800
Message-ID: <20260901064554.2178688-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when
OS controls AER") replaced the AER service bit with host->native_aer
when deciding whether to create a DPC service device.  Unlike the AER
service bit, host->native_aer does not reflect the "pcie_ports=native"
command-line override.

Consequently, if firmware retains AER control, "pcie_ports=native" no
longer enables DPC on Root Ports that advertise both AER and DPC, even
though the option is documented to force native DPC handling.

Check pcie_ports_native explicitly so both command-line overrides
continue to work.

Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/pcie/portdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a9cbfc1d2bc7..a05ee7980fb2 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || host->native_aer))
+	    (pcie_ports_native || pcie_ports_dpc_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	/* Enable bandwidth control if more than one speed is supported. */
-- 
2.43.7

