Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972666;
	b=XSQYYbM919JSWSnF6dGRz8VFz2ypVpY1msU70Q0bgGi4F7uQ3iBc8ljSyncp1JMD2v3K
	 WzcU13KpCiLTAm4L9nBWbUeRjUJQ8FUdLeHxU92yPXhXbUBcLToJD1E+2vp8pPsefILSZ
	 +8FbvxBuH72nDWJvxkSFrxjyryXQaimq4jUCJ0sfFLCO5fZhui9wdiU8/g4lFmjx3i/I4
	 5AmKbEZSRDOwD9Z3UH7A8nBcR3TLLaM6Mai5yV9VGhG1Deh2yMyGb/tHtw4+UrvtAdzDZ
	 yRvLqjOsRt5F/RXGV5ngFxm3qvK7Iok4OF8p1QytIwd9CGqKGbx9fosY+souDRX4PYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972666;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Rdk+KoCZKVcNWi2GCnoRdsLg54qpB/3KzXiaqLtVfJE=;
	b=Epg01PftLbe0GaB1Ho62pyFaDQRDV2wJXxtw2B985DWqy1SH6lduV5hbX/2rNnlSfp64
	 OIjmI+zGJINQFzenUbKyvXrdcCPAaYutw0U7SzuIGVxGux/3rpPaT2WoODpZZ8Et5GhOJ
	 OsOBgWCOBPmPLTrEq3DK1D3sFSunsq4H3KphgcZ5DZvX0mL8HQJeiN15S6053hC557V1P
	 oI5UfvvmMh1edWouEJl122sYY5x/SxCR4tXv7EvcFhjIT0/DpYuAo+YlEI3ohozQP/IG3
	 qqMlxT/m0fq8yWcipz3O4fw20TodeGf3/Laoerozl1M3Fnmd/Mfz9/GRC2Xpzy4aAcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BkxNhnwe;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67833606A32D;
	Fri,  6 Nov 2026 13:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67833606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BkxNhnwe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972665; x=1825508665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z1sOBUUrLI/mZYK2by/G56QXYL/56/c0SiPpzTRruPY=;
  b=BkxNhnwegwoy5JWbd7xHw2k2hv0bywt7F6zOMQbZK094qMYtd/3uH0lW
   9LjtKI/mOENQrfo+EX0ZmDMTkGRT9If0u+XV6Bnr/jw19j9T1wpUIRLVI
   FB3bmvEDrQVKa4lXprH/ThIQDxPuWD/j7qVP+NVMTky2mUKScU1kOo3Xl
   xrjfjt7FNQOT/5aVFvwR3mkLXs/eSeKFo1+tAhCVT/SW8Z6xyvtths8Zy
   L6evJjkiJJt6/V84tDDWRw31u7Bmctzx+AZlvhh/Chno4KQ4ERyiU0SAi
   W0+1hiPUdubBjtVHeIrJwCG4i/BwHe6TjTwnGqlvb37TleZC6EzYJDv3+
   A==;
X-CSE-ConnectionGUID: HkCzam31TpyKPJ/BCDxJjQ==
X-CSE-MsgGUID: +depP/+XTUi7/DaYpbiwtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2812230"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2812230"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:25 -0800
X-CSE-ConnectionGUID: 9JFujfcHQW+jYL2M9LvuVw==
X-CSE-MsgGUID: imhm2SRrQq22LFZ576TqNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7609902"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 03/14] PCI: Don't size or assign disabled BARs
Date: Fri,  6 Nov 2026 15:43:24 +0200
Message-ID: <20261106134341.39493-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
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

When a 64-bit BAR is larger than 4GB but pci_bus_addr_t or
resource_size_t is 32-bit, __pci_read_base() marks the BAR with
IORESOURCE_UNSET | IORESOURCE_DISABLED and sets its size to zero while
retaining the type flags. pdev_resource_assignable() only excludes
disabled bridge windows so such a BAR is still included in resource
sizing.

pbus_size_mem() then calls __ffs() on its zero alignment, which is
undefined behavior. pdev_sort_resources() catches the zero alignment but
logs a bogus "alignment must not be zero" warning.

Exclude all IORESOURCE_DISABLED resources in pdev_resource_assignable().

A disabled expansion ROM is still assigned because ROM disabling is
tracked with IORESOURCE_ROM_ENABLE, not with IORESOURCE_DISABLED.

Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed16ef7c26fa..0c27cec83c0d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -301,20 +301,18 @@ static bool pdev_resources_assignable(struct pci_dev *dev)
 	return true;
 }
 
-static bool pdev_resource_assignable(struct pci_dev *dev, struct resource *res)
+static bool pdev_resource_assignable(struct resource *res)
 {
-	int idx = pci_resource_num(dev, res);
-
 	if (!res->flags)
 		return false;
 
-	if (pci_resource_is_bridge_win(idx) && res->flags & IORESOURCE_DISABLED)
+	if (res->flags & IORESOURCE_DISABLED)
 		return false;
 
 	return true;
 }
 
-static bool pdev_resource_should_fit(struct pci_dev *dev, struct resource *res)
+static bool pdev_resource_should_fit(struct resource *res)
 {
 	if (resource_assigned(res))
 		return false;
@@ -322,7 +320,7 @@ static bool pdev_resource_should_fit(struct pci_dev *dev, struct resource *res)
 	if (res->flags & IORESOURCE_PCI_FIXED)
 		return false;
 
-	return pdev_resource_assignable(dev, res);
+	return pdev_resource_assignable(res);
 }
 
 /* Sort resources by alignment */
@@ -340,7 +338,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		resource_size_t r_align;
 		struct list_head *n;
 
-		if (!pdev_resource_should_fit(dev, r))
+		if (!pdev_resource_should_fit(r))
 			continue;
 
 		r_align = pci_resource_alignment(dev, r);
@@ -1094,7 +1092,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 			if (resource_assigned(r) || !(r->flags & IORESOURCE_IO))
 				continue;
 
-			if (!pdev_resource_assignable(dev, r))
+			if (!pdev_resource_assignable(r))
 				continue;
 
 			r_size = resource_size(r);
@@ -1305,7 +1303,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			resource_size_t r_size;
 
 			if (!pdev_resources_assignable(dev) ||
-			    !pdev_resource_should_fit(dev, r))
+			    !pdev_resource_should_fit(r))
 				continue;
 			if (b_res != pbus_select_window(bus, r))
 				continue;
-- 
2.47.3

