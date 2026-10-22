Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672302;
	b=zjA6cxTkVMobVawGbclT5NEzIRaQlq4VLgamX5WH2v5b0dOWV2Fkg4jTqiqR8HH95UQQ
	 y2Onnk3NG8GgnA9b1jhrHS5FZNoY1QC66NWBlp1ZSwLQp5JqzaV4PdvKKLcKoyikmBcvy
	 s3+Al5q4DHQidJRkl1frpElXsR0+a9vvJsB3vJXBWAZONoSWGc0Cs8SyWi/KeZrp7qwFC
	 hS7o+3vfj+zw4xDkrTtZWM0SY4hR9HKDJOPkz3cymr3hu6StZfD/LEAQ/DQ43qF6DXvIS
	 ag6Drk91cxrou8w2SwnUtNfE5uxD1jZ0lFmZWQEj9V0rKmP0FUYzynA2MDbyBqCB4BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mz4/hi2WNPAXh0HU7Nfb6rMI+2D9TUKroQYNpklEqeE=;
	b=psyGCXNB2EbrDgEqejHhGr5WJ4yzlqizSEHau+hr0IYuOigCLZC0tKGpVxqW7Sz9pGHy
	 DwaewLAr7vo3lcV3lWtqFuhJ2oKN2PDUyz/I8jqK0jJIfM4pZbL8LraEpfoovhlejPxP8
	 T8C8fQUde0MxhAfKuoiseRW//eFhphWmUBCpb4Jp1QQ0ynIlwI9ia33M76lubM0qbbjXY
	 /2Jj41QnaVr9Jpk0N9iSxmsfp0zJS21sdJuCtlm4pQm/cl7uJ6cwO3mCd1SF4kYhOPVKl
	 /cQFzq/loDsGrAYt+N55J160QIt6kcg2KQDbTfPl2OvulEcox9IVcFC/U9Z/ZkSm8Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PnDHiuEE;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF7606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10DF7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PnDHiuEE
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dee593f18so1488083f8f.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792672300; x=1793277100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mz4/hi2WNPAXh0HU7Nfb6rMI+2D9TUKroQYNpklEqeE=;
        b=PnDHiuEEmcseEI/q7ujkH8xQerWkkFUITzE3FCwfLaKSnF3/MQP8JsLtzUVIkn8LdG
         h89TXk0eGdMmRcdGJTjLmNLN5CsJZRU+pr5bRjLuSxGMuY1TLj6M/5ELnkpc2GryPY66
         obYPAdTf4wRez6Wsm/oJ36K2RXxfvTZWDzRViFOqTHJBgL0KIm2HdXHp8CkVqvzsIjBS
         UE+erygC1ihyjbSg3ETnuTDifcZx8wWzzGUP+fF2+eORGHJH+Rn6EQcgfpNdp5sgIm5w
         IyQWqg3bOhRUOuN1kPqMs+VjxQIRYqhEjRHvtCOzRLBrWiWhSnHpB2rKyxX2oYX4in7e
         puMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672300; x=1793277100;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mz4/hi2WNPAXh0HU7Nfb6rMI+2D9TUKroQYNpklEqeE=;
        b=GDKIyNn6MY153zAmWfzBbKcDM+0qUngNLXq7Y8hjFNpvsTD55YGHZn6L1mtm/H+D+e
         9RKSG1Yg4uWGnfGTbI1q1EdxPcCjqYVW8a0Mzl8166n9JIWNU4M333tAShSMP+4v9oyM
         aCCDdqPwMpK1fXcSPYnAMJlYEU4glsoaelf42OqKqbTrSS3dem2AKumpCvGiwSeeaFOe
         7N0p5C0oxJUl9emdkHGZHa3uKRwoe32rMGu/Z/AcNmQs6ZFyKIbvpBMmpbabJ4EMryWJ
         XspS5stMnvA3SaLytx/vbrzEZMc2cqotDoUzAiNN0Xqr7Jb+TQl0KnDSmR7eU5H1KA2U
         kwOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxn+YQeJIOErA1t27rpf606zNY6nz8wW2HG3Gv/5Gd7Aaa4y8hvQtS29dAs8t1z7PB5KwPNhqE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPhHn+NBSrcHWUtyMkscdq4sbf3OFqnPEzzSZOC2mHzPPY3XGK
	F/J0zr/YipcNoBsjSjoZ8GzjwMONC2Tf06pB0yY9ZwXJKZF0TCFDVG9s4Mm4RJng5WcsIKQAjfq
	IQGgp1Zv0jh6C8NIPWNmTt6gcpd5fwrsIVEDewNDwip6ICXqdSws=
X-Gm-Gg: AYBFou1fB10yi+byhobhl9U6bSUmFVKRmwk27Wg2fPAYq62a9H+5buLb68iG638RnN7
	gXQTQ6slH1HUnCnHHh/hxom5YWn0GpLIuP2cK+mbiqcsAANifo9vdLEPJn49SWqS3aACxBIvtkI
	I5ah5euSyu1Jf6ucfZ/l7FiQ8RN1v3gHvkrA7DPALS3QrfM7roK8acKXymT1Ym+yUyWZn/lmVwQ
	6C5zNQ6cqRb0dhUkk2dPqvB2ILK+qtU71qQ+yJumwyXbNvekb+Js5GYJWQGFJ5LCQumWwIjlFGL
	ASIHqvtuLy0G4ngSd2XOs1W3WayJ9Iz+CHA5KvhBOmWsNagc5dXIXsJ2Ro0psmfTHoiB5rH23TA
	kCcfvKv85XfLopDG2NmOIJ0g1MRkoS8tAfo+TkD47LxGI0tOscvQQ6ksroyycucGQ9qtGLIfPei
	/0RAbBY9UYhB81VhSW55y0NqBFiCqRpKLGL9aBl0vdObCDhCOQUE/NoNapLVo312qkuz9BHgi3O
	gsEwsu6cZ7fWfkWJloP2wD+aJuINknIH/LfpAyAVZsubgiZrR7bjPz0OaI49RKdx00FRBPor1Zc
	0TNo3PEKE5wr+Z7dqQ==
X-Received: by 2002:a05:6000:41d2:b0:48b:4c8:7b07 with SMTP id ffacd0b85a97d-48e264e28b3mr10759766f8f.52.1792672300279;
        Thu, 22 Oct 2026 05:31:40 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:71ff:127a:8891:d8cc? ([2001:67c:2fbc:1:71ff:127a:8891:d8cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e2esm11859411f8f.30.2026.10.22.05.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:31:39 -0700 (PDT)
Message-ID: <2f0486ca-7570-4210-87f5-3b1e939fa649@openvpn.net>
Date: Thu, 22 Oct 2026 14:31:38 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/7] ovpn: avoid sending UDP packets with source port
 0
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org
References: <20261022121606.732029-1-antonio@openvpn.net>
 <20261022121606.732029-2-antonio@openvpn.net>
 <179267180279.3290.16441907746812616677@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <179267180279.3290.16441907746812616677@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2026 14:23, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.

Patches 1 to 6 are fixes for pre-existing issues reported by Sashiko 
some time ago, that we confirmed after code analysis.

They are "theoretical" because OpenVPN in userspace is not hitting these 
bugs and we have not witnessed these issues in production, but other 
software may.

Patch 7 is fixing a crash in the selftests binary that we actually hit.


Regards,

> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

-- 
Antonio Quartulli
OpenVPN Inc.

