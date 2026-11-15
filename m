Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708452;
	b=FvKs3q9yuwh6JklRJOBg4XoA1bzmXObaBYRnuJNPGT2tZzuHcKOkI8RFtBSw2ccIh/pU
	 /RSr2+Va87Tll3xlzjHwqG7JySxtScSJ85ywoiXH0OZPeKmjcOHASXa5Bebyyev3hFPb6
	 oDo2f9DzwEKiuqAW9HqXtuUyKcQEwXSoXlFcNl16cNfDlkTazlE93hpzvgMWomgS3Is11
	 gygxt3tQRwud/++J4jYGWQmd8bGbskRH1NmDcoUWUlDM5oQUiEac7UZ60GHCksFAvp4Ms
	 iL8Bp1LHRPnAlaeoGs9fotxYmuFnl4ce+FDakQmiSvCcshJRafHoq5xDAPU9kkh+YPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=qFFVcUdbJVLPGQu7ocAyjzf3pNHMMiFCOAAxSb8MYyA=;
	b=U3oG9O94P7ILn+hxY0wJIGQaNM2L2CWoVJVVaK36og/ZULnAQdCbD26N2XDn22Nx+Vqv
	 C64d77QYxAycFuueGieOcGfV/7VKNFtA7DN5Y1ZqgIHJhrG7PT4xz4Op32IiGz2/l6fOu
	 MjV6HXkmjqD4drEpqjQyWKv3HTmUQVfsDur40dQQaNrq/ffJrNikeruOJaQ/vmY+SRHHb
	 uZbaUHp2sU/E2N9C8ltfzd/7rLmfZgooh/Y1mxNvQiFMBz9F2HdwFPinffTaDlPkAUmhU
	 a9NA4BZlhHA9AORJW3k+Ke9hNOj5LdoG6hcnBZmh+mwzfCOcpcdxB5nnpc2v6F6uL/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="K/fLvnOC";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB662606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB662606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K/fLvnOC
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36fa5673fccso5930245eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794708451; x=1795313251; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFFVcUdbJVLPGQu7ocAyjzf3pNHMMiFCOAAxSb8MYyA=;
        b=K/fLvnOC5vYtObowL3m1TdTwiWcegpqOrLcWFLP7xoTsBtwLPWrTTwL5wZmIKyhR3O
         0WCz9aUunCv/kRBiLKd+/t6u2PZp3LyhEVJ1AqeMexZ57E9Kr84oeWIkoKL6acd4J9tw
         Bc49oA1wL+LNWQNWHjvHA2ziKLc/OiMCqzhkyvEK9xOblPQY8sWZ7d5U5gPb8JJILdDs
         JLqr4zTINbqVrGTkkpFSojE0L42qHJJytzmCCdZxRiLrfaemlDDfW8lM3d4E28JC3iFV
         fODA4ZQQNcJut2R4Caq7b620vdms/bzvTTbLjhllO1oNARrWaZz6kClCTgfswDmaSYmz
         C0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794708451; x=1795313251;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qFFVcUdbJVLPGQu7ocAyjzf3pNHMMiFCOAAxSb8MYyA=;
        b=mr3XIY8RDXlD3+ekLoERP1c19MfdnG4QQ6z08H+cy6DH6u39+GT1UKN3jnUprHlpe6
         k50euWnNkxRpcefPlD2/n4BR9hn76QE7wo9Y9MZSwZSY5QCGdBUU2Tq4etJfKoT5artl
         B/kcBFzsoKqoYG4U+jVOTz4jmsxFe3cU5G2BXt+a26jh0zI0O/IVQ4rIS30z/HytOUzt
         gGR5v2B31h/f8hE/k9XuH46sY+cV6hxZpr1rD0NncVWA40dOWjw7CQhhumNWuC+ByH4+
         p3uiv7faII0FisouRKTt1eDaGyRypioUP866Tt76yW4kWOC+rLKsduRJZZnVpKK8v6tB
         G4IQ==
X-Forwarded-Encrypted: i=1; AL+hErEr4A9AHqcM23Jux3A43rI3xNtuHqEINS4A2iJ6PQnMOAA97x3vgD36PHTzxcQ9qGd2jLCvAHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OxeykLvTBB0B95A6fMzWIN3/BTI0jHAnC6i8jQdrgykYxI+al
	WtOqLsVtj3IKop11VC4aD2jNupoUDpRJ6xMvWjiYiA4Vuy71WSyeQMA1cntyQEJ+rOpFHB6V7Ab
	xt8+nB8+3jztFthTShR7DYrDWJ1gNmw==
X-Received: from dyff26.prod.google.com ([2002:a05:693c:805a:b0:378:1191:3e95])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:83cf:10b0:36a:79e7:2fd with SMTP id 5a478bee46e88-379684b838cmr7445866eec.40.1794708450620;
 Sat, 14 Nov 2026 18:07:30 -0800 (PST)
Date: Sun, 15 Nov 2026 02:07:29 GMT
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Message-ID: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>
Subject: [PATCH] rcu/nocb: Keep lazy timer intact on second lazy callback
From: Chris Wiseman <chriswiseman@google.com>
To: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Tze-nan Wu <Tze-nan.Wu@mediatek.com>, 
	Cheng-jui Wang <cheng-jui.wang@mediatek.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

wake_nocb_gp_defer() checks waketype == RCU_NOCB_WAKE_LAZY and
rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT in one if-statement.

When the first lazy call_rcu() in a NOCB group arms rdp_gp->nocb_timer
for the 10-second lazy flush delay and sets rdp_gp->nocb_defer_wakeup to
RCU_NOCB_WAKE_LAZY, the next CPU in the group that queues its first lazy
callback calls wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY, ...). Because
rdp_gp->nocb_defer_wakeup is no longer RCU_NOCB_WAKE_NOT, it misses the
first branch and falls into the else block for RCU_NOCB_WAKE, calling
mod_timer(&rdp_gp->nocb_timer, jiffies + 1) and resetting the 10-second
lazy timer down to 1 jiffy. The same fallthrough also shortens a pending
2-jiffy RCU_NOCB_WAKE_BYPASS timer to 1 jiffy.

Commit 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power") wrote
this check against rdp->nocb_defer_wakeup, and commit 463d46044f04
("rcu: Fix delayed execution of hurry callbacks") switched it to
rdp_gp->nocb_defer_wakeup, which exposed the fallthrough across all CPUs
sharing rdp_gp.

Give waketype == RCU_NOCB_WAKE_LAZY its own branch and only arm
nocb_timer when rdp_gp->nocb_defer_wakeup is RCU_NOCB_WAKE_NOT.

Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
Fixes: 463d46044f04 ("rcu: Fix delayed execution of hurry callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
 kernel/rcu/tree_nocb.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b6cfee4e5039..347d718befd0 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -335,10 +335,12 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 * Bypass wakeup overrides previous deferments. In case of
 	 * callback storms, no need to wake up too early.
 	 */
-	if (waketype == RCU_NOCB_WAKE_LAZY &&
-	    rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+	if (waketype == RCU_NOCB_WAKE_LAZY) {
+		if (rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
+			mod_timer(&rdp_gp->nocb_timer,
+				  jiffies + rcu_get_jiffies_lazy_flush());
+			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+		}
 	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-- 
2.52.0.rc1
