Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFD4B2046
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888544; cv=none; b=miVv+tkFkrsEYVt1XA/mXpG3AMQ1j/429qLAZZtl23/OhSbznXKN3/C5ERN5mGLnzmNH6C6Yp9xzBq0Sidp4i8dzUAuYAqiaJZ973CjClb8xshGWhCLAbaf50EAtFYQqmDgUgR08bqJG6778o6jvfONfW97xJNLsl8F9lyAR4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888544; c=relaxed/simple;
	bh=ceqOgw+eUwkEPOCMIsd/aR0vDEN5Uo0UJ8VYVSf4+So=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dMq9/75kI09Lqgd1QanJKOVUR68sWr++b+Bk54tTxCNHVpp3QN+UAkyS7MaV86cA5qQID5CGm0aQXO0ZyiXp7XLyKAq+BUnjotYPjXt0yMC1z9rFy5awmHHt+SWYEmItjv/ai56776t1AM9zR6GDwZ5dUFDA+55fAbtQxzRgjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aKsdO/oe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aKsdO/oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9270F1F000FF;
	Tue, 13 Oct 2026 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791888542;
	bh=ja/OFQGpTZrV7XCtNf2eRGoCw33Vfj3jRsZz6PdhB2E=;
	h=Subject:To:Cc:From:Date;
	b=aKsdO/oe73p2ysyJYxN9bwOYOwcUP8p1xx1Nkje9BWyPumQEzZktIyuRpvYPBrw6p
	 iLCsWzgFwPk/UvhTAPO9vjioRi8XbkaBRE5H1WFSutcxEcUZJ7z5yov2XHzgK/a9vn
	 Fmcgsa/dLqz1Q+Wex6r70UrIU0zEX8MVP7o2HHFg=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_conn: Fix UAF Write in" failed to apply to 6.1-stable tree
To: luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Oct 2026 12:49:07 +0200
Message-ID: <2026101307-tableware-velvet-7ee4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5f641f03abccddd1a37233ff1b8e774b9ff1f4e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101307-tableware-velvet-7ee4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f641f03abccddd1a37233ff1b8e774b9ff1f4e8 Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Fri, 9 Feb 2024 09:08:06 -0500
Subject: [PATCH] Bluetooth: hci_conn: Fix UAF Write in
 __hci_acl_create_connection_sync

This fixes the UAF on __hci_acl_create_connection_sync caused by
connection abortion, it uses the same logic as to LE_LINK which uses
hci_cmd_sync_cancel to prevent the callback to run if the connection is
abort prematurely.

Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 824660f8f30d..ed334c253ebc 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -139,5 +139,4 @@ int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
 
-int hci_acl_create_connection_sync(struct hci_dev *hdev,
-				   struct hci_conn *conn);
+int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8164502234c5..587eb27f374c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1645,7 +1645,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		acl->auth_type = auth_type;
 		acl->conn_timeout = timeout;
 
-		err = hci_acl_create_connection_sync(hdev, acl);
+		err = hci_connect_acl_sync(hdev, acl);
 		if (err) {
 			hci_conn_del(acl);
 			return ERR_PTR(err);
@@ -2942,6 +2942,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 */
 	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
 		switch (hci_skb_event(hdev->sent_cmd)) {
+		case HCI_EV_CONN_COMPLETE:
 		case HCI_EV_LE_CONN_COMPLETE:
 		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
 		case HCI_EVT_LE_CIS_ESTABLISHED:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 788a889210d8..e1fdcb3c2706 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6493,13 +6493,18 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 				  UINT_PTR(instance), NULL);
 }
 
-static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
+static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn = data;
+	struct hci_conn *conn;
+	u16 handle = PTR_UINT(data);
 	struct inquiry_entry *ie;
 	struct hci_cp_create_conn cp;
 	int err;
 
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
+		return 0;
+
 	/* Many controllers disallow HCI Create Connection while it is doing
 	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
 	 * Connection. This may cause the MGMT discovering state to become false
@@ -6556,9 +6561,8 @@ static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
 	return err;
 }
 
-int hci_acl_create_connection_sync(struct hci_dev *hdev,
-				   struct hci_conn *conn)
+int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue(hdev, __hci_acl_create_connection_sync,
-				  conn, NULL);
+	return hci_cmd_sync_queue(hdev, hci_acl_create_conn_sync,
+				  UINT_PTR(conn->handle), NULL);
 }

