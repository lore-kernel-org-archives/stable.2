Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365106;
	b=2pjl+8lEkE/kPhH9NonaqePpYVEByA03YvhJQPfImnQUGR2VMMCuVzAuVc2kQHSAr0I0
	 4MLxpHfeqSN7BoNp6nYkgRS64sOYwxdGbRTIqqswD7xJXGN+xdFsKCBse1OuKIkzr6hg3
	 dNU0VLmIs/H07HFwmZweFtkYYqld9D/DhcIScTfgDyPXhbq/8ohExYgn0zFghvdiyEQ3v
	 X7Nnv+qbbujcVeL94zQ1kCvy/QKvmZtZK5vYsQVu6ucfHjKf6Eu0LZwUt2GMURjQ7i9RI
	 aUI/KlW9hphNC9878bHKL1RMZ9YnqQte6epuor5dAhAmhMZGzCpDADT8AJW/jsyeIoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CIHHU4Bt0EiczXxC6qtbV4rA/BwD14G6dlaJUYVc8iU=;
	b=ke5gKrjx0j7bKfLqZOS+mnF2v/9EsGf8M+jQ+qRmx+h6GoWs88AWsm7cgGxt5PAr3xDx
	 jxJ/K/nJMuHsQ8kr3evaGNMkPrgnLeYLclzdCcLcrH4RyfOnj9vfDAEq903lDWfr3wZlx
	 X7oKM3JKRa/IJjAmxhTK1KlIUkQFBroPa6YWTrZX+xfqSTWkwpAaQ0kZwCfT06RYA61xI
	 lQ9AMhoXbZR5rnyP58EGMuM+vaIEB+OhbG8N3SIDajtPUQkPWBE74kG6csr7zfY80LsNG
	 P6uB7txPN4BlMTabZII+wPwn2wSu+G4ncA+iHJGd4thkuT0VcNNeF46RouXeUh6x4Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KnyCLNYm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5960A2605;
	Fri, 30 Oct 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KnyCLNYm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E30B1F0093A;
	Fri, 30 Oct 2026 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365106;
	bh=CIHHU4Bt0EiczXxC6qtbV4rA/BwD14G6dlaJUYVc8iU=;
	h=From:To:Cc:Subject:Date;
	b=KnyCLNYmJWswrEvKTS2RSLLKZ+tqcZFZT45HAE50Hf+fQYk6r810iCM7R9mcNxDty
	 kLwjoSNr7vNImvb+s7EDMNsV1PvN76bp2N9GCDKo0g6oT8XV/9Sru1jP0mgOLpZzWT
	 fzQMmy7fXgGUK1fEIp2bW93CyANgQ4JfQx9/bseE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.3.1
Date: Fri, 30 Oct 2026 13:58:09 +0100
Message-ID: <2026103010-blurt-passable-31f8@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 7.3.1 kernel.

All users of the 7.3 kernel series must upgrade.

