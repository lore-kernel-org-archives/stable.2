Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB934CDD
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606195; cv=none; b=tNiLPhEPE0Xw+MGeVNSWFLLcuPb19Q4Rj35X7aIjRo2S8LruwPeK2oXpcClQ6S9Ay51EpTTr4KYrQLoUwWTAPffRPKAAPwpdaugR1G3R0zkEBc3GsHPm9aFbAdtaOTegbnwkJ4qOlxquEaY/RlNLiLggkprLzXi+5hh0Tw/GnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606195; c=relaxed/simple;
	bh=HKwgogJWfXcsMKewL+kysH6TG/wJTdGDT1IW/gI30mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEdmX9kGJW7ojPOLHiVBkCtKxbYwz47ZgcFVVtL7+O0TPerz0kjZ7Q3MMZjUNPCR9+ZVwFxFifmK93Ro5SLOP8YIAwGGVoWb23EOMOf/M3OQxwH1H3w6/HVV2l3gBOCq5+LXrO/MESEua8W4PHwVkCzty1ApRkh1StRzDFhbR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKrOz57X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKrOz57X"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46cbe01d4b6so1210022f8f.2
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782606192; x=1783210992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/OXIfP8Zs3vii+BF/lVuJKai0eCajAz7G0PCYf1wmmA=;
        b=rKrOz57XmV72SGetT/MbbnC5rdUcRDBwUYGP1SRtPp9MsNGsS0UElwhaVVTVQmN8IJ
         8aObuSVuDUNcuG3/oNR1ULr93Bso/7hZQYeMkDVcIARq4o82Ptr03+PZV1Ou5a5w8DuZ
         xeQbEQ3JQluBWCMVJ2xJBQm5AKCfsUepyrb0W/x55XiXjtDGsxfT7KMr2E2gOzzmrJJC
         +KsNISin8NtAlKDtkVlcJwdGb/DxgU8uExTsurFTPAXfCCV0T5oIYdXUeeQZ6sVit5To
         Mvr7SfOEM0wPGvwsW6GNKISD+ZvtCsAe31mPynZoS4RVv/RphzYir/QZkgIIJOgKheVd
         rkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606192; x=1783210992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OXIfP8Zs3vii+BF/lVuJKai0eCajAz7G0PCYf1wmmA=;
        b=NfiTqfXDKY32/TiiPFuOBovESSk7ew3yeSVjT2oilPz6L/V6ctqBPV0SQGGq7fJkxR
         IgGj2CK6KrI6HUOP3rAmaFO5OO0Ze5WcRVGvZhshld5aDFxmudWY7FndgRSdnztwy105
         NMochHxmodT36cJVbVdG64+sVgiHV16cJTm7kYmR40CFtVSjBZHxedyUki49FUg3qkBk
         qU5ZqDYY8ufAqp0UB0q+mnSZjx5HfSrArpjzfU8rhVN+OZALiwaMOtXIVMzLM1m8RI1u
         62h6QTv4Tw4b/RMeFzwkGER5KGGYf0Um4cGDKB+R1bgLiR8lZO+FRNTK1w9V4RMH9MpC
         po1g==
X-Forwarded-Encrypted: i=1; AHgh+Rrb4OzD8DxVasHvTUd7KP0vTTTnJ08SzTOSvMwDg/lxfiprj5J5tX2GUOXDTQcvneqvAdYC2TM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Gpgdj8JG9QKBlxhUiWaTy77eI8O5Y4ZTcRPkJOYWNNSyt55R
	PFRbcDLiQ+N565Zxx2efMotpb6orCFUUVfOPngfRYoXQqk5uyLYdZTfsy8XLP0fJMPw=
