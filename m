Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441768;
	b=Yu0aV6AiyU+szCMWrua+Oz8idbXfxEBYO9Y62j9ByXX9Fo0V0jaCFekXMXnWoQMvef6E
	 sxqfZjJldAaMKcMu1jg4X2OjAnyb35pamwWTN7TBAl3bQ0j54hUWP63wcLhZmvKmuCHlj
	 PpFWL1zFoyj1y78OyKBDtp0aK8V7rrcx5QihjJ5MZjRbjO+qv6GNyKkiOQQBfIzlyhYEu
	 XVWE1jfqunF9pYHMHpd7o9X6gdubt35CzyBpAlowQuqJKByWqJdAKoNg5OXQc3IGL9ncc
	 5D2OqFZlmqtXdfAT5C/g2/H2/fgC+hnB5zbBqp0ftdLgqmw71oXG14Qf+/LuS27JMLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441768;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Scanned-By;
	bh=kNEpRXv0Qjfeq3BAGqbQG/HWKXbqAXTDOCqw54GskJA=;
	b=Fh1ucTrB5hs8rV8NSK7rtpSH3iWZ/RxB0/79J05vX58Jr6WsohAL3EhpUrcBs3nZrwno
	 3rOX9KmBZljNy9PifkNjihCxnCo9HC+2stTafn492/T7uhy7hAFyb3/qDcVdf1lu4CBqE
	 Q9PNEMbdmWtSL3vXHdPuePBph65WbADXzZINd97g3sNlY+50ZmJuh46HBz3b/L0awoboA
	 QewPGM0A+mDSankj1xZgQfl93r7fFXb1dRIcv1Qx82FOxjepP4ahAXkg/jx5WNRix6ZbK
	 4UfbXZfWNpZve8pmnD96dLU6TMpi9LRBLiOklVLtAIFlNLx2zlgeQMg9+OGnTesdLOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hy9CDtiU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D5606A6AB
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54D5606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hy9CDtiU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795441766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNEpRXv0Qjfeq3BAGqbQG/HWKXbqAXTDOCqw54GskJA=;
	b=Hy9CDtiUTl97lWsg+pENvEllMgVrCGBCbJzUtZlbfMe+dn2Mx0pdEp9pKcGDpxeNo1GpeB
	6kA6RYLgXPD/mut07r0V97+IZPImAktzo2zsvCdk0vGMGi5LhAHyBaW0F2iA4UxD9hma0U
	IBoQbp5IUCKCJZn43WDOYQVEeSAcJd4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-Ez8w3PEcPnyyQ11_yNywQw-1; Mon,
 23 Nov 2026 13:49:21 +0000
X-MC-Unique: Ez8w3PEcPnyyQ11_yNywQw-1
X-Mimecast-MFC-AGG-ID: Ez8w3PEcPnyyQ11_yNywQw_1795441759
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31AF9180076D;
	Mon, 23 Nov 2026 13:49:18 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A985430000E3;
	Mon, 23 Nov 2026 13:49:12 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 23 Nov 2026 14:49:17 +0100 (CET)
Date: Mon, 23 Nov 2026 14:49:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	Cen Zhang <blbllhy@gmail.com>, James Morris <jmorris@namei.org>,
	Lee Seong Hyeon <ihopenre@gmail.com>,
	Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>,
	Nickolai Zeldovich <nickolai@csail.mit.edu>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <awREVxuPMpPXjA6I@redhat.com>
References: <20261120151554.2651743-1-mic@digikod.net>
 <awMn0L7RaQO_6qUc@redhat.com>
 <20261123.ungeuh7Taish@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123.ungeuh7Taish@digikod.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/23, Mickaël Salaün wrote:
>
> That would indeed be simpler, but a single pass would misses threads
> that a sibling is creating at the same time: the cred is copied before
> taking siglock and only fatal_signal_pending is checked.

Aaah, I see. Thanks for your explanation!

Oleg.

