Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795236422;
	b=Fdl+RaRp0sMNbgbVkxAQnIWK+kCROtVfqjtingVKG+y7Jd8Hx/Sge0aLLVj+m0avITN9
	 Hahtmiv7NMQaQdStvh0mP4OVALOwBS3lnDuNEqfBn6t4eX4VAn8NTcjfmZlCAA98bi9I3
	 mqZgoO5Xr6c1ovv4q4IHLoEMuV5qn+fTa3SfJ9XIMuJ1DHRdD/einM8Cs4lRtjuh8hgPD
	 dwX4ZyyYL4yaEnEo7in2UwGO2nVw4MCDUml+NFL9hEccqjOEtXIMQwka13gASZN72sBDi
	 Wk2XHf3RvKed9jI0oAJGu4JqAIp/Prau3piPbQ3nGvMfUP+xFsoDm+EWlRZy9ERwSfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795236422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/CB9rx6q4lOQyZURMO9hFHlkxUMK+i+s+ovpJy5IDcE=;
	b=zZ8/XMemaDuiIGM30qu9blreYRgM5IPSHrCdk6Spx2n5UCme0CYd2QXF/EWVyPc+cW6k
	 E72N2wjaAdD82W20q70wXBNAXPIOQeXK4Yc5LjF2RACHm1Gui/vvhIjPTubryjqpHd4t4
	 lIMVAzbDmQ449zqONVh19CrGpw9ii4uYdeaV92UZm7p02eVpexlVc2owXbS4X8jFbuJRX
	 2F8g7N8O4YRtqEOQt8ozlMkqtaQuwOjBcOAeVqHsRSx865GrBI+W0IHUM7O9S+nFwS1H+
	 GjarQYLJtAPJ2d7xuqRn20P7Y+HYoZQWSxNDi7HYVJrl9Pj3cZQimys5IV8G39kMTgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i9K36LQ5;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EE606A6B2
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 314EE606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i9K36LQ5
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ebf4cd218so10659706d6.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795236420; x=1795841220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/CB9rx6q4lOQyZURMO9hFHlkxUMK+i+s+ovpJy5IDcE=;
        b=i9K36LQ5ciHWWwSCGPt+YuFZddoXX8yIBdGAkskkYPev32LtoMD6oC0fHogDY00NZF
         ehbz8TKRocNGkoX2F3Ogjrs6pUHejsbgR/hZ5sLuh7SPlPvPp1VOrYSyFZCpf0bKHwu7
         1zndkY2+wWnjFNUx8p6WVTEbHxeK5YwHhPhJaJltnL9Jy1J7yzN0HS721pZv30cPkwTj
         SPcOz+WZRhfwC7Plj3iUEIvGmnxsZOnpe75FUG2pLpiZEJeiebZWefc0J7y4ygPEcPsN
         4hB3Pu25bTFoVCsTCj9LBG3sVlxrd7hBGsE3Sac1vTTvveKs9s22yvGflPps5rXSzJTF
         aeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795236420; x=1795841220;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/CB9rx6q4lOQyZURMO9hFHlkxUMK+i+s+ovpJy5IDcE=;
        b=0qbKXwkpL9biJHpSwsDk/mVhS/3UtiNiuU1LBNrP+svXGWsLg7z0+OfLgAVbpco5RI
         ps7DFe/F6DMSDrD5DL6v8Ck87AepMm8+quyB+/yUPeUZrCFaChimwQ+KJauJuOycZ4F6
         n3NrB/7ycP72pTjLro/w2Wpx3hHMGBlPSAcI36Vg20nsdrS3fxVXfx8R6DCHN6G7aG/R
         DCg3s59F3ZqoRPoj8ZTe13+dXJSil5yBl9pGGjNTvQniUg3I6spkFts210dQdxNBeNfx
         byz4Qc+rTd7nhGVdz/dK6X00pTT2ztRadkJjX7RT/V82R9YRHs+LYgRdC7tVjrFiaIgs
         1EAA==
X-Forwarded-Encrypted: i=1; AL+hErFA37j3SqZP/HG807wOsCNRWEBkyEQyma3FeGP6nE3vCGL+uO2ZUcVL9EfSqJCgnojtUP1SDQI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/orgS7cGwI5TicEwB9nrptvjOLGrZ3GPeDAZV53nW45yxz6eSu
	ra9cP4xKmzTteBny8WyJOqlGW+gvDTwM01R+tGjgefr/DvOB7IzIhM0=
X-Gm-Gg: AZFdTZf2o4RzGGE0oKzkRSJ48h/FFNlYu3Hb4Jkp30aIwYdUXrWeO+YLe1WO+DXny0M
	iedctBXT03htj2RraJoA7NrK1SmYQZ3FFgfbxc+/sitOCcUyrTWfJA5+euhWHEeSijoPm6BvPaf
	a2YYA3waC/TmNcExoP+RsRIDK5WjbsmlpyjljqsCphWXaxR6FjT59e5TWhJtjFUb5xVxV5SCi1C
	wvy31ViqnujKBgiXeT1DmbXpKI6HWlvDaWteHlKlUY3Oj1TQFo8nHANsHKpa9wQcta2j+X9jeRX
	K7/JQXJF33MWaE5Wt0xVm+zx/ujEcBx/i/dOEYbLuRyCAnrRaNH3FQ/aRVH8RMamdmUXAQR8+kc
	/X78jgE2xs72SoOd0/duP1+L46sJaKxN4+cnphshqeloIJzwVoOqvbNQOQdpmhWPxONVLSCL56y
	KH7s1Q1MxxyisPxNm6yMbdfg2i3/0K/J1JRiUH+fOpbka9aYpAgItWxqn0noa2DhStSfsKiNXKm
	lheifUgFhp2g5mP5TtFezrxLCyEGPve45SnO0rdYUisEm3Ons0/AQAxoxU+vFAKjJEH4z42phiJ
	uMrPfRyw68FYuf2mJgZNIEVeHEIClj+ILWWdfC4Lv9e4jyYLIV+TN6M0AjGN2R908dTQpcNXXnP
	tccCRGJ/T6Q==
X-Received: by 2002:a05:6214:5701:b0:91f:12f9:fc6e with SMTP id 6a1803df08f44-92134a9b97bmr100160196d6.31.1795236420154;
        Fri, 20 Nov 2026 20:47:00 -0800 (PST)
Received: from [120.7.1.23] (198-84-204-175.cpe.teksavvy.com. [198.84.204.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b0b10sm44711596d6.10.2026.11.20.20.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 20:46:59 -0800 (PST)
Subject: Re: [PATCH 5.10 0000/1811] 5.10.275-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120054906.397973290@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <488235ed-c296-4d76-6d3f-430db7877922@gmail.com>
Date: Fri, 20 Nov 2026 23:47:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101
 Firefox/140.0 SeaMonkey/2.53.25
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261120054906.397973290@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.275 release.
> There are 1811 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
>
>
Built OK for i386, tested on a 32-bit EeePC.
No problems noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

