Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362852;
	b=uzs/TfK1w1gsl8+gAnDSFpUQxDgElKjoq1zTfmpT8nJ8csUk9Empq2AILWmrakZfFo5s
	 yTfuzKJIou6QFZpOpINYMB94pGwKSzJZiBGt8rs8WESE4VYvWFYboFprvZeZ49Gv+/lMD
	 5Pl7xDMWSGy0K/G2om63+x53XxBpyASsorKIb4na9eNRSN3LaLYZwlLtwRicDbd7CDVnl
	 LrVoEO+PD7I/Hh8XYpgeTF9RhouXaOFSa4+sgUaqAlBrkWR5iNu95ghsBdR5UY4nNXDBx
	 Kdv+YChFa6iiV4xrgFbFkJjJ5dHA4X6t+W4pAX0cQd8BPqG8Bt2RTRyIanc6N3O3WZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xv0rjomnreEwJ3awHfgoaSBNl+BwH7nZQZWEX3r6cz4=;
	b=CQORX8ObFW23p/3vfARBxDa+fFgzpXYjaPklSVgDfPp5XsEQkZ/vJseLA+Pw8DM/tNQE
	 1N4WKi3VaeX+mTLAXGOKN2vlRjkTP9b5YgOS6n7C22HUBwM5IwRfG/QWZ/y8pJMTFHbdD
	 gEXnAIIqIH5PnhmbYRALJUImNeD+CQE51xBhMqaqMVY5opNs8gFHem+8/CpiQnZL+HA+y
	 DapyRwBLC72rQv9iHMcYrN8pQUiz1aTxxPAJu+tnyA3P14/E0lWPSGchlS2bFG1lAk7qK
	 KPhgJexG/J4KWi8pB8QQSbHZgIrNlPbOj6a5Jbg/0j1mIzBQLBeKVjNs36YLNxJFWZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=vK9iC1Fy;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB3606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AB3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=vK9iC1Fy
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so5995355e9.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793362851; x=1793967651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xv0rjomnreEwJ3awHfgoaSBNl+BwH7nZQZWEX3r6cz4=;
        b=vK9iC1FyK8AU7W9Xs1PN7+oSwVPX2LTnrER9xMULro+BBAfwCw+NzzUq8fuPmFvUsr
         KfyA5E5NRHyG0gh84nXK217JDiNYXo+VXlaJrnkFx+TTptTjsSoxP8npCSPAqaifJKFH
         LP9MUs5hzGUGmUah3qIXvYnzzCfvMFcjojA0nE+BQYSUeY4wDD9ZzVf6PDtaU6qWlYnr
         0cQdvZvr4Jm6V5BDO6aAjMUrAEr7QO0mt+yW5+coI0oi+loYDLtocgYF4E5rSjh1BNsh
         cm7Pgk3MuRbWW6Cx3GX+dylge/XEjjqD9syV80ZpfAO5vFNvUVdHAwllFmp1hvSWITB+
         BdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362851; x=1793967651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xv0rjomnreEwJ3awHfgoaSBNl+BwH7nZQZWEX3r6cz4=;
        b=kauNM9KJ4eKgsPyRajVOs+s+RrQOfcR6P6fXT4VsRE6s6p+iTijujXOZkwbpjhtlSa
         +wXapgLP36loR9BM8NppObk+z7ubUOsiiwE5ncLd/ExiS5uXPNHT4vvaODc758xND5fw
         eT7lVTqmM5KZwUbW7wh59uCZeJg0BvX/dMSTo36hMjUqVspeZfxEMXhBIyQ4bcAlEoJ0
         0s1um9yehtQn6KHERfwjWzwBltvjTGg7ZKH0eV4cc/E0qMyqfjaTwM39f+4hWO5oKruj
         n/QriJJHgfGCoNnJzsv1FO3EwMzSHfo6yHBBkf0gk0aASoXZk+gGjh2b//yzvbfpnCfq
         Q+/g==
X-Forwarded-Encrypted: i=1; AKwUvBwhfXQrMbO7sr9WbOigF6H5YOZ4UGR4h31ONoA1+BmUpYcHOH9gRg7Ubi92w09vL2dVofz4PYo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjFAYtg9z35Z42qTieuL4qVvbAKnk7tysKC1Uf+GQha0QnXzN0
	IVsDl0MQqQN1PaJRBVK5Y+Ie9djrckFbOerHdF01VghSj11smwo45tM=
X-Gm-Gg: AYBFou0y2yXrhKSlaNGsK16mz3tUq8JePWWQ7Y+IUx1ovZ+zXG49Ywqq0SKXVxtRYaw
	b44ndDXX+PEBCRzCGDMAx5US/cMOEdB6eH3h0GHOPugA0TmrUjyCDpoGhD0PUDwCRhOaIpTK4si
	PBYrciMtApiI0fdvtuDSpymOL2YjfWnoaljFtujWTczjiOAclrCXAtv6hJYNaS4KVYZSj/MD8yK
	dnB7OF3iJID4JuLofXSAY7r92nchD0YznJgwXYaB9S/t0pdsKkC4LC7//9ZjTdLWdJtiNWuoXFI
	Pu2sO68bAks5TCl4tVa74DeEuZ4NngnWuvpeeB+/ERRlHSnZQDDEb4gx+RxBavR4kPT5qXxCCxM
	nHi2nuj68HIiizJQ5oLANsVjteBSO6qJqr2n5hZsJBYR2olo7/ykDx12Om6s2EtdxnvNpKn9BgW
	3/uVwIH8LfdMY5OMZZ0DkKPE6w2l7KhWpB+kRi1p8PNwmDBRkyZeEayd3c1UpZgawoEOpJJuE9d
	5eMhhdTT0wn4lHpr8/eI26gwy2hhkdbkB6Uy59UCXQlWO6Z5otSYUIUzGhMTE56bdIbziaFtBfC
	i0i9P0iXNEL7S8HDEIhNTA5VafVBbvg8K82sHJp2iDSFf6muHUdZSiYPs4bAcNFMEdoMvgV/Wz9
	wVE0=
X-Received: by 2002:a05:600c:8b55:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4ac19234a06mr43869145e9.31.1793362850528;
        Fri, 30 Oct 2026 05:20:50 -0700 (PDT)
Received: from [192.168.1.3] (p5b057761.dip0.t-ipconnect.de. [91.5.119.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77c132sm41033045e9.1.2026.10.30.05.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 05:20:50 -0700 (PDT)
Message-ID: <e24362cb-bce4-4a9f-b9f5-040aaa2823e0@googlemail.com>
Date: Fri, 30 Oct 2026 13:20:49 +0100
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
Subject: Re: [PATCH 7.2 00/10] 7.2.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261030121255.257615100@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261030121255.257615100@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.10.2026 um 13:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.15 release.

Three minutes after the release of 7.2.14? Really? That's, well... ambitious.


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
