Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4430C160
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318751; cv=none; b=rtO1CoP7sxTmGW+JHSGNaTUuLTWEFi+tbsFvbb5UgHeO2AEZze70lL70g4OJmIKs3GY8BrhtH37XPIUmU+pkAl6z9r5L1rcmTlhwE0muV0+3TEDjvmFWTmbdU3pBNzyb7z5WcxlFdvyrEjo9p1FTbJ1WUJOtKUOHMgwO4T4geEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318751; c=relaxed/simple;
	bh=E1T4wE0ygiMAZv855NIhDr6DZngYGNQdjcNp156J/eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uudbULl2CRm+wo4tbpigdxO30qAxUQFZQQXThwF7gw0RfXCjn3kGXruOn0wxB4bTncul47cchzZkl8du3jW8kz+J7dQM8Hc91r3jHJxTzE+Vu3qV/rirRpn4YT3N1TrjP65rjTJL1mmgn3IdURRxdgLJJ3hrX3cOIkTRTq/zENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0l2Ex3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0l2Ex3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782318749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weXIXIEuSPHid59fYxq8EFYgzpqn8iZGIP2KySkFB54=;
	b=U0l2Ex3MsLW2nqroRS27nv5HXBz9NWkSzYhHX1PBKRhnHbYL/PNCfX3ElRavtXJ5JwvGCb
	X/XMYaEdL2hCI6xPLKbJGvFobcxAxkK2m0uFhuPPntRAMxEwqjnRD20FWL+yJCtYCRQU0h
	V+l5hl8lM3+k0ypHC8His/QkBGrbpOI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-QhMcd1y6N8a7NM5r8orjow-1; Wed,
 24 Jun 2026 12:32:23 -0400
X-MC-Unique: QhMcd1y6N8a7NM5r8orjow-1
X-Mimecast-MFC-AGG-ID: QhMcd1y6N8a7NM5r8orjow_1782318741
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 432FE18052D6;
	Wed, 24 Jun 2026 16:32:21 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4CFD0180058F;
	Wed, 24 Jun 2026 16:32:15 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jun 2026 18:32:20 +0200 (CEST)
Date: Wed, 24 Jun 2026 18:32:13 +0200
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
Message-ID: <ajwGjXNj3QaLzvD5@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
 <ajpv5bW01_xtlZ6R@redhat.com>
 <87bjd0c5xk.fsf@email.froward.int.ebiederm.org>
 <ajv9KWlTGqNV_yi_@redhat.com>
 <A35F5FF8-4FCB-4CE9-8DC5-E0A22071010E@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A35F5FF8-4FCB-4CE9-8DC5-E0A22071010E@grrlz.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 06/24, Bradley Morgan wrote:
>
> Hey you two, sorry to impede in your conversation, but could we write
> your "conflicting" patch over my Patch 2?
>
> It's fine if you don't want to, it kind of kills two birds with one stone.

No, sorry, I don't ;) at least right now. Because I don't really like the
changes it adds into send_signal_locked(). But perhaps I didn't read it
carefully.

Can we return to it later? There is another reason... Currently I am very
busy but I am thinking about another change on top of your 1/2. Something
like below. Not sure it makes a lot of sense though.

Eric, do you think this optimization on top of 1/2 makes sense?

Oleg.

int send_signal_locked(int sig, struct kernel_siginfo *info,
		       struct task_struct *t, enum pid_type type)
{
	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
	struct kernel_siginfo __info;
	bool force = false;

	if (info == SEND_SIG_NOINFO) {
		/* Force if sent from an ancestor pid namespace */
		force = !task_pid_nr_ns(current, task_active_pid_ns(t));
	} else if (info == SEND_SIG_PRIV) {
		/* Don't ignore kernel generated signals */
		force = true;
	} else if (has_si_pid_and_uid(info)) {
		/* SIGKILL and SIGSTOP is special or has ids */
		struct user_namespace *t_user_ns;

#ifdef CONFIG_USER_NS
		rcu_read_lock();
		t_user_ns = task_cred_xxx(t, user_ns);
		if (current_user_ns() != t_user_ns) {
			__info = *info;
			info = &__info;
			kuid_t uid = make_kuid(current_user_ns(), info->si_uid);
			info->si_uid = from_kuid_munged(t_user_ns, uid);
		}
		rcu_read_unlock();
#endif
		/* A kernel generated signal? */
		force = (info->si_code == SI_KERNEL);

#ifdef CONFIG_PID_NS
		/* From an ancestor pid namespace? */
		if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
			if (info != &__info) {
				__info = *info;
				info = &__info;
			}
			info->si_pid = 0;
			force = true;
		}
#endif
	}
	return __send_signal_locked(sig, info, t, type, force);
}

