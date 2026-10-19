Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424021;
	b=uiYSK4XqOm+luQZaRP3GhDGUnvOS0Wz9NOyF/t2MpAEs1a2ypfsDQLCUSQTIcuDoSs20
	 IpsEfP1aEWUr2IWN3l7SURaekw3v2WlsrrwFR5MUQoFVc6nSXlERN36eTHrZGOpFnTW7q
	 UFNpNBA6kOl8eQDKJxloVm83lfLeWyCkG63K6+8ci29iLh+Wf0gzNp6rXQ8+Ecf66leCu
	 rMrktTKuGhNklKyf8UzuZ3aPn/peApaAXeo2EHZjUyPJFNeS26VMG/KxuoVsIGEFb362c
	 82OTzPLpD01ALw0cLy4ZCErDh1cqrZlHcgMkCFt9bG5Tx3HTL5G73LTCno4VPhVIVGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424021;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=HQLKqGX+encDCMAwYFRiOY1YUEB13YG3cmAO/gPLw/A=;
	b=5e1W4IPQwJ1MyfSnEKMbFgJXT//Pl5/whGHb3WRQbLunaeaVksBAjSrrP3mB8iOvVDBO
	 nlrPRw7dzSEppH7iUwf4MbKtGyoRYo1DFZZSPa4PC9CKm84WTLw/6b3zrNqJCL7ADLEB7
	 c2+y7njKJqk40xkeSjJk3dVHvYgzgv25sYFgG+h4JYwhYKv1d3EodopBy2KUKWsxFzL2F
	 ynlTMulhh0+AxDD+9epCxCD5b6V12O/ByI68uW6iorSJuJ/UK/e60BR6tCupZ/Byl1UkO
	 MkLxzTi5lwfqZNmSPrDeIp180Sw6ZtmDmC26lWEdCr6aI16j9btDpO4gG/Ej2Ggm5VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=adLaUfP5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338B607551E
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8338B607551E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=adLaUfP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQLKqGX+encDCMAwYFRiOY1YUEB13YG3cmAO/gPLw/A=;
	b=adLaUfP5Vk8s4D1kWerGJ8tGdv95Kx3VVS0u3cMqWUhG0dU0ge0og9lEeavxv/huN7bf7K
	xqCoaQ9par7n8XPQrRfdS/0XEukR2ZeU0nhLB6xc5ZlR0yfnjQ7e6n1SShX9vrqpKnPP3f
	esZ5X/uv8hsF9fP0aibDnF3pN5VNFW0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-Y5GSTjQOOgK6WlncQzmNDw-1; Mon,
 19 Oct 2026 15:33:38 +0000
X-MC-Unique: Y5GSTjQOOgK6WlncQzmNDw-1
X-Mimecast-MFC-AGG-ID: Y5GSTjQOOgK6WlncQzmNDw_1792424016
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BEE71955F11;
	Mon, 19 Oct 2026 15:33:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6202B1800257;
	Mon, 19 Oct 2026 15:33:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-3-jarkko@kernel.org>
References: <20261019142516.300040-3-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [RFC PATCH 2/8] KEYS: Change the type of key->datalen to unsigned int
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
Content-ID: <2609765.1792424012.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:33:32 +0100
Message-ID: <2609766.1792424012@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I would merge this with patch 1.

Apart from that:

	Reviewed-by: David Howells <dhowells@redhat.com>

on both 1 & 2.

David

