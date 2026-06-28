Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1AB8287E
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782607905; cv=none; b=WDTWPfK+xO20HqMgmYWjqV1tvfyYCOB1UlPFzWq5znRa+EkBLQb3TV2ncBtOmJw5ByZi1Sx3nuI3tn/bzgzW3lf8/vyRuWhUtv/Cwc/zgHEbu+OuSmCDLUzzXZTXpgdq6TP/n23ffiPxVm0RVuq1W3avaHL1LYQigNKLajPNA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782607905; c=relaxed/simple;
	bh=Mp9PKgXcdfrnu32zE0xG/md18n+XtX59fwt10nwDEm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O38J+WPB2XSzgfNapWMK0LEyfc2iT9ye7ED9+2mftRDXIxjOube0AVI6i7vPyBf3FzXA1AdxA/KTVnm5lwTKMSrWRTyhKqD9+qlN+x8MGKB0txHHxnx2A5X/7AGScWdQ6pBTjoBhYptZRmcEMuapE/uACEg5E3yXOeZq+l28WYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7Kf9nbq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7Kf9nbq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-463f1165e16so2231295f8f.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782607902; x=1783212702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPwdm7KkCwq7FXWIfhNWIbsHZGYDSUssRzVk4QB6Egs=;
        b=r7Kf9nbq5atKDQKyWca+BjVkF/sTa6Nk3DbwlMXrp9TCRR3hGbtlnRJ9y5ozX+SM55
         12jdAFyMh8jJD8LSx358N7RwI+/YTFV5omK/NukFmelIb4hViNnqdCdtkqehhk7ID0Xi
         hvGxWGEszg4se1ZohRnsSJG7hh6ualbKYMQhhdLV3dVBDHaCMtKi1Be3+OMky5vU5SEP
         DvwSuVXitwYGT/P8Czw5Nk9s2Tx6GiDgND6vGqGNWAC6kFb7RJcKvLe3AOqdzHbOe6eG
         XXOjHUZpZEOd3+cKQ5gcsHc1xdDuyHWYJ2U+kssCT6kUAp0d6hPBAWhP7EBrnN1lkEEN
         kaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782607902; x=1783212702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPwdm7KkCwq7FXWIfhNWIbsHZGYDSUssRzVk4QB6Egs=;
        b=SRlAtrEQQ+nO2duCxahlZF8dKVqUQf4ao9qZDNNIoiRJCqk15LiJGwGy5d8Kxzga+k
         gGIllgCs4ulRt8QXoIXcQy//ZDEgeUXRVTXj4migHAG/o0JEGp3A0iJmOfW9As2q3NSZ
         CinKRfoiPXqk9WoD0CxSfCaZVPH2wmJUyQyZCibUpbkNga3XeT1BwNqPn4tAz0EvLXRK
         byjFe3Po0741JdEEUC9d9yH0mGFlgaSEYuOE4922AVP8rMrTSRESXoNB+PF0hqQudoQx
         uuOp23p2N1O0fcL7DKfNovqU6uE3pGRBhD6W8Qwhm0Fxc/LecX4JZkFOCM0CGrRD6+vH
         AwBA==
X-Forwarded-Encrypted: i=1; AFNElJ9pII71b4LRZfauBG7eustUNaVONDC0bgULKTQvrFR/u+esAWM/Oba+9aE3I+ZwIezBsepnabs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4c4Ng8hGCa1BQ3CqT6OwlVJUJPyWuY2N21o8geLS1vzG/eexX
	70N+/kq1JNfD133OY/6qoJQbbeRhPoYtnIe44CSuBqqRjvty3TKSqR/W
