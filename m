Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A767307AC7
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615036; cv=none; b=Z4uv1llRNZtx3muNjozb38w/P4RZVMlJXFuLIPSoaMoT4/Y7By5dLw6qeeOkNW1hFlE009TkRbZtKw58ewgB3YDoebZgW9Q8WTLoPcKRUSxyj02hlpTqcY1JFliBk9wE8F1GnxQafFLP9V/FYKz3rj3sWA87PSLeHoeY3LvSBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615036; c=relaxed/simple;
	bh=vYhMDrBpV7wOSjocHi8K3ga4voNaT8tKsxyCR9Ta0LM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnZduyzoElOoZcmRpHoKFx0LZEkqu88rtl1NX3NaBlQU02eOPW1H/atMyzsdfcgzB8LolSdIcrkAn7d7LZoyk3T6CJ70/O7Jx0l2dYZNTazw5VEIfnrAHJsILIF8pmQSd6LGhbv69D4wuCDNn3su4/npokRi7q1VYDky8epz5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Dbg/P6Wy; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Dbg/P6Wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780615021; x=1780874221;
	bh=F38WRE3pbuiYboY8ELg0IIsOnygtwhytVmx/MH3Tm+4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Dbg/P6WyQLn5/eMHXAniu8NFb2n0Pqjk19WGonQVHb0R943KIWXox4/cACP7F8V9S
	 Wqx64/ZyraKsU8A8jVVIPc9X0FMWzVndmwC7afl5Of1OsFQ+PFES5uBgjTWXmAqBB9
	 7MUWKMNyHmFmfXiHe/+MXVTdw4yDvNgsJjOnBpiVekZt29n2IIPSc2u/JW3XvTaQ2P
	 Owm4v+GS42LRDuZl4SoZT7LAyGY0icEYfqrivAgo5Yln9y1VIdxzJ0my9f/rdNx+5Z
	 fs/UbrpyZ6ttV/Ibt9OjdO/2YJGZMGMC/hu1wydktUGOBZtMifnfN3RW2cCyoycULV
	 /sFhFMYGVj/1g==
Date: Thu, 04 Jun 2026 23:16:56 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
Message-ID: <56bffc24f3d0d08b45a686a48e99766b0a0821fa.1780614610.git.hexlabsecurity@proton.me>
In-Reply-To: <cover.1780614610.git.hexlabsecurity@proton.me>
References: <cover.1780614610.git.hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 32d7ab5ca986a1270ab561b78aecd653e0abfe31
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

LANDLOCK_SCOPE_SIGNAL must prevent a sandboxed process from signaling
processes outside its Landlock domain.  It can be bypassed through the
asynchronous SIGIO delivery path.

A sandboxed process that owns any file or socket can arm it with
fcntl(F_SETOWN, fd, -pgid), fcntl(F_SETSIG, fd, SIGKILL) and O_ASYNC, so
that an I/O event makes the kernel deliver the chosen signal to the whole
process group.  As the head of its own process group -- the default right
after fork() -- that group also holds the non-sandboxed process that
launched it, e.g. a supervisor or a security monitor.  The sandbox can
thus kill or repeatedly signal exactly the processes SCOPE_SIGNAL is meant
to protect from it.

The scope is enforced in hook_file_send_sigiotask() against the Landlock
domain recorded at F_SETOWN time, not the live domain of the sender.
control_current_fowner() decides whether to record that domain and skips
recording it when the fowner target is in the caller's thread group --
safe only when the target is a single process sharing the caller's
credentials (PIDTYPE_PID, PIDTYPE_TGID).  For a process group
(PIDTYPE_PGID) the target resolves to the caller itself when it is the
group head, recording is skipped, and hook_file_send_sigiotask() then lets
the signal fan out to the whole group unchecked.

Record the domain for every non single-process target so the scope is
enforced against each group member at delivery time.

