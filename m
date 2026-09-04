Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D884189DD
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521720; cv=none; b=mMcir/6vmeN7I4ZFWDb0WQAvp55Rxq5c+0tcdRzH/mL+LoxUx4d5gsodvO7Sy0va1eKglFiVBOxClAdhHmSpUH5pKo5cyVaXISet2JGfouw9HrhyfhUNS4Bq1wwzQ5l/qLkDHRo4RtoxSJlQ3k4I0dpjOs4AEIIU7QGAzzlsEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521720; c=relaxed/simple;
	bh=JglLg/LgJp0dywx6AE5xoqogojkQHfa2ZApqxJ+SFZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keo/eySLJoBGAwaqqtnMTIyhDJz8MZ6Zmrskt5sr4eDVS4B9XP+BETrCDpMEF7BSnvYcHqEl/pA35f7UEobDtuj28PFbI1oHSKfHpxbSU4yy33j2hCNqiH95JQ8aHIAo9GhBK3m0ze+xT1iUfmFZz+HUZnYOdlp1iIF8C4aCQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSVN6i6p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSVN6i6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788521717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0MLdv5y2UxO/lkU2upp311RNrEDjChpWavqlsKcB0A=;
	b=RSVN6i6pPAmyzSuUq2uaf/n8zOrRLdBEJF9sh6eU4MUT3XV3MJKHVwdlSiahcxalqjDJ7P
	sGEQjAoMjzTFFq3IIVMAtm0QSsi9VAiWDOnyUIDPrzSf0CHL7RQC/L/OiIOn0gskdUkRD7
	+PWpbh9ew8PJnSMlIucFDKnF9W7n2bQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-bVnjE0JoP2u-GsRzfT9ZsQ-1; Fri,
 04 Sep 2026 07:35:14 -0400
X-MC-Unique: bVnjE0JoP2u-GsRzfT9ZsQ-1
X-Mimecast-MFC-AGG-ID: bVnjE0JoP2u-GsRzfT9ZsQ_1788521712
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C55991893EFD;
	Fri,  4 Sep 2026 11:35:11 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 508A218005BD;
	Fri,  4 Sep 2026 11:35:08 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  4 Sep 2026 13:35:11 +0200 (CEST)
Date: Fri, 4 Sep 2026 13:35:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch 1/8] signal: Prevent exec() race
Message-ID: <apqs6wgDtpdLI-k8@redhat.com>
References: <20260904112100.683893401@kernel.org>
 <20260904112202.074391651@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904112202.074391651@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Thomas, I can't read this series today, will try on Weekend.

But you didn't reply to
https://lore.kernel.org/all/apgHJj0qH7HlAXKO@redhat.com/
Let me quote that email here:

	OK... lets suppose the exiting task T passes exit_signals().

	Suppose we have an "ignored" timer tmr. Another sub-thread calls
	do_sigaction() -> posixtimer_sig_unignore() and finds that tmr
	in ->ignored_posix_timers list.

	But posixtimer_queue_sigqueue() doesn't check PF_EXITING, I guess
	it should check it too?

	Or perhaps it makes more sense to check PF_EXITING in
	posixtimer_get_target() ?

and at first glance it seems that this version doesn't differ in this respect?

Sorry if I missed something (again ;) but I'd better ask just in case.

Oleg.

