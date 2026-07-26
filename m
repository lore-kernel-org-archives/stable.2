Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478662931D8
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045280; cv=none; b=pmbgk4O+JtfVYhejgJdKP5fRMbQ4deIGhafwbfN/0UztW5IqZsS8motqCNcC0jjJ/2h685U/zk6inMAwx7o/zOm8zpbCjj2PatC2qqJL33/+KYljK9pE5WZg6IFvIAe2S5VSe/8rKo6e2yQBKqkKpILalcDALZ9ZeB2J/gtTBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045280; c=relaxed/simple;
	bh=JUR61lMsOeNdf24yMOleCWIFEBHl2tuSPKCBc8SrrCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9pR1JzMbwIXw7L+wav9NBraZt8wiK+JFgjwNoCqVhoK4vE2cKknRaIrvNaAnqN2Zr6R98wGFKAiIbBFz8iP2rP+xtl1+X7Qx/pMZcCC89OBeHgOyHGdPFT8o1Kj1Nlcw5SCxQg/qwIFD+/6sLnBvwvnQH4x38Srx4pC2kvW55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=DDw9jb+V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="DDw9jb+V"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caced6038eso19507665ad.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785045279; x=1785650079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2mXcDhh8khgWaS8xBEZuV37vbK/EffZ6ZIEOU3bJCAE=;
        b=DDw9jb+VndMs9YzYS3oaoBnDQL/5qClTeSkvAiP99pW1pKCFzukntub8oidgWa/Q+C
         1AaN6lM+9AQJc4BgwY1ji+5qZstNkLD2fSCSxksDpDw8wUo5ZIFjusgDjmx3EYIdxI94
         hI/R+D+4Sd4kemm5XZnQrtGopPgH90DeguGR+AEfpxDEz6tZuJcW+hW509iEl8z0rDsu
         OKpt8olmXjHoEmDabNg4yr0M7S8SC2QjILp3ZMUzCY3Tf1Dn8z3bGcku0vekfACcCMzo
         WIgeeKnNdULtzzNd7Og5MHM2Va2ufg3DT0TNGgmWxB7kRB1KWS28LhE8CdDUxNUA8dk2
         u9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045279; x=1785650079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2mXcDhh8khgWaS8xBEZuV37vbK/EffZ6ZIEOU3bJCAE=;
        b=cxTw8L5S+Y4+0rasc+qXv4QVRPZ8MyuuNbYKqDzQHBtMSP5rRaydQ7PgExcmB1P8Q6
         zoZc/zCNrgxWbV4dJ1N8wsTTdN4G3OgKqyyWvqfebgdWZawZ9QSFJc8a4c1qJXtfn9WI
         t2bHeipvz2DPcgP6D1ZL5II/mJ7OmP8sdzMnbJftkWOhdlRH6VAsn5ZaxZ//YzS1e1O6
         GEwJnfAV8cytYSArtca+8LJQL4BT32ytTjwy28Z7P0/MiDtkbpsaOyGz4gFNtYr+jp+M
         IhfzErsbj9NpCAIukBVno166se5Cp8uOSh9nCWudgIcwoB3UpnxywbNVYyM+ux63R7Xk
         GKYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZ5NyTy185wss+URDUezd25zlZgFrOpbPMx6e5A9xO7kIgLaefcePsQ6iuq+i55KPieHNb/OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOSI5LXe709W1yiR4Y5UnTmRWgt4nNtls3C9WJO8yALYwJL9c
	RSd7mkT/+z3wppMoJrFII7HGKEh0A4SouvlurUn7ZEVct+VqqkhI3ViBBLGYfK8il20=
X-Gm-Gg: AR+sD10EfUlVG7SfeGNSMfPDyYvSO70OCnziT6imqwvz+/bHq0N3gKquzojYlHfgnt1
	QgVHQU77k0d8s7dBZQOpVH6Qz+MCsRSK5Ol1YwUnB/SGC2aM5OonvXFIIjQz2Wk10spCgvqhu0j
	VUsyb3/ugJfrZCcfb99z12S85Y970r/V2zfdJngvXc5oz93ng9KYLejPZO99n2sUSeFulyMzGB4
	EQxutbs6xoUrM3c6VLjiGGgR+b1wLVcs1vZlG4+KXgxjds8eMs/SMcZTiQeI9ZTj7n01p1ivwK6
	kl5tVz4K9ra0z/ClIMH27QWbWTOSTMzq6HJSDrq+lBR8sWGENZyRmEgeNMv2Emt79Kll+vakkqP
	CdGwcMy2M/OB6igg2zTWnV44zHnFWzwh74wbx6XCJadiQou4HTI05+k/XMYNqqrZjQhjYZZtKR0
	qgsfHsrYfctrRE6/GJpA411ipL+rhawnXS+Ao1c6i3QLi5pR7dD0fEfQe5ng8m
