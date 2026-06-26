Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED83EEAF4;
	Fri, 26 Jun 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469674; cv=none; b=WPWfmPI5LUSMHqV4ibcZcY4BnBWc+766TsRpf7bqJtxaVKfh1lfdx3UhQYcUm49EbXeKB0z5vRfGpIK86J/b8IUlO6/zpNbee8hpI/mM4T+DiauDAR9yTb6UWo5gJFhpz+oVw0avdsVP90qcziydjyRMDTqFs5ZV3Lt6z5KqC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469674; c=relaxed/simple;
	bh=MZhwRPTNCsJIk3aNabJjsGxODyCL9FtXHZW0RNl7Qjg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VuCU8iQiP4p5usPTWcJDJKypktd2SohRP38knlVpxncIcfn2MesbQLs77MRWuW7caOfBei6TL5CzNZCg71raMClxD1XRrW7tKIQzMnNbO9wbtfpR75xJyvShsz71mOuv2HPlFlX/4i/6pPogc4Exz1V1dFsrx4YZH85YigaxCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=ohGumFxj; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="ohGumFxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782469659;
	bh=e8nmnh3d5BbttwiwzGI22NcsfM8b00MokXdzihs8LZ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ohGumFxjjf0Raf9wsB+UZCbWDBoG8tHgnZ39bzDb+ibVEV0BmmGEqboD/yxIOeP8V
	 VnUzCDftXgMJNkufSCHcP0DTaGL8scUIdtaUqulvdHyPdMYl+9R/iNvbVxjFFdXCp1
	 49tN0YOLb4i+eztSVXFERQFSpV3k/YW6H0ZnxMSg=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmsLg257mzGpDM;
	Fri, 26 Jun 2026 10:27:39 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmsLf6jxlzGp8j;
	Fri, 26 Jun 2026 10:27:38 +0000 (UTC)
Date: Fri, 26 Jun 2026 11:27:40 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_4/4=5D_panic=3A_use_sys=5Finfo=5Fwi?=
 =?US-ASCII?Q?th=5Ffilter=28=29_to_avoid_duplicate_backtraces?=
In-Reply-To: <aj5TNB8cRtMNTtIT@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz>
Message-ID: <747CB5A4-119B-424F-84C4-5B06FF290C89@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 26, 2026 11:23:48 AM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
>> other CPUs. Do not ask sys_info() to handle that bit again later in the
>> panic path.
>> 
>> Use sys_info_with_filter() so panic_print=all_bt does not request more
>> output after the CPUs are stopped.
>> 
>> Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on
>system lockup")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  kernel/panic.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index 213725b612aa..eb842823df61 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
>>  	 */
>>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>>  
>> -	sys_info(panic_print);
>> +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
>
>Hmm, this prevents printing backtraces from all CPUs completely.
>But what if they were not printed?
>
>They might be printed by:
>
>static void panic_other_cpus_shutdown(bool crash_kexec)
>{
>	if (panic_print & SYS_INFO_ALL_BT)
>		panic_trigger_all_cpu_backtrace();
>
>[...]
>}
>
>But it checks only "panic_print" variable. It won't do anything
>when (panic_print == 0).
>
>In this case, we might still want to print the backraces when
>SYS_INFO_ALL_BT is set in kernel_si_info.
>
>>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>
>Of course, we might fix panic_other_cpus_shutdown() to check also
>kernel_si_info.
>
>But it all becomes very hairy. We have several levels:
>
>   + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace
>
>   + watchdog-specific si_info preferences, e.g. hardlockup_si_mask
>
>   + panic-specific si_info: panic_print
>
>   + universal fallback for any layer: kernel_si_info
>
>Now, we try to check all these variables back and forth to
>trigger all backtraces or to avoid triggering them.
>And it clearly does not work well and the code is more and more
>hairy.
>
>I think about another approach. The word "waterfall" comes to my mind.
>Instead of checking all the settings back and forth, let's process
>each setting one by one and just remember what has been done and
>skip this in the next level.
>
>All the si_info actions seems to dump a global system state.
>So, it would make sense to remember the state in a global variable
>even when it might be modified by more CPUs in parallel.

Not a bad idea.

>I am going to think more about it.
>
>Please, do not send v4 until the discussion settles!

I'll hold on V4.

When you've finished discussing, could I have your suggested patch?
if I think there is issues. I'll fix it.

>Best Regards,
>Petr
>

Thanks!
