Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724D349CDC
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963920; cv=none; b=pMhfb1AYfNYrbsf80rPuhOSrIgYZiEZ+YyH2wIpJAKu//RI8120aBYglQ6z1TJTPKAKYEndCWWBqP+1kQm0J+Gbc6XCfhrG9UXSOFXL1Q5qVH3mcpC0VbUvK6iOUrX01g1xMsfKzQJak4AwmcS094VkXXBXeyTpL7XgOL9KukMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963920; c=relaxed/simple;
	bh=LzOFD7MJcPHTC+KsLKmUlPURpzH9kweKX0DL+Hadqdk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ko9BkjX6ye9itiBBAtDOq+AeiTCEjoMnAC0XIiy8PWFY35qMVsUaUp36VkUEKX3w0JGM32YhaKAIflWiLiXyz4eOEz1fTyNOc6xtNSx2orrkqAuP7oGhUg0i3rS/5BQ/8NwP4gSe+1ACAskm0bjygPO20MryyLwqgG/nJsfVMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+SvWVcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+SvWVcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9961F000E9;
	Mon, 13 Jul 2026 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783963918;
	bh=pC3x48BkVZnQlXhvifS5MmTZdKjyw55Osb6neNTg4l4=;
	h=Subject:To:Cc:From:Date;
	b=C+SvWVcsNMBClytF4NYdDBT29TlWC1YteJa3FFLDbhxJgjvqZYynauhJ5t1wS3Kyi
	 ow5m+qE9aGysDhrpGAMeDrarapl60OxHNwb63rhkmRwU171r/PNpq8SHScc1vAklD7
	 0syTGh5d+ng/FTG5nvGeA8+55itd+/HRCKN2J1t8=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()" failed to apply to 6.12-stable tree
To: oss@fourdim.xyz,luiz.von.dentz@intel.com,xiaowu.417@qq.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 19:31:53 +0200
Message-ID: <2026071353-angular-magical-b4f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 12917f591cea1af36087dba5b9ec888652f0b42a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071353-angular-magical-b4f5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12917f591cea1af36087dba5b9ec888652f0b42a Mon Sep 17 00:00:00 2001
From: Siwei Zhang <oss@fourdim.xyz>
Date: Mon, 15 Jun 2026 11:33:05 -0400
Subject: [PATCH] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()

hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
was pending, but hdev->sent_cmd can be NULL while req_status is still
HCI_REQ_PEND, leading to a NULL pointer dereference and a general
protection fault from the hci_rx_work() receive path.

Instead of inspecting hdev->sent_cmd, track the in-flight create
connection command with a new per-connection HCI_CONN_CREATE flag and
route all cancellation through hci_cancel_connect_sync(), which
dispatches to a dedicated per-type cancel function. The create command
is in exactly one of two states: still queued, or in flight. The cancel
function holds cmd_sync_work_lock across the whole decision: the worker
takes this lock to dequeue every entry, so while it is held a queued
command cannot start running and an in-flight command cannot complete
and let the next command become pending. This keeps the flag test and
hci_cmd_sync_cancel() atomic with respect to the worker, so a queued
command is simply dequeued, and an in-flight command owned by this
connection is cancelled without the risk of cancelling an unrelated
command that became pending in the meantime. CIS uses the same flag
mechanism via HCI_CONN_CREATE_CIS but cannot be dequeued per-connection.

hci_acl_create_conn_sync() and hci_le_create_conn_sync() clear
HCI_CONN_CREATE after the create command completes, but the command
status handler can free conn via hci_conn_del() (for example when the
controller rejects the connection) while the worker is still blocked on
the connection complete event. Hold a reference on conn across the
create command so the flag can be cleared without a use-after-free.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Cc: stable@vger.kernel.org
Suggested-by: XIAO WU <xiaowu.417@qq.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7e15da47fe3a..4ca09298e11a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -985,6 +985,7 @@ enum {
 	HCI_CONN_AUTH_FAILURE,
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
+	HCI_CONN_CREATE,
 	HCI_CONN_CREATE_CIS,
 	HCI_CONN_CREATE_BIG_SYNC,
 	HCI_CONN_BIG_SYNC,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c335372e4062..1966cd153d97 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3178,26 +3178,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	conn->abort_reason = reason;
 
-	/* If the connection is pending check the command opcode since that
-	 * might be blocking on hci_cmd_sync_work while waiting its respective
-	 * event so we need to hci_cmd_sync_cancel to cancel it.
-	 *
-	 * hci_connect_le serializes the connection attempts so only one
-	 * connection can be in BT_CONNECT at time.
+	/* Cancel the connect attempt. A return of 0 means the create command
+	 * was still queued and got dequeued, so there is nothing to disconnect.
 	 */
-	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
-		switch (hci_skb_event(hdev->sent_cmd)) {
-		case HCI_EV_CONN_COMPLETE:
-		case HCI_EV_LE_CONN_COMPLETE:
-		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
-		case HCI_EVT_LE_CIS_ESTABLISHED:
-			hci_cmd_sync_cancel(hdev, ECANCELED);
-			break;
-		}
-	/* Cancel connect attempt if still queued/pending */
-	} else if (!hci_cancel_connect_sync(hdev, conn)) {
+	if (!hci_cancel_connect_sync(hdev, conn))
 		return 0;
-	}
 
 	/* Run immediately if on cmd_sync_work since this may be called
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3be8c3581c6c..c896d4edd013 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6633,6 +6633,11 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
+	 * clear_bit() at done.
+	 */
+	hci_conn_get(conn);
+
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->state = BT_CONNECT;
 
