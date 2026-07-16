Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3633546F6
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232579; cv=none; b=BPKSE3bm9z6+mztN6HiN9nmi+GZOxXez2TGQaxw0mtUGDzHHUfGOlKZcDRY+95o2EuS+Xqqy0MB31IbdMd+7nV6h94aWp453DV8svjiX8Jqxe9Wd+idJWfMysEr6iPelAHO3hcQXpV5Wgo4Mpp+U4YLZkaChtk+gR6FWa+bf2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232579; c=relaxed/simple;
	bh=H+KIRhNgThMTsLA0M+cuXqY7CDX08Fk7i5sOfIkrzEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPZbVkfDUUdiZgoIjpoyHimr6PMrq1Bb8EDiwU/rhzQoURfcrdAfdQ/sfl0yBRiEzOSkeBXNcMXEVvca8mZ3SwG3A/D+ceXgfh8zcF1Xd/NHWzL1RYPsAAPd613Qrde/yQ3QyQlfgN1/Vn7w57YjoZbVABd5M2CcH4wgmLOzPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=T9uK42fa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T9uK42fa"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47362928f65so6374992f8f.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784232576; x=1784837376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9J0UGoE+FEdlPHZ2PqItoZRXJEq8jYYBebyY842C4o=;
        b=T9uK42faADBP4lOLBnvAOwAfUPLTyPjHAk8eezVSPvpDkWqMTBTMtMChmsSW7xoI7m
         bHb6h8ZWOovanH0MQx3M3Ps2k12Unlmvi/VTPY31UoGkzvJcCUT5AV1IhqRC5EUQTHq7
         U7a7TDtW73Uz8YDWFGxHKYcR4q72HBiyRuc00yfk2Jfl7qSDv3x8Ttf04f67nKMyBdxu
         mjX6iR3SXad8+JPboxeJ3nbePYGqtB1bv2N07WAuIvJ2c2E9EjhhPDg3P8LtuhJ0ADIX
         2Oc/LinsdsWPDaXwLiCwP37N6dm/WOK4ZoPpnU0s6/sNIvOXA0OCVN6NPmDiC0tgvBDN
         k9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784232576; x=1784837376;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9J0UGoE+FEdlPHZ2PqItoZRXJEq8jYYBebyY842C4o=;
        b=nn8uL8hyhvB8pVfIYiyV44HP981aNuiIketVE9k0T8JbZft6vInHrcAvWnsOmq01sE
         Honmcu3/3tpBMsDuftJV7MQnWDhTPmDLyU+z5P9kWFAm1ccLs+UUqiBVb4kLeu6PS75o
         ROStpjdiLNUFcCKTuIo5CMeUU1/X2BXj661wo/fIWKduyhuyea6dejYPaOi1m8VuzphC
         wBSyRYAW1zHBvsk2ckexH8JGmk3eetZDtd+8LwXOQxB2OKwYA4gtCgOval86JMWsS+KD
         t48aM9mkNYdOnLj4SuCwiJR00wm0g6r33EShcuTdxqm/b9pOGMFlY4dnYueBC4tSxbIn
         0VgQ==
X-Forwarded-Encrypted: i=1; AHgh+RooExd9AYq/r76P+Iy3aBXlZ06gFh/wxoZNlOdEdFXP+JuXA885g3jUkikqICn2h5N7Bczq1yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcdvGjIlqgG0dff6yTfzmdk8JvfgzzNFXfupYrvsmkxkflL7VR
	AUoADRjWCyBru2Qf50+Ksr7ww53YhAMXiqMnFu75x4KSgWEKVjsthnw=
X-Gm-Gg: AfdE7ckEul1eobOlvb3JrwR8O4apZaYbv0m6at6Gwvce8bNwp1eC1XrDVNIa1WB/J6L
	nQiN2YDS1ZC3McpGKmlsdP/8aknT5tvnPG/XwtVMZuCEul1xPklZhNkSuKAm6EWP83/Y00wzkUQ
	pCxMgHClOC2RHZ+zXwhoUHx9BbFNOghE2eh2ajux+SgXQddVVdC6rSSdNDD7O0Ku01wg3GNYk8B
	677pK+zCIxZcMh2W/pTD34RynGPQ30WpXiXoQUdtqUaXDOrfFeMwmSSvcdrMxMCzzTg6w5kxHOF
	yfwtLhMvpv/gwL2P7T25iN+FjoXTcFUiLuhHzn7sTFAJtNdsm7Vf6DRVQfLB4IeG9YmbuKjjCfD
	EDEU1oCRpIcFkrA4w2o/9eLIEiK8lccuESpDG2ZQ5bCtZ0BhrpVPOiIQ1TEMaHUFdPGauooudwQ
	gjQbTdm3VQ1lu6ZBp8pRY69kpx3/8bhALYK49APmOl6wrC3oTB/BtAsGOoiiKzqESV
X-Received: by 2002:a05:6000:18af:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-47f4885669dmr16323760f8f.14.1784232576301;
        Thu, 16 Jul 2026 13:09:36 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b44d3.dip0.t-ipconnect.de. [91.43.68.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635c86csm27192504f8f.16.2026.07.16.13.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 13:09:36 -0700 (PDT)
Message-ID: <8b127459-4aa1-4887-9920-7debecf2658b@googlemail.com>
Date: Thu, 16 Jul 2026 22:09:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/349] 6.12.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260716133033.287196923@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260716133033.287196923@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.07.2026 um 15:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.96 release.
> There are 349 patches in this series, all will be posted as a response
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
