Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00E223DCE
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693490; cv=none; b=gZoRwhhXsY3z2bN2LO0Xn0Ya2CRIwAkNzlijIgSTyX4At3JdAQdH8nC+EeMp1ECpZCsQDezlmiKUJhZrY+1H+pKvUmWcTuA7NrFI5BtVtNFY3ihYJUJWzN1e0zoi0a9hu7lV4YOn+05D6q+ftB1Ia+ISDlPMuLtxG7Xz6z0NCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693490; c=relaxed/simple;
	bh=xSAn2eA+gsK2NX+/wquGLiUFNntJe9ngu2Rama6GOdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Du1sOOomiQKtzSQTVF2HpalHusHP+MZLPx093dL5+FG276VS6D+fLYJmVMia43vNUwY2X5tj3CNgClCJk79mvZ3mhCA5oIKsHGuJwrgnULAqFnJGCT4MH+HTYoewe6zf6KuvOwk+1nAyNw8JGTTu5obaa0vKcy3CoskvW0RAeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiCF9Jms; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiCF9Jms"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d530328efbso3668115ad.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787693487; x=1788298287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmIh6qdKxbDeRlvcOdLJQsm/geP5sjQy9z3qmCMHb8g=;
        b=qiCF9Jmsxsug/RsqB60maU1BEbJeJg0YkBk3cOrrKcYO/sXSwFi/Ob+hWKlKodb/O+
         KVvRd/gsXex7HEV27EO96mFzSb9WgiVxoswtf1X5+5ZZgeKwnij9XiQZmJ9I38Y2p1zr
         R8klDPfG4Xy+Gb14BdNppYbDVpoavoGdnSadg63s8jYFPj2StjXq4pHDX6DE+OU9rk1S
         pef21qNnkM/dPfmhn/5ff6YIRRQkushMb2nbNJF+Qa2HOCP6Hcbl5qhqTA38Lg95eILL
         5oo22u+RKARAp16wFD34Jxwh+DbmJUfU8GwUSm98LsvAj/MDCmOmQfVcnWH4VfQ6s855
         mmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787693487; x=1788298287;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmIh6qdKxbDeRlvcOdLJQsm/geP5sjQy9z3qmCMHb8g=;
        b=EZ5L17xTXZSEliQ+UFLD4+l1nFvjv5pmOon6ntmM+VddYJAlMEjMdfvuO3bDh5L/DP
         SstZNQM21q5Hh3h/zarULF3mFLe6jLX4mIfd+R8OY5w+7LtbW/qSArKgYvnGxsgdrHtr
         5L3UAvUZicqmEbbs2ZQgq0ZYyZkMpjgzQB+rwuOs61UaulAxAupS/iha0mBDsX1LbzWh
         XZkW/BWlqx8AoPN415BZpwAjCecWAMKonudYFCsRqQQa0qWEicOR0t4NO3Il1wty2I5i
         ozw1kW4OLn+ZBdn9BZoYxhRRHPxt3TbNfMMosi3pJBVQHeMkbnleD7fUGfMrLGiax6ls
         IRWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHocctF0ubsApp8CJmz2y226Kj3f4EovdZrwgQz8lqcW5vEuEZ5pTuLFqk8WcwuUgMnnIi03o=@vger.kernel.org
X-Gm-Message-State: AFuF++mSFKiZLoRaxuXfdZ82383iqzqNRUbjUJgVVrydB122tbOth04p
	Vy8vdMBTNVPR0uceVVPTJbWywOwxxkWeDKmBUWGEeG2lly9lQB36YmM38aYlWOSM
X-Gm-Gg: AR+sD10c6EcyxVQBPWVkPRGnWrk2dn+zd/PEmP9heRMTvvDqRlt47dm4uyCmKzyth3d
	rmvrNpae/WegU4xKfaf+aBcNX34l5NxELY4Jfmvor09xAfE1wMejOmhGJ04Dic/MRtq7PO6FGZT
	6QpCvVa4XLgBmmvu6EYQKF4rj6/+MO+VSGgPtLS0eE2TyNF9X0pvitxrIEYa6FdSPvPr4kP61E4
	jsBpdI+Il3yEUs5Yg6Sm/ukwkL25s2CLhnTVR8D+JxRwWmJ2SfMRY91HzL8bm53US9taz9kDVkb
	0pJNlaelaLsmXvWugNIOOmeigPuiksYONqIJh72jas/jh9OlbmZmxCG3cSfcjyRD6sJ+cPU4uVN
	G0kcQ9fPQQn6Gwi2IZXzkCnPbb7KnNXLw2xyLkoXhMlK7mE0GjC6AACRgrIVRUl5mfhAvY8+rJZ
	HtLipztvu1CfvD6x0U+0BFyfcrDv6/QuAqR2+KVmrVdh5Phil8zcRC2tGy3jU9WOF/d9pDN3MvQ
	LaUZWyfrxxWnhqp
X-Received: by 2002:a17:903:19ed:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d7079ffa9fmr22032265ad.6.1787693487074;
        Tue, 25 Aug 2026 14:31:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm3197944eec.6.2026.08.25.14.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 14:31:26 -0700 (PDT)
Message-ID: <d1e23ddc-f85b-4c4f-b866-f7d34b498b2a@gmail.com>
Date: Tue, 25 Aug 2026 14:31:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/79] 6.1.185-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.677185791@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.677185791@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.185 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.185-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
