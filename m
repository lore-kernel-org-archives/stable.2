Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1043AEF35
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791025631; cv=none; b=plcN14rOp9XYr+KGGajanULfj4WmKzHHSch/ecLp3cmYfmJ/jKo1+Nft+Iyny+1EO8dC29kqYEkzdBdRulZv9IPFy52sH59ujxPtqFpayWWrFPt69yY7Ma5R/IPx3h9ggMSgw8HqyCiXMRxVUAphTYapGB06dcrGYk0WU8o9Dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791025631; c=relaxed/simple;
	bh=hWDUZARlq4vDyxL8gZNwQrCt52jPkXr50aadlzHM8aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6g4Xl8GClCXupT8ThR7psqpqkL2weUSgwSOaYLZ+JZGvSzf1gu4G5fO0I3Y5+RkWNsu4WbTy+yu4p++m4bTJ8+ZBnsNjtEe1epsEzwmxL+2PoqLSIVKQrN2Nb/J8hof3kbLBf1iYpZ9vdpBEUBrRVizARk210DxlyfiRVnw0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SldABLOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SldABLOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791025628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NaIBcD/hC1GVFenfbiP3xESvJltZa3E3pEsPaq2E8qE=;
	b=SldABLOtvNc2YXSREIMhlGQtBY8ijALoehqRGOdRq9hdrEubouSiBWbMmSfWbzpxrVaJEw
	wiKnOjXaYu3cbnzD1KKKOfSpNrZABUxD7Qn8lrly64SdKHqyPVLXqpVCHEWqM+bNkOwXIo
	4mQ5RDQhn61RlLFY9HhltYAWdWSxiCY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138--AaLEvuzMzehhK0TrTqqCA-1; Sat,
 03 Oct 2026 07:07:04 -0400
X-MC-Unique: -AaLEvuzMzehhK0TrTqqCA-1
X-Mimecast-MFC-AGG-ID: -AaLEvuzMzehhK0TrTqqCA_1791025623
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CC0C1828B4A;
	Sat,  3 Oct 2026 11:07:03 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4121F1800576;
	Sat,  3 Oct 2026 11:07:00 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sat,  3 Oct 2026 13:07:02 +0200 (CEST)
Date: Sat, 3 Oct 2026 13:06:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Aviv Vaknin <vaknins33@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Bradley Morgan <brads@mainlining.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] pid_namespace: make zap_pid_ns_processes() freezable
Message-ID: <asDh0zBHEIWdto5x@redhat.com>
References: <20261002202820.3433318-1-vaknins33@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002202820.3433318-1-vaknins33@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/02, Aviv Vaknin wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1751,7 +1751,7 @@ static long do_wait(struct wait_opts *wo)
>  	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
>  
>  	do {
> -		set_current_state(TASK_INTERRUPTIBLE);
> +		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
>  		retval = __do_wait(wo);
>  		if (retval != -ERESTARTSYS)
>  			break;
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 8bc9edb40..127a5fd23 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -269,7 +269,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	 * free_pid() will awaken this task.
>  	 */
>  	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> +		set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		if (pid_ns->pid_allocated == init_pids)
>  			break;
>  		schedule();

Thanks Aviv,

Acked-by: Oleg Nesterov <oleg@redhat.com>

