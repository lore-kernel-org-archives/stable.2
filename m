Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762698;
	b=atXpMji5rYo9pwIyplIdKjKJCD9TQvx51mCjJ81MEPt3P0kiQNiA/Aesp7wRztv+7AYW
	 idFSdLTz2s1MaZyxw1os9B5jKbKiISWy0jTUcTwOXEPhLYdznT29/kWa7WMj3c33fNmzt
	 RDkn17KQOBFfP/Wza/VFBSS54eTbxovdwKhI0kPM4UTcomow714+5DFJTs3KfDFRl8XoI
	 0neSuAxy7370JfPEe2KpdraWLHFn0CepwAgHuckKcCoKM7Ryt5QYFD95QByCx43tlvATL
	 eyNZeKI6m9Z3tIRlHzIJPdtgh0EFqDBOt1GV/EvEaeWYv136yEGKaRtqX2j+JCuOs9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762698;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0YHH0z5wEvyXaDp5uYl1UGhjHY32xNYTV/Ur4hUBJF4=;
	b=Yh8EZyR9ErOpulkT3Q0V+pFz9sfiMfeQDSPBRcRew3m4LZy8QXH9++6a7r29qB6Gm6ok
	 oPT/0jecDR7d0MXQNAX4Ht4zIc4pOQ7dJ35TLPeAgNOAZ3Wtnkh55V5KA5mifns/nfeV+
	 u6pMcA5YsqLcCrP8lWzRMRhNp9hY+1uwWa7LDBBNBvAtEPuyIrIOVAdvofFpIAgJAHweJ
	 7cw/7dqiIfFrRAqbes6DHxeMK/5G2IXGA6or4KMUcHazASez7N47xASGNN/il6DL9szig
	 qMgwj0O6r7RnBeDdIE7MInQBbAr8MaJIkiiqJmy7MhU725S/6XlM/r7wF6fUgPxeuCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FD606A31E;
	Fri, 27 Nov 2026 06:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706FD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 27 Nov
 2026 14:58:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 27 Nov 2026 14:58:16 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 27 Nov 2026 14:58:15 +0800
Subject: [PATCH v2] i3c: master: mark OF bus child nodes OF_POPULATED to
 avoid legacy I2C rescan
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
Message-ID: <20261127-i3c-master-of-populated-v2-1-c52095d00218@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAAYqCWsC/4WNQQ6CMBBFr0Jm7Rg6CARX3sOwKO0gkwht2ko0h
 LtbuYDL95L//gaRg3CEa7FB4FWiuCUDnQowk14ejGIzA5XUKEUtSmVw1jFxQDeid/711IktEo9
 la2gY2ksFee0Dj/I+yvc+8yQxufA5jlb1s/+bq0KF1FnSja7rsjM3HT2zTWyms3Ez9Pu+fwFG/
 VRgwwAAAA==
X-Change-ID: 20261127-i3c-master-of-populated-2ef07c2bb743
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Peter Yin <peteryin.openbmc@gmail.com>
CC: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795762696; l=6039;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=xY5ZfoNHCn0aTxv+yky7pXKjzC/vhosSIilqhNBKimc=;
 b=2tKXCBdJQRK7HHXTH711lmTSeGEbyHLwF3LspHhh2+F5wlk8xzfkltR4bWR/mCNu5y4N7wfJp
 oni3Jk9XurNCz+nEZCJCQ90ox5tggushBOCG/V3p2mpHqcO2UNbI0yk
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

OF_POPULATED is a property of the device_node itself, which outlives
this master's registration. fwnode_depopulate_i3c_bus() is the
counterpart that clears the flag again, called from
i3c_master_bus_cleanup() (shared by the registration error path and
i3c_master_unregister()) and from fwnode_populate_i3c_bus()'s own
error path. Without it, the nodes stay claimed after this master is
unbound or fails to register, and a later re-probe or rebind finds
them already marked and silently skips creating their devices.

Fixes: f26ecaa0f0ab ("i3c: master: dw-i3c: Fix missing of_node for virtual I2C adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v2:
- Also clear OF_POPULATED again on teardown and on a mid-loop probe
  failure (fwnode_depopulate_i3c_bus(), called from
  i3c_master_bus_cleanup() and from fwnode_populate_i3c_bus()'s own
  error path), so unregister/rebind and a failed probe do not leave OF
  bus children permanently marked.
- Link to v1: https://lore.kernel.org/r/20261127-i3c-master-of-populated-v1-1-29d2a6a5509c@aspeedtech.com
---
 drivers/i3c/master.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 01e05bad8661..e85307678fdc 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2667,6 +2667,8 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	return ret;
 }
 
+static void fwnode_depopulate_i3c_bus(struct i3c_master_controller *master);
+
 static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
 {
 	if (master->ops->bus_cleanup) {
@@ -2681,6 +2683,7 @@ static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
 		}
 	}
 
+	fwnode_depopulate_i3c_bus(master);
 	i3c_master_detach_free_devs(master);
 }
 
@@ -3353,15 +3356,29 @@ static int fwnode_populate_i3c_bus(struct i3c_master_controller *master)
 		return 0;
 
 	fwnode_for_each_available_child_node_scoped(fwnode, child) {
-		if (is_of_node(child))
+		if (is_of_node(child)) {
 			ret = i3c_master_add_of_dev(master, child);
-		else if (is_acpi_device_node(child))
-			ret = i3c_master_add_acpi_dev(master, child);
-		else
-			continue;
+			if (ret) {
+				fwnode_depopulate_i3c_bus(master);
+				return ret;
+			}
 
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
+			if (ret) {
+				fwnode_depopulate_i3c_bus(master);
+				return ret;
+			}
+		}
 	}
 
 	/*
@@ -3378,6 +3395,26 @@ static int fwnode_populate_i3c_bus(struct i3c_master_controller *master)
 	return 0;
 }
 
+/*
+ * Counterpart to fwnode_populate_i3c_bus(): drop the OF_POPULATED claim on
+ * every OF bus child so a later re-probe of this master, or the legacy I2C
+ * adapter's of_i2c_register_devices() walk on a different master sharing
+ * the same of_node, does not find these nodes permanently locked out.
+ * ACPI-described children were never marked, so they are skipped here too.
+ */
+static void fwnode_depopulate_i3c_bus(struct i3c_master_controller *master)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&master->dev);
+
+	if (!fwnode)
+		return;
+
+	fwnode_for_each_available_child_node_scoped(fwnode, child) {
+		if (is_of_node(child))
+			of_node_clear_flag(to_of_node(child), OF_POPULATED);
+	}
+}
+
 static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
 				       struct i2c_msg *xfers, int nxfers)
 {

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261127-i3c-master-of-populated-2ef07c2bb743

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