X-Gm-Gg: AfdE7cl+PKRUes7PtP1wIetyvEaSN4IKRMesRRiwt25+PFIFuutGIWzNi/++RnJMtF8
	0w4aHZzekM+vnBFMKRwX9zCpXPtGe8GVAvn20jjCohVVy2fmtyj4hTSAl+6jvyPEWNO3VAk/pNu
	97roAsI54lTkXMqv2mW8N9iU11U9FdDxk95gNXcTvCGCieQoBVrCGV/4jgzU4XA5lPZSZIzAV/y
	+ZkM7aYXaH8dNkvbstCsS5MPUQ+yDaivJyRTjVRPBslN/C5CvLSec+1/BH00jzJGRbw+iNKL5mi
	uqON3vIzAhiSFIdaVxn4Ocu0pVG/g/Z1THss6eGPvBCONX3uONs1pS9m6nf08qN+AWZDVTBdlUC
	LAl4u80tfHBFCnK54/LkJrQRrSWHCKItskk36M/4g13SxKXPPJMXFMdCznyYSXGCe7vLmKT0+JY
	SgjqMnJxLEnG+/cjHlD8vIaQs87nGdbyM24HJM
X-Received: by 2002:a05:6000:4692:b0:46e:6210:bd8d with SMTP id ffacd0b85a97d-46e6210be90mr12463565f8f.17.1782606192121;
        Sat, 27 Jun 2026 17:23:12 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fccca2781sm12320616f8f.6.2026.06.27.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:23:11 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Safa Karakus <safa.karakus@secunnix.com>,
	stable@vger.kernel.org,
	syzbot+674ff7e4d7fdfd572afc@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] Bluetooth: fix UAF in bt_accept_dequeue()
Date: Sun, 28 Jun 2026 02:23:05 +0200
Message-ID: <20260628002305.22823-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_accept_get() takes a temporary reference before dropping the accept
queue lock. bt_accept_dequeue() currently drops that reference before
bt_accept_unlink(), leaving only the queue reference.

bt_accept_unlink() drops the queue reference. The subsequent
sock_hold() therefore accesses freed memory if it was the final
reference, as observed by KASAN during listening L2CAP socket cleanup.

Retain the temporary queue-walk reference through unlink and hand it to
the caller on success. Drop it explicitly on the closed and
not-yet-connected paths.

Fixes: ab1513597c6c ("Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()")
Reported-by: syzbot+674ff7e4d7fdfd572afc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=674ff7e4d7fdfd572afc
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 net/bluetooth/af_bluetooth.c | 17 +++--------------
 net/bluetooth/l2cap_sock.c   |  4 ++--
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index bcbc11c9cb15..a2290ffdc2c1 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -305,7 +305,7 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 
 restart:
 	for (sk = bt_accept_get(parent, NULL); sk; sk = next) {
-		/* Prevent early freeing of sk due to unlink and sock_kill */
+		/* The reference from bt_accept_get() keeps sk alive. */
 		lock_sock(sk);
 
 		/* Check sk has not already been unlinked via
@@ -321,13 +321,11 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 
 		next = bt_accept_get(parent, sk);
 
-		/* sk is safely in the parent list so reduce reference count */
-		sock_put(sk);
-
 		/* FIXME: Is this check still needed */
 		if (sk->sk_state == BT_CLOSED) {
 			bt_accept_unlink(sk);
 			release_sock(sk);
+			sock_put(sk);
 			continue;
 		}
 
@@ -337,16 +335,6 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			if (newsock)
 				sock_graft(sk, newsock);
 
-			/* Hand the caller a reference taken while sk is
-			 * still locked.  bt_accept_unlink() just dropped
-			 * the accept-queue reference; without this hold a
-			 * concurrent teardown (e.g. l2cap_conn_del() ->
-			 * l2cap_sock_kill()) could free sk between
-			 * release_sock() and the caller using it.  Every
-			 * caller drops this with sock_put() when done.
-			 */
-			sock_hold(sk);
-
 			release_sock(sk);
 			if (next)
 				sock_put(next);
@@ -354,6 +342,7 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 		}
 
 		release_sock(sk);
+		sock_put(sk);
 	}
 
 	return NULL;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4853f1b33449..de56ca691afa 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1492,8 +1492,8 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 
 	/* Close not yet accepted channels.
 	 *
-	 * bt_accept_dequeue() now returns sk with an extra reference held
-	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
+	 * bt_accept_dequeue() returns sk with its temporary queue-walk
+	 * reference held, so a concurrent l2cap_conn_del()
 	 * -> l2cap_sock_kill() cannot free sk under us.
 	 *
 	 * cleanup_listen() runs under the parent sk lock, so unlike
-- 
2.54.0

