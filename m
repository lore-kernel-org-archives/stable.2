Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62737BE8C;
	Wed,  3 Jun 2026 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450700; cv=none; b=sOTaC/edDsK4yINO8EoL4YbdMqdvP/pOhT5jwiHqXpLsZ/NoS/amS/FSBbUYXd+0T72GvjJDida99cZPiztibReCWdZJJ9nKAiE+2u31h2Xd6g0lEVxFsLeco7JGQaVRWaNO/tNQTI+VCLA5GPma+agtSGq3+FjIhIRMhl1G/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450700; c=relaxed/simple;
	bh=6K4kwWVj+MVW/8WTrSVGKkdwyz8YfNbYNzUN2tzQ5YY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGZY2wZp62BK2SnCWp89815eHvFl1tUeg76DO5iwc/y4rLGqQ65v7WGxwxuSa9ROcmHoEbwBp/H0yeveWRmpG3xsaGDtjn0lrII+yHFvglj9nLJ8a4gvr8gAPOefnplulFbBr0LUlWF0O31ZGykUf09Ao6bgl+J93znGxiTi0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZxOK2uCq; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZxOK2uCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780450687; x=1780709887;
	bh=V4RAZ7YsxCmaPJkYuxbidNGulBV6q3DaB47ubschr+A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZxOK2uCqHVInKh0XmtoOTk2Y+FABI8H3O9i84g/rzLu2QCHdSn16CBQpvCLL4CPJY
	 QvG1tZZIju/WdQ/ponqN00a707kw5Jy2AnqnBrFyJP1a6ryKguG7RqTwacnExHoYY9
	 5hs0QNvsKM1T07ySA6VbqrSeiiaqnFxL9U2RZs9jmd3igVSsHd2LNk3IElIqoliAet
	 ZeMfLCX5YLZy3x+denNS7IXN244H6VuMKkhOab7W7fr5J/3qFGVQu1JxaABoJPKb/O
	 9if9b6X62R6HHe7y8OhDVHQNy9WLABD1ZE38IwyBbZMBsGJzTayivSAgZof4nPRR1Y
	 iLvRbMxmqnlXQ==
Date: Tue, 02 Jun 2026 17:27:47 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] landlock: fix SCOPE_SIGNAL bypass on the SIGIO/fowner path
Message-ID: <20260602172741.18760-1-hexlabsecurity@proton.me>
In-Reply-To: <20260531.irah0eiM3Chi@digikod.net>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me> <20260531.irah0eiM3Chi@digikod.net>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: dd76b6c270b492527521f76e045ccb5f6023a19d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes a LANDLOCK_SCOPE_SIGNAL bypass on the asynchronous SIGIO
(fcntl(F_SETOWN)) delivery path, and adds a regression test.

A sandboxed process that owns a file or socket can request a signal
(F_SETSIG, e.g. SIGKILL) to be delivered to a whole process group on I/O
readiness (F_SETOWN(-pgid) + O_ASYNC).  When it is the head of its own
process group -- the default after fork() -- that group still contains the
non-sandboxed process that launched it (a supervisor, a security monitor),
so the sandbox can signal processes that SCOPE_SIGNAL is meant to protect
from it.

Patch 1 narrows the same-thread-group exemption in control_current_fowner()
so a process-group fowner always records the caller's Landlock domain; the
delivery-time check in hook_file_send_sigiotask() then runs against every
group member.  The direct kill() path (hook_task_kill) is unaffected.

Patch 2 adds the regression test in scoped_signal_test.c.

The defect was introduced by commit 18eb75f3af40 ("landlock: Always allow
signals between threads of the same process") in v6.15, and is present in t=
he
stable branches that backported it (6.12.y, 6.13.y, 6.14.y).
control_current_fowner() is identical across those branches.

A/B verified on 6.12.90 + CONFIG_SECURITY_LANDLOCK (same .config, only the =
fix
hunk differs): without patch 1 the new test fails (the non-sandboxed parent=
 is
signaled, SCOPE_SIGNAL bypassed); with patch 1 the new test passes and the
landlock signal-scoping suite is 20/20.

v3 -> v4 (review feedback from Micka=C3=ABl Sala=C3=BCn):
  - patch 1: rewrite the commit message -- drop the "cache" framing, lead w=
ith
    the threat scenario, mostly "why" and minimal "what", "process" not "ta=
sk";
  - patch 1: drop PIDTYPE_SID (not possible for an fowner) and use the defe=
nsive
    condition "!=3D PIDTYPE_PID && !=3D PIDTYPE_TGID"; simplify the in-code=
 comment;
  - patch 1: remove Reported-by (implicit with the same Signed-off-by);
  - send as a proper git send-email threaded series.
  - v1/v2 were sent to security@kernel.org (embargoed; not in a public arch=
ive).

Bryam Vargas (2):
  landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
  selftests/landlock: test SCOPE_SIGNAL on the SIGIO/fowner pgid path

 security/landlock/fs.c                        |  9 ++
 .../selftests/landlock/scoped_signal_test.c   | 97 +++++++++++++++++++
 2 files changed, 106 insertions(+)


base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
--=20
2.43.0


