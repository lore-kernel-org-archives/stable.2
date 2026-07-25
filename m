Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D9394788
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785009163; cv=none; b=VXY8Y/a8vGpI0t6T6LUUcl6CIYWyXShR+f/C33lZ1xYjhmrHKwp5prmJy+6NOsG/4XGNpof+keCrROdrs//mAk2ALCl0uyFbxVVD14cAU8bye/DZqBwn+ncd7fvFdP+GSldyVgBNox/by1lSPGqIEDHajyED9mc2jl623CrLfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785009163; c=relaxed/simple;
	bh=sQUfWYbBbGAFGnb9f4oxJ1jqLUWP/syj4X/dNhx4/rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUtfegdtmtiNX5sfSq+o/E5nu0BarPJ5AmckpBB5YvPYijGQ7M+kuX4TMnmudsc7NiMaTWMqkOlCdlB4314OS5tdlZhLTBpxmOtEWZmCuXZ65gJNBoF8lt4yUXEvXak+vI9JAq8ocrV0ra9K8bM10i0cvRkqui8H0RWdyt8aCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw5bWoRN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw5bWoRN"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso480911a34.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785009161; x=1785613961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPEwWoUe7xfClrZacEsfK1+k1qltAEaeL9m2pmWgCQ0=;
        b=Pw5bWoRNv/lKoBRTxOA4e63rbToJ44cYju8RzfV+guIY5V+NBDOMx+ZoJlWJDXAcbZ
         YRbbCJ0ESe5yINkmV1C+lDIHZbPhi6i0Q/94I7i7fkX/KYqZcfmFpg4luvE1y23iwINE
         1hM5VRNMMxHEo94b7AluKBV4Wzxoe7s+0lNi4fHT0EY2oNfdFjZPuUJj1GmLKMrOa3DP
         JCT2qZTNxfMGdCVKGsjjVPRFAz04F61owMpkKaMcqtQVgkL65qWazV33uVbLb8iIghHO
         9/THNylmLd9bU3rdTVaNQTt1eMhirLf+tIOrimSGedm+XL36uigntDtCcAb7B2K3YVyD
         pxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785009161; x=1785613961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPEwWoUe7xfClrZacEsfK1+k1qltAEaeL9m2pmWgCQ0=;
        b=m9oplrbdOlC67Ke+yYSuXCb1a+c+5K1MRgL+1163nMMmJlzMvWq0iCbvz//GqIIKf8
         h/0bpSY9QxbvMwoZrfyZ3IT+BOaGSkO1aWI/FET/NBT8+jIsXVflRnZ1pSp+m0rW1cZD
         97QGKOw6CrGRGfFhZBnksdJWCWufwd1O7znkGvo0Rx9TJ5jZRr2xjIgQsG7zH7lKqce5
         EUDfMaydgS8Mic00h/HZ8sAfyenm/phwZf/wus6Wbekj+nlKpX0hKkbQpTosH9k6kX6K
         his64WU99fCWwnndMsMteM8cPEpzKA+GFwA6Pb9iHo0ZirOTV1iC1hvU3r7FkLzPsSzn
         h0hg==
X-Forwarded-Encrypted: i=1; AHgh+RrmMWkpDQNrG2OARM3GjhERDzzgADrbm9mbyn7A5vIBpsg+XDxv0XwB69Yq3T8y152eoroKbFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfH9UXufDBQPpVp9R+aRZcLNo9JciKVrZpaZPiUtaDC8uVfG2l
	8awzhEj0FjQ+TiGTDdDb2BNG9e5fja1G95guYA8vo6c5dAeICwKslOwj
