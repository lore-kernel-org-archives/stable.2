Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA9390CA3
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738923; cv=none; b=gvipPNNdZo5/vvfiswETFHak1Ho5C+FHHJgSs7uBpLUFnYjUGlRr2EnFnMz2OjGjMJJC4VPOo3xeJVKZKmofrr2XuUfSBdr1QpRHdfFGzSRGJr8e+toZ8QF7AgtfPsX/buWg9eYWPTnUOmJtSN6CrdHOZcuTziBoZ4CPft7SF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738923; c=relaxed/simple;
	bh=sNMGJrjxGOQII/cy/jQVIut5noFDYuUvTYdYnxLVNGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX5FALrVqwkRaRSj1OV0yNhTIH2CyfhddwBeds1JNAWK/0unkyFoNi5mOe89EM+87IjtvMpQrzqvLWmh/C3Du9Yh5/tpHOf8b6Dc3WH8TE/zvwTmlwqbvLi5fxjtKylQVngK/fbLuBBHC237pGLn/VvvlobFsK/T6kZO284TGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eE57TEMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE57TEMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789738916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1G7pn6seS/SOuHvOw8pJc1Knwr72Zy5SeN7YDV021M=;
	b=eE57TEMY0Hnxhv725LtZoLR2KolpL+rWSryBDsatNvaPYUbseaAsY4o0fUhlOAkO0Y6D08
	1gMo4MZbAszRrHQNttFHCWTQyiq17+zp1V8HNfGcrL4gdh/nMrGM1D4XDakyIPezVx+5Gc
	c04acpZk6H6eVtOiwxbJ7caOIIwh4OE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-H0K6Lj2APcaU4-gCZgc4kA-1; Fri,
 18 Sep 2026 09:41:50 -0400
X-MC-Unique: H0K6Lj2APcaU4-gCZgc4kA-1
X-Mimecast-MFC-AGG-ID: H0K6Lj2APcaU4-gCZgc4kA_1789738909
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D66E819776A8;
	Fri, 18 Sep 2026 13:41:47 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3B334180034C;
	Fri, 18 Sep 2026 13:41:44 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 18 Sep 2026 15:41:47 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:41:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <aq0_lvHDViIpX_Mu@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/18, Christian Brauner wrote:
>
> I think this works but they also need to check ->in_execve as the
> exec'ing thread is obviously never signaled:
>
> @@ -2709,6 +2707,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>                 .user_worker    = 1,
>         };
>
> +       /* A creator past its fatal signal or in execve gets no thread. */
> +       if ((current->flags & PF_SIGNALED) || current->in_execve)
> +               return ERR_PTR(-EINTR);

Ah, I forgot to mention...

Can we shift io_uring_task_cancel() up, after setting bprm->point_of_no_return
but before de_thread() ?

I know nothing about io_uring, not sure this would be enough...

Oleg.

