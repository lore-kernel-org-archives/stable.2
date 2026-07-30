Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEF54652
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373101; cv=none; b=PzwxBWN2Ib1jw8HjuIqsEHNhGhgJlaNvUpxdHhpTD8JwZB9WPCpq8hqHSpcm6qxmgc6Yk6gfw+NWwmoXuphMW34ZaJp64khvFV79+pk/zQUba4NSpMA5A6ZxUTNJHc6FRpNIy5sOpzaO5r0M4wmooY6WB8Mb37TjQnKEvMf4wl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373101; c=relaxed/simple;
	bh=p907utAok3Cogx/SiOy7dVzf9AIi4tUpQSGGU7sXYCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvvAICEDPh47IrFFNa57DOHIuuV5Z0ZPGMLJl0bSYK7wkxji+FXD0LKFNIzWsz4jWYCu+ViKrxPS/qElghOwuOHuDk6cjgazK2bMOvSrxd1Ww+JUq1yIEWW4QKpEAmJXsYyUe+9fhCxZVhF3lUCH2EVpn9tlr7UXEnf+B0E7T08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfN5/pWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfN5/pWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82331F000E9;
	Thu, 30 Jul 2026 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373099;
	bh=nFe+rq6TnsXGy3S3AcqWd920jpVZ2Nr0oZt734RTD9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZfN5/pWGglnXYZwsu/fa+kKW1N9escMUK5eVMgcVeWS3KmV3YV57qvfHkJ+dH5hwJ
	 btxvDjDynBu2Fzjz7sHk8bUkc29DWC/WrGC6FKjCRRwd54GYWe7up68+Lyf6I605je
	 LvlYSki2c8MmJuVVo+lTKZVDSeNpLP59Zcdz3YyO7Jxe1GdAN5y1uR7HjLlDd9dVXI
	 hcdSOQluB/N1QJMOAQuOzOS7At9i4a6GFda/deM7sBxDLuA7st1EWVb2pQJFi0JXb7
	 2miuKITeeoR495TvoJW0qV6QuB+ODN1DTIljVL4XHsDhOY5vxi7+hTnBMcX6bW7O3X
	 NzBhz7m88Fw4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Li <yang.li@amlogic.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections
Date: Wed, 29 Jul 2026 20:58:16 -0400
Message-ID: <20260730005817.1696365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072158-wired-pamperer-25c0@gregkh>
References: <2026072158-wired-pamperer-25c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.li@amlogic.com>

[ Upstream commit a7bcffc673de219af2698fbb90627016233de67b ]

Currently, BIS_LINK is used for both BIG sync and PA sync connections,
which makes it impossible to distinguish them when searching for a PA
sync connection.

Adding PA_LINK will make the distinction clearer and simplify future
extensions for PA-related features.

Signed-off-by: Yang Li <yang.li@amlogic.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 9d4b01a0bf8d ("Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h | 10 +++++++---
 net/bluetooth/hci_conn.c         | 13 ++++++++-----
 net/bluetooth/hci_core.c         | 27 +++++++++++++++------------
 net/bluetooth/hci_event.c        |  7 ++++---
 net/bluetooth/hci_sync.c         | 10 +++++-----
 net/bluetooth/iso.c              |  6 ++++--
 net/bluetooth/mgmt.c             |  1 +
 8 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4f649010223951..4a3c99d1aabc10 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -560,6 +560,7 @@ enum {
 #define LE_LINK		0x80
 #define CIS_LINK	0x82
 #define BIS_LINK	0x83
+#define PA_LINK		0x84
 #define INVALID_LINK	0xff
 
 /* LMP features */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c9ec63ab6a6c4a..f660cab086e65f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1001,6 +1001,7 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		h->iso_num++;
 		break;
 	}
@@ -1028,6 +1029,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		h->iso_num--;
 		break;
 	}
@@ -1046,6 +1048,7 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 		return h->sco_num;
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		return h->iso_num;
 	default:
 		return 0;
@@ -1128,7 +1131,7 @@ hci_conn_hash_lookup_create_pa_sync(struct hci_dev *hdev)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != BIS_LINK)
+		if (c->type != PA_LINK)
 			continue;
 
 		if (!test_bit(HCI_CONN_CREATE_PA_SYNC, &c->flags))
