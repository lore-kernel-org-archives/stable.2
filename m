Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561170;
	b=huUuWVPRAPty5VNqjvxixdQgGu6z/gxPolq9QA+2qajg6C5WZeLkda00Juvm2kwITMLg
	 pf6WQvIpygri7GICSq2fg6TP/zMq77YdL5EP/bW+0xNj9bIVvND/ZzPJ6KGhDyrsS81ix
	 kXQD2kyPnRfPtYCEGRAla8dbz/AF3Fd53+6DAQPIyfKKYb+jM3o1jZmm7jCSzVpPgqShF
	 cgoaOsik0JRgmOeUSWqC3bNk6pJE8HJaAwmlkMz9O8BSeAecxpCSFPS8vNHtlgO2GWFgz
	 1t4MaqJH1k2/jpc1Vny9qQ6nKWdFnnA3LE3U0smPx4CHXzZwVAWg9mHVvo7+EYqb/3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561170;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rmQ2mWQe1HLwl5h32XWTPmN+b/bN2UGjG7wxAGIsjRg=;
	b=ro/Yg1v2y5MfUsg5mctkdlkZjSCSy4DT28/v4oZAhtYWnY4b0i+RFDU/p+avFyCGRPxa
	 Cci3rZlqf8HiYzN36xZ5IvsDt32413l8pfz/9+5zHspzBp4Gl1yfLGq1P+JyptdS5CXMW
	 MjEzdP+aT6XzlQ08D+dVXd4pIYwyGkH2pAe8OF4GmvJ0W195LNZxlHiN0bN55DsNtWAKu
	 Cu/L9kruHiGy6PGg6C4RYiu2rbN6DTJONAVruLNICadjngWJc7WpchMPHOeUak5Weu3I6
	 n+OykrL7UFQeRi5EEkM9Z1W+M5OYoUDU7vzBvFUppH7GsJQOm8YTEitpyVyJMCEOmVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fx6VAKSQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB08606A321;
	Tue, 24 Nov 2026 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fx6VAKSQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEF01F000C0;
	Tue, 24 Nov 2026 22:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561170;
	bh=rmQ2mWQe1HLwl5h32XWTPmN+b/bN2UGjG7wxAGIsjRg=;
	h=From:Subject:Date:To:Cc;
	b=Fx6VAKSQToO9Z1hdram1YUO1lEL5Vt1A4K83I+U5OyaiTgBQfNTEQxUXsyJ1IQxgb
	 IHT6YjJaea2BovBd5acGXlTUQQ88026Z7JTWJutZbpMdWKSogu0RT/hkkScA6kVoST
	 pbnUMIe93GcaSsv9oGFgEDwvPwdJPJ/+KU1mOJGE/SgQCjMJFP8sC+TgqwMgM5DSR1
	 tdmU77sDqmOfYcUfn8MJr03VXNILpuzNXB60i30QWHBikWocqq36zaeVcag741ONXD
	 cm9I9GJyDeMz8vFUV6FnN4fRRA/uDEUJ6ibotoWcsRjrxbxQC0fRL6erYnbH9jHGz1
	 Yk93YFfq3nxBw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 00/19] exec: move sleeping work out of exec_update_lock
Date: Tue, 24 Nov 2026 23:58:23 +0100
Message-Id: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MzQrCMBAE4Fcpe3ZDEoqKV8EH8Coi+dnaWGlK0
 mqh9N3N6sXjDDPfAplSoAyHaoFEr5BD7EtQmwpca/o7YfAlg5Z6q5SW+I6pQ5rJ4TR4M9LtGV2
 Hu6a25GRt/V5B+Q6JmjB/3QucT0e4/so82Qe5kUWeWZMJbTK9a7liW7At/mzBI1jXD6SXPUOrA
 AAA
X-Change-ID: 20261120-work-exec-update_lock-7f4bec04bd81
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=5297; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iICEnBMyaYbDfJP4wFkUJlvvreRE2YBrucPLrqy5+d4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziW3dMkEwIPUaF2OUU+SUnyK7/xpU2F6fv9C7YM0VF
 a3Hb/+wdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE4gsjw4rwP3OWSQvXC4qV
 38qqd9RquDKj/eVhNo6onCmJJVO71zMyzI0te2gQqm3dH74xld1aVE1pzS+r+h87GQT9HObxmPS
 yAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I've been massaging exec quite a bit to move a bunch of stuff around
and get rid of a lot of sleeping work out of that path or at least move
it out from precious locks that are used for access checks.

