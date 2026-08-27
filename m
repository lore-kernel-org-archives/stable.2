Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBC421227;
	Thu, 27 Aug 2026 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832478; cv=none; b=EIRO9NTB2v6pjhLdpazmDEymrCScmC4Hv36pekT0uUZ933rLG2nwFCt17KSvdNM8Trtn2dqcX3Yk+6fHo/tkvILJ4DiR3PcF/o7iV9SJtjKQUk/kW8ebphsvnO8ngh8Q5zuJFKd9+NGXQ4weqp0s5cGEi7YGrqONqDpORWqWD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832478; c=relaxed/simple;
	bh=J0PiKCqqvozDaXTK1qBu7BVn4q6Ey0mJmZ91aBD+U34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfF2wh+p9/JNqMLnvc/1ipU+xULaKOVbobk2lCi3lODkqspyv0T8ImUg4NVcPKgAyN1/FMXYJxQUk9Axuq2vBVDCNpf9eTo1/1WybDvk0zkHKhj6d1d8G08jpxRzWqYkd4xXI0hYgLlf4JuJRXWEL6TRu5aFOUXTU/O7sOTdyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=yyN1CkJ0; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="yyN1CkJ0"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3CB1CA3C22;
	Thu, 27 Aug 2026 12:07:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 51A0A2002D;
	Thu, 27 Aug 2026 12:07:52 +0000 (UTC)
Date: Thu, 27 Aug 2026 08:08:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 brads@mainlining.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Clear copied tracing state
 before fork duplication
Message-ID: <20260827080839.35e44d04@gandalf.local.home>
In-Reply-To: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 51A0A2002D
X-Stat-Signature: buiz1t5rx9trs5hepmek5sctm6r91a73
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1988ENOYCIU8H17Ec/Kmbx3v/QRwI7YBW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yh6MsLLU+MMkHmVUoIFgI73amxCC+WQRuG0iaGy9p08=; b=yyN1CkJ0xnXDNZUXNDPtkAKxqn9E34yL4RLqAzXCx/YF+wHfm7X9OUNHq3XWbVgQmEeNmFuXpOhM+UfpD/O4x5GPavycfYfQkBi3ex1OzPRVUTlSWSOViO1frUiN3ZrnHoch2jHuT4T6GhGVuGYn9W2FpsLg1Bdp+8+fkMLE7Rc=
X-HE-Tag: 1787832472-290276
X-HE-Meta: U2FsdGVkX1/JFXqQ5yafWTxb9mNMK5Ht2yZ1xOHAUh6ZdV34hMeXOCALUDY8TWudmQ5QKJgetOAcjyXsZgj6h7LO7HOYGW+qVW8f1zjTTcSbqdyE7teAWfSEmjYdfJY0m6hj1u9BoCh9JlupSiNeXWzI5YK/kC8p8td8JzVLaK9SHoMHN6GCa/zYidUos9Awrm6hF6iuh8GG31P8R+rN0NQgkmEYD6IGZlf4gV8WXq8kcbjZcWmbpFVuJi896AbGDtu8S/22XKUDW5cmcZ6T8f1o6yIszRrJGAWiuNQdfIFfCCY+nFp2YKaXZ82u1Sz2

On Wed, 26 Aug 2026 21:44:15 +0000
J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events=
_user.c
> index 2bbc89d4a266..339e18085af3 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -865,9 +865,12 @@ void user_event_mm_remove(struct task_struct *t)
> =20
>  void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_=
mm)
>  {
> -	struct user_event_mm *mm =3D user_event_mm_alloc(t);
> +	struct user_event_mm *mm;

Why this change?

>  	struct user_event_enabler *enabler;
> =20
> +	t->user_event_mm =3D NULL;
> +	mm =3D user_event_mm_alloc(t);

I don't see why you moved the mm assignment down here. The t->user_event_mm
is not used in user_event_mm_alloc().

-- Steve

> +
>  	if (!mm)
>  		return;
> =20

