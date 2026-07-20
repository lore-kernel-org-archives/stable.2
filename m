Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D220437473
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562937; cv=none; b=KYrUTAMLhzVzFlgKhtCPtGWzclhgDH2QR/AMKt0+gxB3BsGOmd8BK3+rz2mXVR7R6IOc0wx5FLA35X9ZnBCKOSNVrCVpvT4acCc2jPbpf/NdpuikqM+abatVnOc+3XkxO3Z3Cz0YNxMEbGyh7lGJL6l90yuIwIY0ZRtxoApVsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562937; c=relaxed/simple;
	bh=Nj5X/hP8BztMEjdhKMfvaGHQf5So6VjPs93omEFHdzA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tGZMC7Tuy9kAXA34OhLRDkBeqXIuVdjuPzORh6fDXOCxeQebFtyPjj1PdSfhSgtQMy+/doh9/rhQKwVPnnGEDJ2dW5d43LFoxK2ytZc3YFebLgKuVWD1N262i9nailkKYA+K9SYNn20GMBeG3NcP/aGAeIyFEn8j7YAiP6qXt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdxHlBFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdxHlBFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BD51F00A3A;
	Mon, 20 Jul 2026 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562935;
	bh=BC+16OsON6A8NT0ulecST8jidhX0LE94oDM4EOTF+Z0=;
	h=Subject:To:Cc:From:Date;
	b=vdxHlBFqFmwSdFeaIo6a37VBqgJ9G2Cs2uAZlSyCilWs/DTIm/6dXFX9jT5W2WxJh
	 1WrBej4pS9g9i3nhQXYv4vaTkD6ZQqWBImqLYngTaE9HtRdZ2ddCLSKeEzm35xw59u
	 K6TKXFhxYND4tfk1O8pCmd2zB4+MacLedWdtJiZY=
Subject: FAILED: patch "[PATCH] posix-cpu-timers: Use u64 multiplication in" failed to apply to 5.10-stable tree
To: zhanxusheng1024@gmail.com,tglx@kernel.org,zhanxusheng@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:49:10 +0200
Message-ID: <2026072009-plural-agonizing-5276@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 26aff38fefb1d6cd87e22525f41cc8f1aa61b24f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072009-plural-agonizing-5276@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26aff38fefb1d6cd87e22525f41cc8f1aa61b24f Mon Sep 17 00:00:00 2001
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
Date: Tue, 16 Jun 2026 19:20:17 +0800
Subject: [PATCH] posix-cpu-timers: Use u64 multiplication in
 update_rlimit_cpu()

update_rlimit_cpu() converts the RLIMIT_CPU value to nanoseconds with

        u64 nsecs = rlim_new * NSEC_PER_SEC;

On 32-bit kernels both rlim_new (unsigned long) and NSEC_PER_SEC
(1000000000L) are 32-bit, so the multiplication is performed in unsigned
long and truncated for rlim_new > 4 seconds before being widened to u64.

The same file already casts to u64 for the matching computation in
check_process_timers():

        u64 softns = (u64)soft * NSEC_PER_SEC;

As a result, the truncated value is installed into the CPUCLOCK_PROF
expiry cache (nextevt), causing the process CPU timer to be programmed
to fire prematurely for any RLIMIT_CPU soft limit >= 5 seconds. The
actual SIGXCPU/SIGKILL decision in check_process_timers() already casts
to u64 and is therefore correct, so limit enforcement is not broken;
only the expiry-cache programming is wrong. Apply the same cast here so
both paths convert rlim_cur identically.

64-bit kernels are unaffected.

Fixes: 858cf3a8c599 ("timers/itimer: Convert internal cputime_t units to nsec")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616112017.1681372-1-zhanxusheng@xiaomi.com

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 74775b94d11b..5e633d8750d1 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -41,7 +41,7 @@ void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
  */
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 {
-	u64 nsecs = rlim_new * NSEC_PER_SEC;
+	u64 nsecs = (u64)rlim_new * NSEC_PER_SEC;
 	unsigned long irq_fl;
 
 	if (!lock_task_sighand(task, &irq_fl))

