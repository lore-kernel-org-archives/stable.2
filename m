Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193223815F3
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118772; cv=none; b=pSsz+KdX+3yNLHS3J9m7/WOEJb3nFcMUhUEolH/5YSR/kUti26OJLrc8TSHx4JyIAW/moZwcfKLV69LJTQ7Qt/abCMOgSeLbtP/iUluPcMVSq1cpBF9+5niSPGtq/sIT2ytRtWILmNPhN5UvPfgV0M7HzYglkn5EjAkwND7jZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118772; c=relaxed/simple;
	bh=pk62lL0eHeta5EpnmZZ+VcUHyNyaxooZtjYjsf5Tp58=;
	h=Cc:Subject:Mime-Version:Content-Type:From:Date:To:Message-Id; b=L6iOUtxQ1sVVLhbXyReE38GGGrxMNcJ7uWqC2ggqivyj7sqMQxzdmVwplFRYNutFl1alwY4utc3VstguaSPlAN9FfqklQZMPPsLUCLen9mVI+NTcRPalm4zJGNL1gvJeoFO8NCvYcTGZK9cTQox6YWQ4qz80Zcto8X1IS74v5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LuJFmvRX; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LuJFmvRX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792118757; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EHWYhLDF9KZVqmcXGvPXYbi3zpzyWgW4t7XAlVQffwA=;
 b=LuJFmvRXI/5dxGOd6zoj6GWvpG6Ih8qTQ1170a/zLRP+9BodrI+6jcfc5+H4d/656l5xnN
 iFw8fRHcMzXMnoDiYOUmnqH+DFgkVgkMVCFtKntUTsB6Sq0Upx9a9EQpVEFDQyZ+i9fGM2
 uPPfKF11MthlSVbqc1cqn/7rxA/KbERp6HE9M00QN5BeUdS8B+n+QSaqKSqFBOSbuQj49r
 OCfOHwfnAF3faC1cNxWXOWRDq0TL/VkaEfUMrhEyroIoMkgIwmErT6KyTXk6hZaOMPS9kh
 YjWMzI0VJzJmq9SezCOv0SGNHm4xfk44k6evTP9aaUwCITMXQ1bgF05yBUlPVw==
Cc: <mark.rutland@arm.com>, <oleg@redhat.com>, <ruanjinjie@huawei.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>, <stable@vger.kernel.org>
Subject: [PATCH] arm64: ptrace: don't warn on missing siginfo in a group-stop
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26ad18fe3+2186ad+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset=UTF-8
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Date: Fri, 16 Oct 2026 10:45:36 +0800
To: <catalin.marinas@arm.com>, <will@kernel.org>
Message-Id: <20261016024536.18938-1-zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>

PTRACE_ATTACH to a group-stopped child can enter do_jobctl_trap(),
which calls ptrace_stop() without siginfo. PTRACE_GETSIGINFO then
returns -EINVAL, as expected. If the tracer writes NT_ARM_SYSTEM_CALL,
system_call_set() stores the new syscallno before calling
update_syscall_orig_x0_after_ptrace(). Its NO_SYSCALL guard no longer
applies, so WARN_ON_ONCE(!info) fires. A tracer can trigger this on its
own child.

do_jobctl_trap() omits siginfo only for non-seized group-stops. Seized,
syscall-entry and seccomp stops supply it. Skip orig_x0 synchronization
for the non-seized group-stop: el0_svc_common() sets orig_x0 on the next
system call. Keep the warning if a seized stop unexpectedly lacks
siginfo.

Fixes: 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Tested on arm64 KVM at af32da41b032. The unpatched kernel reproduced
the WARN. An initial fix that returned on every missing siginfo ran
without warnings.

The final fix was built on the same test baseline. At a group-stop,
PTRACE_GETSIGINFO returned -EINVAL and an NT_ARM_SYSTEM_CALL write
succeeded without a warning. An ordinary PTRACE_SYSCALL entry/exit
round trip completed normally. Changing x0 at syscall-entry and seccomp
stops produced the expected exit status. No kernel warnings occurred.

 arch/arm64/kernel/ptrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f743cbec1..e12b04b8f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -573,9 +573,11 @@ static void update_syscall_orig_x0_after_ptrace(struct task_struct *target)
 	if (regs->syscallno == NO_SYSCALL)
 		return;
 
-	/* We should only be called when target is in a ptrace stop */
-	if (WARN_ON_ONCE(!info))
+	/* Only non-seized group-stops lack siginfo (see do_jobctl_trap()). */
+	if (!info) {
+		WARN_ON_ONCE(target->ptrace & PT_SEIZED);
 		return;
+	}
 
 	/*
 	 * For compat tasks, orig_r0 is provided directly through GPR index

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.39.5 (Apple Git-154)
