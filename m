Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DB4854F2
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879887; cv=none; b=Id0kXO5cS0kiVh2inZspzzQlXwlmMYLGnJTTnz9hhGBTg5jVI1j0fKx2SolznA3dOI33MHBZZVQuZmIIbuynIIA/k1jWCfhC095K38lCHSIz8muKd6Z1Hcr382QBWz40T+sdQete09Oa6p2mFI3OP8Abvgzcu8GUwZrm5cVvfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879887; c=relaxed/simple;
	bh=Plr2udUrnPzJhrO88d8/cUYCuYFUqVPKmPeP0WjYuzY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JGQkWdIBO3QninBWyhqZb4QZyOFpBAgG9UvaYxoapvEH9UiNWLolKbWw8idTtmt7VJ4Ee4zn4th8NSq0S1HuqgnuknWim4qeTo1hxu1+P+pKolkyEbmJbH/flVQyZ2N8z2ctbUg8G4Cr/wZxVcXMZdNBw8I5/Jo1uLaBCqTXS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3b13pDo; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3b13pDo"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cccfa32670so3840415ad.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785879885; x=1786484685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQAROO2SKZMfB0rf4vSIrisCuL+veKyZjlIzUVOrEqg=;
        b=h3b13pDo+UDmzTwe2p67GeF5fOUR7bsFyGzETWXZXs5tBjWfSVPsU3E13QkOlUzC6l
         lREMc52gtnvx69Q97KLxUvM7dBEMcq4MM3CBxnB9KHAClMi1tb/7g3gbbPbSDToR+sEX
         bmQXAJfxkPmj8JLyKG8iB3MMV1gKy2HolCJRRtzaYZEH3V1tcMPjDJx8SWFfq6VNAL2l
         SgV9hvjFlkvpZMaYBz/SfHeLO7sS0fYp2gSXqjGWpzSBYeKxiKnL5oeAMCoNozmR3NaC
         2RPFBjlAbp53XlOBG6LDAnc2k+yaPlX85lxFxfqZJDQt/TCfvTStfssOiXgaKNn6cdZu
         NJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879885; x=1786484685;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQAROO2SKZMfB0rf4vSIrisCuL+veKyZjlIzUVOrEqg=;
        b=sdP2uv1liP3dyuggMAPWARgi8ynStI3NKukcEQpvSV6oN1NU4ShzU5Q9WMX5YGTG+8
         qrpe4Wj7ggEDtmu6C65urBeZ58FL5fD96GyLaRYYZj5vuS+kZyrdGPWEn/ZhWyTOLSPa
         5tSVlYEJRnZOZ8s9nGNVkeBQgtGdxXNknXdn53efyqmqoitIa/PR4sb7nTnyxoxXEBz0
         bMCDI2PhoVyfRDaCXGTt1ZeMNRDvv0UMi/m++kNZiVaBtOLT9uMKiZfEO8a2VdC9r0m/
         3jJEXwJNrY09Z+v+NHCA4kcirAseuAJOzeSwwdyYGmAkyOEB4SInkUNgpHZmMXOgIscG
         3tdg==
X-Gm-Message-State: AOJu0Yy1sC3QJN4CUF4RsO8GYJoPBI6TvQA5Ijrab0VT1ENGX2tac3X+
	i1zaKyOFDjotsze/Z70c1ULgM4AtuSzijw/wp4Rg7pQjCLqQGdDMxPfce1A95AbHqm0Ce45+Z7h
	D+o6Y06OWKmIlMZMPwuq+RhIVsdejMHZ62mTh6IrfifkXm7wbh8EbynzTbyd2S5V6yi8jto11Vl
	ZPrYyd/3j4x9cET8mo88rz8cQoB6ntB0E=
X-Received: from plgf4.prod.google.com ([2002:a17:902:ce84:b0:2cc:66fd:42ff])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54d:b0:2ca:ecf6:9104
 with SMTP id d9443c01a7336-2d0ca711c8emr20045565ad.4.1785879884724; Tue, 04
 Aug 2026 14:44:44 -0700 (PDT)
Date: Tue,  4 Aug 2026 21:44:05 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804214406.750710-1-tkjos@google.com>
Subject: [PATCH 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com, 
	Xiangyu Chen <xiangyu.chen@windriver.com>, He Zhe <zhe.he@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 1bf4470a3939c678fb822073e9ea77a0560bc6bb upstream.

conn->sk maybe have been unlinked/freed while waiting for sco_conn_lock
so this checks if the conn->sk is still valid by checking if it part of
sco_sk_list.

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Change-Id: I0520456fb59dfdb11b0d8a4d6b7087684736a0ae
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Resolved trivial conflicts in net/bluetooth/sco.c ]
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 22 ++++++++++++++++++++++
 net/bluetooth/sco.c               | 16 ++++++++++++----
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 43b4386018e26c41c914f87e050a0fe958700135..85bab90a6921ce1e9b9025647e23fafd97117ece 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -317,6 +317,7 @@ void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
 struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 			   struct proto *prot, int proto, gfp_t prio, int kern);
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index bef5b6330dd807504292671301c860b96c2ed18e..0af14e3318e7e02173970a1af8e183723bef2c50 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -184,6 +184,28 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
+{
+	struct sock *sk;
+
+	if (!l || !s)
+		return false;
+
+	read_lock(&l->lock);
+
+	sk_for_each(sk, &l->head) {
+		if (s == sk) {
+			read_unlock(&l->lock);
+			return true;
+		}
+	}
+
+	read_unlock(&l->lock);
+
+	return false;
+}
+EXPORT_SYMBOL(bt_sock_linked);
+
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	const struct cred *old_cred;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 01a01d6f01c309a6333859784261d97335dda413..8ac1f9a0222f3e947e75f37ac87115c74cbc0da9 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,16 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *sco_sock_hold(struct sco_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
@@ -87,9 +97,7 @@ static void sco_sock_timeout(struct work_struct *work)
 		sco_conn_unlock(conn);
 		return;
 	}
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -192,7 +200,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
-- 
2.55.0.571.g244d577d93-goog

