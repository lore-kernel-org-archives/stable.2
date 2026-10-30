Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365084;
	b=wV/Fc6bb1noEzktXnQJRPTlfumxvHfa+mY4yZAj3Hw3Fblhpug4XzjSvl6epyNLHWA53
	 ZBSujOo8s6/IM+NHE3H4d3r0ZTPRZp8EZtTTfcMxUVWHOnpvc0xtImJJdYkd950jycUnm
	 6O0nSBUoAK3+Wge7wB1poXI8Oga2NRnRoynAQfu+BLqzB1T6CjXLPIiCwWhJaTSLWFgBh
	 wjDUvlkT0KWHTKLIppd3jxuNLUmw09HJ3B8dIW6xg8dCxhsxM/df4hx9e34EiD+zv+V8L
	 2p2lIynz7hpDstQZ4z/dwwwpF38kYA1nuNqMwUIywrl4MDDAvt75NcqZ6JMPLKmnAkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LpHGJG4BEsUziEetvXn6JA6Aaleh7lKdquZ/MLf5ANY=;
	b=DNFHSmzS9JfZZq4URZXOtTz9eF1wnaomi+bKQRTl3CmJBVNNrf+gCxuxMwUMvQ/i7rpA
	 s3aRBFGP9J6CeZg45SFrXjXX7TV0DE5EhTbMIlfZ0Yvd4IRN6HfK5/PJLkkSVzC9Bo1p0
	 DvYSfP9CISa0tZgJO9SZg4H2uJE9Ns+SyUm5XIv5OzSR55V9kpoLqp9njmYqeuefOaO4k
	 WYKqWQA69uar+J8OmlQzSOYGMZG58LWtu/3fWsZa7h8H1KR5glfXV/l/CxcvDdt0eM/zT
	 /asCDbTenLMXkMm31ysBFxPiMqqpi8mNyzpBEVvuDT5t/gZs1vcNQFaUDslhJPocFlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Qz334WFk;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F0606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462F0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Qz334WFk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso6729675e9.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793365083; x=1793969883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpHGJG4BEsUziEetvXn6JA6Aaleh7lKdquZ/MLf5ANY=;
        b=Qz334WFkgLIZsypknNzqsiXv24AnHflDVmpRVjVDwjHACZ5barjISGPcth5IUIotkE
         EhSxraKuiHCHdKLJY7P2/KsD1W7H0NAiWWsLfgwK1yF9cyy1V09pFNDZBFuPvIOHySnp
         agtxsfqmc+GoPDrIv3/r7/F1JUp3KoeuYv1Xvb5z3k9D0816ugXOoZsO8KvLZz0OzjSr
         sTNEJV/1cRMWs1uQyqVY0wRyooeaW17BUbF9dMsGp/r//F9etA6cKQ+NozTI9UQCDF7S
         Bge7auJdEeGdlU5UGRVe0AixqLbtQ7XFOW8mDs9XKGnsVVFnIGLYr0iJn1pZLbCbiX3T
         1JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365083; x=1793969883;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpHGJG4BEsUziEetvXn6JA6Aaleh7lKdquZ/MLf5ANY=;
        b=dd6E0KsyW3wQdb5tdhgxqnhL1fBqFSOa2FMCCRbY/Bvv6qD/i4LWyEo0dtPANblQDr
         lWX3x4BpJJFj3hqj9dzqllfjoy+u6HqnC42eyfE6BwzdEzQwvLZkSgqeJRTOVuwaDdYO
         WdM8Q4xtEB1S+UyYQE3fgtsQ3SU0iDAoUfxFLP5ESobuHhu2KuW0eEkfZZM3TgQa8VOz
         /wljQy5pF3KtPLmaJA9EXrRx3GZerYa6Apxre0+8G8gk3CsKy+RIfcRKixt3T5fvdd2B
         1KaB6im2qEhMBdIDzj3UsBV/NeKSYlGhrtwK8WWlCU1sJikOw3pJws7b8B8LCTcOkTNA
         rUYQ==
