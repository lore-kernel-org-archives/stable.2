Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB2173
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161014; cv=none; b=tGZrHMNAja/cTd36wLSrxr31ag9GwKUuh6ZV6KJeslmeUZsTG6RRQMPnIzQv3HLkW5i4M1KRYiiKiPYmBhJ3c2C9dN7znYOBlUhJs4jS5c5l4o90ihKR3DtKpNKbOcGHmA3RfaYqIRMXB++g3BbK/vq6kY0RrHVO7eDLvOFFCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161014; c=relaxed/simple;
	bh=u9ilWwOLZvVcjl3y2q2xlSYw0pDB6oPUhHnqS7V7wZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLItPpW5Qxf7pBspiEJ9aoCjNSLH8GCdBIAtSGF0YwnaP0f9DfgSZb+eNzixTQwHMW0h5rPpG8Q1Hefemamg410GAETHfRBYVc6DmE8pbsw32rwG/DlhItREsz2W7L0uVD50FMy5ndpF4Cc/86/nz7Q9Vg2tpFsP+TGOxe8glcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcCmacZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcCmacZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D2C1F000E9;
	Thu, 16 Jul 2026 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161012;
	bh=6zWKh/+PjXoOvK+ZsW9Ib6JV74ga4Ygz+G58Dg8bDzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DcCmacZcQr0kgkbMdqzEyVPamwpx5hkPRnOogttTwcyMIl70IZu0jjxFjJ+yscIEh
	 g4HtDlN9GJLKlt2I29jkusulLGpR7bKeD2WC8XrK5h9M4mqcoMlSu3XmlMa/BeeRj6
	 qYY7MYbi42S8fQ+r3/UWxmwZA56RFnr4P7E1jy8lkVfdPLX5CN+tdf9wPIl8rdVXo1
	 0PlNDBUwDnLH87x0A2w+qRwppN4wVxqn67pPPwJciexWJFr4vOnirJM20t8fwL6V+3
	 0KuRR2wJtnk6oZYDJnZcnmzEYTGLkmE2+yq7z1X8eQAqfIs4InFqn1BEUiReFw4qKq
	 ocBPNnITa+B3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
Date: Wed, 15 Jul 2026 20:16:48 -0400
Message-ID: <20260716001650.589781-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071337-culminate-graveness-5fc7@gregkh>
References: <2026071337-culminate-graveness-5fc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 6c3ea155e5ee3e56606233acde8309afda66d483 ]

This attempts to proper track outstanding request by using struct ida
and allocating from it in l2cap_get_ident using ida_alloc_range which
would reuse ids as they are free, then upon completion release
the id using ida_free.

This fixes the qualification test case L2CAP/COS/CED/BI-29-C which
attempts to check if the host stack is able to work after 256 attempts
to connect which requires Ident field to use the full range of possible
values in order to pass the test.

Link: https://github.com/bluez/bluez/issues/1829
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Stable-dep-of: 2641a9e0a1dd ("Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/l2cap.h |  3 +-
 net/bluetooth/l2cap_core.c    | 53 ++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f22698713bd09b..f375e92aefb147 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -690,8 +690,7 @@ struct l2cap_conn {
 
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
-	__u8			tx_ident;
-	struct mutex		ident_lock;
+	struct ida		tx_ida;
 
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5f319dd84f1ba..f1e230f6d6f866 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -939,26 +939,18 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 				 initiator);
 }
 
-static u8 l2cap_get_ident(struct l2cap_conn *conn)
+static int l2cap_get_ident(struct l2cap_conn *conn)
 {
-	u8 id;
+	/* LE link does not support tools like l2ping so use the full range */
+	if (conn->hcon->type == LE_LINK)
+		return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC);
 
 	/* Get next available identificator.
 	 *    1 - 128 are used by kernel.
 	 *  129 - 199 are reserved.
 	 *  200 - 254 are used by utilities like l2ping, etc.
 	 */
-
-	mutex_lock(&conn->ident_lock);
-
-	if (++conn->tx_ident > 128)
-		conn->tx_ident = 1;
-
-	id = conn->tx_ident;
-
-	mutex_unlock(&conn->ident_lock);
-
-	return id;
+	return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
 }
 
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
@@ -1917,6 +1909,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
+	ida_destroy(&conn->tx_ida);
+
 	if (work_pending(&conn->id_addr_update_work))
 		cancel_work_sync(&conn->id_addr_update_work);
 
@@ -5768,12 +5762,41 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	return err;
 }
 
+static void l2cap_put_ident(struct l2cap_conn *conn, u8 code, u8 id)
+{
+	int ret;
+
+	switch (code) {
+	case L2CAP_COMMAND_REJ:
+	case L2CAP_CONN_RSP:
+	case L2CAP_CONF_RSP:
+	case L2CAP_DISCONN_RSP:
+	case L2CAP_ECHO_RSP:
+	case L2CAP_INFO_RSP:
+	case L2CAP_CONN_PARAM_UPDATE_RSP:
+	case L2CAP_ECRED_CONN_RSP:
+	case L2CAP_ECRED_RECONF_RSP:
+		/* The remote may send bogus ids that would make ida_free
+		 * generate warnings, so only free ids that are actually
+		 * allocated: probing the exact id returns -ENOSPC when it
+		 * is in use, otherwise the probe allocated it and freeing
+		 * is safe either way.  Only on -ENOMEM is the id known to
+		 * be unallocated and the free must be skipped.
+		 */
+		ret = ida_alloc_range(&conn->tx_ida, id, id, GFP_ATOMIC);
+		if (ret >= 0 || ret == -ENOSPC)
+			ida_free(&conn->tx_ida, id);
+	}
+}
+
 static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 				      struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				      u8 *data)
 {
 	int err = 0;
 
+	l2cap_put_ident(conn, cmd->code, cmd->ident);
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		l2cap_command_rej(conn, cmd, cmd_len, data);
@@ -6512,6 +6535,8 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 {
 	int err = 0;
 
+	l2cap_put_ident(conn, cmd->code, cmd->ident);
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		l2cap_le_command_rej(conn, cmd, cmd_len, data);
@@ -8065,13 +8090,13 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	     hci_dev_test_flag(hcon->hdev, HCI_FORCE_BREDR_SMP)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
-	mutex_init(&conn->ident_lock);
 	mutex_init(&conn->chan_lock);
 
 	INIT_LIST_HEAD(&conn->chan_l);
 	INIT_LIST_HEAD(&conn->users);
 
 	INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
+	ida_init(&conn->tx_ida);
 
 	skb_queue_head_init(&conn->pending_rx);
 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
-- 
2.53.0

