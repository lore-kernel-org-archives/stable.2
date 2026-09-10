Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E249C4B0
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049182; cv=none; b=aUSOAO7BQVlmqjLTnI4S0gEYZgvXbsOY3uGbTggVAtOjCWqHHRigkbQn2H6f2BASHkK2qoRWDti9SN3b9TOL0GZdk2+VVK9twPbnQV00YwrwEHk1DrnGlj6zuGg2xGEfc64zaBJ0mCWOPpUl3ZUdLlgFU4B9/HfG+wO/sn8fNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049182; c=relaxed/simple;
	bh=oOamHVN/XfoUAlzgIF9B0a6d1hpvznRMbHRrgsEpdAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVBd0lS+hnjr8VwJZOI1StYzusBuHGQWDqghtNCHmSiivuaHS6zPSlLqIpwAII1b3OUn1oGs6OZ6qup2pdc1v4VPGj1qCBIIyu3nSrLnmwERA0t6UKZeVEE/gSCYF3iYmWC+9hys7CTqkgjXOwNz4ayXWbu2Qwb2BjANh5yqjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFfPxEtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFfPxEtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E48C1F00898;
	Thu, 10 Sep 2026 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049180;
	bh=JYWvr7A6hvMOS0ZzjfdacAUYy1uSajC7NtAFuBcKHt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VFfPxEtvPpKzWmXZ1YrfZkXimeTuenDRyBIykkw0U5LanGCBzUk/5LarPvxO7S2UK
	 juci4qVh0wJf6KrAwwOrVL81nKUHwgqBdoae45W/uecw0/2aA5KlS7al7WuVNG6BwF
	 5ZOSB4meOjuTt9iugO4Yn0GJP4AQsk0nU/3fEfJvv0KycJjYM59m+75VKkXTVyXPXo
	 IU1xreahR0C8sJOpgIy1Ae8VKC4W+C/JRgUDD4N+QMZtGTWWgXkPb6ko686t4b+3Lz
	 33eIBx71Q+flXkbaKtutElXSRbJMp2fhumWUDPeVCnmeNzW7Ny9ih9QsPkmYIHQTrg
	 m6ZR+Z9/SYIwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] futex: Rename: {get,cmpxchg}_futex_value_locked()
Date: Thu, 10 Sep 2026 10:06:14 -0400
Message-ID: <20260910140617.564852-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910140617.564852-1-sashal@kernel.org>
References: <2026090826-jeep-tassel-64cd@gregkh>
 <20260910140617.564852-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 966cb75f86fb15e2659c8105d20d4889e18dda24 ]

In order to prepare introducing these symbols into the global
namespace; rename them:

 s/\<\([^_ ]*\)_futex_value_locked/futex_\1_value_locked/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-9-andrealmeid@collabora.com
Stable-dep-of: a3b8d46fe401 ("futex: Prevent rcuwait use-after-free during requeue PI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 2a1ecbbedd155..a404c8226d728 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -770,7 +770,7 @@ static struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb,
 	return NULL;
 }
 
-static int cmpxchg_futex_value_locked(u32 *curval, u32 __user *uaddr,
+static int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr,
 				      u32 uval, u32 newval)
 {
 	int ret;
@@ -782,7 +782,7 @@ static int cmpxchg_futex_value_locked(u32 *curval, u32 __user *uaddr,
 	return ret;
 }
 
-static int get_futex_value_locked(u32 *dest, u32 __user *from)
+static int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
 
@@ -1108,7 +1108,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	 * still is what we expect it to be, otherwise retry the entire
 	 * operation.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		goto out_efault;
 
 	if (uval != uval2)
@@ -1258,7 +1258,7 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
 	 * The same logic applies to the case where the exiting task is
 	 * already gone.
 	 */
-	if (get_futex_value_locked(&uval2, uaddr))
+	if (futex_get_value_locked(&uval2, uaddr))
 		return -EFAULT;
 
 	/* If the user space value has changed, try again. */
@@ -1379,7 +1379,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
 
-	err = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	err = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (unlikely(err))
 		return err;
 
@@ -1426,7 +1426,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 * Read the user space value first so we can validate a few
 	 * things before proceeding further.
 	 */
-	if (get_futex_value_locked(&uval, uaddr))
+	if (futex_get_value_locked(&uval, uaddr))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -1597,7 +1597,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 		goto out_unlock;
 	}
 
-	ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+	ret = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 	if (!ret && (curval != uval)) {
 		/*
 		 * If a unconditional UNLOCK_PI operation (user space did not
@@ -2046,7 +2046,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	u32 curval;
 	int ret;
 
-	if (get_futex_value_locked(&curval, pifutex))
+	if (futex_get_value_locked(&curval, pifutex))
 		return -EFAULT;
 
 	if (unlikely(should_fail_futex(true)))
@@ -2226,7 +2226,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	if (likely(cmpval != NULL)) {
 		u32 curval;
 
-		ret = get_futex_value_locked(&curval, uaddr1);
+		ret = futex_get_value_locked(&curval, uaddr1);
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
@@ -2672,14 +2672,14 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	if (!pi_state->owner)
 		newtid |= FUTEX_OWNER_DIED;
 
-	err = get_futex_value_locked(&uval, uaddr);
+	err = futex_get_value_locked(&uval, uaddr);
 	if (err)
 		goto handle_err;
 
 	for (;;) {
 		newval = (uval & FUTEX_OWNER_DIED) | newtid;
 
-		err = cmpxchg_futex_value_locked(&curval, uaddr, uval, newval);
+		err = futex_cmpxchg_value_locked(&curval, uaddr, uval, newval);
 		if (err)
 			goto handle_err;
 
@@ -2916,7 +2916,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 retry_private:
 	*hb = queue_lock(q);
 
-	ret = get_futex_value_locked(&uval, uaddr);
+	ret = futex_get_value_locked(&uval, uaddr);
 
 	if (ret) {
 		queue_unlock(*hb);
@@ -3297,7 +3297,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
 	 * owner.
 	 */
-	if ((ret = cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))) {
+	if ((ret = futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
 		spin_unlock(&hb->lock);
 		switch (ret) {
 		case -EFAULT:
@@ -3756,7 +3756,7 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	 * does not guarantee R/W access. If that fails we
 	 * give up and leave the futex locked.
 	 */
-	if ((err = cmpxchg_futex_value_locked(&nval, uaddr, uval, mval))) {
+	if ((err = futex_cmpxchg_value_locked(&nval, uaddr, uval, mval))) {
 		switch (err) {
 		case -EFAULT:
 			if (fault_in_user_writeable(uaddr))
@@ -4290,7 +4290,7 @@ static void __init futex_detect_cmpxchg(void)
 	 * implementation, the non-functional ones will return
 	 * -ENOSYS.
 	 */
-	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
+	if (futex_cmpxchg_value_locked(&curval, NULL, 0, 0) == -EFAULT)
 		futex_cmpxchg_enabled = 1;
 #endif
 }
-- 
2.53.0

