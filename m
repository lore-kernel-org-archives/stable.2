Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFE37B011
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050297; cv=none; b=hcb2EHNNiafI98Sz+RZUqLfn/tb+Djsub447QcwqDeYF8gR/T1O3+T1tUT3DFIjgzJUdqGTNzJ+mo89W8rU5qCkwpgHWUgQ7XYcrtPdo/jJbc5AeH9IkNm8pHDs4CsLmh+k8zH1a3EKxxA2oIN0UrWVJUf4bz18/WhD1LV+hwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050297; c=relaxed/simple;
	bh=8yDT6j+2YLaC6Igh2ia1Cc7cLr83olRZPpOpVWaCIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6XoKUmtl4hxdo7L3ETE6vDficomps9kCpo+IiNHqzGj3+iJ/9HfUbXTvc/itpxUTSPjB5soK6iR2Uu43vhawFApfsI5CTV6k5/5tUSwTsnlshFPHSBI+XSCkVQV+8nYz65ow68dUvHlCDf3zljWjkKk7o8ABqqIV9p0aGyPwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=k3NLgBxU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="k3NLgBxU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so1792911b3a.2
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785050294; x=1785655094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ix+ugMgNqOht1Tm+FalAql8M7pr0T1GbeaRV/ZSSIRM=;
        b=k3NLgBxUCW+tYHr/kLS6VS+a4AzfKQWQqcxyV53KDtFfdTHlzv83cAOPanWLIzSYyi
         nAd9pdtzfr+r2XS+ulQ8YIIjpJuXKO5pXJvskJf0AsGdQ2QCEwPDyGzaPSIpFoXNVo8p
         OyK69KDhPCDcc8vHuS7PmgO01ZjyPAdkd+FMd63b5c3+NruPVIH9+m8s7RkDxWLUh02b
         BdXwCgqZNxuNTwdC8vK9QkZPPiRzga6Ej4KlV5QjR5VE34bfZUUOs9YEMrNpQa0ZmhUR
         NpWlWoG4XKyWnkVHgddQzzDsZ86t7hssfxqMIs7Mne7TaZ6WiQdo9vl5QeZeTy++qbPg
         G7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050294; x=1785655094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ix+ugMgNqOht1Tm+FalAql8M7pr0T1GbeaRV/ZSSIRM=;
        b=gpjb32jFK27v21808ko/Yypl/O8KYIWN2HH/VZwfmhHXiLxn3tXyAkNcTWBNidI/6i
         +Q/JN+UxL6GLx5h62nJY4l1GB8J5qXCSDYe2qF2PalZgc9y46DqYPzCwezfX/fp+u0Tl
         RbZrBLE2OtkBSJ9LCln/kMIO4XsyZO16wdGGqzdmOtqnjGtC+EDCeghfeao4whk/XhTl
         +Il2Ie/GmW/eULd8nLVRKfGfpe2HzHQ7b+GhhQD/yQwFLigHIsWx+NUMO1r/DwaaTvEL
         t9xjbhpC/vAAOeyI3nsvqLgz3TLUSj7u69RMs/xL/+aMLQb7or6OFo9QI6fiS0b0Id3X
         NYhw==
X-Forwarded-Encrypted: i=1; AHgh+RpU+Y/mBBJU/MGDsWjfLB7PxYS9acSmDsVXwF6tUL5SJc4vGGPKfRdK6rFgLWQu4hAwrn1owJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx180HPINf611TEiIfArTBbefQQrjgiWa7Tb8Gu2PEdtbpKNsNt
	dQfnwMgCfG3V0tuTrd5OLudxsKbD/TnEX//U91sEF7MttwS3s4YJNG6aM4rgaHRJF/A=
X-Gm-Gg: AR+sD12Lg5gWiQhFgIKP5ZUcN7jQbKRQcvZON5026CyPLfOgM+lOW3PiDrH3oUZoIUY
	WjbPWc8/cXtkliWMBmRE7tZ0lfX7BhWUlPN8GbYyXZ4huZGUdJk474GgMzDBfDjTXckPWKx9GbX
	Y5UTNJ9YhA2036HiElx6jnzua++eO7R2ySMMe3md8iyVIvm+up0ofaAIStDoKGYWpFun70c43tM
	xgIwkyxnpuYNVsOnB7yL9JNA8h5vI2xJN8pSd+12VBuLuPHaj54gDngQleNRORAjeyLw4piKtav
	hc6IUMDoYQhQ/qiUDd2yQXCJ8lWDzziaMahVhT01r2U7wwTXEyzGGBFJw4ctKbesm8+n2TpiDXw
	v3BFfuBbpkiXL7IeUoMSuWnnywa1bTYx0j7dS5MbXNm3JYeyIirtrfehqkFA/Aw4myG46JiJIqw
	Nwz+qULrgdiE5Io2FoiIDt89pnKI7gfpham0gcpD7fE2/JFXeS6i1G4nWTpvIt
