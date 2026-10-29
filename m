Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793240119;
	b=QbVuUzt3fNS9xIw+ulBPNr8XkR3OtGNtciQvm+ockFATICWKhMYghjwBYAOMlO4S9JOj
	 ZLM3llOGGuaONrHYSDmA5sIX6E/kiwhzCFqqtgtic3mPlad2jUWS7h68SICG2QNyQBipo
	 GV/HZB+8WaDxOuv8bOP2ktWX4rtQmMdG0IRMwrNBE9hI9KroIfkDXkD0nvnOv+jb88ZTs
	 sR/0h979pP1tb7JLDlN6oDzVepptvyxhZQGn5nvh5bozvOQBB8oPGiw00ZlMXfaYnDvr2
	 9omhQTskujf2RLiM0aM4ZrlSQZydLShPLcTWU6dlqWLTze40C4ym4rcRcMkvVD3/Aew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dhqqpxGxhV+d9yusyc+fq0FJI6GkW6OrpwpzJ7OfA8I=;
	b=WS2TVrAu1nRf40R5kFa7D5CkBtzjPIeN9GQBXHpL2hZKkU2RlGerS9eLWuc+VyZueJme
	 TmC2OuhebbAQ3yB7d8DasTxykpHwaCJuhegbuuIgF5N0rkzoJ57RH8IE8JH3xoGbAQCDh
	 eH7lBvK3F47eT3AZavTBpbWLwK4+x2uVWk8x8Ei1DTEE+3oBGkDaCk8Bsi/Jx5IhmYQ7A
	 9hIRsP9FiBnN9XkDtg/l16ikk+Lo8LhuX+nVk7kUxQpcwmw/mkJgjXlwsEtKsYdtm3VDF
	 Ya8M8dFKSp7v4s+V/5gLdG37JLwiEhohP8YnmJ2Em5TgeoAFrYbhpRR4JCsx6NJ1H6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=CCODWCd6;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80670606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80670606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=CCODWCd6
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso14033325e9.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793240118; x=1793844918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhqqpxGxhV+d9yusyc+fq0FJI6GkW6OrpwpzJ7OfA8I=;
        b=CCODWCd67waSVo9IjzUtS95sjmvA7mxAVZEvYYxJ/45BaAmf9i4FhSKhygBKjJyzm7
         OOcfNFBB6tGIDC8F/kR13vXpBY55CmVuh/XBW47/LQiFcw1UDptf00ogSt8kQPKGbWXQ
         tIEJLZtBW+e/EMm30HRKK3o5bZkyrx6yMnKUIhg8Ww8CHLXYznA2Z6N82vAYc9ctOuIf
         8kY4IFyuCcjC3iUHPqVT0AD3Qf9HhHHYOFTrkf7+NDTBSBVdmmG26F1elUQ8D0w71FfL
         HvS0j9sfuYFITq1d9JrieyUaqUJVv7wXblv2FehOBIJ1psuvIx6pDXwv6gFNpzZhf6E+
         CzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793240118; x=1793844918;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhqqpxGxhV+d9yusyc+fq0FJI6GkW6OrpwpzJ7OfA8I=;
        b=igyXgJ+OHiGxz+lyzXtz5mmYsTGK9lXS1bbcZ4jE4J9Gywt4Z3RFALrIFXwXM48JOe
         z8CwK7D7j73XGjnFL2pMewnxT7zM6mKWThk6ZiR0yo0TcljqGFxBwbmsZFYiL20j2h7c
         iaOIL4oDE4Y8QhNTorygItngrJrexV3WPB7/G39J4i+Dwuas0/8XmG04uzVjZUWLO4wd
         IQpb9QDvlG4F85paqx3QFhvk/nQA86LdHCiMq7JzSLHAMPEA0ta1db++l2SLyFycXdTM
         63PN34PRuRWwLchRlXfjxtnZBDXWWo+6XQLUyvK9nA5mt+qzKPuNm6l+DsTh1B00EzgF
         TaLA==
X-Forwarded-Encrypted: i=1; AKwUvBxzJJWNKKjSZu1PIuY63c7qDrEpKZCm5uSUkLtKf8bxQq/ZlnmVh2jIr/Am5124+36MYW8bUco=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPEeRarVe9/Rb83P52opehfTsjDRqkglLXy2Y6MJ6T4gmRhRSL
	QUGGkRtyvJwtLL5dFj4+r1Vg/wwyxsu+M5KfBGFfBlu4myjngrG1P60=
X-Gm-Gg: AYBFou3wRWWqqKKW5KeOCYux1/nWPgzV2XM92eyrXiPvyev4LpuXn6Z897IgvXunhyb
	aj3qKJAXsMT6gtuBnmEH5YeDoyaP2p7XY377eJCZ1kZBdWGzck6ZWrH4bwrgt6RtRxXIWTPua7I
	UYnshGlKhzwPn3SZjjyfUIDGLjzwSvn8Z+T3fw0sCd6fHgFe9KGcrfaz6BCkU1wSPsJrQhw/VF5
	sibKTebZyeX/E0IY8AbChY+NEjkSpgg+2R6ikEWPRCakXeQSQCMZ4L0xVGsGwzXznsYlcClvSSx
	VkUgJhx3wUY42/VFz3QUmmzeLKmYZpktCPcqrKhwg3kdLFQFzlse3g8R29/Muq+glir6UPa/t/2
	/c1q2tVvv/iEYexamTsveJNOOL4z1c2ERRXHnhFfhEZlhiPzvs2Nwh9Z8PClJseZC8GQIFmqJ/N
	KvO2i26AaiWJThFd/kYIL2tQdzJ7v3MMkUmC8Urti1+8nsJ+CWxeVWAlgZDalgB4Q/fAb1E3pGd
	V13imHgcLnIlV8VrnDsZZwbcSv/oRf1paCR1HIQrFH7sj8dFNPdBLjECbTa4t9RVu9zQwi4crI3
	+2KK/cHfYXnxGyss6Ex9SSikggfeimWtOdk54Vn/CfxoTHGXsc+1IxdbP7I9YizwPTb5624gYBj
	LUyABjoj+8KE/OYSzGryFCNzGxTE=
X-Received: by 2002:a05:600d:11:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a974528f91mr69963645e9.0.1793240117667;
        Wed, 28 Oct 2026 19:15:17 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd9f.dip0.t-ipconnect.de. [91.42.205.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm46337915e9.8.2026.10.28.19.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 19:15:17 -0700 (PDT)
Message-ID: <054aab03-ce22-4beb-9d7e-b6d8264fadb3@googlemail.com>
Date: Thu, 29 Oct 2026 03:15:13 +0100
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
Subject: Re: [PATCH 6.12 000/247] 6.12.115-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165947.349197979@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261028165947.349197979@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2026 um 17:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.115 release.
> There are 247 patches in this series, all will be posted as a response
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
