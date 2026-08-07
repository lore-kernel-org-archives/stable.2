Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938D1A6838;
	Fri,  7 Aug 2026 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064425; cv=pass; b=Udm0XACjyx3NfBJ8S2Szjt/rbtRYtWLbjRQmcJGY6eCZ0QH9E6oUXFyhe4Aqjch+w0NXGKKKa9bMxYIiOaxMqiNonDdDMu6n8GZ0+pi5/c8pIs2U1HtBqIXxY75ooQucDvB37v0ZxngKsDr2QHx3kaYhGHWCLIPJVUwMQv0R0V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064425; c=relaxed/simple;
	bh=LuLyGRHvP+K07weEZ1UwtQM7rNKzqoqPNi/xJ9y60dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZMC/B4fTGvPdpDYZJING0Ws327p/sVemOBefoE+70I3SxXVEVnSNYKTrsENuVHtsJa1M7XPbxq24VG2ufAW6IWhlIL4LmeYU5yeIPjs9Fw2zGCcX33en0GbpunwWWIJxmMHijj3p8OkyI93UftTA6/IUQYh0UdS1G9V8EJxbj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=qAP2TCaL; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="qAP2TCaL"
ARC-Seal: i=1; a=rsa-sha256; t=1786064417; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YckDiuaXNpLqEkXQ8pIp+ccEh9O7bR+s6/T6VnHmdz2wFwhNgE2AzuVXqVVIX2dD7B/sH1iyMW2Yc/Qn30eeSNhNSu4tYBCqMkSmq4scium/YNlcTlutTWEVT+brO1kbJPP4h4S9xWFIR1CAxDOMzsb2BPrZufdwL0mEjXNk+RE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786064417; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iHKzdv1ZtKA+mruR/OY/sYC8kV842C752BtaVRYWi0Q=; 
	b=eA5mIAvmEU4wEB+z3CnVLFvAzeq3MNuHQU6pzO9BDzD7gvmcT500YMtQzG0zA9nHHiXlfPHnn8uAmvUES7QE6dR09QRk/kkDP+0XIOMGBN0cSZOlVZkr897P35ryGD1Fihr010CEQAWJ/mnk/TLsHlS0urUBAOzmjLMUhux4CE4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786064417;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iHKzdv1ZtKA+mruR/OY/sYC8kV842C752BtaVRYWi0Q=;
	b=qAP2TCaL41ZdQcDoWy9qeJg17IgR5NcARW6fY5MvA8wW0QczvKv4xJttWmaOCw1V
	5LvhN6hlw6Ebe3t9wczqSqM76PJc/ATVivWRTGz2biMmWAq9wNZVzYqtKKtS6D5VF8D
	psqXnxvs1Dez7YGozMQWoQTkLI1hwt/zkg4jwm6k=
Received: by mx.zoho.eu with SMTPS id 1786064413957699.6254122961409;
	Fri, 7 Aug 2026 03:00:13 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync
Date: Fri,  7 Aug 2026 00:59:55 +0000
Message-ID: <20260807010003.85655-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

iso_sock_recvmsg() handles the deferred setup of a broadcast sink by
dropping the socket lock, calling iso_conn_big_sync() and taking the
lock again:

	release_sock(sk);
	iso_conn_big_sync(sk);
	lock_sock(sk);

	sk->sk_state = BT_LISTEN;

The state is written unconditionally, but iso_conn_big_sync() returns
void and has paths that do nothing at all: hci_get_route() may fail, and
after re-acquiring the socket lock the connection may already be gone,
in which case it bails out without ever issuing an LE BIG Create Sync.

While the lock is dropped the connection can be torn down, for example
when the controller reports HCI_EV_LE_PA_SYNC_LOST:

	hci_le_pa_sync_lost_evt()
	  hci_disconn_cfm() -> iso_disconn_cfm() -> iso_conn_del()
	    iso_chan_del()
	      iso_pi(sk)->conn = NULL
	      sk->sk_state = BT_CLOSED
	      sock_set_flag(sk, SOCK_ZAPPED)

iso_conn_big_sync() then finds conn == NULL and returns, but the caller
still overwrites the BT_CLOSED that iso_chan_del() has just set. The
socket ends up marked BT_LISTEN with no connection, so recvmsg() reports
success for a setup that never happened and a later accept() waits for
BIS connections that can never arrive instead of failing.

