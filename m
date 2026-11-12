Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479210;
	b=xJcFI5TyuKw01MXb5QB8LipQYML/CWinHwYK13CWhCCiK5DBy4zVIF2Qe0uJXTrVpjUc
	 uOI0tYivNjpDRSzGO0IaDbCZYToi0maBXC636KwVkC64J3y65V0gLE7NnEMWnjLT3Mfb8
	 u+dfZaZAikJJFKTd0eabnwy2vpKQ52EtNfc2f8BjFqPbfibtgf4YuaLeyM7ajpKRRxli6
	 +YRkytNhrN+O9gjpidO+06mk5Uw2N07RfaC0QwgLDTlyWkW6p/ZAwNZ/yzGKl8Fcq9cKK
	 VXc8WllfGkhwjFsYXWvzC3ziBf9yZvioNA/XJE2wHYdui2Qil7UpNlNxxaiW/Q+aGIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479210;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=6llOWqJeYAhUICeHCBAXdna4LLIajW03GC3elOBHvx4=;
	b=D4SGzKFtugenVGHPLwzsuTekp8zpDTK9PPgHcjVYJAxfmL085STUqOHGw/HYThwQ4WeW
	 vjPufE/LepgzGBPdCt/BCkwGppGga1HHozaiLPLAD5C+66+jQuioUODFJrWtKqDG4dN06
	 l+bA4RJ9r3fYX/uknHYyrKny4eKnvr4Wev+2hu2BIfSAH/U8iPV10iGjZh3nCx2SjD4e9
	 bfpitsbMzHo7oq6vG/pNkTxnwW5NUmNghadtjS298BHhX+Q2wN7akC8riVMCx0Yd9q1OU
	 Nr5mnRighw2GcIRl9cxKSsiqZZBUpb+7KLng2bw8bqTyjplNQu7oG1QFGzDNbRbghIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=euDFcGry;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D025606A33B
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D025606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=euDFcGry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794479209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6llOWqJeYAhUICeHCBAXdna4LLIajW03GC3elOBHvx4=;
	b=euDFcGryuEgQLLHmExN8Ukx8Xome8BESCk6f2ahfOs5TRrjhD9mwUPvzAbAep5q0SxhJWc
	zKd+qsCxTr2BH4kyzzmzideMj+zz1yC0gZqGXY/2B0O0nUs97wQw/GwNVMPRgljPoABbJz
	1Eaj6EODFhChq2Io+TtthgxZIPPnrsc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-u-i_fN6cN0-B-vlmLwz4og-1; Thu,
 12 Nov 2026 05:26:43 -0500
X-MC-Unique: u-i_fN6cN0-B-vlmLwz4og-1
X-Mimecast-MFC-AGG-ID: u-i_fN6cN0-B-vlmLwz4og_1794479201
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 489C71882607;
	Thu, 12 Nov 2026 10:26:41 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4D73C1956087;
	Thu, 12 Nov 2026 10:26:38 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 12 Nov 2026 11:26:40 +0100 (CET)
Date: Thu, 12 Nov 2026 11:26:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avWUXRywbUFuLm0S@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avT7nQs7zYseYtMw@redhat.com>
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
In-Reply-To: <avT7nQs7zYseYtMw@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/12, Oleg Nesterov wrote:
>
> On 11/11, Mani Tofigh via B4 Relay wrote:
> >
> > From: Mani Tofigh <mt4022@columbia.edu>
> >
> > A task blocked in read() on a pipe can sleep while the pipe holds data,
> > when an epoll(EPOLLEXCLUSIVE) watcher of the read end was added before
> > it.  The watcher's entry on ->rd_wait is exclusive and sits ahead of the
> > reader, so a write into an empty pipe wakes only the watcher.
>
> I am already sleeping, but at first glance this is already wrong?
>
> I mean, a WQ_FLAG_EXCLUSIVE waiter should not sit ahead of non-exclusive
> waiter, no?

Ah, I forgot that anon_pipe_read() uses wait_event_exclusive(), and it
assumes that this wait-event is the only reason to set wake_next_reader...

I seem to understand, let me think about it.

Oleg.

