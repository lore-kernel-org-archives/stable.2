Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67578408031
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284607; cv=none; b=F8leZtQAri7oY5S41LOuzDa3KxSsA8hg0OwBh3eEyaDj9wGJKZgw4GJRWVwp5KhUkQSjsmw0kDo4PAcKa5SMpepPLBFDWBBRnykVZ5k5VA5X3tvYOeM8IDm5c2itHXKiQ5DU0xVmr7Z+nukawOTAkm5j28Dk4UWRHXyv+/mYJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284607; c=relaxed/simple;
	bh=GSpi19COajyBmeu00h0HL0wMdy2XKh2WLArdLFA54KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkcgEhVqztP77GNG4ZBO+K6YAxx3rE2xc9ZwJcl1ukYf+LDaYZqtjqgm8F+3lLgBD/U27IHtO6zw9dABjk7J5LEEoPejQlpF3Jtwc8rQ+rOdvTgr1LL5MUjjsDXqVlXig4A40q0m1SFmoEe2xzZh3CHMzovPlhQf/Ez9yRLYwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Pp+Ngg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Pp+Ngg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7c6dbc60so146905e9.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790284595; x=1790889395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfGvfwNr/tckeUTW0rQax9csKD8upwKYtURB0NTilpk=;
        b=a6Pp+Ngguqb1Ow+2ob0ojGblJ4rb3uzRhiqmBB2FAMIP8jsC/nHzn0UqIeCIb2i1oU
         br1hFZ1QhozdoyGXU45NOW1asGFp/3dWmqKwXeCIVYP2T7hyi7+EcLpJ+tqNVtKuDZhP
         QoXv/iGQ7ziov9uM1OZ6CqLRrzdcyQBZBHrYYFyD0yowcWO/lT3fvQlgaSahBaphC/2h
         4CA85hF0JVXZgv6mpA9+GqRszu6UEldvwCCHz3WYyd3FONPvnw5CXwZOLL7z/JaIaJFi
         kO4izjCaFNKaMCbufrhN49MelKfhCa40w0gA/XMiCIISiXgAa8bITJucqTWBVcEPxjh6
         CCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284595; x=1790889395;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfGvfwNr/tckeUTW0rQax9csKD8upwKYtURB0NTilpk=;
        b=T5zb5voCl6V52Z9OQomY/yfFmTPNcjXtFgpwAfYyCn7iBB/KLOMjSqJAXRWwIXD/f6
         fxHZ5KPzOXb7ujW2P9EXXMI9xygW22VByf8lc0dLcH5My2HNxJjWMF3+cgAFPxMo1P41
         hLmNU1fhqfx2Dl5jVvgdtJI7ZfFW7iy24i7+Ts7jHQt1JeSVSqc/EEiHrkNNsDUV+PiH
         gPtl8zl8hvb37BU/cMjCr2yj81MkQ125HqErKfwYaTIdhfg3bBjvvE5ucMtN5zx2hWAV
         25PlmDRG03+ZTEtUafGQsXAixiqn8HFKW9bZy/GisUuCgHQAmf/4kYlNmljsuFHWnC2W
         31qA==
X-Forwarded-Encrypted: i=1; AKwUvBwVTE1t1kJSraEDtk+SfpWLoQj3IHLdn/20FukHnqJ+M+2+w15X+ecBnz0GB6BMb5nODH+WP5I=@vger.kernel.org
X-Gm-Message-State: AFuF++nt+kf+tyKQ/aUsZigcaStWg7C9EGac4exd9UDZVVShRjSfpq5C
	bme7ERpPmG9Mt2TrHFFIFeQUywMOZbaFQ+NVegUPOKGpqRP8lroRraTo
X-Gm-Gg: AYBFou0FwBpmM+2xuPiXTd086Ly1P4S2CZk1+pYsuwIIz/63BgmPHnjJ/G8W6up3hNo
	GCwc7Iol5fJt/Oj1Y0Bh4RKw127qdpeNFZYKGo6vpG+vWddHM7Zn61RDnjcARUmUPfuNH3MFh2H
	uQIZ79kRo2EWmpAe8fgK2OQuSQOvbL0lN63VtYH2R2THI8TGLcvn4NKrLdLUyHBvwXoXekf2Kcf
	ScQvFinIRD8t/4hh48hLiS19nuOV+f1y6Beh528APDFq5+kR5nc2SysN0NY3qWkaGOYJGwJltgs
	AkksXByo33uHYgyVDiq57s8dpOzR7Eh3JWuqr0SwF5uqTYj/kXMwNXIXTVXANv/PsFkQaQd52bD
	z4BeTsLxT/gAm6mNh38U++c26aj7wJN9KzSWMqsJ/qmLBxS7+ulUfM/9m/SDEvNzaG0M4IldZSC
	hYgeMllPktaoD5+hCmLNQ+/r6tCJFG3YxfWSXzr+cSJ4G7N2u2BuspZvYa4p+5w5R3wHj5uT7n9
	BRM8D5ggYvAfOj6x/HR5SdNYu6noW1a+L/88S2p03c5mLvI8Cju66lBifrk4FiLlt/aY4nVyXcj
	R+f74YF+p/JN9IgPEJf1qo/MPzzHfBPDszQtoMVhtYAveU91igPyB7Bp/1V7Bs6G9NW5Q+Ry7+L
	fmNXUEpgBxf3VwN96k+nL
X-Received: by 2002:a05:600c:8b4c:b0:49f:c432:885 with SMTP id 5b1f17b1804b1-49fe6702398mr60249845e9.2.1790284594803;
        Thu, 24 Sep 2026 14:16:34 -0700 (PDT)
Received: from ?IPV6:2a02:3100:610f:ecfc:4dfb:2ac9:70ba:48bd? (dynamic-2a02-3100-610f-ecfc-4dfb-2ac9-70ba-48bd.310.pool.telefonica.de. [2a02:3100:610f:ecfc:4dfb:2ac9:70ba:48bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm92677785e9.6.2026.09.24.14.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:16:34 -0700 (PDT)
Message-ID: <4cd6377a-e0a5-4058-bc72-40bb32b2d26a@gmail.com>
Date: Thu, 24 Sep 2026 23:16:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net: hsr: fix packet drops caused by GRO superpackets
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, kees@kernel.org,
 petr.wozniak@gmail.com, qingfang.deng@linux.dev, fmaurer@redhat.com,
 luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-2-xiexinet@gmail.com>
 <20260813182111.088aee3d@kernel.org>
 <7c09a44a-19d9-43f5-a852-12f5b6579641@gmail.com>
 <20260923103238.cg3tr_40@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260923103238.cg3tr_40@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2026 12:32, Sebastian Andrzej Siewior wrote:
> Would adding a NETIF_F_HSR_SLAVE flag to slave device(s) and then filter
> invalid flags in netdev_fix_features() fix this? This should help
> against enabling and add a warning if a flag can not be removed.
> 
> A netdev_change_features() might do the job then.
> 
> Sebastian

Yes. I'll use a port constraint in netdev_fix_features() to keep GRO,
and GRO_HW (when configurable) disabled, while the device is an
HSR/PRP port, incl. the interlink port. And call netdev_change_features() 
on attachment and detachment, preserving the GRO settings.

-- 
Xin
