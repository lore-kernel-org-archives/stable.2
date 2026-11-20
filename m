Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182502;
	b=FQYU/c/pwwb+0j/PKqAdglSHGHJsQJX5UilMxRIXwtZ1AzYsi/DaU7WQ9XQbWjWXDci7
	 ukF5J/h6nxWmkpicBE/GjIe4aOhPOIjugfVg2BWE0FaPUKGUklnTwXtO5w2Cj4tL4lhmF
	 l/3bZD5vS+Xgu8m9r9JWexN5Qp/yD+4s6jTsrBOsqlocywR+n8TUCCTvfxk/Ye5gnYjOt
	 AoOMwEbOAbOKQvWz6fEvEVIFtA8JOcbIdDteFZ9qRRysJlqsSw6o1IBRzXoAWWKBqVqQm
	 VUIBbghqMOsVAOOMegYz5PlF1Z5vsd3uaVx4d3zcF3ktBhFMjingy2+LJZhvfvoNuCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182502;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Rm6UaFjb16TIa3CCBCmcpaaAjDD/UlMsl/pcW357mH4=;
	b=HwLy6SEJhGgnPMM18p20GJsJF8Ttr6Qx3cNKmIa0mmeUkYznzvZ2hsLTwW6/GxsAuzgg
	 9/gbvp+QaYiwBpjCBEHe+QP34x9FwgxngJXzbbZYRcjEw9IVJdPg5wdgemxMyHeioDGTf
	 Tc6oG62jhHE7IPFjzN9TmljYwLgu62T0T3gMRgIY7OeEQpAGP7hZLOfSNevIHxQ1Xg9qf
	 orUJAKJ1u2lZYamVrz4R98bEZfqDXgBrC48zx8JeYi4ldxsIsow59hqX9ehVW7PPNiXYE
	 FH873s+oyerzjeagE2uhj9HjOYiBLPESLzh7TMT6drgNEuuBs97H7G6nhuPkq4jpZCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jVu0M/vB";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23266606A336;
	Fri, 20 Nov 2026 13:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23266606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jVu0M/vB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182503; x=1826718503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h18L66jVH3PDdd8JlNPNuSB5kFtfhgqHvs74OkPhuME=;
  b=jVu0M/vBTmH2yc8zvfJHQ3R7vX37JlNBzoGp3UCkq33gY3lqso8q+axy
   jk/S6/0lDjJQwFnfGa+O5hUbVZBG4g0YNio+X+EpefrNF2LuJ45xnwRaq
   AckX4j2x6IrrdQUphtF5RyjTbOOFJ9QmWB+RaXJ+CSoglX6cQOv2cG4gL
   445FUUoFmVacRyJfdfs1SiBpBb4XNRsnkm+zqyEUICACSMgwaAZRt/WD2
   HulGDnzBLoBms/guykEvAI2AQBtXJod7tbnFm2npYXdo2OIlBA9LP9bw7
   PRErOb/Rm0qIqgEYx2NJFt0ab+4R6G7ySijFEULACuAwaVozCBTtNWme/
   w==;
X-CSE-ConnectionGUID: FoZpY69hTTiWKpHZubZ7TQ==
X-CSE-MsgGUID: p7cRxGsZSRCIM8oFHdiO8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4160551"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4160551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:22 -0800
X-CSE-ConnectionGUID: PDUan7jDQ6++qYTZGUTJUg==
X-CSE-MsgGUID: HVut2G1kSv6iulDK/1XOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10605012"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 05/16] PCI: acpiphp: Use pci_assign_unassigned_slot_resources()
Date: Fri, 20 Nov 2026 15:47:00 +0200
Message-ID: <20261120134716.3027-6-ilpo.jarvinen@linux.intel.com>
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

enable_slot() calls the internal sizing and assignment functions
directly to size only the bridges in the slot. Use
pci_assign_unassigned_slot_resources() instead.

Sizing now happens after scanning all bridges in the slot instead of
right after scanning each bridge. Sizing a bridge window only walks the
hierarchy below that bridge, so the order does not matter. Sizing now
also holds pci_bus_sem.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/hotplug/acpiphp_glue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 632344f34cae..fc95d5814ecb 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -497,7 +497,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				acpiphp_native_scan_bridge(dev);
 		}
 	} else {
-		LIST_HEAD(add_list);
 		int max, pass;
 
 		acpiphp_rescan_slot(slot);
@@ -511,12 +510,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					__pci_bus_size_bridges(dev->subordinate,
-							       &add_list);
 				}
 			}
 		}
-		__pci_bus_assign_resources(bus, &add_list, NULL);
+		pci_assign_unassigned_slot_resources(bus, slot->device);
 	}
 
 	acpiphp_sanitize_bus(bus);
-- 
2.47.3

