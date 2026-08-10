Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750E3B9D97
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405895; cv=none; b=EWAXbuHY0ZqcexuZpA9QplDUrCoSW7Y1dQI8e9f5So9vIrobu+MSV5DpUOr/Lav/bS2zXB6PiajbuD9s8Q7BHE7UzL8XQSKSKJX6PVn9WQTslxlpsVNMJyMNoXgAjmg1qPbsqPjIjdCaZ2NKTz2ks+mJtXj3uxnT+JYeRulb3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405895; c=relaxed/simple;
	bh=lWTdhQVE/mCpz6mzi0UY6DxR4TwJLi8TP/pHsYZx/Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbRYgtC35VGEDm2aWku1OTX/JkkFfIa6Xay02MNUPI9QojtpmqxZskxI8S3YdWzNZInqj2uCDbywQJTBPxKT4N9xQWTSUdYGOb5P/lr8gjmj7DG/GFPfqAZpLroZx7mj2HFopjEgE/5tsSc56wWXAWVI37jjFOujvJ+33KQ4+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOc7zZIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOc7zZIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1841F00A3E;
	Mon, 10 Aug 2026 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405893;
	bh=/26mNPgKFFvw5UGIgIIpeVHZZpp+FzuLmGnJq8uBkkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jOc7zZISuPZiJjNYOxtWJTmQdV7cW4W7vi6djwh2U3MTS8YK7i/R+ij/QccNfDJHi
	 SDGPGtU7GYaj0IorsqqmQH4HrPAAlNMOHYbsxx/zM7D2d6QVNvkqJQjvjiyBfjYFE1
	 NpYDbgSgrCdvx78ltViqzKiWpnemLCNg7Bguthxqzisv7PBRsEpNz5CHR83h4XNS50
	 wbE+/SrflblXotj4fxYLIF2VJ08ryTayYZdaEHCJTpiruncnUi2YxVNBcGUtfiUj2m
	 t+0E0KR0reDB0IifIQvTaU6HT/Tgl58hyESPxizIjvzn1VOuPKP/7nI776NLNWWHnG
	 YtmAVu7s0MRmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
Date: Mon, 10 Aug 2026 19:51:26 -0400
Message-ID: <20260810235129.3217516-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810235129.3217516-1-sashal@kernel.org>
References: <2026080548-angelfish-scored-d506@gregkh>
 <20260810235129.3217516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 227a0cdf4a028a73dc256d0f5144b4808d718893 ]

MGMT_OP_DISCONNECT can be called while mgmt_device_connected has not
been called yet, which will cause the connection procedure to be
aborted, so mgmt_device_disconnected shall still respond with command
complete to MGMT_OP_DISCONNECT and just not emit
MGMT_EV_DEVICE_DISCONNECTED since MGMT_EV_DEVICE_CONNECTED was never
sent.

To fix this MGMT_OP_DISCONNECT is changed to work similarly to other
command which do use hci_cmd_sync_queue and then use hci_conn_abort to
disconnect and returns the result, in order for hci_conn_abort to be
used from hci_cmd_sync context it now uses hci_cmd_sync_run_once.

Link: https://github.com/bluez/bluez/issues/932
Fixes: 12d4a3b2ccb3 ("Bluetooth: Move check for MGMT_CONNECTED flag into mgmt.c")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: d0a7b48ad092 ("Bluetooth: mgmt: fix UAF in pair command cancellation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 84 ++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0967b290d7bea..bfbcd0070d65d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2956,7 +2956,12 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	if (!conn)
 		return 0;
 
-	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
+	/* Disregard any possible error since the likes of hci_abort_conn_sync
+	 * will clean up the connection no matter the error.
+	 */
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
+	return 0;
 }
 
 static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3088,13 +3093,44 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void disconnect_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	cmd->cmd_complete(cmd, mgmt_status(err));
+	mgmt_pending_free(cmd);
+}
+
+static int disconnect_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_disconnect *cp = cmd->param;
+	struct hci_conn *conn;
+
+	if (cp->addr.type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
+					       le_addr_type(cp->addr.type));
+
+	if (!conn)
+		return -ENOTCONN;
+
+	/* Disregard any possible error since the likes of hci_abort_conn_sync
+	 * will clean up the connection no matter the error.
+	 */
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
+	return 0;
+}
+
 static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		      u16 len)
 {
 	struct mgmt_cp_disconnect *cp = data;
 	struct mgmt_rp_disconnect rp;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_conn *conn;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -3117,27 +3153,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (pending_find(MGMT_OP_DISCONNECT, hdev)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-					MGMT_STATUS_BUSY, &rp, sizeof(rp));
-		goto failed;
-	}
-
-	if (cp->addr.type == BDADDR_BREDR)
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
-					       &cp->addr.bdaddr);
-	else
-		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
-					       le_addr_type(cp->addr.type));
-
-	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-					MGMT_STATUS_NOT_CONNECTED, &rp,
-					sizeof(rp));
-		goto failed;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_DISCONNECT, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -3145,9 +3161,10 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	cmd->cmd_complete = generic_cmd_complete;
 
-	err = hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
+	err = hci_cmd_sync_queue(hdev, disconnect_sync, cmd,
+				 disconnect_complete);
 	if (err < 0)
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -9695,18 +9712,6 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	mgmt_event_skb(skb, NULL);
 }
 
-static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
-{
-	struct sock **sk = data;
-
-	cmd->cmd_complete(cmd, 0);
-
-	*sk = cmd->sk;
-	sock_hold(*sk);
-
-	mgmt_pending_remove(cmd);
-}
-
 static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct hci_dev *hdev = data;
@@ -9747,8 +9752,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (link_type != ACL_LINK && link_type != LE_LINK)
 		return;
 
-	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
-
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.reason = reason;
@@ -9761,9 +9764,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	if (sk)
 		sock_put(sk);
-
-	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
-			     hdev);
 }
 
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
2.53.0

