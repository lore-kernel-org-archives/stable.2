Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E233D5660
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159733; cv=none; b=ERrN8Kd/3feCC1KsvNer3L2tAPgtVlPsOUdjPmVUuljbC5ZFrhiKbbbacA2aitrLd5dRE76/jxG4Aq3eBbBkdOVzUyLkEqK2frQMBjcnTzE4aPNKm89AXbuy7LXms8wvvNj5/wgUIGj+O8Mq5V8OqDbuGCN3RqP35xVD7hnDdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159733; c=relaxed/simple;
	bh=ty4gQ2OCE1P+tuwSecPGbjJi4F6FKgGwpi3skvaVYRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUz5qAYfprOL7c0DTcFoQzIR5UlgfN4T1KaZJ/Nu2ghwqq6cH8PTzAbYjPBz4Btbnvo2CvbNb0GpayHNczY4iX/WnxcXkVPbzg2Ivf+H3ZTmlk0keo65DCEhSeusZqHslPnh51bZl2q1tM8pZgbBLzR0vQPzvixOhQOLx6GQjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l274L3w0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l274L3w0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AD71F00A3A;
	Wed, 15 Jul 2026 23:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159731;
	bh=Cmeqb73OqZDpTedTqdFmBo7XzjhPJQg1aNfliB4HJnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l274L3w02E7XMcw1rDQeR14tpZIsC787Xn5YXySpJP4yXRtRv3SJyfQdJxTzBSMQI
	 DZSTh/uVogV2H2ao2xCSpXEmyjQM4zUfGrP+73e9+LWimUvsTNa1H9KNEsZSLWEJJ3
	 zQx2O86iYzR9D06AqzTia7mGPD4OUQM7I7ZKumgWlY86DiyTGWr3mKj1R+W3OYSqeX
	 kBFNLAtHJt3baUcnHyjnLLH25mVrhevzNufcUk8PV5COUloMb6ZJGatZcvVMUVbspp
	 0QBXJPglQ+LJuJCftqoo36xFLh+kWW9ZePhO1lcnW03dqKyT8WLllDozPvvs2eKH8C
	 tkLWa2q0AP/Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Wed, 15 Jul 2026 19:55:26 -0400
Message-ID: <20260715235529.525959-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071350-agent-mustard-7408@gregkh>
References: <2026071350-agent-mustard-7408@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 13218453521d75916dfed55efb8e809bfc03cb4b ]

