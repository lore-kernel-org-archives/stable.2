Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607757;
	b=K1wEv0+eSnWIy4cmZSP9gVoIF7cQVcz5a/zK8ZIedvBGHRhTWBABUYMiVYBCzcD9QkAx
	 cOrI9cCcaPzgIuMhe6oNvkddyxblhZXXG4D5Nuubu1nsYYPKLp/1HxeyVIff0CNnr28Fc
	 EtwTOMsqVTQCCbjM1BqHQmuxVG1TZAKmOOZDKIz4bVCiZ4yXwcVmDtbYqOgvJBY1zKDLn
	 1/Gl1qnUShJzV4DTeUSJMiMnFacCsgF0a8H8QmqXMBblg1bEbPrngLISy5MAfyc1G9a8D
	 7TWlF1S3ZlHnHE8HvhqkmtM9Kqi89EYut6/njWwNNO/nj40XfFu41I3awj7Wnr0EjMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607757;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=f2AwCkNuNcNTtX9kmSc7WIvhZoX+0iuemqBB5uiZJV0=;
	b=Yhmzq5WVGe75NgT6UKO/NWS2Wr4YNmRsgBPyTGZ66vpCJGaeaxrbzi8h8ECAtdwyF5Ue
	 2etp43kaOaf2R4VcpQkqGb5S19pmnjKUeLmq5hsv0Sj/gn+JFRhCDwECxoP5FqOYCeqTm
	 pYKA2QWQBMaP6aJeSm82pLISxK6xsnB/cxkaQD+aiUhVXKKQg9ToCIq8QghWWWqTOwJdC
	 egTRV8uIZK2ZyCT50wHknMzVLBuAQj2G5MmF8WcutW/Ke6gkcGYFEBuTGGeGkUSHXQr0I
	 KuU1FbnNCvyPEbu84nnCLmtfxp8eUrU5Lp1RNdmkZSUjwFUtjfGlWPL60tCkX4NOTLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gFyPYHJA;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CFF606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39CFF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gFyPYHJA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795607755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2AwCkNuNcNTtX9kmSc7WIvhZoX+0iuemqBB5uiZJV0=;
	b=gFyPYHJA+UuPgRB1ZrKUvtKH8676otVGnL8PiG2X6IZObaZORbWcQI7OftXWpxizP8zkuT
	J12EdIBIvGkROVV14svt7UhwIh/kYLnfktjj40fhVHSd76ZbD3rf6N+qZ7SAVJGrlbP3DC
	1+ANlsx3Ze4JgIc8mYseN1mvzi45woY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-ceSh3YlNPEW2q_Jh034pvQ-1; Wed,
 25 Nov 2026 11:55:51 +0000
X-MC-Unique: ceSh3YlNPEW2q_Jh034pvQ-1
X-Mimecast-MFC-AGG-ID: ceSh3YlNPEW2q_Jh034pvQ_1795607749
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 041B71956044;
	Wed, 25 Nov 2026 11:55:49 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AFA401801975;
	Wed, 25 Nov 2026 11:55:45 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 25 Nov 2026 12:55:48 +0100 (CET)
Date: Wed, 25 Nov 2026 12:55:44 +0100
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
Subject: Re: [PATCH 3/7] eventpoll: don't claim real exclusivity for
 EPOLLEXCLUSIVE
Message-ID: <awbMwBDP9TsJBmzV@redhat.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com>
 <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com>
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
In-Reply-To: <CAHk-=wgFnKO_O0fR_-O+i5yUGaDcz8_HwpM5QiLM4jPFYZb41Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/24, Linus Torvalds wrote:
>
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1626,9 +1626,8 @@ static void ep_ptable_queue_proc(struct file
> *file, wait_queue_head_t *whead,

FYI, none of these patches can be applied, both patch and git-am complain
"patch: **** malformed patch at line 34: *file, wait_queue_head_t *whead,"

>  	pwq->whead = whead;
>  	pwq->base = epi;
>  	if (epi->event.events & EPOLLEXCLUSIVE)
> -		add_wait_queue_exclusive(whead, &pwq->wait);
> -	else
> -		add_wait_queue(whead, &pwq->wait);
> +		pwq->wait.flags |= WQ_FLAG_POLL_EXCLUSIVE;
> +	add_wait_queue(whead, &pwq->wait);

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

