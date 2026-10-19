Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425325;
	b=XlBYM5Z5+S5Vu3ZR3704nHo4SGJ7P4C/HYRl8dKOykoJCpgR7HaUVyJnXtVx7m2eSteo
	 TSVbr+6csv58ODg1sE4cdxFC1mbEDK6nDoKFqHsGocOKufqMWjn9R76l/CVkwo/ONnBaS
	 C+xveyaW1yPRMaems5XcVHjrIAXXfpb31LFLh0yM8x1AwoYFx4y+kq5d4bWqWuKIkFWrW
	 qb33lUeYNX+V6E1sSUWTeuUPJGnvhXw8K3yxnmvo+ZNUX7BSRVsG5sYdIjYHENxe9PcYp
	 Z+hdppGkqp97OMiPEFEIvC5YBeun9SYelttY3Wt0w5gbNedKJgbSiZSLjvceaxHlAxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425325;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=rutENMajq1V1U3rINnISmb9MHW7iJ6RCHaeAN3MwYeY=;
	b=vLRpOtMh21u3qwi7C4Kjp1XslABJrzF3qeuOUkvIQCr59jvQC6q1dgK3e0gkC1qoKdeH
	 8X78wFT2XksC58+/TLT60T6DtDcb+9N/5vgI/pDb1hy7QQgtzTBwYswBuqpShybN5iG0L
	 f9tFH0/B/TtVQDq9xjlJZ3cc0YdlYT3CIy6oqTs/MXiDf5hDR/eHxOQThOBUKe3Ckj0j8
	 TJ+FUkXEJsvp6lJiuRIfkv7y3GG5YEL8OFAjwbRx4Y0NM8aYiml2o+3rcfqnI+mEgez1L
	 Cjh1bvDmIalrY6+QZACoJ0v8krP2bOWCALYZ4g8f8+3zofrDoB/FSIDgmkfSkqiBdYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EN+DUKfw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22E606AACC
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D22E606AACC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EN+DUKfw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792425324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rutENMajq1V1U3rINnISmb9MHW7iJ6RCHaeAN3MwYeY=;
	b=EN+DUKfwiFNTiqGpmgLDP7RYbZSjT6xG4VmqEc3GL7P/gn8m7YwpceYRt5t1nUNClhkO1u
	8KlnndqBNrYeKnbEQ9aGPAyg/VQFqU3afhtvE1J5kX3VZUc4pzbTOnQr5K4z1SHaGyObvK
	nc49ZvI4D0EciubT2b+O0aPY0ffA44o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-896bG0iVMQ2wFWwxFeUxFQ-1; Mon,
 19 Oct 2026 15:55:20 +0000
X-MC-Unique: 896bG0iVMQ2wFWwxFeUxFQ-1
X-Mimecast-MFC-AGG-ID: 896bG0iVMQ2wFWwxFeUxFQ_1792425319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7AF81956049;
	Mon, 19 Oct 2026 15:55:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D45E518005BE;
	Mon, 19 Oct 2026 15:55:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-9-jarkko@kernel.org>
References: <20261019142516.300040-9-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY
 SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 8/8] KEYS: Verify the key identity in __keyctl_unlink
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610586.1792425313.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:55:13 +0100
Message-ID: <2610587.1792425313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This will show it:

	keyctl newring ring_a @s
	keyctl newring ring_b @s
	A=`keyctl add user A ss %:ring_a`
	B=`keyctl add user A qq %:ring_b`
	keyctl newring R @s
	keyctl show
	keyctl link $A %:R
	keyctl show
	keyctl link $B %:R
	keyctl show
	keyctl unlink $A %:R
	keyctl show  # R is now incorrectly empty

Reviewed-by: David Howells <dhowells@redhat.com>

