Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648215;
	b=tC/4d3LjXMcQR+vAKW8tw5RCVYjE1rPT35jZvVBjYl2PEQJhOkrlHjdw6tf65KJoBx16
	 Y2ezV65okUtkcGpYcNw5JEib4iYPgIRjHahMuZLqweoGLlFxjuAWKv/jC89vxqSXW0gHo
	 tIVNGmZOiSJShNqMSLHlNXYQYg4NtI51/H8mMYCMpssgY9xdrSDsZI4hZ+q+AIZyX2aLD
	 yvZhwe1+S6MyjH12UNqpcTrEthaem9KowP9MP8iGSIz5kYxU//2cH++qWWFKun2kxZfDk
	 jDvI2yb0TxEQU7FlWon0rnd7YkcI9X+BmUgkd0hlEjAr2kFgNteayu/BLsGntz4HGpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648215;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ufX5fwnfTNC/geKCQOhfiPmfvUno+xbkbh5CDsEgZ24=;
	b=BJ0sJIRUEL40voZgatZkda3IUeSuneVuUpkMi7zroHnJOFUeT0M8HKgaDSIqSqKuc/y4
	 l5u0sMdu0kFFAfAZRMtdDlJJcdCK/62fN3QnFBZ8oOA4GW5Dr2Go/M/ylXR0wxmULvkit
	 1UJ2B3sy1Z4n823/7/FIvDS/2hBucG9PRr5D/CFyrJeougA+6xJzSmpJMCVCIK6Gs46aa
	 Lb7Rxb3ldnTvds4xIeIUhOnboAS5altJKvvMgAxyQt2m1CVNQJ0s0vr/wpCWYNTLqE7P0
	 1Kd4D1GFMpKBwZVPyROIqo2K9sgd5pKySTBiqKdQkc7KwfOG1p5Ry8+tZcEADFn3Zaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZmOzFfIB;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B2606A31E;
	Wed, 25 Nov 2026 23:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D2B2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZmOzFfIB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648215; x=1827184215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPcnz5vZucVTndhKfgx6Rvxk9IhMbqnTuETaUkw7fwE=;
  b=ZmOzFfIBBwE0JYcjOd6RyrJ5dfdYp0SK+kpNqR8mxpPKK14CN2OtUWcT
   DQK6ikA2FGPkLFiSnbaEiDdsqCtc4nz+Xu+M0AEDQWYGjsB4wgJTk7UFE
   R6sswDYaXVW8tCpT5Zd9owoyDuAB/XWDCXmklGZfN1lR/FDkdp+aYbtGV
   c1thuek7Q5ZFr6V/fb+B0VRjT8BFD9vYmRR8Hkk5TfnFm1XulmosSWDfW
   520609FLibIZEFBVV/XYobSDQUUHe4bovYw/FnAbmOJYqQFZiwjEeeu18
   x1WywdzenAwUCuNRAmG2ss4E/F3aZYsUQ64334+XV1cx9KAqYGnh3HQFU
   g==;
X-CSE-ConnectionGUID: fGQN1yKwThKw+klNTg8fKQ==
X-CSE-MsgGUID: GQtvuYM4RSie1veZK+0XNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4435072"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4435072"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:14 -0800
X-CSE-ConnectionGUID: Uj1O4oIvRKahe+y0swQ1Hg==
X-CSE-MsgGUID: eFnJVrsBRbqUfFDPQ+yVcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12283415"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:10 -0800
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
Subject: [PATCH v3 03/17] PCI: Use guard() for pci_bus_sem in pci_do_resource_release_and_resize()
Date: Thu, 26 Nov 2026 01:09:02 +0200
Message-ID: <20261125230925.2441-4-ilpo.jarvinen@linux.intel.com>
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

pci_do_resource_release_and_resize() releases pci_bus_sem on its common
exit path, which it shares with freeing the saved resource list. Move
the body into __pci_do_resource_release_and_resize() and take
pci_bus_sem with guard() in pci_do_resource_release_and_resize() to make
adding more locking simpler without mixing goto-based cleanup with
guard().

pci_bus_sem now also covers selecting the bridge window.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 29ec9ba59d92..10b9d3eb2864 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -26,6 +26,8 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/limits.h>
+#include <linux/lockdep.h>
+#include <linux/rwsem.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -2374,8 +2376,9 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	return 0;
 }
 
-int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size,
-				       int exclude_bars)
+static int __pci_do_resource_release_and_resize(struct pci_dev *pdev,
+						int resno, int size,
+						int exclude_bars)
 {
 	struct resource *res = pci_resource_n(pdev, resno);
 	struct pci_dev_resource *dev_res;
@@ -2386,6 +2389,8 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	unsigned int i;
 	int old, ret;
 
+	lockdep_assert_held(&pci_bus_sem);
+
 	b_win = pbus_select_window(bus, res);
 	if (!b_win)
 		return -EINVAL;
@@ -2398,8 +2403,6 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	if (ret)
 		return ret;
 
-	down_read(&pci_bus_sem);
-
 	pci_dev_for_each_resource(pdev, r, i) {
 		if (i >= PCI_BRIDGE_RESOURCES)
 			break;
@@ -2435,7 +2438,6 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	}
 
 out:
-	up_read(&pci_bus_sem);
 	pci_dev_res_free_list(&saved);
 	return ret;
 
@@ -2478,6 +2480,15 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	goto out;
 }
 
+int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size,
+				       int exclude_bars)
+{
+	guard(rwsem_read)(&pci_bus_sem);
+
+	return __pci_do_resource_release_and_resize(pdev, resno, size,
+						    exclude_bars);
+}
+
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-- 
2.47.3

