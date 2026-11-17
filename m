Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936348;
	b=L1C+pb5Js3KUW8KPN5gzv1NS16djKTjr5uhXVh1dVegaCWZ6wMRitwC5vvz65ZiVqazz
	 e/FDI8gd+w9f7NKhCF07TNiHpmKZGh/THAF3lE63fjey/pVKfqFADsklwJFYaVNTL/vb2
	 d1w2pBVoC//34nzk4hVh50h+HIoDgqp0DZLmidkHN0/AJFlZAgKdvVLbNpvWuFiaNbeAA
	 AJntFBiHJyq5tDXxZYrucJOahkmeOQaSTz7zWkdwdbC0pmnPl69NqZZkwtgI0jJlL0Gcs
	 C8mPlU2mWoXSZjVzwLdB2JJU7amMjMMtWvAk2RumSrHi3wVZ+Fuw6bVm70XS97k11Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936348;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=5HpZNf1p6vQ+Z15EuGtPfQXOlxM7vON26KjcgJWrLvY=;
	b=E1Jd46P8jokoIjLPvgJ7TZZ+N/HZLTxggrBiAOUWhwfQaK4vpBAX/bOFRiJBqy2xEPmx
	 A8HkAj625VyN/EqWgcrJoB1XaIdFKKmR6j3aXnmaCXKmj9ATbDdSWDjeBh7GKXrX1i8ZB
	 ndIms804Y088mkyR3Cia675mbwUsx6wPX7id9MmdEI+Fdf3hLbEVzqYf7vwEhMoJWPAFe
	 Q7dKsUcS5OLI4kRRIYd6FwkH1nm1eZq5vuemRv4ZUBfQfh85SDgJ6qqGq28yMj/BrwXk0
	 W5TNbWz9w9IeFzOkldUC47FoIRvTCTxipiDEGmNN9+id5c11g5rMpGWirCBpgA475zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y0cAOkcf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD22606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD22606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y0cAOkcf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794936347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5HpZNf1p6vQ+Z15EuGtPfQXOlxM7vON26KjcgJWrLvY=;
	b=Y0cAOkcfxmvbVcUy2Mymrlgs35i1jUf7NE83emRI/hA1hsWrUYxY8HlAV7xOA5QNog+QBl
	+M0hp8O/CBYsmeoJvD66wKoKuWcZ33NPsFEij9YbtR3FgG8zVIvqcrq6yEvy4a75TrsWTu
	ftoHUqsFTxzRimLV//JwDTiEVK0u/HY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-OB_fdnBjM0yJlldqNbt59Q-1; Tue,
 17 Nov 2026 12:25:41 -0500
X-MC-Unique: OB_fdnBjM0yJlldqNbt59Q-1
X-Mimecast-MFC-AGG-ID: OB_fdnBjM0yJlldqNbt59Q_1794936339
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CB201956051;
	Tue, 17 Nov 2026 17:25:39 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F27F53001DAD;
	Tue, 17 Nov 2026 17:25:35 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 18:25:39 +0100 (CET)
Date: Tue, 17 Nov 2026 18:25:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avyODoFhZ_M7YDU5@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
 <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/17, Linus Torvalds wrote:
>
> On Tue, 17 Nov 2026 at 05:27, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > However, EPOLLEXCLUSIVE breaks this logic. ep_ptable_queue_proc() does
> > add_wait_queue_exclusive() if EPOLLEXCLUSIVE is set.
>
> Christ, how I hate epoll. It's a pile of stinking shit.
>
> This literally violates THE WHOLE AND ONLY POINT of exclusive waits.
>
> The rule for an exclusive wait is that it *will* act on the wakeup -
> either by consuming the data, or - if it can't consume it all - by
> waking up the next waiter itself.
>
> So it's not that "EPOLLEXCLUSIVE breaks this logic".
>
> The logic is fine. EPOLLEXCLUSIVE is broken beyond words.

Well, I thought so too. That is why initially I replied "we don't care"
to Mani. But then I decided to summarize and add CC's.

So. Do you agree that we can "ignore" this report from Mani for now?
Until we find a user application that already depends on the behaviour
before f1cebdec9739 (the next write() wakes up a reader which sleeps on
->rd_wait for no reason).

Just in case... io_uring/poll.c:__io_queue_proc does the same:

	if (poll->events & EPOLLEXCLUSIVE) {
		add_wait_queue_exclusive(head, &poll->wait);
	} else {
		add_wait_queue(head, &poll->wait);
	}

Oleg.

