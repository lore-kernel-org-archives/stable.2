Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047194;
	b=eAT2O02z5r+0vKnr79TAjIf4KP6aq+wAQ5Rkh1lZ9Dg4Wx5bFegOvQIMxcaLJ1qWpY/r
	 z6r5hGQX79vh08/FJHFnT8t+XdAzslGFOqEvAeT1LW2yR9STsULclG+Lob1UwKWpsnURI
	 nNR6pX9CBN5cyiPM1WYOGzjveteR5WCFD7h3pDbnHTFR3VJXF+pXWYCn4RyWPIelJ2TYQ
	 o07WSp4ttAVQb5RalOjSDG7jpjF9MBzyV39gv7dyfUA9byFeWk4xqgAFVHoBDuEfDTkyi
	 53MQEaCjkfN7I2QfaUFbSCGH7JfKxD5CddyHYUvkmesZgfIvVjr/nXJQsh2w+MODS6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V5tg9MzqNU5PWdXPQpSOKzKY94RAXQ3ycFwRdwlyJ3Q=;
	b=zMOGxe0AD+pY5nf4wvMDIlCd9Sch2teKMMKS33Y1eYHw3jbxB5XY0IoFNAFVaIhHlN2X
	 cLxDDCv5aPRdJn01/fWqa9r8rGuyeMU5n97RxBCPVEH2UmlUawH9DHCRWAxiyMwMB2dAb
	 Y+IhJKwQ4eBn5nbNuDfKVy8zJh+TqfYGw/I2sU9BMN7SX1Brtc7uFWI6jQv/oBrm20S8k
	 JXfPsmgmNQdl9Pv6KFp+cc7ffxqpSuSMwDLNrbZU7obszLZpMUJGSU8mAsemjDEvcfn6o
	 npkmkL+HyjAs9rOHDvR6CiayX/mDPVoNScEV5mPzBRHyE7MBW9ZWGKmq/jLhXE+8iOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m92ziUD6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m92ziUD6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027041F0089F;
	Sat,  7 Nov 2026 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047193;
	bh=V5tg9MzqNU5PWdXPQpSOKzKY94RAXQ3ycFwRdwlyJ3Q=;
	h=From:To:Cc:Subject:Date;
	b=m92ziUD6sdw9E9AcHVHO5rEJzVZmBdwyZxf2BUxc5cP27mCWgP0vMhR09Wl7sNFr5
	 6JPDwls9lxRWiHBV83NsUA0saN0sWpXuEm6qHLG+xI4LiCoH0xUtqmUjw0pDI5dHyK
	 lvJ2rq/TO+zjXNk99uDgb3x841ZJac9zJQkG/93NrdcAqPuG4VK9bJqGmNxJSI9Bl/
	 V9RYdljLAkSUJTUqdRD6cX6C9BmWMzVC0uwGMKsWhcwvbRARJwaAsBGQqniE8F2K0h
	 KfnY7STouNULFYaoZo6mdGm3uGypy60Dcy/h+CAjTM6pzXHU6owrhlgU2lOBH9Dj+V
	 Gxwp9LA9HL5mg==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] posix-timers: Accept NULL clock_getres() output in stubs" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:31 -0500
Message-ID: <20261107052631-failed-6.12-5b819071e434@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5b819071e4346256c4edbae5cc2095dff25694fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052631-failed-6.12-5b819071e434@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5b819071e4346256c4edbae5cc2095dff25694fc Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 20 Oct 2026 16:11:21 +0000
Subject: [PATCH] posix-timers: Accept NULL clock_getres() output in stubs

With CONFIG_POSIX_TIMERS disabled, clock_getres() returns -EFAULT for a
supported clock when the result pointer is NULL. POSIX permits a NULL
result pointer to suppress returning the clock resolution.

Only copy the result when a destination is provided, in both the native
and time32 stubs. This matches the full POSIX timer implementation and
preserves clock ID validation.

Fixes: baa73d9e478f ("posix-timers: Make them configurable")
Fixes: d822cdcce43f ("posix-timers: Move compat versions of clock_gettime/settime/getres")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020161121.85042-1-dennylin0707@gmail.com
---
 kernel/time/posix-stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 9b6fcb8d85e78..5a27335a917ec 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -83,7 +83,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_time
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_timespec64(&rtn_tp, tp))
+		if (tp && put_timespec64(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -166,7 +166,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_old_timespec32(&rtn_tp, tp))
+		if (tp && put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
-- 
2.53.0




