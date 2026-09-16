Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED43672AF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599180; cv=none; b=gcYBPlV8VEvTh0SPGO5ISWlKwhgMHeU+aWDVlv2PzxSf6y3oi8teWL0MJWxUQrrlnNxhesvbkKmwcyWBhuP7jUosIDFR3F81ws1ATwuTVEm2E3gUMoL5asXSRGEWGf969BXymXH6y7aPvJfrpFzb9LxC+E0IjGdbTUDL70MsTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599180; c=relaxed/simple;
	bh=IPDaG144/ImDFFDUS/R+UUd/Zz+B8Tz8TKE9Dg62fdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEURKHqgVWlqI1kvM9L5b96rJHHeSqdUzhtWgKCAyOxB7PLEj2Gx6wF9TFhMoeWN12G0+yS8cBqwDGc5FLNT/8A8xCnG7icR1a6BpZBfwhUhDIXnY+sEw1BIrgMVc7XhxI1bV+vr5Nd454EgcPShaWMwmgPXi+o6WnPs4Z9eDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cpp5CSzw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cpp5CSzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789599175; x=1821135175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPDaG144/ImDFFDUS/R+UUd/Zz+B8Tz8TKE9Dg62fdg=;
  b=Cpp5CSzwTw0F3QkhlIKNYRWa8QjyHAPKvoYmFTnLOpPnEyVZFPVX4BG2
   wEJGXQyi5GqaFl7mTGuE6gbryWUkbmoe+CPc169byoyGl5zi7pqUdRZxl
   YlTcI71yK5zX7STwWcO6MsVxe126dymuhHrl+kisPW8yx61LDQy0GSnIM
   cBOzb42gDE8HyH/sRmd+bSpyRH4K0xpIPP15jNdy+HLNo2zalAXHmPRwG
   lUGSVZcrw5ZClDXYRaF9DFEN4STtbls28Hl4o6H7ok22oIZrC61YtVuxI
   uRWPJ1R5dYnL3U5b9i0JAPmIseJFfAo9pdPlK4Vn2/aFf05q4jBpPm5GB
   A==;
X-CSE-ConnectionGUID: fAnUBLw1Suu6Mgb1RSuPBw==
X-CSE-MsgGUID: BX64ElYzQO6h/G/njavsCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77547668"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77547668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 15:52:51 -0700
X-CSE-ConnectionGUID: rKP916VoRhqWj+bs6rZ5Dw==
X-CSE-MsgGUID: ndRhn07aTHClZUN9xJs5wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272018136"
Received: from cdjpc409-it.jer.intel.com ([10.12.50.120])
  by orviesa010.jf.intel.com with ESMTP; 16 Sep 2026 15:52:50 -0700
From: Gil Fine <gil.fine@linux.intel.com>
To: mika.westerberg@linux.intel.com
Cc: gil.fine@intel.com,
	gil.fine@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] thunderbolt: Fix credits reservation logic for DisplayPort tunnels
Date: Thu, 17 Sep 2026 01:57:55 +0300
Message-ID: <20260916225755.45127-3-gil.fine@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916225755.45127-1-gil.fine@linux.intel.com>
References: <20260916225755.45127-1-gil.fine@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we reserve lane adapter credits for as many DisplayPort
streams as the leftover credits allow, after USB3, PCIe and the DMA
reserve (which only covers one full DMA tunnel plus a minimal second
one). This is wasteful in practice as no known host router exposes more
than three DP IN adapters.

As multiple DMA tunnels become more common (as is topology below), these
unused DisplayPort credits can be used for additional DMA tunnels.

Take for example the following topology, where the links from the hub to
Host2, Host3, and Host4 are inter-domain links carrying DMA tunnels:

          --- Domain 1 ---
          [Host1: USB4 v1]
                 |
                 |
         [Hub:   USB4 v2]
         /       |        \
        /        |         \
   --Domain2-- --Domain3-- --Domain4--
       |         |            |
   [Host2]     [Host3]      [Host4]
   USB4v1      USB4v1       USB4v1

