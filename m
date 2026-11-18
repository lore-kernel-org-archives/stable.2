Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007431;
	b=Izu/TnIz9kSCJHTsCG50KnVnQCYQ3Rx0b6sJb/QoWtfBxh+nL/172mSk8xB8uMXVBdyR
	 cA8M2nslzAvS677TwHCqgCM4drFwyrQWcsnyCKlnCcQSDQkQ9PoII6/uq9WM/pWMwkDGf
	 ulI2MAK/W0kyBuWcB+EL8bUzOYsvJGLbJTfpV5dk1o2iQ9WaDKFd4+pnmrwhY9iHp9zp9
	 LqXqg2RMkKTShKOWGV6TajgQtbx+7IBP1BmPR07KiHYKG9TJV7m+ff/4qYzA/ENlXhHPJ
	 2sP7Jru+RkCQ1hxfZ8LnW1C+mkWmRwSoDApqiZdyMiy5n0SSn4QNq8qVU/hh/hhm/ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007431;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=SW1SgyAqJZMhz2Qvs3jWCWx5VKPPmPyNUr3G/FpCRlc=;
	b=aZ5znY5fddQDMKfRJDTAfQe6mPTRhhG6coEaCbO1nkp0qrkebqAL2m3wEGFZ+IKw7dBz
	 TNMLghax15egH0hvb3DbYGzAmz1Ki6IOQmZGHHXyprIg0oITaell9thAgdG5JT9+o8RhC
	 phKqFKFGdDaXPFC8CTag7AwdFyO65xvV1dvMKAWX+GqJlMU2dzX2dyp2x43AYN3dSATsv
	 H6hugSxlj2/GyJ++GZZaLyzv/RABuv+bapDaUx7Wu3GDmyLG2M88XZA0RTq39pWpZI+Jy
	 FMxKtcytgUaFp3GpYI8pKDx/nVyniQ0yc+Ieu95n0O/hQee4mmfz8sb7FJzuBR3zbuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FKluoVao;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B24606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B24606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FKluoVao
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795007429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SW1SgyAqJZMhz2Qvs3jWCWx5VKPPmPyNUr3G/FpCRlc=;
	b=FKluoVaoKe1S+DWStVVoqokhwOsDD8LrCozAibqvOCNCzmZlZLhBLqUSQvMbmxoTTSbGyv
	WDjy3AmvkR3AkqbzRIs7Ot2EI1UhrBn1fFzayg7YqL8hzW7bhphNrRIRNfMDe7IEppAlu9
	JCQTDiyw8z9JFiIn7kpEvgXZSzEeObQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-PSY9HXz-MPSmoDPTNZ-_8Q-1; Wed,
 18 Nov 2026 08:10:25 -0500
X-MC-Unique: PSY9HXz-MPSmoDPTNZ-_8Q-1
X-Mimecast-MFC-AGG-ID: PSY9HXz-MPSmoDPTNZ-_8Q_1795007423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1105919560B1;
	Wed, 18 Nov 2026 13:10:23 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4D8A23000223;
	Wed, 18 Nov 2026 13:10:18 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 18 Nov 2026 14:10:22 +0100 (CET)
Date: Wed, 18 Nov 2026 14:10:17 +0100
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
Message-ID: <av2juQijIISJAgyf@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com>
 <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com>
 <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com>
 <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/17, Linus Torvalds wrote:
>
> That header isn't _horrible_, but some of it was uglier than needed,
> and adding WQ_FLAG_PRIORITY would have been a huge pain because the
> code unnecessarily special-cases WQ_FLAG_EXCLUSIVE.

Yes. See also below.

> NOTE! Entirely untested. Comments?

I tried to check it line-by-line, see nothing wrong. FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

---------------------------------------------------------------------------
And this reminds me. Please look at __wait_event_interruptible_locked(),
it is buggy.

do_wait_intr() and do_wait_intr_irq() use __add_wait_queue_entry_tail()
regardless of WQ_FLAG_EXCLUSIVE (reported by Mani in another thread).

Plus another problem: exclusive waiter must not fail if it was selected
by wakeup, see the comment in prepare_to_wait_event().

What if we add, say, WQ_FLAG_LOCKED and change prepare_to_wait_event()

	--- x/kernel/sched/wait.c
	+++ x/kernel/sched/wait.c
	@@ -274,7 +274,8 @@ long prepare_to_wait_event(struct wait_q
		unsigned long flags;
		long ret = 0;
	 
	-	spin_lock_irqsave(&wq_head->lock, flags);
	+	if (!(wq_entry->flags & WQ_FLAG_LOCKED))
	+		spin_lock_irqsave(&wq_head->lock, flags);
		if (signal_pending_state(state, current)) {
			/*
			 * Exclusive waiter must not fail if it was selected by wakeup,
	@@ -299,7 +300,8 @@ long prepare_to_wait_event(struct wait_q
			}
			set_current_state(state);
		}
	-	spin_unlock_irqrestore(&wq_head->lock, flags);
	+	if (!(wq_entry->flags & WQ_FLAG_LOCKED))
	+		spin_unlock_irqrestore(&wq_head->lock, flags);
	 
		return ret;
	 }

?

Yes, finish_wait() needs to check WQ_FLAG_LOCKED too... perhaps just

	if (WQ_FLAG_LOCKED) list_del_init(...);

at the start.

Then we can trivially redefine all users of __wait_event_interruptible_locked()
on top of ___wait_event/etc.

Say, wait_event_interruptible_exclusive_locked(wq, condition) can use
___wait_event(wq, condition, TASK_INTERRUPTIBLE,
	WQ_FLAG_EXCLUSIVE | WQ_FLAG_LOCKED,
	spin_unlock(&wq->lock); schedule(); spin_lock(&wq->lock))

Will you agree with this hack? If yes, I'll try to make the patch on top of
your cleanup.

Oleg.

