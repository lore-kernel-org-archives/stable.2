Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF934040D
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791248; cv=none; b=IG5al68pi15FlVkHNm6R6XsVYk4++AgvNhRevlUx/jcEvz8/Tx+gySpiOqUX2rVwM0sI2tuLAvzAi5OSNm2Hq/Bj7RlZxOBlVciK087fRzEYVfQc4R8e+BTLEBRDVpJC5d4OGdQ2dXlNfZN12BbjLNMFFBWzlarTchXPrZmgBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791248; c=relaxed/simple;
	bh=iWoSzUYJLnENnLJ+6d2f18+YRDfc0wb5KlE4uEi2kZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGHYe82hXDd+UgOOnCdqd56tlDhnrPBjs7Q7b+/Nr0f+ReVxIU97+IHgLbSWqKwAyusX5e9gajZWRnSqnZOAPMvNFYXk0AHq7I9nGKaqJ/ejv0VtKUwv+HQEYUYLinwVWiiWm7jWXIe0ZfLbS6xqAu8p2yE6KFgW80OWmT3zx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GMhxFbP6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GMhxFbP6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-471eeac43bfso257991f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784791245; x=1785396045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nth5iIvPYHQYLZs/eqFWoZtm0g6LK9jEijFjgKUtDEA=;
        b=GMhxFbP6lP8XLwE0dptxvNlEWtz4nqbYJj4v+ms/dVWM64LxG281KlQC/ypGiFGeft
         gUetUhpYTPfOM3WWwsf7+LGOeT0p8laErWicCowapVP14LY/mN9zvfBh96oaDCNxmCyn
         ciXbBsltL0TBjsj99EH1j9g/MwLXJOXCMFoitghl+SDTcF/CLMeN52ME7SfmCnRLBkpz
         fz6Hwou31FJNXFeaeHTjmM53c8ztvlRMYVpzDC5n/i3liXB5Jj9T+APsluPw/qYq5j1C
         A2Eq/rBqMrA1nA4Epr908z7/9iZ+m6D6T+TC5Mh6T82hIlU+v+PMFV6tbACphL5jLvkx
         TTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784791245; x=1785396045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nth5iIvPYHQYLZs/eqFWoZtm0g6LK9jEijFjgKUtDEA=;
        b=ftzn8b8Wk/+dN2JDHMYxLl5VNBP3jbiynv4XUn6DDH4DQaiLVTfxfLwEvBtYklz4gG
         AhATyPK7a3gaaQuk2lX5omI7EjEJ3KpqLOzuNB4GwoEYzdB4sqow/bGF8/5nTIkp7ZsO
         qywS8mLAXxWBD7A1KFSKpKF9S70JGZWgtTuQNENLw1+M/GcnFJJeGfa4qUSUx+FBsx4A
         AQ0YltYbKOxgL0vqHH4uWSGgOOLO3CEoteyGTP6FIDoz4f/E7Zi3HP/QI5Ve9923QSov
         VnbLdANxAR4OkJIT9HTrmUlA9w7enN8tvmDjFGjjIRvrxf+0yyeat16QGqTixC7O7A36
         hHBQ==
X-Forwarded-Encrypted: i=1; AHgh+Roe7hW2ApElF0UV1W7psB/ybMpXckFjpUpJLFALQp2AtqIT4G/HPfsLYVPZ8jrCKJjVOSMd374=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhYEVa9pA+CwDxbgymkdm2r/1Ir4/4X+M9OC+ovO6mJVfgkDM
	T+HzW+Qlmg3jy4N3msUjHPzDdSgR2siaFTQcfGQGaWxrhg0Ro13sWFg=
X-Gm-Gg: AR+sD13G3JharZ86hed3tJx/69FC17HWHiTa0tguitAyb+5KrfAcyEqjW/joUV0ynBg
	i01sLo3zbxOWQXP+J49CNNyj+VoZFSLeXZqGbjAvOBwyI29pRtZU2fDDO+8Xe0sBcrpJdd3gaCj
	ciK+7PepPKpXtNv4Qs2DtMTEH1e6Shj1DTid35rmhb4C3KtqEM15a016KDvYPWbxwCLXdXR1qUW
	Wiha2q+L3cTQws/QfDyjWJI4R0IcHz2Vr71+PwplF8lmDlvmR/uKzwecF5x5K14CFtvxSH9Nfm/
	ZSE6RtyMgrR+ib0lNQSdTGAWEYLyrXbMB/h+z+cU6U43YoU8kMjqXJ3L04TPWPOfT2Ay3fTSRbH
	6mq0znJ6ygUydMkSfwtweG+2KGpgVeWBo0Yc5RmsyJZFWUkXLnjubXBhCpGplkhG2qh0awbt6S3
	nGAWOswVemov6mb/RC6SVpV/dVI1m7jLhvCLCp81xMUwk75HeI2EiK8gI=
X-Received: by 2002:a05:6000:3105:b0:47f:83b3:2cb2 with SMTP id ffacd0b85a97d-47f8d770508mr2274615f8f.57.1784791245138;
        Thu, 23 Jul 2026 00:20:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acb97.dip0.t-ipconnect.de. [91.42.203.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm13809444f8f.7.2026.07.23.00.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 00:20:44 -0700 (PDT)
Message-ID: <a01ad02b-0b9f-4af6-b3c9-748814f3e3b2@googlemail.com>
Date: Thu, 23 Jul 2026 09:20:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 0000/1029] 6.1.178-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260722143218.909123637@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260722143218.909123637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2026 um 16:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.178 release.
> There are 1029 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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