X-Gm-Message-State: AFq9FYIX03FjaFluAnIr51QGowL/vVYgPUIdkoVNOEv2y/LJ5baEArDa
	YarR0jRxvedk98aTPtunk6ew4ml3dW2Zn6FYhvOrRrMfFZJl612t9fA=
X-Gm-Gg: AYBFou02LET8sZ4+e3k8o9wthA+is9yPXIinNKPVh1DSm4QBIg8npRRNs30QW66y7r3
	T4gcuQ0APJszISFWPOxAU2fWGqAoqUZWDWRRkUsE2i3wSYEod+dg++Bpkz2QTTyAcmImQg+rpp5
	e7n0f1Cwe2E9kjj2yuVRLXJubi82+/0gr072bfnlZhHM3kktQOHEy5hOKWYwOAFuLgT7lfqD5QO
	coyHVDaX+h+Zbq1KVniDzYJCj/EfB9sY46OBZ0RQPJ5sgxgoGJafr2cFaQcGXEDPV3CaR66oVJ1
	IU7Ok63beiVD2tLQbAyQKnX4fQfZYzbi7PWOtGL4gQyH+pgI7wy+jO8Q68ZU3E8y+ZJcm7Q/6/U
	2TSKIcUSR/dwiQ0myu2oMrEukHWMFgplfgi/5KVkVaI4VPpLnJheXHAXvIOWIGNcVAfwca1ZxlK
	pjdcUq0C0tWKGQHyq8fvzOd6t2OEpg36u3RHlAL4CSQ2lbYAu2kjlOujv9mdxs+6TKZ26XY5Oj9
	kaOFtGpWxqp5ReKbxps6ddjc7kVgSfQdv1D7ad+3J7EYaREBCd4Fot2Mr0QDVUUq3LA8h3FkifS
	O1xHo9GTn9HbyLgiOkWBGgGZ48Jq3P5PJFG9+o5Q6xDYmyfWhUU/Gp1MQxtCrSjPtBWx1KU0RLW
	9ukw=
X-Received: by 2002:a05:600c:1910:b0:4a7:4697:dae3 with SMTP id 5b1f17b1804b1-4ac17a360d9mr51142165e9.24.1793365082439;
        Fri, 30 Oct 2026 05:58:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b057761.dip0.t-ipconnect.de. [91.5.119.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8bd8esm3027169f8f.42.2026.10.30.05.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 05:58:01 -0700 (PDT)
Message-ID: <9a349321-21eb-4897-a897-74d6d4416138@googlemail.com>
Date: Fri, 30 Oct 2026 13:58:00 +0100
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
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261030121255.257615100@linuxfoundation.org>
 <e24362cb-bce4-4a9f-b9f5-040aaa2823e0@googlemail.com>
 <2026103019-badge-android-5e34@gregkh>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <2026103019-badge-android-5e34@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.10.2026 um 13:51 schrieb Greg Kroah-Hartman:
> On Fri, Oct 30, 2026 at 01:20:49PM +0100, Peter Schneider wrote:
>> Am 30.10.2026 um 13:15 schrieb Greg Kroah-Hartman:
>>> This is the start of the stable review cycle for the 7.2.15 release.
>>
>> Three minutes after the release of 7.2.14? Really? That's, well... ambitious.
> 
> Yes it is :)
> 
> I want this to be the last 7.2.y release, and everyone move to 7.3.y
> after it is out in a day or so.  We have just too many stable kernels
> "in flight" right now, and too many pending patches based on the huge
> number of bugfixes flowing through the system right now.  This is an
> attempt to keep on top of that by reducing our release load (and your
> testing load).

Ah ok, understood. That makes perfect sense.

I was wondering, anyway, how on earth you and Sasha manage that immense workload. I guessed that you must have, 
together, at least twelve arms and five heads to be able to do what you are doing.

I have to say, that I am damn glad that I don't have your job! 😉😁

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
