Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233812B9B7
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197833; cv=none; b=et3sDa0lVY3JXRP8gNJyV8laTuVPf2pJnvTOwYbxwvnM4DguZ6jViYEroUT4ar6Qhr15b+YBTu9SAsMD9j/F6fWkCKlAOAq6yYT3V60P6KfZuv3FDskUoax9fZmWPOrw4e0nxv+T/FKzuz4K8IL0tqxf41wLg6trjrZ4/QrHcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197833; c=relaxed/simple;
	bh=8Js8wZRcpU48iTKQ/To9hKkMo2ZGHlw8eyR+n7PZ+lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kX01a9I11p1XB9mBYU8aYpcQL2U1H3O8HGKUJDF1VzeNDPbIyE3yKqUdW7Orir6EatM2W0F4aeMy9HJBwZSfn+oYYFE77A0a98gulXcRPZvtPQL31FfhWwcCMglmrYcFUl/rJvPvFryupkavySXd8AEpWpSQnn7tORY/JaMNQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ9/UEAm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ9/UEAm"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so3404328b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785197831; x=1785802631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x3LqIU13UVLNl/mP5cmMkdDanFvCHhY96m+D7CkouA4=;
        b=bQ9/UEAmmyRbPGic4BSCXU+/daby/6gsYQrTlrZxcUOrsNQX6eS+WuRCzey9Ex9IUB
         7tdt5+St0UIQ7isWzXuObO3+OCCcI07MjhXs+RFQLfDaqy8kv5JTq65Rn3ZNbTBELEzv
         SfPgQy2ynp7cLGTH+Znw87ry20ULmlPHQp2IhkepS5JLTnbYRjyH/qZkHPDA6W68A1j5
         0SL71CIVak2X7PJw3DmS1GabllQdA1owHkkYiMPpf179Q0oEjlqz8kEB7QqfWwBqpYGL
         UhRqCxIKvjWKu4xwyXjSBLpYKspOlzzi4Nxz42Fs5axRjSE1IfKNIxdDH8qKEwKTm1aR
         +e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197831; x=1785802631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3LqIU13UVLNl/mP5cmMkdDanFvCHhY96m+D7CkouA4=;
        b=pPyDEYa5nwsgsvo//KHb7IOEbdMoEn67o2u0lYutSB7rmUbIejjtt+G19xRsiZDKfn
         Tf6GYb9/x4MF8uoo24kjamr19G2TMfuFEJR4xa/wAwZsWcYiFibXTPH0c/gPDAVuW6BW
         Zi10qJoQQL7RfuWuqMbST96FNw8gavqGdMgwVaNjNxI08LtBPRnh7GXIy/uG+on53LN3
         fCsTpEvZtVeh5fOoA+hThH2SgoupONxX5SDapJ6uFLUQdfwzI0+oM17jl3ca9dqq5e9E
         hPT1PmSp89LaXFLLLLwzmJwWtv6II6hKrP3B72rdYzyAuKFj29wXSgqBos5NQLWMA3GB
         ULWg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5//p4IsUEXlbqktTTjknFBTFi8sRx+0CqD6I2o6POBemxcsx61k4dMI135h9QjSiFUFmXL/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcvz0iomQtKECF7M/rIiusj4+Mh7oEkEgmHDiWynZRKysqegfr
	GIdafY53vnVW8FBMj5u0o2Pb6e5F9gyupm/MfMTeN+F6bRPyhWYp5/kyCbvo1J1MgRIiJw==
X-Gm-Gg: AR+sD10sbR+fTQd3kKHKgiTajRa4ZUnMOAyvUqzEw1a2R7FIOWqsDl2FYjK0wpjIKxy
	2byoNZ5Dt4mvABx0Uypa4L0A+PTtIW9uOCRw3ZQDofjNYCTLnRbyJ7Y2NEwtdgUUX4HWxiCAOfh
	kK9aHZtP2ScNzczbbJBZZH9IqnVwwgbvkn5fxA79tKLAhhnItqiezmdKlFtN06Qy/biAqgDpDlJ
	WpoPo/5spzON2A7R06y8y6fMj+YSAfll5696/2HvqYsR9pC9Agd/msc/FUOsUVqmnL0QaAU1cdP
	aaz9duh7Q5b5rXmEDiDEn+NIlceYufz2J3zJoA3C83yofe2YiMkdjUfO6xVPVKC3G2+9QEoEugb
	mE24FZ+7GLQY2KObVFgIv1U1kR213AysaqFM0ujBntU3/Ug5Y83Rmlbd3T7xt+wnflXuPj5E=
