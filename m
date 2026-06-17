Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222648164E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713820; cv=none; b=FJPL4jt4IabxVC6tmkxwsJ694TcZP3TFdW1zyfhDtcDQorv+Jjv8AzE2K8H7/L2IFCG70r6Qbz9+ITuLbP6b0gXUWbsVuITiqxaEdnjf/BpXSudCg69Suyb8iHO4gYluRha8dfZ6kPlBtygwAlRInuO6tyPKAhmKBGHRAsIHoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713820; c=relaxed/simple;
	bh=hsewUNouosKGNpJS30V7SF+ZI6qWwdZuSjy4WguIEJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnYH4HNbQykjyEtTwAUb8iAdQHVpe6et7Kjy3oRhycjDYlf26xy8ZFvp5/QGQqNRRGiRnkHGET5rAC0uI9UTfdXoB5RHELvpGMaAPGGw5EfG3bes/rIB9/hwV2q69SZFmxE8mCWs64Jf3lcpcJEHxKCkz+nXM+Cc15jq52WxqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JWa09O1X; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JWa09O1X"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-460662fcb4eso18674f8f.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1781713814; x=1782318614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2Fz0gfXChJSjKov0DWWEtFMC4KgxCKir1jdmeKrCPA=;
        b=JWa09O1XStTdGQPeGFlZ5wQvVYhgknNqQYF64t23kH9K715IwJJlSycHTr7UjLUy/4
         mnGncL0e3cXbsgc5/uTDhe7Pi6+nv7pT9ejz9xE3mTKSTM54Y6T+vSJKC8o3v7zrs+qm
         0AoIedycRiUUhuKCks7uB8wu6hJkjzQtWfWWJBnOHU4zGw81mqx/qMesIYBepEELbpv7
         SAoNXY37F+4KVB5vPPDxqgi3GfZs5d3XRs27emCBTJ/ZaTtYFdoAWx7v/+fJ5NLzELE0
         UD7tZzB6O58D/PQec70piniu9blsaBjZF1F5ryy7LjKtSBYDWaKfuYQncb8yP82PewNA
         BpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713814; x=1782318614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2Fz0gfXChJSjKov0DWWEtFMC4KgxCKir1jdmeKrCPA=;
        b=Pp5EBJjWWFrmLt5ggGHEFTySabPYHmeD+o9v7SAprHZIuCGIsyPa9nWZXl78OX6FkR
         /ribQzOBhwDDJMvZftsx1JcGkWV0UG5G4fda8p5V6iuQ+Xn0ZEwoWMA4JNtBLbu92YZH
         HCfuaHSuFSj46OTtK/RMVD0jnd7v7xdnfsoAZjpNJwUbvp8P0/U+B6rVQch19v8XHq6l
         ycGpv29A+FIyHCv0mjM8wyJagYzLJIA2U1oLYWShYkfTSd3skoJZCLQzAKw47dGQKOb1
         DUhWv55W9fRrGbMQbRyi/R2YI4B3KdfwMXHxc6r4GJY0AiqqyRdxCYL0l1lbXUbIbeM+
         ixuw==
X-Forwarded-Encrypted: i=1; AFNElJ9OKYyt+vGzJv3GI7p4k7OJgHJqMvE7/9rU1RRfR7+Aa+cpJNSMdmWt3/60zlE+1UyZRkVTZ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2X0kpowC9LZv7yQeHDOFBeBgW2ZVSb3IdrqqEBCpy53QCv6L
	v50vjgKziBto8czVsa4Fw0JqX37BSEWcm9f8lrSyurwOqvGFmhRGCzw=
X-Gm-Gg: AfdE7cnJS0MYxKYQTALs/7NE/TWoELo5RETzBVFjOaW+7SvDy+/P0UIqQrGK7w7WRHO
	Ghi+wkPIlwPZjxnbqs55Gton0t5LMIbuWkljnO+moe/S1gjUVze905RIKQatn5RrlY0lvWYcmXN
	i+9eou5/LAAWlLK3W/kVQKVe47pdVGgECEt+3kKQuQHqgv6rHxmQrj3ozhtV2gXqlicIdy+TjS8
	sl6QnO7aS2fnMMyGNiFnOHwZz58xwep2MyfINp6/HhJYdM+34I14nfO7/64Tjllwde/dR/H84xl
	zqvKZQ2xo+Rflc7hOhYlT4RoPQOxSzknHMwbaHmUuSQlWsGSOcFxc+LEoP12u+Aoz8dhhIhYpmV
	gSOaPiy3jlhOP8cZLhH6AXL0hTlXaGGVe7c/zclxN6nleI94ljwf14AUb4Mv0vSR/hbhalePwC7
	p/KZUeb+pcVcNHhUWXX/kPhw53P+gdMgRsh1i5b9xECieIDg0KLOfcfjMUdPQ1awJ6TqrADbLFE
	r0=
X-Received: by 2002:a5d:45cc:0:b0:45e:945b:276 with SMTP id ffacd0b85a97d-46237d5b277mr5616577f8f.20.1781713814234;
        Wed, 17 Jun 2026 09:30:14 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4777.dip0.t-ipconnect.de. [91.43.71.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm56803202f8f.1.2026.06.17.09.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:30:13 -0700 (PDT)
Message-ID: <96791227-acbc-4a38-b779-a4238f0c2061@googlemail.com>
Date: Wed, 17 Jun 2026 18:30:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/452] 6.6.143-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145117.796205997@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.06.2026 um 16:53 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.143 release.
> There are 452 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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
