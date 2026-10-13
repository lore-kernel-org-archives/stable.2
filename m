Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD3490BE4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917565; cv=none; b=rDtl8POg6KZLRCFsaWx7pbRwUR8hz+FumOERmLKSUOSE6cLZ7y3ZHkg1jlXnr706B6D1XKYLNYF7z7O9oPhf+jY8eaPHjCDmFJZc8EVL4GvOQz1r/A61N9Cyr6cYbt+cUEIyLZF50HjyU4m0n2dkTsJpPUK6kg2bHPmpi8l/Q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917565; c=relaxed/simple;
	bh=wLL3TvP/meKgmgmjxcflse6I9fbjuJ0AU+wd1SNdEo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th5I0IRqgfprkgyBLdzb8iXThma2edaeYwB6K7BNqdhTXCs7uOr0uydruNYsv1lUtmPkIcSR7Lkxx5ldPTJevtaAo5trWJxDKJ82IiIHaiYRJgV2xc1WhQzaE1/KuopeC/UJvglCsEIbb6GSbvlMCP4ih5oyCyF46tYOfUDmQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPUp2UXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPUp2UXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421A21F00893;
	Tue, 13 Oct 2026 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791917563;
	bh=regyv/Hrn18fgWC37hFasl2TD1BOteoc2ArAdT32zxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oPUp2UXtaWM9eOoxAaGGTb8DdhgiPoLmlSaXjGpeY2uwBuEa6GY6ljQzJbDrlyA/7
	 u5msB/nBZ6EyQVFGou2opdFablRo8cB7AKj6fNGuEaamt131WQavK6gCtTKXSZXyCX
	 ZAq2j+ybOBCZcASEbbJ53Ju9PlkA5YcXESYEXfHTBfwGYy8jei9afhTNJfO1c0dnjd
	 LeJRXVFy2aDfar37rQwf3FQ91NQ4XcsG0f5x0aMsCacbag/+eoP6R24oq4lQ6kIFU3
	 r6cEaj+YMR7wUi5ouXR4Ssf8F6fI7W9k3rXSAlFiS0dNgbtUPdWjJtT04qL2z/tWul
	 PAPmlWcGW892w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Bluetooth: ISO: Serialize concurrent connect calls
Date: Tue, 13 Oct 2026 14:52:42 -0400
Message-ID: <20261013185200.649645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101226-facsimile-revolt-1331@gregkh>
References: <2026101226-facsimile-revolt-1331@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit e32d80293a0e1a160d5e5101daa8c82148c07510 ]

iso_sock_connect() checks the socket state before taking the socket lock
and drops the lock again before setting up a connection. Two callers can
both pass the admission check while the socket is open or bound.

Caller A can copy its destination for route selection, then caller B can
replace the socket destination before A binds or connects the CIS. A
then uses B's destination with the route selected for its own request.
B can also proceed after A attaches a connection and sets BT_CONNECT.
For deferred BIS setup, B can bind a second BIS and overwrite
iso_pi(sk)->conn, leaving the first connection's reference and conn->sk
back-pointer stranded. Concurrent CIS connects can likewise replace the
socket's connection. Later teardown only detaches the current connection,
so a callback on the old connection can race with socket release and
access a freed socket.

KASAN reported:

  BUG: KASAN: slab-use-after-free in iso_sock_hold+0xf7/0x1b0
  Call Trace:
   iso_sock_hold+0xf7/0x1b0
   iso_conn_del+0x7b/0x1d0
   iso_connect_cfm+0x186/0x16a0
   hci_conn_failed+0x154/0x280
   hci_abort_conn_sync+0x3dc/0x7d0
   hci_cmd_sync_work+0x173/0x300

  Allocated by task 121:
   sk_alloc+0x2b/0x6d0
   bt_sock_alloc+0x29/0x370
   iso_sock_alloc.constprop.0+0x19/0x300
   iso_sock_create+0x94/0x100

  Freed by task 121:
   kfree+0x121/0x3c0
   __sk_destruct+0x42b/0x540
   iso_sock_release+0x29d/0x340
   __sock_release+0xa1/0x260

Check admission under the socket lock and mark the connect operation in
progress before publishing its destination. Keep that flag set across
route lookup and connection setup, rejecting another connect with
-EBADFD before it can change the destination or attach a connection.
Clear the flag after either helper returns, including on failure, so a
failed setup can be retried.

A separate flag is needed because the socket lock must be released before
acquiring the HCI device lock, while BT_CONNECT requires an attached
connection. Keep the existing state transitions and the deferred CIS
completion through iso_sock_recvmsg().

