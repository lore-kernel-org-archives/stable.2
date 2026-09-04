Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAE3EC6AE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500329; cv=none; b=kNKjIV1NwNARddEdwegqta72E0aSk0ah2zSpo8M+OIpbbZkz9GirTACDWlpm984w0W9dYHCqvfmzIFur9wdCusuWyArRts+EjbRywhoG5ZgZ0cJb/baiCYw9GI4a11Y65rkGP9qaE5UZuQHXRDaMsibQ5d3a0viiufXfoPSGICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500329; c=relaxed/simple;
	bh=JxYmCxlJJowzNmZPMfXJ7tH/eI9WB2OxTwVR65rzFTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1hFZ0qRFYLwUIilcmvqdBcJIK8cnWTkNwKq+t2qelDtUSe28fG7Z0OXPtzoEtG1eBDv6zg24NaMuY8X8oeBC5ZxgditTFi+iTEdExqQp0gjjAfX0/HNxFtxvRIel4FiOtUR0xTpsvRFBHMkfTPuFuIXhTjoerPz6rnNDic+kjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoMOFePp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoMOFePp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A501F00A3E;
	Fri,  4 Sep 2026 05:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788500327;
	bh=v0rvcMGmSTbkELKcYG/vBG/hpeH6RhyD3WN33WanTw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CoMOFePpf6zD92zHQQsKaUfY2/l0Gl8JogM434NL/aEpcRzE+vImOYaWay8gpoz2e
	 vtvLT/3DZsJPFgJY3EWiev2OjmkIjiAQNto2ikNYFlyMBxL8GIu+Mo3O+OzbdgwsVq
	 +UyU1iiPBLaQZTWL32ESGMQ1yLqo6/aR5HYSPuOIDqpO4eJBS3aAQt517VrH74kGIX
	 KlRoouHoy2w+0I8Gjn3rMckAgmmWJXrywRI252Wub1ZxoGKQC2aAOGqIyFzqhdojHD
	 6S5mlDyJZULBR3b7DdHEpFVutIiXTXhIWq4MqK9cnZGZMTvUZabsOIAfcHcE3uUnQR
	 Oq1V1u6/cU4Sw==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, ruanjinjie@huawei.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] entry: Fix seccomp bypass after ptrace with TSYNC
In-Reply-To: <2026090332-laborer-mandarin-6dec@gregkh>
References: <2026090332-laborer-mandarin-6dec@gregkh>
Date: Fri, 04 Sep 2026 07:38:44 +0200
Message-ID: <87a4pxa84b.ffs@fw13>
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
@@ -51,6 +51,9 @@ static long syscall_trace_enter(struct p
 		ret = arch_syscall_enter_tracehook(regs);
 		if (ret || (ti_work & _TIF_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		ti_work = READ_ONCE(current_thread_info()->flags);
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
