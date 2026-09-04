Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB403815E1
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500157; cv=none; b=AzPrjJgHCwiEGWOmsO2SHHPCfydKPi2LliOWbE8veAfa/IXWNqAd13MbDFZvlWPXK0Gko8d2BOH/RqtmaxvN0YwJZanfimcuKGMarU87zexkeF9gk2WEVHfsaLylXtFOxJLDV1OjzG6sb2sW7JXt74VOqiuvy3j/ZCw885NYqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500157; c=relaxed/simple;
	bh=77g48iWvSbKpNeXgHSm13bhzN3E6IkG87uMszLIteak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tWdzHPzleyq7pL+IIdeivdZU49zfHRcqS11UAZdEsMJhzG4Fmil5oiOC63Pz8Uq/h/sMmW+TdGhUIacaPLf8UJn6cZVVlcs7Rx/hUmHWJIC3ARA8YGsS22k0xfXT8nHmfVckPvfuAHScq527NFY2C0Q3WfI6iBOBpZTLNw/Qntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYGmuMGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYGmuMGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B8D1F00A3E;
	Fri,  4 Sep 2026 05:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788500156;
	bh=NVHPwUYYqzujasMCvGqDFet1STtVvlZL/crOlmfg2NM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DYGmuMGFneF7JxYKOLndLamcmuBsAWk8xX1QZjuvDVNG+GOX44KLmlCdRnxHTtL7q
	 I0qE0cPle6eBa5usX/ysHZYixKSr0+lEhLJohAL+CQOriVgdJRw7K0iZRp6fjNmRip
	 Yp1rzL7MIlxHGEDzPKVXz8JsHON6x0wl77jjU/QTFypEFmbd5G47bLzWd3ocBRBob+
	 CId7g8DJZc1cJLS3Se6deAnaqjKmftq40yBRXlQdyw0dZOc6VZNpc3RE9LqyCcSdY0
	 TA+Og7zdHkp0UYaJrlsi8W3f2GrZv17N+ycIpErfu9fPjxZljM0UHSQ2YseJ0DrqXf
	 ANEb48WIP7Xjg==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, ruanjinjie@huawei.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.18.y] entry: Fix seccomp bypass after ptrace with TSYNC
In-Reply-To: <2026090330-tightwad-steep-b6f8@gregkh>
References: <2026090330-tightwad-steep-b6f8@gregkh>
Date: Fri, 04 Sep 2026 07:35:53 +0200
Message-ID: <87ik4la892.ffs@fw13>
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
 kernel/entry/syscall-common.c |    3 +++
 1 file changed, 3 insertions(+)
---
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -37,6 +37,9 @@ long syscall_trace_enter(struct pt_regs
 		ret = ptrace_report_syscall_entry(regs);
 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		work = READ_ONCE(current_thread_info()->syscall_work);
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
