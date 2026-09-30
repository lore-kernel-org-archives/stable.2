Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2644F96C4
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782297; cv=none; b=ScEv49mmrLy0prR16vJ+moJfsTCvh2WDgIj6J7uEYZjFmsZpZX0x57uGUwAGW971kxpjeziXLMLRsO1amerrLGfXLEpR1Cyz0xVLs+vooK7316brYy40quRUcryGPAqOlHC3fCj+Kw7areOD6/1rW/xWej9g7p/jK7IFEWT42J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782297; c=relaxed/simple;
	bh=YaEkY7Prkm1t+dOiRdb9Jmao+BYlzcsJacUbsOBSR4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM1V9UxTlr2Gw/GERwdxVRTkMa/ctZpCFIaqfdtn4DVws1V8YW03hObofniZsBeTeE1wsC4t+7Y/1qRPPKTTkFuQx6iFDdxp9M/pZ2GO2BgC463HG5Kdwb4j1RxE6bcr/AJlWJFpUaY6IFdWoiDxDKzltWghnH7Omme24nsgvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZqMfig6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZqMfig6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606461F00899;
	Wed, 30 Sep 2026 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782278;
	bh=lZCSLNY+RXTedXQ3watki34xMJQwJ22kmUjlREokVp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZqMfig6CQvIrCemCAspncz99v0pFOl3cKie5vrdeogvLT3fO9Z63yLftBNfww/Wc
	 0+RrUbte98h/FlWyXyXcnSEGsLqKPRqAbOt2tiLEt6T8oH82YFwrpQMlLWrTGhi/kj
	 CcDAd4PgTEBEUvvOiYsDxGCu4PY9hHTq72vo5gzZgguJvdQGbRcdjjXVHp04jukThV
	 NOrkQ2mNTTSuV7fyDmEYtI0F0aZLIdxB+7kJRj00WON/1em2P7qknA/OpcUL1vioyu
	 nrT6V91rkFW9lH3g72wdZIp9RoCTNPf5B3FcTKGWYsWgitUr6Z/im6cp6A+Nwpyn+D
	 vEvxC/g75DyLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings
Date: Wed, 30 Sep 2026 11:31:14 -0400
Message-ID: <20260930153116.2781860-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930153116.2781860-1-sashal@kernel.org>
References: <2026092936-wildlife-vengeful-86d9@gregkh>
 <20260930153116.2781860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 709788b154caf042874d765628ffa860f0bb0d1e ]

{cis,bis}_capable only indicates the controller supports the feature
since it doesn't check that LE is enabled so it shall not be used for
current setting, instead this introduces {cis,bis}_enabled macros that
can be used to indicate that these features are currently enabled.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Fixes: ae7533613133 ("Bluetooth: Check for ISO support in controller")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 0fcd4dad555c ("Bluetooth: ISO: release unused CIS holds after channel attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/bluetooth.h |  4 ++--
 include/net/bluetooth/hci_core.h  | 13 ++++++++++++-
 net/bluetooth/hci_sync.c          |  4 ++--
 net/bluetooth/iso.c               | 14 +++++++-------
 net/bluetooth/mgmt.c              | 10 +++++-----
 5 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 32701b5fedafc..f0193e3bbc523 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -634,7 +634,7 @@ static inline void sco_exit(void)
 #if IS_ENABLED(CONFIG_BT_LE)
 int iso_init(void);
 int iso_exit(void);
-bool iso_enabled(void);
+bool iso_inited(void);
 #else
 static inline int iso_init(void)
 {
@@ -646,7 +646,7 @@ static inline int iso_exit(void)
 	return 0;
 }
 
-static inline bool iso_enabled(void)
+static inline bool iso_inited(void)
 {
 	return false;
 }
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4ed681b2dafea..4b9f3a6591b9f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1950,6 +1950,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 				!hci_dev_test_flag(dev, HCI_RPA_EXPIRED))
 #define adv_rpa_valid(adv)     (bacmp(&adv->random_addr, BDADDR_ANY) && \
 				!adv->rpa_expired)
+#define le_enabled(dev)        (lmp_le_capable(dev) && \
+				hci_dev_test_flag(dev, HCI_LE_ENABLED))
 
 #define scan_1m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_1M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_1M))
