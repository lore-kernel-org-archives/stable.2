Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EC5187EB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792926; cv=none; b=HozXKyUW0A4Ra9PtpiJjkAsMbVpOw9hWVQ3jJoR+SywJArlpWMA07LkUy6p6FAOXM/9H2sPwo+2xiNWtZjxRtGIIsM2XCgLYkUvOHeJzb9PMoeyUjkr7i19wvbbc28OdaugB+sIHnSsURX/yHD78tu6+vAk4ztMSaF2411eZxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792926; c=relaxed/simple;
	bh=TWV39jO2bCVDiNHVm5nuIjQU6dGuf2cqP/Y82o7dkos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e96axArm4WUD2y8ftjXAHU937h1GJXZcrmeNouoTM9yW3+l2JWlMem0f/nHcGCC1GVD5RRKE2VhYjsaY3yBN2Crlritje17I170nhkrbGP4xTjgrNSN7H7wR8NUYTAdWBRibHOD4SIAGk34bAecaxjUlMdDn1mbnoxarUuO7m6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVSbheUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVSbheUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9861F0089B;
	Wed, 30 Sep 2026 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792924;
	bh=B/WQg6IkM9ipcfRG1cW8eQmImyP633GNhmQ5t8PpwvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WVSbheUonskWna2zR2xVXZ6AnmsaFqwp0qVTx1g10GWNVdV8SFcFcooIX3X1mlqzU
	 BYGpjPwwrsu57V/NcgH5xKoCguBNAMbAXj6+SDNvnh5YRZe9DY8NS29Ls4u41pFxbV
	 bpHdOuGUJhm4jr0yqIkgdvXvLWOSdNDeQPmS3FEQFwIsZI1TfBqh2PeqtHyuO+t6EN
	 q0qmnK7X9wl47tOrZXlp9lZQssk90IDPGsaV2p9pRsHxDfPqC2OocK8nyym28o93nP
	 norAEaark3Iiz1UO8T8hSM23IAvs5DTwxGZduK+muXfCQtJrk3A/QtuuBuTi9xovdT
	 +8ugUZ+GsrsMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] Bluetooth: HCI: Remove HCI_AMP support
Date: Wed, 30 Sep 2026 14:28:40 -0400
Message-ID: <20260930182841.34239-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930182841.34239-1-sashal@kernel.org>
References: <2026092958-cathouse-visiting-7f57@gregkh>
 <20260930182841.34239-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 84a4bb6548a29326564f0e659fb8064503ecc1c7 ]

Since BT_HS has been remove HCI_AMP controllers no longer has any use so
remove it along with the capability of creating AMP controllers.

Since we no longer need to differentiate between AMP and Primary
controllers, as only HCI_PRIMARY is left, this also remove
hdev->dev_type altogether.

Fixes: e7b02296fb40 ("Bluetooth: Remove BT_HS")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Stable backport scope: retain only the read_unconf_index_list()
allocation-counting change needed by b5dbb41b212c ("Bluetooth: mgmt:
fix race in read_unconf_index_list()"). Drop the HCI_PRIMARY test from
that first pass so the target patch applies without conflicts.

Keep the HCI_PRIMARY test in the response-filling pass. Counting an
unconfigured AMP controller can only reserve extra space; the returned
controller list and response length still include only primary devices.
The target subsequently replaces this flag-dependent count with a count
of every device on the locked list to fix the race.

Linux 5.15 still has BT_HS/AMP support and lacks hci_bcm4377.c and
hci_sync.c. Drop all remaining upstream hunks rather than removing
fields, handlers and driver support that this tree still uses.

The preceding l2cap_connect() UAF fix made its return type void, but the
5.15 AMP create-channel caller still consumes that return value, causing
an allmodconfig build failure. Pass the referenced AMP device into
l2cap_connect() and move the existing AMP channel setup into its locked
region. This retains the void return type and protects the channel until
AMP setup finishes. The caller retains ownership of the device reference
and releases it after l2cap_connect() returns. No new functions are added.

[ sashal: Reduced backport -- upstream 84a4bb6548a29 touches 20 file(s), this
  backport carries 2. Not backported here:
  drivers/bluetooth/btmrvl_main.c
  drivers/bluetooth/btrsi.c
  drivers/bluetooth/btsdio.c
  drivers/bluetooth/btusb.c
  drivers/bluetooth/hci_bcm4377.c
  drivers/bluetooth/hci_ldisc.c
  drivers/bluetooth/hci_serdev.c
  drivers/bluetooth/hci_uart.h
  ... and 10 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: b5dbb41b212c ("Bluetooth: mgmt: fix race in read_unconf_index_list()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 58 +++++++++++++++++++-------------------
 net/bluetooth/mgmt.c       |  3 +-
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0140f82fdc8df..093b8dd184dad 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -58,6 +58,8 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 			   void *data);
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data_size);
 static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err);
