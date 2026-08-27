Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395A3FFAC6;
	Thu, 27 Aug 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832599; cv=none; b=bO1Klj8PdsHryioo0iMGBxbNE86RgVA/fis4r8zeGxECENSDyIcW4TvovM4/1QlbwfmrBKdWpwB69t6xBJQvp7sFPv3QNtkuirc56hX8AqiuUWcYbjDunN0oPPt7xPzPCg4znL82OOgBDo48wOAGh5Uq1dNltrLfyRGJ4liV11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832599; c=relaxed/simple;
	bh=YlZfnPJHRSXq3i6qKHvB6jw0SkWZ4mfUiGtPf+tphj8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kY/ep8TCtvCYO+yNll90jaden3PIYR2uhk+OEVrqa0icf39YZnkrTWV2khH2aT3c5DbD/68W5CQxqanj1tsPEov6FuM4ICLN8HI2tLRNiu9rlLluswW2eLT5v7Jn8vTZ7fYANFqbh6a1DMm7rDMEL5OHs3HG18QHDK3InQq7uXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=MzEXrpFJ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bUjuZ0tq; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="MzEXrpFJ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bUjuZ0tq"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787832586; bh=UmwF9grtCB3dzPlHdm4Hh/r
	NUgB8p50M7R7mwTGZHM4=; b=MzEXrpFJHC56lYwfvcJ8PdLgofNClmP/NU9l/pbESfWEpCzT88
	BpiL+IhwsaoJrvYm7h3BzjpR0i51gS8Ig3dOVrTkgPlnZSzV/hL53TNg3lCoZiIQmbrhbHL8GDE
	s6JUe3RDHenta9b3nPQS2s7N24+VYA1dqflHFsYz+XdpQHEzNEidEgOx4Rw25O0u3n0r7rKqHll
	V4Qr8jdBsQxIhzueGQ/n5bOjOiUzVpCve+Pfv/tEif2jVFeZyYA4tznA2aloFLrtKRQehYBCDFK
	Ptyitr1URGm36i+neDKqXL3UhM1M1py/xx0szTvbXeutsruJDpkXtEBJoX1XVr7klAA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787832586; bh=UmwF9grtCB3dzPlHdm4Hh/r
	NUgB8p50M7R7mwTGZHM4=; b=bUjuZ0tq7ASAgfWWb6xzSIvijEDJarrqhOteP48w+j6pUDstHX
	bT7bgcjN4PoTQD6nvHDDwz037I35fjPnTYAg==;
Date: Thu, 27 Aug 2026 13:09:44 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Steven Rostedt <rostedt@goodmis.org>,
 =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
CC: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_tracing/user=5Fevents=3A_Clear_c?=
 =?US-ASCII?Q?opied_tracing_state_before_fork_duplication?=
In-Reply-To: <20260827080839.35e44d04@gandalf.local.home>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr> <20260827080839.35e44d04@gandalf.local.home>
Message-ID: <A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 August 2026 13:08:39 BST, Steven Rostedt <rostedt@goodmis.org> wrote:
>On Wed, 26 Aug 2026 21:44:15 +0000
>Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>> diff --git a/kernel/trace/trace_events_user.c
>b/kernel/trace/trace_events_user.c
>> index 2bbc89d4a266..339e18085af3 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
>>  
>>  void user_event_mm_dup(struct task_struct *t, struct user_event_mm
>*old_mm)
>>  {
>> -	struct user_event_mm *mm = user_event_mm_alloc(t);
>> +	struct user_event_mm *mm;
>
>Why this change?
>
>>  	struct user_event_enabler *enabler;
>>  
>> +	t->user_event_mm = NULL;
>> +	mm = user_event_mm_alloc(t);
>
>I don't see why you moved the mm assignment down here. The
>t->user_event_mm
>is not used in user_event_mm_alloc().

Uff, not wrong, I must be dummy dumb dumb, well, I base my reviews off 

Does this fix the bug? And is this a small fix?


>
>-- Steve
>
>> +
>>  	if (!mm)
>>  		return;
>>  
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
