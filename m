Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182484;
	b=3CnxZo6BHn6fVL9mhuSyRHf0Jyg3WE1lf10pfgrXd+YHNVALZostrKtEelsTROZ0rqUP
	 oaA8cguEAuQKttOKFeJr60BKmP6yUJyhKbO/O4t531GZmoT2V8fJKvDEBllq8oe2sW3mk
	 T98eeFRZk9rxbORGuu5WL9hschuEWNLxZ7Pporle8RTcvE9Y1FT+7/WMu7hFLt8I/O+LL
	 OK+dqZC+Gd98cyrRiU+ooBK4VGKMDRRMnc1P9AL3jyJP+Qz60e9YzWHl3Lb8UabvGvFm0
	 cBcqIuNlLXk+uwOkxSqJ8hydhYFpJeyZASBVgtCrAk7qgaqU3BHPRKiD9NMLVGslF2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182484;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ufX5fwnfTNC/geKCQOhfiPmfvUno+xbkbh5CDsEgZ24=;
	b=RbpQcgY6m71905iS6ZajVomkuYga/dsbnrxgYa3/QpapFXSFuPFhR5W2/jhI1iefcuO/
	 t1zQCbgLRCXZUt3ay8Z+/f2C0M+9OferYEr0UheBXTxehMff7Uok/hdvEM5AWFqRN2j90
	 PISk5oF5x7vzAzFy00WH809g11NulpjjLMnTxsYYFfLePnOHlKQJkSc87AYgfbqJTtSh2
	 OJL9tnL8Yr8JIQm+qMEv8ZG3nbsoJRMQ8Z2hXVjkzcpv0t9tNDYLuQQxJPP3RlZiekXCQ
	 +Fh3O9uEwmnGBr2eo6INsUxbS657qXUpdXbBYYqDtuiNH+V2HpzCzcKuDqwmv1WoY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VJO6jUyj;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2BA60A2600;
	Fri, 20 Nov 2026 13:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F2BA60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VJO6jUyj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182484; x=1826718484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPcnz5vZucVTndhKfgx6Rvxk9IhMbqnTuETaUkw7fwE=;
  b=VJO6jUyj9W1xXVZbghbDKdOkkM8VnrbCX7zEV1uvIBqU8eafQ0c8qRyn
   i+TH/uo+iMMxuq/431RPovvf1Uy1P41jPjItXekH6iQStfFxB7i9Ndobn
   6w0TFLWOpwq+FW+jr8oLa+r+cWcmR2DlDWuc8g62RHU7P0SytLyzPutPr
   QEPThexJhjt5Q9T0GRsnwyA6h4ebdjpiSUwf4wR3ZchMncFsXhxvUQ+ez
   T0R48joaEL0/wXawLM+wyMEn7elBvxzEw5fIo25dzhalTVFA2K5Sibwzc
   X6bQ58SthN2ieichuXKzqXpJXlgSLtbEJt5aiTz8Odpvn6W52oB+PJ6e8
   A==;
X-CSE-ConnectionGUID: WUTObgW3SSWR/zySmioftQ==
X-CSE-MsgGUID: iRfQPR6uQ1egRDSn/Cnj5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4052897"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4052897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:04 -0800
X-CSE-ConnectionGUID: XOvsMvHQSgqRMKqv+LWgsA==
X-CSE-MsgGUID: UJnxxJfKS8CNyaKko1/LDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11277583"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 03/16] PCI: Use guard() for pci_bus_sem in pci_do_resource_release_and_resize()
Date: Fri, 20 Nov 2026 15:46:58 +0200
Message-ID: <20261120134716.3027-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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

