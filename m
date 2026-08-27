Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF743C0635;
	Thu, 27 Aug 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833118; cv=none; b=iAYuoBpCN3TlIYpzIs/UnVPoY3QLwU6/AVT9DHckuzkzWoOwoe0igA9t1GeAQtEm2mq8SVEIV0xO5bFlAOaelYI/1OCjpOo7RCIoLn5s4sXzUfL56yLoQGV4Q0yYrn22SVIpRbuCmfMXGWx7p1UkCGd9ZoVscBToOoZohv4m8no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833118; c=relaxed/simple;
	bh=zBWr/35bR3H2jkfu2LGG9Vs/UroHh+OvaZbpBWggNGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAGPT5vkHa9jEG38lwWxMBk9BJ7QB5pdDwW6MM1SyLc8I6ipPp1aNjS8QGdVlVBQyk6djoahkz6h5cR8XY0fds7PVNDVvy0rZjsBGUXWeaemJ+FJ+hUO7v8dgb5AXqi4hyGAWu6LiZcVcUHLcYBHWV4wQ9F2D1OHdQcnsabUVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=uHbSlip8; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="uHbSlip8"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2A6D7403F6;
	Thu, 27 Aug 2026 12:18:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 4C4A920027;
	Thu, 27 Aug 2026 12:18:28 +0000 (UTC)
Date: Thu, 27 Aug 2026 08:19:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Clear copied tracing state
 before fork duplication
Message-ID: <20260827081915.320fe2c3@gandalf.local.home>
In-Reply-To: <A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<20260827080839.35e44d04@gandalf.local.home>
	<A4F580CE-2211-4D05-9D3D-15AB427C74A4@mainlining.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fj7kjbcuwmphixa4tb8tiep7wuyuumer
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4C4A920027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/sDFoMoh6N2xeCPxBd+jXdpMeXfTGB2Xk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=akNnSyt/DG1u9KFJTg36bQGZncIw4FqwwxZ/3QLG7V4=; b=uHbSlip8Xa1Q51X6qrwD8ZzIf7jkARGI827JEDvVa3b2vNklL6RA0xf6VPGIS+KrUyaE6o1aydQnYK0lAs/Qpoc9ZDH/g0fDHe5KKz3Z4YHis6TXSFPJMGj09yugKoTaRS2EruLSHnCis7EVqmhP/0+7tw+MzmjsvCCwjZ39oao=
X-HE-Tag: 1787833108-911114
X-HE-Meta: U2FsdGVkX1/LaFxpwkDESwqvJ0GhQTwYpZA2DssHFtoYdzH3mJfnoS2ua5tlh7fE/7rDwKC1CH20lrlBxfKdCXvISkzMkQuVzoiLeEfYs7z9G6b+DPI9Q//7V7x9TzxLDJsCk/cPy2XH5gWc8XnVpQeLMBSe51oWAV/jH9/CXF7TYQbmPC7lnNJ+EyO2m0dFGR+6yVJcoZN2p29PXY9d9rNnXo4wBKnv2F6xvMVY5NkLHw/ZQ5qUBQOjXqkI8aimlGU02BGO7ZpzfCWB7bUy8Pwe6c5vsyNkW7rvjy4UXXgIvKiutWx0vydmonPBzWJgV5QeaHRZErKfhtzxk3yrSb5gRMxNEIBy2/8q8CjvfVa2qqEDZbHnGtHOCRp5PSc0

On Thu, 27 Aug 2026 13:09:44 +0100
Bradley Morgan <brads@mainlining.org> wrote:

> >> @@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
> >>  
> >>  void user_event_mm_dup(struct task_struct *t, struct user_event_mm  
> >*old_mm)  
> >>  {
> >> -	struct user_event_mm *mm = user_event_mm_alloc(t);
> >> +	struct user_event_mm *mm;  
> >
> >Why this change?
> >  
> >>  	struct user_event_enabler *enabler;
> >>  
> >> +	t->user_event_mm = NULL;
> >> +	mm = user_event_mm_alloc(t);  
> >
> >I don't see why you moved the mm assignment down here. The
> >t->user_event_mm
> >is not used in user_event_mm_alloc().  
> 
> Uff, not wrong, I must be dummy dumb dumb, well, I base my reviews off 
> 
> Does this fix the bug? And is this a small fix?
> 

The bug is fixed because it needs to NULL out that value. I asked from v1
to move that change to this function. But this function only needs to add
that line before the return. It doesn't need to modify anything else in
that function.

That is, something like this:

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8c82ecb735f4..6b89d225b189 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -868,6 +868,9 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	struct user_event_mm *mm = user_event_mm_alloc(t);
 	struct user_event_enabler *enabler;
 
+	/* On failure, do not free parent's copy */
+	t->user_event_mm = NULL;
+
 	if (!mm)
 		return;
 

-- Steve
