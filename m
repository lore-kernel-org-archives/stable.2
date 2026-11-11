Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440102;
	b=FwRbvZbORmIqK6qQ4ab1eO21UJ6MLx0eArgFSOCrIEjUNuba+pK+IEVDANUKN7Ss6Jss
	 zT4pAEfogQzLoCpOGxGoXO89f7LbAlotCBz1z8SSn1V6jM+n0/wxA78NcNQPXBM74ofgh
	 A092PGYWEME29e3W2u9123UXbv/QLXBXzQV9dTb7N53prJ0FcwOOwxYVR9POitYxOFb+C
	 qbS6dLsvZmhs4BbGM58Qcc+hiyveFO22v1IhFOCfQ5USxLe/fq7FBRUqGpn/BEoBLR7rh
	 tPZ2PtLdvw7shkOrLzpPG0IxtV0du6V9aH1q6Ss3byqk5oO+EM1bImWIe50E9wiQ6HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440102;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=/saIjk+/mSYq8iZPgFXOiIKZ5cwgIKJ/PXOQnMC6enM=;
	b=2I9TYsVQ8CveweESzni3bQWjNP/86RvgTRVeZQTHOEQwOLh0tt1uP0I+mupEKMNMQ3pp
	 TkRIFkZHApx3Gu1hNd2lkmWB13yqo3VKtjlFeBIpYUkMFfPxb5hMvOrBMRgSSmKiXRhBV
	 q5KHejlA12qtGrNfhzJsbw5R+02BMcaElo7+bUXfw1arbNsTtLR33QcQd6Xt9OX04A37g
	 y8HDexET1d+AYg0w0Ishe2IjK/6buLSiDsh2J+Th6MrBqO2QDbIYYQDn3x773P/qalKbC
	 Nk3dFzPgXTZHpJXkWGKc+mqIVUUWpyDgdaw4jVVyA/rC8Ixi2iVmZNlebRJMiNgADaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xp4Yhy+Y;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A0606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC0A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xp4Yhy+Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794440100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/saIjk+/mSYq8iZPgFXOiIKZ5cwgIKJ/PXOQnMC6enM=;
	b=Xp4Yhy+YIvpi3JUP+bBCVlNhRud0NcKMbeaFKgrXMUaKDyiaueamIFZW82W7KTicHcrn42
	xR/TewgJtEaIXzKeGpch0nnRD7QedRoZSOZ3gkud6yAWMyq9vaSzknXdeqofTuM5GjMjv2
	AX1pLcZ6V3AvyFMfu8DSArqMVi732QI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-pXEQOR1MOveyCYTcvZquSA-1; Wed,
 11 Nov 2026 18:34:59 -0500
X-MC-Unique: pXEQOR1MOveyCYTcvZquSA-1
X-Mimecast-MFC-AGG-ID: pXEQOR1MOveyCYTcvZquSA_1794440097
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4670719560B5;
	Wed, 11 Nov 2026 23:34:57 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BBD27410;
	Wed, 11 Nov 2026 23:34:54 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Thu, 12 Nov 2026 00:34:56 +0100 (CET)
Date: Thu, 12 Nov 2026 00:34:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
Message-ID: <avT7nQs7zYseYtMw@redhat.com>
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
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
In-Reply-To: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/11, Mani Tofigh via B4 Relay wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> A task blocked in read() on a pipe can sleep while the pipe holds data,
> when an epoll(EPOLLEXCLUSIVE) watcher of the read end was added before
> it.  The watcher's entry on ->rd_wait is exclusive and sits ahead of the
> reader, so a write into an empty pipe wakes only the watcher.

I am already sleeping, but at first glance this is already wrong?

I mean, a WQ_FLAG_EXCLUSIVE waiter should not sit ahead of non-exclusive
waiter, no?

Oleg.

