Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424518;
	b=rgPHYaHOwnTERoLZTlBaJd2JZJK8ybLuAZZ6PLJ7B/ARM+cUpnzNYI6FGMjFFsygUQSq
	 p6JJrLnZ5neWBH23YXmpMxK2uT1AeKLaM59vRlm5v55LM1FyC6t8axoi/vEqV8WtEjthh
	 SCnIZyxPf8rIP3D3nX+1Wc5b+KC5aUxkqg1deH7Xvfuzb4kBYybonQDFeUhtrajptjZm+
	 FAh8oAB2mqfEo0mi5ec7vwFg91O9LhBSDjc2y9r/UBFXdo3N6SNd2YvDj1wMcCKOc5FHB
	 N8HPA2aN1cfFyBBQMsb4XDr6RXp+N93pqtU1uAD4z5jMCQB51mcHybic/TYScHIuCdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424518;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=NaN+mCZydYoju135pw7TWTUw+J0RdYin2G9nyjNDB/Y=;
	b=FQyUZhVl+9egnvjPGsMAmiEofD4C9WbRw79z+G9k7MqNMTa5A6flVwuM6pFOY2zR+aAP
	 0GNYgPeBf1xY29w2EvMB/64CARDcQbxd7qSn0d2YTw1H6I2SlxMAa/OE4Wg+Yq9lOex0p
	 1o6Yd3hDKlNbYem9lbck9I1kgb3WUvonAXRaSTWM3TRji66/T71FqyZTSbHMKFmpCXu0K
	 TvDbqvLLOe58fqrNQKOHjHNfAeqcXCvoCZa/99402EeVAwIet9r++atV5ASpTYq2zLmUS
	 XBNGxo2YZAVyTsHjqNaJEo4jlKJpFXtvvIh+5tOmmXCafRI6rBLT6jUUWQ2BlqfhE7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+Ft0x3T;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0566606EFDD
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0566606EFDD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+Ft0x3T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NaN+mCZydYoju135pw7TWTUw+J0RdYin2G9nyjNDB/Y=;
	b=i+Ft0x3TaUe1uyF9tkXen8CYwLBP8nFYSslxgr/Y9KaOiT3HmZv5kHasMX/+8za40OfTR1
	P84lIj7EYFkS2OF94/vVtZ3LQWLWTXbXChZHJqZDAvruPDHllqOmgVhsrvQtEOZ9omv+8I
	2tMmbF1Z5KbI0DjSudQlDIuc4DRYIOU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-FPDmvhMOPueC8vIQAl0fXg-1; Mon,
 19 Oct 2026 15:41:52 +0000
X-MC-Unique: FPDmvhMOPueC8vIQAl0fXg-1
X-Mimecast-MFC-AGG-ID: FPDmvhMOPueC8vIQAl0fXg_1792424510
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 467561955F7F;
	Mon, 19 Oct 2026 15:41:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32C9D30000E3;
	Mon, 19 Oct 2026 15:41:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-7-jarkko@kernel.org>
References: <20261019142516.300040-7-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 6/8] KEYS: Prevent overflow of user->qnbytes in key_alloc()
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
Content-ID: <2610122.1792424505.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:41:45 +0100
Message-ID: <2610123.1792424505@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I suggest merging patches 4 and 6, then add:

	Reviewed-by: David Howells <dhowells@redhat.com>