@@ -6645,6 +6650,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
 			hci_conn_del(conn);
+			hci_conn_put(conn);
 			return -EBUSY;
 		}
 
@@ -6690,6 +6696,12 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 					     &own_addr_type);
 	if (err)
 		goto done;
+
+	/* Mark create connection in flight so hci_cancel_connect_sync() can
+	 * cancel it while blocking on the connection complete event.
+	 */
+	set_bit(HCI_CONN_CREATE, &conn->flags);
+
 	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
@@ -6725,11 +6737,14 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 				       conn->conn_timeout, NULL);
 
 done:
+	clear_bit(HCI_CONN_CREATE, &conn->flags);
+
 	if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
+	hci_conn_put(conn);
 	return err;
 }
 
@@ -7004,10 +7019,25 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
-					sizeof(cp), &cp,
-					HCI_EV_CONN_COMPLETE,
-					conn->conn_timeout, NULL);
+	/* Hold a reference so conn stays valid for the HCI_CONN_CREATE
+	 * clear_bit() below.
+	 */
+	hci_conn_get(conn);
+
+	/* Mark create connection in flight so hci_cancel_connect_sync() can
+	 * cancel it while blocking on the connection complete event.
+	 */
+	set_bit(HCI_CONN_CREATE, &conn->flags);
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       conn->conn_timeout, NULL);
+
+	clear_bit(HCI_CONN_CREATE, &conn->flags);
+	hci_conn_put(conn);
+
+	return err;
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -7059,22 +7089,97 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return (err == -EEXIST) ? 0 : err;
 }
 
-int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
+static int hci_acl_cancel_create_conn_sync(struct hci_dev *hdev,
+					   struct hci_conn *conn)
 {
-	if (conn->state != BT_OPEN)
-		return -EINVAL;
+	struct hci_cmd_sync_work_entry *entry;
+	int err = -EBUSY;
 
-	switch (conn->type) {
-	case ACL_LINK:
-		return !hci_cmd_sync_dequeue_once(hdev,
-						  hci_acl_create_conn_sync,
-						  conn, NULL);
-	case LE_LINK:
-		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
-						  conn, create_le_conn_complete);
+	/* cmd_sync_work_lock makes the HCI_CONN_CREATE test and the cancel
+	 * atomic against the worker, which takes this lock to dequeue every
+	 * entry: while it is held no other command can become pending, so
+	 * hci_cmd_sync_cancel() cannot cancel an unrelated command.
+	 */
+	mutex_lock(&hdev->cmd_sync_work_lock);
+
+	/* In flight: this connection owns the pending request, cancel it. */
+	if (test_bit(HCI_CONN_CREATE, &conn->flags)) {
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+		goto unlock;
 	}
 
-	return -ENOENT;
+	/* Still queued: a successful dequeue means it never started, so there
+	 * is nothing to disconnect.
+	 */
+	entry = _hci_cmd_sync_lookup_entry(hdev, hci_acl_create_conn_sync, conn,
+					   NULL);
+	if (entry) {
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+		err = 0;
+	}
+
+unlock:
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+	return err;
+}
+
+static int hci_le_cancel_create_conn_sync(struct hci_dev *hdev,
+					  struct hci_conn *conn)
+{
+	struct hci_cmd_sync_work_entry *entry;
+	int err = -EBUSY;
+
+	/* cmd_sync_work_lock keeps the HCI_CONN_CREATE test and the cancel
+	 * atomic against the cmd_sync worker.
+	 */
+	mutex_lock(&hdev->cmd_sync_work_lock);
+
+	if (test_bit(HCI_CONN_CREATE, &conn->flags)) {
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+		goto unlock;
+	}
+
+	entry = _hci_cmd_sync_lookup_entry(hdev, hci_le_create_conn_sync, conn,
+					   create_le_conn_complete);
+	if (entry) {
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+		err = 0;
+	}
+
+unlock:
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+	return err;
+}
+
+static int hci_cis_cancel_create_conn_sync(struct hci_dev *hdev,
+					   struct hci_conn *conn)
+{
+	/* LE Create CIS is shared by the whole CIG and cannot be dequeued
+	 * per-connection, so only an in-flight command can be cancelled.
+	 * cmd_sync_work_lock keeps the test and the cancel atomic against the
+	 * cmd_sync worker.
+	 */
+	mutex_lock(&hdev->cmd_sync_work_lock);
+
+	if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
+		hci_cmd_sync_cancel(hdev, ECANCELED);
+
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+	return -EBUSY;
+}
+
+int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	switch (conn->type) {
+	case ACL_LINK:
+		return hci_acl_cancel_create_conn_sync(hdev, conn);
+	case LE_LINK:
+		return hci_le_cancel_create_conn_sync(hdev, conn);
+	case CIS_LINK:
+		return hci_cis_cancel_create_conn_sync(hdev, conn);
+	default:
+		return -ENOENT;
+	}
 }
 
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,

