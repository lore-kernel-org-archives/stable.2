Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760445;
	b=WFeqJCKzbNun1Tmkqz2F11yaIlD3PYpn0lcV9VLTYyIt4wQPQygz/o7+DljqKS7Qy6Uu
	 PChEqlE2vVMoWTNtGEJOFDHSBtjfKeffpWACRy1pqMs33cLg9biU8xSQ10u2E1Ejwiesb
	 EYRPGVZZGmepRUQuP39SLX/yN36QuKvSoymFYLdv/YN2Wl7Wq/5lpGES0g2+t1OpyXi73
	 8Hql7Usls1+oVVX82yc31UoxJz1SVBXPXP7FqUYdNIFuIYL6/EV22RxmCEDqjYopJgjRm
	 qepNZLLUBXiu10QMzr8KlKYI0M3t/x7Lw+Hrp+G6CLHaAOSrpUSqjJlmAXflpLkSg7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760445;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LnZjqQyDMjBGiHlj10jOuYrhXkC8SlmCFuLag3OZXEI=;
	b=zpoEzkILY6VAZV+B7NoqpBsr6C8riXOMLpIYShycZMTzZonszFP0/fjrC9K8oY5Vmwm7
	 rcBpB17ru13aa9Vf3cBj+rKy7CNgPVjE8t8POWol7/MpsqMqLmrdlF2nin64354c5wRip
	 FSPTlk6ftgjIelWJSiEj+6jyydIuTEt285ty9TTY/V8lfrjbt7GKO5eKyVt9gbuBDLxix
	 v20n5fEgEVtY8egV3iBSvNwF8887B3lgmsUo0vcv8XUjRTpej2nlQ62GU0MpmKlyd+4dI
	 0806ioJkLvqTDccLvf7zjdBoRFV+GBudUZwReeDK6VC++Qxvbl6oTiCKMj6ITFyVgow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA12606A31C;
	Fri, 27 Nov 2026 06:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA12606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 27 Nov
 2026 14:20:36 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 27 Nov 2026 14:20:36 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 27 Nov 2026 14:20:02 +0800
Subject: [PATCH] i3c: master: mark OF bus child nodes OF_POPULATED to avoid
 legacy I2C rescan
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-i3c-master-of-populated-v1-1-29d2a6a5509c@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIABEhCWsC/x3MQQqAIBBA0avErBvIKRK6SrQwG2ugUrQiiO6et
 HyL/x9IHIUTdMUDkS9J4vcMVRZgF7PPjDJlA1XUKkUapba4mXRwRO8w+HCu5uAJiV2lLY2jbmr
 IdYjs5P7P/fC+H1xNdcNpAAAA
X-Change-ID: 20261127-i3c-master-of-populated-2ef07c2bb743
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Peter Yin <peteryin.openbmc@gmail.com>
CC: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795760436; l=3487;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=61bYkC444y6LURoBfsYDeMvfueN3HRxEzlGVlaACKDY=;
 b=FdCau5Fvp3+HsyVTTucMRi5NsIe6YzcG+tMM4dNypDzwIJwK/IsTiZez6gljMhHu+1liAhf4p
 1i7ZbgmrXnJCYb3xzdlngYtdQ1v/V/v8w6RdRquc9n2VFq0tKG/ivPU
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Commit f26ecaa0f0ab ("i3c: master: dw-i3c: Fix missing of_node for
virtual I2C adapter") made the DesignWare I3C master's virtual legacy
I2C adapter reuse the I3C bus platform device's of_node, so consumers
can resolve the adapter by phandle. i2c_register_adapter() reacts to
any adapter with a non-NULL of_node by unconditionally calling
of_i2c_register_devices(), which walks every child of that node and
requires a "compatible" property to build a modalias.

The I3C core already owns and fully parses every child of the bus node
via fwnode_populate_i3c_bus()/i3c_master_add_of_dev(), for both native
I3C devices (no "compatible" needed per the i3c.yaml binding) and
legacy-I2C-under-I3C devices (registered explicitly through
master->boardinfo.i2c in i3c_master_i2c_adapter_init()). Since neither
path marks the node OF_POPULATED, the generic of_i2c_register_devices()
walk that now runs afterwards treats every child as unclaimed:

 - native I3C-only nodes have no "compatible", so of_i2c_get_board_info()
   fails the modalias lookup and logs "of_i2c: modalias failure" /
   "Failed to create I2C device" noise for a device that is already
   correctly registered on the I3C bus.

 - legacy-I2C nodes do have "compatible", so of_i2c_register_devices()
   silently creates a duplicate i2c_client for the same address that
   i3c_master_i2c_adapter_init() also registers from boardinfo.i2c.

Mark each OF bus child OF_POPULATED once i3c_master_add_of_dev() has
accounted for it. ACPI-described children are left untouched, since
OF_POPULATED and of_i2c_register_devices() only apply to the
devicetree case. fwnode_populate_i3c_bus() always runs before the I2C
adapter is registered, so of_i2c_register_devices() sees the flag
already set and skips these nodes entirely, without disturbing the
of_node propagation from f26ecaa0f0ab.

Fixes: f26ecaa0f0ab ("i3c: master: dw-i3c: Fix missing of_node for virtual I2C adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 01e05bad8661..f025c9e9a046 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -3353,15 +3353,25 @@ static int fwnode_populate_i3c_bus(struct i3c_master_controller *master)
 		return 0;
 
 	fwnode_for_each_available_child_node_scoped(fwnode, child) {
-		if (is_of_node(child))
+		if (is_of_node(child)) {
 			ret = i3c_master_add_of_dev(master, child);
-		else if (is_acpi_device_node(child))
-			ret = i3c_master_add_acpi_dev(master, child);
-		else
-			continue;
+			if (ret)
+				return ret;
 
-		if (ret)
-			return ret;
+			/*
+			 * Claim the node so that i2c_register_adapter(),
+			 * called later for the legacy I2C adapter sharing
+			 * this same of_node, does not also run
+			 * of_i2c_register_devices() on it: every child here
+			 * is already fully accounted for, whether it ends up
+			 * I3C or legacy-I2C boardinfo.
+			 */
+			of_node_set_flag(to_of_node(child), OF_POPULATED);
+		} else if (is_acpi_device_node(child)) {
+			ret = i3c_master_add_acpi_dev(master, child);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/*

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261127-i3c-master-of-populated-2ef07c2bb743

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

