Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235575;
	b=uZazWi7rOkRyOWKaMxPt9h69VL3T1fGRq6X2HAEk2ryQ5n5KQCkuBhK7JQ1KrTwP8KGt
	 Vc1iN+xRNSbOx4ETtc5YHqqEysxjFt2NEbuvXJfkIpt/J/xN2TB8XeBUwMvNudjktw3l4
	 3G8tWS5FPLhf0z944axtlNgO3nyv5KBRHbrpNuwhczA/3zdl4frsA+Z69w2VAbpn9bmgi
	 OVnUr6pZP0FpCojr6+q9UpjZD7GDKqP8iGJ008Q9tgWV2au0j86iB9Yeg+60THzRAV/ne
	 YkfwQTPk7tsuVndfmOnrrY3LGlueRjZ6l7bsdbg0GDnNeQJNA+dF/PEGFvUliFvHkmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235575;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZTynlzVV0Ls8ODcAkfDfMcepOFVJ/hELBpVjw8Sm7jw=;
	b=UMYw43I2Rmap54C089P3IbzUiq1456YHzESVquIN13byu9YOmBtX+ChS1jc0Tv74lVub
	 TKPB4i2Ts6kSizxPeAQ90Hh/YjdTwCaXP7kQ7lH+Bp5GNe4HMYEI+GV1JPaJzv2Xhg4Hb
	 Moq+V82O5xDe7tITbh5VgCFv5ypu3ycGc3p8qPvJX+8ZvlUboFvfE2WZ6iAgRWhepKBXp
	 QaewHusclpmB4Bs9fNlPmFvaEbJxiDZYRQ44K0AzJLfakCZUDzLcPzaU9E3ohbDOwOUDw
	 M5/VgiT3jte22PSubSIFeUOGCc0bMckHxtFII1EoIVMuEmnYi3Rck0i+NvvN+SzunZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Obm6L/ji";
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A08606A331;
	Mon,  9 Nov 2026 14:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A08606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Obm6L/ji
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794235574; x=1825771574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eH+3l1QBIxv1/IMcwKV7cNhEIMMQ97rqwGMaHvQn0c4=;
  b=Obm6L/ji3msyphQvZ3tXMfA26TuAAqQofij/6zmImPlscD4dwJDmwi+h
   QQweuUI2716t3zFyxKAj6uN5dosr7OfQgm0x/ZdnbS8RaLegbvvm2MTlT
   HINDnVrgomJpTGMHyIIUxViOBvkvaCdntQDDtl48KqA3lOLPmYHEv5Plv
   KGW2/4byhe/DVbHSEKH+J2jZrv99OnfJx2Ra7A2Sg4FwytvA/BcTiNLTu
   PTln9MQNVFLODWHlzaf4brB5KiYWzSCilfPJAOgUZduwvCwRxD/p20bnC
   uhoKKIkNBWZyzgImJ9D7pEVuUbU6f3FR+Betb7De0Q3KgQedm/aa0EFJk
   A==;
X-CSE-ConnectionGUID: PaPCJRqETouGZvzIB+tGEg==
X-CSE-MsgGUID: Jh8CjTIOQlaSTPO2w/wX/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2836640"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2836640"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:14 -0800
X-CSE-ConnectionGUID: zH+OlhDfR6KlqmKRlcD/ow==
X-CSE-MsgGUID: 5j1elAAYTqyHqmM13E4YYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8323933"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] PCI: Fix NULL dereference when shrinking window without optional size
Date: Mon,  9 Nov 2026 16:45:51 +0200
Message-ID: <20261109144553.2516-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
References: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
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

adjust_bridge_window() assumes a bridge window it needs to shrink is on
add_list. A window is only added to add_list when it has optional size
or alignment. When resource distribution gives a window that is not on
add_list less space than its required size, res_to_dev_res() returns NULL
that is unconditionally dereferenced.

Consider a hotplug Root Port with no spare pref space and a switch below
it with two non-hotplug Downstream Ports. 02:00.0 has a 2M pref BAR below
it and 02:01.0 a 1M one. Alignment leaves only 1M of pref space for
02:00.0, and hot-add (emulated using a remove+rescan cycle) crashes in
the inlined adjust_bridge_window():

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  RIP: 0010:pci_bus_distribute_available_resources+0x19b/0x4b0
  Call Trace:
   <TASK>
   pci_bus_distribute_available_resources+0x468/0x4b0
   pci_bus_distribute_available_resources+0x468/0x4b0
   pci_bridge_distribute_available_resources+0x7a/0x90
   pci_assign_unassigned_bridge_resources+0x43/0xe0
   pci_rescan_bus_bridge_resize+0x23/0x40
   bus_rescan_store+0x63/0x80

The required size must not be shrunk, so return early when the window
has no optional size.

Fixes: dc4b4d04e1ca ("PCI: Prevent shrinking bridge window from its required size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---

As it was a non-public run of sashiko, no link is available to sashiko's
report.

 drivers/pci/setup-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed16ef7c26fa..bd0974def921 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1896,7 +1896,11 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				break;
 		}
 
+		/* Without optional size, there is nothing to shrink. */
 		dev_res = res_to_dev_res(add_list, res);
+		if (!dev_res)
+			return;
+
 		add_size = size - new_size;
 		if (add_size < dev_res->add_size) {
 			dev_res->add_size -= add_size;
-- 
2.47.3

