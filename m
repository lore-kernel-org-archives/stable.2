Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5424C2242
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951188; cv=none; b=OxEvhUFTT2UGVBj61UkFT8CmIq/IM83EYX/Tu/4ygON9Xyi8T+DapbxRJ5aB0otVEpTFsT7h+y1zoQsqgmB1ZkzA9lCFFeZArIhKpIc95yyNMl0wYd2H6dvhCLixVWeG2YEgGCgB4OOyul8nVvBoYpIFJJV0fddOsj7jqq89urI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951188; c=relaxed/simple;
	bh=PbsiIeWzpYJ48wASnRqP4OeKBqhdqKTiiSGy443qL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hjq8NunPElup51BrdeybjyO5AaWdRdUsGzRIugiYjlJZCFXY8aapmc49bVpkIIxwKBbBtNtjN/KDC3LmNyMib0vMKPRWDjrCkvDONo2RFfdB7/XDbv13QRVc/VPrUrKAWbbSQTSLYWEAQfNOL54BJBD35Jliyeov5I26IdHq5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTVvgg0G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTVvgg0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790951185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMbn9GyMJX2ye19RxY34Y+M9r3F2OOFTFH8nBqhUXD8=;
	b=TTVvgg0Gx6heJBkPG2E3sgX39pwLtEKCqGXK2MpB+o2YnUOIkrzBIx4shI1V5B5Fb6VRN3
	BneuLzOlS3tie93Hgl+irVMJSkoL5lUyt398N8zXSHRxIF/mpkwPVz0nLITduThVE3Dl/D
	IL/hIrrKq2whzKfaGWvHF98mW2E6L1s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-EyzbVaSlOOafxjQdgjdVEQ-1; Fri,
 02 Oct 2026 10:26:19 -0400
X-MC-Unique: EyzbVaSlOOafxjQdgjdVEQ-1
X-Mimecast-MFC-AGG-ID: EyzbVaSlOOafxjQdgjdVEQ_1790951177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22F531905617;
	Fri,  2 Oct 2026 14:26:17 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9B0661956086;
	Fri,  2 Oct 2026 14:26:13 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Fri,  2 Oct 2026 16:26:15 +0200 (CEST)
Date: Fri, 2 Oct 2026 16:26:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Aviv Vaknin <vaknins33@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
Message-ID: <ar-_BMp5cuPwDw5J@redhat.com>
References: <20261001121254.883973-1-vaknins33@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001121254.883973-1-vaknins33@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/01, Aviv Vaknin wrote:
>
> Fixes: 3eb07c8c8adb ("pid namespaces: destroy pid namespace on init's death")
> Fixes: b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in zap_pid_ns_processes")
> Cc: stable@vger.kernel.org # 6.1+
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Aviv Vaknin <vaknins33@gmail.com>

OK, since Rafael agrees with this patch

Acked-by: Oleg Nesterov <oleg@redhat.com>


but see below...

> @@ -243,6 +244,11 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	do {
>  		clear_thread_flag(TIF_SIGPENDING);
>  		rc = kernel_wait4(-1, NULL, __WALL, NULL);
> +		/*
> +		 * The freezer's fake signal ends the wait with -ERESTARTSYS;
> +		 * freeze here, or one stuck pid namespace blocks suspend.
> +		 */
> +		try_to_freeze();
>  	} while (rc != -ECHILD);

Somehow I still think it would be better to change do_wait() to use
TASK_INTERRUPTIBLE | TASK_FREEZABLE. Slightly less robust in theory,
but I think should work in practice...

Rafael, what do you think?

>  	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> +		/*
> +		 * TASK_IDLE: no hung task warning or load for a wait that can
> +		 * last as long as a tracer keeps a zombie, and a pending signal
> +		 * (e.g. the freezer's fake one) can't turn it into a busy loop.
> +		 * TASK_FREEZABLE: let the freezer freeze us while we wait.
> +		 */
> +		set_current_state(TASK_IDLE | TASK_FREEZABLE);

This looks like overdocumentation to me. I guess it was added by AI. Other users
of IDLE/FREEZABLE do not try to document the meaning of these task states.

But this is subjective, I won't insist.

Oleg.