X-Gm-Gg: AR+sD12VUaEq7p3gR4sEH2BFlEMi4CqRcN6NMI87SGBLwM3KvcA0DIXcvBBrpOywSt5
	afQAdINw9JsxoUpH70YOPoFcFOXZVJfwxUH5Gjmt4lNnfRspZG0HcgR7aRIYBsJpvL3DMsnvk5x
	iCMR6bQ9OhUYKJtGGvYjKMqW/C7pDdGKQvH/1RHWAzy1b/3EY5FmaoRX9DpXHtwKUCe5c6Men7n
	G/icfug52u7I+7qLKydYbL9yFpurOBIOWeKlePkRAH8lEKsu1OcO3e/ONjtvldq655KyysyqTV/
	W0US/Hxhe70w7XVmq5r+P2tqstBOvVmYn2HX29yIug6DJTudSTto0niTkz5rRim0yd/h8kVS34/
	1BNK0KNimn7MZDrRNgciimsnzXsFR88OT8rVcHLzdrP4MPRYJJB+isldc7fdaPODYkikHSvQz
X-Received: by 2002:a05:6830:4181:b0:7e7:76f:3ec0 with SMTP id 46e09a7af769-7ee78c77bc8mr2670398a34.15.1785009160499;
        Sat, 25 Jul 2026 12:52:40 -0700 (PDT)
Received: from beelink.. ([155.133.15.206])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e0ec5bsm8837163a34.10.2026.07.25.12.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 12:52:40 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] Bluetooth: SCO: give the socket its own sco_conn reference
Date: Sat, 25 Jul 2026 16:52:30 -0300
Message-ID: <20260725195230.967546-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c6e534e497ee771ca80e5f3c6223eaf305bca48c.camel@iki.fi>
References: <c6e534e497ee771ca80e5f3c6223eaf305bca48c.camel@iki.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn_del() drops a reference it does not own. It takes one transient
reference via sco_conn_hold_unless_zero() and releases it with the
sco_conn_put() that follows sco_sock_hold(); the additional put in the
!sk branch releases a second one:

    conn = sco_conn_hold_unless_zero(conn);
    ...
    sk = sco_sock_hold(conn);
    sco_conn_unlock(conn);
    sco_conn_put(conn);

    if (!sk) {
            sco_conn_put(conn);
            return;
    }

When close() races the controller's Disconnection Complete, sco_chan_del()
clears conn->sk and drops the socket's reference while sco_conn_del() is
running. sco_conn_del() then sees sk == NULL, its own put drops the count
to zero and frees the conn, and the second put writes to the freed kref:

    BUG: KASAN: slab-use-after-free in sco_conn_put.part.0+0x1a/0x190
    Write of size 4 at addr ffff8881099dec74 by task kworker/u17:3/413
    Workqueue: hci1 hci_rx_work
    Call Trace:
     sco_conn_put.part.0+0x1a/0x190
     hci_disconn_complete_evt+0x1ee/0x3e0
     hci_event_packet+0x54a/0x650
     hci_rx_work+0x321/0x3d0
    Allocated by task 413:
     sco_conn_add+0x72/0x1a0
     sco_connect_cfm+0x88/0x670
    Freed by task 413:
     sco_conn_del.isra.0+0x3f/0xf0
     hci_disconn_complete_evt+0x1ee/0x3e0
    refcount_t: underflow; use-after-free.

The root cause is that the socket stores the connection without holding a
reference of its own. __sco_chan_add() does:

    sco_pi(sk)->conn = conn;

so the socket borrows whatever reference its caller happened to hold, and
the callers paper over that with ad-hoc holds and puts. Give the socket a
counted reference instead: __sco_chan_add() takes one and it is released
together with the channel (sco_chan_del()) and in sco_sock_destruct().
With the socket holding its own reference, sco_conn_del() no longer needs
the extra put and the redundant hold in sco_conn_ready() goes away.

