Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424618;
	b=rVSELx6AXx43FmKvi885dDL3YERvfdEs/5GlNbmCgFUYfEMjM1AMvgDM1L+KQzEQAgox
	 OrAQhK3FdnB/UW1DMR+75agvRtZ9+UKgQhikGrMLtHZs6RmCMYSjx0t61UKPmq1Nj5Jeo
	 QpxgTQYpofqCmiqPfUCtERfIv7mNL32p1AzBGFxZyBsppdN1eAyHito9U996jQ/GozEKI
	 ImH57tU108AODWSj4+YSXRTRFnuguyc1ZL8HH67TbZM+0F4iXA2w859vEG9gaoeZ/YGXi
	 qdHHjW1f4jAXawsdkGAOqyIyCM6HApSLU/rjpVy6bpKcWuBXeUWmdVR+zCSWX1Ip71Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424618;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Content-Type:Content-ID:Date:
	 Message-ID:X-Scanned-By;
	bh=aWENVPvxx0/Tm7EYgjz9wevRNyQ6ebrJIgBkAgK1W1s=;
	b=Bopi9SRwtF4Pamer4Ta4cVoQGps0iCoh67N0YvSv8EaiR3ziwA98sHoMKvfYko/MtxDQ
	 Y3kf0vHFCba17HEOfUaDqabwtYHljOC6FzChXNo7LSBGwLpY5kAaCjkeUbj+tTMX+DsVn
	 wB3lh/sS5fh46xB1g14yCmK4pvBQ7lMB21FjcMudVFcUV/YItn9AY7vWWBbfUBcFKTKon
	 vrzAPHKDl9D/NS8eiVNvYz3g6IRSbk1bmKac+YmGua7UybiwUUTHl35d+8RwK47NeDfpW
	 TTnktCrtI+RHAqPveQWRLEvS87fTFI3SXfH7AH3EOU3XQKaChj3ZVudc8WDxBLKG51g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LLigXAmQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF31606A33D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF31606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LLigXAmQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWENVPvxx0/Tm7EYgjz9wevRNyQ6ebrJIgBkAgK1W1s=;
	b=LLigXAmQ/bK7mF9no+IesegCAiHhdvrB8O/vi4hrwpQTI3rwSvzBznGmhxNm2dHCmv3t/w
	djAA9LXd20CeE8pWU20y0apYZk8OF3+2fwsijYmq8TtqNetOpemVcu9g4UMIBB+nsOsYEZ
	n44Ulu+cpSpIQLOGmIjBdxI8FcfuJtg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-ASZMWjEQPqmWTLXlVQ0IaQ-1; Mon,
 19 Oct 2026 15:43:33 +0000
X-MC-Unique: ASZMWjEQPqmWTLXlVQ0IaQ-1
X-Mimecast-MFC-AGG-ID: ASZMWjEQPqmWTLXlVQ0IaQ_1792424611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 980321800671;
	Mon, 19 Oct 2026 15:43:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 004B91956095;
	Mon, 19 Oct 2026 15:43:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261019142516.300040-8-jarkko@kernel.org>
References: <20261019142516.300040-8-jarkko@kernel.org> <20261019142516.300040-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-security-module@vger.kernel.org (open
                         list:SECURITY
 SUBSYSTEM),
    linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH 7/8] KEYS: Reject @datalen values over INT_MAX
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
Content-ID: <2610185.1792424607.1@warthog.procyon.org.uk>
Date: Mon, 19 Oct 2026 16:43:27 +0100
Message-ID: <2610186.1792424607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> -	int delta = (int)datalen - key->datalen;
> +	int delta;
>  	int ret = 0;
>  
>  	key_check(key);
>  
> +	if (datalen > INT_MAX)
> +		return -EINVAL;
> +
> +	delta = (int)datalen - key->datalen;
> +

You don't actually need to move the subtraction.

But apart from that:

Signed-off-by: David Howells <dhowells@redhat.com>