On the USB4 v2 hub upstream facing lane adapter with credits:
Total 160, control path = 2, USB3 = 20, PCIe = 76, 7 credits per
DisplayPort stream, DMA = 14 + 1, reserving the full six possible
DisplayPort streams is calculated as:
(160 - 2 - 20 - 76 - 14 - 1) / 7 = 47 / 7 = 6 => Six DisplayPort
streams.

This leaves only 20 credits for DMA - one full tunnel (14) plus a
reduced-throughput one (6), which is not optimal.

Fix this by limiting the reservation to TB_DP_RESERVED_STREAMS (3), or
the number of DP IN adapters above the lane adapter, whichever is lower.
Beyond these reserved DisplayPort streams, remaining credits for
DisplayPort and DMA tunnels are allocated on a first-come, first-served
basis.

With the reservation now limited to three streams instead of six, 21
credits are freed, giving DMA 41 credits, enough for three DMA tunnels
(14 + 14 + 13).

Fixes: 6ed541c53edc ("thunderbolt: Allocate credits according to router preferences")
Cc: stable@vger.kernel.org
Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Assisted-by: LLM
---
 drivers/thunderbolt/tunnel.c | 41 +++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 0625b1ff3820..f7e9d58de2f7 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -85,6 +85,9 @@
 /* Minimum number of credits for DMA path */
 #define TB_MIN_DMA_CREDITS		1
 
+/* Number of DP tunnels we reserve credits for in advance */
+#define TB_DP_RESERVED_STREAMS		3
+
 #define TB_DMA_PRIORITY			5
 #define TB_DMA_WEIGHT			1
 
@@ -156,6 +159,22 @@ static inline unsigned int tb_usable_credits(const struct tb_port *port)
 	return port->total_credits - port->ctl_credits;
 }
 
+static unsigned int tb_dp_in_count(struct tb_switch *sw)
+{
+	unsigned int count = 0;
+
+	while (sw) {
+		const struct tb_port *p;
+
+		tb_switch_for_each_port(sw, p)
+			if (tb_port_is_dpin(p))
+				count++;
+		sw = tb_switch_parent(sw);
+	}
+
+	return count;
+}
+
 /**
  * tb_available_credits() - Available credits for PCIe and DMA
  * @port: Lane adapter to check
@@ -167,9 +186,9 @@ static inline unsigned int tb_usable_credits(const struct tb_port *port)
 static unsigned int tb_available_credits(const struct tb_port *port,
 					 size_t *max_dp_streams)
 {
-	const struct tb_switch *sw = port->sw;
+	struct tb_switch *sw = port->sw;
 	int credits, usb3, pcie, spare;
-	size_t ndp;
+	size_t ndp, reserved;
 
 	usb3 = tb_acpi_may_tunnel_usb3() ? sw->max_usb3_genx_credits : 0;
 	pcie = tb_acpi_may_tunnel_pcie() ? sw->max_pcie_credits : 0;
@@ -197,7 +216,23 @@ static unsigned int tb_available_credits(const struct tb_port *port,
 	} else {
 		ndp = 0;
 	}
-	credits -= ndp * (sw->min_dp_aux_credits + sw->min_dp_main_credits);
+
+	reserved = min(TB_DP_RESERVED_STREAMS, ndp);
+
+	/*
+	 * The only real use case is a downstream directed DP tunnel, so reserve
+	 * AUX + main video on the upstream facing adapter and only AUX on the
+	 * downstream facing one. Don't reserve more than the number of DP IN
+	 * adapters above the current lane adapter.
+	 */
+	if (tb_is_upstream_port(port)) {
+		reserved = min(reserved, tb_dp_in_count(tb_switch_parent(sw)));
+		credits -= reserved *
+			   (sw->min_dp_aux_credits + sw->min_dp_main_credits);
+	} else {
+		reserved = min(reserved, tb_dp_in_count(sw));
+		credits -= reserved * sw->min_dp_aux_credits;
+	}
 	credits -= usb3;
 
 	if (max_dp_streams)
-- 
2.43.0

