Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438107;
	b=UY4cHkdUuudcmQwOCx8GomdNpfg/TgL8/CPwWzNrYefYZzo6xQLSGGzYh42Gk08ioXqd
	 FYFj0wItq5Dlq8LAefE6Sam2jFUQEmOarYkcGC7jSqOWDqiuNzqvI4ixJRq5o8sScSNfw
	 qOPVJEIqV2HTcthd36caA/oO+5eZhm2OnlWwETJBNbqoDXJz/mubiGv9lprQomTM5r5UJ
	 EqiMhagyd4CdTw3VLEvMDDqnoygRNWZwDXERWJT69Jfrx7/dp5ed09bvtFjnQjAahSOBU
	 j15PwrSnl35CI2qligIaNoGRGZ/fi5CdeKSQiRvKHdns4LOsh28q1pn6TWc9oYAdprQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438107;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=wj6qsWXGoJ393cS9Xlx1U/BYTtbd972bohi7Obe4yhA=;
	b=MdNLvXPnqUTJ+eNkr+nm+ofPh2LXilMB++uR3gh/myQhcenzJ8Lk5XlUszADWVwEKRmC
	 oVUrwWlClRRFEaXR1efdHtDuoB96B1RKk6Uhv94pZrv2CSqlFJPEw8d1hZWpLJWqzRttY
	 T+9di0HP1RRRtnQ43BaIqmkWVtBwjhdAdeD6iWHTOGinPOLZIZQrMg2TSozV8FDBrjxhQ
	 gL+eWzIHNBOx21+Ux1uI97I6YwyT2ggVByebMLVNB5S3x9Pd1XSsrYWcQtWiZ+8ibYn2f
	 HppmsxkmVsEQboZYmvj4HMu1MGmV2Ro22CewJ9SZTR88/PRmgi37e2evUIkPjTgC11Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MvhzWRa6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D060A2619
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED9D060A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MvhzWRa6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794438106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wj6qsWXGoJ393cS9Xlx1U/BYTtbd972bohi7Obe4yhA=;
	b=MvhzWRa6CxIyw8RcXYZWBtWEP8d+FaOLRY7Yj+cGsQUwd9RiIzFQ75zG6FPExdtuv4Z/TN
	NQQFojrYTOKFc10pKvQ01tAdFxIGFJjIJCuSb0DKJyivf8gWgMFugStr/aUgO7qCfHPUAU
	Klx4NgvoiPVMYE2qjUX0BHtio+f5Duc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-yazoqcCZMMyfwaVL55ieTA-1; Wed,
 11 Nov 2026 18:01:42 -0500
X-MC-Unique: yazoqcCZMMyfwaVL55ieTA-1
X-Mimecast-MFC-AGG-ID: yazoqcCZMMyfwaVL55ieTA_1794438100
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 229991801313;
	Wed, 11 Nov 2026 23:01:40 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 01DC41800495;
	Wed, 11 Nov 2026 23:01:36 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 12 Nov 2026 00:01:39 +0100 (CET)
Date: Thu, 12 Nov 2026 00:01:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org, Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] sched/wait: Queue non-exclusive waiters at the head in
 do_wait_intr*()
Message-ID: <avTzzxZvE3HqH3KS@redhat.com>
References: <20261111-b4-sched-wait-intr-head-v1-1-17cf2af5b964@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-b4-sched-wait-intr-head-v1-1-17cf2af5b964@columbia.edu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/11, Mani Tofigh via B4 Relay wrote:
>
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -319,8 +319,12 @@ EXPORT_SYMBOL(prepare_to_wait_event);
>   */
>  int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
>  {
> -	if (likely(list_empty(&wait->entry)))
> -		__add_wait_queue_entry_tail(wq, wait);
> +	if (likely(list_empty(&wait->entry))) {
> +		if (wait->flags & WQ_FLAG_EXCLUSIVE)
> +			__add_wait_queue_entry_tail(wq, wait);
> +		else
> +			__add_wait_queue(wq, wait);

This look right and matches prepare_to_wait_event(). But it seems there is
another problem if WQ_FLAG_EXCLUSIVE, see the
"Exclusive waiter must not fail if it was selected by wakeup" comment in
prepare_to_wait_event().

Perhaps it makes more sense to simply kill __wait_event_interruptible_locked()
and reimplement wait_event_interruptible_locked() on top of
___wait_event(cmd => do_wait_intr) ? This way do_wait_intr() will only need
to do unlock + schedule + lock.

Oleg.

