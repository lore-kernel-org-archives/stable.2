Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F2417340;
	Fri,  3 Jul 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092352; cv=none; b=Mh5JHFWS9TN5/FL3pah/YolHbHzhf+lGv7fgX29JdZbSjF64Aje237dSmJRnSq6VfTP/7z6vvOKydjcbNSN+e9cGkXPsSpadSEIfk5mHHQ3b3XUfINKj3P/wII/xSoABG0h9Ztd0AfyRNMk+o2ZngzIer+Xy/6WdvwVQ9eQGEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092352; c=relaxed/simple;
	bh=DQq8RReMEcABMHHCXpb+73LtwviVsW/UuYug12fcTZo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Kb25ziFbtpnCgofiP4dvvN9p59IV0JsMpQ2RaLxm/CN1wrlJZY4Ssx87k+sBk1ShcZt8ZaHsFNaY6pRZXgs7EqRIm8lorlaToTuICb5ovdH7TOv4dThEeQDXCwdHwVtlV6Yr3c+lsWAjUAhUtmjob0U9pXWygEdWkjB7k04i2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=QFgIRCgK; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="QFgIRCgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783092346;
	bh=6zVOs+5+z8ghlJRrlHLjm6Akcr94kbV2GxVtfp+rFPM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QFgIRCgKYSHnvxlsr4Bm9+jXovNMh8oXObttTbeNqQokcTp/XMkm+YxErusX+H5r+
	 y+OzE4nhGEDKewf0pcu8ORwOZ8vA0DbeRvpx8+45fHA+pBZFWTTV9Iwa9vu3eqEIvS
	 cSYl1iU+YoXHtVipUjSFmRm65iZxYE9DljW61NsM=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gsHdQ3RsPz6vZY;
	Fri, 03 Jul 2026 15:25:46 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gsHdP6g07z4y2q;
	Fri, 03 Jul 2026 15:25:45 +0000 (UTC)
Date: Fri, 03 Jul 2026 16:25:45 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Feng Tang <feng.tang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_4/4=5D_panic=3A_use_sys=5Finfo=5Fwi?=
 =?US-ASCII?Q?th=5Ffilter=28=29_to_avoid_duplicate_backtraces?=
