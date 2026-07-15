Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B273D75A2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159728; cv=none; b=X0Sb0/Kusf7ktNRbJHTtdzZWpU+qa9qCuWR4nkcgjJQACZ0KdCXAbdBDib4in7STwGnGP+ehx6pTnoqiNnkgV94f5rJRzMn2tXqGSTqVF/pYQTpDSt0BBzA3zK1ucUOEODfgr0u8ooLLsqTSVXrf6csTuPhD9bVY8b9oduSwUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159728; c=relaxed/simple;
	bh=nXUFs9rYspeh0UfQ0KW5Lelz62JxkSUaKRYeRfa/gS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPXgqGXBVdkWo9OSI4vh9J19J6hpkUg/AjL6ZgZaDr0Eg49No09FzCdkqwpscGL3cBQMh8/mEd1BaLQCOY5ObyoJanOdqBgHVU/7kwBe45xsx+9P/uMn5pFBhKahZ0hTPdGXjTx4ar7dmKiIB+SO7EGTuPC876Bdi5IimpYTqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjcGfB/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjcGfB/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F431F00A3E;
	Wed, 15 Jul 2026 23:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159727;
	bh=yGIrc+UatPp0XKSYveSsf7CFonABxyGshKeSIOQefxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WjcGfB/q+auyTkZ9hD5GP5JrfRD4VApVtFRmSAzhWtyIy6KUNMy/CYcU2Ds0QHbjH
	 Zf0ycbax8xeTrTTh3yp+NG5U9qISXGlSbdJk1PxfPdTOJMsql/n9Zp9H2tdf43w723
	 Id6OYOiotoiw0iM0rxuqJgjWDYdf/s7q8AY/kgib5s6MzJro8dA4qWX5m/ZXKmKSzi
	 a0GyD0dse0ajzstvSR4RmCPPQLwEi84Dd9rUOknFtXYX7UgXV9hx/ZESHDRY3RBumo
	 dgzD+wtnSGtglGXEJY7opM+sUG/N12ReA/3JKvw5bjJcfF9PPlTMbm5kQK6StGvKbS
	 XKslycstlzTEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
Date: Wed, 15 Jul 2026 19:55:23 -0400
Message-ID: <20260715235525.525483-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071336-hastily-statistic-2a3e@gregkh>
References: <2026071336-hastily-statistic-2a3e@gregkh>
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
index 21e4c9d916680a..71ae06fe613cd2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -694,8 +694,7 @@ struct l2cap_conn {
 
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
-	__u8			tx_ident;
-	struct mutex		ident_lock;
+	struct ida		tx_ida;
 
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ef5c1503c564e0..e62f5aa38ab040 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -961,26 +961,18 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
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
@@ -1939,6 +1931,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
+	ida_destroy(&conn->tx_ida);
+
 	if (work_pending(&conn->id_addr_update_work))
 		cancel_work_sync(&conn->id_addr_update_work);
 
@@ -5782,12 +5776,41 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
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
@@ -6534,6 +6557,8 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 {
 	int err = 0;
 
+	l2cap_put_ident(conn, cmd->code, cmd->ident);
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		l2cap_le_command_rej(conn, cmd, cmd_len, data);
@@ -8112,13 +8137,13 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
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

