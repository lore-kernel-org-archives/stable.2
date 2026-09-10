Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47247499F1D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049181; cv=none; b=UvxUY+L+uAgk09VPqAdpdueVkgvyMtrXndo9vcwPAXgOUsHNeT7tlzIxFaecrdqPkLcYpZ8V6Q1RbDGjniaY+z5VFP98qvDH4OW/kP9oMLtMR8S8JT93Rxm38cU7SsGdjtSQA9g0L6a1v9VTJxu2RaB7SenNKsbgr3F3ByU/JLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049181; c=relaxed/simple;
	bh=cnKNuEWIcXR6YzgQM/X3BDE2gkKXmGd4ipb5snY6ob8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WN7VTOzWJ3xlSbSYL3v9koGMwXrB6rxn1omcjM5PM2F8R/2/wmbUJ0pbqEfTzEjqczEMwADsb5Tt7mcWuQCNTyxXqFZTPGTezAM2eMCc+O1zLNGsPrIQXopgi+bcNYagD5Cw390gCAOsZxb1S7+jn8SvHdb8xP9ijJKF1UWWez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByGY46XT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByGY46XT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6069A1F000FF;
	Thu, 10 Sep 2026 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049179;
	bh=dGmmwv9eF4kfTortKerE6XdnQbrInQZa5h7Zy+koy10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ByGY46XTd+NqB0MPXpsBc25n7I8L+LasLTdFvn2iJwl3e1imumvyyTssGftXU9j1r
	 8988iVy4cyIabo71K00BTxzEH8hKXnN+LC7pSijwzQGJqGjLbYYxnqYaUfuCOzJcEM
	 qcAc+qPeU3lFzIOMlhBuDUn/Yhp11VWfPOeFYJKwNCLaCly7zmSrdU01s5VrJsBY7f
	 maS7fpvC3c+UfVXidsy68OEz+f5bzTrCfyVT9eSwjfxZUGki1Zr4Iw6Qz3aRDpaZsM
	 oBG1v0B6JsAle/tug05WoBsVwiGLMszTV2HTgN/BpvYVmyEOeyHBUTtA75pSFPNwRa
	 cXLN97tyNHR2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] futex: Rename hash_futex()
Date: Thu, 10 Sep 2026 10:06:13 -0400
Message-ID: <20260910140617.564852-2-sashal@kernel.org>
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

[ Upstream commit eee5a7bc96becd7cdb8e4fabd327ca5e49136704 ]

In order to prepare introducing these symbols into the global
namespace; rename:

  s/hash_futex/futex_hash/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-8-andrealmeid@collabora.com
Stable-dep-of: a3b8d46fe401 ("futex: Prevent rcuwait use-after-free during requeue PI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index ff61ed8184a32..2a1ecbbedd155 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -298,7 +298,7 @@ struct futex_hash_bucket {
 
 /*
  * The base of the bucket array and its size are always used together
- * (after initialization only in hash_futex()), so ensure that they
+ * (after initialization only in futex_hash()), so ensure that they
  * reside in the same cacheline.
  */
 static struct {
@@ -408,13 +408,13 @@ static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
 }
 
 /**
- * hash_futex - Return the hash bucket in the global hash
+ * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
  *
  * We hash on the keys returned from get_futex_key (see below) and return the
  * corresponding hash bucket in the global hash.
  */
-static struct futex_hash_bucket *hash_futex(union futex_key *key)
+static struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
 	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
@@ -923,7 +923,7 @@ static void exit_pi_state_list(struct task_struct *curr)
 		next = head->next;
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
-		hb = hash_futex(&key);
+		hb = futex_hash(&key);
 
 		/*
 		 * We can race against put_pi_state() removing itself from the
@@ -1673,7 +1673,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (unlikely(ret != 0))
 		return ret;
 
-	hb = hash_futex(&key);
+	hb = futex_hash(&key);
 
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
@@ -1771,8 +1771,8 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	if (unlikely(ret != 0))
 		return ret;
 
-	hb1 = hash_futex(&key1);
-	hb2 = hash_futex(&key2);
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
 
 retry_private:
 	double_lock_hb(hb1, hb2);
@@ -2216,8 +2216,8 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	if (requeue_pi && match_futex(&key1, &key2))
 		return -EINVAL;
 
-	hb1 = hash_futex(&key1);
-	hb2 = hash_futex(&key2);
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
 
 retry_private:
 	hb_waiters_inc(hb2);
@@ -2459,7 +2459,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	hb = hash_futex(&q->key);
+	hb = futex_hash(&q->key);
 
 	/*
 	 * Increment the counter before taking the lock so that
@@ -3224,7 +3224,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	if (ret)
 		return ret;
 
-	hb = hash_futex(&key);
+	hb = futex_hash(&key);
 	spin_lock(&hb->lock);
 
 	/*
-- 
2.53.0

