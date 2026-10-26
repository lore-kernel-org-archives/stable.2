Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040079;
	b=FnstiAPgpAj2KgETTeITuRYmc9AENbnwAON6iLYYD0r/2Z9U5W+LmHUjFLd5dV+4lO2N
	 NFP2cN9LXDaUI/2iofV1yrhKnwjifw66RKTXA3Ql/4PUabLxXdkzTbXAIb6p0AySr9UuJ
	 FL4pYdRR6MqovpK3XygR84DDLaC/FKsoe+DWTHXRmj8SBRbAwQjt4ZCK55m2TmaswnVd9
	 oomQVxIsO6uQkyFNy8UWW/+i+JlAPW9QFuUnB503IaNsvEQi/sKx4nut66JQxnNwg3A4c
	 xHKxN/S6kpfvEg8CsTHGEjynUE10+Si2W7UiRMXkEXJ+wt4t5nUiDshrGN+H6pHk/6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=g1SrbF6MexHYCEG2Z9HqDiWdRSH1K217RRXRSida3VI=;
	b=5kyyHKr+xeaRtlgAfz9fEk4auUBH98yCjPKmBReZ4mi3VadzavbJecjIRge2bCXOcRR+
	 fMNz0lFCK9RKyrKLEwg5x00vg5DDZLyeox3V1vM2BkCSGZWWRegVe8xm3tWE0S1r2c09f
	 pBfASa5gcrJu0j6sz0VgdgQ/P19V2hrF+zJGZYdb7wi0xiOW7FfI7jGDD5rc53Ua+s/af
	 FMYsH1CynOf7boVtFKaFm5Toucn1N3LvJ42/HExDobetrptyglSaM8O8gdxQ3LBKX8tzD
	 IwlQcgDS6qOb4wvEFzGOsMa4ZRctv3VvwBQ90KfK3k74qVG8iZ5GCc5QJ7P6JCpwa4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Gs72zGSW;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873D606A324
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8873D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Gs72zGSW
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-53aa0802881so1729897b6e.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793040076; x=1793644876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1SrbF6MexHYCEG2Z9HqDiWdRSH1K217RRXRSida3VI=;
        b=Gs72zGSWLplhI4YGGyxTLX6F3MV/6q75OPBFoK0d54H4NG0ayR/xMgS29zw8VNY3Xx
         En2PKwL712VHdJFpxx2QT5nnIGwiC9vm0iI0dS0RIyIz2df8TVlhj5IGP5x22qsUO6Ly
         aKp2hSu2WqgpzhrIcswbCU5rZeYhJ7ma8F0U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040076; x=1793644876;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g1SrbF6MexHYCEG2Z9HqDiWdRSH1K217RRXRSida3VI=;
        b=QfQP3km19T0m3L89ZoIdbUvbhYsEkW94DIohhz/r8HOC7PJcnL1DTJSsFS4VW/nRvw
         QaLxlNte0URur4K47B/epsG2LuhKdqyC7uNuFOkDo0Hoy2nZgf8WyGHvoupZD3lrGPEg
         1FQEVe9Bul8LJXMUdHPaZQqtXb/XshCKd0WKAW19FtwBXdwx/rcUDuL+Rg7lFXM5TbQU
         O8Z9ZQDInggJWL7W5GBcKdzd8EzC2qf8y2zV+PpME9sxVSNHO2y8GyFnK4MH7rf9XNFl
         wHVC+6JQ0rn4sqICvRCQ05S9MMyhfN4Wg0bGSEN95/Jm8Ks+ejSufk5LgvDK2o/1Diq5
         AlJg==
X-Forwarded-Encrypted: i=1; AKwUvBzWBlgX2SxcV7LoQ0PEV3T2yKke4QI+SaxZv7RVaZLwnbAnHoVoVOT+4uYg1B2r+CwKboaTJgU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI33SOU4FWvCG8CMEZT17jQPKzJUMQ1/jeeqbGXhM6d0ijgTKWg
	5zPaB65amemcAsLSi5p78uq3BwHLH/iK/kIMWdfma4+DRPb3XtdElpdBhi6RYk8CtO0=
X-Gm-Gg: AYBFou29QgsBaTknehLbqYafti6u2ElVVtC6QfFXwznxttVmKXDsJeEZQNGFZdEZqx/
	caHKc73lacAShRUU+j2lvqCSBqd7MZDxmRp0iAIWTn0A312gxSYq9OxO/CLkY3kUhW/vAt+8Jze
	lTCJeInG3ZXC9qQ/7xyebLXb/JfIB8KkEoSlm4i2RmR3FQxKo90tSBKXr0LZRCLSxkdA4Gn4Zjj
	FAtynqlMXIjLDR3mvb48Yv0NN6lXayt4ynclm+UZ0gYgvMNznCD11wgb7b/Xgb7h8Sim2BM60ZO
	kE5yUOfQ2nn3HrkQbjRG4wDvAd+dQXgYfnTjm30Z5vjNUa+CoaipGdx25zMDQ7qAIV7cDQVqXSR
	5dBjRhY5tKvVvUuH9o/gTsihrkAsrq+pxkx9w+KUJm2nXzL7uvLPyF6wUyMm3xgr3eveBQeCP9S
	M6XvkfYNZ75CxvUGtysyas9vr+mOurU+vapWkFi4otDuxNNn+4dR4EJY+TI7lgYzq5asn9AH8gz
	JvqjBdWyQ4+XJMYNox/IQBCuaCrYQD6Cz6Pp0qenjmo4Au47BvUqV1AutUCWqtE0w==
X-Received: by 2002:a05:6808:c40a:b0:4f5:c4b9:dbfa with SMTP id 5614622812f47-55c0030f23amr5326997b6e.48.1793040076466;
        Mon, 26 Oct 2026 11:41:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04074375sm6051582b6e.1.2026.10.26.11.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:41:15 -0700 (PDT)
Message-ID: <855636a8-36f3-412d-b4e6-d780fd1ff85c@linuxfoundation.org>
Date: Mon, 26 Oct 2026 12:41:08 -0600
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
Subject: Re: [PATCH 6.18 000/193] 6.18.59-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261023163714.201276352@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261023163714.201276352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 10:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.59 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 25 Oct 2026 16:36:50 +0000.
> Anything received after that time might be too late.

Might be late but here it is.
  
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
