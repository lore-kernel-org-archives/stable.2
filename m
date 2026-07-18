Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C41EE7B7
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338979; cv=none; b=ciCH9pZiWl5Uda6kcEt6HP2WcNI7h7W1Kh9cqTySYyvGx5SE8BRnCAgftsvYYJYT8YsGm9T+PY2dq/Zwdysj96eck0bViDtR+OihsZIpx5+zthCjChMrsrCd2uYfGmrV0wCrBAaKXFOmpAFVYB0Cx6tc6qqA0MP4iL8gT+fY2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338979; c=relaxed/simple;
	bh=tzpV5Q+kEKWdMfYHZm/eH1lwHftKZQj4hFItFUavIzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n11V0wta3s2/K6H9TI110Ir/u3UxGtFx7FLSLfGvCy7yHVKDJHPZrpy++4LfwMl7YAgOVD+yWTZ/cLunIWrEQ1jDBd56CaLw7k6nZIIEChQX6sAiC6jWdoNKyHRZiheQIQXF0MfW7YjKtPWgBXcHliW6dMe1FMEu0pKyzBKv3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mCWVU82e; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mCWVU82e"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f25d47dcso32953875e9.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 18:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784338976; x=1784943776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3clgJcwSjud4cWyU1JLhAejxLBMQ4geUn3FcNJdjRU=;
        b=mCWVU82e8CYCV38+Lz2vGG1dCEfECN2CtrGRayivMBYePGSTiGw7SJRdvk/c0Q7EHG
         hM2AMkqYtk1nzoeY3b5Cu3xi5/lOVYGW6o3umjyef8Ug7IcCbVuV5xc4kY8FYcNRq1nD
         jqZ6bq18iiag28VUORsxJymq3R67ST57otyB+CGgMus/vg1OwSBunQeVf5NFzc+HCmwq
         QiFqQ8DSofsHW4wpOV06yDcvx0bo7U109anbgS/dXDuQ2+4q2kmJt5P4kb+aptauQUig
         c8Fqt8kzhvSeahlkhRKRzju9hWerT3UBHqcoRYqXHm25Jo3zsSWj7AXAG60WHNk50OtR
         g5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784338976; x=1784943776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3clgJcwSjud4cWyU1JLhAejxLBMQ4geUn3FcNJdjRU=;
        b=pebBsmBsFUpIeu6CIKLeRWRZeGWgbbMitbu1idYjrc/ubFBfejnLR6ipT5B3ordHyH
         h47y68NO9T0sPpF5LXy9LqJ3c6iZoFVM2UHPdG04IBuJsNmmo8ssTsRFa0pezuoCz0xY
         8/dGMEV4p7ehc6Eoap3gB96nRAW1N4QOT4kWL7bvbkwyB04OhX3jpDICHo+FjU1Jjzb1
         111YhvzZ+h0XQXzKGyWlQaSWlGnWaCFA7UT7EqwzXzn8p8br5T1CY02n19SehIoXjPjj
         xgdo51qVoD2IHRQoZx3qTyN5na+1XH/2BkGM7livMWSnH2LoyXk33HO+xdw+nU/AhPVs
         hM9A==
X-Forwarded-Encrypted: i=1; AHgh+RqtjRZVJhl4I2Y2fv8cksWq2MORZrTmzUL0Vc0W+/jK88DSIuHOPTEtaG5xU+aostzsuav3+n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbExzau0jCs+1whocasJO470Y6OQ0o15gQLkCHNNWEf5pArsu
	l3EXQCT03DufdGM6M5W0aAiRI3aoVf1aaNNbmW5qV+UZK/JN9WEHldo=
X-Gm-Gg: AfdE7ckDFyIoZUplsasdJqfo8LHiRWOUfor0VAn/ceyQiEzHvzSWdoGorSVuZqTwNo7
	FVz3OmCjCgdFCmIYACHBQzVb6+lsqt0VSZuAuowGaYHOMT5auHXOjjNti0NKclZywYINoR4gjku
	70rK6VHPPCVl7J2ZDQmkk3lTn2dMcpnixyg7/rHhzvfzHCEMGFfZRas7ocqWEtODQHk2pKsXles
	c94qS0ssGAIW9lwwpcDldGbxRypC4KIvXkxvgZ1lXlFawTBrzNw70/UJ+mhuM1BSKWh3sFHk/QH
	FB5pVvhP7tPQJW7QR0X4XUYUhLM2KkYFz2imFVMusk/JatdiPGWPyHErykrcUI/6P70KZYajcM9
	Ds4AhwiqFF/QgNL6OlJv/zWQq7ftH0I3gwqeQKitgNcj7p3Z3866xph5kB74GueRcXgMCyeaAaN
	IZ8FxUYaXvPrZjDMnIYiMWI1Z/I/RXJuvSkS5xCxlzoiOvCei8DENo3jI=
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id 5b1f17b1804b1-4954a771521mr56511635e9.33.1784338976025;
        Fri, 17 Jul 2026 18:42:56 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acbcc.dip0.t-ipconnect.de. [91.42.203.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e0fcdbsm90874815e9.2.2026.07.17.18.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 18:42:55 -0700 (PDT)
Message-ID: <7bce7e41-3419-44f7-b184-666c016c755c@googlemail.com>
Date: Sat, 18 Jul 2026 03:42:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/357] 6.12.96-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260717101823.379399592@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260717101823.379399592@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.07.2026 um 12:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.96 release.
> There are 357 patches in this series, all will be posted as a response
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
