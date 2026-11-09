Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258479;
	b=ezY6xFxP070RWeujqHtnnZ0OWMclNaO+dKlGdY+RL2rZgUv432w6isqMmHBwZ8ude9fM
	 NOU/qb8teNOFBDjMHLg5UdjH2KpTZSFlj3q7oS1W4igavsvY2QC3oO9tsxWVxnmi+jicI
	 SIKD4Ja9bZvHg5aMNSFqk4rWLilXEAu2p9x5fb4ERulFbpnYL7i5xBQulMCbmNnT9CN9q
	 39egx54VserinX+Ngpny3I72cNtgbd/AMatbHI8Djqk7CKTciu/KcmWmEcDS6LlFx+kr1
	 l4UcZDOKDMKrQYHlOAhb//6kBuUzDSAZBmXqPETS6bGxhnQrzFxBuUMFQmvZm3iVQgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258479;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=baiETMIsgc6YGRL1qHqGjDmlur6R10Judfum+86QzVs=;
	b=T3nd1YanB9AbKd3OROlERDybuZE6dYFsxK73Zr+yyOKUv/eXaafdHG+kH7rRKXzOu+M3
	 7DgPKmFbGuENRSIzbqJBGcM5/anS6tIkGwflMN50RukgRnHRrvCLnGI9RgpL152dKVzXK
	 ZHbQhJK0t8vvZLPsJfmJJhyyPXiOKlQWOEXFKMenpJ8+vEtLULyujqFTR4ixkrwPMPMvK
	 UUad01kc/AO9+rq4GEbc2dfZAVyYRnZAEgXu/VvGSktMdCgXNEbWew3IMPv+adUU97PXY
	 dhIHFitzCJ/A+GaPog6Iom3UFL1m6onm7/vjcsQeVnONazq43lxFDUUUUXhZfkgblJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MV2PBVzM;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FC60A2607;
	Mon,  9 Nov 2026 21:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875FC60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MV2PBVzM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258479; x=1825794479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fxXF/9et+4Uw+IO/nG39bsXrq3vS5Vn0Aa/hTjovQZk=;
  b=MV2PBVzMtn8oiwqak5fPez+HaHyn2VGo3sU8QAuitrh1hutNIIhB+OlQ
   tytoEj1Q+LFT4/zLgqhairfSnvlaEA5OcafyZVpNJwlWqnYW9tI50zHo9
   t8Noi6ausjS1yEQ3NqTj4aWP0fovrrUBlx8IqJu0U+GYe5A3nzw+xma0T
   2PO4d+lQ6x/com7IMvzFPUqNSGNwCUynk5AGn7luytXQm2fuSvrR4qkiw
   p2Uopw2Be/DH9pNOPk11Wa/PFwP4QBlqcBwuaGcpLDFCsNFUZvHWg98ZP
   RHuRq0LAMFXSkZTj8HoPC9AcmB4EYi07ZcEWe3h6I45228vV6h4doxELN
   w==;
X-CSE-ConnectionGUID: f/9rI7dpRledacIi1vTw9Q==
X-CSE-MsgGUID: 2/RPPcEkRJqOSowrQqT93g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3079409"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3079409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:58 -0800
X-CSE-ConnectionGUID: KLRjvRZNTFuOU4qcuvTmyA==
X-CSE-MsgGUID: OzhPokStRlypIBafp3UdSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8016852"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/11] PCI: Use Header Type to detect CardBus bridges in pci_resource_alignment()
Date: Mon,  9 Nov 2026 23:07:03 +0200
Message-ID: <20261109210714.3862-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
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

pci_resource_alignment() detects CardBus bridges by the Class Code while
the rest of the PCI core uses the Header Type.

When CONFIG_CARDBUS is not set, pci_cardbus_resource_alignment() returns
zero. A non-CardBus device that reports the CardBus Class Code then gets
zero alignment for all its resources, and pbus_size_mem() calls __ffs()
on it, which is undefined behavior. When CARDBUS is set, the device gets
CardBus window alignment instead of its own alignment.

Use pci_is_cardbus_bridge() in pci_resource_alignment() and make it take
a const pointer as pci_resource_alignment() has one.

Fixes: fd29d4ea09ba ("PCI: Separate CardBus setup & build it only with CONFIG_CARDBUS")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci.h       | 2 +-
 drivers/pci/setup-res.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..519918e24cc5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,7 +419,7 @@ extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
-static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
+static inline bool pci_is_cardbus_bridge(const struct pci_dev *dev)
 {
 	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 376f09630a4a..d8d53861b4a6 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -255,7 +255,7 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 
 	if (pci_resource_is_iov(resno))
 		return pci_sriov_resource_alignment(dev, resno);
-	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
+	if (pci_is_cardbus_bridge(dev))
 		return pci_cardbus_resource_alignment(res);
 	return resource_alignment(res);
 }
-- 
2.47.3