In-Reply-To: <akevFNCaXnt0kRVC@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net> <20260625152558.7450-5-include@grrlz.net> <aj5TNB8cRtMNTtIT@pathway.suse.cz> <aj5tFiwhRqPkAkqU@pathway.suse.cz> <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local> <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net> <akYq1YaCpZ0b4SBS@pathway.suse.cz> <EC1E5A79-524A-45C2-9FE8-964EB0E18D76@grrlz.net> <akevFNCaXnt0kRVC@pathway.suse.cz>
Message-ID: <070E6C0C-5AEF-4BD9-84C9-72B2D5E62177@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 3, 2026 1:46:12 PM GMT+01:00, Petr Mladek <pmladek@suse.com> wrote:
>On Thu 2026-07-02 19:13:26, Bradley Morgan wrote:
>> On July 2, 2026 10:09:41 AM GMT+01:00, Petr Mladek <pmladek@suse.com>
>> wrote:
>> >On Mon 2026-06-29 13:54:18, Bradley Morgan wrote:
>> >> On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
>> >> wrote:
>> >> >On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
>> >> >> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
>> >> >> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
>> >> >> In watchdog, panic, and hung task detection scenarios, sys_info()
>can
>> >> >> be called multiple times or alongside direct backtrace triggers
>like
>> >> >> trigger_allbutcpu_cpu_backtrace(). This results in identical
>> >backtraces
>> >> >> being dumped repeatedly from all CPUs, cluttering the kernel log
>and
>> >> >> delaying or obscuring critical debug details.
>> >> 
>> >> im feeling a new file to do all the force panic jazz, but putting
>tape
>> >> on sys_info.c isn't bd either.
>> >
>> >I wonder how to move forward with this.
>> >
>> >Honestly, I am not sure what exactly you mean by creating another
>> >API for tracking the reports so I could not judge it. Feel free
>> >to sent some POC.
>> 
>> sup petr, here's my poc
>> 
>> This should make my entire thing make sense
>> 
>> >From eb587ed749ff5993c517f29799b369185c5ee7d8 Mon Sep 17 00:00:00 2001
>> From: Bradley Morgan <include@grrlz.net>
>> Date: Thu, 2 Jul 2026 18:09:23 +0000
>> Subject: [POC] sys_info: Introduce incident state-tracking to prevent
>>  duplicate diagnostics
>> 
>> In watchdog, panic, and hung task detection scenarios, sys_info()
>> can be called multiple times or alongside direct debug output
>> functions (like trigger_allbutcpu_cpu_backtrace(), print_modules(),
>> print_irqtrace_events(), and dump_stack()). This leads to identical
>> diagnostics and stack traces being dumped repeatedly, cluttering the
>> kernel log and delaying critical panics.
>> 
>> Introduce a state tracking bitmask and helpers in a new file,
>> lib/sys_info_filter.c:
>
>New file suggests that it would implement an API using
>sys_info_filter() prefix.
>
>> - sys_info_filter_and_set(mask): Atomically tests which bits in a mask
>>   have not yet been printed during the current incident, marks them as
>>   printed, and returns that subset.
>
>The name of the funtion is a kind of puzzle. I think that we
>could do a better job.
>
>> - sys_info_reset(): Clears the printed mask state.
>
>This function has sys_info* prefix. It would expect it in sys_info.c
>
>> Add SYS_INFO_MODULES, SYS_INFO_IRQTRACE, and SYS_INFO_STACK flags to
>> include/linux/sys_info.h, and handle them inside sys_info's diagnostic
>> dispatch.
>
>I though about adding an information that we printed backtrace for this
>CPU as well. But it not trivial. Different API shows different extra
>info, like modules, IRQ backtrace, registers, code. I would leave
>this complexity aside for now.
>
>> Update the watchdogs, hung task detector, and panic core to call
>> sys_info_filter_and_set() to deduplicate their diagnostic printouts, and
>> sys_info_reset() when a warning incident concludes (e.g., when a stuck
>> CPU recovers, or a new hung task check round begins).
>> 
>> This ensures each piece of system diagnostic is printed at most once per
>> lockup/panic event, preventing console log spam.
>> 
>> Assisted-by: Gemini:gemini-3.5-flash
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>
>> --- /dev/null
>> +++ b/lib/sys_info_filter.c
>> @@ -0,0 +1,120 @@
>> +static unsigned long sys_info_printed;
>> +
>> +unsigned long sys_info_filter_and_set(unsigned long si_mask)
>> +{
>> +	unsigned long old, new;
>> +
>> +	if (!si_mask)
>> +		return 0;
>> +
>> +	do {
>> +		old = READ_ONCE(sys_info_printed);
>> +		if (!(si_mask & ~old))
>> +			return 0;
>> +		new = old | si_mask;
>> +	} while (cmpxchg(&sys_info_printed, old, new) != old);
>
>It is a good question whether to update the info using atomic
>operations. One problem is that the mask is "unsigned long".
>I am not sure if it natively atomic on all architectures.
>32-bit architecures use extra locking when implementing
>atomic operations with 64-bit values. And we should rather
>avoid any locking in this code.
>
>Well, long seems to be 32-bit on 32-bit x86 so it might be
>safe after all.
>
>> +void sys_info_reset(void)
>> +static void __sys_info(unsigned long si_mask)
>> +void sys_info(unsigned long si_mask)
>
>I wonder why this sys_info*() API implementation has been moved
>from sys_info.c to sys_info_filter.c.
>
>I am sorry but I do not see any advantage in adding the new file
>sys_info_filter.c
>
>> NOTE!!: This is AI generated!! This **MAY** not be the finished product,
>> this is ONLY the model!
>
>IMHO, Gemini did pretty bad job in this case. Please, try to review
>the AI generated before you send it. And send it only when you think
>that it is reasonable enough. :-)
>
>It is even fine to send "crap" but you should start the mail
>with a warning that you send it just give us an idea what you
>had it mind. And you should explain why you actually do not like.
>
>Best Regards,
>Petr
>


for now, I'll go with your approach, I'll split up and submit your
patch(es) in the coming days.


Because the whole new file idea is super complicated and requires a
load of discussion before a model could be completed.

One of my ideas is to just kill sys_info. and/or make it better.

Other ideas I need to think.

Thanks a lot for reviewing my model though.

Thanks!
