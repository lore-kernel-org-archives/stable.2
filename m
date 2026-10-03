Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256833936F
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067589; cv=none; b=B70KtGio8zMczVRXOAMe0X5zgI4RhNeNab+/0gdLrh4U/nerOYD55pFvHQ3tE40mFS7feuBwLWkrQaQzquGN4Od1ir0Ml3rgk4LP0+gEshR8KdLwSEkTLQql8OahQoY28xCegKGRQhSajCsVxyRFatuS14azOUF4G/bwalUoxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067589; c=relaxed/simple;
	bh=KB2yxKkixqut5ModUUMeBSzZZ/lZPMN7thDmej/BPrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da96RDlsNm9XoxGTu7pPcudvECCcy1adu7pcPvTHfXt89Ppm69GaCabNxo8FRukRbNLs3KG7XIhwAGxpwcLSccypv8D0g6Gxo8VHmDKNic/IyghqFgnuE3dVwCXvDkEXxm75l15NZKxSDKHMT++e12n+uZ4DFOvMbkUedQauFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyK2OUG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyK2OUG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86881F0089B;
	Sat,  3 Oct 2026 22:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067588;
	bh=sT+VAcyHGeox7xWQmLBK3Ze8dptwT2MWWx91kJXjnqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LyK2OUG1TRDd0zKAw5nYs9nECoSYJ6760+3nnLHxG25Bodwy1t6DZaU0oKHb8wQlI
	 6e6REFaHO7yPLJ1cl/CYcxhYXVlu10VFPpjzvGUwlPKDdltcP26Sqpai52KNtQpxNO
	 Gj2wsWQ2CLKeOlsVsdFvhihbaAyxIbuM22Qv93xsiS8Wt/Tq8OFmewDNqPsEV3zWCJ
	 6nk5uSOrz6HfVmF9CL3UUaBFQzLXH+14rIKMAMwyGXSOdMU3is+79di1ikjxxX0Ek4
	 Mlca5vseP4TJyy7XCjyiKg/fYdwCwDvhgEgIALgJ6Wsx8cd7zAj4GPG0AqDUkyXYBt
	 yk464WakOWjFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Menglong Dong <dongml2@chinatelecom.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Sat,  3 Oct 2026 18:46:10 -0400
Message-ID: <20261003224546.706125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100341-letter-overstate-ddf7@gregkh>
References: <2026100341-letter-overstate-ddf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit ceb5d8d367d6d37a220023df443d8b67c2f4d1cd ]

rcu_read_lock() is not needed in fprobe_entry, but rcu_dereference_check()
is used in rhltable_lookup(), which causes suspicious RCU usage warning:

  WARNING: suspicious RCU usage
  6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S
  -----------------------------
  include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
  ......
  stack backtrace:
  CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S
  Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
  Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
  Call Trace:
   <TASK>
   dump_stack_lvl+0x7c/0x90
   lockdep_rcu_suspicious+0x14f/0x1c0
   __rhashtable_lookup+0x1e0/0x260
   ? __pfx_kernel_clone+0x10/0x10
   fprobe_entry+0x9a/0x450
   ? __lock_acquire+0x6b0/0xca0
   ? find_held_lock+0x2b/0x80
   ? __pfx_fprobe_entry+0x10/0x10
   ? __pfx_kernel_clone+0x10/0x10
   ? lock_acquire+0x14c/0x2d0
   ? __might_fault+0x74/0xc0
   function_graph_enter_regs+0x2a0/0x550
   ? __do_sys_clone+0xb5/0x100
   ? __pfx_function_graph_enter_regs+0x10/0x10
   ? _copy_to_user+0x58/0x70
   ? __pfx_kernel_clone+0x10/0x10
   ? __x64_sys_rt_sigprocmask+0x114/0x180
   ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
   ? __pfx_kernel_clone+0x10/0x10
   ftrace_graph_func+0x87/0xb0

As we discussed in [1], fix this by using guard(rcu)() in fprobe_entry()
to protect the rhltable_lookup() and rhl_for_each_entry_rcu() with
rcu_read_lock and suppress this warning.

Link: https://lore.kernel.org/all/20250904062729.151931-1-dongml2@chinatelecom.cn/

Link: https://lore.kernel.org/all/20250829021436.19982-1-dongml2@chinatelecom.cn/ [1]
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: e0a624919040 ("fprobe: Use guard(rcu_sched_notrace) and check rcu_is_watching()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1c9ae332afad1..2ba7470443551 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -428,6 +428,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
+	guard(rcu)();
 	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
 	reserved_words = 0;
 	rhl_for_each_entry_rcu(node, pos, head, hlist) {
-- 
2.53.0

