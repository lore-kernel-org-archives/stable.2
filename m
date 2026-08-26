Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836F3A0E8E
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770132; cv=none; b=hEjg2yumzKxxUiavNLqu77Z68nnzBoLnKNo0b7OLxm4t1OgQG/faMAAkdnYYCcav+yjCnMHoRGn5l2/3be/SjasEqf+qIB9jcTKDFyqIAuoM86Gy1mnLmtIWAiCsTBhgjaAxSBUSWjwJGktL3iUdLQ61sxF0q0wFpleDUjkk8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770132; c=relaxed/simple;
	bh=7GXSiuMcmBT70yu2YVgq3ucJnrVNFCKGAttFE10kGQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5sPuMQ/yVAcBNvr+JnSSLFXWptN780xQv+yVzbjcrFDCNzdLtNy9VIw2FykX7FXmvZuaMQ/WdDDd6UoatOOyr+JAj5yKI7bxBP++Ggz3BcxYCvdk6KxPhsUVi5TOArjQXf9IpfosLhZ1Ch0dSzzC+/JKkmKktw7WVVRB6Bsiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+X5nSOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+X5nSOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7030F1F00A3A;
	Wed, 26 Aug 2026 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787770117;
	bh=K59FokJXk2n/F2JWNyU8nZVNGYVH1uaUDbxVID+Ef7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+X5nSOrh0E9YXKuQsf5dU0Gh67tgVRan6LU1hAPxfOL45gFzJb9yr7RtX4YKKG5z
	 0e18C/E9FyN1td+E9RFy8cuf5lv/jVvjqo0cF/NELsUgIkKL81n8FLJrwnVoVAgSXD
	 gNWz7mGvEx7MB3vM4j0FEuAkeRBZUf5k/1MPjDQ7FyZOOHMdF773F0NJVN39w/q2Q4
	 HZYV0dZolf6Vg74GOFRMLRRM0H80/Jlr1FN5xaa6fxj9SmKxBASTKW5AtL8n/zyvAd
	 yZ17Pixj3K/iAPbh+3DLrmQAtTgoA4wh5V1DoiVfnQvsIxLXtqzjIV2V/2zzSSteB4
	 oyejICbi2Hpnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
Date: Wed, 26 Aug 2026 14:48:31 -0400
Message-ID: <20260826184834.3559828-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826184834.3559828-1-sashal@kernel.org>
References: <2026082559-suspect-staff-6aaa@gregkh>
 <20260826184834.3559828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 71e9588435c38112d6a8686d3d8e7cc1de8fe22c ]

The order of CIS handle array in Set CIG Parameters response shall match
the order of the CIS_ID array in the command (Core v5.3 Vol 4 Part E Sec
7.8.97).  We send CIS_IDs mainly in the order of increasing CIS_ID (but
with "last" CIS first if it has fixed CIG_ID).  In handling of the
reply, we currently assume this is also the same as the order of
hci_conn in hdev->conn_hash, but that is not true.

Match the correct hci_conn to the correct handle by matching them based
on the CIG+CIS combination.  The CIG+CIS combination shall be unique for
ISO_LINK hci_conn at state >= BT_BOUND, which we maintain in
hci_le_set_cig_params.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 0acd4eeb4b22 ("Bluetooth: hci_event: validate LE Set CIG Parameters response")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  7 +++---
 net/bluetooth/hci_conn.c         |  4 +--
 net/bluetooth/hci_event.c        | 43 +++++++++++++++++++-------------
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4f47f9ff25b30..62609d228e809 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1192,14 +1192,15 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 			continue;
 
 		/* Match CIG ID if set */
-		if (cig != BT_ISO_QOS_CIG_UNSET && cig != c->iso_qos.ucast.cig)
+		if (cig != BT_ISO_QOS_CIG_UNSET && cig != c->iso_qos.cig)
 			continue;
 
 		/* Match CIS ID if set */
-		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
+		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.cis)
 			continue;
 
-		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
+		/* Match destination address if set */
+		if (!ba || (ba_type == c->dst_type && !bacmp(&c->dst, ba))) {
 			rcu_read_unlock();
 			return c;
 		}
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d7cc13644b367..eb6519d85df69 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1862,8 +1862,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *cis;
 
-	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.cig,
-				       qos->ucast.cis);
+	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->cig,
+				       qos->cis);
 	if (!cis) {
 		cis = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
 		if (!cis)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1ada32d54623f..9ddfcf8446e67 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3783,49 +3783,58 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
 	struct hci_rp_le_set_cig_params *rp = data;
+	struct hci_cp_le_set_cig_params *cp;
 	struct hci_conn *conn;
-	int i = 0;
+	u8 status = rp->status;
+	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
+	if (!cp || rp->num_handles != cp->num_cis || rp->cig_id != cp->cig_id) {
+		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
+		status = HCI_ERROR_UNSPECIFIED;
+	}
+
 	hci_dev_lock(hdev);
 
-	if (rp->status) {
+	if (status) {
 		while ((conn = hci_conn_hash_lookup_cig(hdev, rp->cig_id))) {
 			conn->state = BT_CLOSED;
-			hci_connect_cfm(conn, rp->status);
+			hci_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
 		goto unlock;
 	}
 
-	rcu_read_lock();
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2553
+	 *
+	 * If the Status return parameter is zero, then the Controller shall
+	 * set the Connection_Handle arrayed return parameter to the connection
+	 * handle(s) corresponding to the CIS configurations specified in
+	 * the CIS_IDs command parameter, in the same order.
+	 */
+	for (i = 0; i < rp->num_handles; ++i) {
+		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, rp->cig_id,
+						cp->cis[i].cis_id);
+		if (!conn || !bacmp(&conn->dst, BDADDR_ANY))
+			continue;
 
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (conn->type != ISO_LINK || conn->iso_qos.cig != rp->cig_id ||
-		    conn->state == BT_CONNECTED)
+		if (conn->state != BT_BOUND && conn->state != BT_CONNECT)
 			continue;
 
 		if (HCI_CONN_HANDLE_UNSET(conn->handle))
 			ida_free(&hdev->unset_handle_ida, conn->handle);
-		conn->handle = __le16_to_cpu(rp->handle[i++]);
+		conn->handle = __le16_to_cpu(rp->handle[i]);
 
 		bt_dev_dbg(hdev, "%p handle 0x%4.4x link %p", conn,
 			   conn->handle, conn->link);
 
 		/* Create CIS if LE is already connected */
-		if (conn->link && conn->link->state == BT_CONNECTED) {
-			rcu_read_unlock();
+		if (conn->link && conn->link->state == BT_CONNECTED)
 			hci_le_create_cis(conn->link);
-			rcu_read_lock();
-		}
-
-		if (i == rp->num_handles)
-			break;
 	}
 
-	rcu_read_unlock();
-
 unlock:
 	hci_dev_unlock(hdev);
 
-- 
2.53.0

