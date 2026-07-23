Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09667429CD1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800694; cv=none; b=jCV13SJHrGSdCLOxk2R29qP5H/lPeATQEeMk0UEAVnn+0jHJ4DqpUab9smi6ilrpna32fJRZ7U4y0VvUaJaXgjKSpDhxi+/PCIvuYh/p6WI91GIVHDXRSSk/+b2PflqXgR3GNcrbUo4g1Zg6sMPYjV+sWsb2Q66IGMTORBJBSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800694; c=relaxed/simple;
	bh=JyQ0i5MWICcwd6Ew8dcNJE1TVRfcbZFrQF41FwWqY7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9/xeS8ykW5ytgMjtOW0txbYxwUcV6mKpJ59Z5T6KGBRLjhay6RAEq4BZ1uwTGmKqafZSNwAk6mQ7vH3i2MqQ4bDmIvLC3Dcv7b5bUjrOCelSqSJv5SGts+e/stAPf31rD3vw4ROkqO8DhudqWQVEf6bcAjdkWGr3wJW6yi4avQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTX21+ZJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tFuCYt42; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTX21+ZJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tFuCYt42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784800690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
	b=RTX21+ZJgzX4T+zquTAYoJ6tq3vimeVxmmv+/Gq03cSe/HoIEdsswkYQxGn26HnhcTNGpb
	rENMWTzt9LNWlNrXQ4A3R3QqnyHB5oIfxKVkDgtroVcyElwMZz2v2mAT/K1C9Rwci2igIm
	ot5AoTGRzVGRmbQqNfXkvPfrK1/iAk4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-xNeuNY33MoiZVzaoLmM5eQ-1; Thu, 23 Jul 2026 05:58:08 -0400
X-MC-Unique: xNeuNY33MoiZVzaoLmM5eQ-1
X-Mimecast-MFC-AGG-ID: xNeuNY33MoiZVzaoLmM5eQ_1784800688
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955ecd8a10so4108195e9.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784800688; x=1785405488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
        b=tFuCYt42JvZIkLIMeRpoNFG/m+2/Yy337SFd/cralS3Lvj81CgwA+T0Gm2MAvoB6Rb
         JC6FnnhCGTDolLwh3kVDDaEu0oZhGbneCLWwF9uGKk85Vse5Qun34kgwskLtOplg8nzt
         wdRXTRZIpyXTdw+Dq/NbN1JhasLPO/xqbe2SrPTw5HWmd3d4K8fGIhpvy+CiH3iRmdyd
         bKekihkgcQGxez5mqIGlhrLFcmNGpwaDRbCM7TBR09o5bBjrF/oUh41r+2SEiuMNf6m2
         470GTbsVljkZKh4ALPeAnUIPbZX0bDlUlAvN3sSp3SvO8L9njUCiAcBXNtj5HXaXOs1j
         kHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800688; x=1785405488;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
        b=fqmX3po6EeX9sbw4gIgj4kMJikbDaDDxIV2LzNLNsO5JoCfYC7XaHgyuglNoNIhT8a
         ZXzr+2UOlhKh6bdRlYXPl6rTqx9DooRXGPZSkaxXDh8Xo+DyX/UVcCj+UHBd+oBi/e+7
         9e2yHzjLC59LilmIja8J+/hXLTA+Kh6FPAnPYtZ9VuXx3USfXVToSbpNhnr69k3Tam53
         NfeNA0/m+O26LKJM/P70C0+QHJy9cFCm/+lzWZ3ESYK21IoSnnk+1V/J1yCtr16McvJ2
         wXAQmROB6ChxLtBx4yqhZAY73E5QKTOexeihRUc63bC7hQydILm1ulClzQHaIjZJbeQp
         4D0A==
X-Forwarded-Encrypted: i=1; AHgh+RqYNcrNYeKuSQZPc8QfbWMQOvHovn61J2K1QBNbPiRGhecHLxCkc1cJ4nt8SuTeBa83JZOdnbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauVK1AgsoHieielhWhMEsCvDGPpC2eANuAHfoyDIyuUMSH2fk
	gSBcUMe32yrkfiT8o3sc21qHdrkU45qW7sajXLzOJwicUYytSC2oSD2YVoYPwVN/PImg7CBKqQm
	94LG+TClj57gMDiabKFznG2rKRFqA2K5qquAX8Nk+Frec+JCRvKRObh5sOQ==
X-Gm-Gg: AR+sD12ND+hkdR4P14El+UZXtbHgReSersoLMZB5pj2GATqQvQ2K3Ek+nd62/HohiqG
	c5/7xBUYf8cd8N3/FPsmsiGNP6jQVO/B5dt21UFWW+cHMcRdDMpKYkDQt21OGzUQ6HbZcWJoJFk
	Ux+G36QYKtMBWH4BeQEhdnxsoqNGmkqyX175RjpwUIjPV4jc+iujgP7/vdTrpbJp6rnEj8oNw99
	OxK5OWW+jdwpCWPh7GAaJ+Ht/pKmba0fQKg22rh8TUuOCbylUmzr+cTOsn/rr69VDjTWtCZdSjp
	wkdZNMkN3KHVSxhRjf17l7E6SbDx07U+cuO+gQe/0BLiq4Pp6JDrdlejpLzqL+j12IXMHHJRDev
	tFwJ4w9dR+ty1TwpcO5uajUA22H2Gnex6BfKsRXoIoMCU0LRvlSooJ4HLOtgU0V2RLFRG6CNjod
	pokw==
X-Received: by 2002:a7b:ce0b:0:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49573cc1a71mr16360075e9.4.1784800687615;
        Thu, 23 Jul 2026 02:58:07 -0700 (PDT)
X-Received: by 2002:a7b:ce0b:0:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49573cc1a71mr16359805e9.4.1784800687105;
        Thu, 23 Jul 2026 02:58:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c8760sm194729325e9.14.2026.07.23.02.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:58:06 -0700 (PDT)
Message-ID: <265fc46b-1e33-4283-b94b-7c591a9cf3ba@redhat.com>
Date: Thu, 23 Jul 2026 11:58:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
To: David Lee <david.lee@trailofbits.com>, Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713104752.241175-1-david.lee@trailofbits.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260713104752.241175-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 12:47 PM, David Lee wrote:
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index c31d2af5dd22..8aae9273b7c1 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -1768,15 +1768,19 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
>  {
>  	struct sock *s;
>  
> +again:
>  	write_lock_bh(&x25_list_lock);
>  
>  	sk_for_each(s, &x25_list) {
>  		if (x25_sk(s)->neighbour == nb) {
> +			sock_hold(s);
>  			write_unlock_bh(&x25_list_lock);
>  			lock_sock(s);
> -			x25_disconnect(s, ENETUNREACH, 0, 0);
> +			if (x25_sk(s)->neighbour == nb)
> +				x25_disconnect(s, ENETUNREACH, 0, 0);
>  			release_sock(s);
> -			write_lock_bh(&x25_list_lock);
> +			sock_put(s);
> +			goto again;
>  		}
>  	}
>  	write_unlock_bh(&x25_list_lock);

Note that sk will stay on list (with NULL neigh) even after disconnect
and the above introduces a quadratic behavior, but I can't find an easy
way to avoid it.

/P

