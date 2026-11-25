Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608953;
	b=4sNOf4Ku0hTZDuaVyX6PwI6p1wbspjvPv3TZXOD/yai32PVS+llG3i1/dPkhlazFuyb2
	 g/MS9/YinrnDXNSWh/q/x5p0SgJxtjUI5Vfjklu85oFWef04/ADlQCrS7s7e6fwqmJI/8
	 nWyB50S5osYgdcm2Qr4pgDUfI6Knbx4ZUkKBIx0ouKo+rB1PGIC8Lq7Y19gzZ+3IAGDyF
	 BEtgjLOnHrCDs6If3KrO9ayos3UkGYVSqM1aiPRacjMfBxRLtrYRx9Pq51kl9EXhJCsL1
	 9/CsNSat615gfz9UUW7h5NkilL7K4fFWKwip+Jnqh/9juLLqUfNI+yJNejEDbei06gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608953;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=zoN7I0BDPbXDDeNenHos3vHXfJ3u5ltkjoBOqq3KTgU=;
	b=y9IXDLZyg2QjJENqHVMibAvvlsNKKNtRlsA0/fw/yMrTCCdgecVKVLEfYOqQ/yUJ4evF
	 oAh+/sXoWYIrPHdwaqsWpRGZwnfMddlxWkfDjCiwLtZoFPfG75e1mFdyn6D7JjONrcbDF
	 RXEsmdjEuyD1WodHV3qFc0Ra4M197QxItfJOxQIjaBhcpjZRs7nkqMXu9+LxtgSdiu/2X
	 Qm4W98I3PsJJMhuvuixjSbRLMd6A+Qc5MCJ8etfFOPMgfDuY2dtvvG4r1YX/Ea3t7hQIe
	 ganPYvsBip6ffURMar4a5QZap7QlQumCPwdDPkhNLVkjjIGJ8BS0zxrKl2OEPJadY+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TSfj8Ydt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA6606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5FA6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TSfj8Ydt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795608951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoN7I0BDPbXDDeNenHos3vHXfJ3u5ltkjoBOqq3KTgU=;
	b=TSfj8Ydtn6TgDPioSrA8boOOr7CViwz1/TBfYecLMPmKwLIxFALQOO+77yACXnIrvQzx9Z
	BONOqCFzjU/x8oZdm0PfWfRnsHd0UuLUqXR1wiST/GufAUZe6ThuFg9ApEOKTMn0rwdhqT
	xi5ym4HOTRGL1ETeMny2RyspxOGt5os=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-GDTU3zJxMsaXpCLmoG1DuQ-1; Wed,
 25 Nov 2026 12:15:47 +0000
X-MC-Unique: GDTU3zJxMsaXpCLmoG1DuQ-1
X-Mimecast-MFC-AGG-ID: GDTU3zJxMsaXpCLmoG1DuQ_1795608945
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 344C119560B1;
	Wed, 25 Nov 2026 12:15:45 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9B8C18004FC;
	Wed, 25 Nov 2026 12:15:41 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 25 Nov 2026 13:15:44 +0100 (CET)
Date: Wed, 25 Nov 2026 13:15:40 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Michal Nazarewicz <mina86@mina86.com>,
	Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user
 space waiters
Message-ID: <awbRbH35xP3KEEOF@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com>
 <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
 <awbJz9stwx_JzZFX@redhat.com>
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
In-Reply-To: <awbJz9stwx_JzZFX@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/25, Oleg Nesterov wrote:
>
> On 11/24, Linus Torvalds wrote:
> >
> > @@ -105,10 +111,16 @@ static int __wake_up_common(struct
> > wait_queue_head *wq_head, unsigned int mode,
> >  		unsigned flags = curr->flags;
> >  		int ret;
> >
> > +		if ((flags & WQ_FLAG_POLL_EXCLUSIVE) && poll_woken)
> > +			continue;
> >  		ret = curr->func(curr, mode, wake_flags, key);
> >  		if (ret < 0)
> >  			break;
> > -		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> > +		if (!ret)
> > +			continue;
> > +		if (flags & WQ_FLAG_POLL_EXCLUSIVE)
> > +			poll_woken = nr_exclusive > 0;
> > +		else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> >  			break;
>
> I obviously like this change, but note that wake_up_all*() helpers
> use nr_exclusive == 0, so
>
> 		poll_woken = nr_exclusive > 0;
>
> doesn't look correct.

Yes, but ...

> I think this patch should also change them to
> use nr_exclusive = -1.

No, this won't help. It seems that __wake_up_common() needs
"bool all = !nr_exclusive" before the main loop.

Oleg.

