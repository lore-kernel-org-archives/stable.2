Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763125;
	b=epb/eNFSfdP0jcnveqKYIMkjiG9o+fK8W5R9Jl49ZUma9Dhqn5IJhcfKk17sMwSZEyh4
	 Avz+vv4O/hTM6YvXSlaCUpj4VrvdybS8Xu5hsSWNRfHqKv1j2wmYu+F9ZUhSK4CDsfSA1
	 +315guuUDYEbgX03liMkOFvwsvsxG+LW5SQySsgwwKrX/WIv0D6dcLZ0viIusniGG11hi
	 S/c9nPimyOXIci4Wte/lM7iqyV7pf+cUGitclt4BBOIrPK+gknbETD/CvSrt5OW80mOeg
	 BbwaSyJwZsy6AkkBLWsYU3wIrhq4A08vDWdv+WZIDcdnKFrtrJTozI3jq+rYiTjd88A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763125;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=YNzPy9WIGKzk5Mhl2eWjAAhHu9EFIi0yUenQI3Z81r4=;
	b=MszRmN1gnS2Q784GRwVY6vW8pvDgBxwSiwOxbZ1ql4YMSVgpb0UdFTbtmjgz560Hvx5q
	 rAz/0S2+/cmIN/oqExdzWyXGvHqfC1pZ1MlJ7IIxSTmBadsOAsMPuePCWccV93yHGMH91
	 WQapRKabJEk2DdtkPnThE7lhhYG0NLz3OQXb/uOSjnx2zOPx+VUB5BKS/yqMn4oRGXWoJ
	 ibjIlbYT5WXJLE9nYGUwIySXrHJH3o5GcygrDcamyljqUxzp4eoV77zrgdcXvzJUIZkrz
	 K3f2IQz3aKGHpUo3KjlBzNIEoRtUn9Y4Lpp3R1NGaSDHTuXxIKGw3f3my9LX87uAxMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=BU0avgyx;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39E606A88B;
	Sun, 15 Nov 2026 17:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F39E606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=BU0avgyx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794763125; x=1826299125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YNzPy9WIGKzk5Mhl2eWjAAhHu9EFIi0yUenQI3Z81r4=;
  b=BU0avgyxCgBnBDOJtHhybasFpkn+Gh6SvU4TdKDcuUQjfLN7UZez/9Oe
   1LlrLJF11rUC8bY8oO0sg90PVmc9xbKcXrjoP6IVyDuNgRdH7js68Ta7X
   zzVKCAnlLrh52rOqwaAPW2TDcWWnA7t/zVXCV2UOFq/2Y3qMSKIL1ME5/
   xm1wKyxUpyadUkG544zW3nb9cKm6gM1jRQM4NorM7Lx82Es5lwqTva0h4
   mVoL81hp8Cff0p72wFMwu0J77WgFFFgnWvoQqtNJMQejWCoYvwpzME2sh
   tdWm/N8i7vrvpPaAjPEPLySJ94ogDhXHNPZ+uWHLRrH4taRtLbGL0qeAT
   g==;
X-CSE-ConnectionGUID: yX/U3VgzSuSRLsGcL61osg==
X-CSE-MsgGUID: cie6R9sSRvmY8ykNRJV09g==
X-IronPort-AV: E=Sophos;i="6.27,215,1787011200"; 
   d="scan'208";a="33868730"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:18:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1465]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id 5ec6dabf-735a-49b8-b405-60cf754ab77d; Sun, 15 Nov 2026 17:18:42 +0000 (UTC)
X-Farcaster-Flow-ID: 5ec6dabf-735a-49b8-b405-60cf754ab77d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:41 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:40 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zeev Zilberman
	<zeev@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] PCI: Avoid runtime D3 on Amazon PCIe switch ports
Date: Sun, 15 Nov 2026 19:18:30 +0200
Message-ID: <20261115171831.1498006-3-avivb@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261115171831.1498006-1-avivb@amazon.com>
References: <20261115171831.1498006-1-avivb@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The PCIe switch ports on AWS instances (vendor 0x1d0f) advertise PME
from D3hot but do not send it. Since commit d4c79b63d82d ("PCI: Allow
D3 for native hotplug-capable Root Ports on non-x86 platforms") these
ports runtime suspend to D3hot on non-x86 platforms, and hotplug events
such as an ENI attach are lost.

Mark them PCI_DEV_FLAGS_NO_D3.

Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports on non-x86 platforms")
Cc: stable@vger.kernel.org # 7.3.x
Co-developed-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..292047804b09 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1476,6 +1476,18 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
 
+/*
+ * Amazon 1d0f PCIe switch ports (e.g. 1d0f:cec2) on AWS instances
+ * advertise PME# from D3hot but never assert it, so hotplug events on
+ * a port in D3 are lost.
+ */
+static void quirk_amazon_bridge_no_d3(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AMAZON, PCI_ANY_ID,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_amazon_bridge_no_d3);
+
 /*
  * This was originally an Alpha-specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
-- 
2.50.1