X-Received: by 2002:a17:903:2f08:b0:2c9:c517:d08b with SMTP id d9443c01a7336-2cfdf45f0c5mr35503435ad.22.1785045278519;
        Sat, 25 Jul 2026 22:54:38 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm12967045ad.73.2026.07.25.22.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 22:54:38 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: SCO: fix sco_conn double free on outgoing connect
Date: Sun, 26 Jul 2026 14:54:31 +0900
Message-ID: <20260726055431.42350-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn is refcounted with a kref that sco_conn_add() initialises to 1.
That single reference is the connection's association reference, owned
by the hcon and released when the link goes down.

The incoming attach path takes an extra reference for the socket before
__sco_chan_add(), but the outgoing path, sco_connect() -> sco_chan_add(),
does not.  An outgoing SCO socket is therefore attached while conn->ref
is still 1, and two unrelated teardown paths both release that one
reference: sco_chan_del(), reached from close(), and the !sk branch of
sco_conn_del(), reached from the sco_connect_cfm() / sco_disconn_cfm()
callbacks.

When an outgoing SCO setup fails while the socket is being closed, the
two race, starting from conn->ref == 1:

  1. sco_chan_del() clears conn->sk.
  2. sco_conn_del() takes a temporary reference (ref 2) and, seeing
     conn->sk already cleared, gets a NULL sk.
  3. sco_chan_del() puts the reference it believes it owns (ref 1).
  4. sco_conn_del() drops its temporary reference (ref 0) and the
     sco_conn is freed.
  5. sco_conn_del() takes the !sk branch and puts the freed object.

KASAN reports a slab-use-after-free of the kmalloc-128 sco_conn in
sco_chan_del(), followed by a refcount_t underflow.  Both operations are
reachable from an unprivileged AF_BLUETOOTH / BTPROTO_SCO socket doing
connect() and close().

Give the socket its own reference on the outgoing attach so that the two
teardown owners no longer contend for a single reference, and drop the
association reference in sco_conn_del()'s socket-kill path so that it is
released exactly once there as well, symmetrically with the existing !sk
branch.  sco_conn_ready() consequently has to take both references
itself, because sco_connect_cfm() puts the one from sco_conn_add() as
soon as sco_conn_ready() returns.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
Reported privately to the maintainers on 2026-07-10 with root-cause
analysis, a PoC, a KASAN log and this fix; posting to the list was
requested as the follow-up.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bluetooth/sco.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c05f79b7aa31..3db6552de06c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -276,6 +276,9 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	sco_chan_del(sk, err);
 	release_sock(sk);
 	sock_put(sk);
+
+	/* Drop the association reference, as the !sk branch above does */
+	sco_conn_put(conn);
 }
 
 static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
@@ -296,10 +299,16 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	int err = 0;
 
 	sco_conn_lock(conn);
-	if (conn->sk || sco_pi(sk)->conn)
+	if (conn->sk || sco_pi(sk)->conn) {
 		err = -EBUSY;
-	else
+	} else {
+		/* Take the socket reference, which sco_chan_del() drops when
+		 * the socket detaches.  Without it the socket and the hcon
+		 * would share the single reference from sco_conn_add().
+		 */
+		sco_conn_hold(conn);
 		__sco_chan_add(conn, sk, parent);
+	}
 
 	sco_conn_unlock(conn);
 	return err;
@@ -1452,6 +1461,13 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
 		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
 
+		/* Two references are needed here: the socket one, dropped by
+		 * sco_chan_del(), and the association one, dropped by
+		 * sco_conn_del().  Unlike the outgoing path, the reference
+		 * from sco_conn_add() cannot serve as the latter, because
+		 * sco_connect_cfm() puts it as soon as this function returns.
+		 */
+		sco_conn_hold(conn);
 		sco_conn_hold(conn);
 		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
-- 
2.50.1 (Apple Git-155)

