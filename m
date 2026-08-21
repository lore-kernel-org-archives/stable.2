Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918939099C
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318521; cv=none; b=N7xk92dzd0vCvTRphP0HxnKSrdKBUfkR2qvm241FCFNzX1HQiNlwtJQzXBq+try7rRdRcCtjom/UBm97sutPjp8XC+2ac4E5M6u2fDJ4kLHn5jsznHt45uXDQDdrkLVrXP+wYhmrhAD11lnapMzunhOyq2hmBHiCz7K5yMkJ7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318521; c=relaxed/simple;
	bh=RQg3xA6rwb9np995dLqi+teIPepo7EW4N1UEpxqVX14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NafHpoy8Wl3btOLJSxGtkD8Lfwj+SevSgYlQHSlPuB6Jqwcb1jsMqQQsA+cobnXTasnzKuPO53Q89J+kGE5tLRzUsgcn0lIV42X4V9bLEomr/Obv1/iD7i+sFixstHryiXnficBf7ct81qf/avr0N4iq6Sap2uIv0IMFggUZJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nZM+QD0J; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nZM+QD0J"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso159362566b.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787318512; x=1787923312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G3lUMoCTXIuvo/lvc/TnhyCBtsYQ1ZJf5IigNILfKr8=;
        b=nZM+QD0Jn/99M5lyleKlVHvAfXlR2TPgPhQbaFx3eUctyZKfz08dQEmV4FJ6p7dF8b
         FKPrd7lcNscYgJmKCZO4mPA+GO5LOqX9PfeRrorlecIcOl6CTJTUXaEdfnCGrAGPU8fV
         3ZYBwLGuBj30l7HAityUbVXJLKgJTqUdhOf13sH0Q2X6yt65mqC6a9m6rQPcaJB9PzWZ
         yTd9GVk1AaF5Sj97C3mGfZIXr03EUY3toBKRd7vCATgEzsb57SZ+/aXP+30YJtAyscqx
         RPrth8eW0ZaBo5OUNnRuRLLsMko0hIRRf7kH0B9PRjBLZIAJW97w3iULn64jTPaR9IyC
         dQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318512; x=1787923312;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3lUMoCTXIuvo/lvc/TnhyCBtsYQ1ZJf5IigNILfKr8=;
        b=T3JqDpVmapUdej+ClcOmafqVLDWgd8SFLmvD5uaIBn6DqG0M0iACsZs4yvKcNQr0Th
         qT2gnksDyWLnMnzEojh83JWDAETpDwK5uys0QC4jSCSOA/qIGikkzKWGXL8vOqHgKL/5
         rat029KBYZCCxDsmQ8gxykN13LtwRjLQGYIJ2XB8vyJxatUUYX1v5VeXi8w6SMtQo0mJ
         HB9GPHDWwjmoSUhoaC5qkXJFsrrcUsPAELE4UXZTq3wgWnjU+pAwvMc14pmc0C95IMpF
         gbSGav4gwmQAG59RiMn3xBMtOTvDeFbavIuYOgaDSwwYM4evkVAYpOuf2TVp4zUweKGs
         oDYA==
X-Forwarded-Encrypted: i=1; AHgh+Rrh1L8ji4DKwZxPJ946AtjoIQrzdqXXAvMJX2ZNTjYYTWmjOYjYMA8KmZ+7KPTve3bx4Vo7vTs=@vger.kernel.org
X-Gm-Message-State: AFuF++mO9sTs7Zvk3VE7lJCXo8daifyTKf495zd2hfXjg0a+wowsBB3y
	ybI3zV6E+Qx81549xgR3SEQ+gYI5tQMSaSOOFLjIFJEHr1+T2gSGAgA=
X-Gm-Gg: AR+sD128aZWQBJHAywD3Mu4VDct8iJCejSPz5WlRHyuMKH7533bzH/bQGsCTa5i+MKt
	tJ1uODo3W7GrnRj1uw2FScI+hHMm2Gl0LXhJ1uMPFZw+I0o5zmdGE25Kcg3dP/hG/oUwqnC+t54
	StiORA9i3f9j4B+aWkjXMwAv4WJA2MSx5Vv29o1m4XnlU6IPI4baDdSVJfDukvBBluTS/dYav6k
	UOcWWy7z7jMwn3qnk4gis64AFSZ50yGvlNy2bhdxaBvnXXR+l2YhLfWLnaJFwB8UUBR9aJs+iu1
	ST/OTE+1S2ksmAcYlF7PdvF4iTa1M3d3z9RqKeTOqz6AQgOuyW+T98PRpzAsPrHvi3DAYqPkCH8
	gXCm4LivryLBAAw6mn0He3FB07LstV5ohzDEengfTeb2PppAwvqt7VxVcqmGfk/eNI35NssFGzk
	l7Cv5FX4zzpKUaGj/X2r5qNniRhD6tGUV5bcpwoAkfkPusrG5CSqV1QQCztyrEHbM0Ts6ekdp28
	q5xVZ1Z0W5StIFX3tddxoB3QUo7G8GoGOq3ShOIxA==
X-Received: by 2002:a17:907:6d26:b0:c15:dcc6:d06d with SMTP id a640c23a62f3a-c2469f9cbb0mr613567566b.0.1787318512095;
        Fri, 21 Aug 2026 06:21:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac6d4.dip0.t-ipconnect.de. [91.42.198.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b09349sm465679566b.19.2026.08.21.06.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:21:51 -0700 (PDT)
Message-ID: <3a42c3c7-cd23-46d4-bec5-ad54e74028ae@googlemail.com>
Date: Fri, 21 Aug 2026 15:21:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/217] 6.18.46-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260820145237.531699751@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260820145237.531699751@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.08.2026 um 16:52 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.46 release.
> There are 217 patches in this series, all will be posted as a response
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
