Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFE49CF35
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049181; cv=none; b=MnXfG8lwYm99t3WinbZvpb7fft4umtW2k6nag/dJs465HjLTesE0p0Hg5EIl7+ZIIv1eih7p0dFegrVHS6xGN4HjKSslLQ9u01Q1EqLXOw8llB3nTpNL5K7PrdVfm1NG3UItLq4KYurSvU367LQStfsin8vPWK+gTSUpHHogAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049181; c=relaxed/simple;
	bh=EfZGW9u7UuwpuDv6K1E1u17eIbguOgIVEhcXKv7zvyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dcgleq0XxAK19WMJ+IQJE3EhhbuRS7DWFJKSdGdKoGWOvHeN1Y48vqX1sv3p1vdk6FzOGkmUE+n+VVr/aXNgiMxQuTxb33dt7pQXPO9Uix8T8EIAM0RHDLM6u5p9myVCfX1cmoU2eE4WPDdHXWpG7ADahf6b3VDMiO2FM9AxLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIQ9LRcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIQ9LRcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A174B1F00899;
	Thu, 10 Sep 2026 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049179;
	bh=tovsLfkauagsSSfaqCCCgJLVpuEgpjLyRNGhCi6RhqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GIQ9LRcseeZUrsmeyc+rAfU8943E9jMhZrdh0a0Mv423ZgeREi8sTyUrDCLPT17Ch
	 dj+F3WXm0QhNEVio8cIZws0n0I24Z9RNjpEnkxca9/jBw6yPexobkzopMZ2HXoQ6j2
	 Ifw7fnYZUm4+g3BtCoTNbcXtlx7w20p86kwoIvJ61iNyqfbDD9rOL/Qq21Vf8D77H6
	 LRILdDNM3RFrcKLnZ4cyMIPELOjPdilMZhbQ4IU7C5KpmlHjRp5QGlgHsmjmEt5eL3
	 r7yYSkcQozPtFlru2lpTnd/fcCsEejpxQfBrmpznVDflojcJjMV+rrZkmrqp4eKgUK
	 FMH+8Y/ytH96w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] futex: Rename __unqueue_futex()
Date: Thu, 10 Sep 2026 10:06:12 -0400
Message-ID: <20260910140617.564852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090826-jeep-tassel-64cd@gregkh>
References: <2026090826-jeep-tassel-64cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit af92dcea186ed7bcd5cc013163ec47a8a135ee97 ]

In order to prepare introducing these symbols into the global
namespace; rename:

  s/__unqueue_futex/__futex_unqueue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-7-andrealmeid@collabora.com
Stable-dep-of: a3b8d46fe401 ("futex: Prevent rcuwait use-after-free during requeue PI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 8a3a27967973a..ff61ed8184a32 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1508,12 +1508,12 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 }
 
 /**
- * __unqueue_futex() - Remove the futex_q from its futex_hash_bucket
+ * __futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
  *
  * The q->lock_ptr must not be NULL and must be held by the caller.
  */
-static void __unqueue_futex(struct futex_q *q)
+static void __futex_unqueue(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
@@ -1540,13 +1540,13 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 		return;
 
 	get_task_struct(p);
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
 	 * is written, without taking any locks. This is possible in the event
 	 * of a spurious wakeup, for example. A memory barrier is required here
 	 * to prevent the following store to lock_ptr from getting ahead of the
-	 * plist_del in __unqueue_futex().
+	 * plist_del in __futex_unqueue().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
 
@@ -1998,7 +1998,7 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 {
 	q->key = *key;
 
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter = NULL;
@@ -2566,7 +2566,7 @@ static int unqueue_me(struct futex_q *q)
 			spin_unlock(lock_ptr);
 			goto retry;
 		}
-		__unqueue_futex(q);
+		__futex_unqueue(q);
 
 		BUG_ON(q->pi_state);
 
@@ -2583,7 +2583,7 @@ static int unqueue_me(struct futex_q *q)
  */
 static void unqueue_me_pi(struct futex_q *q)
 {
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
-- 
2.53.0

