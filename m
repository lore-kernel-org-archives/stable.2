Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083F3C8C43
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148588; cv=none; b=DZQdE/as8ULNaVWgb4sMiPsloqIMYgQTiYqvmlFWz6+9I9pTd9LCxj60Y0TWhD4CZQg4GKaD+sCzRTh/L8fms5ireY+RFmGai6k/SyC2bOVoPS/FRbsQ/oYRT5NPSQmlEdLqwfB1jN8ZRASNmE/wfpFxFvXC7iGUgYdRXuY054Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148588; c=relaxed/simple;
	bh=90Oq3CBAOIIbyMKH4FCG03AvQHEtG61Qw2A4ZJZIeVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr2/TvcUqNUVVSa0WMhVFhd/zv9Uk/AZplsIPuK0RxaHvn47yUEXGOuRptLmiGCTojr2patRfQ8jECU1/3MQbGz6lgfISwmUD2YZel/X8bh84D5qEi/ySzKDT8qpX7cMOqCdBPZaFBJJU2WSXk6v8jWtdW9MJuWNhN6t99Fh1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnIfQd+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnIfQd+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CD41F000E9;
	Wed, 15 Jul 2026 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148586;
	bh=CDHG7cVurQ/qqZsNb9pjhbztdeT+Hks+M8bUoRXBXwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnIfQd+aXH1zYR/5EtDOExMDA3u4JFbs3gLl6HoDXAFZ+JDD5kr9BdCaWWou4h+Nq
	 /GT4jYQiGYXBmxdhxMncVJKEBHAPMcEiI9U+jXnudobwG4IETJQhja5lFnp+uswIRw
	 Q3Px2SrooKvw5C4h52xrw9RHSIo+/hyx9OrtDEXEIYelxU2WrL9+D/kkQ/Iw3Y8AgU
	 EOgcKMDpuRkr/8gIumdGE5pU9TNX1dVLf1j66BFZANy9zt4vRNvsdyfU9eQdDWJn9r
	 KNdjHL7nksXrXka3HlYXaugrjErN1B66Qyok3apAZx7Pzo5A5IQNF6hofJEoPdawDY
	 xCmIWQQOIqSiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
Date: Wed, 15 Jul 2026 16:49:43 -0400
Message-ID: <20260715204944.205221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-renovator-imprison-ad7b@gregkh>
References: <2026071335-renovator-imprison-ad7b@gregkh>
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
index 00b5d56f369f64..1bea957f3bf4e0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -658,8 +658,7 @@ struct l2cap_conn {
 
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
-	__u8			tx_ident;
-	struct mutex		ident_lock;
+	struct ida		tx_ida;
 
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 52e607b0902ada..90e2ec9d20bb8a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -926,26 +926,18 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
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
 
 static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
@@ -1774,6 +1766,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
+	ida_destroy(&conn->tx_ida);
+
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -4750,12 +4744,41 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
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
@@ -5469,6 +5492,8 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 {
 	int err = 0;
 
+	l2cap_put_ident(conn, cmd->code, cmd->ident);
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		l2cap_le_command_rej(conn, cmd, cmd_len, data);
@@ -7017,13 +7042,13 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	     hci_dev_test_flag(hcon->hdev, HCI_FORCE_BREDR_SMP)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
-	mutex_init(&conn->ident_lock);
 	mutex_init(&conn->lock);
 
 	INIT_LIST_HEAD(&conn->chan_l);
 	INIT_LIST_HEAD(&conn->users);
 
 	INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
+	ida_init(&conn->tx_ida);
 
 	skb_queue_head_init(&conn->pending_rx);
 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
-- 
2.53.0

