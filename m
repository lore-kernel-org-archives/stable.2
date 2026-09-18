Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37448C41F
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743355; cv=none; b=oRaHr8pAOWF+XMHq4pnoAVLI/1FZgMx3aozl8F0IE33gL89eLVMGwG8tgFiL7q7Au2+N0Z1Oz8l+aKo4uUh7w5073XXwTajdzT4miC1wu5WaJgi4ncUr6Ke6xzvs7PLS75ERK+wyhFy7TJnZfGEm10P/LkmYxxTxD5PDXX0LZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743355; c=relaxed/simple;
	bh=SEltdDyfocBjIbVQfU9Lz5DYNVbfP/4uaiY3W6LZcdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZRQTK54SIJGAEGpUV3XLHfjBhv3WptDwOX3IXa6bULwNsWL/WVPer2+woRyc7kUp/wKU5KOY6In1XyncfmOwXwwPNw//XvjvPEbIFYi4kAmJuEkre0KbMkg4qYX7RTvhCCO/mR3oik4ntG9/yAI+yqhltlX7vdyu6qujIdCm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dss5sRPT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dss5sRPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789743351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=193Eukm5kz/lh19QRcN0hlB5xjOPp1QwF8rk3uoxO/g=;
	b=dss5sRPTVf/awXGvJTH9LgqpD8cV8gZ0KNlhuWBjj6NXAWhuk3V+VYGnBD5fHMHH9ZPuOF
	6U+E3wdrL513R5V6AQkpppVmoWHE6ypoKrAp0thgLbqgFGYanvGiFUoP1Y4WKK8G2vZSKI
	0l1brpJFwZfyE3TnFEDUyT9BwD+BzfQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-2AFqT8aRN9WgKt31jB8-4Q-1; Fri,
 18 Sep 2026 10:55:47 -0400
X-MC-Unique: 2AFqT8aRN9WgKt31jB8-4Q-1
X-Mimecast-MFC-AGG-ID: 2AFqT8aRN9WgKt31jB8-4Q_1789743345
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49CBC1935DC9;
	Fri, 18 Sep 2026 14:55:45 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 61DD01956095;
	Fri, 18 Sep 2026 14:55:41 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 18 Sep 2026 16:55:44 +0200 (CEST)
Date: Fri, 18 Sep 2026 16:55:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/7] io-wq: order the exit bit against worker creation
 task work
Message-ID: <aq1Q652euXxJVf36@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-5-f3787fcda051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-work-coredump-fixes-v2-5-f3787fcda051@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/17, Christian Brauner wrote:
>
> --- a/io_uring/io-wq.c
> +++ b/io_uring/io-wq.c
> @@ -1324,6 +1324,8 @@ static bool io_task_work_match(struct callback_head *cb, void *data)
>  void io_wq_exit_start(struct io_wq *wq)
>  {
>  	set_bit(IO_WQ_BIT_EXIT, &wq->state);
> +	/* Pairs with task_work_add() in io_queue_worker_create(). */
> +	smp_mb__after_atomic();
>  }

Acked-by: Oleg Nesterov <oleg@redhat.com>

