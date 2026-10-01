Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B3530DF0
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868932; cv=none; b=L/1L98r40jCHQG1V4fW4VVeln0skTHIj12wo1DNyEpElttdC51TUQku/F56y5ujvXDLlvWABEvwm44Yaakad+4Q4x66OUJi+itfd4MwzPzxiDwXPySa86eqoNkkdzexSEhvkbfOusmjDKg99yB6feHyBE0KhfQA9Q7XcoxGwkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868932; c=relaxed/simple;
	bh=kjrBaOIQzRodXYyVE29/glCVcdUU681z5IQunrw2auU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhPxIR3amhrqQhRkdzqy+RiHiIOPu7Uz+Qaer/K3zC8jcrufpHQyYNZD6kAoKs6b6QxHTxmwxhnBLylkWBHnnbFU/r/FEGmo7nxf+V3LVpnL4A85C4tJJaeu2K1DM/bqBc44cyxVoGAeIiLnprK8htoK1NN/Ua4eO/8EwZECeqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDQcMqrA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDQcMqrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRkuIUECUxJhe8ANm3v3u37Ui3/ef2M1wF0nlt+w2i8=;
	b=fDQcMqrA2SPr3+kyTkdPQCvk56jwhNfgH/nEHBEWZOP0rL0B42fQa5S4udSYmoScNctYbs
	lNqZaqOpe/ZHJZWOJIvvgactnF5Ga78SaE3TN1X/eMeoaaA3z4ZcVVKyATErgWQViD/JhE
	lN5gfaHtjMBP1XKLRNSr+AhYsV6YihQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-nz2JhCNpPSGjempuhP8A-Q-1; Thu,
 01 Oct 2026 11:35:26 -0400
X-MC-Unique: nz2JhCNpPSGjempuhP8A-Q-1
X-Mimecast-MFC-AGG-ID: nz2JhCNpPSGjempuhP8A-Q_1790868925
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AA1D1955F0B;
	Thu,  1 Oct 2026 15:35:25 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CF38E1800361;
	Thu,  1 Oct 2026 15:35:22 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu,  1 Oct 2026 17:35:24 +0200 (CEST)
Date: Thu, 1 Oct 2026 17:35:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Aviv Vaknin <vaknins33@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
Message-ID: <ar59uapn1SrPXlWe@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Aviv,

Thanks, at first glance your patch makes sense... but for some reasons
I can't read the source code today and perhaps tomorrow.

let me ask a couple of questions right now.

On 10/01, Aviv Vaknin wrote:
>
> @@ -243,6 +244,11 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	do {
>  		clear_thread_flag(TIF_SIGPENDING);
>  		rc = kernel_wait4(-1, NULL, __WALL, NULL);
> +		/*
> +		 * The freezer's fake signal ends the wait with -ERESTARTSYS;
> +		 * freeze here, or one stuck pid namespace blocks suspend.
> +		 */
> +		try_to_freeze();

Well, I don't really like this another callsite of try_to_freeze(). Perhaps
we can change the kernel_wait4() paths to use schedule(INTERRUPTIBLE | FREEZABLE)
instead? Not sure, please recheck...

>  	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> +		/*
> +		 * TASK_IDLE: no hung task warning or load for a wait that can
> +		 * last as long as a tracer keeps a zombie, and a pending signal
> +		 * (e.g. the freezer's fake one) can't turn it into a busy loop.
> +		 * TASK_FREEZABLE: let the freezer freeze us while we wait.
> +		 */
> +		set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		if (pid_ns->pid_allocated == init_pids)
>  			break;
>  		schedule();

Looks "obviously good", but I need to recall why this code uses TASK_INTERRUPTIBLE,
not TASK_IDLE.

Oleg.