@@ -2020,14 +2022,23 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 /* CIS Master/Slave and BIS support */
 #define iso_capable(dev) (cis_capable(dev) || bis_capable(dev))
+#define iso_enabled(dev) (le_enabled(dev) && iso_capable(dev))
 #define cis_capable(dev) \
 	(cis_central_capable(dev) || cis_peripheral_capable(dev))
+#define cis_enabled(dev) (le_enabled(dev) && cis_capable(dev))
 #define cis_central_capable(dev) \
 	((dev)->le_features[3] & HCI_LE_CIS_CENTRAL)
+#define cis_central_enabled(dev) \
+	(le_enabled(dev) && cis_central_capable(dev))
 #define cis_peripheral_capable(dev) \
 	((dev)->le_features[3] & HCI_LE_CIS_PERIPHERAL)
+#define cis_peripheral_enabled(dev) \
+	(le_enabled(dev) && cis_peripheral_capable(dev))
 #define bis_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_BROADCASTER)
-#define sync_recv_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
+#define bis_enabled(dev) (le_enabled(dev) && bis_capable(dev))
+#define sync_recv_capable(dev) \
+	((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
+#define sync_recv_enabled(dev) (le_enabled(dev) && sync_recv_capable(dev))
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!test_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &(dev)->quirks)))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index cc2b0b85426f3..ff44e838e557a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4651,14 +4651,14 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!cis_capable(hdev))
+	if (!iso_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
 
 	/* Connected Isochronous Channels (Host Support) */
 	cp.bit_number = 32;
-	cp.bit_value = 1;
+	cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 52d8dcebb7828..b2a4cb12b6b70 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2499,11 +2499,11 @@ static const struct net_proto_family iso_sock_family_ops = {
 	.create	= iso_sock_create,
 };
 
-static bool iso_inited;
+static bool inited;
 
-bool iso_enabled(void)
+bool iso_inited(void)
 {
-	return iso_inited;
+	return inited;
 }
 
 int iso_init(void)
@@ -2512,7 +2512,7 @@ int iso_init(void)
 
 	BUILD_BUG_ON(sizeof(struct sockaddr_iso) > sizeof(struct sockaddr));
 
-	if (iso_inited)
+	if (inited)
 		return -EALREADY;
 
 	err = proto_register(&iso_proto, 0);
@@ -2540,7 +2540,7 @@ int iso_init(void)
 		iso_debugfs = debugfs_create_file("iso", 0444, bt_debugfs,
 						  NULL, &iso_debugfs_fops);
 
-	iso_inited = true;
+	inited = true;
 
 	return 0;
 
@@ -2551,7 +2551,7 @@ int iso_init(void)
 
 int iso_exit(void)
 {
-	if (!iso_inited)
+	if (!inited)
 		return -EALREADY;
 
 	bt_procfs_cleanup(&init_net, "iso");
@@ -2565,7 +2565,7 @@ int iso_exit(void)
 
 	proto_unregister(&iso_proto);
 
-	iso_inited = false;
+	inited = false;
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cdb2425a16a2c..28afc6f1ed195 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -920,16 +920,16 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
 		settings |= MGMT_SETTING_WIDEBAND_SPEECH;
 
-	if (cis_central_capable(hdev))
+	if (cis_central_enabled(hdev))
 		settings |= MGMT_SETTING_CIS_CENTRAL;
 
-	if (cis_peripheral_capable(hdev))
+	if (cis_peripheral_enabled(hdev))
 		settings |= MGMT_SETTING_CIS_PERIPHERAL;
 
-	if (bis_capable(hdev))
+	if (bis_enabled(hdev))
 		settings |= MGMT_SETTING_ISO_BROADCASTER;
 
-	if (sync_recv_capable(hdev))
+	if (sync_recv_enabled(hdev))
 		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
 
 	return settings;
@@ -4613,7 +4613,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (IS_ENABLED(CONFIG_BT_LE)) {
-		flags = iso_enabled() ? BIT(0) : 0;
+		flags = iso_inited() ? BIT(0) : 0;
 		memcpy(rp->features[idx].uuid, iso_socket_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
 		idx++;
-- 
2.53.0

