Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48534D4E2
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849358; cv=none; b=d8TCTUSzo7sv1xN3HulrpNCvTvcSgWtXhW+Tb/XBwJMfexpfHLTtYYwfbESQhIGUzuXrB6h+3VeUQbtwoYvdF1VRxEUtfr/+njToLKDszFOUwMPunejNd4dHJhPTSzs96TECfu5ev75H45pwumN3lrok+HN0XYYhlDVD+6ObijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849358; c=relaxed/simple;
	bh=GtyBnUDy1XmyW8TFUweRrkgz87Vb+jaYYX7eemGWk2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKkvxUsne4EZ3lTXL69ctRGa03GIM/YRHuAklbTO9pXOoLcQZJ0Q2zHZuVIpsDgHDdx+pzonDPMFt2nQNdSOrt2mK41Fhdj8FKvxUgLzeoyNejaij+CRLpA2ft0tHlJI8rMQKYKnI7UtC0EVBF6nAepaI/1GcORkagLFLV15fE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbfAuAd8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbfAuAd8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c197eaaab00so208085266b.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784849354; x=1785454154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IMll30OycGqJfNeIH/aMl3dCus/QWYYNzJKzRVgh/s0=;
        b=GbfAuAd8HuO4JClPJwwcKlxHx5M89C+Eq9DWVnp7p4Y/495E4Y3AsD0WljOk8XyCic
         /Etq8auNpFT7EcELKnnEnBGRupSAGSd+qPqF3JeM87PaGXyk6ipszHZJdqJ0UVQbFlXE
         5d8zJj0QzMULjX7O+bthw+J+mRFDDL+ZpQ+9Yd6OFBPwSW7nX44P5xyoWLm7KUAD3P9x
         GaVL+LjHw/9QCnOkt5zpdQlyBmyolvTj6Iy3i42B6wkjR2knM3bUG0scDXbVfRfrBunJ
         caaLiNapaAQMPikLxKp/xbTcYr799GvenH1tFY4mY1Ycr7RjJoXPrgsFrlQTRdcFyWUp
         R7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784849354; x=1785454154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMll30OycGqJfNeIH/aMl3dCus/QWYYNzJKzRVgh/s0=;
        b=QErqN6yP2SqCpJKu2YUW8QxVGZR/LD24WihPABiYAkNT15TSQTvFwHDHWM8pQUXI8W
         Ipw44xl12qEwbSHhrbn661Ze6cpD+nwiD1lIZ12FCD0xBYh7yCfRL67kJ4F4D4eChEEX
         hvAPFzVv9Hd5WzAMo1B+q+AYSzO08I1NWWveYt5X0YmEkFOlKR5neqG0GZSDjCElqbPb
         TaKgoo6yEWhzWhZrytgzAahFWnkGcnWEFI3+itwXU1/fyXsz/VQVKkjmewjS4tKj+U4X
         Lb+R0C8L0K9yCGAipqx1lB797xP+f5P93mgynm7NJSaPfYH+fO5UrTSXU+YQtO/FeKlZ
         nrQA==
X-Forwarded-Encrypted: i=1; AHgh+RqynlyZ8fQtrI5m7oM113EYDKsaj6it0p3QXg4MAY9Yffxb5k6BG+TTiOd5yvpQYCNl0Ny/AaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DI3EER3m6XkkuuEzNvlmKg5QwpyMIyQjt+Simmex+AiOvO0C
	sUzt4uzq82AWJpRXB0jk+LKYy2mucGoX5MUIW/uuWEU6FpHCDtqXadl5
X-Gm-Gg: AR+sD139sKVGnq341+cjGdxzJxcsRBfETZrNHeFSJaaIu3kBdsWogGKjkwAl/yl0D+X
	uGzFwcaFz/nsZzhfoAEeshT9IL8RYYOjEirI76gk9DmGzJLcrRuVO72/ZQxe4QuTaPog6BV+GgX
	jSY9PzRaFHKdYEx/hLGLajvsxO0ujQSH2H0/NAzOOTI52ybYt/taWdL8S7AD4dpS5Xj2u5/8o1H
	WjDyFr92Dh9VCIZ/Pon0p8eicq2H77PnCYHP++2rzUpkN8DXD8w7Y49rPnxF2Ih7bHgHXqrrHnx
	IiybI2Elsw+9JcjHO0KRgO4y8k2jBHPmR5zWJKKgGhEUM6ICIBMs8mgcbi3JcyNvFeUU2R2Lhfl
	159LW0eXdPWx84lEdQ25YTHJptCy6UkR+nAFGtMqBqq7WlpPSHCA8h2y8e/0ctDKD+aGv8XSB0w
	==
X-Received: by 2002:a17:907:e014:20b0:c1c:2b61:b9da with SMTP id a640c23a62f3a-c1c50bf22ecmr157944266b.34.1784849354297;
        Thu, 23 Jul 2026 16:29:14 -0700 (PDT)
