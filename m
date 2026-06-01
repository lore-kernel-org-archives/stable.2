Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5832E9ED6
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780348066; cv=none; b=M4g0hTWWr0iJjrJEDNqCHVzNST/551I1CCkT/DY2vmJCoQoArJwQfBDVdMiHhpdVxrajDoURJrfEPPj0DkCYa8arQostUMUX/lTLbh/h6A7WUa9OuOYyUXc9yFThp3iiKcipFoh6dOoF4zjsCF8REELpBdN/+gMD3K2++v8K2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780348066; c=relaxed/simple;
	bh=+L8aVHnARkByV3UmQ+HgDTphp9/dN6AUUqp/Wm7Mltw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl8oVmUFllP+il/ZPWx/UTHTClQ+QUGSwIOC9IFGjLpEchfVuE0ijFc+j3QR20Bs5CaPjONaMTVO95PXF6A8FmizA5IM8DJQ2J+RO6SLXf1k+oCfXsO7XrZsZBHXKHnTfCXPN6XWrG/HP27scjcaQ0SC2nHgH9eyg6pBAop44Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UKNosXut; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UKNosXut"
Message-ID: <a167cf00-7a9c-4a30-9142-e0b6f9a4a3d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780348061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=co0I00Xq52CoHpDQW6LxXKmSSFvzTGDaX5Spnes4S7Y=;
	b=UKNosXutGYs6+967EgMtIqG8JVq9x0cg73SkhMlQT1c37PNmfT/993A5K1YsQyZtwOnFkO
	cbpa2Mjo2pkZDiPsnS/gbuiNDqNofIXM9YurXBqCW/tR7NHllXTSbfQzuAvV+1Ym6bgBmi
	zEh665smwy1LyY9DyKyzIPuuzvlYHJs=
Date: Mon, 1 Jun 2026 14:07:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] bpf: cgroup: use kvfree() for replaced sysctl
 write buffer
Content-Language: en-GB
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 jolsa@kernel.org, kees@kernel.org, joel.granados@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
References: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
 <20260529031026.2716641-2-dawei.feng@seu.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260529031026.2716641-2-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/28/26 8:10 PM, Dawei Feng wrote:
> proc_sys_call_handler() allocates its temporary sysctl buffer with
> kvzalloc() and passes it to __cgroup_bpf_run_filter_sysctl(). Since
> kvzalloc() may fall back to vmalloc() for large allocations, freeing
> that buffer with kfree() is wrong and can corrupt memory.
>
> Use kvfree() to safely handle both kmalloc and kvzalloc()/vmalloc
> allocations.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
>
> Reproduced the bug based on v7.1-rc4 in a QEMU x86_64 guest booted with
> KASAN and CONFIG_FAILSLAB enabled. To exercise the replacement path, the
> test tree also included the accompanying fix for the stale ret == 1
> check in __cgroup_bpf_run_filter_sysctl(). The reproducer confines
> failslab injections to the proc_sys_call_handler() range, uses
> stacktrace-depth=32, and injects fail-nth=1 while writing 8191 bytes to
> /proc/sys/kernel/domainname from a task in the target cgroup. Under
> that setup, fail-nth=1 triggered the fault:
>
>    BUG: unable to handle page fault for address: ffffeb0200024d48
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: Oops: 0000  SMP KASAN NOPTI
>    CPU: 2 UID: 0 PID: 209 Comm: repro_proc_sys_ Not tainted 7.1.0-rc4-00686-g97625979a5d4  PREEMPT(lazy)
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
>    RIP: 0010:kfree+0x6e/0x510
>    Code: 80 48 01 ef 0f 82 ae 04 00 00 48 c7 c0 00 00 00 80 48 2b 05 04 1b 23 04 48 01 c7 48 c1 ef 0c 48 c1 e7 06 48 03 3d e2 1a 23 04 <4c> 8b 57 08 4c 89 d0 83 e0 01 48 83 e8 01 49 09 c2 49 >
>    RSP: 0018:ffff888108de7ab8 EFLAGS: 00010282
>    RAX: 0000777f80000000 RBX: ffff88815af398c0 RCX: 0000000000000080
>    RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffeb0200024d40
>    RBP: ffffc90000935000 R08: 0000000000000001 R09: 0000000000000001
>    R10: ffffffff86b4b297 R11: 0000000000000000 R12: ffffffff819b71fd
>    R13: 0000000000000001 R14: ffff888108de7cc0 R15: 0000000000000000
>    FS:  00007f8988cc2b80(0000) GS:ffff8881d3256000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: ffffeb0200024d48 CR3: 0000000101d6b000 CR4: 0000000000350ef0
>    Call Trace:
>     <TASK>
>     ? __cgroup_bpf_run_filter_sysctl+0x626/0xc30
>     __cgroup_bpf_run_filter_sysctl+0x74d/0xc30
>     ? __pfx___cgroup_bpf_run_filter_sysctl+0x10/0x10
>     ? srso_return_thunk+0x5/0x5f
>     ? __kvmalloc_node_noprof+0x345/0x870
>     ? proc_sys_call_handler+0x250/0x480
>     ? srso_return_thunk+0x5/0x5f
>     proc_sys_call_handler+0x3a2/0x480
>     ? __pfx_proc_sys_call_handler+0x10/0x10
>     ? srso_return_thunk+0x5/0x5f
>     ? selinux_file_permission+0x39f/0x500
>     ? srso_return_thunk+0x5/0x5f
>     ? lock_is_held_type+0x9e/0x120
>     vfs_write+0x98e/0x1000
>     ? srso_return_thunk+0x5/0x5f
>     ? kmem_cache_free+0x308/0x550
>     ? __pfx_vfs_write+0x10/0x10
>     ? __pfx_do_sys_openat2+0x10/0x10
>     ksys_write+0xf2/0x1d0
>     ? __pfx_ksys_write+0x10/0x10
>     ? srso_return_thunk+0x5/0x5f
>     ? trace_irq_enable.constprop.0+0x110/0x140
>     do_syscall_64+0x115/0x690
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7f8988dd8907
>     Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8  01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 >
>     RSP: 002b:00007fff4069b878 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>     RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8988dd8907
>     RDX: 0000000000001fff RSI: 0000564f97ef46b0 RDI: 0000000000000005
>     RBP: 0000564f97ef46b0 R08: 0000000000000000 R09: 0000564f97ef46b0
>     R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
>     R13: 0000000000001fff R14: 0000000000000005 R15: 0000000000000001
>     </TASK>

I think the above log can be simplified like

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

> With this fix applied on top of the same test setup, rerunning the
> reproducer with fail-nth=1 yields no corresponding Oops reports.
>
> Fixes: 4508943794ef ("proc: use kvzalloc for our kernel buffer")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

