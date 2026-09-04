Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3A415F06
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500293; cv=none; b=WOnsY9owW/+Wb77q+ebQZciDJt4eA1uRmGUmfYm2Spnv1PvUGFebDr8x2fVR/G6+bu4C2V0LiRd1j6L0lM9t9HzDUxgzgdNYilCJd7ScKXkcvmIdUNk8Tjmq0lSCY6lWq02JihkwEAQBKpguL5a/gy07Alv8MFZKFfVeibBtdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500293; c=relaxed/simple;
	bh=pTslszR2NkuB0ijzL3zAFamcLslPXJ7w5tHrv11MbG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RniBYhVK7OVJkwlWaXK1xENy1NcTAsD72mABGxhlO1Y8cpDlgebCm3JCr8WFseo4WgHodQUBnS/3jUwCZeHAW5F9mKM1ppLP8n1FMn9eAMVDNlz9M4hgHTONpIQmsHAroBDn4D7nbTChXGOL6T9jUCX3krhNhKsEDlmnpo6X4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRxxtTgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRxxtTgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9131F00A3D;
	Fri,  4 Sep 2026 05:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788500292;
	bh=oYIUxiWwZj4/oxb9ObaCohFSr+33OhRaCmI7cAdjN30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GRxxtTguWoldRoi/0p341pMQ4PI+3dmu76FJ41hM8FUdOzWa/wqkd4JykKOTnO/BA
	 08zWbqQU600vO4TRA8IOFpYy832bkEpb+7kafJzY/xe0NJiOcjsNiQXowRU/FPchj5
	 bDJ2Smr5BrDkCir5YuQhMfGuFsBa6i0hz/kDeuqKm1puTy1CL6wH4RCiTxJkIbIlVs
	 aW81r0v6X0xNxrHjJuf/l+RdoFfvLMNX6LbmMPDRozdcc3A9xhuYUuI4Brtty+LS/r
	 5CAe5T3A2JxOGXCESEIq7rCpYeHxAQaITuzbN2we76lGr3dbVRA44k/8Scya+Q0wFg
	 rZWXZgatUveuA==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, ruanjinjie@huawei.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y] entry: Fix seccomp bypass after ptrace with TSYNC
In-Reply-To: <2026090331-easeful-blazing-ce5c@gregkh>
References: <2026090331-easeful-blazing-ce5c@gregkh>
Date: Fri, 04 Sep 2026 07:38:09 +0200
Message-ID: <87cxuta85a.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 4a3591287fb7f808e209b4974ed337f609a2006b upstream.

Sashiko review pointed out the following issue.

If a thread is stopped in syscall_trace_enter() for ptrace, another
thread can install a seccomp filter with SECCOMP_FILTER_FLAG_TSYNC
(e.g., via seccomp_attach_filter()). This will successfully set
SYSCALL_WORK_SECCOMP on the stopped thread, but syscall_trace_enter()
evaluates a cached 'work' variable sampled on entry. Consequently,
the subsequent check for SYSCALL_WORK_SECCOMP misses the newly
assigned flag, and the filter is silently bypassed.

This race condition could allow an unprivileged process to execute
a prohibited system call (e.g., execve) that the newly installed filter
was intended to block, especially since the tracer might have modified
the system call number during the ptrace stop.

Fix this by re-reading the syscall_work flags after ptrace handling,
so that any new SYSCALL_WORK_SECCOMP flag set by another thread via
TSYNC during the ptrace stop is observed before the subsequent
seccomp check.

Fixes: 142781e108b1 ("entry: Provide generic syscall entry functionality")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260629132914.1135C1F000E9@smtp.kernel.org/
Link: https://patch.msgid.link/20260713025712.416366-1-ruanjinjie@huawei.com
---
 kernel/entry/common.c |    3 +++
 1 file changed, 3 insertions(+)
---
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -61,6 +61,9 @@ static long syscall_trace_enter(struct p
 		ret = arch_syscall_enter_tracehook(regs);
 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		work = READ_ONCE(current_thread_info()->syscall_work);
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