That recording is necessary but not sufficient on its own: the kernel
signals a process group through its members' thread-group leaders, and the
leader of the registrant's own process can carry a different Landlock
domain than the sibling thread that armed the owner.  domain_is_scoped()
would then deny that leader, even though commit 18eb75f3af40 ("landlock:
Always allow signals between threads of the same process") requires
same-process delivery to be allowed.  hook_task_kill() avoids this by
evaluating same_thread_group() live, per recipient; the SIGIO path instead
delegates the whole decision to a single registration-time check, which a
process-group fan-out cannot honor.

So also record the registrant's thread group next to its domain and exempt
it at delivery: hook_file_send_sigiotask() allows the signal whenever the
recipient belongs to the registrant's own process, restoring the
same-process guarantee while keeping out-of-domain group members blocked.
The direct kill() path (hook_task_kill) already evaluates the live domain
and is unaffected.

Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the=
 same process")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/landlock/fs.c   | 15 +++++++++++++++
 security/landlock/fs.h   | 10 ++++++++++
 security/landlock/task.c | 11 +++++++++++
 3 files changed, 36 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..ff2c12e38bfc 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1909,6 +1909,15 @@ static bool control_current_fowner(struct fown_struc=
t *const fown)
 =09if (!p)
 =09=09return true;
=20
+=09/*
+=09 * A process-group fowner fans the signal out to every member at
+=09 * delivery time, so record the domain for any non single-process
+=09 * target -- even when it resolves to current as the group head -- and
+=09 * let hook_file_send_sigiotask() check the live scope per recipient.
+=09 */
+=09if (fown->pid_type !=3D PIDTYPE_PID && fown->pid_type !=3D PIDTYPE_TGID=
)
+=09=09return true;
+
 =09return !same_thread_group(p, current);
 }
=20
@@ -1916,6 +1925,7 @@ static void hook_file_set_fowner(struct file *file)
 {
 =09struct landlock_ruleset *prev_dom;
 =09struct landlock_cred_security fown_subject =3D {};
+=09struct pid *prev_tg, *fown_tg =3D NULL;
 =09size_t fown_layer =3D 0;
=20
 =09if (control_current_fowner(file_f_owner(file))) {
@@ -1928,21 +1938,26 @@ static void hook_file_set_fowner(struct file *file)
 =09=09if (new_subject) {
 =09=09=09landlock_get_ruleset(new_subject->domain);
 =09=09=09fown_subject =3D *new_subject;
+=09=09=09fown_tg =3D get_pid(task_tgid(current));
 =09=09}
 =09}
=20
 =09prev_dom =3D landlock_file(file)->fown_subject.domain;
+=09prev_tg =3D landlock_file(file)->fown_tg;
 =09landlock_file(file)->fown_subject =3D fown_subject;
+=09landlock_file(file)->fown_tg =3D fown_tg;
 #ifdef CONFIG_AUDIT
 =09landlock_file(file)->fown_layer =3D fown_layer;
 #endif /* CONFIG_AUDIT*/
=20
 =09/* May be called in an RCU read-side critical section. */
 =09landlock_put_ruleset_deferred(prev_dom);
+=09put_pid(prev_tg);
 }
=20
 static void hook_file_free_security(struct file *file)
 {
+=09put_pid(landlock_file(file)->fown_tg);
 =09landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain)=
;
 }
=20
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index bf9948941f2f..911b83669e20 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -78,6 +78,16 @@ struct landlock_file_security {
 =09 * euid.
 =09 */
 =09struct landlock_cred_security fown_subject;
+=09/**
+=09 * @fown_tg: Thread group of the task that set the file owner, pinned
+=09 * while @fown_subject holds a domain.  It lets
+=09 * hook_file_send_sigiotask() always allow a SIGIO delivered to the
+=09 * owner's own process -- e.g. the thread-group leader reached through =
a
+=09 * process-group owner -- matching the same-process exemption of
+=09 * hook_task_kill().  NULL when no domain is recorded.  Protected by
+=09 * file->f_owner->lock, like @fown_subject.
+=09 */
+=09struct pid *fown_tg;
 };
=20
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 6d46042132ce..7ddf211f75c3 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -411,6 +411,17 @@ static int hook_file_send_sigiotask(struct task_struct=
 *tsk,
 =09if (!subject->domain)
 =09=09return 0;
=20
+=09/*
+=09 * Always allow delivery to the file owner's own process, including a
+=09 * thread-group leader reached through a process-group owner.  This
+=09 * mirrors hook_task_kill()'s same-process exemption and preserves the
+=09 * guarantee of commit 18eb75f3af40 ("landlock: Always allow signals
+=09 * between threads of the same process"), which the registration-time
+=09 * check cannot honor for a process-group target.
+=09 */
+=09if (task_tgid(tsk) =3D=3D landlock_file(fown->file)->fown_tg)
+=09=09return 0;
+
 =09scoped_guard(rcu)
 =09{
 =09=09is_scoped =3D domain_is_scoped(subject->domain,
--=20
2.43.0


