Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795237733;
	b=oJum4RVcErc1zc556U8FlYl/pO8VxCqNFuGG0bveJ5jxkM4G1e6IsKePKuI/Me/zN488
	 6565aVJyzsyM5Mjzwk+TgJkk3Qyxd9PzavmrxEE6G98jTkYyuI041dfJXwNybN547w9Q/
	 rM02yL6EaHxG3ishuAbVdgoikpFrZmWXtoVQU1gA+XYydfKRnj3eCyIXdJNZjZ7VEFnCh
	 yhtSvdg5BBUp/XpljPKX0YSj9qMCN8xb/8lp+ah/f3CbwMN2+vqM/tA5iwBcEdk3HZ67D
	 5BwIDoVUENYCDT1WUK7DQVcEN7gjgwX0ysVKGwSul4tbNcX45JzLP4/4+GD/JodRitg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795237733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zq35YXCPx2V3r1wIC+O3B5GGrUsSEAAKs34AuDkQiBE=;
	b=yx4s+Hy6LR5+b4ItV9DGCpARPDTGTvprdSDOukgVJO+KdHuL47vzQPQCHVT0g+G/sYC6
	 obrcLkWdjo6vPzrVSPnTI5ZQNdsJHfTOdxEhAEvjvbyPpgljWt53Vk/ek+Ve46lVVy7O6
	 lkM/OoRhViFBglXzY0IEoPOJ6xE6EUVm0+vIg401bE/7j/I+MBy1pBWZvmZ0duDQ1lVnH
	 M8Zd3bEKQtPuyIVFOlY1j0eDlb7y1FEeXT8HCqvzr8mW9zyzkVjaxym/C0vQCYXJ59Qmj
	 k+eWidVoXlldwcRQSrwVUTOWspCRHZwlrd9PS7GLgLZIdHRjVkSbpEwRswOspwIhTYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b="tZnt/4Y7";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE31606A693
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 05:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE31606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=tZnt/4Y7
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb61185057so10628465e9.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795237732; x=1795842532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zq35YXCPx2V3r1wIC+O3B5GGrUsSEAAKs34AuDkQiBE=;
        b=tZnt/4Y7RYchW/Xv/P+nub5RSq7O10Uz2tD8QGAgo4NiWxcY8xgsVNfH/37JZWuFaD
         xUiz2wRoOW4b0n36yr7cAhTbOuBnPedxhBwdaXgxSeDyL7RbmNzgv0H1MtrzQqbcUSwk
         xHFlluzBeM10rRkwdul+NCCEadwZY50g4MCOIdGaBQwI32P5gY5IX6WOzxrZhtNhCcPo
         JeQ/6C6AFaAEZswEAUISzl9WWYdYiF1x+qBH9pZYsh+ZiOyP7DI5nQl/qqWgiJaqTb9+
         IiGaVZ1cz4pJ2ILrirF1cnCldLrUqqAa1tv4kKrH4KhtDijozRSQLGAPkUHr7jsJZHjF
         LKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795237732; x=1795842532;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zq35YXCPx2V3r1wIC+O3B5GGrUsSEAAKs34AuDkQiBE=;
        b=X5g08XeCrHLJ9Kn84mnaxNDMqvZRjApVTE7lbwy5uopjAjE5nkGEww3ixNz39Php0w
         Q314j5ksYM2b8N5LuPN2yTDrHV76xUfqDnyQDW1zLl+77LrdD0inPXXekpQ9JL+8keV9
         TzmWEUBIUynJ4fZBPUNIFgzZwqQKM40/IpOvXPGdvwD6f0UjGvKm9Y1dlWgXrwcvfEMT
         zK3UIqxzW4jidAVfzCP1Z8j5uEUZO9PUnjVERxoXtpbgEhjQf4eoEc/e9WedIt+icH7v
         ExQVgv+dh6zAheomiaQtTX4k/TlJ80kF8tDIJdTThhqcGUojDhY267jF+JnhwD2JEt44
         6JEA==
X-Forwarded-Encrypted: i=1; AL+hErHFWJB7xUkQjy+DH3EmjnLDRd5KitQd9MlXF4kw64xQMTfMj/OlbkaEKZpFiJ/PBe4RETg2P2w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CKiBzVmRY1ZEtcGRkG54K9hJPcDqSX18SnXTxTeihwo4hFppO
	0f0wpdWtrmU2yYavx7A+L7ewMZT22UmCGMz9QumrNXF0O9z+z34bC/c=
X-Gm-Gg: AZFdTZdwbZlyooZ1moEPKG+yJH9cjgF0Fjgzb4PRqnjBRWOf5MjrhoIU7rR+A+a98CQ
	x3KjaMVe4WKhlHhU2qhQhHeng6LjZyVww9/vP1rnmNt/d8AYMyavxNbaRkns/S7uYWugv1vwglp
	pQ5Lw7gzgTVr58dExPmdF7eDO2aqXqErFZ/yAi2SUAz8keXf+tkVgH2k6SkVM1wfiT4+bemZ1DT
	XDg8TzKR+eRgC4EcpixXOFkxK8cR6JI3QTGRYUU0HY3/Hz40Q0fbufRqmSJNMEKabXW4iHtx52Y
	0cfvrp7q/+YVoDDghL/yfo9ZNpmIbfntsqk9Rw2+p7IFdftC4/rEujWHsfNEDs+ZYQ2z/5DOc9O
	V8D8VCerKsCKD1jnMIMuklHnPmjMwB7bhFE2hVqgXnNaq2ptY3dgl2oqoxnZU+d3hP5LdSkwU3M
	cUhysmo4+oNhAND4tsPUxwmVuzFsZ4uwy9iMvJ+D//4MP3FOpNfrSTA4fdpJGcKgB6Kwt0VsmQ/
	B1x/tD7vjeaINDBa8QloAJUCKmjaH9wt6hfFxc+cDO9adVtwoUBLuQw8DRgZpdrS2YbXEXiJ31C
	ME3lfrR4YobE8BlsoFQeKHO7olpAxbqfkD1CiU97LdHfopLOnPvHlDjwerQGPBbqB4oTg1e+zcS
	N6EOzXg==
X-Received: by 2002:a05:600c:34c9:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4bb88810d28mr123194735e9.18.1795237731809;
        Fri, 20 Nov 2026 21:08:51 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac65d.dip0.t-ipconnect.de. [91.42.198.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm222372595e9.14.2026.11.20.21.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 21:08:51 -0800 (PST)
Message-ID: <4d8acddd-10ca-4630-95e2-ce2adb76c689@googlemail.com>
Date: Sat, 21 Nov 2026 06:08:50 +0100
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
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120055248.913352689@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261120055248.913352689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.11.2026 um 06:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2642 patches in this series, all will be posted as a response
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