Reject an existing socket attachment in __iso_chan_add() before taking
a new reference or publishing either pointer, so every caller preserves
the connection association. Keep the same-socket, same-connection success
case for deferred CIS setup. Reject an attached socket before BIS setup
so a reusable BIS is not claimed before the attachment is rejected.

In CIS setup, reject a different HCI connection before iso_conn_add()
and drop the per-attempt HCI hold directly. An unowned iso_conn may still
carry another reference after detachment, so its destruction cannot be
relied on to release that hold.

iso_listen_bis() creates a fresh PA HCI/ISO pair under the device lock,
so the temporary iso_conn_put() frees the ISO candidate and drops its
HCI hold on rejection. iso_conn_ready() uses a freshly allocated,
unpublished child with no connection, making the socket-side rejection
unreachable.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Suggested-by: Pauli Virtanen <pav@iki.fi>
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ sashal: adapted attachment checks to direct connection assignment by moving socket locking earlier. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 73 +++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7ffb47a12dd3d..d809c5c13319c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -49,6 +49,11 @@ static void iso_sock_kill(struct sock *sk);
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
 #define EIR_BAA_SERVICE_UUID	0x1851
 
+/* iso_pinfo flags values */
+enum {
+	BT_SK_CONNECTING,
+};
+
 struct iso_pinfo {
 	struct bt_sock		bt;
 	bdaddr_t		src;
@@ -59,7 +64,7 @@ struct iso_pinfo {
 	__u8			bc_num_bis;
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
 	__u16			sync_handle;
-	__u32			flags;
+	unsigned long		flags;
 	struct bt_iso_qos	qos;
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
@@ -225,6 +230,9 @@ static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
 		return -EBUSY;
 	}
 
+	if (iso_pi(sk)->conn)
+		return -EISCONN;
+
 	iso_pi(sk)->conn = conn;
 	conn->sk = sk;
 
@@ -269,6 +277,12 @@ static int iso_connect_bis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
+
+	if (iso_pi(sk)->conn) {
+		err = -EISCONN;
+		goto unlock;
+	}
 
 	if (!bis_capable(hdev)) {
 		err = -EOPNOTSUPP;
@@ -296,13 +310,9 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	lock_sock(sk);
-
 	err = iso_chan_add(conn, sk, NULL);
-	if (err) {
-		release_sock(sk);
+	if (err)
 		goto unlock;
-	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -315,9 +325,8 @@ static int iso_connect_bis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -338,6 +347,7 @@ static int iso_connect_cis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	if (!cis_central_capable(hdev)) {
 		err = -EOPNOTSUPP;
@@ -369,6 +379,13 @@ static int iso_connect_cis(struct sock *sk)
 		}
 	}
 
+	/* The socket lock keeps the current attachment and its hcon stable. */
+	if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon != hcon) {
+		hci_conn_drop(hcon);
+		err = -EISCONN;
+		goto unlock;
+	}
+
 	conn = iso_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
@@ -376,13 +393,9 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
-	lock_sock(sk);
-
 	err = iso_chan_add(conn, sk, NULL);
-	if (err) {
-		release_sock(sk);
+	if (err)
 		goto unlock;
-	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -398,9 +411,8 @@ static int iso_connect_cis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -847,17 +859,26 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
-		return -EBADFD;
+	lock_sock(sk);
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		return -EINVAL;
+	if ((sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) ||
+	    test_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags)) {
+		err = -EBADFD;
+		goto done;
+	}
+
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
 
 	/* Check if the address type is of LE type */
-	if (!bdaddr_type_is_le(sa->iso_bdaddr_type))
-		return -EINVAL;
+	if (!bdaddr_type_is_le(sa->iso_bdaddr_type)) {
+		err = -EINVAL;
+		goto done;
+	}
 
-	lock_sock(sk);
+	set_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags);
 
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
 	iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
@@ -869,16 +890,18 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 	else
 		err = iso_connect_bis(sk);
 
-	if (err)
-		return err;
-
 	lock_sock(sk);
 
+	clear_bit(BT_SK_CONNECTING, &iso_pi(sk)->flags);
+	if (err)
+		goto done;
+
 	if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		err = bt_sock_wait_state(sk, BT_CONNECTED,
 					 sock_sndtimeo(sk, flags & O_NONBLOCK));
 	}
 
+done:
 	release_sock(sk);
 	return err;
 }
-- 
2.53.0

