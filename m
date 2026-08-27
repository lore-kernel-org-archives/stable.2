Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB318DB1F;
	Thu, 27 Aug 2026 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814942; cv=none; b=awkRcYhzI5LkLh3tlRQEIZSq0ODeU7zwwPJwPqY/lmi63+ANusvQeSgSVAx+RikzxFX8auSsQemPlTLmIUSaaqrYarKWt2IVkk7WEWf3Oo+tMM417rLnVcAjTMgbE4vaDZWBdB/R7Rff7h+QAEYJqSo6pwz0f3j5XhaAAHCdP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814942; c=relaxed/simple;
	bh=9Z3mOB8sjN4xtEd9AWWKUGkfZsPYHphhCLDfo3n7LIM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rIE4un4Na1f6tjeE6VdkVG8ZwO6B/KBosqDyRyWSn7bDoOote5xmEF1yY9TL/R2WSR28bCrJq2q81Z2Be2Wh9Mj6V7gXhZ/A9ARk3WU/GG2SPbt4Pz6XTlaJhDzbnz2YXtql9x1MBOp1/p/BgOCPjvcLz35T1+0rrNESxeIbdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=jtxDEiKN; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="jtxDEiKN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0/WmpBw1NC/NZ1Pwlc5Do2FNd8FdtHL1x6eXwEeq7Ik=; b=jtxDEiKNLKP6UGzhJh3QLxRMR5
	zWLQ+Glcw40djkqxGiLCniny5XLFJDUfQBSfW8sUc8TSkEVHrYfnLiS52hE0QkQRDoKxKGs9HPHLS
	GyQ/0rH+nBBRK9lf+aQHn1fNAPgM9Mxc7HwXhDXDJTV2QmtPtKJGNwI7WHaQ7NvcVlDjplyX5OLp8
	d3C485CFnBRn4jxXLDza1wb3JyJFvnXEZzqmvvK6QGGYcmeqZ17scH2DEzjWHtwRmaSHJcjr/zRXm
	vw76HSWFBacsNxw7cIcUetUNbFGD+kLYNnKHUIPXDGpIGcyzSKNakCbywRrI304kFxMSEGiVD9fM5
	EQ0NTuZA==;
Received: from [::1] (port=55356 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wzUKk-00000001pPr-2UA3;
	Thu, 27 Aug 2026 09:15:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 09:15:33 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Bradley Morgan <brads@mainlining.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Clear copied tracing state before
 fork duplication
In-Reply-To: <5B7C72AA-5655-4916-AB17-03A8B94F5D7C@mainlining.org>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <5B7C72AA-5655-4916-AB17-03A8B94F5D7C@mainlining.org>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <faa62ef4d9144b3145a8a6254ac3fea6@oss.cyber.gouv.fr>
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


>> diff --git a/kernel/trace/trace_events_user.c 
>> b/kernel/trace/trace_events_user.c
>> index 2bbc89d4a266..339e18085af3 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
>> 
>> void user_event_mm_dup(struct task_struct *t, struct user_event_mm
>> *old_mm)
>> {
>> -	struct user_event_mm *mm = user_event_mm_alloc(t);
>> +	struct user_event_mm *mm;
>> 	struct user_event_enabler *enabler;
>> 
> 
> Comment?
> 
> /* Failure must leave the child with no copied state to free. */
> 
> I mean, okay, you don't got to, but itd be nice, if your happy with it, 
> add
> 
> Reviewed-by: Bradley Morgan <brads@mainlining.org>

I usually don't think about adding comments, but yes, that's a good 
suggestion.

> Maybe you could add this to your memories
> 
> "The description length should be about the same as the change being
> added,unless there is a splat, or something else like a table which 
> needs
> to be added to the description, keep the description length the same as
> thepatch size, e.g:
> 
> Instead of doing 3 paragraths about a one liner, we could do a small 
> two
> or more line description describing:
> 
> What causes the issue?
> Why is it bad?
> How did you fix it?"

Sounds like a good practical advice, thanks. Yet in the present case,
since there is a security issue with the UAF, I felt that it was
important to explain where it came from instead of something very
short along the lines ("fixing a UAF"), hence the couple of paragraphs
and the KASAN output.

Anyway, noted, and here is a shortened version that skips some details:

Clear the child's user_event_mm pointer before duplication so that a
failure in user_event_mm_alloc() cannot leave the inherited parent
pointer in place, which otherwise triggers a UAF.
(+ KASAN output)

I will send a v3 if you feel that's good enough.

Regards,
Jérémy