X-Received: by 2002:a05:6a00:3391:b0:84c:1c9e:f894 with SMTP id d2e1a72fcca58-84e5942e09amr3416394b3a.4.1785050294084;
        Sun, 26 Jul 2026 00:18:14 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533ce57asm1678602b3a.28.2026.07.26.00.18.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 00:18:13 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	linux-x25@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ms@dev.tdt.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/x25: fix use-after-free of the socket by its timers
Date: Sun, 26 Jul 2026 16:18:08 +0900
Message-ID: <20260726071808.47781-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x25_start_heartbeat() and the x25->timer helpers arm their timers with a
bare mod_timer() and take no reference on the socket, while
x25_stop_heartbeat() and x25_stop_timer() cancel them with the
non-synchronising timer_delete().  A pending timer therefore keeps
nothing alive, and a cancel does not wait for a callback that is already
running on another CPU.

x25_heartbeat_expiry() rearms itself unconditionally, so an expiry that
races teardown reinstalls sk->sk_timer after __x25_destroy_socket() has
already passed its cancel point.  The following __sock_put() frees the
struct x25_sock while the timer is still queued, and the next expiry
dereferences freed memory.  KASAN reports a slab-use-after-free read in
x25_heartbeat_expiry() below call_timer_fn(), on a kmalloc-2k object
freed by close() on another task.

Switching the cancels to timer_delete_sync() is not the fix: both are
reachable from inside the very timer they would then wait on.
x25_heartbeat_expiry() reaches x25_stop_heartbeat() through
x25_destroy_socket_from_timer() -> __x25_destroy_socket(), and
x25_timer_expiry() reaches x25_stop_timer() through
x25_do_timer_expiry() -> x25_disconnect().  Either would deadlock the
softirq against itself.

Give every armed timer a reference on the socket instead, with
sk_reset_timer() and sk_stop_timer(), and drop that reference in each
expiry handler, which owns the reference of the firing it services.  A
pending or running timer then keeps the socket alive by itself, so the
existing non-synchronising cancels are safe and no path waits on itself.

The heartbeat must also stop rearming once teardown is done with the
socket, or it would keep it alive forever.  __x25_destroy_socket()
unlinks the socket with x25_remove_socket(), which uses
sk_del_node_init(), so sk_hashed() is a reliable marker: rearm only
while the socket is still linked.  A heartbeat that wins the race and
rearms just before the unlink finds the socket unlinked one period later
and lets go, so the socket is released within one heartbeat interval
rather than leaked.

__x25_destroy_socket() also reuses sk->sk_timer as the deferred destroy
timer through a raw add_timer(); arm it with sk_reset_timer() as well
and drop the reference in x25_destroy_timer(), so that path follows the
same rule.

Verified on v7.2-rc4 arm64 with KASAN under QEMU, both kernels built
from the same config and driven by the same connect/close reproducer for
45s.  With the heartbeat period shortened so the microsecond race recurs,
the unpatched kernel panics in __run_timers() on LIST_POISON2; the
patched kernel completes the run at the same race duty with no splat, no
refcount warning, and no sockets left in /proc/net/x25.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/x25/af_x25.c    |  4 ++--
 net/x25/x25_timer.c | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c31d2af5dd22..5f2fee4da853 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -363,6 +363,7 @@ static void x25_destroy_timer(struct timer_list *t)
 	struct sock *sk = timer_container_of(sk, t, sk_timer);
 
 	x25_destroy_socket_from_timer(sk);
+	sock_put(sk);
 }
 
 /*
@@ -398,9 +399,8 @@ static void __x25_destroy_socket(struct sock *sk)
 
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
index 2ec63a1f4c6d..7896cd43f1cc 100644
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
-	timer_delete(&sk->sk_timer);
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
-	timer_delete(&x25_sk(sk)->timer);
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
2.50.1 (Apple Git-155)

