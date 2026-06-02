Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277C37BE88;
	Wed,  3 Jun 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450706; cv=none; b=VHpjUwPVRtQH1m2kSnu4xpDTRIhHWW19b8HncFMkhGyBcGGit7xKYToTQQnFUieoa+2GDTuf+6aVLSGX0MSeGBIadrxkpuwhHKk2KcWjfo8YU1lwywPLdMMBTL3G7ifyBShGtH7b6xi/W/XhrqjwbtgPei+pswjsZl/PMPShke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450706; c=relaxed/simple;
	bh=7dpTDpxwEOIzk22YgLvrqs67Vg7Je/wtKwL+vcE03QM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFbt3YGsZZoOlANLP7dw7V12aID8t1Vm6fQC/eAnKXoKJn06wsAnztNQJeKsn83nYIbDA2PsKKVCDC5G0UlPZF1W163A8Wk6USJrvucOsTkIxKJfTvAS0zjDikotNnRQt1S4A89DOox6DWGsVcRXZngzzUG/EMY8VQQYSPvDqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lWWRoizP; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lWWRoizP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780450698; x=1780709898;
	bh=Xoqh0gHhlYUbvmyM3ulY5nL3TPXotPEdpVBETVb6EVA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lWWRoizPdrttMmBQQyvx1vXFKvBunBnRxLjSwoT47KOhwpUjbmJNA1dNaXqsG5Vch
	 yxhuFZJ8TAQab/8iPeu0EuOZLh4dAz/Pvj4agljjz/4MwmibNrbQGqhbWr+oraHJ93
	 bEFtWfnQ6AdUvajuwiLkGNaaCZ3NMmGhg3uAtsyki6TZKuxACZkBdqUzJ6hYyxJnQa
	 qqN5E+tfzdrdsnZa+UEXpa2B5aD64qzuOyrS8a9iD6izZgJitJf90xC4vcj8loe7tZ
	 5sWqS3ILNWDFG97ynzcgV2GbNKzbYxsAYJdemGxlGMPV4Y/5gH/he8kUK/J/Ui9sad
	 M8oWm2Bw1lcyg==
Date: Tue, 02 Jun 2026 17:27:56 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
Message-ID: <20260602172741.18760-2-hexlabsecurity@proton.me>
In-Reply-To: <20260602172741.18760-1-hexlabsecurity@proton.me>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me> <20260531.irah0eiM3Chi@digikod.net> <20260602172741.18760-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 942fde585501fdf26f189db2f771231337837627
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

Skip the recording only for the single-process target types, so the scope
is enforced against every group member at delivery time.  The direct
kill() path (hook_task_kill) already evaluates the live domain and is
unaffected.

Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the=
 same process")
Cc: stable@vger.kernel.org
Tested-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/landlock/fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..2ebad70a956d 100644
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
+=09 * target -- even when it resolves to current as the group head --
+=09 * and let hook_file_send_sigiotask() check the live scope.
+=09 */
+=09if (fown->pid_type !=3D PIDTYPE_PID && fown->pid_type !=3D PIDTYPE_TGID=
)
+=09=09return true;
+
 =09return !same_thread_group(p, current);
 }
=20
--=20
2.43.0


