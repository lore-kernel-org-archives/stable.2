Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258467;
	b=yPRUzd/e6bbI1hpT5wCPAxlEpWD7wHgU9SrQajbUCkCCKkxVunpJ4i/3J+Ull0Ic2r7J
	 Nal93Ey1Dxeo+5u6kHpt8DbdOKSFM5KhTPcEWbraSNXanhvL/xl8nViW5zinBdILhFRZn
	 ud81b7PiTwm+Oy4Izus06n2QDJz1Mh8bQUmDFUKwygFWR6YehJq4Rm3OhNHSopimH3m9Z
	 1JICZeF1XVw5T89JWcqdOfARhNsEbiKtygdISoAS/cJL+A2vg+fv/w/FsyA7mxxqoVxK4
	 lPt8uZLqWnxOPtszB3jMSZY1DXdMuw3ey/AdkM538URykDi/qlfiJxDeYzboBLhjLZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258467;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qmgeUuLjmJ/wmzQKJYHDJPfMGYHY2ormhPUZcxonf/I=;
	b=BXesGKJtC9dXNM4HSn+5RBMxwjhUk8DdzRDf+Wq9ADsSXxLQH0mz/L/1SHWw1KxsoCl6
	 yVx3QJn9XZk7vn3UH5I3I+rDJzp/qAeoT/bnMEi7u/msCs0drtpSwIt5YCgezxRHGj3ed
	 YqYuzoPPSzmEqOfy82O/yPmbkhQrxhPdoUZkl18v7GNtYO0ksrP4IlnR+5E96P/48CxQL
	 Mxld/zz23g8XcW/3vWDiVk2nvNskBvbABPyrcV2SXosg9nQScKhwKW6J3eUP2BIWzPv//
	 NR2rjjpdmkpANZpoRP2kxvaVGu5U4NMgSn5SHjTVJVTwCnpMMBEvKZjusFoiMgzU7Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dhcMXdcM;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A83606A325;
	Mon,  9 Nov 2026 21:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A83606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dhcMXdcM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258467; x=1825794467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDxMxOCsi7Wo7NO2LMxhmoeFjMI1TJ0AWMsIPGM+PYQ=;
  b=dhcMXdcM4ecptlAi2FtaM64ajjKX02Fudzf+gYywVqKcqx945cisP4Kp
   Mq7uxBPwJFDCiXG0B+WygQySAAWHJ80vgma6NOyY/+2dHXOKflhgdqm0W
   bYhjpDchaBSjE/NgI5Qh+1SoB+V7Cr4+Y/+AzDsXSPvOML1tTZwhUxAh/
   eNeEzydbf8HBGffEV/1QwvZqXYW+Li1S+dr7fWeUe+L/6QzaHag/Opx2n
   Q7MA9klSGO3YhpJMG6noR6WKNuK4HhBNbysXwBRi8vgsy2qYcqarCNkba
   aEcQs4ztJisdidAlEZA1boGcJOFueY2uxFRH04Q8eVjYpb9hw15cFlmXC
   A==;
X-CSE-ConnectionGUID: XzK/xtZGQ2yxBJcTMrAgRA==
X-CSE-MsgGUID: cSzM8ltMQsqeDnQZueeVxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3079396"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3079396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:46 -0800
X-CSE-ConnectionGUID: Jn5L83FTQ+iMZxnVsJKQ2g==
X-CSE-MsgGUID: Qx8XpJw6Qj2m6HalaZt08w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8016832"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/11] PCI: Use Header Type in __pci_bridge_assign_resources()
Date: Mon,  9 Nov 2026 23:07:02 +0200
Message-ID: <20261109210714.3862-3-ilpo.jarvinen@linux.intel.com>
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

Commit b2fb5cc57469 ("PCI: Rely on config space header type, not class
code") converted bridge window sizing and assignment to use the Header
Type but __pci_bridge_assign_resources() still uses the Class Code to
decide how to program the bridge windows. A Type 1 bridge whose Class
Code is not PCI_CLASS_BRIDGE_PCI gets its windows sized and assigned but
they are never programmed into the bridge.

Use the Header Type also in __pci_bridge_assign_resources().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---

I don't have known failure to point to with this, thus I've not added the
Fixes tag (the commit ref is available in the changelog if it's needed).

 drivers/pci/setup-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed16ef7c26fa..6209773a35f1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1636,12 +1636,12 @@ static void __pci_bridge_assign_resources(struct pci_dev *bridge,
 
 	__pci_bus_assign_resources(b, add_list, fail_head);
 
-	switch (bridge->class >> 8) {
-	case PCI_CLASS_BRIDGE_PCI:
+	switch (bridge->hdr_type) {
+	case PCI_HEADER_TYPE_BRIDGE:
 		pci_setup_bridge(b);
 		break;
 
-	case PCI_CLASS_BRIDGE_CARDBUS:
+	case PCI_HEADER_TYPE_CARDBUS:
 		pci_setup_cardbus_bridge(b);
 		break;
 
-- 
2.47.3

