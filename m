Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527093D4131
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214645; cv=none; b=DS/1dy8rSbUY1q4gsGDG66uyD3tV8jEw5/QGcfSquyBsgYJJiAdWvOCSRyQNzrFprHleExm0av7yz9mOuMNxkOJyseM0JRa8rKLQbAiljZ7CFfxfC/V68ifca7RB0BCdJEJznYxdFXRcGYKxdKY1Fw7gDp6b+oQur7Dhem/Lc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214645; c=relaxed/simple;
	bh=/rvnHWxsyjatejwWQprf3f9bMXo+Vb/0KMckYAc718M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPjsnmIz96UUf6fPHGi8+/FhYZL1MGh8TbuIHGWOB6NTQkXz6nNz7R2PHuY1nnN6lm+EnS7PfndLILjocU2YNQZZfMMZaiuzFGWbmvh9shFJBm7dBIaBY1hTh605NLwVepbXOMwxKFpt5TdgXCUBl3XA7opbKgzybWZcuMXV8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxG5LlWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxG5LlWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782214643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QY/9Nl/VrWcVhdfUgvda7VSgNL1uP8RPDDyNnbWdsHA=;
	b=NxG5LlWNTy9oXRdbgze5xauuc8gno+gsUAJXpV9ryh2usGlfDpUqXQ4GRFtfCKujf1ca9a
	rs6Cv0lUbiogLozy1Zy9dC+4TmuDIB2p1vhArCrjThF0Sp5FeGBudMaxN0jzQN96e25eYy
	YSB+G8ctFeCyJavjPSjPRpHKjD/DWQ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-pUab9T4nMmyWCqshHQA76g-1; Tue,
 23 Jun 2026 07:37:20 -0400
X-MC-Unique: pUab9T4nMmyWCqshHQA76g-1
X-Mimecast-MFC-AGG-ID: pUab9T4nMmyWCqshHQA76g_1782214637
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E34EE18009C8;
	Tue, 23 Jun 2026 11:37:16 +0000 (UTC)
Received: from fedora (unknown [10.44.49.10])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 68CD33189;
	Tue, 23 Jun 2026 11:37:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jun 2026 13:37:16 +0200 (CEST)
Date: Tue, 23 Jun 2026 13:37:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bradley Morgan <include@grrlz.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
Message-ID: <ajpv5bW01_xtlZ6R@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add Eric.

OK, I agree, it seems we need a simple fix.

Acked-by: Oleg Nesterov <oleg@redhat.com>

-------------------------------------------------------------------------
But let me add some "offtopic" notes... Why do we actually need this fix?

kill_something_info(). But at first glance sys_kill/kill_something_info
can simply use SEND_SIG_NOINFO? If yes, this makes sense anyway, I will
re-check...

do_pidfd_send_signal(PIDFD_SIGNAL_PROCESS_GROUP) allows to call
kill_pgrp_info() if si_code < 0... Not that I think this would be better,
but we could move this "rewrite" logic into __kill_pgrp_info()...

Anything else needs this change? Most probably yes, but after the quick
grep I don't see other group senders with !is_si_special(info).

Eric, what do you think?

Oleg.

On 06/22, Bradley Morgan wrote:
>
> send_signal_locked() rewrites sender ids for the target namespace.
> Group sends reuse the same siginfo, so one recipient can affect the
> next.
>
> Copy the siginfo before changing it.
>
> Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
> Changes since v1:
> - No code changes in this patch.
> - Add patch 2 for Oleg's const suggestion.
> - Link to v1:
>   https://lore.kernel.org/all/0873AC4A-3CB2-4F7B-BFE6-75D855AD22DC@grrlz.net/T/#m89955d13f10807c316d34cc76680d690a2d95b31
>
>  kernel/signal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b9fc7be1a169..d72d9be3a992 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>  int send_signal_locked(int sig, struct kernel_siginfo *info,
>  		       struct task_struct *t, enum pid_type type)
>  {
> +	struct kernel_siginfo rewritten;
>  	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
>  	bool force = false;
>
> @@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
>  		/* SIGKILL and SIGSTOP is special or has ids */
>  		struct user_namespace *t_user_ns;
>
> +		rewritten = *info;
> +		info = &rewritten;
> +
>  		rcu_read_lock();
>  		t_user_ns = task_cred_xxx(t, user_ns);
>  		if (current_user_ns() != t_user_ns) {
> --
> 2.53.0
>

