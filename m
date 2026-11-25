Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648234;
	b=SS7ZxWB+KP73Q/5bculyIbsF8JuLlzJjdxyvgPqFgE+cStQ3VZL0m8ubeCkv+amYI6LD
	 /Yhg0aXnNZQaE3CU+kncZ7qW2rmEa2/GO3xprINplYqD0tJvQCC7hMUdE1sG3usmdoO/2
	 Va/WfoT5i1ZpakWH3oZ5L5h5Is8seT167n6QBgtEhJ3rYk9uGSCMh7oxaE9+5HrqVXhEq
	 64A/R596Fl/dakhGVHcmgzGYeKi1vIFSOmTCmizeEDnJvEiwy7nVIQc5fYI8AgrAZ366i
	 k8NTVcAum3bMZLWaO7NQW5Vp5Hw0aYsGBD8mR2gQuRJzjCA83IJePhUmnTjwuDZnZsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648234;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VUZly3QaaWGkt8NgBX5pAur13/hfvDIKs3EcJSYniiA=;
	b=zcMImcPXJe4rATMFqTOXar4IL1xFSaFhn6CsK/AycwUY1xmqSeghKKXGMqwIXts/DpWa
	 0petaTwqk8zVUjzyxBY3oVu3gOJ3TbkFzDD5vhZHhWs+CPAl0nqKeyvIE2FLCqqlxWwPq
	 sBZeV3aSixVbv1WFFhmiNSTZ4rn+nf5sLNq2FKVAnbZyZQKB3yllHHJ0h+IqhxMfcXTAq
	 HjNzxzaTyr7FfyOcKYpLY1qTUlfR2rxNnuGuQn0+spsanSRhxOLG/m0fi3RD8gpFBmylG
	 9Fc1LDWbkL8A9HCeNBaKqzgp2oLd8LI2twknuoaHp3ePIeMqdCatHcHy+0/5gkiTtMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZQVRlAho;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CA606A326;
	Wed, 25 Nov 2026 23:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZQVRlAho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648234; x=1827184234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/F3/u6+Vuy5zuYhOzdF4dbUy0sQvfaHgVZWMO4keQxc=;
  b=ZQVRlAhoIoPdWnihrR5ewr2s+vipxcXHOCCViDWwx5tbnM+lx/yFllmK
   EmpiGyZ0WUCbBHol6I/921T3TGTnv44b1WgOUp1LdtGOodoIFzUZWveEj
   a7vgYHopdNjsotdQf6ZxswXeUvRW9iqdubxv+TSJLOLQZs3QBJZJLW2v6
   m3HxtpNqhGgPGTU0K3WIIFtYHJNsFMlmjxe7KpSnlz4HiC9TRdJO5OvlL
   7GS6k2t9cCjJFRQP26cWEL9sxSo8EK97zHQgxIsujT6zUK7uNe5r3Qkk+
   RKnfRXI+jvAQk8QUuTDwfT3lAZP7Ghn2gzbGlfDCFC5qUv6sPnxckhsun
   g==;
X-CSE-ConnectionGUID: VjaQqR+qQdqdGiG6XI0SRw==
X-CSE-MsgGUID: q1ZBA2RyTky3xEpJS2SrBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4435139"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4435139"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:34 -0800
X-CSE-ConnectionGUID: 8per91xJStiKVvq82B7nWQ==
X-CSE-MsgGUID: 3TqOehU3RBaaSaXTmXMLuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12283454"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 05/17] PCI: acpiphp: Use pci_assign_unassigned_slot_resources()
Date: Thu, 26 Nov 2026 01:09:04 +0200
Message-ID: <20261125230925.2441-6-ilpo.jarvinen@linux.intel.com>
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

enable_slot() calls the internal sizing and assignment functions
directly to size only the bridges in the slot. Use
pci_assign_unassigned_slot_resources() instead.

Sizing now happens after scanning all bridges in the slot instead of
right after scanning each bridge. Sizing a bridge window only walks the
hierarchy below that bridge, so the order does not matter. Sizing now
also holds pci_bus_sem.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
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

