Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668760;
	b=hxzQMGUPxGqGxYz+HuEnmvl5V890/oCBU+Ap7Dv3sn824/c6ndiIOKXF9DJo6AMT5nhX
	 mwKH3kyU0YoJpEJzuXtuim5r2KscfRNzn4/SaezotCfZdBTpZHA3iC/oaElgNgsT5tykL
	 qz0B4MkL1rVTUEXYU7wH/oe9rakThdLkdLvtJZqwZr3loQtwLNgESYL1ODcYTnl83xEiZ
	 O/2rZYjgrGv5Bl+oINMmzyYvzEK1uk+S+mN+AgYPKrehQ3nPBB4OQMFYrN+L/CfL+KdU9
	 Xtt30Ey641xmUE/JXmFPVh/oEIgUBlYc1sYqKuWRA6K/vvOLWWIwhhrT7W8IkL9/Deg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668760;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/mxt8P+p8nf0AiOazDgUB7JS7ORkdSvZiaaLa5AtUKc=;
	b=LXolftgfT0ydqIOKm0Nry5LgmeynfgLe5UoLcfyXYvknDbTc+hqHBXuhg4ftulZLBV2M
	 iMRuTRhE6DH/rFPVwAkMJg/dNS1XOadPsj6IX5a7clw2SVz4Ic/Pq/cGZSpXffM7bUWBo
	 +gnw14g08aZJi5r3qNgR3jxkN7CCsdQzDqH7Z1ESOIt5CWU5p6ou67bCN+Av64XX/YGqX
	 sLVPSqHICf7CsQm8BErS5JamB2f5wtxP6kMaovFGj1y9jrX371idgkf6FK9a7kCp71rvO
	 Ju2fH5iwqel2dVkG9spH3Rirw4gMW3QLDqxz9SyJyTSsBwoZ5IcoNpI2NulRHdEPDzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mf5fqHeK;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950E7606A330;
	Sat, 14 Nov 2026 15:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950E7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mf5fqHeK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=mf5fqHeKuc5bU5TH8fTSzCRqE13f/jgJFdelRXx6kMGeDMulRczsq9NTFgf1Ds94uK0thS95oObIm
	 PcHn1FieVBL2lnLEDMeI3tRMvuqp7iWcbsEa+RbNXvIHpz+7KRP703tCyaGW9b2lvM2Uud7B2kDoXW
	 temuXqNFacPRBob4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af878cebd0-91f2c;
	Sat, 14 Nov 2026 23:05:50 +0800 (CST)
X-RM-TRANSID:2ee86af878cebd0-91f2c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHD-W7400297 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af878cb188-47d2b;
	Sat, 14 Nov 2026 23:05:49 +0800 (CST)
X-RM-TRANSID:2ee66af878cb188-47d2b
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com,
	Aibing Chen <chenaibing@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] nbd: do not reinitialize a live socket lock when reclassifying
Date: Sat, 14 Nov 2026 23:05:46 +0800
Message-ID: <20261114150547.842-1-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular
dependency") reclassifies the socket passed via NBD_SET_SOCK (or the
netlink equivalent) with sock_lock_init_class_and_name().  That helper
is meant for freshly created sockets: besides setting the lockdep
class it clears sk_lock.owned, reinitializes the wait queue and
reinitializes sk_lock.slock with spin_lock_init().

The NBD protocol has userspace keep the socket fd open, so the socket
can be in active use while it is being reclassified: an inet_shutdown()
or lock_sock() racing the reclassification can hold sk_lock.slock
across spin_lock_init(), leaving the live lock zeroed.  On
DEBUG_LOCK_ALLOC kernels this surfaces as "BUG: spinlock already
unlocked" (debug_spin_unlock()) from the shutdown/lock_sock path
running in parallel.

Add sock_lock_reclassify_and_name(), a variant that only re-arms the
lockdep class and name of the live sk_lock (plus the module owner
tracking) without touching the lock itself, sk_lock.owned or the wait
queue, and switch nbd_reclassify_socket() to it.  The
sock_allow_reclassification() guard is kept to narrow the window in
which the lock is in use by lock_sock().

Reported-by: syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b29ed72382b0e218323a
Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
Cc: stable@vger.kernel.org
Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>
---
 drivers/block/nbd.c |  6 +++---
 include/net/sock.h  | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf..28274a48d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1251,19 +1251,19 @@ static void nbd_reclassify_socket(struct socket *sock)
 
 	switch (sk->sk_family) {
 	case AF_INET:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET-NBD",
+		sock_lock_reclassify_and_name(sk, "slock-AF_INET-NBD",
 					      &nbd_slock_key[0],
 					      "sk_lock-AF_INET-NBD",
 					      &nbd_key[0]);
 		break;
 	case AF_INET6:
-		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NBD",
+		sock_lock_reclassify_and_name(sk, "slock-AF_INET6-NBD",
 					      &nbd_slock_key[1],
 					      "sk_lock-AF_INET6-NBD",
 					      &nbd_key[1]);
 		break;
 	case AF_UNIX:
-		sock_lock_init_class_and_name(sk, "slock-AF_UNIX-NBD",
+		sock_lock_reclassify_and_name(sk, "slock-AF_UNIX-NBD",
 					      &nbd_slock_key[2],
 					      "sk_lock-AF_UNIX-NBD",
 					      &nbd_key[2]);
diff --git a/include/net/sock.h b/include/net/sock.h
index 3144efad8..2b305777c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1704,6 +1704,22 @@ do {									\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
+/*
+ * Reclassify the lockdep class of a live socket lock.  Unlike
+ * sock_lock_init_class_and_name() this variant does not touch the
+ * lock itself, sk_lock.owned or the wait queue, so it is safe on a
+ * socket that userspace still holds.  The caller should check
+ * sock_allow_reclassification() first to narrow the window in which
+ * the lock is in use by lock_sock().
+ */
+#define sock_lock_reclassify_and_name(sk, sname, skey, name, key)	\
+do {									\
+	sk_owner_set(sk, THIS_MODULE);					\
+	lockdep_set_class_and_name(&(sk)->sk_lock.slock,		\
+				   (skey), (sname));			\
+	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
+} while (0)
+
 static inline bool lockdep_sock_is_held(const struct sock *sk)
 {
 	return lockdep_is_held(&sk->sk_lock) ||
-- 
2.50.1.windows.1