Making the socket own its reference means the connection is now actually
freed on the error paths of sco_connect() where it used to leak, which in
turn runs sco_conn_free() and its hci_conn_drop(conn->hcon). To keep the
hci_conn accounting balanced, make that ownership explicit as well:
sco_conn_add() consumes one hci_conn reference and the sco_conn owns it for
its lifetime. sco_connect() hands over the reference returned by
hci_connect_sco() and no longer drops it on the error paths;
sco_connect_cfm(), which is not given a reference, takes one with
hci_conn_hold() before handing it to sco_conn_add() (and drops it again if
the allocation fails); and the explicit hci_conn_hold() in sco_conn_ready()
is removed. Every reference then has a single, clear owner.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v3:
 - Incorporate Pauli Virtanen's review: make sco_conn own one hci_conn
   reference for its whole lifetime -- sco_conn_add() consumes an hci_conn
   reference, sco_connect() no longer drops hcon on its error paths,
   sco_connect_cfm() holds one before sco_conn_add(), and the hci_conn_hold()
   in sco_conn_ready() is removed. This avoids the double hci_conn_drop() on
   sco_connect()'s error paths that v2 would otherwise introduce.
 - Keep the sco_pi(conn->sk)->conn = NULL clearing in sco_conn_free(). v2
   removed it as unreachable, but KASAN testing of close() racing the
   Disconnection Complete showed that dropping it reintroduces a
   use-after-free on the sco_sock_release() path, so it is retained.
 - Drop the hcon reference in sco_connect_cfm() when sco_conn_add() fails,
   so the allocation-failure path does not leak it.
v2:
 - Make the socket own its sco_conn reference rather than only deleting the
   extra put, per Pauli Virtanen's review.

Testing: on v7.2-rc4 with KASAN and a /dev/vhci reproducer that races
close() of an SCO socket against an injected Disconnection Complete, the
unpatched kernel hits the refcount_t underflow / use-after-free above
within a few thousand iterations; with this patch the sco_conn_del()
over-put on the Disconnection Complete path no longer reproduces.

 net/bluetooth/sco.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index fcc597be5bbd..aa9f61a748ab 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -188,6 +188,9 @@ static void sco_sock_clear_timer(struct sock *sk)
 }
 
 /* ---- SCO connections ---- */
+/* Consumes a reference on @hcon, which the returned sco_conn owns until it is
+ * freed. On failure (NULL return) the reference is left for the caller to drop.
+ */
 static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
 	struct sco_conn *conn = hcon->sco_data;
@@ -198,6 +201,9 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 			sco_conn_lock(conn);
 			conn->hcon = hcon;
 			sco_conn_unlock(conn);
+		} else {
+			/* conn already owns a reference on hcon */
+			hci_conn_drop(hcon);
 		}
 		return conn;
 	}
@@ -265,10 +271,8 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	sco_conn_unlock(conn);
 	sco_conn_put(conn);
 
-	if (!sk) {
-		sco_conn_put(conn);
+	if (!sk)
 		return;
-	}
 
 	/* Kill socket */
 	lock_sock(sk);
@@ -283,7 +287,7 @@ static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
 {
 	BT_DBG("conn %p", conn);
 
-	sco_pi(sk)->conn = conn;
+	sco_pi(sk)->conn = sco_conn_hold(conn);
 	conn->sk = sk;
 
 	if (parent)
@@ -366,15 +370,15 @@ static int sco_connect(struct sock *sk)
 	 */
 	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
 		release_sock(sk);
-		hci_conn_drop(hcon);
+		sco_conn_put(conn);
 		err = -EBADFD;
 		goto unlock;
 	}
 
 	err = sco_chan_add(conn, sk, NULL);
+	sco_conn_put(conn);
 	if (err) {
 		release_sock(sk);
-		hci_conn_drop(hcon);
 		goto unlock;
 	}
 
@@ -1439,8 +1443,6 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
 		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
 
-		sco_conn_hold(conn);
-		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
 
 		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
@@ -1496,10 +1498,12 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 	if (!status) {
 		struct sco_conn *conn;
 
-		conn = sco_conn_add(hcon);
+		conn = sco_conn_add(hci_conn_hold(hcon));
 		if (conn) {
 			sco_conn_ready(conn);
 			sco_conn_put(conn);
+		} else {
+			hci_conn_drop(hcon);
 		}
 	} else
 		sco_conn_del(hcon, bt_to_errno(status));
-- 
2.43.0

