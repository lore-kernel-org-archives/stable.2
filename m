Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049839;
	b=uUmQWexxEshIbz3h7NsxQjuA0vf55IVnrOZwYx970fnBE5fu8fFNbkKwr4Mfby0GEL45
	 fnIvqWFPV6gtKmQtjDO6kZT80fVdEXHOYHLiSB1/OMsyC1eHdCG0IWqExk6oug0ylQMaz
	 oCywuSoPwhnDMPpVIx6XOKuKrOywaW5xNUs6UfuyAjp3HE92rphPVr84N4WNhJl1UntUK
	 1rHG+isPcXruNomf92WC+kLaPxOsr3Wa7NrbcJ2qLlSK9iFwEWlTZMnuttV4H7sna0Ge2
	 BrdsxKsP8YRhbB3cn44JTsKO25XSlSW6kyRjSwo9ObGd+52EoxdTXiTw8tZ96+kH4bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049839;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iSGHFCbxDtejkROazBf4jfzKn4SV8NBEdhhleDCVHOE=;
	b=5g2R53sTcwcKd2noFDbMKqiv1UkuKQN/nKHYtY1KiidLmYNwEDcZ2MMSFS29cOS8qQU3
	 czlkVAXUaqkSwlY0iWOzeKqTmaBE2wMKNF+IoNSGshyEO0x5FuGCpEEiadHdam0klcck1
	 ObiDuYCTE4iWuOrY07rE+AV5WPG2Ju2YULFQlEjL358fNi/BM0cuE1J96a8HSM65d6jdZ
	 jHbQDzpsMR38O3MGZb1L6GJHh9t/0kqQW6F3sGlNGhGTAwen1tFpyVLmkiO1SZZlKoJ9t
	 2vUjU14FK4tjceDedN9RAUWxpGtYQp3FKb4Aitof8qYn2/4ee9YDEttBlIMnQOhU3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWmbYV2d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWmbYV2d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6B51F008A1;
	Sat,  7 Nov 2026 11:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049838;
	bh=iSGHFCbxDtejkROazBf4jfzKn4SV8NBEdhhleDCVHOE=;
	h=From:To:Cc:Subject:Date;
	b=iWmbYV2dtYzu8pUQKlhqI3tevlSSW3WbqyhoYmDJbryIATcvEfc4TabFmLLVVhRDt
	 ZZ7baHeEOFPayKmWhWNDItaZzepZmXKnQtR6pU7XTye1VswmRIccHLtNRdoPiqt36q
	 KquEq/nkrhkbk1eOXyFdv7PlPl7iuTq0bFRGVc3Fpda5T6cExxx/QpihF6rOty6ulY
	 m/gojPTi+jZAhqkdWwrjFhd+NkWg0C/5ZJsgTB1xUsonqVjUhZtoQXEqO0eVzwkb+c
	 gH8KP0WBjWf1nYQmmtDsdjKktR1XPBRmLCRuu+LFn0iaLLSOzwdhrcHcqnQQeZy9We
	 bX/h2nRsQSFbg==
From: Sasha Levin <sashal@kernel.org>
To: nickolai@csail.mit.edu,
	legion@kernel.org,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ucount: take the rlimit reference before checking the limit" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:36 -0500
Message-ID: <20261107061036-failed-5.15-b14fcabd34e0@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b14fcabd34e02c40f72d3cd1e9bd4fd18df40ff1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061036-failed-5.15-b14fcabd34e0@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b14fcabd34e02c40f72d3cd1e9bd4fd18df40ff1 Mon Sep 17 00:00:00 2001
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Mon, 19 Oct 2026 14:59:13 -0400
Subject: [PATCH] ucount: take the rlimit reference before checking the limit

inc_rlimit_get_ucounts() takes the reference that pins a ucounts level
while its rlimit count is non-zero only in the walk whose increment is
the 0 -> 1 transition, and only after that walk passed the limit check.
A walk that raises the count from zero and then fails the limit backs
out without the reference, while a concurrent walk that raised it past
one keeps its increment and never takes one either:

  CPU0 (obeys the limit)              CPU1 (overrides it)
  new = add_return(1) -> 1
                                      new = add_return(1) -> 2
                                      new != 1, no get_ucounts()
  new > max -> dec_unwind
  sub_return(1) -> 1   (no put)

The count is 1 with no reference held. When CPU1 drops its charge,
dec_rlimit_put_ucounts() takes the count to 0 and puts a reference
nobody took, which frees the live struct ucounts, and the user_namespace
it pins, with kfree_rcu(). The mirror interleaving leaks the reference
instead.

An unprivileged user reaches this on a kernel with CONFIG_USER_NS=y: in
a user namespace with RLIMIT_SIGPENDING 0, one process taking
synchronous SIGSEGVs (forced, so override_rlimit is set) races a second
process in the same namespace and uid that queues real-time signals,
which obey the limit. The two hold different sighand->siglock but charge
the same per-namespace SIGPENDING ucounts. Unpatched, with rcuref
debugging:

  rcuref - imbalanced put()
  WARNING: lib/rcuref.c:266 at rcuref_put_slowpath+0xf4/0x120
   put_ucounts+0x5a/0x180
   do_dec_rlimit_put_ucounts+0x70/0x90
   __sigqueue_free+0x33/0xc0
   get_signal+0x56f/0xd20
   arch_do_signal_or_restart+0x87/0x380
   irqentry_exit+0x243/0x650
   asm_exc_page_fault+0x26/0x30

Take the reference on the 0 -> 1 transition before the limit is checked,
so the walk that raises the count from zero owns that level's reference
even when its request is rejected, and unwind a rejected level through
do_dec_rlimit_put_ucounts(), which releases the reference when the count
returns to 0. The get_ucounts() failure path is unchanged. With the
patch the same interleaving, forced some 80000 times in a KASAN build,
produces no warning and no KASAN report.

Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
Cc: stable@vger.kernel.org
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
Link: https://patch.msgid.link/20261019185913.805378-1-nickolai@csail.mit.edu
Acked-by: Alexey Gladkov <legion@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/ucount.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index ec8b1445e2877..c3de5b94d25f7 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -308,23 +308,26 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
 		long new = atomic_long_add_return(1, &iter->rlimit[type]);
-		if (new < 0 || new > max)
+		/*
+		 * Take the extra reference on the 0 -> 1 transition before the
+		 * limit check: a rejected walk must not leave a concurrent one
+		 * holding the surviving increment with no reference.
+		 */
+		if (new == 1 && !get_ucounts(iter))
 			goto dec_unwind;
+		if (new < 0 || new > max) {
+			/* undo iter too, releasing the reference taken above */
+			do_dec_rlimit_put_ucounts(ucounts, iter->ns->ucounts, type);
+			return 0;
+		}
 		if (iter == ucounts)
 			ret = new;
 		if (!override_rlimit)
 			max = get_userns_rlimit_max(iter->ns, type);
-		/*
-		 * Grab an extra ucount reference for the caller when
-		 * the rlimit count was previously 0.
-		 */
-		if (new != 1)
-			continue;
-		if (!get_ucounts(iter))
-			goto dec_unwind;
 	}
 	return ret;
 dec_unwind:
+	/* get_ucounts() failed for iter: undo iter without a put */
 	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 	WARN_ON_ONCE(dec < 0);
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);
-- 
2.53.0




