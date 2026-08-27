Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA57448BB6;
	Thu, 27 Aug 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833492; cv=none; b=AGqTZIw49Ob1VPyO6J8AJdPmYIfRG69U3Km2Gys9yFuHHoLxx3Tnx3u5qENyppV7kMMoBdLa7bFbbgf2uGyN1D1nIOvJAacZvhMP/4R/EuOhePYunU9xBaK49K7IjgvdtEmAUIr2UVYRcF5NHF1ObGCGRSw6H2YJ3t8lYr+cdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833492; c=relaxed/simple;
	bh=ivf53OgFtMjyPnLKACr+7rsvdM7IpLqa4fkvzX2elFM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XzCVfy5nChtBlZDIUkx8qKoG7nCmV/sZQisl1p+tYNDWRcFQXc5Sbb5Z4ZWPcWwSK0esGjSNfp8RGPDC7zUYmUEm7OS2PKpcwxotjiGlViTCXKs9i731gMGcUYwkVRenGdF1LcwsabANEazTI3BqOgqvPk4skwLc1uCe0Ir8ut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=H/f7wP+F; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JOw5lk16; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="H/f7wP+F";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JOw5lk16"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787833475; bh=JxKthkBcIEQZDO2wxHRAzfg
	xeEEMbJD0usxwKTdeUaE=; b=H/f7wP+FXUO+yxa+q5vMus7cTVI+8nucqzx0Wp+UYsGKinys03
	4pG4JJ1IkakhM0gsWPYanau/YtRvLuEcZfz+tXmgVUjDaToLzIaxnOotvSAf+houXm45s7awPUe
	3Eu6PJL/VNZnE/TkBM8OF0xh0ZJDvSoijKpAI5m4vKUCneKFeF8V5YL20NRBypDSWmv3I4xOegz
	V/ntvXmHlDiMvC674mCk2RQMUUSygeVGrZCOazYNvtGi6BoBOZ7YzjEPJ6fbmuFzJHQxeRMZY97
	FAeA+NJlCv85yztUJ6Gczxsyuhi16LumrzaFVDQqfOUPoBtfab8UOvvUjw0jzR1Kszg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787833475; bh=JxKthkBcIEQZDO2wxHRAzfg
	xeEEMbJD0usxwKTdeUaE=; b=JOw5lk16fOmp4jIc3b+JiIh8o2Vx7r00pCxMUo7g2SxJbzFbNy
	/f9IF5SKpBnHdKbYez1ePgLmSbdH4Bn9UZAw==;
Date: Thu, 27 Aug 2026 13:24:31 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Steven Rostedt <rostedt@goodmis.org>
CC: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_tracing/user=5Fevents=3A_Clear_c?=
 =?US-ASCII?Q?opied_tracing_state_before_fork_duplication?=
In-Reply-To: <20260827081915.320fe2c3@gandalf.local.home>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr> <20260827080839.35e44d04@gandalf.local.home> <A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org> <20260827081915.320fe2c3@gandalf.local.home>
Message-ID: <E0B041DD-5A2A-4120-95F6-BDCA947495A9@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 August 2026 13:19:15 BST, Steven Rostedt <rostedt@goodmis.org> wrote:
>On Thu, 27 Aug 2026 13:09:44 +0100
>Bradley Morgan <brads@mainlining.org> wrote:
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
>The bug is fixed because it needs to NULL out that value. I asked from v1
>to move that change to this function. But this function only needs to add
>that line before the return. It doesn't need to modify anything else in
>that function.
>
>That is, something like this:
>
>diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>index 8c82ecb735f4..6b89d225b189 100644
>--- a/kernel/trace/trace_events_user.c
>+++ b/kernel/trace/trace_events_user.c
>@@ -868,6 +868,9 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
> 	struct user_event_mm *mm = user_event_mm_alloc(t);
> 	struct user_event_enabler *enabler;
> 
>+	/* On failure, do not free parent's copy */
>+	t->user_event_mm = NULL;
>+

Sorry to be mr begfortags here, but this also LGTM, this fixes the bug,
andit's short, thanks for the patch, since I'm busy rn, add my tag if jean
is to submit this 

> 	if (!mm)
> 		return;
> 
>
>-- Steve

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
