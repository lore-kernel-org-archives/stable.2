Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC623E5EC2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965102; cv=none; b=ioYm/FN/v7mRvfhyQLEwdhZJM2grEhbm+kv9nKw9iQL4tkKvGatz8KEITkx0aGhP9Y6Skh/Ohwkf1c6wFngMIje6ME9MIgXjYH3jWzRlSvbJgiHbbXhFAkX94wrdcNWXwKLuZqRI1Qd//c4prNFcloctKAtmoFbT6qHLqtpNayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965102; c=relaxed/simple;
	bh=OoDmUc/8XtCceK9p+h+/SE9QHPZ6p/OJ7DDwunZIJxM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j6UdPZXmTRW3vu+IhuDb7vYXCAtl0fW8DmBj3cKfFQsqFRdgbHMJvC3VbE02qh+LLbKPgW4Ga+IJnRJPhAGm+ZV6GtcDzDOcHhH/HinUEge5fXd/DHxp1KMlIWXsjd0R1vf6AibQKll0XP+AyqEUvtX0Tn8PF6O0Gd7LKAZDhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCCDx1TP; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCCDx1TP"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso17413245ad.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785965087; x=1786569887; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEee5sfGqkAQFl6GZPGNdx0Fm2VSIMtcRUsGRdoNGMg=;
        b=qCCDx1TPDdJml2ne5nwDLwWBNQqi8SLcGVU+rBAgIZ9Rg5oMAZVYkk1Y1xDiJ90Dcn
         +xjc0qom6aU42s2U4wXyTcnRaH4Ltkl9UlbABBoCwSloqUevRQcXWHygh+j8Nr3y3qUW
         lFwJCtWKivs0byqd98XySNG7ympI2IXeeIV5WscsOfVaki8bCb/A2dd5mdPJ79g8jaoq
         1RaC1hVBPfvT2ZQoYfk3/i4VqIKkdFyKbFiVly+SPyp/38ZaxZ50hbLB+zxc/eBE0fuG
         RaguvjJ78LDDy0t8X4q/0HQ8n4VpzNIy1pM9c17jXVNJO4Ty3XvvbOYZZLXmJHvzoSg1
         QEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965087; x=1786569887;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OEee5sfGqkAQFl6GZPGNdx0Fm2VSIMtcRUsGRdoNGMg=;
        b=eEZmQfvPv6+QxZW7J6eZWFkqNs21V4M+Gi9Ilhy9PvxC/Sy0DLehai5ZZ6ccYdn5hy
         KrJFbBENaZ8V581eTMPd8ovXMEPwfORUGr8pgo5uG0rsyszqXgcMWS0yQvUiVjZAXe3F
         bhhyGXaeSHyzlYBlApaEfryP3AmwTLsSpFz8SRsvWvFX7FnF8hz/Y3rpdXGSJvi79ruK
         XodnvGvDjlnbj9YYU6CEmkPH+RBQCn3317qdueSDM/TaaorMvYKcPpDmyfiojeuVVutR
         PafVKTdJ1g5j3aw2EGS/DQSEUmusbVIxrXpT2kgaV86m87yMi88r0b6cvd9TevohkP1A
         freg==
X-Gm-Message-State: AOJu0Ywf+Uqjb92azDRhrbRg4ksz73HvFnpqH8OVxBZYmVKUse7bnfCM
	MgQBBtKPQFMOG9s/1TZV4QOEID0blmeVpCEZI8kpsntDdNtS4nGK0hOLCkkH8EOUIdBA82J0uCh
	0TxhOdsmXmD4YJWXAZntcsW3Yym7xDPrx9xhUSYBqe+H2jMUhvH7ZFIcybIpkn/qVTTNevG1j6M
	R7pZY/uzCnxAmGWw7v3b1v+jyPJEdjh44=
X-Received: from plao6.prod.google.com ([2002:a17:903:3006:b0:2ca:d6d7:6943])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c10:b0:2c7:f4bd:91b5
 with SMTP id d9443c01a7336-2d0ca15d0a1mr118249685ad.0.1785965086682; Wed, 05
 Aug 2026 14:24:46 -0700 (PDT)
Date: Wed,  5 Aug 2026 21:24:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805212435.48618-1-tkjos@google.com>
Subject: [PATCH v2 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Resolved trivial conflicts in net/bluetooth/sco.c, removed
extra reference on sk ]
Signed-off-by: Todd Kjos <tkjos@google.com>
---
Changes in v2:
- Removed redundant reference on struct sock
- Removed Change-Id tags

 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 22 ++++++++++++++++++++++
 net/bluetooth/sco.c               | 17 ++++++++++++-----
 3 files changed, 35 insertions(+), 5 deletions(-)

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
index 01a01d6f01c309a6333859784261d97335dda413..2fbd9c93440ce4936d47b3bd47aa1dc28da82c20 100644
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
@@ -192,11 +200,10 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
-		sock_hold(sk);
 		bh_lock_sock(sk);
 		sco_sock_clear_timer(sk);
 		sco_chan_del(sk, err);
-- 
2.55.0.629.g250fe7f194-goog