The updated 7.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                |    2 
 crypto/asymmetric_keys/restrict.c                                       |    8 
 fs/coredump.c                                                           |   18 -
 include/linux/io_uring_types.h                                          |    2 
 include/linux/key-type.h                                                |    1 
 include/linux/key.h                                                     |    5 
 include/linux/sched.h                                                   |    2 
 include/linux/sched/signal.h                                            |   27 +
 io_uring/io-wq.c                                                        |    2 
 io_uring/io_uring.c                                                     |   42 ++
 io_uring/net.c                                                          |    2 
 io_uring/poll.c                                                         |   17 -
 io_uring/wait.c                                                         |   16 -
 io_uring/waitid.c                                                       |    7 
 kernel/exit.c                                                           |    5 
 kernel/fork.c                                                           |    9 
 kernel/irq/proc.c                                                       |   24 +
 kernel/pid_namespace.c                                                  |    3 
 kernel/ptrace.c                                                         |    6 
 kernel/signal.c                                                         |    4 
 kernel/trace/ftrace.c                                                   |    4 
 kernel/trace/trace.c                                                    |   21 +
 kernel/trace/trace_events_filter.c                                      |    6 
 kernel/trace/trace_events_hist.c                                        |   36 +-
 kernel/trace/trace_events_synth.c                                       |   10 
 kernel/trace/trace_synth.h                                              |    1 
 kernel/trace/trace_syscalls.c                                           |    2 
 mm/damon/core.c                                                         |   22 +
 net/bluetooth/l2cap_core.c                                              |    7 
 net/bluetooth/l2cap_sock.c                                              |    2 
 security/keys/key.c                                                     |   13 
 security/keys/keyctl.c                                                  |   15 
 security/keys/keyring.c                                                 |  152 +++++-----
 security/keys/process_keys.c                                            |    5 
 security/keys/trusted-keys/trusted_tpm1.c                               |    4 
 security/keys/trusted-keys/trusted_tpm2.c                               |    2 
 tools/dma/Makefile                                                      |    4 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc |   24 +
 38 files changed, 373 insertions(+), 159 deletions(-)

Aaron Ahmed (1):
      ftrace: Initialize modname and offset in print_rec()

Adrian Martinez (1):
      KEYS: Fix key_reject_and_link() race with keyring restriction

Austin Schuh (1):
      io_uring/wait: wake real-time waiters from hard interrupt context

Cen Zhang (4):
      keys: Avoid the owner account dereference in named keyring lookup
      keys: Check the authorization payload in process keyring searches
      keys: Protect the type name while describing a key
      keys: Protect the read method check against type removal

Christian Brauner (10):
      coredump: hold RCU while releasing parked threads
      signal: don't retarget shared signals in a dying thread group
      signal: only SIGKILL and the freezers interrupt a coredumping task
      io-wq: order the exit bit against worker creation task work
      ptrace: refuse to change the signal mask of a user worker
      fork: release the files of a failed fork after sched_cancel_fork()
      exit: hang up the tty before closing the files
      signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
      coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
      pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper

David Carlier (2):
      tracing: Hold trace_types_lock when updating modules in persistent instances
      tracing: Hold trace_types_lock when resetting last boot data from readers

Donggeun Yoo (4):
      tracing: Save the event file instead of the compatible histogram
      tracing: Unregister field variable histograms when the command fails
      tracing: Add the bucket size to expr_field_str()
      tracing: Fix 64-bit and signed histogram fields on 32-bit kernels

Greg Kroah-Hartman (1):
      Linux 7.3.1

Haoran Wang (1):
      tracing/syscalls: Use copy_from_user for the faultable syscall buffer

Haris Okanovic (1):
      genirq/proc: Fix missing CPU header in /proc/interrupts

Jens Axboe (2):
      io_uring: end the drain when the drain request completes
      io_uring/poll: don't loop on HUP with multiple references

Juanlu Herrero (1):
      io_uring/poll: avoid retry wakeup loss when dropping ownership

Junyeong Lee (1):
      io_uring/waitid: prevent cancel reference wrap

Kyle Zeng (2):
      tracing: Reject incomplete event filter expressions
      keys: make keyring indexes independent of kernel addresses

Lee Jones (1):
      tracing/histograms: Verify event_call identity when updating synth_event refcount

Pauli Virtanen (1):
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

SJ Park (1):
      mm/damon/core: error damos_commit_quota_goal() for zero target_value

Sasha Levin (1):
      tools/dma: fix building with O=

Srish Srinivasan (1):
      keys/trusted_keys: return immediately after TPM unseal failure

Stefano Garzarella (1):
      KEYS: trusted: Fix blob allocation size in tpm2_key_decode()

Tamaki Yanagawa (1):
      io_uring/net: keep recv buffer select length within MAX_RW_COUNT

Weiming Shi (1):
      asymmetric_keys: reject trust keys without IDs

