Received: from pdfedit.cz (pdfedit.cz [37.205.9.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C8258EFF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.9.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413755; cv=none; b=O4XH5CIr6nNnWFWpr6Z9oHE+fHHjNP1CoevHerd4pU+SfVyQwx+SGDkdtLOBWRKoM72t0x6ITuMuNdN+JlgVSuDaY4ygwkLNJQmON8+E/4ddjUoC7q9H+o2hSLWerk5ne7tSdbY1nl2axPNErO65wR9pL1UGL2UP/cX/mXzIOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413755; c=relaxed/simple;
	bh=2jDIPelxMjjtDj1XbBKDG5QkQZ4xnRa4LbQ0BrI86yk=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=u/b1NJOY5osEwv4SGNbZVubrP4CBtU7QEnu6kbDWgpNVk4H/7//qV+8ebZr0jqiUZ+yn5SbM+tCMgGcpOo1tK9TbDmWx2/UdWevz+aR+VQc9vw9ed0n90ntcLBYcZfLjfQdpx5q+FpAu+p363K5bY+TxS/T41BIYkJBy1yggCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=petricek.net; spf=pass smtp.mailfrom=petricek.net; arc=none smtp.client-ip=37.205.9.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=petricek.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=petricek.net
Received: from localhost ([127.0.0.1] helo=pdfedit.cz)
	by pdfedit.cz with esmtp (Exim 4.98.2)
	(envelope-from <mp@petricek.net>)
	id 1wtbZN-00000003R7w-2OK5
	for stable@vger.kernel.org;
	Tue, 11 Aug 2026 03:46:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 03:46:21 +0200
From: Martin Petricek <mp@petricek.net>
To: stable@vger.kernel.org
Subject: [BUG] apparmor: deadlock in complain-mode change_hat
User-Agent: RWM
Message-ID: <552f7777b10a92ef675cb12a07ba8b7b@petricek.net>
X-Sender: mp@petricek.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Originally found in 7.0.0 in LTS ubuntu 26.04 with pam_apparmor + su in 
complain mode set to change hats.
Then verified in newest available vanilla kernel I've compiled to see if 
still present:

7.2-rc7 vanilla -> affected

checked also some other kernels:
6.18.44 vanilla -> affected
6.12.95 with debian patches -> unaffected

Simplified reproduction that does not need complex pam_apparmor config:

hat.c
     #include <sys/apparmor.h>
     #include <stdio.h>
     int main(void) {
         int rc = aa_change_hat("no_such_hat", 0x1234abcdUL);
         printf("aa_change_hat rc=%d\n", rc);
         return 0;
     }

  cc -o /usr/local/bin/hat hat.c -lapparmor

/etc/apparmor.d/local.hat
     abi <abi/4.0>,
     include <tunables/global>
     # Complain-mode profile with NO matching hat:
     profile hattest /usr/local/bin/hat flags=(complain) {
         include <abstractions/base>
         /usr/local/bin/hat mr,
         # deliberately no ^hat defined
     }

  apparmor_parser -r /etc/apparmor.d/local.hat

Then to trigger the bug:

  aa-exec -p hattest -- /usr/local/bin/hat

On systems without bug (for example 6.12.95 debian) it just prints:

aa_change_hat rc=0

On systems with bug, the executable always hangs, prints nothing and 
becomes unkillable.
(And once stuck this way, it will cause any further hat changes to also 
cause the changing process to get stuck)

Then in syslog you can find hint about cause:

kernel: INFO: task hat:3409 blocked for more than 483 seconds.
kernel:       Not tainted 7.2.0-rc7 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
message.
kernel: task:hat             state:D stack:0     pid:3409  tgid:3409  
ppid:2605   task_flags:0x400000 flags:0x00080800
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x48f/0xfe0
kernel:  schedule+0x27/0xa0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x569/0xa10
kernel:  aa_new_learning_profile+0x15f/0x210
kernel:  build_change_hat+0x19f/0x3b0
kernel:  change_hat.isra.0+0x5dd/0xd60
kernel:  aa_change_hat+0x2f3/0x710
kernel:  aa_setprocattr_changehat+0x121/0x1f0
kernel:  do_setattr+0x28c/0x340
kernel:  apparmor_setselfattr+0x20/0x50
kernel:  security_setselfattr+0xf6/0x110
kernel:  __x64_sys_lsm_set_self_attr+0x53/0x90
kernel:  do_syscall_64+0xdd/0x5e0
kernel:  ? __mod_memcg_lruvec_state+0xfd/0x260
kernel:  ? lruvec_stat_mod_folio+0x8d/0xd0
kernel:  ? __folio_mod_stat+0x2d/0x90
kernel:  ? map_anon_folio_pte_nopf+0xd1/0x1f0
kernel:  ? do_anonymous_page+0x184/0xa10
kernel:  ? __handle_mm_fault+0x805/0x870
kernel:  ? count_memcg_events+0xef/0x230
kernel:  ? handle_mm_fault+0x1f0/0x2f0
kernel:  ? do_user_addr_fault+0x2bb/0x7b0
kernel:  ? do_syscall_64+0x94/0x5e0
kernel:  ? exc_page_fault+0x75/0x160
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: RIP: 0033:0x7f815e134c8d
kernel: RSP: 002b:00007fff6df94ea8 EFLAGS: 00000246 ORIG_RAX: 
00000000000001cc
kernel: RAX: ffffffffffffffda RBX: 0000556d8c81d040 RCX: 
00007f815e134c8d
kernel: RDX: 0000000000000046 RSI: 0000556d8c81d040 RDI: 
0000000000000064
kernel: RBP: 00007fff6df94ef0 R08: 00007f815e212ac8 R09: 
000000000000000c
kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 
0000556d8c81d010
kernel: R13: 0000000000000026 R14: 0000000000000046 R15: 
0000000000000064
kernel:  </TASK>
kernel: INFO: task hat:3409 is blocked on a mutex likely owned by task 
hat:3409.
