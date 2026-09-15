Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DE3D952F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484579; cv=none; b=pqblmhy0fYHg4bc/OM3Nn6rdl4VyJX6RVf81rQv5HObUBsaUjPIfNEfaQ5IB6SWgIgNHCPtrc0bU1OHgDtYWzHsX3fEO8WdjtUJn+R0XLJ4CzScx8/voblEcmPLfayUfqZW+LoaXuXN7FXCkm8AqpS2ejjiHWoL5bdohizE0IAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484579; c=relaxed/simple;
	bh=yL9gjDzcdbDEXhuKZE8yM1jk8TwvDCeRrm+Vd8ZiE5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Htye+5cphVv04jWE0LaTQ610BugNoCDan6NCZmjVVbkOcWmDbr4zliIHO788FdG6x3rIX6OhnxF2nYHb+ZnSVGOA8isAnEx0X8XGz36R+jhwUP+DqMOItzrgvKYzmw7pb3+B6QbGmQ1TBf0lLdDVJ5udqJm85MT8o10Bz5jywcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOFclMoH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOFclMoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789484576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YHyk6+IrqQOJoNBANVy6H3eTJp4wkRbqnNOpZl37PNY=;
	b=VOFclMoHeQEdpX4T+d+05MVQnRqbvaueNPqsqrBFcJI25Z27BFUs5FbmsWvEGP61hs4oED
	2y5JHWksKuZfrpSWcNEVtB+qzi5KTsyp4X7CU/IHA5jm0VEY7AYWgiVAGRvVZvyVYPQv5F
	lyRTmpcsWFq1FXE2hrQCB+KR/y85elQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-t8xWsI1wOhS3uKw5owlbRQ-1; Tue,
 15 Sep 2026 11:02:51 -0400
X-MC-Unique: t8xWsI1wOhS3uKw5owlbRQ-1
X-Mimecast-MFC-AGG-ID: t8xWsI1wOhS3uKw5owlbRQ_1789484569
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52A711955E91;
	Tue, 15 Sep 2026 15:02:48 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9361195604C;
	Tue, 15 Sep 2026 15:02:44 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 15 Sep 2026 17:02:48 +0200 (CEST)
Date: Tue, 15 Sep 2026 17:02:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/6] fork: refuse new threads while a coredump is in
 progress
Message-ID: <aqleExxTBcHsonQe@redhat.com>
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
 <20260915-work-coredump-fixes-v1-2-f354ca41780c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-work-coredump-fixes-v1-2-f354ca41780c@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/15, Christian Brauner wrote:
>
> Say a SQPOLL thread is a member of a thread-group that coredumps.
> The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
> thread uses io_sqd_handle_event() and calls get_signal(). It removes
> SIGKILL from the pending set and returns. The SQPOLL thread breaks out
> of the loop and drains its own task work.
>
> Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
> worker when no other worker is free. So it ends up calling
> create_io_thread() from a thread whose fatal signal is gone. That means
> copy_process() allows the creation.

Hmm, thats bad ;)

But then ...

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2491,8 +2491,8 @@ __latent_entropy struct task_struct *copy_process(
>  		goto bad_fork_core_free;
>  	}
>
> -	/* Let kill terminate clone/fork in the middle */
> -	if (fatal_signal_pending(current)) {
> +	/* Let kill or a coredump in progress terminate clone/fork */
> +	if (fatal_signal_pending(current) || current->signal->core_state) {
>  		retval = -EINTR;
>  		goto bad_fork_core_free;

this change is not enough? Don't we have a similar race with exec?

de_thread() kills all other threads and counts them too. Shouldn't it
also check signal->group_exec_task ?

Oleg.