X-Gm-Gg: AfdE7clJWFo9LwE1/xqu7DrxyFkIZFGj8BqLcDys2tFpcXxU1h78wa2V6TmzbrTch2Z
	06cFgKZF7ZaHCdVBFpx7K5p1/5Da4caBoi7cjgF+Szp44AaQPSELdEbKKiSR2q3FYWgmY0ha8J8
	zvrRekOgprgXLMomxuajDOhG4Ec/kirdJ2CqfeEQHGj/uCFp+y0OIfnJhUF3/OeUwjkk6lfsSYs
	skSuD6/Gged9goikIgZ5fus29FtDWbHKXGNYLVUzi824P5BFyGuNR8/2VfvvqxkKn0tZAQZ6thU
	9kV0frp5G9vZ+rKqaq61CyYRE8Bt3Hjko3497vgtPPD8hcScYaErmeDYVAOF4OQNekEC/t9xHzv
	szyO2e6u4w4QwYH1uOL7/a+dwePsGaQvcqc3eMOFoLv1K/w/GdAHHQpVnpdi8OhOXnUKdFvDUa1
	6sCclKbaZdMmqWOm3vGweEa51Nuw==
X-Received: by 2002:a05:600c:4ed1:b0:492:6fea:969c with SMTP id 5b1f17b1804b1-4926fea982amr96709265e9.0.1782607902326;
        Sat, 27 Jun 2026 17:51:42 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm4269078f8f.13.2026.06.27.17.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:51:41 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+fed5dce4553262f3b35c@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] Bluetooth: bnep: pin L2CAP connection during netdev registration
Date: Sun, 28 Jun 2026 02:50:58 +0200
Message-ID: <20260628005058.29072-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnep_add_connection() reads the L2CAP connection without holding the
channel lock, then passes its HCI device to register_netdev(). Controller
teardown can clear and release that connection concurrently, leaving the
network device registration path to dereference a freed parent device.

Take a reference to the L2CAP connection while holding the channel lock.
Retain it until register_netdev() has taken the parent device reference.

Fixes: 65f53e9802db ("Bluetooth: Access BNEP session addresses through L2CAP channel")
Reported-by: syzbot+fed5dce4553262f3b35c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fed5dce4553262f3b35c
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 net/bluetooth/bnep/core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index add9a8f7535d..f7d88c33e23e 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -559,14 +559,18 @@ static int bnep_session(void *arg)
 	return 0;
 }
 
-static struct device *bnep_get_device(struct bnep_session *session)
+static struct l2cap_conn *bnep_get_conn(struct bnep_session *session)
 {
-	struct l2cap_conn *conn = l2cap_pi(session->sock->sk)->chan->conn;
+	struct l2cap_chan *chan = l2cap_pi(session->sock->sk)->chan;
+	struct l2cap_conn *conn;
 
-	if (!conn || !conn->hcon)
-		return NULL;
+	l2cap_chan_lock(chan);
+	conn = chan->conn;
+	if (conn)
+		l2cap_conn_get(conn);
+	l2cap_chan_unlock(chan);
 
-	return &conn->hcon->dev;
+	return conn;
 }
 
 static const struct device_type bnep_type = {
@@ -578,6 +582,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	u32 valid_flags = BIT(BNEP_SETUP_RESPONSE);
 	struct net_device *dev;
 	struct bnep_session *s, *ss;
+	struct l2cap_conn *conn = NULL;
 	u8 dst[ETH_ALEN], src[ETH_ALEN];
 	int err;
 
@@ -637,10 +642,18 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	bnep_set_default_proto_filter(s);
 #endif
 
-	SET_NETDEV_DEV(dev, bnep_get_device(s));
+	conn = bnep_get_conn(s);
+	if (!conn) {
+		err = -ENOTCONN;
+		goto failed;
+	}
+
+	SET_NETDEV_DEV(dev, &conn->hcon->dev);
 	SET_NETDEV_DEVTYPE(dev, &bnep_type);
 
 	err = register_netdev(dev);
+	l2cap_conn_put(conn);
+	conn = NULL;
 	if (err)
 		goto failed;
 
@@ -662,6 +675,8 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	return 0;
 
 failed:
+	if (conn)
+		l2cap_conn_put(conn);
 	up_write(&bnep_session_sem);
 	free_netdev(dev);
 	return err;
-- 
2.54.0

