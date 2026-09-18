Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582C4B44AF
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728060; cv=none; b=pzTW/oAoxHWLopLEN0b8DCg6pYoc0L87vr/sD7sYKr0SCd0qVHJXLiNzGgS28B/QbUJQ0tKxj9YB0edHAuEufy5ZZhmW9N4H+QjyCRi8ZZZkft0L8Q81CTzFLXBrxPg04tyLppU9/m50J0TREyjhOj0WsCbJ67EjHbeiDs6VciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728060; c=relaxed/simple;
	bh=+difSxvjkcc8DCKltwjQVkR0VCgiAM/fWSzRXSJxKFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpjLMOJo6uUTjOjjAnBznHInA67B6Tmm6fgnHpoOAz6jHtA0QXzOvfh2dRcDsokCx5URpTtE1dR8fVoOeQTRhCthg3LY/vTFeUFOIjahbBRY+QD4JjqIASmvRNl/DjjA6XTeO8DoR3+bmaSBlCpD9J0ubi5RkB/uBSqF/H/zSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/L65tvw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/L65tvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789728057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWpYd7ykBa+pqh/CyPARHr2i0q4gvAGEWlcw4oSuPo=;
	b=X/L65tvwrdlT13sfOkrqh3KefZ8T3Q+q2auEtabUXDI6fTaadByDYEIzwld5xEYhaOxAmU
	RsUHvB1LQ4Q9Yq/+CMWSXhRj+TO+cshWagT77NB4USyYKl6xLYmr9zolp47yBppPbPm13S
	qT7FaxUlNVxo/8hBIiiT65HlJwFtw2Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-ZK5aK-O7OAKAcpsQdMVDLw-1; Fri,
 18 Sep 2026 06:40:54 -0400
X-MC-Unique: ZK5aK-O7OAKAcpsQdMVDLw-1
X-Mimecast-MFC-AGG-ID: ZK5aK-O7OAKAcpsQdMVDLw_1789728052
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7B9D196F76F;
	Fri, 18 Sep 2026 10:40:51 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 185AC195604D;
	Fri, 18 Sep 2026 10:40:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 18 Sep 2026 12:40:51 +0200 (CEST)
Date: Fri, 18 Sep 2026 12:40:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <aq0VLTyxNatFmLOK@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/17, Christian Brauner wrote:
>
> Say a SQPOLL thread is a member of a thread-group that coredumps.
> The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
> thread uses io_sqd_handle_event() and calls get_signal(). It removes
> SIGKILL from the pending set and returns. The SQPOLL thread breaks out
> of the loop and drains its own task work.
>
> Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
> worker when no other worker is free. So it ends up calling
> create_io_thread() from a thread whose fatal signal is gone.

Oh.. Can we fix this in the io_uring/ code somehow? The very fact that
copy_process() can be called after get_signal() returns SIGKILL looks
very wrong to me. See below.

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2491,8 +2491,10 @@ __latent_entropy struct task_struct *copy_process(
>  		goto bad_fork_core_free;
>  	}
>
> -	/* Let kill terminate clone/fork in the middle */
> -	if (fatal_signal_pending(current)) {
> +	/* Let kill or a group exit, exec or coredump abort clone/fork */
> +	if (fatal_signal_pending(current) ||
> +	    (current->signal->flags & SIGNAL_GROUP_EXIT) ||
> +	    current->signal->group_exec_task || current->in_execve) {

Well, the comment doesn't explain why should we care about exec or coredump,
if we forget about the problem above fatal_signal_pending() must be true.

At least, can we move these additional checks into create_io_thread() ?
To not uglify copy_process()...

Hmm... get_signal() sets PF_SIGNALED before it checks PF_USER_WORKER, so
perhaps something like below can work?

And perhaps io_should_retry_thread() should check PF_SIGNALED too?

Oleg.

--- x/kernel/fork.c
+++ x/kernel/fork.c
@@ -2700,6 +2700,9 @@ struct task_struct *create_io_thread(int
 		.user_worker	= 1,
 	};
 
+	if (current->flags && PF_SIGNALED)
+		return -EINTR;
+
 	return copy_process(NULL, 0, node, &args);
 }
 

