Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F24AC15D;
	Thu, 17 Sep 2026 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636688; cv=none; b=ItpasluMZoc5YAukQPDyq3BTMZxSAKbwDcxP8gehRyIBX/js9rwZjwNDOBzcrAbRZKDZurkdAzT39qJO/+3OgLa/nozXOSWpwEULxmWmks4qhxbvn9hIJ3Vofz1pP+fAb0sbZgYJX2MFkgmiN4zap0ijKEg8tFi3mifkKS7du3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636688; c=relaxed/simple;
	bh=QFgjXXUybA8CBQDzo0leFmaEK+XgKvIPes+QPTJhl4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3aJr90a+G+Idhcc5NomJvM6Jj6B0XQRK6OFSFPx/+YHz7nHiL7x0KQAuu/LMFjiI7lvgMXh7wlt9xLsIHvsV1r3BYwNGUDNAcUiHJA+Sy1fGYZYlkqsQzO9v9x7jVz0JdxB6qB5UvLm/i8A1fp1R2zh6uz98KTve+L3+fndBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUrqL/gE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUrqL/gE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FFE1F000FF;
	Thu, 17 Sep 2026 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636685;
	bh=/Rhxw036vxujupFof0/OPSjDt69n/+Ot/zuxSne0Eqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GUrqL/gEKSnTVaqEMvtTMGAJIeAc3r1NHdhkY/bcVnaqjDYy7u/nc9nEWQUY+dn8F
	 XoCdbwTsnfZI8ojF1nF7YW4wAzKsG/p6LxqFNL0layDchsrDMBrwZqFZKqpUDmgC82
	 AAgiW7w74PRJm3hJ93xqiliY6Jn+nlnyhTRWnKnAP4ZLLnfMMGc8VagCQuSIIy5zqj
	 1r4lbKsNjJwkuUD40b9C1AROzPPdszzmoZNLncBcTqOgeSlgbdKtnuzSy2ivEkkYCE
	 l0KXXuVRnw83JH7voMkIy6gHPECHSHHq25H36zaZiEwF/fBflCbjLSzYIn82/fQuUA
	 vJgUsyHK8UIPg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:17:33 +0200
Subject: [PATCH v2 6/7] signal: don't retarget shared signals in a dying
 thread group
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-coredump-fixes-v2-6-f3787fcda051@kernel.org>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
In-Reply-To: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QFgjXXUybA8CBQDzo0leFmaEK+XgKvIPes+QPTJhl4U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3mBSyypWda//OuPjubFXtBm/HNH9kSkm5b5ScNmR0
 2m3X6cZdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkrw8jw4mVW053OxmfeSC4
 o/1cFGP1m6bT/5ce4inKTqzcKJ2j8JeR4b+D9D2R2y1XvJcfks+YNGHNmdVTT9hce3JUVTb20pI
 /c5gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

If the calling thread has blocked a signal then
retarget_shared_pending() slingshots a shared pending signal to a
sibling thread. Today it only skips PF_EXITING threads but not a
coredumping thread.

But if SIGNAL_GROUP_EXIT is set no thread in the thread-group can
dequeue such signals anymore as get_signal() sends SIGKILL to every
thread and prepare_signal() drops any other signal.

exit_signals() also returns early on SIGNAL_GROUP_EXIT. But neither
sigprocmask() nor the mask restore in sigtimedwait() do.

Say a thread sleeps in sigtimedwait() and a sibling thread crashes. The
sleeping thread gets woken by the zap call. It restores its mask on the
way out and retargets a signal that was queued for the coredumping
process. That means TIF_SIGPENDING is set on the coredumping task which
zap_threads() had cleared. So a blocking write sees TIF_SIGPENDING and
truncates the dump.

Stop retargeting signals when SIGNAL_GROUP_EXIT is set and avoid
needlessly truncating coredumps.

Fixes: e6fa16ab9c1e ("signal: sigprocmask() should do retarget_shared_pending()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index d8bb1f168055..c3bad983dd37 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3117,6 +3117,10 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 	sigset_t retarget;
 	struct task_struct *t;
 
+	/* Nobody dequeues them in a dying group, see get_signal(). */
+	if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
+		return;
+
 	sigandsets(&retarget, &tsk->signal->shared_pending.signal, which);
 	if (sigisemptyset(&retarget))
 		return;

-- 
2.53.0

