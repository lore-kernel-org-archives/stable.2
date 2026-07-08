Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399E4C955F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535738; cv=none; b=PMcegWCEUGhnen7k9+fNlq7YrFXManid5dHxRSOFdELeLmJBSIKYR9IYTe3OFNcArR1YV4JttyE5Pfl7u/hCUFj/U4JmRX/bZvoTIpinLPNPaHUNHYYoXymPg2/AYm7jwBoWRVQY/0y44kaPV1on9y8ufwnO5m1ASBmPo+qfegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535738; c=relaxed/simple;
	bh=cR0sI4JX7X5rTmm87aZaAf6gDZhWgglYVWhHlvHHkbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avXX/+kJoz72X03VyafNm1acjkJ0VwG+g2f5nWCzf1xhGeMDINosdqsxQNTTAwBDrClwMKLSgWH7EpaczdXc+PflUqkDbdy1E8PNAznqZ/FhKER3xFJSm09oLp4k7XhuRSOEzkWA0KEXz8acxMY0a/2QKQD+pMy2loiiuo+184k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DP/abv3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP/abv3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783535736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cR0sI4JX7X5rTmm87aZaAf6gDZhWgglYVWhHlvHHkbQ=;
	b=DP/abv3rCS3+JCsNGy2haQWMuz0ZL79HvWgBK0fwd2HfzFh8FGO3MXzV+ELD24rVTNZNFb
	5tjhfTo+4u3fzZeVunm6c1aETjESqnlkJmPHUsuonHqjJe3qwgn56LtqjxJMdpe5ukhSou
	TC8uOnlmadzIakpMdYYXE968zporl+4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-KxgXL-nBPMuHfofScI0D1g-1; Wed,
 08 Jul 2026 14:35:33 -0400
X-MC-Unique: KxgXL-nBPMuHfofScI0D1g-1
X-Mimecast-MFC-AGG-ID: KxgXL-nBPMuHfofScI0D1g_1783535731
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CAD91800609;
	Wed,  8 Jul 2026 18:35:31 +0000 (UTC)
Received: from fedora (unknown [10.44.33.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A151B1800370;
	Wed,  8 Jul 2026 18:35:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Jul 2026 20:35:31 +0200 (CEST)
Date: Wed, 8 Jul 2026 20:35:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Wongi Lee <qw3rtyp0@gmail.com>,
	Jungwoo Lee <jwlee2217@gmail.com>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: timers/urgent] posix-cpu-timers: Prevent UAF caused by
 non-leader exec() race
Message-ID: <ak6YbiubLDabNCyT@redhat.com>
References: <178324479651.744054.11944477307374142373.tip-bot2@tip-bot2>
 <ak51mpHPzsQrGFmv@localhost.localdomain>
 <ak5-L-1SzGPEc0_i@redhat.com>
 <87v7apqrx8.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7apqrx8.ffs@fw13>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/08, Thomas Gleixner wrote:
>
> On Wed, Jul 08 2026 at 18:43, Oleg Nesterov wrote:
>
> > On 07/08, Frederic Weisbecker wrote:
> >>
> >> > There is a similar problem vs. posix_cpu_timer_set(). For regular posix
> >> > timers it just transiently returns -ESRCH to user space, but for the use
> >> > case in do_cpu_nanosleep() it's the same UAF just that the k_itimer is
> >> > allocated on the stack.
> >>
> >> do_cpu_nanosleep() only targets current and since it's on the stack, no
> >> other task can access it. And the current task can't be exiting/exec'ing
> >> while calling posix_cpu_timer_set() on that stack timer.
> >
> > I thought the same initially, but it seems that this is not true...
>
> Indeed.

OK,

> > Or why else we have clock_getcpuclockid() ?
>
> To express which thread or thread group the sleep should be on. It's
> exactly the same as timer_create() + timer_set(). It sleeps until that
> clock accumulated enough runtime, while regular posix-timers either wait
> for a signal or handle it async.

This is what I tried to say, sorry for possible confusion.

Oleg.