This enables buffer flow control for SCO/eSCO
(see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
recently this has caused the following problem and is actually a nice
addition for the likes of Socket TX complete:

< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 5
        SCO MTU: 240  SCO max packet: 8
...
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
> HCI Event: Hardware Error (0x10) plen 1
        Code: 0x0a

To fix the code will now attempt to enable buffer flow control when
HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED is set by the driver:

< HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
        Flow control: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
        Status: Success (0x00)

On success then HCI_SCO_FLOWCTL would be set which indicates sco_cnt
shall be used for flow contro.

Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Pauli Virtanen <pav@iki.fi>
Stable-dep-of: 12917f591cea ("Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      | 13 +++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 62 +++++++++++++++-----------------
 net/bluetooth/hci_event.c        |  2 ++
 net/bluetooth/hci_sync.c         | 24 +++++++++++++
 5 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b25746b91986c2..fb82d6f395d418 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -206,6 +206,13 @@ enum {
 	 */
 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 
+	/* When this quirk is set consider Sync Flow Control as supported by
+	 * the driver.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED,
+
 	/* When this quirk is set, the controller has validated that
 	 * LE states reported through the HCI_LE_READ_SUPPORTED_STATES are
 	 * valid.  This mechanism is necessary as many controllers have
@@ -416,6 +423,7 @@ enum {
 	HCI_WIDEBAND_SPEECH_ENABLED,
 	HCI_EVENT_FILTER_CONFIGURED,
 	HCI_PA_SYNC,
+	HCI_SCO_FLOWCTL,
 
 	HCI_DUT_MODE,
 	HCI_VENDOR_DIAG,
@@ -1513,6 +1521,11 @@ struct hci_rp_read_tx_power {
 	__s8     tx_power;
 } __packed;
 
+#define HCI_OP_WRITE_SYNC_FLOWCTL	0x0c2f
+struct hci_cp_write_sync_flowctl {
+	__u8     enable;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_TYPE	0x0c46
 struct hci_rp_read_page_scan_type {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a2a6fb20f49647..623323a0f07c4a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1824,6 +1824,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
 #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
 #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
+#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
 #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ)
 #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
 #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BREDR))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 824208a53c251e..332a7f0da47e98 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3556,42 +3556,27 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 }
 
 /* Schedule SCO */
-static void hci_sched_sco(struct hci_dev *hdev)
+static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
-	int quote;
+	int quote, *cnt;
+	unsigned int pkts = hdev->sco_pkts;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "type %u", type);
 
-	if (!hci_conn_num(hdev, SCO_LINK))
+	if (!hci_conn_num(hdev, type) || !pkts)
 		return;
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
-
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
-		}
-	}
-}
-
-static void hci_sched_esco(struct hci_dev *hdev)
-{
-	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote;
-
-	BT_DBG("%s", hdev->name);
-
-	if (!hci_conn_num(hdev, ESCO_LINK))
-		return;
+	/* Use sco_pkts if flow control has not been enabled which will limit
+	 * the amount of buffer sent in a row.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		cnt = &pkts;
+	else
+		cnt = &hdev->sco_cnt;
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK,
-						     &quote))) {
+	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
@@ -3599,8 +3584,17 @@ static void hci_sched_esco(struct hci_dev *hdev)
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
+			(*cnt)--;
 		}
 	}
+
+	/* Rescheduled if all packets were sent and flow control is not enabled
+	 * as there could be more packets queued that could not be sent and
+	 * since no HCI_EV_NUM_COMP_PKTS event will be generated the reschedule
+	 * needs to be forced.
+	 */
+	if (!pkts && !hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
@@ -3636,8 +3630,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco(hdev, SCO_LINK);
+			hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3692,8 +3686,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco(hdev, SCO_LINK);
+			hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3738,8 +3732,8 @@ static void hci_tx_work(struct work_struct *work)
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
-		hci_sched_sco(hdev);
-		hci_sched_esco(hdev);
+		hci_sched_sco(hdev, SCO_LINK);
+		hci_sched_sco(hdev, ESCO_LINK);
 		hci_sched_iso(hdev);
 		hci_sched_acl(hdev);
 		hci_sched_le(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4607db3037bd91..e2b9a009bf59b2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4445,9 +4445,11 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 			break;
 
 		case SCO_LINK:
+		case ESCO_LINK:
 			hdev->sco_cnt += count;
 			if (hdev->sco_cnt > hdev->sco_pkts)
 				hdev->sco_cnt = hdev->sco_pkts;
+
 			break;
 
 		case ISO_LINK:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9da2acec6f7f02..31bd230089e12d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3877,6 +3877,28 @@ static int hci_write_ca_timeout_sync(struct hci_dev *hdev)
 				     sizeof(param), &param, HCI_CMD_TIMEOUT);
 }
 
+/* Enable SCO flow control if supported */
+static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_sync_flowctl cp;
+	int err;
+
+	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL */
+	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)) ||
+	    !test_bit(HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED, &hdev->quirks))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 0x01;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (!err)
+		hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
+
+	return err;
+}
+
 /* BR Controller init stage 2 command sequence */
 static const struct hci_init_stage br_init2[] = {
 	/* HCI_OP_READ_BUFFER_SIZE */
@@ -3895,6 +3917,8 @@ static const struct hci_init_stage br_init2[] = {
 	HCI_INIT(hci_clear_event_filter_sync),
 	/* HCI_OP_WRITE_CA_TIMEOUT */
 	HCI_INIT(hci_write_ca_timeout_sync),
+	/* HCI_OP_WRITE_SYNC_FLOWCTL */
+	HCI_INIT(hci_write_sync_flowctl_sync),
 	{}
 };
 
-- 
2.53.0

