Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFB5221E0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911378; cv=none; b=CG6yYqLkUKRAXl1ZM5XVgDaOibLZIGvVJb7L7VIp99fero91N7x/wt5vuJ/VoLV7EM5UpK7XAiaGe0p0lW4TpsV1K+kQPZ1BspP224vMMflGJrdtZu9kcD2lmRq9Cx57WvZYZhIKNjN4Z55S6acBZ2+yP8UT4w67viwsME6IW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911378; c=relaxed/simple;
	bh=6OYMFUiz+Pty5Tk/aSfcPyAv8SUe8BPwQR5g6vcvPKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1RBsVg+LbDaHFj9f70UiTBhbTY5MKE9uPKX2Pduir9IUvMKkCIeOSTxNxwIT1nxoZSyAR3cno3WNAeXSLHXvrvaBRcB9czglPNNBV3PL1WGsc3VqYz+AhOtRDShHY7ZB+QxggItJBzqo4iEhuab53WELIBwVJUX92Xd3MoipiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V85OI/6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V85OI/6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ED81F00893;
	Tue, 13 Oct 2026 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911376;
	bh=5kjU0yUH00I7mrAU8jJdycDhTuemmRd87WV3gNkuh0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V85OI/6Nfmj4dWfkeA4SFOFrqOGc/eVH1HTdSRoC0k2RX5gINtUI34j9qn72bmYXz
	 yRE0w/91icBMrmPSRXtp6ig03TmkKahCEz8kbsvLU8lq2ShPZYbcRYTkmaVx9DKPvN
	 dJvypH1PsMAaeF11J+fWJB1WjJVUEKFb1YTAp8RnYeOgI+61L1z5Pol7Ljj//KtF96
	 lS5fLigwqQ8ZBgOJ102ZId1iqPhvRrthMU3Afglv1+kWwLcqKnKb8ScnZsc0LZ39hf
	 yql7+nul6ogfPKIzte8wyp0Mv0f9qP808lHdQQlKjGppbyQHhOWEnm1e9+KdXTcu6J
	 soWz51wADPTLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] Bluetooth: ISO: Serialize concurrent connect calls
Date: Tue, 13 Oct 2026 13:09:35 -0400
Message-ID: <20261013170911.255700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101225-clench-crowbar-615f@gregkh>
References: <2026101225-clench-crowbar-615f@gregkh>
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
[ sashal: Moved socket locking earlier in the connection helpers to provide the locking coverage assumed by upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 23bd4d8c397f7..2dd8e6e6beac5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -55,6 +55,7 @@ enum {
 	BT_SK_BIG_SYNC,
 	BT_SK_PA_SYNC,
 	BT_SK_PA_SYNC_TERM,
+	BT_SK_CONNECTING,
 };
 
 struct iso_pinfo {
@@ -277,6 +278,9 @@ static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
 		return -EBUSY;
 	}
 
+	if (iso_pi(sk)->conn)
+		return -EISCONN;
+
 	iso_pi(sk)->conn = conn;
 	conn->sk = sk;
 
@@ -321,6 +325,12 @@ static int iso_connect_bis(struct sock *sk)
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
@@ -367,13 +377,9 @@ static int iso_connect_bis(struct sock *sk)
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
@@ -389,9 +395,8 @@ static int iso_connect_bis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -412,6 +417,7 @@ static int iso_connect_cis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	if (!cis_central_capable(hdev)) {
 		err = -EOPNOTSUPP;
@@ -450,6 +456,13 @@ static int iso_connect_cis(struct sock *sk)
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
@@ -457,13 +470,9 @@ static int iso_connect_cis(struct sock *sk)
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
@@ -479,9 +488,8 @@ static int iso_connect_cis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -1000,17 +1008,26 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
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
@@ -1022,16 +1039,18 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
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

