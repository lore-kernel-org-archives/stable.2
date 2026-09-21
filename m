Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA1371D11
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986771; cv=none; b=JDJcA7AJW1GiRoz9uPdlt6VpAmoG5ltzWErwlqJNrjOWOrMyBv0ebeeJYCqpBJJAUUoRrit5G+uEBCLZNxiSW+RW94lJofCpfOQDSw9k85z+6FRHPpuq8qDgmd+LuLTFkDoAGUM704Cyxc0aeJaDOpFLkxn81tPMFw3aiwJl/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986771; c=relaxed/simple;
	bh=KZadSeZqephBsHbVNXtBZ0HEkwYoNYgIbKhAcKBhmFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq9jo0SnUsTEaqCrMg7oB36Zl9SgAE8NwiJPTb/In1Gx55IfICvmGX1tAbbDSQNv/2iCUVFsetRqlUuWauMzQFoWnXC9wcU8z+uWSmDwO5OocJeyjG4zbUu4bmG9ok+aFBQXM57XqSIPdnGun4FcviH+xlxBiaIljFdENPfmsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJvUOLWe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJvUOLWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789986769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dfX0uPkgOugVML85bBzWDMFZaOWExPaUKgWWIP1kWE=;
	b=QJvUOLWezEyRYOG9bqB4jaYuJpXmaI+Oqp4Zpz7ZUXGKNRjjPiDzxI25OVVeXAon4YOMwi
	FuDKr80JqrerZYat0lffDqyQ81JNSuoU8dH/geHxF+A5gGOfRZlkD1w3idL9B4TDCeh0Zh
	I4unqHdQNGg8IraWpNlBbODyY6fAF3U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-EiUlTb4tNzuHYTvdF1LTDQ-1; Mon,
 21 Sep 2026 06:32:45 -0400
X-MC-Unique: EiUlTb4tNzuHYTvdF1LTDQ-1
X-Mimecast-MFC-AGG-ID: EiUlTb4tNzuHYTvdF1LTDQ_1789986763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 509D71801BF4;
	Mon, 21 Sep 2026 10:32:42 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5FBDD1956041;
	Mon, 21 Sep 2026 10:32:37 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 12:32:41 +0200 (CEST)
Date: Mon, 21 Sep 2026 12:32:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <arEHxPFFrRtvUSPJ@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
 <aq0_lvHDViIpX_Mu@redhat.com>
 <20260918-elstern-potenzieren-marotten-71ebd0744753@brauner>
 <20260918-oliven-lebst-wohltat-c633868711f1@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-oliven-lebst-wohltat-c633868711f1@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/18, Christian Brauner wrote:
>
> zap_process() skips every thread that has PF_POSTCOREDUMP set.
> do_exit() sets PF_POSTCOREDUMP in synchronize_group_exit() and calls
> io_uring_files_cancel() right after that.
>
> That runs task work, create_worker_cb() runs and creates a new io-wq
> worker. If a thread started a coredump rgith before that worker gets
> created from a thread with PF_POSTCOREDUMP set which zap_processes()
> doesn't see. So two ways of fixing this:

Christian, I got lost ;)

TBH, I don't understand why the new io worker is really bad in this case.

But lets forget about coredump/zap_process. With the change below the
io_uring_files_cancel() paths will no longer be able to create a new
worker, even if coredump is not in progress.

Is it correct?

Oleg.

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2707,8 +2707,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>                 .user_worker    = 1,
>         };
>
> -       /* A creator past its fatal signal gets no thread. */
> -       if (current->flags & PF_SIGNALED)
> +       /* A creator past its fatal signal or its coredump point gets no thread. */
> +       if (current->flags & (PF_SIGNALED | PF_POSTCOREDUMP))
>                 return ERR_PTR(-EINTR);

