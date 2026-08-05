Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBD402B97
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922968; cv=none; b=WcEH0OknsHNVSymA1a9Oljtuub73L1Oi8uztGDw//saD4fhBRWSdkZD2ZDJ42IbPvFzZEvEzZ1u3WMi2CT15eTBKe6b8k9n5tVASlLINtyY1zrNR09vD+AZjhYpIJa2KMkJLX4Wcv3eE84/YKDHL6Yt+lus+5gX8A5Lh8KN9NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922968; c=relaxed/simple;
	bh=WwvkZDlhm3tn6FEU8HWoCKyqS3vbD1JIUMeg5EqQbew=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GlCT/Cpw41nIVJxNsIGmTYu7SkeC79Khn3txejZ72NHkLaeNSUjrBac4coeONlRy2wUQhI8x9QqpY8QESt2jtBQLImw1I3FV/jFRMdezfhG4uZ0RILjziKWncJ8ziPnD6t0MAhVVpQAjEtj6+OBUgPR3eScwvEOy2ddN07Ju6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4Xiwf8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4Xiwf8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702451F00A3D;
	Wed,  5 Aug 2026 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922966;
	bh=tLarwaTPFfrPP3KEAUh91TSqG71BvKpGkruzpUlB/ZE=;
	h=Subject:To:Cc:From:Date;
	b=K4Xiwf8HiittQCw5uKPFbfC2xCHntUi9r0rUaWMS9TtYQJPg7+EHAzKl9GFH3NInl
	 oXG+8UMvfWIxWx6NlkIEMLRVgySQyza3+duESefs3Ccat9CLro2/XqL84UEnmeKgE9
	 gZLghHsYUX4nFfteqIFUGwu5Y/WqaG5POBrnqTvY=
Subject: FAILED: patch "[PATCH] Bluetooth: mgmt: fix UAF in pair command cancellation" failed to apply to 5.15-stable tree
To: xizh2024@lzu.edu.cn,enjou1224z@gmail.com,luiz.von.dentz@intel.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:39:48 +0200
Message-ID: <2026080548-prize-pavement-f579@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d0a7b48ad0921bd88effaee10bf970ab1d5d0ddd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080548-prize-pavement-f579@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0a7b48ad0921bd88effaee10bf970ab1d5d0ddd Mon Sep 17 00:00:00 2001
From: Zihan Xi <xizh2024@lzu.edu.cn>
Date: Tue, 21 Jul 2026 22:36:07 +0800
Subject: [PATCH] Bluetooth: mgmt: fix UAF in pair command cancellation

The pairing completion and authentication failure callbacks look up the
pending MGMT_OP_PAIR_DEVICE command by walking hdev->mgmt_pending. The
lookup returned a command that was still linked on the shared pending list,
without keeping mgmt_pending_lock held for the later dereference and
removal.

A concurrent MGMT_OP_CANCEL_PAIR_DEVICE request can remove and free the
same pending command before the callback uses it. The reverse race is also
possible when cancel_pair_device() gets a command from pending_find() and a
callback removes it before the cancel path dereferences it. This can lead
to a use-after-free and a second list_del().

Make the pairing lookup helpers transfer ownership of the pending command
by removing it from hdev->mgmt_pending while holding mgmt_pending_lock.
The callbacks and cancel path then complete the command and free it
directly, so racing paths cannot find or free the same command again. Take
a temporary hci_conn reference in cancel_pair_device() because the command
completion drops the reference stored in the pending command.

Fixes: e9a416b5ce0c ("Bluetooth: Add mgmt_pair_device command")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1db10e0f617f..4fd37ac79986 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3514,11 +3514,13 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 				 NULL, 0);
 }
 
-static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
+static struct mgmt_pending_cmd *remove_pairing(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct mgmt_pending_cmd *cmd;
 
+	mutex_lock(&hdev->mgmt_pending_lock);
+
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
 			continue;
@@ -3526,9 +3528,39 @@ static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
 		if (cmd->user_data != conn)
 			continue;
 
+		list_del(&cmd->list);
+		mutex_unlock(&hdev->mgmt_pending_lock);
 		return cmd;
 	}
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return NULL;
+}
+
+static struct mgmt_pending_cmd *remove_pairing_by_addr(struct hci_dev *hdev,
+						       bdaddr_t *bdaddr)
+{
+	struct mgmt_pending_cmd *cmd;
+	struct hci_conn *conn;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
+			continue;
+
+		conn = cmd->user_data;
+		if (bacmp(bdaddr, &conn->dst) != 0)
+			continue;
+
+		list_del(&cmd->list);
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return cmd;
+	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return NULL;
 }
 
@@ -3566,10 +3598,10 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete)
 	u8 status = complete ? MGMT_STATUS_SUCCESS : MGMT_STATUS_FAILED;
 	struct mgmt_pending_cmd *cmd;
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 	if (cmd) {
 		cmd->cmd_complete(cmd, status);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 	}
 }
 
@@ -3579,14 +3611,14 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 
 	BT_DBG("status %u", status);
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
 		return;
 	}
 
 	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -3598,14 +3630,14 @@ static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
 	if (!status)
 		return;
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
 		return;
 	}
 
 	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3762,23 +3794,17 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = pending_find(MGMT_OP_PAIR_DEVICE, hdev);
+	cmd = remove_pairing_by_addr(hdev, &addr->bdaddr);
 	if (!cmd) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
-	conn = cmd->user_data;
-
-	if (bacmp(&addr->bdaddr, &conn->dst) != 0) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
-				      MGMT_STATUS_INVALID_PARAMS);
-		goto unlock;
-	}
+	conn = hci_conn_get(cmd->user_data);
 
 	cmd->cmd_complete(cmd, MGMT_STATUS_CANCELLED);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
 				addr, sizeof(*addr));
@@ -3796,6 +3822,8 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
 		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 
+	hci_conn_put(conn);
+
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
@@ -10137,14 +10165,14 @@ void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
 	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 	ev.status = status;
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 
 	mgmt_event(MGMT_EV_AUTH_FAILED, conn->hdev, &ev, sizeof(ev),
 		    cmd ? cmd->sk : NULL);
 
 	if (cmd) {
 		cmd->cmd_complete(cmd, status);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 	}
 }
 