Received: from beelink.. ([186.247.163.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a78927sm297178566b.12.2026.07.23.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:29:13 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: SCO: give the socket its own sco_conn reference
Date: Thu, 23 Jul 2026 20:29:02 -0300
Message-ID: <20260723232902.792805-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Simply deleting the extra put is not enough, because the reference it
releases is not always accounted for elsewhere. __sco_chan_add() stores
the connection in the socket without taking a reference:

    sco_pi(sk)->conn = conn;

so the socket inherits whatever reference its caller happened to hold.
That works out for sco_conn_ready(), which takes an explicit
sco_conn_hold() beforehand and whose caller puts its own reference, and
for the success path of sco_connect(), where the reference returned by
sco_conn_add() is silently handed over and later released by
sco_sock_destruct(). It does not work out for the two error paths of
sco_connect(): if the socket state changed while the lock was dropped, or
if sco_chan_add() returns -EBUSY, the reference from sco_conn_add() is
never released and the connection is leaked. The extra put in
sco_conn_del() is what eventually reclaims those orphans, which is why
removing it in isolation trades a use-after-free for a leak.

Make the ownership explicit instead. __sco_chan_add() now takes the
socket's reference itself, sco_connect() releases the one it got from
sco_conn_add() on every path, and the now redundant hold in
sco_conn_ready() is dropped. With the socket holding a counted reference,
a connection can no longer reach zero while conn->sk is set, so
sco_conn_free() no longer has to clear sco_pi(conn->sk)->conn. Every
reference then has exactly one owner: the one sco_conn_add() returns
belongs to its caller, the socket's is taken and released with the
channel, and sco_conn_del() and sco_sock_timeout() only ever hold
transient ones.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2:
 - Do not just delete the extra put: make the socket own its reference,
   balance sco_connect()'s error paths and drop the redundant hold in
   sco_conn_ready(), per Pauli Virtanen's review.
 - Drop the now unreachable sco_pi(conn->sk)->conn clearing in
   sco_conn_free().
 - Indent the quoted code with spaces so gitlint stops complaining.

On hci_conn_drop() vs hci_connect_sco(), which was also asked about: the
reference hci_connect_sco() returns is released by hci_conn_drop() on
each error path of sco_connect(), and on the success path it is handed to
the connection and released by sco_conn_free(). That side looks balanced.
There is a separate asymmetry that this patch does not touch: when
sco_conn_add() returns a connection that already existed for the hcon,
hci_connect_sco() has taken a fresh hci_conn reference but sco_conn_free()
only ever issues one hci_conn_drop(). That looks like a pre-existing
hci_conn leak rather than an sco_conn one; I did not want to fold it into
this fix.

Testing: the original defect reproduced 45 times across 2 independent
runs on unmodified v7.2-rc1-240-g71dfdfb0209b with KASAN, driven through
/dev/vhci by racing close() of an SCO socket against an injected
Disconnection Complete; both KASAN and the refcount_t underflow fired
every time. The BlueZ CI ran sco-tester against v1 with no regression.

 net/bluetooth/sco.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index fcc597be5bbd..21f829575803 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -81,9 +81,6 @@ static void sco_conn_free(struct kref *r
 
 	BT_DBG("conn %p", conn);
 
-	if (conn->sk)
-		sco_pi(conn->sk)->conn = NULL;
-
 	if (conn->hcon) {
 		conn->hcon->sco_data = NULL;
 		hci_conn_drop(conn->hcon);
@@ -265,10 +262,8 @@ static void sco_conn_del(struct hci_conn
 	sco_conn_unlock(conn);
 	sco_conn_put(conn);
 
-	if (!sk) {
-		sco_conn_put(conn);
+	if (!sk)
 		return;
-	}
 
 	/* Kill socket */
 	lock_sock(sk);
@@ -283,7 +278,7 @@ static void __sco_chan_add(struct sco_co
 {
 	BT_DBG("conn %p", conn);
 
-	sco_pi(sk)->conn = conn;
+	sco_pi(sk)->conn = sco_conn_hold(conn);
 	conn->sk = sk;
 
 	if (parent)
@@ -366,12 +361,14 @@ static int sco_connect(struct sock *sk)
 	 */
 	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
 		release_sock(sk);
+		sco_conn_put(conn);
 		hci_conn_drop(hcon);
 		err = -EBADFD;
 		goto unlock;
 	}
 
 	err = sco_chan_add(conn, sk, NULL);
+	sco_conn_put(conn);
 	if (err) {
 		release_sock(sk);
 		hci_conn_drop(hcon);
@@ -1439,7 +1436,6 @@ static void sco_conn_ready(struct sco_co
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
 		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
 
-		sco_conn_hold(conn);
 		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
 
-- 
2.43.0
 
 
