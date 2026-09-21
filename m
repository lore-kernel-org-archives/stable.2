Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E34A3F34
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000786; cv=none; b=LEaFbYOuCKjrjnryW9Mnh0G3KR3PgrBLnQnSrSTZSSpI6g3CqMQnYNUiQeLRfeKwS9YGk7lPZCAZn4rvqyzgbNl5nQ+3Bs57gtKMH66+PruYqROeKRdw8GASNLO5Xep9zeF/l32n0CFKVqfIT2eF8hyQmkBf4KEfO3smVknfRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000786; c=relaxed/simple;
	bh=MyEXqmotfUt4yA1+Hy68CC39XSg+h8EY6D6AQC+ntwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUgaZjuXWbkDIwAHGQ5bh7RQwn3MwQWiOfWG42Dou0M/0npgBry3R6GWYDfuPtyMkdVpuIdvIKaG/1tqGPYi2IiGfuESBFrnvBl1R2DBJcaq0wvibR9qIQL7bRxMwtoTaAloxDnr7zHQh1l6yddl0+d3fZDoOzR80wU4gldNDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIgEZylw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIgEZylw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790000783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pcLJlj5TIE0odij7lPFRE58kbHckgF1Zqih4BUaQQ8=;
	b=UIgEZylwudvfLCjWM4qid+3+APf+RC8fybWBm+MzuhlMGPpmQS+SjGMRolz1i/J8MEZmhu
	yrt6m1KK/Q5EV+sNyFwAnIxXP+VWvbutmYyarADMwJ6gVVemjPIuVDulVVgSS0RQ7cwMPr
	0lxGNbEBlSYpThulXsB0DO8ANFL1apc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-zIc0_6r3NoSA_cJqD0Vc_A-1; Mon,
 21 Sep 2026 10:26:18 -0400
X-MC-Unique: zIc0_6r3NoSA_cJqD0Vc_A-1
X-Mimecast-MFC-AGG-ID: zIc0_6r3NoSA_cJqD0Vc_A_1790000776
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 422C11953994;
	Mon, 21 Sep 2026 14:26:15 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5D11B41D;
	Mon, 21 Sep 2026 14:26:11 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 16:26:14 +0200 (CEST)
Date: Mon, 21 Sep 2026 16:26:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 14/17] fork: don't create io threads once
 PF_POSTCOREDUMP is set
Message-ID: <arE-gZw53CqPTRXP@redhat.com>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-14-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-work-coredump-fixes-v3-14-8e4adb1619e6@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 09/21, Christian Brauner wrote:
>
> Refuse to create an io thread when the creator has PF_POSTCOREDUMP.
> That costs nothing. io_uring_files_cancel() raises IO_WQ_BIT_EXIT
> before it runs any task work, so a worker created from there only ever
> gets to exit again, and io_should_retry_thread() doesn't retry -EINTR.

Thanks for this note in the changelog,

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2706,8 +2706,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  		.user_worker	= 1,
>  	};
>
> -	/* A creator past its fatal signal gets no thread. */
> -	if (current->flags & PF_SIGNALED)
> +	/* A creator past its fatal signal or its coredump point gets no thread. */
> +	if (current->flags & (PF_SIGNALED | PF_POSTCOREDUMP))
>  		return ERR_PTR(-EINTR);

Acked-by: Oleg Nesterov <oleg@redhat.com>

