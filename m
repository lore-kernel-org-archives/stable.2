Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368928;
	b=KPG/PkVGlxRhITCIojz64A11DOy4+++a73WQpNYyPh0WQ/+TG27tMi4mBm0H5DcLgwo1
	 vNakWNwe8XU6hEa+IjX6L5K9jWVLzHFceJmB2JrYdmQR3JUkxbE9Mj88LAxvoiqdHN5b9
	 dGPj9ElNqQAe6pUV9U0+jp+uA3xSFvEBwa9IZ9hIU/tTfe5A/w99fYr2h7GTkQlj/TFBC
	 SgDCsNCHduoCqrNndC/m0JYWqiqJoLmFhoWsdN1OZRVBtZve+Xfz/v6/Oo7s7iOQyefEr
	 Efu96tlewWxiBFL/KdLfIfBPvs2mfq27xGu1GHke1vTFJWR1QV53cRNXhUMmVpG9i0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368928;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Scanned-By;
	bh=sJM5U0UMt7klljmQpHi8pFYazE6ZZS3AuyiLULRE4vg=;
	b=4NNTYznBFd/Hv27H3Cl1LQ2oX4KpQbFAyEiqnmAkPG2JkCDnR8eTmuvcAXbWcx6/OCY0
	 EmCJXNpjaTxxXAbSH1OmOl52411NyKfxeLpGpYw5/0CNa4m8/sudpxnLc397P8YcTSFHm
	 Pc0zOWOwsS/RwTeA1MMIabYNIv6O7LLv64YNjFgfOsagW/aKyO4/TqWTe+bncOaiD/6/9
	 cu1fkkCowtTWinN2bMLY4Rfw2TSE0i7UpivuKnMpuccgVfrO+4iS28wdPALHMWQCFnpw9
	 YSEwATo4Pe19p6JiK2o/lIk1JRur8q4Jg2uaTy8TClKLb9nyUuqsA8bjnfKTn/F4Krg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QSydsZyE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F42606A33E
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 17:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F42606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QSydsZyE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795368927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJM5U0UMt7klljmQpHi8pFYazE6ZZS3AuyiLULRE4vg=;
	b=QSydsZyE+PmJj8GEtBnQZzd4yYFiXGZq+SeQOat7S7XSJDadPUzwHdefG6NLaoYFsRwqSz
	pZUwiIR9NShaieH3FJA5NBuz4Lzlzn8SDhAauXHprrDC4Zah34X7lmoxhxzPXbLpz3KPfc
	hAxT5OdxgK4Offfwl4PoUOUC7t57ZA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-49qdmpqANlG9np73tUhOVQ-1; Sun,
 22 Nov 2026 17:35:22 +0000
X-MC-Unique: 49qdmpqANlG9np73tUhOVQ-1
X-Mimecast-MFC-AGG-ID: 49qdmpqANlG9np73tUhOVQ_1795368920
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E3CC180047B;
	Sun, 22 Nov 2026 17:35:19 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0C54F41F;
	Sun, 22 Nov 2026 17:35:13 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sun, 22 Nov 2026 18:35:18 +0100 (CET)
Date: Sun, 22 Nov 2026 18:35:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	Cen Zhang <blbllhy@gmail.com>, James Morris <jmorris@namei.org>,
	Lee Seong Hyeon <ihopenre@gmail.com>,
	Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>,
	Nickolai Zeldovich <nickolai@csail.mit.edu>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <awMn0L7RaQO_6qUc@redhat.com>
References: <20261120151554.2651743-1-mic@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120151554.2651743-1-mic@digikod.net>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/20, Mickaël Salaün wrote:
>
> @@ -492,6 +533,19 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	size_t newly_discovered_threads;
>  	bool found_more_threads;
>  
> +	/*
> +	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> +	 * multiple threads call landlock_restrict_self() simultaneously.  If
> +	 * another operation got there first, gracefully yield by restarting the
> +	 * syscall.  This allows the current thread to process pending
> +	 * task_works before retrying.
> +	 *
> +	 * sighand->siglock protects only the marker, not the wait below.
> +	 */
> +	CLASS(current_tsync_marker, marker)();
> +	if (!marker)
> +		return restart_syscall();
> +
>  	atomic_set(&shared_ctx.preparation_error, 0);
>  	init_completion(&shared_ctx.all_prepared);
>  	init_completion(&shared_ctx.ready_to_commit);
> @@ -503,16 +557,6 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
>  		task_no_new_privs(current);
>  
> -	/*
> -	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> -	 * multiple threads call landlock_restrict_self() simultaneously.
> -	 * If the lock is already held, we gracefully yield by restarting the
> -	 * syscall. This allows the current thread to process pending
> -	 * task_works before retrying.
> -	 */
> -	if (!down_write_trylock(&current->signal->exec_update_lock))
> -		return restart_syscall();

Just in case, the patch looks obviously correct, so feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

-------------------------------------------------------------------------------
But when I look at this code...

Well, if we change landlock_restrict_sibling_threads() to rely on ->siglock,
it seems that it can be greatly simplified? I mean, it can roughly do:

	...

	for (nt nr_threads = 0;; tsync_works_grow_by(&works, nr_threads))
	{
		guard(spinlock_irq)(&current->sighand->siglock);

		if (!nr_threads) {
			if (signal->flags & SIGNAL_LANDLOCK_TSYNC || ...)
				return restart_syscall();
			else
				signal->flags |= SIGNAL_LANDLOCK_TSYNC;
		}

		if (nr_threads < get_nr_threads(current)) {
			nr_threads = get_nr_threads(current));
			continue;
		}

		for_other_threads(current, thread) {
			if (thread->flags & PF_EXITING)	// stable under siglock
				continue;

			ctx = tsync_works_provide(...); // can't fail

			...

			task_work_add(thread, &ctx->work, TWA_SIGNAL); // can't fail
		}

		break;
	}

	complete_all(&shared_ctx.ready_to_commit);
	...

We can kill tsync_works_trim/tsync_works_contains_task/count_additional_threads/etc.

Sure, this needs another change even if I am right.

Oleg.

