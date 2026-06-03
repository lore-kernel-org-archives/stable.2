Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3C425CFF;
	Wed,  3 Jun 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484338; cv=none; b=Nx4m9nEeAjZuHqpyvh0dbJW8u2+gzb128Ddof3UjUTHLMRcyCL3FpE6jFgCEPSgDDKemOBeNpJ5oGFIO8oZ9ti5p8GkJBfcJNS2jP+CwIZAI+YJlWGVuD6t5DZjtDygAUaqEXDH+hgb4qC4obslXzPnbjbVYOri37InNP/TaniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484338; c=relaxed/simple;
	bh=Gfw8dFOA/3r77Mwc4Cmh2PzhRbKNXJrXkigZq/J1GdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLmVYbHXptFBlpkqQWHcSDWHtUYt0nbSfr2RrOveYQ3oeX+0DJvRXN/zU9mNxaILYdgHXW7c8qkEQ3neK9++tImiQVKEMeI0MhIeCBWhEmqOb56++wizAzxdfOGHvyyCbjYlXu2SBKC6dI4YSe6a8ZsH2Ie0HjJChBiQh+63pPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hFZnF/t9; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hFZnF/t9"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40ea2c69b;
	Wed, 3 Jun 2026 18:53:35 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: martin.lau@linux.dev
Cc: emil@etsalapatis.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v3 2/3] bpf: use kvfree() for replaced sysctl write buffer
Date: Wed,  3 Jun 2026 18:53:16 +0800
Message-Id: <20260603105317.944304-3-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8d1e059203a2kunmafab39db1ed265
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSB8aVk8eSxpPTU5NHR9MTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=hFZnF/t9uZJKotYogSltBkAZCYjdMey/mbEG0ud93bqJtfFZwOAsxZ3bk1baXMHX1Hvz18UYsAE4cTdOBQiXRQxkO8SrP41126RqRDY0LE+iIjjt4hmE6R3fkvypt1e2YGeJ6XK9L+ZZLjgrw2TR2zzyPekPvFYsyInExXCqpJA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=VO/F218VvhrP/hVvE8uuzLplHyagZNEHN4/okjCoHj4=;
	h=date:mime-version:subject:message-id:from;

proc_sys_call_handler() allocates its temporary sysctl buffer with
kvzalloc() and passes it to __cgroup_bpf_run_filter_sysctl(). Since
kvzalloc() may fall back to vmalloc() for large allocations, freeing
that buffer with kfree() is wrong and can corrupt memory.

Use kvfree() to safely handle both kmalloc and kvzalloc()/vmalloc
allocations.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc5.

Reproduced the bug based on v7.1-rc4 in a QEMU x86_64 guest booted with
KASAN and CONFIG_FAILSLAB enabled. To exercise the replacement path, the
test tree also included the accompanying fix for the stale ret == 1
check in __cgroup_bpf_run_filter_sysctl(). The reproducer confines
failslab injections to the proc_sys_call_handler() range, uses
stacktrace-depth=32, and injects fail-nth=1 while writing 8191 bytes to
/proc/sys/kernel/domainname from a task in the target cgroup. Under
that setup, fail-nth=1 triggered the fault:

  BUG: unable to handle page fault for address: ffffeb0200024d48
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000  SMP KASAN NOPTI
  CPU: 2 UID: 0 PID: 209 Comm: repro_proc_sys_ Not tainted 7.1.0-rc4-00686-g97625979a5d4  PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:kfree+0x6e/0x510
  ...
  Call Trace:
   <TASK>
   ? __cgroup_bpf_run_filter_sysctl+0x626/0xc30
   __cgroup_bpf_run_filter_sysctl+0x74d/0xc30
   ? __pfx___cgroup_bpf_run_filter_sysctl+0x10/0x10
   ? srso_return_thunk+0x5/0x5f
   ? __kvmalloc_node_noprof+0x345/0x870
   ? proc_sys_call_handler+0x250/0x480
   ? srso_return_thunk+0x5/0x5f
   proc_sys_call_handler+0x3a2/0x480
   ? __pfx_proc_sys_call_handler+0x10/0x10
   ? srso_return_thunk+0x5/0x5f
   ? selinux_file_permission+0x39f/0x500
   ? srso_return_thunk+0x5/0x5f
   ? lock_is_held_type+0x9e/0x120
   vfs_write+0x98e/0x1000
   ...
   </TASK>

With this fix applied on top of the same test setup, rerunning the
reproducer with fail-nth=1 yields no corresponding Oops reports.

Fixes: 4508943794ef ("proc: use kvzalloc for our kernel buffer")
Cc: stable@vger.kernel.org

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 2c7f72d3fb11..a0b5f8cd8b10 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1936,7 +1936,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 	kfree(ctx.cur_val);
 
 	if (ret == 1 && ctx.new_updated) {
-		kfree(*buf);
+		kvfree(*buf);
 		*buf = ctx.new_val;
 		*pcount = ctx.new_len;
 	} else {
-- 
2.34.1