+static void cmd_reject_invalid_cid(struct l2cap_conn *conn, u8 ident,
+				   u16 scid, u16 dcid);
 
 static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 		     struct sk_buff_head *skbs, u8 event);
@@ -4202,7 +4204,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 }
 
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
-			  u8 *data, u8 rsp_code, u8 amp_id)
+			  u8 *data, u8 rsp_code, struct hci_dev *amp_hdev)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
@@ -4265,7 +4267,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	chan->dst_type = bdaddr_dst_type(conn->hcon);
 	chan->psm  = psm;
 	chan->dcid = scid;
-	chan->local_amp_id = amp_id;
+	chan->local_amp_id = amp_hdev ? amp_hdev->id : AMP_ID_BREDR;
 
 	__l2cap_chan_add(conn, chan);
 
@@ -4287,7 +4289,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 				 * The connection will succeed after the
 				 * physical link is up.
 				 */
-				if (amp_id == AMP_ID_BREDR) {
+				if (!amp_hdev) {
 					l2cap_state_change(chan, BT_CONFIG);
 					result = L2CAP_CR_SUCCESS;
 				} else {
@@ -4339,6 +4341,27 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		chan->num_conf_req++;
 	}
 
+	/* Finish AMP setup while the new channel is protected. */
+	if (chan && amp_hdev) {
+		struct amp_mgr *mgr = conn->hcon->amp_mgr;
+		struct hci_conn *hs_hcon;
+
+		hs_hcon = hci_conn_hash_lookup_ba(amp_hdev, AMP_LINK,
+						  &conn->hcon->dst);
+		if (!hs_hcon) {
+			cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
+					       chan->dcid);
+		} else {
+			BT_DBG("mgr %p bredr_chan %p hs_hcon %p", mgr, chan,
+			       hs_hcon);
+
+			mgr->bredr_chan = chan;
+			chan->hs_hcon = hs_hcon;
+			chan->fcs = L2CAP_FCS_NONE;
+			conn->mtu = amp_hdev->block_mtu;
+		}
+	}
+
 	l2cap_chan_unlock(pchan);
 	mutex_unlock(&conn->chan_lock);
 	l2cap_chan_put(pchan);
@@ -4350,7 +4373,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
+	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, NULL);
 	return 0;
 }
 
@@ -4917,7 +4940,6 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 {
 	struct l2cap_create_chan_req *req = data;
 	struct l2cap_create_chan_rsp rsp;
-	struct l2cap_chan *chan;
 	struct hci_dev *hdev;
 	u16 psm, scid;
 
@@ -4934,8 +4956,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 
 	/* For controller id 0 make BR/EDR connection */
 	if (req->amp_id == AMP_ID_BREDR) {
-		l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP,
-			      req->amp_id);
+		l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP, NULL);
 		return 0;
 	}
 
@@ -4949,28 +4970,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 		goto error;
 	}
 
-	chan = l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP,
-			     req->amp_id);
-	if (chan) {
-		struct amp_mgr *mgr = conn->hcon->amp_mgr;
-		struct hci_conn *hs_hcon;
-
-		hs_hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK,
-						  &conn->hcon->dst);
-		if (!hs_hcon) {
-			hci_dev_put(hdev);
-			cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
-					       chan->dcid);
-			return 0;
-		}
-
-		BT_DBG("mgr %p bredr_chan %p hs_hcon %p", mgr, chan, hs_hcon);
-
-		mgr->bredr_chan = chan;
-		chan->hs_hcon = hs_hcon;
-		chan->fcs = L2CAP_FCS_NONE;
-		conn->mtu = hdev->block_mtu;
-	}
+	l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP, hdev);
 
 	hci_dev_put(hdev);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5b67247587ba6..8a1fc2d252800 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -460,8 +460,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (d->dev_type == HCI_PRIMARY &&
-		    hci_dev_test_flag(d, HCI_UNCONFIGURED))
+		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
 			count++;
 	}
 
-- 
2.53.0