@@ -1344,7 +1347,7 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != BIS_LINK)
+		if (c->type != PA_LINK)
 			continue;
 
 		if (handle == c->iso_qos.bcast.big && num_bis == c->num_bis) {
@@ -1413,7 +1416,7 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != BIS_LINK)
+		if (c->type != PA_LINK)
 			continue;
 
 		/* Ignore the listen hcon, we are looking
@@ -2025,6 +2028,7 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		return iso_connect_ind(hdev, bdaddr, flags);
 
 	default:
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 17b0cd1c2b5241..b62da619913b50 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -785,7 +785,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 	d->sync_handle = conn->sync_handle;
 
 	if (test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags)) {
-		hci_conn_hash_list_flag(hdev, find_bis, BIS_LINK,
+		hci_conn_hash_list_flag(hdev, find_bis, PA_LINK,
 					HCI_CONN_PA_SYNC, d);
 
 		if (!d->count)
@@ -914,6 +914,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		if (hdev->iso_mtu)
 			/* Dedicated ISO Buffer exists */
 			break;
@@ -980,6 +981,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 
@@ -1033,7 +1035,6 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 	}
 
 	hci_conn_init_sysfs(conn);
-
 	return conn;
 }
 
@@ -1077,6 +1078,7 @@ static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		if ((conn->state != BT_CONNECTED &&
 		    !test_bit(HCI_CONN_CREATE_CIS, &conn->flags)) ||
 		    test_bit(HCI_CONN_BIG_CREATED, &conn->flags))
