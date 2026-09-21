Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB74A1DF9;
	Mon, 21 Sep 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998308; cv=none; b=VLUQEoDVq8AcZ4BiZhWIyqjOsFxvmGPDgVIWDwpRGDgfM9DlCRo/gclYRxz27CgL8Cqx+3JeGUgvmSr4JKqgLCo8hn9AlfeBTc9rJLZ5XSa15EyXl42kymc91WCezZf4p1HCNain8B1UllbHsPP6Ur5TqDes1BxkvuS49maXKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998308; c=relaxed/simple;
	bh=5cmOqATVUXTDQgM82raywtxRqKGg+wRZ/gH8Sbkxogk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pV7Jn7fOBYeai6JZa2HGJVqo5SCJcwFUZrX6A9ustiS+MIRhIc24yXcsJXjPXgVbH8isnRaoZU3O0rkT7b/awY5NrRl1WCFLGul/mvOS7Wy7+Ap/za5LOLSIyQe8kR2QwwTbQcU5XeBDkcelkBcecnwLtWxgo3l191ieXdNEa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTElbC33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTElbC33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05531F000FF;
	Mon, 21 Sep 2026 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998307;
	bh=e4AZu4AlntNt1aYig0/jFDygUFvaCLDRa7pO2XcQvUU=;
	h=From:Subject:Date:To:Cc;
	b=CTElbC33WCvK21eYsu1cvCUz+/OAaKUyDjGunBjoj3Dcxwg2gIpLoNBEYjRs5e1T9
	 1IIWTK1qe4enooe2DuMaHz8FVVp5y9mOT9febxd9ltEsejyb+9XV+Fu8oA4wFtpAT1
	 Muk5iJN0JjbzbdQC81KDOtVfLAAuYylKYAV07yerti0WXWcszEKbFdkztbdQstg86M
	 TVbdoVXwAtkINnL4RohkYYVqQIHk9FGD2t4pJG2uTSw040ORzznD3C04jHQjDGCcKC
	 T3cMPMvi1ImTtpFtM3ZRmZqslphJuY815B2ZFNNxWFNAectS+lRL2d0G0F4Lb7H6Tb
	 SXcktS3b+k98A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 00/17] coredump & signals: an impossible affair
Date: Mon, 21 Sep 2026 15:44:49 +0200
Message-Id: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf4V0bUnLw1ZX/odxUcoUKkrJFFBD+
 HcpxkQT4/LOnHtyJ+IBLXiyjyaCMFpvXbuEdBMRXau2AmrLJZOEJVu24zm9OWyodgjlcO2osXf
 wFEqzk1oyA0KSpdkhrI+leDy9sh+KM+g+qAJRKA+0QNXqOpyCNH5L47UbBySgtfW9w8e6cORB+
 X/MyCmjJs0zrTIuJNOHBrCFS+ywImHNmHxKxG9JskqEFEaXiuX8SzLP8xN/7AjmOQEAAA==
X-Change-ID: 20260915-work-coredump-fixes-edf98c80fe78
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3905; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5cmOqATVUXTDQgM82raywtxRqKGg+wRZ/gH8Sbkxogk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLlTxbd8XWa+Kc+KiT/E91pz+7J8Ov7qyvJXT+94z
 khOaavV7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/2eMDP+PuL2Sl6qrm/zZ
 2OzjVDbmL7/t903i+vJDpf3FncWnLi5iZPjJ3my/wPRveUdkuFHrju/LnFutHVxcCxeamzPGf18
 +kREA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

I asked Chris to look at the coredump code with kres and it found a few
bugs. I started looking as well and found a few more. Here's a fixes
series. I also used TLA+ modeling for this.

Fixes in here:

- UAF in coredump_finish(): a parked thread can be freed before it is
  woken
- only SIGKILL and the freezers interrupt a dump now, cgroup v2 included
- core_pattern is parsed from a snapshot instead of racing the sysctl
- the io-wq exit bit wasn't ordered against worker creation task work,
  exit could hang on worker_done
- shared signals are no longer retargeted to the dumper, that truncated
  cores
- a failed fork released its files under scx_fork_rwsem, deadlock
- a session leader's exit lost the SIGHUP for the foreground job
- an io-wq worker of an SQPOLL ring as the dumper deadlocks the group,
  user workers never dump now
- PTRACE_SETSIGMASK can't unmask a user worker anymore, the only way in
- exec cancels io_uring before de_thread(), nothing adds a thread after
  it
- no io threads from PF_SIGNALED or PF_POSTCOREDUMP creators, they
  broke threads_remaining
- descriptor tables are closed highest fd first again, the order the
  deferred puts had

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v3:
- Address Oleg's reviews.
- Add a couple more fixes.
- Link to v2: https://patch.msgid.link/20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org

Changes in v2:
- Add fixes for retarget_shared_signal().
- Expand fixes for signal_pending().
- Link to v1: https://patch.msgid.link/20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org

---
Christian Brauner (18):
      Merge patch series "files: make closing files synchronous for close_range(), exec, exit"
      coredump: hold RCU while releasing parked threads
      signal: only SIGKILL and the freezers interrupt a coredumping task
      coredump: parse a snapshot of core_pattern
      io-wq: order the exit bit against worker creation task work
      signal: don't retarget shared signals in a dying thread group
      selftests/coredump: test shared signal retargeting during a dump
      fork: release the files of a failed fork after sched_cancel_fork()
      exit: hang up the tty before closing the files
      ptrace: refuse to change the signal mask of a user worker
      selftests/coredump: test a user worker as the coredumping thread
      selftests/coredump: expect PTRACE_SETSIGMASK to be refused on a user worker
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set
      fork: use SIG_KERNEL_ONLY_MASK for the user worker signal mask
      signal: enforce the user worker signal mask in __set_task_blocked()
      fs: close files from the highest descriptor down

 fs/coredump.c                                      |  73 ++--
 fs/exec.c                                          |  11 +-
 fs/file.c                                          |  55 +--
 include/linux/sched/signal.h                       |  19 +-
 io_uring/io-wq.c                                   |   2 +
 kernel/exit.c                                      |   5 +-
 kernel/fork.c                                      |  20 +-
 kernel/ptrace.c                                    |   6 +
 kernel/signal.c                                    |  22 +
 tools/testing/selftests/coredump/.gitignore        |   2 +
 tools/testing/selftests/coredump/Makefile          |   6 +-
 .../selftests/coredump/coredump_signal_test.c      | 238 +++++++++++
 .../selftests/coredump/coredump_worker_test.c      | 447 +++++++++++++++++++++
 13 files changed, 832 insertions(+), 74 deletions(-)
---
base-commit: dadceac9d20a1c90269aafd7746f7c0c05879ad3
change-id: 20260915-work-coredump-fixes-edf98c80fe78

