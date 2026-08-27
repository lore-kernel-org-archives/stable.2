Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B3411FA7;
	Thu, 27 Aug 2026 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833094; cv=none; b=ba3InxFOD7HfcLYOInJeHtckph/adT58cUMPPUot81rkyB4cSqc9GJjkV+3g7iiMAvGCH3oc3Dk/bnL/7/kuqpcSPejQiOCLoF4CuVGSABCWAepr8Etx7WdjVbYo1rNv4WbzZLX5+Z+4yOJ+tsRFlwTfPXGYMplMLKdGeidb0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833094; c=relaxed/simple;
	bh=5ADKeD3SYv9XjbuCywHtJAUw7WKo8jt1m47yILG/d6k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Kxxj7kyjKQKTSqeBJM1X1gDMqpO3VY+iVQaPeApAtyF1+3TN3oYtucu1dXk3l1UC6RCKvJSj6yQeWL4FXJVm9vhvyotc1BLMDGLNtilpDV71z62qbcHQckd44B3hSQZHne8A9GQUh3EOFvxUXtUBY4hgwDFN+jtZ8kScodjTIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=XjBGK5UD; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Q9p9QU83; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="XjBGK5UD";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Q9p9QU83"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787833050; bh=T0wPFc8wjuUMc+EQl/s943h
	V3ykgmUBZgBjxvFUpE14=; b=XjBGK5UDm7oaiMh5/eFsRIwu3k8vi4HBKEqjJC/gVc4RIIwV4T
	t6cy9mteImC+2GeX1T71hEGYAGLuEULs9YurJHVrWMIYBusK0CWL9Bj9T9oqZTUjFD6cohMvMSF
	zE+lUBhYh9zHvEpXqUkPTIrU5hSZK7MrxbQ08Z3/7ZVzATAx00vP1VjvHIYOKTsptrcb/+N/Bhl
	7EMYtjnFg/2VEKrD7BUYArAkNqoUJj97y/jEHd4SX17vvQDDTbhCGsqCLttlQrHtdBYDzKwvKz6
	0lu/hUsgaWk+ESJh948GGqK1RtCStNx2lkigbQlxqvtRkO96EE6sBWuVlMuhx44z/SQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787833050; bh=T0wPFc8wjuUMc+EQl/s943h
	V3ykgmUBZgBjxvFUpE14=; b=Q9p9QU83I5kC2qyA/sTMJqoyv4ewU2bd90hCZLJ8LMA/Y13/FH
	oYQOUBQm+NzC2Q9RnHVB1RaRl1seeljEs3Cg==;
Date: Thu, 27 Aug 2026 13:17:28 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Steven Rostedt <rostedt@goodmis.org>
CC: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_tracing/user=5Fevents=3A_Clear_c?=
 =?US-ASCII?Q?opied_tracing_state_before_fork_duplication?=
In-Reply-To: <20260827081531.092fafbc@gandalf.local.home>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr> <5B7C72AA-5655-4916-AB17-03A8B94F5D7C@mainlining.org> <faa62ef4d9144b3145a8a6254ac3fea6@oss.cyber.gouv.fr> <DAC674C5-A6BE-4D99-9721-2805640BA8A3@mainlining.org> <20260827081531.092fafbc@gandalf.local.home>
Message-ID: <493C257E-31B8-424C-992D-BD127151949B@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 August 2026 13:15:31 BST, Steven Rostedt <rostedt@goodmis.org> wrote:
>On Thu, 27 Aug 2026 10:45:29 +0100
>Bradley Morgan <brads@mainlining.org> wrote:
>
>> >I usually don't think about adding comments, but yes, that's a good
>> >suggestion.
>> >  
>> >> Maybe you could add this to your memories
>> >> 
>> >> "The description length should be about the same as the change being
>> >> added,unless there is a splat, or something else like a table which  
>> >needs  
>> >> to be added to the description, keep the description length the same
>as
>> >> thepatch size, e.g:
>
>No that is not correct. In fact, some of my longest change logs are
>one-liners and my big changes are small descriptions.
>
>A one-line can be extremely subtle and require a deep description of the
>problem. Big changes may be "Implement this feature" with a description of
>the feature that is much shorter than the code used to create it.
>

Hmm, could be right, my memory isn't perfect, don't worry.

>> >> 
>> >> Instead of doing 3 paragraths about a one liner, we could do a small
>two
>> >> or more line description describing:
>> >> 
>> >> What causes the issue?
>> >> Why is it bad?
>> >> How did you fix it?"  
>> >
>> >Sounds like a good practical advice, thanks. Yet in the present case,
>> >since there is a security issue with the UAF, I felt that it was
>> >important to explain where it came from instead of something very
>> >short along the lines ("fixing a UAF"), hence the couple of paragraphs
>> >and the KASAN output.
>> >  
>> 
>> umm, you could include a ASCII table or something, that signifies the
>bug?
>
>I think the change log is fine and doesn't need to be changed.
>

Yeah, I do too.

>The added comment to the code is fine though.

:)

>
>Thanks,
>
>-- Steve

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
