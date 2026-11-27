Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748672;
	b=o0EgBqwtSPyI0uJb9+SE2jk6FgLDndzglppUIm5kVuz7Qf7e1fngZpdKLrUg5LjYwDHC
	 Jl58OZ1YGF1u51UgrX+w4FhSJfqFezxg03ygYYfr8fIipObvKeFnb5+HC5nNn1S1q7doy
	 4J2zwU2yPQOxJNJJiFK4l+MKKtnZnwrG1Xxj8Ka+ggKgwKK7m+2GMPJuEdzPjpGjFR2u/
	 /6cCBClQ1CHXZf952Ww23PEqd2SsDQTlCKTIwaqOVOwh8ywm8HPiiJOyDN3ydUOqdAMtt
	 VzkXVeypBf3NNHpThxK8gNox/wPb9TQjNuwNlHqVIcodgWuh3CdPu1hhslxZB1v1pmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=He0FxAz0Sxy6zOcpGM0GdzaAstOzkTmrMCJae4Q03Aw=;
	b=NO3skrVLTqBrIoeNmd/yCbFDHZXtLfh//xD9lDMyC4OZJzkWnAeolowkO+QLSiZyVc6Q
	 LUtBsMC2JPZRXi8W2KFraNZSeKt7G9iURrOrciUEKhlYrgyfrOYx57HIWHJnTDLtBzsIp
	 zf+RxfRD47UENPPb55losLddzBXmWug1q4UfmUvMQQXxOa1xYv9zNmWmWql6NLuCnau0t
	 8kpzRQZ12sDtL0Wx3nUFIGnWVM/WCtNXZGqcMOpmsyYNq1EgUb0Lz/9sO2vN8cKf1cvcN
	 MeIsSrCrCULVX2uB4cKJOSwmqSwf+oVcuQpAeWaogcORmGxIX8PabHY2UQNl4ZYR0lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=idE7CbRw;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA77606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA77606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=idE7CbRw
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d05d51553so53801435e9.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795748670; x=1796353470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=He0FxAz0Sxy6zOcpGM0GdzaAstOzkTmrMCJae4Q03Aw=;
        b=idE7CbRwL7l7uh1ptKEbnUg/QKOSpSSOgzRysYOuy+Hyo71dsxdLx1gRpEO0nLUz+y
         XlTOAhBI/SO6/fOduuTiSfmCR1KIK69SB5uKcXhb1IOJzJbAJPHBPO7Wn9SNnoSva4y8
         x5jWDvx99GckSaHalgWCmB6PuccwN4Beo/2H/v3OtTjCIFuLjyrcoomqedZKRvZyulev
         QyjNDeJQpdURnVedExBJQxjznlRtO7Yk+VwGTxZfg6vChjAp/WtNkskba98AuTDn6uUT
         JbTY5oWOgH88AcxLpxzfzEuhyAaSSOiLDtG4fVUK+V86MvPf4pDBYaT3Aj29rlkWMe8G
         3k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748670; x=1796353470;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=He0FxAz0Sxy6zOcpGM0GdzaAstOzkTmrMCJae4Q03Aw=;
        b=qPS+CnLvuOdCMyubMM4A8Pzk4gX9L9dCO8OGQPe6AAtlZMlgXAMOH3anD+6iNJvuG5
         r8JENRThKyrL8KHz0zY5KwExW7jILcWMgLG1fXlMcSA6xVIdMcI159DnmUR8yLwJmGHw
         G7uVtN6QF7M0yZP2nAESZjzH5YHPsDRpmSoJ4U63K4dXKn5CN1/xJvHymsYT5N/NsBxm
         n05uzvScFqV8h/LDzFo82ixAy3K8/YQZZ9tKkQBR+XAQKF92F2TU9CNQrwY22C0+PWS/
         95yssMSazfgwaJAED/Oh+GH6ADfXdUYHqRyOn6zLzQVQhndSqOMFYgEiuxi9bGATqX/f
         2DgQ==
X-Forwarded-Encrypted: i=1; AL+hErH5rGyi5zziFLZQLRHZMKIZG+3CpoDcpjtN2wTnT6h1AUIoOtIUy+CUSEjOLoB6bR23qTjgPRA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p4oeWd5m195gzcpe2IQ+jIWwnsYL4+zHRFTzAMqkyJi79hsvV
	Cu3u1o/nSiQTxuDeOQPp4NOkjP8UgJokqPFKqIssSUXx1BAOebMZ/10=
X-Gm-Gg: AZFdTZcLa+fg68HhbEPHfazxXoxd1vaNP1xk7EnGnd2yG0JL6yx00HvqxV2DgGMSd14
	Ddzjx7J0c6gZ0i1061mrX2jWe+k+vX7CTJGu1+RLE8TvCzY8cmVeSjHrCzjVBII8iw1PGXeSDU5
	5HEQnTjcOE4GIZjGI54WVXrps//tfahl8I0NdtO0O5Q0MLmQVSCWwPPUC+FQY0CSy3PgTfajUaC
	Sp+PpeUdNFx1xKBZZPgDm6dlx8WyTObvNVKRxqX2eyWxe3yMO++ux9NzhO9nHooq/0QDlo9gMaN
	jM7eFqjwaVNInURjQnym0fviiPfZ7lJ+nQoSeaDceiUqHjMqGov71BB7afGRrOJ9UG0BxxMbqir
	ikpjlhEWS1uFjfrwQtsOWRQLe8G4PWra6pDmnK5UUtuRAtWbmd3181bgeowRe3F86zukbgtRIli
	mHQ5X7UEYjskCXK2ORhw3dMDio+sQasM3s4Yqa42biTSf3I2JmEZD4soB4sOmUO97oo9TLGE1rL
	o243FpOmff4jf6iFO0sIEWDlvVegP9Ga5CeD6yLyjIMuaNTnV7ObZ3Lpny/6j3yyRs9Yxpn4b0I
	j2kh/UXxwtmNHN3bVYwKTmffuNgXuJiygtTSc0oGTbMlasywzistXcs7xSD61lDn5qw3Z/CCPWh
	1FMs=
X-Received: by 2002:a05:600c:848d:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4bb88810b2dmr448522065e9.16.1795748670262;
        Thu, 26 Nov 2026 19:04:30 -0800 (PST)
Received: from [192.168.1.3] (p5b05722b.dip0.t-ipconnect.de. [91.5.114.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b34e9c3ffesm28601374f8f.19.2026.11.26.19.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 19:04:30 -0800 (PST)
Message-ID: <dcc7e0c9-0bfd-4143-9b75-b6e751fa76da@googlemail.com>
Date: Fri, 27 Nov 2026 04:04:28 +0100
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
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc2 review
To: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org
References: <20261126105725.767748294@linuxfoundation.org>
 <20261126190437.95251-1-ojeda@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261126190437.95251-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.11.2026 um 20:04 schrieb Miguel Ojeda:
> On Thu, 26 Nov 2026 11:58:43 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.18.66 release.
>> There are 990 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat, 28 Nov 2026 10:55:59 +0000.
>> Anything received after that time might be too late.
> 
> Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
> for loongarch64 and arm32:
> 
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> 
> I don't see Peter's `offset_readdir` warning in my QEMU boots, though
> they use a minimal userspace.
> 
The warning message is still there in -rc2 in my build, because Greg had not dropped the two patches yet in -rc2 that I 
found were causing this. Greg was too quick with rc2, our testing time was not up yet ;-) And I was still busy with it, 
and then I wrote my findings after Greg had released it, which I had not noticed then.
Maybe in -rc3, if there is one?!

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
