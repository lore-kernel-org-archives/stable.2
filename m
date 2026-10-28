Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203026;
	b=gXjZId5IMlGYKtzECNzJLY/qEyf285J7EPchFKwkh1u1PTVyQ47gN9ow6FwIeRyStVuD
	 UP3OoWj22vSMbM+X5vncPthCUc3uaaNTrTISUKXqoejFq73vpUpAGtKVvuWz+Yrbd9lT4
	 57Z6rzWnPZz9mPe4uauNA0eCyIOXuE3FMeqd9X8ICPxerI7uu58YnTZU2+KkXNSb+NJ6i
	 HhgeCVQlYFSU6eXuF8x038FXcO9bpcll/M057J/f8CW8c6Rk+wjb8myHtC/qjQYBV+4sP
	 +ZXcm4cHN5ixfBDb9BVVPSVzM7exorbPdJfeXfPiG6Qntho7biOeMWXJCAZ88vkoGDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203026;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x9a8ukmPy3tDSnRrsB7rvoLZB+SIHcvYOMosd6h1qY8=;
	b=4QxG4lzE9f3MSfjeYJXHEoINwdM2gA27l56wBhsFJOcCrrcYVvp2mokin//UNwgh+CJk
	 h75/gC7Czul5UoKGaYQxMQ/3hoC+M2BJSJVY9NvNb1GaKWFjypAiRGEqgLgRQ1xABp8++
	 vaSwQqlX8MXzx+fukTi37XYf3hh6o9t5WZ1+hq0M6sIZ/RnfIHtA0pm1OX82Y4E+5o/K1
	 ZP8VC1PUdry56yKSO+t3KjIwJxg+QRSVrY3uu6XUfxDN8P0Wgnn1XuRDcmwFhKOmWd9Fk
	 K7VMKDPvP041+Cekh2mXcxj0Xm6srvt62kaEiJumx9giWe5WX602MWl7fBVD3znKRrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kiCRbpGT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC4606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kiCRbpGT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C22A1F01828;
	Wed, 28 Oct 2026 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793203025;
	bh=x9a8ukmPy3tDSnRrsB7rvoLZB+SIHcvYOMosd6h1qY8=;
	h=Subject:To:Cc:From:Date;
	b=kiCRbpGTwkNPDky+d/MeUKVl7ByIhVZRoXPIH7Yls9oLnEB5ZjNSx3KM7KdJvpH/l
	 eOwQPjaPD+7PXFjR9PFcdZe9M9J64VbvxSS/pxkxpoVEiEaDSFuBHBQbme+kIpM/kl
	 3YQc/z7IuNnMmKXotlxcuYsmILtkVWkIUNsuiJ/s=
Subject: FAILED: patch "[PATCH] pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting" failed to apply to 5.15-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 16:56:56 +0100
Message-ID: <2026102856-tightness-regroup-f464@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5c0985dd3c32fc2bbd0e8beaf13cf52cd97376a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102856-tightness-regroup-f464@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c0985dd3c32fc2bbd0e8beaf13cf52cd97376a2 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 14:08:20 +0200
Subject: [PATCH] pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting
 the reaper

Since commit 7fea700e04bd ("zap_pid_ns_processes: clear
TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING") zap_pid_ns_processes()
clears TIF_NOTIFY_SIGNAL before every kernel_wait4() call. Otherwise
kernel_wait4() doesn't sleep and returns -ERESTARTSYS if
signal_pending() is true and the reaper busy-waits.

But clearing TIF_NOTIFY_SIGNAL doesn't fix it. It can get raised again.
For example, klp_send_signals() sets it raw against any task that hasn't
transitioned yet. And it keeps sending it until the livepatch finishes.

The sleep loop waiting for pid_allocated to drop has the same problem
and it doesn't even clear anything. So a schedule() in
TASK_INTERRUPTIBLE returns immediately.

Use a no_notify_signal guard. signal_pending() will ignore
TIF_NOTIFY_SIGNAL and the pid namespace reaper sleeps until a child
exits or free_pid() wakes it.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-5-6609e42b3157@kernel.org
Fixes: 7fea700e04bd ("zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index d36afc58ee1d..8bc9edb40b78 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -238,9 +238,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
+	/* Task work must not busy-loop the reaper, see signal_pending(). */
+	guard(no_notify_signal)();
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 

