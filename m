Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47E2EEE76
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615027; cv=none; b=Z/foNVkSwddUGfRggPj7sEwnC7LUbkGtoLn9Xcl54UlYp24H5hc8dXzwY3reDRYs4i+0xZ6e3Ozkw+4DFKfRdcE44CzvObVf2vtk05dVsMVo2W0O3pvY7Av2h3vUWusMaKm/sxVElGEHH/Ag6rnHhCR8Ix/+kf7sz+2n6a0BoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615027; c=relaxed/simple;
	bh=t58DHOlosOslnvkMsKXAJZE+tYd0rd5t7+rL4vHQ+5o=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=h0dUhnqNuuywm7HFNR4CXl1REQqzSW029zTZKIXZWGUThTmX4qjl39GWKvII/rV68zefdCkT1eTC/GkSs1h8MrSY05QXNdOL6Yg/bxC8heO+IFIdqCyXEangVYiXpFZ4HC5iIsV3q6R5WnC0uXQANc7rfy8oIzxQZxCM4DmoP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Gfh9QO22; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Gfh9QO22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780615012; x=1780874212;
	bh=D3NU5N03BdvQjGYqoWYBKW8NfgFTb1fFy4vrcHlyVAY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Gfh9QO22KK4O5uykJv6TAcTlkDtXecigBideLJtPU6HzTk4uOYceEI9Dp/RRBJJ0u
	 mDZRf57Db2QUdKOnm3Mp58E9yR1r1DtoZ7FrD3HKfKBp1yAr5lMZfDEUcC9zO1JFcy
	 LjskDLVjhuyVkjhkhAq3zMxwJ6kq6x8LPGd6mTsRXKsB/fmzv3MC7jH1bf5iijOqhs
	 vTfComgOuOv/gCDJDF3W0OL5b/zd5r8r3pqBv2vXe3jQV9QHr2ogfVPe3JpMX8ULRH
	 gwKtdGEID/gEVPim8Bo16NHoiEuomszpQ6RCd8z96ZeMm1I3G0G5Z8+v5wbF+p0vLn
	 Vbs40+sgZv2kg==
Date: Thu, 04 Jun 2026 23:16:47 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Justin Suess <utilityemal77@gmail.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] landlock: fix SCOPE_SIGNAL bypass on the SIGIO/fowner path
Message-ID: <cover.1780614610.git.hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: e9b4375a06059e5dd26de805de614bb79d1b7e70
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes a LANDLOCK_SCOPE_SIGNAL bypass on the asynchronous SIGIO
(fcntl(F_SETOWN)) delivery path, and adds regression tests.

A sandboxed process that owns a file or socket can request a signal
(F_SETSIG, e.g. SIGKILL) to be delivered to a whole process group on I/O
readiness (F_SETOWN(-pgid) + O_ASYNC).  When it is the head of its own
process group -- the default after fork() -- that group still contains the
non-sandboxed process that launched it (a supervisor, a security monitor),
so the sandbox can signal processes that SCOPE_SIGNAL is meant to protect
from it.

Patch 1 has two parts:

  - Narrow the same-thread-group exemption in control_current_fowner() so a
    process-group fowner always records the caller's Landlock domain; the
    delivery-time check in hook_file_send_sigiotask() then runs against
    every group member.  This closes the bypass.

  - Recording the domain alone over-blocks one corner: the kernel signals a
    process group through its members' thread-group leaders, and the leader
    of the registrant's own process can carry a different Landlock domain
    than the sibling thread that armed F_SETOWN.  domain_is_scoped() would
    then deny that leader, even though commit 18eb75f3af40 requires
    same-process delivery to be allowed.  hook_task_kill() avoids this by
    checking same_thread_group() live, per recipient; the SIGIO path
    delegated the whole decision to a single registration-time check that a
    fan-out cannot honor.  So patch 1 also records the registrant's thread
    group next to its domain and exempts it at delivery, restoring the
    same-process guarantee while keeping out-of-domain group members
    blocked.

The direct kill() path (hook_task_kill) is unaffected.

Patch 2 adds two regression tests in scoped_signal_test.c:
sigio_to_pgid_members (out-of-domain member must not be signaled) and
sigio_to_pgid_self (the registrant's own process, reached through its
thread-group leader, must still be signaled).

The defect was introduced by commit 18eb75f3af40 ("landlock: Always allow
signals between threads of the same process") in v6.15, and is present in t=
he
stable branches that backported it (6.12.y, 6.13.y, 6.14.y).
control_current_fowner() is identical across those branches.

Verified on 7.1.0-rc5 + CONFIG_SECURITY_LANDLOCK=3Dy (same .config, only th=
e
landlock change differs across arms):

  - unpatched: sigio_to_pgid_members fails (out-of-domain member signaled,
    bypass), sigio_to_pgid_self passes;
  - patch-1-record-only (the v4 hunk): sigio_to_pgid_members passes,
    sigio_to_pgid_self fails (the registrant's own leader is over-blocked);
  - this series: both pass, and the landlock signal-scoping suite is 21/21.

A standalone reproducer of both invariants was also built -m32 and -m64 and
run on each arm: the fix behaves identically through the i386-compat and th=
e
x86-64 native syscall paths.

v4 -> v5 (review feedback from G=C3=BCnther Noack):
  - patch 1: also fix the same-process over-block introduced by recording t=
he
    domain for a process-group fowner -- record the registrant's thread gro=
up
    (struct pid) in landlock_file_security and exempt it in
    hook_file_send_sigiotask() (task_tgid(tsk) =3D=3D fown_tg), restoring t=
he
    18eb75f3af40 guarantee for the registrant's own process;
  - patch 2: add sigio_to_pgid_self covering the non-leader-registrant /
    pgid-includes-self case;
  - drop Tested-by: Justin Suess -- patch 1 gained the delivery-time exempt=
ion
    he did not test (re-test welcome);
  - posted as a fresh top-level thread (no In-Reply-To to the v4 review).

  v4: https://lore.kernel.org/all/20260602172741.18760-1-hexlabsecurity@pro=
ton.me/
  (v1/v2 were sent to security@kernel.org while embargoed; not in a public
  archive.)

Bryam Vargas (2):
  landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
  selftests/landlock: test SCOPE_SIGNAL on the SIGIO/fowner pgid path

 security/landlock/fs.c                        |  15 ++
 security/landlock/fs.h                        |  10 +
 security/landlock/task.c                      |  11 ++
 .../selftests/landlock/scoped_signal_test.c   | 183 ++++++++++++++++++
 4 files changed, 219 insertions(+)


base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
--
2.43.0

