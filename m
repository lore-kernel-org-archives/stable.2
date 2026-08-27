Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25731B130;
	Thu, 27 Aug 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833764; cv=none; b=hPoYd+V7kaRd+XZt7j9cAZbBJaaJb5HxEUewsgXpDxpr+zfLB205WYN2tJpmW4iZ6+M8f1MdnD58/gjonG+yhDTlpQq82hC762/x33qcKwyn/UORTW4lQTaMGcg6JnuHlX0sTzLK+FhsL+ZyMgx8HUs7aP9uYFy2BIkU/wJK4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833764; c=relaxed/simple;
	bh=zfMn9iXKfI3ENhFuiYb63ayz/K4vBbvMISeAgximqwE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L0NG0iKoqtk+9Vlv+dTI6MkYAQ2hOHPSHWcLQ+bOvaZLyPSDHuPzFFJASjRvZ3wEb3pyOKY6njLJq2bVAOzp4jE5oxcR9clPnMj5Z+oNgi5ufyqcVoUyxvBIFf4IB4yZelYRi3W0esj0QAaTRSBBu7mb7VvlWhO4mPg81hJabug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RF0NsA8e; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=SXDpLn8P; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RF0NsA8e";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="SXDpLn8P"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787833760; bh=vYWS7FJFrWNFzqcVBE7+ytV
	qgWZhai1nR8bp/OZEK8s=; b=RF0NsA8e3uKaB/7GpPXMKI9nUCf/RvEc8i2u67Gk9eVhgyQijv
	SJV0+MQVK1TSFzJALxHjQ/3GvhqmHjIAVmWOMetUMwmtp5PXLrtGsCJK0uUxTAtG3TbtwR1fUF/
	/swt36hdmFYZ4tWIncWJweoxEegp/Amu+a0FDZyOyPydCQkV0ALht/4XA6EvV6V7tHUog19mmra
	sZ2pQl0Lq+0rGexFLCTB9luVO1J6k/UlKLVCI7oNEVIzy02KUfMLJHS8NeJTB0RL/9AG5ZVFCQV
	pw4ijoq05yJrei+ouMjYrHZuN6nV4fTcwq5RHH7B1cC4Aki0wzTqChDai3rZWKbGrXQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787833760; bh=vYWS7FJFrWNFzqcVBE7+ytV
	qgWZhai1nR8bp/OZEK8s=; b=SXDpLn8PeIvV8rFJ6tCFYqXpawCmG9jkJQa0mV7a/ktduLQcU8
	P8Brdr2qZif/++tZNTJSHBjSBN6LpkC6ZsBg==;
Date: Thu, 27 Aug 2026 13:29:20 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>,
 Steven Rostedt <rostedt@goodmis.org>
CC: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_tracing/user=5Fevents=3A_Clear_c?=
 =?US-ASCII?Q?opied_tracing_state_before_fork_duplication?=
In-Reply-To: <3beb0339407a35c0b995856eae74d870@oss.cyber.gouv.fr>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr> <20260827080839.35e44d04@gandalf.local.home> <A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org> <20260827081915.320fe2c3@gandalf.local.home> <3beb0339407a35c0b995856eae74d870@oss.cyber.gouv.fr>
Message-ID: <CE51AB37-6584-4001-9375-24AA00C8B79D@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 August 2026 13:27:44 BST, "Jérémy Jean"
<jeremy.jean@oss.cyber.gouv.fr> wrote:
>On 2026-08-27 14:19, Steven Rostedt wrote:
>> On Thu, 27 Aug 2026 13:09:44 +0100
>> Bradley Morgan <brads@mainlining.org> wrote:
>> 
>>> >> @@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct
>*t)
>>> >>
>>> >>  void user_event_mm_dup(struct task_struct *t, struct user_event_mm
>>> >*old_mm)
>>> >>  {
>>> >> -	struct user_event_mm *mm = user_event_mm_alloc(t);
>>> >> +	struct user_event_mm *mm;
>>> >
>>> >Why this change?
>>> >
>>> >>  	struct user_event_enabler *enabler;
>>> >>
>>> >> +	t->user_event_mm = NULL;
>>> >> +	mm = user_event_mm_alloc(t);
>>> >
>>> >I don't see why you moved the mm assignment down here. The
>>> >t->user_event_mm
>>> >is not used in user_event_mm_alloc().
>>> 
>>> Uff, not wrong, I must be dummy dumb dumb, well, I base my reviews off
>>> 
>>> Does this fix the bug? And is this a small fix?
>>> 
>> 
>> The bug is fixed because it needs to NULL out that value. I asked from
>v1
>> to move that change to this function. But this function only needs to
>add
>> that line before the return. It doesn't need to modify anything else in
>> that function.
>> 
>> That is, something like this:
>> 
>> diff --git a/kernel/trace/trace_events_user.c
>b/kernel/trace/trace_events_user.c
>> index 8c82ecb735f4..6b89d225b189 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -868,6 +868,9 @@ void user_event_mm_dup(struct task_struct *t, struct
>user_event_mm *old_mm)
>>  	struct user_event_mm *mm = user_event_mm_alloc(t);
>>  	struct user_event_enabler *enabler;
>> 
>> +	/* On failure, do not free parent's copy */
>> +	t->user_event_mm = NULL;
>> +
>>  	if (!mm)
>>  		return;
>> 
>> 
>> -- Steve
>
>Hello Steve,
>
>Thanks for this. I thought that my previous version was okay
>so that it was not required to read the details of
>user_event_mm_alloc() to get convinced whether user_event_mm is
>accessed or not, but it's true that in the end, this is not
>required. Your fix is simpler. Do you want me to send a v3
>with that simplification and the same changelog as in the v2?
>
>Regards,
>Jérémy
I wouldn't mind, add my tag, I review differently from Steven, so Steven
may not be happy at me :(

I review on


1: does this do what it's intended
2: does it fix X?
3: Any comments, any new functions used instead, any way to get the line count shorter?


And others, I apologise if I'm wrong. I just review in a different style.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
