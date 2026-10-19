Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35C35E1AC
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377381; cv=none; b=EKvugyZ3KQzI6Myy8CvzdoWdts2rJ0btnKjGfbJHZ+NFkjFdAbGWW99FnCGsbM65qT+rl2EkTCuhtcgJ36yL/1vLvUxsvh8nck3sL3gMZLp8zwV254ySvK/kvS1VV463VkPynvkjaAYR1PCUMP2mDaWX3vwPPrGu/QeiSABtFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377381; c=relaxed/simple;
	bh=iNt0kPYsw7dxBfWIAxR3gPDhzaBRX1UrKHotWnU2Dwg=;
	h=Date:Message-Id:Subject:References:To:Cc:From:Mime-Version:
	 Content-Type:In-Reply-To; b=Hk4cLMPa41PKnHPAQ0cd2IrbIgWPlKu9ECGwK+GYkR9oivJVW1TMAwSXSIBoQbMm09AkUkpmt+W5flwS2fSAsJe320vWMviSfIxxK/Tb4qG7jp2wzSV2kVKB+xVSC/Duzgg3sp+Mt8Zg7fbUZcBEjC6pfZmWAnbpnWwQmBuw23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jFsG5Apj; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jFsG5Apj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792377362; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PHriPCstg+i0z+ONxMg+lO4AK2AiTlrmJeaS1ABljFU=;
 b=jFsG5ApjPDMjlMerIak1gTsjH8Eh7KCWxr9n74b75FE1A0K75zzGnmoWz0MichRc0kzFrT
 YTp0OAZS3y+bEHYdukgizOWqgMVZx0FY2XQrFeHWeUXilW0IWyRBncXp58wrGdF4Q4597k
 x6llivluwdsjC+EqdUoTLIxmx+yGMhIWGBxHb5SVC/g/b6PfyeAyu0vJAYl3i1LA6wb9lw
 gzNYMG1IzxokfaOiZBXlpvL7jpA4S+r6gtwNFfU1m4+1L310TDVzOLqNn6UoQ5cwgLc2sK
 dJTmW5mVYMp3yn+u6vaYtKMTXfAZ5UfLkTgLEpOoqZCvhWWwG8Ta4mOaws+ZdA==
Date: Mon, 19 Oct 2026 10:35:44 +0800
Message-Id: <b80c0fd0-498b-4c6c-93df-acee59d2be85@bytedance.com>
X-Lms-Return-Path: <lba+26ad58210+1d7611+vger.kernel.org+zhaogongyi@bytedance.com>
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: ptrace: don't warn on missing siginfo in a group-stop
References: <20261016024536.18938-1-zhaogongyi@bytedance.com> <atHHttWKtnKHJnVQ@redhat.com>
To: "Oleg Nesterov" <oleg@redhat.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>, 
	<ruanjinjie@huawei.com>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <atHHttWKtnKHJnVQ@redhat.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>

On 10/16/26 2:44 PM, Oleg Nesterov wrote:
> On 10/16, Zhao Gongyi wrote:
>>
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -573,9 +573,11 @@ static void update_syscall_orig_x0_after_ptrace(struct task_struct *target)
>>   	if (regs->syscallno == NO_SYSCALL)
>>   		return;
>>   
>> -	/* We should only be called when target is in a ptrace stop */
>> -	if (WARN_ON_ONCE(!info))
>> +	/* Only non-seized group-stops lack siginfo (see do_jobctl_trap()). */
>> +	if (!info) {
>> +		WARN_ON_ONCE(target->ptrace & PT_SEIZED);
>>   		return;
>> +	}
> 
> Perhaps we can simply remove this WARN_ON_ONCE?
> 
> Oleg.
> 
> --- x/arch/arm64/kernel/ptrace.c
> +++ x/arch/arm64/kernel/ptrace.c
> @@ -573,10 +573,6 @@ static void update_syscall_orig_x0_after
>   	if (regs->syscallno == NO_SYSCALL)
>   		return;
>   
> -	/* We should only be called when target is in a ptrace stop */
> -	if (WARN_ON_ONCE(!info))
> -		return;
> -
>   	/*
>   	 * For compat tasks, orig_r0 is provided directly through GPR index
>   	 * 17.
> @@ -588,7 +584,7 @@ static void update_syscall_orig_x0_after
>   	 * Don't update orig_x0 for a syscall-exit-stop, as x0 now contains the
>   	 * return value of the system call.
>   	 */
> -	if ((info->si_code & ~0x80) == SIGTRAP &&
> +	if (info && info->si_code == (SIGTRAP | 0x80) &&
>   	    target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT) {
>   		return;
>   	}

Hi Oleg,

Thanks. I agree that we can remove WARN_ON_ONCE() and allow the
orig_x0 update when last_siginfo is NULL.

I tested syscall-exit-stops on an arm64 7.3.0-rc6-syz kernel with and
without PTRACE_O_TRACESYSGOOD. In both cases, ptrace_message was
PTRACE_EVENTMSG_SYSCALL_EXIT, and an NT_PRSTATUS write succeeded.
The observed si_code values were:

   without PTRACE_O_TRACESYSGOOD: SIGTRAP        (5)
   with    PTRACE_O_TRACESYSGOOD: SIGTRAP | 0x80 (133)

There were no kernel warnings. With the proposed equality check, the
syscall-exit-stop without PTRACE_O_TRACESYSGOOD would fall through and
update orig_x0 from x0, which contains the syscall return value at
that stop.

I think we should retain the check for both si_code values, while
guarding the dereference:

         if (info && (info->si_code & ~0x80) == SIGTRAP &&
             target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT)
                 return;

I'll send a revised patch with the warning removed and this condition.

Thanks,
Gongyi
