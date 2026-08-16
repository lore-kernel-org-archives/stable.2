Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945123C8C7C;
	Sun, 16 Aug 2026 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909432; cv=none; b=iQUL8bnmo3U+9f8x+aFzenXcn5lbWbb1S0yLhZe/QYAkxN68jj11D7LeoLRlYVRPp920UHRT236UV++WVLwdGAL8INVFhpCjfdJQBuI3zcEcUNC+viv4PuDn/Z6KBFslPA104wW54iSIA3cTYoNDC0WUOotNJH5qB24H4ywL/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909432; c=relaxed/simple;
	bh=kIiKoHQd0WC6Fnty8XFffg4ag75LX1LzGU8SF1IIyAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgjR8cUXzNfkjt8UsNbqRu6fwQWhk/5f8CX9iaU3HWqFzBIoB20LiTqEZQp4NfKiqsYuCojWqscByQmXnovlUpWTiZlA5oPHgmxnstHWmYITl/2cg4p/WlatX9mvdstfwqEYsIo85XTbNfQ2wkGX9Jeiw9U4VktaaXxnf6TjpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev; spf=pass smtp.mailfrom=ptr1337.dev; dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b=Ud7QlrtT; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b="Ud7QlrtT"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 826B92815E5;
	Sun, 16 Aug 2026 21:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ptr1337.dev; s=dkim;
	t=1786909428; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZwESbhAwmIEQ+n1rNhD7jwlr70PRztrlCvHPR6Pi4TQ=;
	b=Ud7QlrtTAV4suHiFKU5C5CttHtF+qkRtt8tTsG6bdtXg6F/RmpU3luHIX3vBVwmpCjQMrW
	BK8uswo7e3wx992pgMmTiXzwss8diMY9RlBrQci8WoJFbPPOTnxnJ5PWEWPZFG4Vy8BDkd
	+06gDslNFbF/M9pA9e+ujp8QpJuNn9gh4LBc+6TPBs3zRrXFCMIm1NnliHrcGz8dJFMyRt
	iO6FgpEge8/YmI0vYM1agp7Zk4PmfQ6BMomlhzwhvxvmRHHeirWHdrHl3ghU/qSbz9YAdS
	3AMa6V+g1ELK5MB1bQg7UOTyTEn+MCT4yNM7/qSPNmshnwxMvC4GMJVXaN63SA==
Message-ID: <0b56bfb6-bdb4-4b6b-ae91-ce2e9455b213@ptr1337.dev>
Date: Sun, 16 Aug 2026 21:43:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1.y] Revert "tracing: perf: Fix stale head for perf
 syscall tracing"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260816133101.83109-1-admin@ptr1337.dev>
 <20260816105735.6845e413@robin>
Content-Language: en-US
From: Peter Jung <admin@ptr1337.dev>
In-Reply-To: <20260816105735.6845e413@robin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 8/16/26 16:57, Steven Rostedt wrote:
> On Sun, 16 Aug 2026 15:31:01 +0200
> Peter Jung<admin@ptr1337.dev> wrote:
> 
>> This reverts commit be94a3a77e7eb99c53418de7d4a01bc7eb3f634e.
>>
>> The upstream commit was applied after commit 57918341dd19 ("bpf: Add
>> sleepable support for classic tracepoint programs"), which moved BPF
>> program execution before the per-CPU perf event list is checked.
>>
>> The 7.1.y implementation has not undergone that restructuring. It handles
>> BPF and perf consumers together, and already reloads the current CPU's
>> perf event list after syscall_get_data().
>>
>> As a result, the backport adds an unconditional hlist_empty() return before
>> bpf_prog_array_valid() is consulted. A syscall trace event can have a valid
>> BPF program array while the current CPU's perf event list is empty. In that
>> case the early return prevents the BPF program from running.
>>
>> This breaks BPF consumers of faultable syscall-enter tracepoints such as
>> sys_enter_execve. One observed consequence is that Proton VPN's app-based
>> split tunneling no longer receives exec argument events and therefore
>> cannot match newly started processes.
>>
>> Revert the stable backport. The existing head assignment below the removed
>> block preserves its intended stale-head protection while retaining the
>> previous BPF-aware handling.
> 
> OK, so the Fixes on the original commit be94a3a77e7e should have had:
> 
> Fixes: 57918341dd19 ("bpf: Add sleepable support for classic tracepoint programs")
> 
> Instead?
> 
> -- Steve
> 

Yes, this should fix it too, but has been not verified yet. I will run a 
test tomorrow and let you know.

Best,

Peter

> 
>> Fixes: be94a3a77e7e ("tracing: perf: Fix stale head for perf syscall tracing")
>> Cc:stable@vger.kernel.org
>> Assisted-by:Codex:gpt-5.6-sol
>> Signed-off-by: Peter Jung<admin@ptr1337.dev>
>> ---
>>   kernel/trace/trace_syscalls.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index 8dcedff8429a..8ad72e17d8eb 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
>> @@ -1436,11 +1436,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>>   		if (syscall_get_data(sys_data, args, &user_ptr,
>>   				     &size, user_sizes, &uargs, buf_size) < 0)
>>   			return;
>> -
>> -		/* The above may have caused a migration */
>> -		head = this_cpu_ptr(sys_data->enter_event->perf_events);
>> -		if (hlist_empty(head))
>> -			return;
>>   	}
>>   
>>   	head = this_cpu_ptr(sys_data->enter_event->perf_events);
> 

