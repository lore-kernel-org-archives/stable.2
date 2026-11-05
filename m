Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864339;
	b=gmfG/SQ19PSazASTR2hSohyn4WFW+KCrp1k0bRs/Le9FAIwi43SeRNJbPkuIJmPGLJPr
	 3ri69hmHj3egAhHwmFrfDHdA2efYvddUsPANHsYnTb/1UP+GrL6p5n3cKq+U02E9r69Eb
	 3/bfsQJSVrM1Tzt/vcNUvvv2k5U8XfKf1+Et/gHPqJ984EF7qf+tCNUVpRPV6xzK90AFD
	 lc8NQaG1QCOHqEi98+y3ZuD+A5cYUQfuTfn0XzI2nXoLYGM3+hFsX8N2Iq/g27tDVYqPe
	 MRWNxX0E23Sh3ZLqlr1ilEeTyeODm8eqwZx1ZA52Eldjc0iIodLgDgVcjcBkXTdkRwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CnrMMQppxmI6EGSsQCvw1P8oldla87L6eez+yQ0O3fk=;
	b=2TjkiIkoMJnGnEG6ggLqogoUybPP5PBEdaDaTd1pb389sfue5Km2LKax5PuAi1jX2pup
	 lXmFLz30rfXz4YObUJdnWWU8MBJO9DTHtay8Tbu4L3N2ycHKafDCTdS6X5LnRDR3nMxyN
	 vTG+g2c6XYwbgzTrq0qWZAZn1gdmTTvx4OQfv8fVN473ygbeEVMAUQqjwRMImEJznJruV
	 4uZYE8Qaq8iEJI0ewt7twNtnWGH/b5l1Jqp/ybhyQ9uWn+Fwqh2pfIZ5kbAqOio8TJ6DX
	 kpiOwKMqtaLYpPGo69Slb1kwklh/LdKZgwqZqNefyn3Siqupx7fHpP1qzibA2Tk6ahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=jGxcuEN8;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D052606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D052606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=jGxcuEN8
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e10a70540so922489f8f.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793864337; x=1794469137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnrMMQppxmI6EGSsQCvw1P8oldla87L6eez+yQ0O3fk=;
        b=jGxcuEN81wio3/XEklGBGKGH3fDIeW54XUe+UScH6HCEvSGrlDprVDTVLlS469A+VE
         Ib4nYVR1aiEr2JZINbYzc0Km08M4kMmqG/rAp9UjuSoS5TB+jHYJWyh8tIX1nD8SeGPo
         GtFz7iwxtD7/grmghvPlamKV0dzeNizNd02w4Pc2+STzodOOUmYIjg19lOdilHorJCaE
         AwP4dMkndzRXK3nw/zqvqgjkWJFfey9CFb9SO6f3fSnNOHAabAkLSQq8MAq6gNTP1CpZ
         dBe98U5gCom/dCK0E8/FwFzX32g6z6lMvoWYKnyIZSfqNdfZ243uU6J+yijR4B/Aim82
         S2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793864337; x=1794469137;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CnrMMQppxmI6EGSsQCvw1P8oldla87L6eez+yQ0O3fk=;
        b=bHOyfObDhcqtMObdTSPTxQpR0zg0L/s2a+LhcJbF3BwXyZBuTGVdvjedCCE/fy6EUx
         e4AHhe9oLLHsrGO1C8J3YofB6xBN0a3GuNSQ1BZ5isD4IEb157/4w3K06v4Q1tfBPKgD
         Jp3KehoBoXBxWgfYB2CsFIyM8CU06fT1/s0H7ltRyPX0gSdYN6ICEfcXrtGfkf8qtEeY
         b2wz04ClVs2jb3T89vIppgcvzY7wp2TVWJmBqjSW4I/IAq0884ej54fc3DEd/XAf1YSx
         vpBe18AV9+7wXmO73ONRt6zJshEV0wqT5qqOIZT0DJ5LuaDHoVoALcgvcIs6+fE4RsSh
         Dgpw==
X-Forwarded-Encrypted: i=1; AKwUvByjJKIQtAkJyk8zcpZv9FUKVLd8BazRfGpru5Rs6A+yWkEQ/f08UW3wYZy0cWJVuEdP9Lko3A4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hs+YTXMApLQwC6OoZcVQIbkNsP6Rq9RF5k9hnZ1YpmZUvKjPw
	CO3s7z2LRnJQaxRdDuNX70wYU6pQvIwxaxl0JE0Psqx4k3O00uB0Ts8=
X-Gm-Gg: AYBFou0jCKW1eT/7ztnmwr/O2IqKbqMhTBrv2GTebPRnhd3o2RZBL3TqpibyoDP74WT
	dJsMDcrS8ueNyjdVH0A2fW4ZzclUNDSyVRybtbLKVFOpbtlxW5X0o7NvnF5hZi20qlrBAGRZHik
	UdJGbZcV7SlghgxUhGY/NJ0wEHrwcDe8JA2r5ExWQ3hpj7Bijfc2lYjuaJ4z6Y444fWUPk/Zwig
	DYO94Qzm6+Hx7so2ix8Gf20Nlh6anlXOlG0DL8zt4n3ASy6EHgl0TpuNdE/98aVYowfoVdZGuWd
	0bpwZPGQUZQxUZQdAkwUKAmlh66M2n8apeAjmvCP4M7saTIEP8fLWEt+VRImK17kJtrZwnghBAP
	Lcn46KXXYFw4eQvziDoqFGYuDVvWI/n5BprjeMSGPvbmAscTQkWitPKiBjhYsStav5tDnGHyi+p
	Q3zdJ2EziW8f19wpuuvzP+c7PDGiGT6QwMeL2fk93H5RvMVc+/Ql84OmC32femU3LaSXstnqTCM
	/HQlv+OgBhsQeNqW1/4Sbk1/h/d1UZStMD6xs078SHd6yF+cq8qweZpCqQ9yg4GHk8abUcfJO9y
	jdkdoiLhBcqRU91YX1AXgsZSED0QJE914mDQHikr1KQsUXXRJhA+nS8nmhIDbnSnFf4mzAaF6f1
	epg==
X-Received: by 2002:a5d:5f07:0:b0:48d:ef7d:4b4c with SMTP id ffacd0b85a97d-48e6e4f8c4dmr38866485f8f.44.1793864336714;
        Wed, 04 Nov 2026 23:38:56 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4618.dip0.t-ipconnect.de. [91.43.70.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1f100sm8472216f8f.46.2026.11.04.23.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 23:38:56 -0800 (PST)
Message-ID: <5588d6e7-8507-46c6-a872-20c536901f1d@googlemail.com>
Date: Thu, 5 Nov 2026 08:38:55 +0100
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
Subject: Re: [PATCH 6.18 0000/1005] 6.18.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261104211043.516122098@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261104211043.516122098@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.11.2026 um 21:55 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.61 release.
> There are 1005 patches in this series, all will be posted as a response
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
