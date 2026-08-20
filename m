Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D7442FB5
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229506; cv=none; b=ufubjhsW6mgaF+qMKybGCx/RMR5lPsLoI8aB4LTP7Wxxkah9VD7SmNoBFgrsRDakMra8/TcaAAsSyeuQrVnmoK0tO3G1H2k8d4mqNdACAIOFfxD24C08o2qVjSOGS3BeeuovawN16d87VCvcpeIPlN7laeT3nqWUtvP7yEnh3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229506; c=relaxed/simple;
	bh=I3nCoKMMlsaDHclCQ78K3fsSJ1nu9wJUKuhFBIvQM30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH8kZkVT6gBewAAOXksK4f77a8WrN99RTHWcWC2pJxvIJvN4XbhVYTKoZNA8wHOWi3i80CsdafoD1JfY3bExYC++F/XPJbB936sROQTdUlqvTWARECbl2PTVpV69r2QOtPv9UV9ctZ/8iYaA/rumfvrfgQ+k4NfEWiMqpGMnTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ2x92D8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ2x92D8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246D01F000E9;
	Thu, 20 Aug 2026 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229504;
	bh=uwYRx7HKWIPZYRkwlTTgj0oUnPmXeW7GtQ4MThMNizY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQ2x92D8kf5zhn2XpxRvo6PPkjE6BuUgLlDKQk16sCEBeZWiDfVxgYcjWI8V9+c++
	 1c8zIMX71wYtAZ89y8FfcAsOpFKzIIVpWBFsKPMsfZdPaOPBFB/rU1Vkndq/9eRZNu
	 LnvjJI25NhYqRbS/ASThfQwgxPHvJT3mZNoy2O47ITT6Y/cPEo/yYkwoOBELXqwd0I
	 3cjyKVw4oXxUeKdtBptCNmUdvhYpuEg2ZMuVj/SWnP0N8/DLEdrGUOpyejLhxowQ+3
	 1TI7+Jb5wn0Q7y++ARzlHk0cn2nQJE6r4NfcMDpQt1WdOEH7U89ODLJT8iNDrBD+Ph
	 eWXYuK5iSGXDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net/x25: fix use-after-free of the socket by its timers
Date: Thu, 20 Aug 2026 08:38:22 -0400
Message-ID: <20260820123822.1613838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081741-fasting-obtuse-fd95@gregkh>
References: <2026081741-fasting-obtuse-fd95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baul Lee <baul.lee@xbow.com>

[ Upstream commit 2195424c3da2ef1829a63b807e3a900a90e57d85 ]

The x25 timers are armed with mod_timer() and cancelled with
timer_delete(), so a pending timer holds no reference on the socket and a
cancel does not wait for a callback already running on another CPU.

x25_heartbeat_expiry() also rearms unconditionally, so it can reinstall
sk->sk_timer after __x25_destroy_socket() has passed its cancel point.
The following __sock_put() frees the socket while the timer is still
queued, and the next expiry uses freed memory.  KASAN reports a
slab-use-after-free on the kmalloc-2k object freed by close().

timer_delete_sync() cannot be used here: x25_heartbeat_expiry() and
x25_timer_expiry() both reach the cancels from inside the timer they
would wait on, through __x25_destroy_socket() and x25_disconnect().

Arm the timers with sk_reset_timer() and cancel them with sk_stop_timer()
so that an armed timer owns a reference, and release it in both expiry
handlers.  Rearm the heartbeat only while sk_hashed(sk) is still true,
since __x25_destroy_socket() unlinks the socket before dropping it.  Arm
the deferred destroy timer the same way and drop its reference in
x25_destroy_timer().

Reproduced on net with KASAN, with the heartbeat period shortened so the
window recurs.  With this patch the reproducer no longer triggers a
report and /proc/net/x25 drains.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Link: https://patch.msgid.link/20260726220342.47245-1-baul.lee@xbow.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted context due to `del_timer()` not yet renamed to `timer_delete()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c    |  4 ++--
 net/x25/x25_timer.c | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 733c3616256ae..5db55f3baf0b2 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -362,6 +362,7 @@ static void x25_destroy_timer(struct timer_list *t)
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
 	x25_destroy_socket_from_timer(sk);
+	sock_put(sk);
 }
 
 /*
@@ -397,9 +398,8 @@ static void __x25_destroy_socket(struct sock *sk)
 
 	if (sk_has_allocations(sk)) {
 		/* Defer: outstanding buffers */
-		sk->sk_timer.expires  = jiffies + 10 * HZ;
 		sk->sk_timer.function = x25_destroy_timer;
-		add_timer(&sk->sk_timer);
+		sk_reset_timer(sk, &sk->sk_timer, jiffies + 10 * HZ);
 	} else {
 		/* drop last reference so sock_put will free */
 		__sock_put(sk);
diff --git a/net/x25/x25_timer.c b/net/x25/x25_timer.c
index 9376365cdcc9b..2afa8ecaf509a 100644
--- a/net/x25/x25_timer.c
+++ b/net/x25/x25_timer.c
@@ -36,45 +36,45 @@ void x25_init_timers(struct sock *sk)
 
 void x25_start_heartbeat(struct sock *sk)
 {
-	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void x25_stop_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
 }
 
 void x25_start_t2timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t2);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t2);
 }
 
 void x25_start_t21timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t21);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t21);
 }
 
 void x25_start_t22timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t22);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t22);
 }
 
 void x25_start_t23timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t23);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t23);
 }
 
 void x25_stop_timer(struct sock *sk)
 {
-	del_timer(&x25_sk(sk)->timer);
+	sk_stop_timer(sk, &x25_sk(sk)->timer);
 }
 
 unsigned long x25_display_timer(struct sock *sk)
@@ -108,7 +108,7 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			     sock_flag(sk, SOCK_DEAD))) {
 				bh_unlock_sock(sk);
 				x25_destroy_socket_from_timer(sk);
-				return;
+				goto out;
 			}
 			break;
 
@@ -120,8 +120,14 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			break;
 	}
 restart_heartbeat:
-	x25_start_heartbeat(sk);
+	/* Do not rearm once __x25_destroy_socket() has unlinked the socket:
+	 * it is past its cancel point and owns the teardown from there on.
+	 */
+	if (sk_hashed(sk))
+		x25_start_heartbeat(sk);
 	bh_unlock_sock(sk);
+out:
+	sock_put(sk);
 }
 
 /*
@@ -166,4 +172,5 @@ static void x25_timer_expiry(struct timer_list *t)
 	} else
 		x25_do_timer_expiry(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
-- 
2.53.0

