Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677187;
	b=THGMo1/4AY+K7N2znhP+jvXAiCtElNDB1P9HPADcMDtgwPNEZqI3XM3PBKw1m7c/WUSv
	 TB4+ZRqmGoIH2MoVvKHwwkLLJmnMuXNxTkNnJPoam82njEc9tNWVRmny3Sj+yZNy89bJ9
	 83y5tVy3eXiZ/bMUa9GvfHnRILbHt2VPPGKcrGH9eOFydVsFAq3+7mWLPI7dYHYcJnTNB
	 PT/SA2P0Aqg9Ur95La52DhuCMt7baQn4JmsFo8bWG4idSAWl+yEo5JRkFRe8lpsr++TsX
	 RDJvkHgEI2BjZE2AfW15nYVQAnkj+6FqeIpxbQTEK38blj96aTAtDmNsXBK7br5Iinw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+znmWJGuLi0+VfYwsBvWce64M+CET7dyCJAEYtt+T78=;
	b=QMe97O4bn/Rmu0CmhB64w++QWo0It+LubrJUzlBHbrVSOVww0yLC/Fj0Y0Kg11zJ5tcD
	 lfaL4XVmwW6a8lwboOZQwBtt5T5+fQce8YJag0nyr30YnRjUxTYhNrDsZ+ZmA1f7ySVrq
	 vOYpUuShaQmceoT6Krgap+uST+19iZD7a6Wd4sUSQqp0xXdHCYHtk8W1eQoVXiMLNCxvS
	 qHHleo0eNfqU+mZSny/9TVSFKgfa9pAEqWz9YG4ijsbQztvJZAKg5+8Xn7r9/HlsNQnoF
	 soPDWLpnXl5nPiiXuxtblLIFJJIiGIXchI5uMfxsYf8E0h7Tsb8EWum3Zs37gvskPCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ciaaPeyD;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A31606A333
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A31606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ciaaPeyD
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so28164795e9.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794677185; x=1795281985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+znmWJGuLi0+VfYwsBvWce64M+CET7dyCJAEYtt+T78=;
        b=ciaaPeyDyB30zKy8ePJ/fnq7GVNQET6QGcbAsEd7sOX2dAEwBufU2eRN1b3V2/5XDv
         t5wrRbIS228H46SsNzIwf//41KVxw6ueiFV+pQyY7VVS5FOVycxtd8UNp3Ky1bVJLhc5
         CDjReWZrfqCuKMv7Dg58T3uneM+uu7jmbiayZbAOkqkCmw6YtBezkQNlec/Dvegjnw+4
         6yAwtngFQVvINq1/WP2sDUW2P9aV8zn3K5C0tVMhh6gkk/Vpxvmi2cN0R6L6jUmkXWfz
         exq/PtuUJ/n/XsHfduargC5IVic+r4Ep6yTOPcK+zQd+fCnqCBsOs+m8Iv3ltRxkZkfe
         jhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794677185; x=1795281985;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+znmWJGuLi0+VfYwsBvWce64M+CET7dyCJAEYtt+T78=;
        b=V20fovqMHHrf+BAJDVQLDyaelutJZYp0/fWGodn4eN51Dxo6j/6hPkjcp4Y0Q+XhJC
         SvdxuCp3IaNnjPXdBGFUVAXXC8udzoGtwF1OBGzNSVa9ixY3NV4mppZmAa0WAqovtzQD
         YxS70rmNpgMaTaL5cYfugUT2gDG9kXGJ3gAzXhms6surfUz9j8kc5XDyTnqHUbTunwuG
         Ch4+4gDrIJxHx1p4yOpEx6gofFD03rvama5GS9aOdFwfbM9P3vR1v+u+PPUhklfpxX4c
         9gSnHIdd4C7iE8/S08t9UqLnr9u5cSK3mKcfPiRJXxicnFIve4b2YlOU+Vf3lYtn/Nfv
         rADQ==
X-Forwarded-Encrypted: i=1; AL+hErFZXbvmJ06hiC4Nedzm20wbt6Ty76o/4HnZS8srzLHjA3lbYTMP3xJRKdYzaUquAG1ss5kmk8k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RMxiCK2BmIATFdl3JyK0TCu4wAWL4Uieot6wuaGTyy2aolwo3
	Tw4bXUcTNcxcl8d7w2HKG1J0gAQchqUsT0Wc0MbKYrNrJkS3121aaOs=
X-Gm-Gg: AYBFou2BessaNnYvf8L9O7B4VpgfrxOCpRcm9sMaLF50FYLStJloOmXSrzAxq1cZXhA
	0Q+D6xvxOI0uEGeHg8To3AML+WNOvvkSbVJk3mGNX4BrhrXPsKvdNiBGhhqFLIkDDLouPHOHQbA
	IF+C2c2qxvjx8RKBXtzfUgRnRCD1/7af9xJsZU6hDj86HqbiWOTEb7ulGpBuYrIQe+pnzHvYXDw
	pBqnPDA/QWII0XaYMWeOwlv/lG6G8kh0BPHVuy5zX3Zguqpu6wCTQ9cHbyZbEttYa2zv2b4Q58+
	eKtblBo48RXEorgBGmSqY9bcajazDWl/OeyXLp8mla+7m5B1hDCmEAeJI06Q4ayN6BnLa6rwDBa
	NeaDRjV/xjxVJ4VfxIUE1CFSLO+0yq7eJYeJu4G2LSqWIKETTxtkpHGzcY9aZ3CIsETcXsN3sfd
	KXwU3ueMyb/EZnoAOw6aKzHWc7REwxGALbH2rMZ/1ZEzdk4t/N7rd7cQ7ac689nwdfYx6Cy1+mE
	9QG2faf3vk3WiwrEpPPp2SAPNUIV3paIfnf+ypjT048QyA9LdNSU7NBT7kMkrWdjw0GhWAPZPaz
	5Bp7j2NAEwrwzgegrtFYOpwF6PJICdGkj4UnXU6RIjhR1k93tARiKroyi9DPqNtZ/8vd5xHA3kp
	CIFNBlA==
X-Received: by 2002:a05:600c:a10a:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4bb55a4f1d8mr90924655e9.15.1794677184998;
        Sat, 14 Nov 2026 09:26:24 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4c4.dip0.t-ipconnect.de. [91.42.196.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm166424125e9.11.2026.11.14.09.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 09:26:24 -0800 (PST)
Message-ID: <7fd966f7-49e3-4ab9-adb8-03ae961d0da4@googlemail.com>
Date: Sat, 14 Nov 2026 18:26:23 +0100
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
Subject: Re: [PATCH 7.3 000/507] 7.3.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261113153753.358973689@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261113153753.358973689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.11.2026 um 16:45 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.3.5 release.
> There are 507 patches in this series, all will be posted as a response
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