A concurrent shutdown() reaches the same write by another route:
__iso_sock_close() takes the BT_CONNECT2 PA sync path to
iso_sock_disconn(), which sets BT_DISCONN but leaves conn and
conn->hcon in place, so iso_conn_big_sync() succeeds and BT_LISTEN is
written over BT_DISCONN. Both the BT_CONNECT2 and the BT_CONNECTED case
write the state the same way.

Let iso_conn_big_sync() report whether the BIG sync was started, and
only move the socket to BT_LISTEN when it was and when the state has not
changed while the lock was dropped, mirroring what the BT_CONNECT case
of the same switch already does with iso_connect_cis(). Both conditions
are needed, the error alone does not cover the shutdown() race.

This corrupts the socket state machine only, it is not a memory safety
issue. KASAN and lockdep stayed quiet in all of the runs below.

Reproduced with an emulated controller over /dev/vhci on a KASAN +
PROVE_LOCKING kernel. A PA sync broadcast sink socket is driven to
BT_CONNECT2 and recvmsg() on it is raced against teardown, with a debug
delay inside the lock-dropped section to widen the window:

 - HCI_EV_LE_PA_SYNC_LOST injected: 64 of 64 rounds left the socket in
   BT_LISTEN with the connection gone, recvmsg() returned 0 and accept()
   on that fd returned EAGAIN, which iso_sock_accept() can only do while
   the socket is BT_LISTEN. With this patch, 0 of 64, recvmsg() returns
   an error and accept() returns EBADFD.

 - shutdown() instead of a controller event: 24 of 32 rounds wedged in
   BT_LISTEN, 0 of 32 with this patch. With only the error check in
   place and a short window, one round still wedged while recvmsg()
   returned 0, which is the case the state re-check covers.

An unraced control round behaves the same before and after: recvmsg()
returns 0, the socket reaches BT_LISTEN and an LE BIG Create Sync is
issued.

Fixes: 7a17308c1788 ("Bluetooth: iso: Fix circular lock in iso_conn_big_sync")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 net/bluetooth/iso.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e5b2168e8819..aa2ce78f56a2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1660,9 +1660,9 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
 	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
 }
 
-static void iso_conn_big_sync(struct sock *sk)
+static int iso_conn_big_sync(struct sock *sk)
 {
-	int err;
+	int err = 0;
 	struct hci_dev *hdev;
 	struct iso_conn *conn;
 	bdaddr_t src, dst;
@@ -1677,7 +1677,7 @@ static void iso_conn_big_sync(struct sock *sk)
 	hdev = hci_get_route(&dst, &src, src_type);
 
 	if (!hdev)
-		return;
+		return -EHOSTUNREACH;
 
 	/* hci_le_big_create_sync requires hdev lock to be held, since
 	 * it enqueues the HCI LE BIG Create Sync command via
@@ -1693,8 +1693,10 @@ static void iso_conn_big_sync(struct sock *sk)
 	 * both before dereferencing conn->hcon.
 	 */
 	conn = iso_pi(sk)->conn;
-	if (!conn || !conn->hcon)
+	if (!conn || !conn->hcon) {
+		err = -ENOTCONN;
 		goto unlock;
+	}
 
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 		err = hci_conn_big_create_sync(hdev, conn->hcon,
@@ -1710,6 +1712,8 @@ static void iso_conn_big_sync(struct sock *sk)
 	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
+
+	return err;
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
@@ -1734,10 +1738,19 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		case BT_CONNECT2:
 			if (test_bit(BT_SK_PA_SYNC, &pi->flags)) {
 				release_sock(sk);
-				iso_conn_big_sync(sk);
+				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
 
-				sk->sk_state = BT_LISTEN;
+				/* The socket lock was dropped, so the
+				 * connection may have been torn down
+				 * meanwhile and iso_chan_del() may have
+				 * already moved the socket to BT_CLOSED.
+				 * Only move on to BT_LISTEN if the BIG sync
+				 * was actually started and nothing else has
+				 * changed the state.
+				 */
+				if (!err && sk->sk_state == BT_CONNECT2)
+					sk->sk_state = BT_LISTEN;
 			} else {
 				iso_conn_defer_accept(pi->conn->hcon);
 				sk->sk_state = BT_CONFIG;
@@ -1748,10 +1761,11 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		case BT_CONNECTED:
 			if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
 				release_sock(sk);
-				iso_conn_big_sync(sk);
+				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
 
-				sk->sk_state = BT_LISTEN;
+				if (!err && sk->sk_state == BT_CONNECTED)
+					sk->sk_state = BT_LISTEN;
 				early_ret = true;
 			}
 
-- 
2.55.0

