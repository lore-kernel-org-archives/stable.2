Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E843C872B
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700687; cv=none; b=ZQEgI87mJAdx+UpONa9hwiYyewTie0jiiOb+E+VL/K37is41m0P/MeqmiReaM2fCb3pZTNjmBD3+49YqARJURwwniC3dacYqMlzVjerJPl4QsBEUDcDJpiXr051YotiTuUoXVmczykLHfC+VqvRqdUHRK4fRkwUxPOlG35BqW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700687; c=relaxed/simple;
	bh=1cXTyKrezTAFARLoZb9kc8FQy5G+fRHkjI/Bk80wyrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jURlCtyUOtpmytDSDYhG68J9lk/VeSv2l5J8ofU3WAJxqdFRTXlLumU4KCpW0Y0kO2qyyqrfasbv4ISzo0dehJghQq/nz51xxRwt4hJnQ65h9t8LssxGcdyKpkQQ9td+vQ5/iw62UgXZZxNtv+bHhvkcvWG908qiVf/hj0oCtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diCZxxsj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diCZxxsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788700684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TD92eCESGEn8DzPNc3JWo4V4tBuaFy4JtD+w3RW1fw=;
	b=diCZxxsjgIr+TFXSLsstbRGBc/t4iYJ/LAv96VmY+KxrGEgqtPoohHBIuFWsrSAU8nZ3tx
	DkkbLgWkSdhUJdDq77wLZsiOBt/r1ODsCGW/MX8J77yVN0t8MJcGMG9TauQ+KGLYgi6HQy
	vumKFVWh/PLPkaE/3XZBcWt4/8yj5ls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-7Ix9_Wu9NZqFOPeL_yDHTA-1; Sun,
 06 Sep 2026 09:18:03 -0400
X-MC-Unique: 7Ix9_Wu9NZqFOPeL_yDHTA-1
X-Mimecast-MFC-AGG-ID: 7Ix9_Wu9NZqFOPeL_yDHTA_1788700681
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E76411955E97;
	Sun,  6 Sep 2026 13:18:00 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9CAE4423;
	Sun,  6 Sep 2026 13:17:56 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  6 Sep 2026 15:18:00 +0200 (CEST)
Date: Sun, 6 Sep 2026 15:17:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <ap1oA1MDAHnBz0N4@redhat.com>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905185839.667208455@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 09/05, Thomas Gleixner wrote:
>
> +/*
> + * Find the target task for the POSIX timer signal and prevent that a
> + * PIDTYPE_PID signal is queued on a task which has PF_EXITING set.
> + */
> +static inline struct task_struct *posixtimer_get_unignore_target(struct k_itimer *tmr)
> +{
> +	struct task_struct *t = posixtimer_get_target(tmr);
> +
> +	if (t && task_can_queue_signal(t, tmr->it_pid_type))
> +		return t;
> +
> +	return NULL;
> +}
...
> @@ -2136,7 +2183,7 @@ static void posixtimer_sig_unignore(stru
>  		 * has exited by now, drop the reference count.
>  		 */
>  		guard(rcu)();
> -		target = posixtimer_get_target(tmr);
> +		target = posixtimer_get_unignore_target(tmr);
>  		if (target)
>  			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);

Not sure posixtimer_get_unignore_target() makes a lot of sence...
It has a single caller, and posixtimer_sig_unignore() can do

		target = posixtimer_get_target(tmr);
		if (target && task_can_queue_signal(target, tmr->it_pid_type))
			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);

But this is cosmetic and subjective. I believe the patch is correct.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

