Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4993A3812
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212816; cv=none; b=fK2U+EDf7xYOyo7kCFmybqgre8J55dpHtVKa2hVClJLtP06VkcE9FEY+ooj4OmJwdQGqG4R3989zer+NdzJsgstZKMbAbNI0T4hby5C6cNOrqRF+RaPgbDElhKfqaOA2kV8YWxcDjOerSVmC3oxOZkatnNGs6OtsWaST2Ybz1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212816; c=relaxed/simple;
	bh=VHk9tnXgTX4un92G83jhAlGoUOM9u54+bmUVg2GyEsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8vqvQEJJmmaArTlQ9eyu74nahuyHfxVhZ3oAh7vt47JG6YBEGLpgEmw3QzemSw/9rm8vFqYCE4OOK0LcBOIYttL0Mj93wnzGObABkHAivrJuQl5445hxpj/wcD14KbBUzsR8V3h+oYiESoV4EangFHzclGdcWZEBeazM2LJhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S86o6E1v; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S86o6E1v"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3450418b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785212815; x=1785817615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U/7RjL9K8RAni2hscSrAMUdMIsxUqYfJ9Fu6xqaJi30=;
        b=S86o6E1vGH+/shmK+eKKRz8xxJpnU3QJcZH5TqtorFWYm+AQoaUSG/s8F59zT54s2G
         Y9n5WMSD+3beqAn/dEntxXUhHhtN6bR4ryxpCa8+NnQG2fmUarNeL7Z1VS1nmFytuitt
         Sm47r+Wva7qzaLPqa5KJyMtIuRhal7utdts2nQI1EQAQzQVj2ADrCQBj69KHI8OeWYyA
         NdBOM7nQw92joC/rkcenqCqwRWgrrsNyvRrMGVOlbMaJgCUDonZX3272bZ39tgjjnoDt
         MCcTANiCkVsWwdeqj1L8thbpIRECARDMjdlrEXCvuo+lPgdksMsEl2h2v+dpxKrr9KwU
         Ruag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785212815; x=1785817615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U/7RjL9K8RAni2hscSrAMUdMIsxUqYfJ9Fu6xqaJi30=;
        b=cWLX+9M7Cayn9IcMNwRHce4R9iPtR13L12ALroBzySJYCsbKKiWRAyRpbvgT/Eusb6
         FbZKnq5ow5xL4yxW756ebInAfWLv4hlHUI1njzrtg4WcS8+Fh7+aBZAOKO89gmawUk+U
         r0H8ss8NocQSu5xv8qdGXvRQLQxsIYc8/qqt8eczdDXmkHzxE2KvTbU7wFfBartS3QLi
         Q1b0o/QPQevrEBZaXlADlkgThQuNXTzvt8IJ7MCb2oYgRQAfBznM1C3kuMcxuIeaHlH7
         VGkDaDxwPXYPlp5cJo98JBOAJvtqHgFDmjE9fn/So9rQL8ZC689jr0ndK5pC5q1EyHJl
         IFVw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+jEASwlFFZqFMpJTpbUqdnUEWNoRm41ztov4HsCJmrgzC+xfyDIWeT7T2mP/101+WU/LVow8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkxHxX+SWzeJ2fUpqswdBH4jRv5AT/v1XMCQM5IuBI13y94nUw
	A68SVcsUOEzr+r6e3eCgDAO8+1rbMI4eEa+k0hc/JVVaIOWP2scGgAav
X-Gm-Gg: AR+sD10Fy1CsZJNzY4YyA83hmvmJ6mURfAnZE0TUzW+r3FvA+92nyI21xQfta7iZLqw
	hAi/bC9HjBnWulGnVvpSyTw1dFvzyogibDgRB0OoI2tCUW6XK5ADlgWr/GMFJBYmZ2hgXTxPYAH
	ycnkobkaeYa9BF2TqIRQ4AOBj0lHnLhmBXo1g3T1QidUHmr0Sp1gPH8to8EJmxUo6jARv1RgwWo
	QwRfqCIonZRoG0vHQkI2LYiKFmn5tIfXY4JXHF1VNdJTLTVwTcNm8wR2A1nB9Dpbn5A99nORehM
	NvK5+HQIBGT53597r2x+FAQPUZl2iiI8ADW8wGFf6iCsQA/jjHfs4uIc8FyMXdmzLmD4GynEkNy
	Fq+sz+50AINFsoBitd/o60GXKWncEVJDz++H7Y3A8yY0O/0WiPOvvqQVBFmy75ztq+NT1N+jP9r
	Uj9XunNA==
X-Received: by 2002:a05:6a00:cd3:b0:847:9151:3409 with SMTP id d2e1a72fcca58-84e9335fe7emr781324b3a.55.1785212814475;
        Mon, 27 Jul 2026 21:26:54 -0700 (PDT)
Received: from beelink.. ([94.156.205.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b2867sm4058943a12.15.2026.07.27.21.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:26:54 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
Date: Tue, 28 Jul 2026 01:26:39 -0300
Message-ID: <20260728042639.1315193-1-qwe.aldo@gmail.com>
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
v2: quote the inlined code and KASAN splat in the commit message with
    spaces instead of hard tabs, to satisfy the bluez CI gitlint check;
    no functional change (CI sco-tester and sparse pass).

 net/bluetooth/sco.c | 84 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3d4362a09df4..8df0fa48fc60 100644
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