This is another round I plan to upstream. The gist is that we're relying
on exec_update_lock in a bunch more places now and we've been
willy-nilly moving stuff beneath that lock for a while. That's not
sustainable. We need to clean that up and really only do the absolute
minimum of work under that lock to avoid stalling tasks indefinitely
just because stalls an exec. It's also just good hygiene because it's
getting really hard to understand what that lock really protects.

I've spent some time playing with various patches. Some of them went out
independently. This is another core chunk:

* proc_ns_readlink() copies the link to userspace with the lock held.

* kcmp(KCMP_EPOLL_TFD) copies the epoll slot from userspace with the
  lock of both tasks held and then waits for the epoll mutex which
  epoll_wait() holds across a page fault.

* perf_read() and perf_ioctl() copy to and from userspace with the mutex
  of the perf context held. perf_event_exec() takes that mutex with
  exec_update_lock held.

* SELinux ignores a failing replace_fd() when it revokes inherited files
  during exec.

* A vfork() parent is woken up in exec_mmap() but a child that shares
  its signal table with the parent only gets a private one after that.

* SELinux and AppArmor revalidate the inherited files from the
  bprm_committing_creds hook, i.e., with the lock held.

* Move the time namespace switch out of the lock. It doesn't need it.

* Drop the lock right after the new credentials are committed instead of
  in setup_new_exec().

* Don't take the mmap lock of the old mm in exec_mmap().

* Look up the vma for a link in /proc/<pid>/map_files without
  exec_update_lock held.

While at it, don't take the mmap lock in exit_mm() either. It's the same
leftover. A vfork() child that exits without having exec'ed waits on the
mmap lock of the parent it has just woken up.

* A vfork() parent is woken up before the child has left the mm, in exec
  as well as in exit.

What's left under the lock that can block is the hardware breakpoint
flush in flush_thread(), perf_event_exec(), perf_event_exit_task(), the
allocation in set_cred_ucounts() and a sleepable bpf lsm program on the
bprm_committing_creds hook.

The perf ones still take the mutex of the perf context but perf_read()
and perf_ioctl() don't sleep in a page fault with it held anymore.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (19):
      proc: copy namespace link after dropping exec_update_lock
      kcmp: look up epoll target without exec_update_lock held
      perf: copy counter values after dropping ctx->mutex
      perf: copy ioctl arguments without ctx->mutex held
      selinux: close inherited files that can't be replaced
      exec: move unshare_sighand() before exec_mmap()
      selftests/exec: test exec with a task sleeping in a page fault
      selftests/exec: test exec with a shared signal table
      lsm: add security_bprm_revalidate_files()
      bpf: mark bprm_revalidate_files as sleepable
      selinux: revalidate inherited files before taking exec_update_lock
      apparmor: revalidate inherited files before taking exec_update_lock
      exec: drop exec_update_lock after the credentials are committed
      exec: switch time namespace after dropping exec_update_lock
      exec: don't take the mmap lock of the old mm
      exit: don't take the mmap lock in exit_mm()
      proc: look up map_files vma without exec_update_lock held
      vfork: wake up the parent once the child has left the mm
      selftests/exec: test when a vfork() parent is woken up

 fs/exec.c                                        |  81 ++--
 fs/proc/base.c                                   |  68 ++-
 fs/proc/namespaces.c                             |   7 +-
 include/linux/lsm_hook_defs.h                    |   1 +
 include/linux/sched/mm.h                         |   4 +-
 include/linux/security.h                         |   5 +
 kernel/bpf/bpf_lsm.c                             |   1 +
 kernel/events/core.c                             | 138 +++---
 kernel/exit.c                                    |  10 +-
 kernel/fork.c                                    |  24 +-
 kernel/kcmp.c                                    |  72 ++-
 security/apparmor/lsm.c                          |  23 +-
 security/security.c                              |  27 +-
 security/selinux/hooks.c                         |  22 +-
 tools/testing/selftests/exec/.gitignore          |   3 +
 tools/testing/selftests/exec/Makefile            |   6 +
 tools/testing/selftests/exec/config              |   3 +
 tools/testing/selftests/exec/unshare-sighand.c   | 236 ++++++++++
 tools/testing/selftests/exec/update-lock-fault.c | 547 +++++++++++++++++++++++
 tools/testing/selftests/exec/vfork-mm.c          | 363 +++++++++++++++
 20 files changed, 1480 insertions(+), 161 deletions(-)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261120-work-exec-update_lock-7f4bec04bd81

