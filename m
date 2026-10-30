Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362357;
	b=lQdlDYmroBmlTk/B2PQrW0tujB68CcmdO1BXIeuRlYAgzGM1SLJCydc0MVFpYkLpATi3
	 NFzlrgTTQroQhCmKAjpG51QUSLbF5oFZ2aY6bf9EJfVlbpeK+Dh6j5AECQ+86mRe5CjE+
	 5wx75D4ohwEPBjTqtUpL/XkCo56AaDvkY15+XyUkYCcsLUClvIi70T11tb7kxKvnsp1bD
	 aQYpST3Yxx/OWBQ9SIFkLv4lpAGZo3sZ+KsTlrt0qugMfQVIzKxEvhVFkaH4hYeXyfwQ9
	 qWF6b5A7uJ3n6xYJayC2LUprFIFFRxqIJC0NFvFCJngnrpTU22sfSnfpK5t7T1nu9Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Znln4m26uKUa4MxYoPtuQawPYSx2GIaT+4l6IFn/UWI=;
	b=UG7dwrwr/MxgXZ0CZqo8Qti1X2WMbOkw3d1zNkGFEAcVAHcefvnsHcKsOaLCxgy6/Bzl
	 u+rfPDtrBFc/28XT0R6CcYSS+JE3VSQjpHgTNHWTp+LQMtXYnexkc1L+KKGI7yQ6K2cz+
	 0Ne2FZQb9D1OwkgjKcOeFvmeSGSAZEVzc4CerXlNT+llD56tDNCW+iM05Z+wjEDitfTEZ
	 edx7YB8hRoPQ/QqBmrn8DwL8twm/ldm6SniX1xjp7FMUXC+HWCfKroNJaB3wPZ/92xqZY
	 STPSGA6jZGZMA+NCMdwK+5zxtb4u3fWe778GwyAPEM8vSW5VcEI/n08VATma2AhhgBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yKwQB4k6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DE606A31A;
	Fri, 30 Oct 2026 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yKwQB4k6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9150A1F000C1;
	Fri, 30 Oct 2026 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793362357;
	bh=Znln4m26uKUa4MxYoPtuQawPYSx2GIaT+4l6IFn/UWI=;
	h=From:To:Cc:Subject:Date;
	b=yKwQB4k6YHOmdvtS97XilXSIr5yG4UjPpFGns6PTeIfrzeB7nitxT5qa1wG//ZwLd
	 Gt59cCHjJeWaoOWZtKo3xuGOpaL2W2XN2nv4csaNmPNAPl7qFPqfZyl3vKfwiwxS5Y
	 WmdZZe8H6Yl65o/+Hrq1Age8rQ5vJZlo+lIruSNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.14
Date: Fri, 30 Oct 2026 13:12:32 +0100
Message-ID: <2026103032-conclude-illusion-3814@gregkh>
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

I'm announcing the release of the 7.2.14 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                |    2 
 crypto/asymmetric_keys/restrict.c                                       |    8 
 fs/coredump.c                                                           |   18 -
 fs/ntfs/file.c                                                          |   32 -
 include/linux/io_uring_types.h                                          |    5 
 include/linux/key-type.h                                                |    1 
 include/linux/key.h                                                     |    5 
 include/linux/sched.h                                                   |    2 
 include/linux/sched/signal.h                                            |   27 +
 io_uring/cancel.c                                                       |   43 ++
 io_uring/cancel.h                                                       |    2 
 io_uring/fdinfo.c                                                       |   14 
 io_uring/futex.c                                                        |   32 +
 io_uring/io-wq.c                                                        |  126 ++++++-
 io_uring/io_uring.c                                                     |  180 +++++++---
 io_uring/io_uring.h                                                     |   44 ++
 io_uring/kbuf.c                                                         |    2 
 io_uring/loop.c                                                         |    8 
 io_uring/mpscq.h                                                        |   14 
 io_uring/napi.c                                                         |    4 
 io_uring/net.c                                                          |   26 +
 io_uring/openclose.c                                                    |   11 
 io_uring/poll.c                                                         |   38 +-
 io_uring/register.c                                                     |   54 ++-
 io_uring/rw.c                                                           |   18 -
 io_uring/sqpoll.c                                                       |    7 
 io_uring/timeout.c                                                      |  102 ++++-
 io_uring/tw.c                                                           |   36 +-
 io_uring/uring_cmd.c                                                    |    2 
 io_uring/wait.c                                                         |   48 ++
 io_uring/wait.h                                                         |   15 
 io_uring/waitid.c                                                       |   19 -
 io_uring/zcrx.c                                                         |    2 
 kernel/exit.c                                                           |    5 
 kernel/fork.c                                                           |    9 
 kernel/pid_namespace.c                                                  |    3 
 kernel/ptrace.c                                                         |    6 
 kernel/sched/ext/ext.c                                                  |   14 
 kernel/sched/fair.c                                                     |   16 
 kernel/signal.c                                                         |    4 
 kernel/trace/ftrace.c                                                   |    4 
 kernel/trace/trace.c                                                    |   21 +
 kernel/trace/trace_events_filter.c                                      |    6 
 kernel/trace/trace_events_hist.c                                        |   33 -
 kernel/trace/trace_events_synth.c                                       |   10 
 kernel/trace/trace_synth.h                                              |    1 
 kernel/trace/trace_syscalls.c                                           |    2 
 mm/damon/core.c                                                         |   22 -
 mm/damon/sysfs.c                                                        |   19 +
 net/bluetooth/l2cap_core.c                                              |    7 
 net/bluetooth/l2cap_sock.c                                              |    2 
 security/keys/key.c                                                     |   13 
 security/keys/keyctl.c                                                  |   15 
 security/keys/keyring.c                                                 |  152 ++++----
 security/keys/process_keys.c                                            |    5 
 security/keys/trusted-keys/trusted_tpm1.c                               |    4 
 security/keys/trusted-keys/trusted_tpm2.c                               |    2 
 tools/dma/Makefile                                                      |    4 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc |   24 +
 59 files changed, 1036 insertions(+), 314 deletions(-)

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
      io-wq: order the exit bit against worker creation task work
      coredump: hold RCU while releasing parked threads
      signal: don't retarget shared signals in a dying thread group
      signal: only SIGKILL and the freezers interrupt a coredumping task
      ptrace: refuse to change the signal mask of a user worker
      fork: release the files of a failed fork after sched_cancel_fork()
      exit: hang up the tty before closing the files
      signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
      coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
      pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper

David Carlier (2):
      tracing: Hold trace_types_lock when updating modules in persistent instances
      tracing: Hold trace_types_lock when resetting last boot data from readers

Donggeun Yoo (3):
      tracing: Save the event file instead of the compatible histogram
      tracing: Unregister field variable histograms when the command fails
      tracing: Fix 64-bit and signed histogram fields on 32-bit kernels

Greg Kroah-Hartman (1):
      Linux 7.2.14

Haoran Wang (1):
      tracing/syscalls: Use copy_from_user for the faultable syscall buffer

Hongling Zeng (2):
      ntfs: fix race between fallocate and mmap reads
      ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()

Hui Su (1):
      sched/fair: Avoid overflow in place_entity()

Jens Axboe (6):
      io_uring/timeout: don't put a sequence target behind the last flush
      io_uring/timeout: don't flush with the sequence behind the last flush
      io_uring/timeout: don't lose a cancel as io-wq arms a timeout
      io_uring/poll: don't loop on HUP with multiple references
      io_uring: end the drain when the drain request completes
      io_uring: keep the drain active when a deferred drain request is started

Josef Bacik (43):
      io_uring/waitid: own the request before clearing ->head
      io_uring/cmd: don't leave list poison in ->hash_node
      io_uring/wait: don't spin on a stuck overflow list
      io_uring/io-wq: don't lose the signal that ends work
      io_uring/io-wq: don't hide a link from cancellations
      io_uring: don't flood a cancelling task with task_work
      io_uring: don't lose the DEFER_TASKRUN wake up
      io_uring/cancel: rearm local work wake up before sleep
      io_uring/mpscq: disable preemption while pushing
      io_uring/io-wq: don't go to sleep on pending work
      io_uring/io-wq: don't strand work when a worker exits
      io_uring/io-wq: don't exit with a creation pending
      io_uring/io-wq: let cancel find picked up hashed work
      io_uring/poll: don't lose a cancel as io-wq arms poll
      io_uring: don't lose a cancel as io-wq parks a request
      io_uring/cancel: don't forget that the work was running
      io_uring/cancel: recognize "no timeout" on 32-bit
      io_uring/cancel: let CANCEL_ALL find parked requests
      io_uring: wake ring pollers for local task_work
      io_uring/wait: look at all CQ waiters on wake up
      io_uring/poll: drop stale double poll entry on rearm
      io_uring/futex: allocate private hash before waiting
      io_uring: drop the CQE cache if a refill fails
      io_uring: don't split 128b SQEs at the SQPOLL cap
      io_uring/register: don't wrap 32b CQEs when resizing
      io_uring/register: handle index wrap when resizing
      io_uring/register: keep 128b SQEs intact on resize
      io_uring/fdinfo: fix CQE dump of CQE32 rings
      io_uring/timeout: don't skip over reached sequences
      io_uring/timeout: keep repeat count on multishot update
      io_uring/timeout: use the right clock for ABS updates
      io_uring/wait: no early -ETIME if min_wait finds work
      io_uring/napi: make stale entries time out after 60s
      io_uring/napi: don't busy poll past an expired timeout
      io_uring/zcrx: fix buffer offsets in areas above 4GB
      io_uring/kbuf: handle index wrap in last buffer check
      io_uring/sqpoll: let the thread sleep on disabled rings
      io_uring/openclose: keep the lock in io_pipe_fixed()
      io_uring: don't pass restart error codes to userspace
      io_uring/net: don't retry recv on uncommitted buffers
      io_uring/timeout: no ABS update of multishot timeouts
      io_uring/timeout: don't end a linked timeout with 1
      io_uring: look up the file before queueing to io-wq

Juanlu Herrero (1):
      io_uring/poll: avoid retry wakeup loss when dropping ownership

Junyeong Lee (1):
      io_uring/waitid: prevent cancel reference wrap

Kuba Piecuch (1):
      sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs

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

