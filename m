Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617334A76F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275492; cv=none; b=AmRQzK1p/B2xFthib6tR8X4Z8bY3Ev6fCMuSL9XwTjFdZ3AymGQZfzxrfhBPDtJt1hne9FjobNmRNpTEqoWgdXpi5PgYWmsOfSsngiumSgcVXXVeh2X8SdYQOXqvJ8hZYkU17/4HqMEMk+pTmhu+J8DPdaEt8p/tfS56S4Qzebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275492; c=relaxed/simple;
	bh=uPBvhV9B1Ngg44ZnlNzhrv+2p7NO90U5d5xqEHJ1wOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9qOd3YhJnR9PEd/5E6AyTGuvjAz9tdT30WAXCNqCmTZNZKBjnbU2VMQwauEOaPTfOD+JV9Fasw3w9m9VuN2LM6cbojDBZKZrqwSIAFA7IQdatAw7myvGgpu16GPLybsfoCiMLfwoL4EiFTRl9hLUXemnxzPswtu0ObfuAdHFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alRU4abT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alRU4abT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843E91F000FF;
	Tue,  6 Oct 2026 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791275490;
	bh=7xYeCfiADYpdkm/LBogBwRx4v8wrdLqWs1ZKbKw1GNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=alRU4abT3IeRlTLqwbBIBYi7zFlPRlkZK5XAPiSfKA4dq6ImdKcD/xtHrArKWSpcx
	 0wRAJi+ZHN1Q4ub5mll+UIyFEbnyOq2DC6A4Bj+dJqzesO7m6H5oIKrMvKhrDqlwx1
	 rnU0eJwKNzW1NGEJkii15aAGUdfoU4qIuR5a34CV8Z5L5DRSL1Bb6bYNVJ17s+xC3u
	 yXgsVIIT9O5gDdxKCkZ5r/FANnPESeVZBEOpSxmjOtz5seZo/zfFN40mHjRU9XaWTm
	 +A/oRMdpah+h57gtZ0BoJjPuyq7vcO2PreY10lVmMFUEaROt7T6nAMC3ICqKa5R/Nj
	 LZ2hh0X3XZ3BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] Bluetooth: hci_conn: Only do ACL connections sequentially
Date: Tue,  6 Oct 2026 04:31:23 -0400
Message-ID: <20261006082552.3871603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100541-valid-olive-13c3@gregkh>
References: <2026100541-valid-olive-13c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Dreßler <verdre@v0yd.nl>

[ Upstream commit 45340097ce6ea7e875674a5a7d24c95ecbc93ef9 ]

Pretty much all bluetooth chipsets only support paging a single device at
a time, and if they don't reject a secondary "Create Connection" request
while another is still ongoing, they'll most likely serialize those
requests in the firware.

With commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
requests") we started adding some serialization of our own in case the
adapter returns "Command Disallowed" HCI error.

This commit was using the BT_CONNECT2 state for the serialization, this
state is also used for a few more things (most notably to indicate we're
waiting for an inquiry to cancel) and therefore a bit unreliable. Also
not all BT firwares would respond with "Command Disallowed" on too many
connection requests, some will also respond with "Hardware Failure"
(BCM4378), and others will error out later and send a "Connect Complete"
event with error "Rejected Limited Resources" (Marvell 88W8897).

We can clean things up a bit and also make the serialization more reliable
by using our hci_sync machinery to always do "Create Connection" requests
in a sequential manner.

This is very similar to what we're already doing for establishing LE
connections, and it works well there.

