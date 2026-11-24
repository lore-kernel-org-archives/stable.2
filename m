Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561193;
	b=MtGFnJClxinDSU/LpcvyNLgJ6/THxapXkhTRIHf77f5dFBp5LCjngFuVHfPkOgkXFQwE
	 2Lcndb9ChpKqBbu5RnYt4/yoeFlbo6zXbgQozTr+BzFYk0pAiOxnxsSvHtSXI/lVEqife
	 wdAZ0FTxEYElfKpXLuy/TK6WEC9onlwjsJo4RqtxwjEWFKn8u5KQD08lQ5GcroInxAI9A
	 Rwlyw7AJlPW/6qlMcaFN7pe4KGmsv0GJ75ERmaYr6FFBkne9KTsJMwA/2T2PK4sxWlog0
	 SQeTWBKk0VR94xARZBEXKARhhHArknfTX3L5KhCImlR8QihGq9E85i9tsA42BTxEooA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561193;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LXmAmGdBNLLBP4R6S0ZfcTIok2405TTTPIbQrdyiZZw=;
	b=bInHuPXGZMmdI3COqrIGg/k3Oy2fjPOPwOTnjoydQBIVJnqhU/R8pyPBT2BrWYUquau9
	 PHnGy46ayehyb6H6Wfw5kb+Hjygr9Rllw2jsO2Q9dbhcCcit0tHu93sbEfF+heovlThp4
	 qpCLlYLNrYx3jQkoYT/97LG/sAw1N7NoHoVlkGbo9G+44Fp4tXKmw1nO/GHyA8QxAGyz4
	 9oy48pkspD3zy0hZ3V+fjN4gA7+mlojmSXR1wr4ZCafuKo1FX1dcePdJyMtaVQy7RdRgz
	 xpwGLzOZ/j3pVq5gf5hhoynf5JXpXQbDMNrIQ1sFNVXLSiqEf3m32O5jr8sl6gmaJLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AX8myc6P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349F606A330;
	Tue, 24 Nov 2026 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AX8myc6P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1744F1F000F2;
	Tue, 24 Nov 2026 22:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561193;
	bh=LXmAmGdBNLLBP4R6S0ZfcTIok2405TTTPIbQrdyiZZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AX8myc6PK9Et1np5YJLmjrgno2cX9NsDytcEZbZlB9OZmyITi41GUplWWvz5coWZ/
	 oKMVzLU57myhtd/Z6GnvQ37v8ruIRBVvTY8ziFcWwnKzcymwdOcUtdt2wOjAiFPbc8
	 XzF84LtsDOYDEHJuhSCyAB6HKq41AZskoDTl3zSdf6wAMc1MESsyvFnnVoWTrxylqb
	 p4ouxxHAZK7TquvbrphpwIoOspozvJMVfR/F2vH1afymmxwSJ5ydlzlu9vHbtsdQtv
	 CIjVYV9iT/ZDAkkmmFLqU0pKLMX4CCiBHfJdSa8LBkxoildxpoySNtAUArjfOZc5Ql
	 pv4qTDO95TOUg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:29 +0100
Subject: [PATCH RFC 06/19] exec: move unshare_sighand() before exec_mmap()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-6-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M1m34MDED+Y6PEKM7nEMrksy4d72guGeEChTZo/u7p8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzie3ZteW3aI9x60n9Pe/OvhHLVX4e/j414rvz/g/1v
 LyJbYqhHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZWM3wP3Hes+TLvJtzPuu4
 d3+TCL79Y///gOMfF8rcnfA+6rHSi2UM/2M/B31rL375oV3m107F6i2Ky1VZ4/gm7N2z8mTcr6/
 vT7MBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A task that called vfork() sleeps until the child has released the mm.
During exec that happens in exec_mmap(). A child that was created with
CLONE_SIGHAND shares its signal table with the parent and
unshare_sighand() only gives it a private one after exec_mmap(). So the
parent runs again while the child is still on the table they share. If
the parent ignores a signal right after vfork() returned the new image
can end up ignoring it as well.

It used to be the other way around. Commit ccf0fa6be026 ("exec: Move
exec_mmap right after de_thread in flush_old_exec") moved exec_mmap() in
front of it for two reasons. bprm->mm was to tell whether exec is past
the point of no return and everything that can wait for userspace
indefinitely was to sit in front of the lock that became
exec_update_lock.

Move it back to where it used to be, right after de_thread() and the
posix timer cleanup. Nothing in between relies on the signal table still
being shared. With that the table is private before the parent is woken
up. And the new table isn't allocated with exec_update_lock held
anymore.

Fixes: ccf0fa6be026 ("exec: Move exec_mmap right after de_thread in flush_old_exec")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8d2b14e1d455c..87b78fce609de 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1171,6 +1171,14 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	posixtimer_exec();
 
+	/*
+	 * Make the signal table private before a vfork() parent that shares
+	 * it is woken up.
+	 */
+	retval = unshare_sighand(me);
+	if (retval)
+		goto out;
+
 	/* see the comment in check_unsafe_exec() */
 	current->fs->in_exec = 0;
 
@@ -1223,13 +1231,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out_unlock;
 
-	/*
-	 * Make the signal table private.
-	 */
-	retval = unshare_sighand(me);
-	if (retval)
-		goto out_unlock;
-
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();

-- 
2.53.0