X-Received: by 2002:a05:6a00:3a0f:b0:848:2f74:d8d9 with SMTP id d2e1a72fcca58-84e9345816emr61485b3a.74.1785197831282;
        Mon, 27 Jul 2026 17:17:11 -0700 (PDT)
Received: from beelink.. ([94.156.205.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533ce1f7sm3629824b3a.34.2026.07.27.17.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:17:10 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
Date: Mon, 27 Jul 2026 21:16:54 -0300
Message-ID: <20260728001654.965175-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_recv_scodata() upgrades the weak hcon->sco_data back-pointer to a
strong reference under hdev->lock:

	hci_dev_lock(hdev);
	hcon = hci_conn_hash_lookup_handle(hdev, handle);
	...
	conn = sco_conn_hold_unless_zero(hcon->sco_data);
	hci_dev_unlock(hdev);

but the pointer is cleared from the other side without that lock. When
the last sco_conn reference is dropped, sco_conn_free() ran

	conn->hcon->sco_data = NULL;

with no hdev->lock held, so the RX path could read hcon->sco_data and
call kref_get_unless_zero() on an sco_conn that was concurrently freed:

	BUG: KASAN: slab-use-after-free in sco_conn_hold_unless_zero+0xbe/0x160
	Write of size 4 by task kworker/u17:0
	Workqueue: hci0 hci_rx_work
	Call Trace:
	 sco_conn_hold_unless_zero+0xbe/0x160
	 sco_recv_scodata+0x13f/0x490
	 hci_rx_work+0x3af/0x730

kref_get_unless_zero() only guards against a zero refcount, not against
the backing memory already being freed.

Give hcon->sco_data an actual reference on the sco_conn it points to, so
the object cannot be freed while the pointer is still installed, and only
clear and drop it from sco_conn_del(), which runs under hdev->lock (its
callers, sco_connect_cfm() and sco_disconn_cfm(), hold it). The reader in
sco_recv_scodata() also takes hdev->lock, so the store and the read are
now serialised: the RX path either observes NULL or a reference that is
guaranteed to stay valid until it drops its own.

sco_conn_add() no longer hands its kref_init() reference to the caller as
the connection's only reference; that initial reference is the one owned
by hcon->sco_data, and callers get their own via sco_conn_hold().

Because the sco_conn can now outlive the socket (the association keeps it
alive until the link goes down), the hci_conn can no longer be dropped
from sco_conn_free() without regressing socket close: closing a connected
SCO socket must still tear the link down. Move hci_conn ownership to the
socket instead: __sco_chan_add() takes an hci_conn reference and it is
released from sco_chan_del() and sco_sock_destruct(), exactly once. The
sco_conn no longer owns an hci_conn reference, so sco_conn_add() stops
consuming one and sco_connect() drops the hci_connect_sco() reference on
every path; sco_connect_cfm() no longer needs its hci_conn_hold() dance.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/sco.c | 84 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3d4362a09..8df0fa48f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -84,12 +84,14 @@ static void sco_conn_free(struct kref *ref)
 	if (conn->sk)
 		sco_pi(conn->sk)->conn = NULL;
 
-	if (conn->hcon) {
-		conn->hcon->sco_data = NULL;
-		hci_conn_drop(conn->hcon);
-	}
+	/* hcon->sco_data is cleared and the association's reference on the
+	 * sco_conn is dropped in sco_conn_del() under hdev->lock, and the
+	 * hci_conn is now owned by the socket (held in __sco_chan_add() and
+	 * dropped in sco_chan_del()/sco_sock_destruct()), so there is nothing
+	 * left to release towards hcon here.
+	 */
 
-	/* Ensure no more work items will run since hci_conn has been dropped */
+	/* Ensure no more work items will run before the connection is freed */
 	disable_delayed_work_sync(&conn->timeout_work);
 
 	kfree(conn);
@@ -188,8 +190,11 @@ static void sco_sock_clear_timer(struct sock *sk)
 }
 
 /* ---- SCO connections ---- */
-/* Consumes a reference on @hcon, which the returned sco_conn owns until it is
- * freed. On failure (NULL return) the reference is left for the caller to drop.
+/* Returns a new reference the caller must drop with sco_conn_put(). The
+ * hcon->sco_data association holds its own reference on the sco_conn for the
+ * connection's lifetime; it is dropped in sco_conn_del() under hdev->lock.
+ * @hcon is not consumed: the hci_conn reference is taken and owned by the
+ * socket in __sco_chan_add().
  */
 static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
@@ -201,9 +206,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 			sco_conn_lock(conn);
 			conn->hcon = hcon;
 			sco_conn_unlock(conn);
-		} else {
-			/* conn already owns a reference on hcon */
-			hci_conn_drop(hcon);
 		}
 		return conn;
 	}