Note that this causes a test failure in mgmt-tester (test "Pair Device
- Power off 1") because the hci_abort_conn_sync() changes the error we
return on timeout of the "Create Connection". We'll fix this on the
mgmt-tester side by adjusting the expected error for the test.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Retain the existing LE scan cleanup helpers when removing the old ACL
connection implementation. They remain in use for deferred connection
cleanup and are unrelated to ACL request serialization.

Stable-dep-of: 8ed67535fdff ("Bluetooth: hci_sync: Fix inquiry cache use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_sync.h |  3 ++
 net/bluetooth/hci_conn.c         | 69 ++++---------------------------
 net/bluetooth/hci_sync.c         | 70 ++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fcab978894b12..847e7d3de5913 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -410,6 +410,7 @@ enum {
 #define HCI_NCMD_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
+#define HCI_ACL_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 012ac6db29fd7..0b44c4f70a075 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -166,3 +166,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason);
 int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
+
+int hci_acl_create_connection_sync(struct hci_dev *hdev,
+				   struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 55b9f3e713f72..5fa2a66d4a8d4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -227,64 +227,6 @@ static void hci_connect_le_scan_remove(struct hci_conn *conn)
 	schedule_work(&conn->le_scan_cleanup);
 }
 
-static void hci_acl_create_connection(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct inquiry_entry *ie;
-	struct hci_cp_create_conn cp;
-
-	BT_DBG("hcon %p", conn);
-
-	/* Many controllers disallow HCI Create Connection while it is doing
-	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
-	 * Connection. This may cause the MGMT discovering state to become false
-	 * without user space's request but it is okay since the MGMT Discovery
-	 * APIs do not promise that discovery should be done forever. Instead,
-	 * the user space monitors the status of MGMT discovering and it may
-	 * request for discovery again when this flag becomes false.
-	 */
-	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-		/* Put this connection to "pending" state so that it will be
-		 * executed after the inquiry cancel command complete event.
-		 */
-		conn->state = BT_CONNECT2;
-		hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		return;
-	}
-
-	conn->state = BT_CONNECT;
-	conn->out = true;
-	conn->role = HCI_ROLE_MASTER;
-
-	conn->attempt++;
-
-	conn->link_policy = hdev->link_policy;
-
-	memset(&cp, 0, sizeof(cp));
-	bacpy(&cp.bdaddr, &conn->dst);
-	cp.pscan_rep_mode = 0x02;
-
-	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
-	if (ie) {
-		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
-			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
-			cp.pscan_mode     = ie->data.pscan_mode;
-			cp.clock_offset   = ie->data.clock_offset |
-					    cpu_to_le16(0x8000);
-		}
-
-		memcpy(conn->dev_class, ie->data.dev_class, 3);
-	}
-
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
-	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
-		cp.role_switch = 0x01;
-	else
-		cp.role_switch = 0x00;
-
-	hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
-}
-
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	BT_DBG("hcon %p", conn);
@@ -1654,10 +1596,17 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 
 	acl->conn_reason = conn_reason;
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED) {
+		int err;
+
 		acl->sec_level = BT_SECURITY_LOW;
 		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
-		hci_acl_create_connection(acl);
+
+		err = hci_acl_create_connection_sync(hdev, acl);
+		if (err) {
+			hci_conn_del(acl);
+			return ERR_PTR(err);
+		}
 	}
 
 	return acl;
@@ -2590,7 +2539,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 
 	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
 	if (conn)
-		hci_acl_create_connection(conn);
+		hci_acl_create_connection_sync(hdev, conn);
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 4e4eae12ee3fb..afa38e093479a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6706,3 +6706,73 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_cmd_sync_queue(hdev, _update_adv_data_sync,
 				  ERR_PTR(instance), NULL);
 }
+
+static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn = data;
+	struct inquiry_entry *ie;
+	struct hci_cp_create_conn cp;
+	int err;
+
+	/* Many controllers disallow HCI Create Connection while it is doing
+	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
+	 * Connection. This may cause the MGMT discovering state to become false
+	 * without user space's request but it is okay since the MGMT Discovery
+	 * APIs do not promise that discovery should be done forever. Instead,
+	 * the user space monitors the status of MGMT discovering and it may
+	 * request for discovery again when this flag becomes false.
+	 */
+	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+		err = __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_CANCEL, 0,
+					    NULL, HCI_CMD_TIMEOUT);
+		if (err)
+			bt_dev_warn(hdev, "Failed to cancel inquiry %d", err);
+	}
+
+	conn->state = BT_CONNECT;
+	conn->out = true;
+	conn->role = HCI_ROLE_MASTER;
+
+	conn->attempt++;
+
+	conn->link_policy = hdev->link_policy;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.bdaddr, &conn->dst);
+	cp.pscan_rep_mode = 0x02;
+
+	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+	if (ie) {
+		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
+			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
+			cp.pscan_mode     = ie->data.pscan_mode;
+			cp.clock_offset   = ie->data.clock_offset |
+					    cpu_to_le16(0x8000);
+		}
+
+		memcpy(conn->dev_class, ie->data.dev_class, 3);
+	}
+
+	cp.pkt_type = cpu_to_le16(conn->pkt_type);
+	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
+		cp.role_switch = 0x01;
+	else
+		cp.role_switch = 0x00;
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       HCI_ACL_CONN_TIMEOUT, NULL);
+
+	if (err == -ETIMEDOUT)
+		hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
+
+	return err;
+}
+
+int hci_acl_create_connection_sync(struct hci_dev *hdev,
+				   struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue(hdev, __hci_acl_create_connection_sync,
+				  conn, NULL);
+}
-- 
2.53.0

