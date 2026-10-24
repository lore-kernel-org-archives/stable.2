Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808835;
	b=OycFYEwU4FriuA7pveBgZY/KdK6gpsgohbyEjCGAuJKG7gILSUsiQ0NEN4tJ/bvv09hd
	 ORIKqcSE8/Yn6du5oM3ybGsWnoui3KKrV2cvV1xk2jlTv3RnWdk+ZcKRMfgFtL0PhmHL9
	 ic9N/w7YdpngukedNVdm8PmGDJ8hwiqG/0VCWJdMQZm2H/bS8zpZXUgpg5Tks9h7sHEDu
	 XCyHIYN6zfFMXf5nXAoMQ03XY5fxMcgsFTwxd9xHjndWtkqzpokO+P7agNxDr41BMZwHr
	 qJ2rLpt0RKhF9ozZ7A8E/Usrh7JWAiNbDxSHZgbUH25ML9PxCw0fu46lc9zyQsl6cAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dbq+C1knGtel/8heo5gmPJKIJmhELJ53YLi5og68HsI=;
	b=oH1NEpj0R6MvrisTxvkwIhWK+3QIaI1GfKGHlpJT4iClbcNhBwl5jrD1loj9ZVgPghy4
	 QA/2Of7AoNMbd+9ObMB8EWxLtYNfjrkm/jUXgpMpWMPaSseSEwh1GxCWgEz7ziUD1vXVd
	 97d/b+pBbBh9kVF8ZjXnTB5pyB415OeIu5vLDJQTp9ogYHXVGZB+snzfRTnUwOG4MqhAj
	 ULCvcuVBQ061eKjydM823bHYnolmeNDGOmQk+PTF1omwCH9pL23XuM+MIMysv1UuLAjbo
	 r3mELAgSXxh27zBEbHORYBlq0hwDPzeG1HcgBdKbQwqlV9LbNG15hztOua4zScY0dMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=GWaJI1zI;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3E606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D3E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=GWaJI1zI
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso822853f8f.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792808834; x=1793413634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dbq+C1knGtel/8heo5gmPJKIJmhELJ53YLi5og68HsI=;
        b=GWaJI1zIUBB052oSJa9UtU2rFA/QQz6czNQ8xYEa+mHu29BouCsuGhzzCRrwbTmbnB
         w3Kyn0Jl+G3E0xjX4PG9qH0C6XPUrixLrpd33yo9GKJc8GpTXrahRdEnp1RNi3Lmj52I
         W3derfTam89gY47QoSd0mhe8/hhDLPKB6OQrHlWsuXA+Xx872AoZDbZIWjEwVB1zHTlZ
         eSywb10VDzfQ6qs3zeXq63+IQ6owAuaUwhgT39IxePdNQO1o421tWCNJGIUjHtVoTcUo
         I4146WfzVMKSab5szv7wOr6w5UpP3l1tYzjsMmpm88IBgA0I5j5ipszWfhfpgIhQKMQ9
         eaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792808834; x=1793413634;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbq+C1knGtel/8heo5gmPJKIJmhELJ53YLi5og68HsI=;
        b=eih+0Y1xdNu9kc+dV6ihRwpW2PCdUlRye3MMZtkwsBsKE/mlEZm9AnhIt7B6o/30I9
         8250HlL1/rxKZ0+8st1QGdJppQJPE0iR1+99RV5vHMtrZowEN7v2Otk441V/k9Pyi782
         X6zWACH87js83oc/nIhtTRrRqBeB8uSZujAbb0ME68BoSqZLPX6fInCyljuwdw1XrRlr
         WRtDxG2RU7I/kAMeIqLFpVQolBhNjcBHF9HHyjJ+wj8UPO2tr+2bvYY9q3wwkvJvPwVI
         YQbJ9vVSVIE9wAqhrAkGrYt/VeOKU813EIIWOpnwOo1B82JHg0fqDOFpvjM9tKQ1jaIr
         9+8Q==
X-Forwarded-Encrypted: i=1; AKwUvBw6ag676y7jji/vzopqec+r1nNWojbvCfrUrc/vKiYos/bRoJ+s50QYYPUS6jXSn2+Zl0ruS6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJavJZ2Q6YJ2rzVsMaIkhxSRmZ7AqTX1lQobx8kaAP7JZhbjyuf
	H8RvK4JJsT+WxVG9vJm2vGVjSXT0hP/V8UUdwWNQaj1RiVf9qnn+eSs=
X-Gm-Gg: AYBFou0mfoALuUFL6NVRMX3nTNp2Pnzrg2J5RtiMpWXXhuIBIGjw4wFibuLE0BJZ//+
	vfOLrLq3JN8Z1EIApQmzQr4JA/VzMY/c0yybH6qblDdJrEiTUEljbFncHHOm4BrJY+JayD9p+Gq
	bVwNzg3+SwErqB6tJ8cX5nBzotRxrrSll1gLOqIDq5KwnRuHvSHnR8zWoga9ALnO0KJYpf2mUD7
	empqj9mpujVJUk6VRiCpwgOsXYGFqy8DODqZ4euoaOqiVKc6TwUK+0MjdV15E4ryQCxMARTJE7y
	3ZmZoxwWLkrml303ItySJ//uRra+JT5XYctelfU4O7W2qmQB3Es3gaOfTBaWKt4ZIs62jeMFwfW
	tpkytZAg1xrBQ8V1b2t1tA+/3mcH/ziWidnYAP8fSqdP3RFw18HDX3q0L7auurzEMokeYn2bd/J
	gyAXfsVbG3kqdQMOk6/XV03m55z+HcS2CUaNfux7g5Y8V9iE9TeeCfH/DbqKjrXuVjv65BfAJlv
	XZUxt0H23DlyTOTyVxY1CBRGctRaJhezVcQIsx0sZHartgoo9Fxgw/ex3vn3V9qq77OEBCcPna0
	Mi7mRnyVboLMYwEOKk7en5s/OXqWAojUziVhr61dHxjwKJnAMrmkOA==
X-Received: by 2002:adf:ed8f:0:b0:48e:1d87:f170 with SMTP id ffacd0b85a97d-48e3eb83fffmr740933f8f.12.1792808833581;
        Fri, 23 Oct 2026 19:27:13 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac555.dip0.t-ipconnect.de. [91.42.197.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm1742797f8f.44.2026.10.23.19.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 19:27:12 -0700 (PDT)
Message-ID: <a4ebdccd-4f47-4449-b120-59e1d6bc4951@googlemail.com>
Date: Sat, 24 Oct 2026 04:27:09 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/193] 6.18.59-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261023163714.201276352@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261023163714.201276352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.10.2026 um 18:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.59 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
