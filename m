Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A143BDD2;
	Thu, 27 Aug 2026 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823989; cv=none; b=D5ZzDFQBLYED6L9iV11kQVmJmrwgAWUSiGFPB6N9vKsYWwGrOPDNXG/PTwAA4c0HAZvhuzPgnaAQWMRNc41P1Rki52n2LIssYlO1h6VoyIg1APi8deMj4ajxbII08rw2m+kpi0/1CtydsKDN644XKDY5XYdnXU+/rUtl7vy0PSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823989; c=relaxed/simple;
	bh=dh3vG164APjYii4z2Xh7/2PK1JpXQxJG9m23Lli66T0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZTmLmzQUtcqrvXuW5MwHeD4wAYJWSf9WPFyeYQFEUDDy64bWw6E7zXBLYSKKbS0t2FWfCZQm7ASrBj1aUSDy5vO9j7ptKtV9tSBA6CnKXeNSG4LIAKIPjhuhOdkEtri/wDvYNSKEk0stJX66VbuOHla3RGuZaFhMxQdEVqN7GFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YrOJM0cK; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UvdP5/x/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YrOJM0cK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UvdP5/x/"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787823929; bh=V2GO/ymiyRXc2KVf5bJHpIK
	KtBTztJDEc9YYiaIiBy8=; b=YrOJM0cKLUM5HxZ/zfajojwVriXDownnfGzUGlrroFAPxZTp7R
	xLblzXFdgLYy/okKPJYaDhO5wEHKLp/IKgXBpN1HP1mOc/DL+ef81bWMZFdEMeDV/PiAfcZ6gdh
	iGSUdwP0NkrSapzQENFpFXo72uHzIQRLT4MvAZVVh7/xWBai+i3RnZZFptYa7gueBZ5EDbB6lmt
	ZR2zoZStjXC5KFEWTxO95l+UbB6etdCKfIsNixYtK1eecsQdw0gpsSidygoQ3ATMKDjQYlCqfft
	b3rQVnY8pRXeAOm6cIOLAONlsbk4HEkMJptL/QZqSqcj0CgF4guT+vvQnnIOmArJAgQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787823929; bh=V2GO/ymiyRXc2KVf5bJHpIK
	KtBTztJDEc9YYiaIiBy8=; b=UvdP5/x//IitHMxRTvfXNjEuA8Defdp7HN40m2+W1/AT9GbF4J
	saaK/p1cfzPeBxtC5hGf4yxmH62cPEKmJjDg==;
Date: Thu, 27 Aug 2026 10:45:29 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
CC: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_tracing/user=5Fevents=3A_Clear_c?=
 =?US-ASCII?Q?opied_tracing_state_before_fork_duplication?=
In-Reply-To: <faa62ef4d9144b3145a8a6254ac3fea6@oss.cyber.gouv.fr>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr> <5B7C72AA-5655-4916-AB17-03A8B94F5D7C@mainlining.org> <faa62ef4d9144b3145a8a6254ac3fea6@oss.cyber.gouv.fr>
Message-ID: <DAC674C5-A6BE-4D99-9721-2805640BA8A3@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 August 2026 08:15:33 BST, "Jérémy Jean"
<jeremy.jean@oss.cyber.gouv.fr> wrote:
>
>>> diff --git a/kernel/trace/trace_events_user.c
>b/kernel/trace/trace_events_user.c
>>> index 2bbc89d4a266..339e18085af3 100644
>>> --- a/kernel/trace/trace_events_user.c
>>> +++ b/kernel/trace/trace_events_user.c
>>> @@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
>>> 
>>> void user_event_mm_dup(struct task_struct *t, struct user_event_mm
>>> *old_mm)
>>> {
>>> -	struct user_event_mm *mm = user_event_mm_alloc(t);
>>> +	struct user_event_mm *mm;
>>> 	struct user_event_enabler *enabler;
>>> 
>> 
>> Comment?
>> 
>> /* Failure must leave the child with no copied state to free. */
>> 
>> I mean, okay, you don't got to, but itd be nice, if your happy with it,
>add
>> 
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>
>I usually don't think about adding comments, but yes, that's a good
>suggestion.
>
>> Maybe you could add this to your memories
>> 
>> "The description length should be about the same as the change being
>> added,unless there is a splat, or something else like a table which
>needs
>> to be added to the description, keep the description length the same as
>> thepatch size, e.g:
>> 
>> Instead of doing 3 paragraths about a one liner, we could do a small two
>> or more line description describing:
>> 
>> What causes the issue?
>> Why is it bad?
>> How did you fix it?"
>
>Sounds like a good practical advice, thanks. Yet in the present case,
>since there is a security issue with the UAF, I felt that it was
>important to explain where it came from instead of something very
>short along the lines ("fixing a UAF"), hence the couple of paragraphs
>and the KASAN output.
>

umm, you could include a ASCII table or something, that signifies the bug?

>Anyway, noted, and here is a shortened version that skips some details:
>
>Clear the child's user_event_mm pointer before duplication so that a
>failure in user_event_mm_alloc() cannot leave the inherited parent
>pointer in place, which otherwise triggers a UAF.
>(+ KASAN output)

Hmm, I'm iffy on this,

As in, You saying "which triggers a uaf"

Wait no, that does sound right, yeah that's fine, you don't need to su
Bmit
a v3, since the length is fine, but yeah.


>I will send a v3 if you feel that's good enough.
>
>Regards,
>Jérémy

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
