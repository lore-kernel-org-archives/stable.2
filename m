Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235617;
	b=UZMEYbNEUF4x+2mFLmuYI6Q9YuLIPRxFnoNAlRg8uAp/5KneSaqy8/xeb8Gm2pMofZ7Y
	 /IJ9mWG7W8JOiOyUMiDiFLE2wkSRCqPCX8BfR0djOxmw8kKaVRQRAOQOM7LqUqTYhtlrG
	 yzd+YvvRZzl1yqF1nnxU0/480cjhAOY513iUJw374K65BN823o1cotztWljiqd5xJ8Zbz
	 oCyzs1Vki63gJYOKdzgEsrv1AgBHTeqFm3XX646WwXB0+e0Pv1H5n+BjWEGlaD8Ek59d/
	 8GDM0Xk+9H3iTGaR6eWHBd6mWYM52SZskvLwtmxg2M9wI0C7dJQNGOKd+i/aqcz5b5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235617;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/Zs+Ic1R03IE+bmq387RlMKn8zZ+sny+To/g863uh+I=;
	b=KddoTb9gdnOpxTSysoazT8muQyV4+WbA44QqkTgbkat9zkVsJ443BhH7PP6lGudzoenb
	 AfYuCUA2lDrmn+c5qymwYqqOkhEOH1kVb+mAd6kDtJNFceGKJgQ6C8zr0bLTfzrkfOJxG
	 CntHTAVZZUau1q5SuumYFJHje8Atbao4wBqVcLM7/kwklOQB0t5vT930FEzWosOkrvFdB
	 F1fw9a7ARSz1+KBQyJCKqpgFvqBaOxpoqEYwoawRgIy8CiVobgmiHt/UzqBnsQQ2ETeQ/
	 8Pf+y+7QNdp5T9lc+a6qm+w1XQN5gI5leeJFi9xp4umKPRMrDopg6SNpUcrTun7Tf7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqN4mN8g;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20C606A31C;
	Mon,  9 Nov 2026 14:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C20C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqN4mN8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794235616; x=1825771616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IYpd36+hNdVVbHA3LFgNx5Hn7NExvNmImvUzW4FHbYY=;
  b=kqN4mN8grlztSnqH6hQMrpkjUmZ1L91piGySO8znJ3RMaG09ff7JoVAe
   8laCuGbWm1jxFVN+mVPL32dgl/wQe0OB42icb8AlewZfQjD4RxHvbgzPb
   hmNoxCfLu0/Q4OT4ZtWVzjRi+eEEGIdmz1PL8b4MA7eY8erMpM8LkSYV2
   ZzAwokXhqI0rPRffPj3m3xe9UriTnyRmMJNNvlRL53gjcs+S1jIYhCIal
   LjIXVbyDiXivSysLfa3a9sqcXSydQ3faF+h1Eh7iH22wj6+iKXf6+YrkH
   7slVg5Bu7F4nK2ej8x6xHEmisrBuGeWGhm0RxLPYtiMyKB/6ktXCsAh75
   g==;
X-CSE-ConnectionGUID: /e+66MnWTdSh29v71GyyJQ==
X-CSE-MsgGUID: LqYelcxcS/uIkz7gDKU1lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2957091"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2957091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:56 -0800
X-CSE-ConnectionGUID: GBQL0ihET5usu8uKS7Ogvw==
X-CSE-MsgGUID: bgQJgiuYQviRFVR9NG048g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8044136"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:46:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] PCI: Honor window granularity during resource distribution
Date: Mon,  9 Nov 2026 16:45:53 +0200
Message-ID: <20261109144553.2516-4-ilpo.jarvinen@linux.intel.com>
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

When a bus below a hotplug bridge has BARs smaller than the window
granularity, removing them leaves available[i].start unaligned.
pci_bus_distribute_available_resources() then aligns the start up for the
downstream bridge but keeps the end, so the size passed to
adjust_bridge_window() has a sub-granularity tail. The bridge window ends
up not being a multiple of the window granularity.

Align the size down to the window granularity after aligning the start.

Consider a hotplug Root Port (bus 01) with a Switch Upstream Port (bus 02)
below it that has an e1000 and an ivshmem with a 64k pref BAR as its other
Functions. When the switch is hot-added (emulated with a remove and
rescan), /proc/iomem before and after this change is:

   faa00000-fe9fffff : PCI Bus 0000:01
  -    faa00000-fe8200ff : PCI Bus 0000:02
  +    faa00000-fe7fffff : PCI Bus 0000:02
         faa00000-fc8fffff : PCI Bus 0000:03
           faa00000-faa000ff : 0000:03:00.0
         fc900000-fe6fffff : PCI Bus 0000:04
  -    fe820100-fe8201ff : 0000:01:00.2
  -    fe840000-fe85ffff : 0000:01:00.1
  +    fe800000-fe81ffff : 0000:01:00.1
  +    fe820000-fe8200ff : 0000:01:00.2
  ...
     100000000-13fffffff : PCI Bus 0000:01
  -    100000000-12000ffff : PCI Bus 0000:02
  +    100000000-11fffffff : PCI Bus 0000:02
         100000000-10fffffff : PCI Bus 0000:03
           100000000-10fffffff : 0000:03:00.0
         110000000-117ffffff : PCI Bus 0000:04
  -    120010000-12001ffff : 0000:01:00.2
  +    120000000-12000ffff : 0000:01:00.2

Before, the bus 02 windows end at fe8200ff and 12000ffff, which are not 1M
aligned and thus impossible for a bridge window. As such an end cannot be
written to the bridge, the resource tree does not match what the bridge
actually uses: it decodes up to fe8fffff and 1200fffff, covering the BARs
of 01:00.1 and 01:00.2.

Fixes: 9db0b9b6a142 ("PCI: Take other bus devices into account when distributing resources")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9d8b22d1e6ad..5651966f3029 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1974,7 +1974,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct pci_dev *dev, *bridge = bus->self;
 	resource_size_t per_bridge[PCI_P2P_BRIDGE_RESOURCE_NUM];
-	resource_size_t align;
+	resource_size_t align, win_align;
 	int i;
 
 	for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
@@ -1989,10 +1989,22 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * window.
 		 */
 		align = pci_resource_alignment(bridge, res);
-		if (!resource_assigned(res) && align)
+		if (!resource_assigned(res) && align) {
 			available[i].start = min(ALIGN(available[i].start, align),
 						 available[i].end + 1);
 
+			/*
+			 * Small BARs on the parent bus may result in a
+			 * size that is not a multiple of the window
+			 * granularity (usually 1M), which is impossible
+			 * for a bridge window.
+			 */
+			win_align = pci_min_window_alignment(bus, res->flags);
+			resource_set_size(&available[i],
+					  ALIGN_DOWN(resource_size(&available[i]),
+						     win_align));
+		}
+
 		/*
 		 * Now that we have adjusted for alignment, update the
 		 * bridge window resources to fill as much remaining
-- 
2.47.3

