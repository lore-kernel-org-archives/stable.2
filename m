Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674688;
	b=W8E16OFDGJ8TjbQOY2hnoUznGMXX6WLvzbBoSsCT6iet0mSWeZmiVv+GYfKLIPbVp0WN
	 isiGpmgI4JKKMvea2ReYv3nRdvwikYwj7XeNLSgGT+LlSoCNX8PQXWaRTWpFMQV/QIvEf
	 vT4anmfaPRREBVSoFoED/Mxy+RnFqUIyFRKVdkytnBTxSeqs/pwWAG8q5BRGpXsum8xpO
	 H2nGvP8yNoiEaQ765/ZcoeEEzFPpSQjo5uQ9qDgro5YsprAc3H57QNJLE1YGHQf32s1qK
	 8mFEhRHYYAZCR+X1LbJVr7mrMhxuDz8gKFDHiF0uo2fYsVSTMQMN9gNXzIcKk5LJDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=h4axWdmxX9gtDkNwklTEbzWCcmvgV4kr9k9kh9hjp2s=;
	b=SDwiO+SWj93bdt5aKpfjZILdDawbEhgB/N9TEAMPQXqgrdbv0GZ/4GpcnoqD54t/Ca/O
	 W2McccZLEue6hWCAE31KA29S2yRd9qHHN0F/1vUj+ROk4prHgGF5UVBJJKauzya2XqLOG
	 g8hvLNyDK8/RSWmBfHr/z6w6ojSK2X8J6ze/35lldRoBsDy+DGmloPb5pZCBJP3oh8DGe
	 PcjKvp22OcyCGNwUhqomkjxsWPEa6BGtgQqLu9WNqbw4NAFPw1iThdvLJIF0KQrTlThLx
	 G5Za8dWAayqeCeO5Zq4l5Hupdw9MIBO2B1D3JrEdPKOaJunE5qwoocBIy46+MlXszcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=WapXwFRy;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD2606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84AD2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=WapXwFRy
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49a92144733so769906f8f.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794674687; x=1795279487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4axWdmxX9gtDkNwklTEbzWCcmvgV4kr9k9kh9hjp2s=;
        b=WapXwFRyLE4UMSQQp6q74hJxJZKhvMEzr8td3rBwUpnZtlQt82GSLJ09wU1d/BwnqN
         ckJXxMSsygktQmcmqJXu42j0g7IlbU2xj4zPInT14vpP7NFmnNqKyteWm9kZ7eiZVSD/
         INaA6H3c6NYOM9/fZeotBlWUHZ4mFZr7BgLQrWCkcVEyISboFdYV5e+9umRO85qajUn/
         3p8VxS1xieGaSvdrnt+y/cNNUTWC8ufdx7TCgdbR4MYdFPHfRmUHm2PKDmCK6zcnEeTK
         XmkUHcij75iAp1eEqMoHLj/XCDD6sF+s1GX3viZcxmbx5ZXh1SXpC2CdL2Mtgt0rab14
         +HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674687; x=1795279487;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4axWdmxX9gtDkNwklTEbzWCcmvgV4kr9k9kh9hjp2s=;
        b=qSlsZUiaqHpVC1eAAGpuBsWGD+oIIunMLm2Dblq86O+h4H4tC89unB8OFOB0HviBLq
         LUYad81KIswl5e+MNp/7UXmV+dwb7cBce+TO5wGwIc1QpSMZ9jJRgofcqLD3H7qOoM5o
         zfUGFgyZPcBhMxYgFBDP8HOsWdR3bPKyETiIM0bSOrGXDIc7ayGgKQm2zuW8dQfeQs12
         gGOJ7WNbhPvKRwLLs8yvFs+DnI2TxUGnLlAeZoMjNopaJFwQRXLhs5WDjGV2jE58qzUn
         KnHpazV/mIFwTsYhzZVVuQUi1/+xbByGD131DCTrao1y8M7eZ073Law5nkvmZng8t9oH
         LYVQ==
X-Forwarded-Encrypted: i=1; AL+hErHP0aYCxVgxuykO2grJ6L2ZPoHvXjHJYBQcssBecsI4q35MczQ09WDYY0LZo1d5bIWLo8/Qo/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZzGLwn7PzI0lQ8PHrSlM7LlS7oc+ZfjxQYH7AXXKyTlWFXNZ8
	+on+IwX6XvaMydKf13+eWl7J8loG6u5xvPpI1vEjYDcvefs8o+i6te8=
X-Gm-Gg: AYBFou2euH9H9CKKUn/GnF1lAmp4U+VU9WHpMfwEuZ9/QHKbq3LCBlsdndcuZX+0amC
	LgqREgDBiEpVcZoStx0AdgDnMv/12y+to9I0hp47LBwgrPc+DdMccjvy0dUT8z3+B90N5m+hRrT
	lmi9vC88WRmk7JGxS84aiqeRSD5GGbVhBN9DiJ0r8JbJ0f6HjWeXNNrT344aB/jpdFSJT6SMPes
	8bLN9xTrymMQhjXp+D/V4NqJ/Y/5ukPA7cKSPU/c4E2Dql6bnKiPBfwg3NBgMlhIz8MqrZ+5EU+
	HwsbcC4G6mI4b23T8/eyUy2ZATuJEMV+7jAi+2C7GODxF72xfyHhJxKKl6Dz8mhnl7d8g1FIF6a
	RCEn/Cwva9K1v+Oj5MWHLCoubiWJbaCIbpULPhHK0sM9H1J4rGFgc0pp9P99LM8S/BLagyhEW6I
	Cx+9tv+OZVdeZy1h1D0ss2w2ebTGxiEOR3eGlZKcOjbrYDv7YvQiDwT7wU3MMejuCgPv1DlRBut
	KzcLd2bW5L9q3kTR58rhZpxI9ocn91ol0DbgQS1i3T/7r497NRkmB+e/LnoCb7eeYxwaMTVsL1K
	udIP2R9XXn22Zhk4utMIR05eOboayV6LffJBnKqP+IyvMhrXt9/mBmE1TF/N+iiH9u/87hiEKBO
	vGAO14g==
X-Received: by 2002:a05:6000:2007:b0:491:7ab7:81a1 with SMTP id ffacd0b85a97d-49c72c9be63mr11913231f8f.46.1794674686748;
        Sat, 14 Nov 2026 08:44:46 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4c4.dip0.t-ipconnect.de. [91.42.196.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8e794sm11806540f8f.59.2026.11.14.08.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 08:44:46 -0800 (PST)
Message-ID: <6bd63228-03f5-42e8-a7b1-367007d8dcc0@googlemail.com>
Date: Sat, 14 Nov 2026 17:44:44 +0100
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
Subject: Re: [PATCH 6.18 000/686] 6.18.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261113153820.902362109@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261113153820.902362109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.11.2026 um 16:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.64 release.
> There are 686 patches in this series, all will be posted as a response
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