@@ -1152,7 +1154,8 @@ void hci_conn_del(struct hci_conn *conn)
 	} else {
 		/* Unacked ISO frames */
 		if (conn->type == CIS_LINK ||
-		    conn->type == BIS_LINK) {
+		    conn->type == BIS_LINK ||
+		    conn->type == PA_LINK) {
 			if (hdev->iso_pkts)
 				hdev->iso_cnt += conn->sent;
 			else if (hdev->le_pkts)
@@ -2089,7 +2092,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 
 	bt_dev_dbg(hdev, "dst %pMR type %d sid %d", dst, dst_type, sid);
 
-	conn = hci_conn_add_unset(hdev, BIS_LINK, dst, HCI_ROLE_SLAVE);
+	conn = hci_conn_add_unset(hdev, PA_LINK, dst, HCI_ROLE_SLAVE);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -2266,7 +2269,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	 * the start periodic advertising and create BIG commands have
 	 * been queued
 	 */
-	hci_conn_hash_list_state(hdev, bis_mark_per_adv, BIS_LINK,
+	hci_conn_hash_list_state(hdev, bis_mark_per_adv, PA_LINK,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb93ff8f1e73bc..45517fca81018d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2960,12 +2960,14 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	case HCI_ACLDATA_PKT:
 		/* Detect if ISO packet has been sent as ACL */
 		if (hci_conn_num(hdev, CIS_LINK) ||
-		    hci_conn_num(hdev, BIS_LINK)) {
+		    hci_conn_num(hdev, BIS_LINK) ||
+			hci_conn_num(hdev, PA_LINK)) {
 			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 			__u8 type;
 
 			type = hci_conn_lookup_type(hdev, hci_handle(handle));
-			if (type == CIS_LINK || type == BIS_LINK)
+			if (type == CIS_LINK || type == BIS_LINK ||
+			    type == PA_LINK)
 				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
 		}
 		break;
@@ -3402,6 +3404,7 @@ static inline void hci_quote_sent(struct hci_conn *conn, int num, int *quote)
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 		cnt = hdev->iso_mtu ? hdev->iso_cnt :
 			hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
 		break;
@@ -3415,7 +3418,7 @@ static inline void hci_quote_sent(struct hci_conn *conn, int num, int *quote)
 }
 
 static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
-				     __u8 type2, int *quote)
+				     int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn = NULL, *c;
@@ -3427,7 +3430,7 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if ((c->type != type && c->type != type2) ||
+		if (c->type != type ||
 		    skb_queue_empty(&c->data_q))
 			continue;
 
@@ -3631,7 +3634,7 @@ static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
 	else
 		cnt = &hdev->sco_cnt;
 
-	while (*cnt && (conn = hci_low_sent(hdev, type, type, &quote))) {
+	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
@@ -3750,8 +3753,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
-/* Schedule CIS */
-static void hci_sched_iso(struct hci_dev *hdev)
+/* Schedule iso */
+static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
@@ -3759,14 +3762,12 @@ static void hci_sched_iso(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!hci_conn_num(hdev, CIS_LINK) &&
-	    !hci_conn_num(hdev, BIS_LINK))
+	if (!hci_conn_num(hdev, type))
 		return;
 
 	cnt = hdev->iso_pkts ? &hdev->iso_cnt :
 		hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
-	while (*cnt && (conn = hci_low_sent(hdev, CIS_LINK, BIS_LINK,
-					    &quote))) {
+	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
@@ -3791,7 +3792,9 @@ static void hci_tx_work(struct work_struct *work)
 		/* Schedule queues and send stuff to HCI driver */
 		hci_sched_sco(hdev, SCO_LINK);
 		hci_sched_sco(hdev, ESCO_LINK);
-		hci_sched_iso(hdev);
+		hci_sched_iso(hdev, CIS_LINK);
+		hci_sched_iso(hdev, BIS_LINK);
+		hci_sched_iso(hdev, PA_LINK);
 		hci_sched_acl(hdev);
 		hci_sched_le(hdev);
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fbd63e51b49386..8901ed1b4606b8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4455,6 +4455,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 		case CIS_LINK:
 		case BIS_LINK:
+		case PA_LINK:
 			if (hdev->iso_pkts) {
 				hdev->iso_cnt += count;
 				if (hdev->iso_cnt > hdev->iso_pkts)
@@ -6421,7 +6422,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	conn->sync_handle = le16_to_cpu(ev->handle);
 	conn->sid = HCI_SID_INVALID;
 
-	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, BIS_LINK,
+	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, PA_LINK,
 				      &flags);
 	if (!(mask & HCI_LM_ACCEPT)) {
 		hci_le_pa_term_sync(hdev, ev->handle);
@@ -6432,7 +6433,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 
 	/* Add connection to indicate PA sync event */
-	pa_sync = hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
+	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
 				     HCI_ROLE_SLAVE);
 
 	if (IS_ERR(pa_sync))
@@ -6463,7 +6464,7 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
+	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, PA_LINK, &flags);
 	if (!(mask & HCI_LM_ACCEPT))
 		goto unlock;
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 661bbf06cf7f7b..a23ea811537a5f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2979,7 +2979,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 		if (sent) {
 			struct hci_conn *conn;
 
-			conn = hci_conn_hash_lookup_ba(hdev, BIS_LINK,
+			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
 						       &sent->bdaddr);
 			if (conn) {
 				struct bt_iso_qos *qos = &conn->iso_qos;
@@ -5543,7 +5543,7 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct hci_cp_disconnect cp;
 
-	if (conn->type == BIS_LINK) {
+	if (conn->type == BIS_LINK || conn->type == PA_LINK) {
 		/* This is a BIS connection, hci_conn_del will
 		 * do the necessary cleanup.
 		 */
@@ -5612,7 +5612,7 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		return HCI_ERROR_LOCAL_HOST_TERM;
 	}
 
-	if (conn->type == BIS_LINK) {
+	if (conn->type == BIS_LINK || conn->type == PA_LINK) {
 		/* There is no way to cancel a BIS without terminating the BIG
 		 * which is done later on connection cleanup.
 		 */
@@ -5677,7 +5677,7 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	if (conn->type == CIS_LINK)
 		return hci_le_reject_cis_sync(hdev, conn, reason);
 
-	if (conn->type == BIS_LINK)
+	if (conn->type == BIS_LINK || conn->type == PA_LINK)
 		return -EINVAL;
 
 	if (conn->type == SCO_LINK || conn->type == ESCO_LINK)
@@ -7148,7 +7148,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 		goto unlock;
 
 	/* Add connection to indicate PA sync error */
-	pa_sync = hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
+	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
 				     HCI_ROLE_SLAVE);
 
 	if (IS_ERR(pa_sync))
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 30c1002437800e..12a01dc6dbde37 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2211,7 +2211,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
-	if (hcon->type != CIS_LINK && hcon->type != BIS_LINK) {
+	if (hcon->type != CIS_LINK && hcon->type != BIS_LINK &&
+	    hcon->type != PA_LINK) {
 		if (hcon->type != LE_LINK)
 			return;
 
@@ -2252,7 +2253,8 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
-	if (hcon->type != CIS_LINK && hcon->type != BIS_LINK)
+	if (hcon->type != CIS_LINK && hcon->type !=  BIS_LINK &&
+	    hcon->type != PA_LINK)
 		return;
 
 	BT_DBG("hcon %p reason %d", hcon, reason);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6280fcfcdd0c6a..c0156de908eda5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3242,6 +3242,7 @@ static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
 	switch (link_type) {
 	case CIS_LINK:
 	case BIS_LINK:
+	case PA_LINK:
 	case LE_LINK:
 		switch (addr_type) {
 		case ADDR_LE_DEV_PUBLIC:
-- 
2.53.0

