Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7815B5AB;
	Mon, 13 Jul 2026 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911301; cv=none; b=YDx6D1tdqkcYO2AW+ft4MNaOYoB8+jVuWXg51R1WUoX99SYEr0y88IZ2tcAHFTM6QqX12xCadvAhKPvzk9UOqEIICJC3r88AO5bLAPnlcUfteoLQ6O5z4FVUgaB44sRalq1v3IRO1X7BfNsCJQD/Zy3xEOCSCmqI92NoCHy/mOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911301; c=relaxed/simple;
	bh=EnKfbqcCYYSXdziSrYKA98+yiMDGBEkowiVteD71BiE=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=k5j0F+q46fbUH8D4nAfTgbm2VRABrDT7lIbV9mQSrkS6VV5af/HenMhX5HuzHsm/nzPqP/Z2vzEkLzkV4s4X/byhB7/Cn4P+Z8c0h1iJ5MS1ngG1hsx4qDL0KokS4i0bX10vB23LWEhWxO79O9oDovVm7uZJzYs9O5wCy0T9mFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=gsluGzhS; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="gsluGzhS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EnKfbqcCYYSXdziSrYKA98+yiMDGBEkowiVteD71BiE=; b=gsluGzhSMBNnNtqBIvtjtMAX/w
	DcI3aOlZKQIG+kdI5db+5VSTRwy5b/6Gigy7/iE1xVuIr7L+19e+Bf6JblwHz8eo6Qr15krIPvspT
	F1n5h/lmrU/VeOyGJLW3VBrwwR7D1O/uy5g2gK5uEpyVwZKJM70lTEvYuPTf1FAi6txE=;
Received: from in02.mta.xmission.com ([166.70.13.52]:57340)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wj6oh-00F1vl-U4; Sun, 12 Jul 2026 20:54:47 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:34252 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wj6of-000TKc-0K; Sun, 12 Jul 2026 20:54:47 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  peterz@infradead.org,
  oleg@redhat.com,  tglx@kernel.org,  npiggin@gmail.com,
  pasha.tatashin@soleen.com,  kees@kernel.org,  stable@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
In-Reply-To: <20260712125300.31501-1-include@grrlz.net> (Bradley Morgan's
	message of "Sun, 12 Jul 2026 12:52:59 +0000")
References: <20260712125300.31501-1-include@grrlz.net>
Date: Sun, 12 Jul 2026 21:54:36 -0500
Message-ID: <87tsq3vbtf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1wj6of-000TKc-0K;;;mid=<87tsq3vbtf.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;sPfnum=0;;;sPf=pass
X-XM-AID: U2FsdGVkX1/2LCnRfFntjkxNTv5fkBguMqjJ0Cc6uXc=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Bradley Morgan <include@grrlz.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2483 ms - load_scoreonly_sql: 0.13 (0.0%),
	signal_user_changed: 12 (0.5%), b_tie_ro: 10 (0.4%), parse: 1.08
	(0.0%), extract_message_metadata: 20 (0.8%), get_uri_detail_list: 2.4
	(0.1%), tests_pri_-2000: 13 (0.5%), tests_pri_-1000: 2.7 (0.1%),
	tests_pri_-950: 1.32 (0.1%), tests_pri_-900: 1.06 (0.0%),
	tests_pri_-90: 101 (4.1%), check_bayes: 98 (4.0%), b_tokenize: 10
	(0.4%), b_tok_get_all: 11 (0.4%), b_comp_prob: 3.1 (0.1%),
	b_tok_touch_all: 71 (2.9%), b_finish: 1.02 (0.0%), tests_pri_0: 399
	(16.1%), check_dkim_signature: 0.62 (0.0%), check_dkim_adsp: 2.6
	(0.1%), poll_dns_idle: 1893 (76.3%), tests_pri_10: 3.1 (0.1%),
	tests_pri_500: 1924 (77.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] reboot: enable IRQs before do_exit in the halt and
 power off fallback
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, kees@kernel.org, pasha.tatashin@soleen.com, npiggin@gmail.com, tglx@kernel.org, oleg@redhat.com, peterz@infradead.org, brauner@kernel.org, akpm@linux-foundation.org, include@grrlz.net
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Bradley Morgan <include@grrlz.net> writes:

> The reboot syscall calls do_exit(0) after kernel_halt() or
> kernel_power_off().  Those are expected to stop the machine and not
> return.  When they do return (no PM info, power off failed), the
> shutdown path has already disabled interrupts: native_machine_shutdown()
> calls local_irq_disable() on x86, and do_exit() then hits its
> WARN_ON(irqs_disabled()) at kernel/exit.c:930.
>
> do_exit only warns by design; make_task_dead() is the path that fixes
> the IRQs disabled state (commit 001c28e57187 ("exit: Detect and fix irq
> disabled state in oops")).  The reboot fallback is not an oops and wants
> a clean do_exit, so enable IRQs at the two call sites instead, matching
> the make_task_dead pattern.

I think this is fixing symptoms not the actual cause.

How does kernel_halt or kernel_power_off manage to return?

If they aren't supposed to return changing the code to call
make_task_dead to indicate you are on an error path is probably
the better fix.

Eric

> Splat from syzbot:
>
>   ACPI: PM: Preparing to enter system sleep state S5
>   kvm: exiting hardware virtualization
>   reboot: Power down
>   ------------[ cut here ]------------
>   irqs_disabled()
>   WARNING: kernel/exit.c:930 at do_exit+0x1cf7/0x2ae0 kernel/exit.c:930, CPU#0: init/6193
>   CPU: 0 UID: 0 PID: 6193 Comm: init Tainted: G             L      syzkaller #0 PREEMPT(full)
>   Tainted: [L]=SOFTLOCKUP
>   Call Trace:
>    <TASK>
>    __do_sys_reboot+0x36e/0x400 kernel/reboot.c:784
>    do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> Fixes: 001c28e57187 ("exit: Detect and fix irq disabled state in oops")
> Reported-by: syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8fdf0d8e10bdde1c2e88
> Closes: https://lore.kernel.org/all/69f5ec0c.050a0220.312cd3.0023.GAE@google.com/T/
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/reboot.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index bed6967bfa96..7e8ebb470721 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -777,10 +777,20 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  
>  	case LINUX_REBOOT_CMD_HALT:
>  		kernel_halt();
> +		/* kernel_halt() was expected to not return. */
> +		if (irqs_disabled()) {
> +			pr_info("reboot: halt returned with irqs disabled\n");
> +			local_irq_enable();
> +		}
>  		do_exit(0);
>  
>  	case LINUX_REBOOT_CMD_POWER_OFF:
>  		kernel_power_off();
> +		/* kernel_power_off() was expected to not return. */
> +		if (irqs_disabled()) {
> +			pr_info("reboot: power off returned with irqs disabled\n");
> +			local_irq_enable();
> +		}
>  		do_exit(0);
>  		break;
