Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648254;
	b=yjB5FaATT90tDMfwX+I09BAaspy9wwB4yGM7Efof2V1UtUq+rV1T25zgRdO9NKCVwQMx
	 AxrwhVey/frvlY/ZcHrfSsf9OR61MHrT0dOhvnLV0tygFBqC1g5eLUt/fijQpbPtOcyE0
	 Zo20eOFsZw9K0d01jpvjnMf7sfGHIzffmz2fYppF2jqCtRJACnXNfdUdG9H1g69lRRxkP
	 HLIRc32EvnasnQnAR/OZI7+aZ/C7TrZHFWm0GMhSAPmutTuGW/5LZl+0LM5fQSmo84xuV
	 KP80JixVCCvH/vfMSPV+oRt1cVTvMlz0RbtBAyeISbc1x+MwPdUTR7xM+GTWbCoUlFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648254;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=IrqtLAswdk1Q0ZFEPPO5PlZCeBXDXoMHw0kHScbL5gk=;
	b=lTn1FQiqgBDn4Z6A2Om5+43P8HYMzaGEe6Vz3uNnvkzcOOyEpS7M8osGJhF949OTyq0Q
	 BarU/p6qlrGRDtoeD5hAMnmmx6SrV2UFfdbHddEJF+zW6LwfN+k4zRyMZjeeqONhR+v9M
	 NINYrn6lMg3zhlHphSvDwlakK5oeBDClhMy/JAvZbSWjR3NMjzq0beSugwrztrIxuVsIe
	 vK2gqVX9aiqszKBJGfLVsrkMFkYH1joieQPWVr8+z8PoNmDXsVUHmnbeUuWMqjbwPoMZv
	 rcfLM/fy5rZnoL21y7es+A3lfpkLPwc5BpzQTHfz+C3nETZKHFycImRpz+e5bIcSdQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pi8Sz+fZ;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50A606A31E;
	Wed, 25 Nov 2026 23:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E50A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pi8Sz+fZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648253; x=1827184253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NizAyldnA+W44R6lgiTKWakIA/nf0+1OagQKNTtoJMQ=;
  b=Pi8Sz+fZ7vc4D52OvKz+poPGGpCLSh8pA8JdVprIo/zHfrAeufCiGLpF
   bDu3rhQaBDDobJ1xsfd3oL6yMKMB6GdFrlo+rH/ihyT+cAr8ED9/64UT3
   fpf/FpKHvxEW4sUXMVG7Hb0YABgUXqeH1Vm5KTB37ylR99RiDMA12He9c
   60KwHG2CGAnneJZYYovnAJ8fRGCFAOTBoGYDISuyeAZ7jRMOP3R0hcoZL
   r7TyF+Qpx0I+ORSXfSAsmFB4fv2BiYVsawFd4wLgmqkoQfR8drvStM74w
   P+8D/lIOfOi5kboQ8dEE5DuIbJdyIRgDq4EHCqxy3VuuZex/g4C6bA+cg
   A==;
X-CSE-ConnectionGUID: X0E0kYRXRpuYE0hewunxLA==
X-CSE-MsgGUID: fZDNPezTRCWLv7jHG1ffVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4428675"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4428675"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:53 -0800
X-CSE-ConnectionGUID: z0Yjgx1hRgSTX/NO4ubkag==
X-CSE-MsgGUID: rdFw28R2RDO3luq7Yl0PGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12323253"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 07/17] PCI: Make pci_find_host_bridge() take a const bus
Date: Thu, 26 Nov 2026 01:09:06 +0200
Message-ID: <20261125230925.2441-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_find_host_bridge() only reads the bus hierarchy to find the root
bus. Make it and find_pci_root_bus() take a const struct pci_bus so it
can be used where only a const bus is available.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/host-bridge.c | 8 ++++----
 include/linux/pci.h       | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index be5ef6516cff..33cc7fc3fc88 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -9,7 +9,7 @@
 
 #include "pci.h"
 
-static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
+static const struct pci_bus *find_pci_root_bus(const struct pci_bus *bus)
 {
 	while (bus->parent)
 		bus = bus->parent;
@@ -17,9 +17,9 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *pci_find_host_bridge(const struct pci_bus *bus)
 {
-	struct pci_bus *root_bus = find_pci_root_bus(bus);
+	const struct pci_bus *root_bus = find_pci_root_bus(bus);
 
 	return to_pci_host_bridge(root_bus->bridge);
 }
@@ -27,7 +27,7 @@ EXPORT_SYMBOL_GPL(pci_find_host_bridge);
 
 struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 {
-	struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
+	const struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
 	struct device *bridge = root_bus->bridge;
 
 	kobject_get(&bridge->kobj);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d89aeb7c9ff7..d03a2e277013 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -700,7 +700,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 						   size_t priv);
 void pci_free_host_bridge(struct pci_host_bridge *bridge);
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
-struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
+struct pci_host_bridge *pci_find_host_bridge(const struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
-- 
2.47.3