@@ -227,7 +229,10 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 
 	BT_DBG("hcon %p conn %p", hcon, conn);
 
-	return conn;
+	/* kref_init() above set the association reference owned by
+	 * hcon->sco_data; hand the caller its own reference.
+	 */
+	return sco_conn_hold(conn);
 }
 
 /* Delete channel.
@@ -242,9 +247,20 @@ static void sco_chan_del(struct sock *sk, int err)
 	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
 
 	if (conn) {
+		struct hci_conn *hcon;
+
 		sco_conn_lock(conn);
 		conn->sk = NULL;
+		hcon = conn->hcon;
 		sco_conn_unlock(conn);
+
+		/* Release the socket's own reference on the hci_conn taken in
+		 * __sco_chan_add() so that closing the socket still tears the
+		 * link down even while the sco_conn is kept alive by the
+		 * hcon->sco_data association reference.
+		 */
+		if (hcon)
+			hci_conn_drop(hcon);
 		sco_conn_put(conn);
 	}
 
@@ -266,6 +282,15 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	/* Detach the connection from the hci_conn and drop the reference held
+	 * by the hcon->sco_data association.  The caller holds hdev->lock,
+	 * which serialises this NULL store and put against the read of
+	 * hcon->sco_data in sco_recv_scodata(), closing the use-after-free
+	 * where the RX path could upgrade an already-freed sco_conn.
+	 */
+	hcon->sco_data = NULL;
+	sco_conn_put(conn);
+
 	sco_conn_lock(conn);
 	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
@@ -290,6 +315,13 @@ static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	sco_pi(sk)->conn = sco_conn_hold(conn);
 	conn->sk = sk;
 
+	/* The socket owns a reference on the hci_conn for as long as it stays
+	 * attached; it is dropped in sco_chan_del()/sco_sock_destruct().  This
+	 * keeps close() tearing the link down now that the sco_conn can outlive
+	 * the socket through the hcon->sco_data association reference.
+	 */
+	hci_conn_hold(conn->hcon);
+
 	if (parent)
 		bt_accept_enqueue(parent, sk, true);
 }
@@ -371,6 +403,7 @@ static int sco_connect(struct sock *sk)
 	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
 		release_sock(sk);
 		sco_conn_put(conn);
+		hci_conn_drop(hcon);
 		err = -EBADFD;
 		goto unlock;
 	}
@@ -379,6 +412,7 @@ static int sco_connect(struct sock *sk)
 	sco_conn_put(conn);
 	if (err) {
 		release_sock(sk);
+		hci_conn_drop(hcon);
 		goto unlock;
 	}
 
@@ -395,6 +429,11 @@ static int sco_connect(struct sock *sk)
 
 	release_sock(sk);
 
+	/* The socket took its own hci_conn reference in __sco_chan_add(); drop
+	 * the one returned by hci_connect_sco().
+	 */
+	hci_conn_drop(hcon);
+
 unlock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -495,9 +534,26 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
 
 static void sco_sock_destruct(struct sock *sk)
 {
+	struct sco_conn *conn = sco_pi(sk)->conn;
+
 	BT_DBG("sk %p", sk);
 
-	sco_conn_put(sco_pi(sk)->conn);
+	/* If the channel was not already torn down via sco_chan_del(), drop the
+	 * socket's own references here.  sco_chan_del() clears sco_pi(sk)->conn,
+	 * so the hci_conn and sco_conn references are released exactly once.
+	 */
+	if (conn) {
+		struct hci_conn *hcon;
+
+		sco_conn_lock(conn);
+		hcon = conn->hcon;
+		sco_conn_unlock(conn);
+
+		if (hcon)
+			hci_conn_drop(hcon);
+		sco_pi(sk)->conn = NULL;
+		sco_conn_put(conn);
+	}
 
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
@@ -1511,12 +1567,10 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 	if (!status) {
 		struct sco_conn *conn;
 
-		conn = sco_conn_add(hci_conn_hold(hcon));
+		conn = sco_conn_add(hcon);
 		if (conn) {
 			sco_conn_ready(conn);
 			sco_conn_put(conn);
-		} else {
-			hci_conn_drop(hcon);
 		}
 	} else
 		sco_conn_del(hcon, bt_to_errno(status));
-- 
2.43.0

