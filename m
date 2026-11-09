Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258484;
	b=UlJR+08a9WICEMasOULAe2YbKC302JrQGsh4Dn0UXEQT+fJTz5nbtE5fM8xM319uoGd0
	 3X329p0Pylsz+CSYfsfw+NgBQrr4szhV9AVPN3TODUxDgK0N+aOhJpOs986l8U9ojPwHr
	 Q+bqc7i9MN7pxjkTDerrkOhMZDCDbWXAATX/v2eoPqZ7X+OB1pHw7GeU+xuQmuV3oHZIE
	 tTiv2LGladn52PzAnHaCaFbQueyEUwhrCL5aFIxxMac/5QYsesvwMrl+oMV87KhU+YO02
	 TqsfxWk2lSdW7GX+UzfQzvawfInu6iuQYH6dE3mieBof//WrmZY3mOUlHIR4WQI6Rzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258484;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RCGuHpO4WlOcImMwKKlL4ESImylrBW1Nc+3VmNrj1Bg=;
	b=U1DKTNvyaOTjf9fINmdt9K4cfnRIKZ4xai5m42m/Wl/HJpZ5Si+IeqS65l7m1AVJftKe
	 jFum9qZ4czjdtQIlt5B0Uvryjv8u2arWGHkPBLnUooxRjuHcruD3ZEdS2JBHjXa6f/Rgc
	 aYz8JMLf7do8kbxa/t/xLQFqKJpHi5f92PbrFspuYv4zJ6gBhMqLNa7vbstVZatzSLRkT
	 e+BCI8UgpELBaK0UVZahUuLhq+3e1tNs6+9+T6ExIetKNrT63BQqBvAqntr6kHUSVozGU
	 f6+sy+TjGLAk4tkadPijf+PQfp7/txvoPceq8Jkb3OYmfsOGpUHdm6jo4eU5DFVZgKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IFo0LfJA;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB90606A33B;
	Mon,  9 Nov 2026 21:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB90606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IFo0LfJA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258484; x=1825794484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bOvwJZoyAp9LbMasE5/+1+3+ZUzr/A918Jm768LJYes=;
  b=IFo0LfJAJ25Su/eVx8d/XK0ItKyHJs47erHfJw6Npobm1FsbfT9ZvSxk
   bYwZyErkUs0ySIU6VTPNkOF32jeGE28UhIFzRgi0tgf03QArpnxs9QZOs
   EuhwG9mk5FOBWjFlovQuGH9bvgTwtdb3hB5pyeRVVIax8rBlLkLS0v7ZL
   n6dgl+vR4fJtQUTnsT1jZTmtp45OYgAx8Wa/ZABxlcVf3YL328Ppsf34e
   7kzBABX2INBk3jhf3kEmIPYhJKn7V0bE9ETCqiqtDYhxLIF8ZFl7PGhrS
   Ro2o6xpzufpFzCsApVLEo2UBV2OPpfg/xRMHz53RPKccUA85nJoyvMfGv
   Q==;
X-CSE-ConnectionGUID: 00rx9oKxQOSrFbNqxPaxQg==
X-CSE-MsgGUID: 2akHjo45TqCRVsYnMJjIUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3079418"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3079418"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:04 -0800
X-CSE-ConnectionGUID: vNtHD/7SSrilT339GkxJsw==
X-CSE-MsgGUID: lD5dahDZQuu+r7bV5aC2QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8016859"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/11] PCI: Fix off-by-one in CardBus resource names
Date: Mon,  9 Nov 2026 23:07:04 +0200
Message-ID: <20261109210714.3862-5-ilpo.jarvinen@linux.intel.com>
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

cardbus_name[] in pci_resource_name() has no entry for resource index 6
(PCI_ROM_RESOURCE). As a result, all names after it are off by one: the
last non-window resource is named "CardBus bridge window 0", each
CardBus bridge window is given the name of the preceding window, and
PCI_CB_BRIDGE_MEM_1_WINDOW falls outside the array.

Add the missing entry.

Fixes: 65f8e0beac5a ("PCI: Update BAR # and window messages")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..46da873c9aac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -839,6 +839,7 @@ const char *pci_resource_name(struct pci_dev *dev, unsigned int i)
 		"unknown",
 		"unknown",
 		"unknown",
+		"unknown",
 #ifdef CONFIG_PCI_IOV
 		"unknown",
 		"unknown",
-- 
2.47.3

