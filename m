Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD0382381;
	Tue, 22 Sep 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087621; cv=none; b=sVzgItSCN1vfxoBXmMKwBal2SCleeY++7CnMkGz5yqTzMDNXrV6Gxbe3Zvw6VznRK13VRRClkWqgC5uSAiHLf7d5BfoEvsUvtMT2PEELo689xjvEKTt38reUuyT/Fy/Q9JseG3lsEuDpjzf2pjQ2Vh8LBbpTBQtDUY8A4ou8m5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087621; c=relaxed/simple;
	bh=CHqV++KS6RHB6kYz97qF6YGlEunOCipdBNB08iPcByQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibx8S6BVgZ4I7gXjhyTAy2mylTl3eLAmBXv+IntFgG/2xdXlGYY4WrfRU5O03vBjG7BBHOD1Gtgvin9bQla54KLfWS9QaPlnIeDYPD4DWdQMKcstG8AlgvQnAIM9n5+CRjXCNyXxyXGJIdYguUwRVYdUcAVFhF6jVaqWqMt1i70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX9biEl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX9biEl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21801F000FF;
	Tue, 22 Sep 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790087619;
	bh=SX+z6NYoCWxNBGYU99ktnwwcCSe7GjbZgEJXo4djVCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BX9biEl1MsiHmxiw5g0mwtlxHsMXdJJs7EENd2SKzhScStDGRDti4g9OlEPHw93Ix
	 WrdBXYIVZUqDh6y4UhXrfQJaSXbUEpfMnPklbBRUI1kUaQ1OdGdIlQYaP2uiE+3K/Q
	 nKulIl1srUyP7Zg6uugHpCEHgsh/dd2RDn7SpBdeuYDN1LcvJOUErXq/QdFuLo1U0u
	 gl8yNWwEUhgFlk0Zulfl6iAqDpS/Fq7n2j0bDp/NkyUJlS51yQmFLsyFl9jefnguHS
	 EmvE0IyhrPe6y8vqHqStNyadWtZ5Im7mY8iygqft8AHxZD+n/7cmuJT8b+lXXeuztX
	 A6umjl156o2jA==
Date: Tue, 22 Sep 2026 16:33:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, io-uring@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 02/17] signal: only SIGKILL and the freezers interrupt
 a coredumping task
Message-ID: <20260922-bibliothek-fakten-vielzahl-78613362e349@brauner>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-2-8e4adb1619e6@kernel.org>
 <arJ6zZuI59BJnXpl@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arJ6zZuI59BJnXpl@redhat.com>

On Tue, Sep 22, 2026 at 02:55:41PM +0200, Oleg Nesterov wrote:
> On 09/21, Christian Brauner wrote:
> >
> > For quite a while now coredump has allowed either SIGKILL or freezing to
> > interrupt an ongoing coredump. Since we seem to like it complicated
> > "freezing" can mean a lot of things:
> >
> > (1) Power Management induced freezing
> > (2) cgroup v1 freezer controller induced freezing
> > (3) cgroup v2 freezer controller induced freezing
> 
> All of them do signal_wake_up() which sets TIF_SIGPENDING
> However, zap_threads() clears this flag.
> 
> With the recent changes including your PF_NO_NOTIFY_SIGNAL and
> 05/17 "signal: don't retarget shared signals in a dying thread group",
> what else can make signal_pending() true? Apart from SIGKILL.
> 
> So perhaps we can simply do _something_ like
> 
> 	--- x/fs/coredump.c
> 	+++ x/fs/coredump.c
> 	@@ -508,7 +508,8 @@ static int zap_threads(struct task_struc
> 		int nr = -EAGAIN;
> 	 
> 		spin_lock_irq(&tsk->sighand->siglock);
> 	-	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
> 	+	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task
> 	+	    && !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
> 			/* Allow SIGKILL, see prepare_signal() */
> 			signal->core_state = core_state;
> 			nr = zap_process(signal, exit_code);
> 	@@ -583,7 +584,7 @@ static bool dump_interrupted(void)
> 		 * but then we need to teach dump_write() to restart and clear
> 		 * TIF_SIGPENDING.
> 		 */
> 	-	return fatal_signal_pending(current) || freezing(current);
> 	+	return signal_pending(current);
> 	 }
> 	 
> 	 static void wait_for_dump_helpers(struct file *file)
> 
> ?
> 
> At first glance the change in dump_interrupted() makes sense anyway.
> For example, dumping to pipe can't tolerate signal_pendin() == true.
> 
> What do you think?

Yes. Here's what I have in the tree.

Subject: [PATCH v4 02/17] signal: only SIGKILL and the freezers interrupt a
 coredumping task

For quite a while now coredump has allowed either SIGKILL or freezing to
interrupt an ongoing coredump. Since we seem to like it complicated
"freezing" can mean a lot of things:

(1) Power Management induced freezing
(2) cgroup v1 freezer controller induced freezing
(3) cgroup v2 freezer controller induced freezing

So (1) and (2) are handled by checking freezing() but (3) isn't.
(3) uses cgroup_freeze_task() which sets JOBCTL_TRAP_FREEZE and calls
signal_wake_up() on every task in the cgroup. The trap isn't handled by
the coredump code.

Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/arJ6zZuI59BJnXpl@redhat.com
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-2-8e4adb1619e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v4:
- Gate the dump in zap_threads() on freezing() and JOBCTL_TRAP_FREEZE and
  let dump_interrupted() test the flag, as suggested by Oleg.
- Drop the signal_pending() hook and coredump_signal_pending().
- Blame the cgroup v2 freezer commit as well.
- Link to v3: https://patch.msgid.link/20260921-work-coredump-fixes-v3-2-8e4adb1619e6@kernel.org

 fs/coredump.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d88a65e37ee1..af09a4660341 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -508,7 +508,9 @@ static int zap_threads(struct task_struct *tsk,
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
+	/* A freeze requested before the dump would be lost with TIF_SIGPENDING. */
+	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task &&
+	    !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
 		/* Allow SIGKILL, see prepare_signal() */
 		signal->core_state = core_state;
 		nr = zap_process(signal, exit_code);
@@ -580,13 +582,8 @@ static void coredump_finish(bool core_dumped)
 
 static bool dump_interrupted(void)
 {
-	/*
-	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
-	 * can do try_to_freeze() and check __fatal_signal_pending(),
-	 * but then we need to teach dump_write() to restart and clear
-	 * TIF_SIGPENDING.
-	 */
-	return fatal_signal_pending(current) || freezing(current);
+	/* Only SIGKILL and the freezers set it after zap_threads(). */
+	return task_sigpending(current);
 }
 
 static void wait_for_dump_helpers(struct file *file)
-- 
2.53.0

