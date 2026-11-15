Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743280;
	b=VEuPqbjyzI7IZZqHrhbVbKb84nJV2lGhqoFiaywxyN3wX30vMqwZpo8bgOjEQFphSnDR
	 nHzfj3pp0dBKPZe10CNRzNWZnsAlN1lgHtqhelwdELb1K+lkf46Ii+lkI3OsJvIQvYH/b
	 nY5wzYb5Vroq34hzvk0pfIHHelzMbXOon1XtPqrTqZqUeoc0zEJHZVVrV6BOUNz1HapXi
	 Dm17OTPCqE+ka9bNoaPtdDzIMcutggWExNiVvkWOCUrajt1VI/d6M/oc7DIcdpns3s3yj
	 iszaypvI91YAGsQNXbjFb27sqnGxExeyiyeL4Z8BV/5iWxr9cTApWe5I5JkthBU2WYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743280;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=oi51xaTG/HK0Yfo+7f/VbT3aH6dKHxeareUfdsGr6Fw=;
	b=zEnM+2CMoGF2Nrle+Ymi4MMR71uXVaK0so6gTsXopFbhiQoUmuW19e3CNYoOx278QwV1
	 A1oK9xjredC9GfiAcp1GmM0YRAhK9XEgg8gWDHy+sOHFl/B9cVSo/wqnpoOMnc7nXZjN3
	 QE4N2sQO9K3rvJm26wuqRb82zfQaFutpfJdgIjt7qrVqtYuFH+wgzAGo1aQbFsqDZ87oG
	 kc8fU6vdBbKPDLGXSe/tlgOAYEFpetU82qom/PxgzevHgCozJs0P+u3hhZ+uTbK59SK3P
	 eml010PXXIT7cOObafNIkS1B9Y7f4kh7BzQihdNPT01bCQTcdfP/th7N7UUrljTUi7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=EErrNkKM;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEE606A8A8;
	Sun, 15 Nov 2026 11:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74CEE606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=EErrNkKM
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04dd;
	Sun, 15 Nov 2026 19:47:50 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?b?V2lsY3p56ZG55Y27a2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2] PCI: apple: Prevent module unloading without IRQ teardown
Date: Sun, 15 Nov 2026 19:47:48 +0800
Message-ID: <179474326811.103840.15695658964160156282@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df08fd1c03a1kunmbac61c98bf77e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGRhNVh1DSUsdSxodGk5PSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=EErrNkKM3bnude6pCFUBL9amXrTOPNrhxd6SCA0ewgEek6EvhfUarntmYQveXt7ckT5ElrNg60CEStL9uhOAOKfjMUJXNIMceZTlewS1lCIqfbsbmV7GjWHfHNKd+ONtCzvhdekiFv2bT0za3DOwEqZ9kEEb6YlNa12vK6xCaZM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=oi51xaTG/HK0Yfo+7f/VbT3aH6dKHxeareUfdsGr6Fw=;
	h=date:mime-version:subject:message-id:from;

The driver suppresses userspace bind attributes but still registers
a module exit callback. Unloading it leaves the PCI hierarchy and
unmanaged IRQ domains and handlers referring to released resources
and unloaded driver code. Removing only the root bus does not make
the remaining IRQ state safe.

Register the driver without an exit callback so a normally loaded
module cannot be unloaded. This follows the maintainer's suggested
first step while complete controller removal remains unsupported.
Keep the tristate option, so loading the driver as a module remains
possible. This change addresses module unload, not dynamic removal
of the platform device or existing probe-error cleanup.

Found by the author's in-house static analysis tool.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Cc: stable@vger.kernel.org
Suggested-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/87mrrj8ku6.wl-maz@kernel.org/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index dfd0e34..061742b 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -892,7 +892,7 @@ static struct platform_driver apple_pcie_driver = {
 		.suppress_bind_attrs	= true,
 	},
 };
-module_platform_driver(apple_pcie_driver);
+builtin_platform_driver(apple_pcie_driver);
 
 MODULE_DESCRIPTION("Apple PCIe host bridge driver");
 MODULE_LICENSE("GPL v2");
-- 
2.50.1.windows.1
