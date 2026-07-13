Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801E29992A;
	Mon, 13 Jul 2026 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922261; cv=none; b=rYSgMIVqPc2oCyvq9QRxCCZYQkETkzR/jdw425B/TpQv2V6hwskaSWAAgO2K4cYYVwoHHxk2SwBfkHtyx3N3JLRP+uzUEvZTGopcSEEs2b51csNMaeX0a50Vxl2+7pU81y2LiCkSUHFcPSjB8BPaJIJASQ2z7qGjNPMjZH5vDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922261; c=relaxed/simple;
	bh=ghvSR731ywixyygr0RBmBJDrkYSzfu1orlQs9/ElasQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PsL7ZkHXe8q/Jw5ZhdhZC8WV5QaZ1azWrZQgXlIZGPgKWF7/foTJzZDF38is7lbF0BYAVKJZApKf+4aVK7zsIA27hY8WmHY8slpmKsFxwO3uV92Pbu9Hd20rA/rheEW8Cs86dnE3gufdOGQecIFXxOS4oZLDViejjt9evn+QB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=RWnnLw0J; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="RWnnLw0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783922248;
	bh=wK3teu60zqHskTeqI3g1BIktGR91ceQ9tifigFTSbCA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RWnnLw0Js5i2tQ1+hSp7VlLF5KsXgbTkxtdEc10ZK3qX5A9bYJZ1DdkdTVYXdn8L2
	 5+4Q7JgRrqoXiMSaWAbvndDRoMNXnFSGhpsGBQ98MxY6YjOXcfS8gudhSjV9V0Qj1w
	 ITKPWvOmQMuGH/4+Kx51Z0GA5a4MWqX6symL9QLI=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gzBY45KJwz6vQ5;
	Mon, 13 Jul 2026 05:57:28 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gzBY32j1Hz4vyJ;
	Mon, 13 Jul 2026 05:57:27 +0000 (UTC)
Date: Mon, 13 Jul 2026 06:57:26 +0100
From: Bradley Morgan <include@grrlz.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org,
 oleg@redhat.com, tglx@kernel.org, npiggin@gmail.com,
 pasha.tatashin@soleen.com, kees@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_reboot=3A_enable_IRQs_before_d?=
 =?US-ASCII?Q?o=5Fexit_in_the_halt_and_power_off_fallback?=
In-Reply-To: <87tsq3vbtf.fsf@email.froward.int.ebiederm.org>
References: <20260712125300.31501-1-include@grrlz.net> <87tsq3vbtf.fsf@email.froward.int.ebiederm.org>
Message-ID: <0F13AE9B-5C0C-4327-AA36-C1EB2413EA9F@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 13, 2026 3:54:36 AM GMT+01:00, "Eric W. Biederman"
<ebiederm@xmission.com> wrote:
>Bradley Morgan <include@grrlz.net> writes:
>
>> The reboot syscall calls do_exit(0) after kernel_halt() or
>> kernel_power_off().  Those are expected to stop the machine and not
>> return.  When they do return (no PM info, power off failed), the
>> shutdown path has already disabled interrupts: native_machine_shutdown()
>> calls local_irq_disable() on x86, and do_exit() then hits its
>> WARN_ON(irqs_disabled()) at kernel/exit.c:930.
>>
>> do_exit only warns by design; make_task_dead() is the path that fixes
>> the IRQs disabled state (commit 001c28e57187 ("exit: Detect and fix irq
>> disabled state in oops")).  The reboot fallback is not an oops and wants
>> a clean do_exit, so enable IRQs at the two call sites instead, matching
>> the make_task_dead pattern.
>
>I think this is fixing symptoms not the actual cause.
>
>How does kernel_halt or kernel_power_off manage to return?
>
>If they aren't supposed to return changing the code to call
>make_task_dead to indicate you are on an error path is probably
>the better fix.
>
>Eric

Doh! Nice catch!

I'll do a V2 with some other things I needed to address too, e.g:


>> Splat from syzbot:
>>
>>   ACPI: PM: Preparing to enter system sleep state S5
>>   kvm: exiting hardware virtualization
>>   reboot: Power down
>>   ------------[ cut here ]------------
>>   irqs_disabled()
>>   WARNING: kernel/exit.c:930 at do_exit+0x1cf7/0x2ae0 kernel/exit.c:930,
>CPU#0: init/6193
>>   CPU: 0 UID: 0 PID: 6193 Comm: init Tainted: G             L     
>syzkaller #0 PREEMPT(full)
>>   Tainted: [L]=SOFTLOCKUP
>>   Call Trace:
>>    <TASK>
>>    __do_sys_reboot+0x36e/0x400 kernel/reboot.c:784
>>    do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>    </TASK>
>>
>> Fixes: 001c28e57187 ("exit: Detect and fix irq disabled state in oops")
>> Reported-by: syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=8fdf0d8e10bdde1c2e88
>> Closes:
>https://lore.kernel.org/all/69f5ec0c.050a0220.312cd3.0023.GAE@google.com/T/

The lore links wrong, I'll fix that bug later.

>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  kernel/reboot.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index bed6967bfa96..7e8ebb470721 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -777,10 +777,20 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2,
>unsigned int, cmd,
>>  
>>  	case LINUX_REBOOT_CMD_HALT:
>>  		kernel_halt();
>> +		/* kernel_halt() was expected to not return. */
>> +		if (irqs_disabled()) {
>> +			pr_info("reboot: halt returned with irqs disabled\n");
>> +			local_irq_enable();
>> +		}
>>  		do_exit(0);
>>  
>>  	case LINUX_REBOOT_CMD_POWER_OFF:
>>  		kernel_power_off();
>> +		/* kernel_power_off() was expected to not return. */
>> +		if (irqs_disabled()) {
>> +			pr_info("reboot: power off returned with irqs disabled\n");
>> +			local_irq_enable();
>> +		}
>>  		do_exit(0);
>>  		break;
>

Thanks!
