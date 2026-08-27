Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1836D503;
	Thu, 27 Aug 2026 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833674; cv=none; b=C7IdHIB4EBGYEPu+9dVo3cCQ4eF6RYR1xlFeIimUYYVbe9fqgQ1r9uvX8YTMaepFOG+JwxWdctAQp16A/Sri/zGL3QRBbzXhDO5tQQKQE97TY7TyhAX+j9E21i1yzkbRvvD4RNBZBeYEMjAtQiMWvbTpNV+9vB7Uh/fYtfH899o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833674; c=relaxed/simple;
	bh=0NQQV9LlbF0a/loMDk4OajOl5hTBIHpuqK/90NKZm8o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HUnPSIR5Ei/tAMsdDn/Ztmcs09v65hSsSJUYICsplL0tEUy1NdLN0+ci009wz2duWudcowM/R98AAoV+ZfHDJpnlpndSp1/WSWeG9hz9M6x3iFXqG6Jhbx/anDhmT4zlCz35euQNJyTi87TUXT2mhZ0MyV7sOa5cS3bxtXk8/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=IKmDmBBB; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="IKmDmBBB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bX+iMofqIG9jE2E//kQHKV8uxkbBD8n3W9MnLo0o0wU=; b=IKmDmBBBafFSHNSFNc84+Xf8Rs
	tZiAsuLod4OlXM/4Kjmc8qiQDs0XfXwy/LKTRXJJrIIMhYQrGTh9I2SRlGvkBySxHgXFNfkeQMBkB
	pLf4h562mKMcTTyDquwmpxXmdtLsVhbJ3RpLfEaGT3rTTHRrTCs8mFCpRfcn5+3b6+cX8yLYojMCK
	98iRBQFd0FgixQtCnsyrqE2QZYu3r45lln+s6swq6qqPaNjY/NXUUphxD1thFEdNjlCJR3oOK5gOu
	J6GvnCOKMUfVG5fqAZuPIaWiQX4OVtYwKYcwF8ipdJ1doHEKzRWQzy9pNEsDsQ/ZPFjCkzIZX9P1x
	viIIE6tA==;
Received: from [::1] (port=51628 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wzZCr-00000007MnU-0WyP;
	Thu, 27 Aug 2026 14:27:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 14:27:44 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bradley Morgan <brads@mainlining.org>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Clear copied tracing state before
 fork duplication
In-Reply-To: <20260827081915.320fe2c3@gandalf.local.home>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260827080839.35e44d04@gandalf.local.home>
 <A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org>
 <20260827081915.320fe2c3@gandalf.local.home>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <3beb0339407a35c0b995856eae74d870@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-08-27 14:19, Steven Rostedt wrote:
> On Thu, 27 Aug 2026 13:09:44 +0100
> Bradley Morgan <brads@mainlining.org> wrote:
> 
>> >> @@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
>> >>
>> >>  void user_event_mm_dup(struct task_struct *t, struct user_event_mm
>> >*old_mm)
>> >>  {
>> >> -	struct user_event_mm *mm = user_event_mm_alloc(t);
>> >> +	struct user_event_mm *mm;
>> >
>> >Why this change?
>> >
>> >>  	struct user_event_enabler *enabler;
>> >>
>> >> +	t->user_event_mm = NULL;
>> >> +	mm = user_event_mm_alloc(t);
>> >
>> >I don't see why you moved the mm assignment down here. The
>> >t->user_event_mm
>> >is not used in user_event_mm_alloc().
>> 
>> Uff, not wrong, I must be dummy dumb dumb, well, I base my reviews off
>> 
>> Does this fix the bug? And is this a small fix?
>> 
> 
> The bug is fixed because it needs to NULL out that value. I asked from 
> v1
> to move that change to this function. But this function only needs to 
> add
> that line before the return. It doesn't need to modify anything else in
> that function.
> 
> That is, something like this:
> 
> diff --git a/kernel/trace/trace_events_user.c 
> b/kernel/trace/trace_events_user.c
> index 8c82ecb735f4..6b89d225b189 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -868,6 +868,9 @@ void user_event_mm_dup(struct task_struct *t, 
> struct user_event_mm *old_mm)
>  	struct user_event_mm *mm = user_event_mm_alloc(t);
>  	struct user_event_enabler *enabler;
> 
> +	/* On failure, do not free parent's copy */
> +	t->user_event_mm = NULL;
> +
>  	if (!mm)
>  		return;
> 
> 
> -- Steve

Hello Steve,

Thanks for this. I thought that my previous version was okay
so that it was not required to read the details of
user_event_mm_alloc() to get convinced whether user_event_mm is
accessed or not, but it's true that in the end, this is not
required. Your fix is simpler. Do you want me to send a v3
with that simplification and the same changelog as in the v2?

Regards,
Jérémy
