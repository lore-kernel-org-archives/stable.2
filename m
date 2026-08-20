Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4735FF6E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237675; cv=none; b=PAmKi0D6GBOq8sT6B8l4VpB1qjyaOZ2nSXKxMN5H89qUqWcux5frvQiG/Rqtq+Ay2k16PvPwlnktX45w06KeZGieFhjN9FI9X+jfKC+xghr29bWNztphAu+m4cs7k10A3FpYfSLV6ipKAsWIcT2TTzFQvChgHbdcOtPBnkPCns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237675; c=relaxed/simple;
	bh=z67/W3F3iE8qYldq+N9H5Qkwto119OcrzZ+bubBJUrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyWBYSiAOwXyqS1biZ50bo1xLmPAVxJRBo1SvPoMPgbxYwPACv3n9v1rh7R9zVbTdqRfJrWG6AMo0r307KpgfV2u0N4eVgq1bm1FJGMLlN3ibm4Qm5s7Uq18bfG/ENC50YCNtiCVQT3jsZcuAJ/jIqi7q0BqXOMScqP1ftmkbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Xdi9ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Xdi9ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185A51F000E9;
	Thu, 20 Aug 2026 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787237673;
	bh=lDFxoTAgVUuRtyQmqAjpzH0NVb+8yXxl5hLmJ4v6/aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H5Xdi9wwiU7dqKvKvIKpPqfcWHnec2P1KPB+TiBznJyb51CA9PKx4MA46cNsdi1vy
	 vW0FrVNl/UmRehTnibaqQ2e3t3dLYNYMs2cPyTZP0edYUf11ZEeDecsv3dDSbWU8J1
	 0ZIrxmMi69TvT03OC/zQGzdow2TWFt+fSWLLBM+4qIo1OtcmsnVDsu4EJqnFc0IaS7
	 MPYGeiFvaOdlRvHtIM1lkwYznIo/XtLUTwjGBhVVKhD7AvbEhj7E9a5Fw39HGCytjc
	 GLOmr8WDpVcE1kTfldgBjrCqMaFyNkjCC8kOzbSt6Af64gqsSWnuPPfWvhdqwotoI+
	 ts/d5AOdYCh2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/x25: fix use-after-free of the socket by its timers
Date: Thu, 20 Aug 2026 10:54:31 -0400
Message-ID: <20260820145431.1942079-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081745-contend-uranium-639b@gregkh>
References: <2026081745-contend-uranium-639b@gregkh>
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
index 3dbbf52e2f9b7..dad4daca3990f 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -372,6 +372,7 @@ static void x25_destroy_timer(struct timer_list *t)
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
 	x25_destroy_socket_from_timer(sk);
+	sock_put(sk);
 }
 
 /*
@@ -407,9 +408,8 @@ static void __x25_destroy_socket(struct sock *sk)
 
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

