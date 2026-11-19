Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048322;
	b=tbMp07w0UIrYajzTkdavPkmq3x0uTpiYt11B1Fx59bCndSKE5M3k9V4RvhIDJDIJCAWq
	 1scuUp4e5g51JQgt1eC4kvreYjc8tIbfO+R4vD3qwzotTBmxC04dykgun5H7OXzErV33S
	 9o0+6AEHTF5v2IPkD3JRw4+2u09IN3sJqv6n+WhRXg15NRuEgBmhBIgMR3jUnN90wKUnq
	 mDg/tgzLVXUF5TKF6tKda9GvgiqN4/8N1mbzW5V/tjMtswNVXO0Fw6eQY+S87tQUU3glA
	 0p4Y/QlTwgeF7JrIJO5gMQbudB0d7uAaS4KQfM+PhRBGl5q5DWCm4bIDKQAx3NtCLUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EmJ9n+7z7H7Pdfstw1q7EPzAbXgdZ2VMyW5XMf764DE=;
	b=plWEwhyX2V6znjI/TnXWcWtf9cVOGVfRIty18hsvdRaBKXlABhUz2LeXC6boG7Gt5grD
	 1gHlDloO3hng/Id0JgbadBvrJOI8qoMtDRNKOQ6dr0XJrnEeguJbg9Bf9GN/Khy5Xm2tn
	 VhWdKrrlVbxofMI9sjCmEnNOx1K00/7/0weRpSKrZnegJgGTcDjy5tj+gu0nVTQjZNb6C
	 HVp/TWdJH55LlaxwVnxxbhWTYCX152ZWj9/q1jA7PLH3kbgQUN3v5PdDGZSmBq4gUmSJ2
	 rWorxl3LawNfAXN1xDOSQnKxsEMW/EgOabdE5KsKGD5BCJA1hY4DiICa7Ow4mo8nvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=LyUjzDkg;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6C606A333
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E6C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=LyUjzDkg
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so12919955e9.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795048320; x=1795653120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EmJ9n+7z7H7Pdfstw1q7EPzAbXgdZ2VMyW5XMf764DE=;
        b=LyUjzDkgjpwY2fqh8cRQj1z6c1X1PUz2whV1WJU84ENXoWJ6X3QpVxiUOGchTFKyqF
         VWjvAt/zIr1sA+FOfWNYG8fj0AcuZolKce6EumJuHIOBeKzm91x1QW+P2hpzja8L0Ei1
         krFzD/ivvNOmsgfYdZZkVVcijajcLGDzH4+LrPYmkig7nUKOsOlePJd3bO001SjsRKOj
         FXlg1K0i33QALaum+QOVL28G5y9w3fVK1akHp1kV6HvcRC9Qnhacnrff5nbyUPYSi5Wf
         aGxJQupN+C7Ca0rVam7emy0sfsQKSoz85ZH3Zbd2CCljAOJer6e7Azr0SJ+Svj//3P6U
         b8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048320; x=1795653120;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EmJ9n+7z7H7Pdfstw1q7EPzAbXgdZ2VMyW5XMf764DE=;
        b=OA/5Mgu+xSL2GOmVTDSD58QCGHAyIYFOyibhf0scZLRWDTbRBeV5/YL8gxOjGwg9AC
         E27PvZgJISF4D0YxvG8lLbW92rh2xo5R8UYN5kV7OGpU5ZpHBghWYQ9XrBxKJUL3XR4J
         Fp3y8VSD6Gg6w9TMVXbznLeH3ymmDoNBxka9F2ZtXHH5aAg5Rbf7QplLQDvbsfF9W1y2
         Y1w6bA3C3Akqe6T4l1jlpmolyKvYQ7WXFDsBdYKioJnk/YsVCaRocXz4OTwCMMxlX3Ps
         MrZaWNl0gv5RtVyA6e4hrO/1j/0VT2rIRJVye8089EJeyGj9Ddygz2MfKoLaeO06uzdU
         7f2A==
X-Forwarded-Encrypted: i=1; AL+hErF80LOqiqHrBBrJxwbc7EG2sqeUGe+L6LFYlA7dO7sktkCne2jc5SgKex+e5irY27FC+0TPx/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Yjd/baXpZJAF8tyRPIjOHOIWSDdJN1PeyT9Xii5KClVFV8J4A
	9Zz3Wi2hfNNh9MlqY+70L61hnr0h/hD4v3rQeBATkYXncW3/sKMNbz0=
X-Gm-Gg: AYBFou0sbDjIFZajhoiIlYUGydeSWg5CRyPXrQmMRMX6H8PPx99+5sd1GdkuD5yLaT+
	8NU4+wK88cFnNfykp+pQziutN30cb/Zkief7YeihhdTxNtqyvozQj1raIQ5ZKWX8Jfwv1l/xoXu
	lJKoKG3c6xqJNT9iVSuoOBJcZPbRNSYYa/MbH0L55qD7kMk39KzRFHAglZTvQ+LeA5w2e3h+E/l
	zxvzDgV8/soiFrk9+pr+IfPMtQPjCf5usEJhAolhQc46JCcDIs6WsQoF1KGziFvtQy3tGPd/4wf
	OtYLxwRRo9ZNcHX6VU2UfBf1phf8hO5vFUHUcnt4sXD71zk4XBBs5LU+9kden2Fi2/QtjcvLfbC
	igdBlYnMIqVaWa8XPnM5z+pIWtRpcuNm6j7c/LqscmhRtSZ58EORW6TbQ+5OmBPIYB3bM69uuoH
	jItT4vFTCCnWe5luUe4nj3tbb7sfaYZ8pNo3mv53cnt+6t60uvJY5LKtgvnLwJgeefWzILmlfQT
	0wF0WhDG6oz1X9sWBfFN/xaMpsOaAGwJ6zKpVFQsoZo2JpTi/Lj5j0vHwaeAhQxN70Ex5FjF6ga
	hi1Fj7uxtWLAA/OwzlWHfbU8TnH3njLsEwulSwVFdRWqVHY2oNHB3giHit6JxnA9nlkhuei1c0V
	z03dxNQu2Ik4BwF8RpfemMWmrjcw=
X-Received: by 2002:a05:600c:8b05:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb7da26eacmr82453255e9.29.1795048320249;
        Wed, 18 Nov 2026 16:32:00 -0800 (PST)
Received: from [192.168.1.3] (p5b2acb64.dip0.t-ipconnect.de. [91.42.203.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb845095dfsm13761465e9.5.2026.11.18.16.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 16:32:00 -0800 (PST)
Message-ID: <62c31ebf-0752-4208-afd7-57baae9fd73c@googlemail.com>
Date: Thu, 19 Nov 2026 01:31:59 +0100
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
Subject: Re: [PATCH 6.6 0000/3318] 6.6.163-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150313.527275416@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261118150313.527275416@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 18.11.2026 um 15:10 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

It's really a bit scary that the "new normal" these days seems to be that these RCs are so massive, 3318 patches, WOW!

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
