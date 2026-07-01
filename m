Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99002395AEB
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937868; cv=none; b=fCL2EPwEoEEAZ6erSORvuJRvlnEf4M4u/LZxwdC3uJ2M40u4zSch2iMzp2PrlBVvwiTpq6t+QstWSKSwokP34rEzJIT0XlTHwevpOaFgbv3PWzFKjFjNgncyR2Mh3KA3Ft8OMygLUIRrJKa/bHPGX8/bR4Sq7cUYdUtLTPWHMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937868; c=relaxed/simple;
	bh=sJb1hpPoJvea7G7luaxcB0X03g/OToAr3zQtJFOLpTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/Jo9aC806HPUsGNHv34ZnpXZ6IPoAzFHBXH28I2epT9qJfAFvnIAWSgRtc7LiL33sQaHQhxCzRfDYLcEdGi4wD2coJiJ0FYvWdxXXzNiW//AJswl+5vIDkzcm/0uzFHRpDeoHde3q+a19ZTGXu2u7mtcLpyeHN4/UwSsoYmC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=BhG3hNme; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="BhG3hNme"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9e89fded0so9791685ad.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782937867; x=1783542667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJb1hpPoJvea7G7luaxcB0X03g/OToAr3zQtJFOLpTk=;
        b=BhG3hNmevinikbQJMYKq/RKT0K4a4jvzcdBxKWbd0pU85Bfbu3S08Qe28WPN2jJkeE
         DpQo95m9+o/M+ZeLDdURHpaIpXVc8Njvdsp8tuM9k8NcErHjUTOowyuRbjtKDvAc8B7f
         ixAK2H1hNPOmNYRciTdoi/7Ja20PT0IYuuxVbeD0hoGPAk5WTEJqoX9HAfnJY9/kWwiz
         aIvxe6YiE99LqInohwQLDfr8jEWYwf0v4JfQEWUaHvGD5gQwlOcAnhj7zoEGePxH422v
         h0RQSsmbA9q7Q2MkJxUoDiQHbWKhgvLmR6a1lgbwwwD1vFZg/PAQcvlTbOMm0kXl7iNp
         1kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937867; x=1783542667;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sJb1hpPoJvea7G7luaxcB0X03g/OToAr3zQtJFOLpTk=;
        b=Oj8LdxGaDwNrxy9ZElar5tv/8UjdWLI5km7SEjwAHZNAF8E+ATdxLu2v8A8CEuw5/M
         JfM1YLvcFYr7LYLbAnNp2i0Bn6usN/z8hXMTDMRKSElQ6aQWWdJx1wJij7okZ/Bg9RpY
         NyZJaM5yWXKS2PA79FBuNi0kNG3e8NfOGi5H9bBcMHZ5Dn1ZJvlbbFOIapiOBMUfsGGL
         W9XbGpXZrYzhrB8en6q0Kboa7MHlfCfZCJEu7dfmub05H8f3pameOXrTejmOTqtgVG6f
         DNnrJKLU05YrsdfJqkxeH+ybftB9dTe42ml6XxGMNHq+uxTvNZO1y2B5a/ACOlvPN5ew
         Mh6w==
X-Forwarded-Encrypted: i=1; AHgh+RqtheBsIS0y1/QhZ8GuJuoewfkhBSWV8r4+lYSMCTvep45QTDquo6Bc8ZPFeiqjQNw4klo1j20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtDnyG4UaSqPYUYHRCWE0Q9i6q4ajDVBm4k9/OSBJBcm5R25f
	AUSydkNJsSb+7OCuw2A6dh+12080j+j3jE9AjpTA9PDqvgxkMh6K7iB4vcPT9dtPjcIt1kC42nA
	G3KHzQBs=
X-Gm-Gg: AfdE7cn8c0HhJsO4G5UNe1gcHXBoHhPTDS4FessthWOIRZ1Ztusu8qqnDVORGmAy0mC
	+UOFGIiqRnU/CofN+ccWgxm8VzocFhuBg1IOD1o405H7AbL9cO9pvpGDhsy46GmG8l96EbItXgb
	pNb4K91F6HI8CBT3FaUnxafMnZui5cV2wJX+9oCzMktkNfiocZmNATbUDEa0x++Ha2Uyb9JEBAf
	oV/L1oIV/cLfPVz5cYSmFb0lepSABKloV6VCZJC/bJKwNw9yVT2ToMMauU1Yws79xEBxRESfw1J
	xTd7dMM5WHs+yXX5tED9M+ar6beBGNko1MM7akzrOltBNXj7OpnnE/x+JQmWoBslWpCC3f7mW8B
	AGc3+6otyc2nji1ExqcI5HP4JrH8v94qnCSbcu/VvL5RjSUtR6klehUSKCG/IcIuxTgxXDRC06h
	OLovKkE2ou7UwCRMiElTE333a2upyldBEwFUF7/6MM4nC98TV1zlsi1dRZSHgp/LK+VkN5Ipxep
	dwHvZzGc0IIM3CoBPP5ajzjdVgRbN37o9m51eijuvibck1XqyB3g0K9I2uwD3ly6BR9pGsarrFz
	k723czE=
X-Received: by 2002:a17:903:1acb:b0:2c9:bd64:8c8b with SMTP id d9443c01a7336-2ca911d9aa1mr21958695ad.31.1782937866890;
        Wed, 01 Jul 2026 13:31:06 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dae49sm3586195ad.10.2026.07.01.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:31:06 -0700 (PDT)
Message-ID: <4210584abe2c4ae948ef12225cc20b86b7e06586.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: terminate xattr names before listing them
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 outbounddisclosures@openai.com, stable@vger.kernel.org
Date: Wed, 01 Jul 2026 13:31:04 -0700
In-Reply-To: <CAC7i46-V_aK=ZVVvQ_45_Sv==swzD0P0-FeqWbsbO4zACiv_9w@mail.gmail.com>
References: <20260611212710.5134-1-kylebot@openai.com>
	 <4a0ad1fbf065b3d0bc0e3f1f2efbc44249181d03.camel@dubeyko.com>
	 <CAC7i46-V_aK=ZVVvQ_45_Sv==swzD0P0-FeqWbsbO4zACiv_9w@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-01 at 00:02 -0600, Kyle Zeng wrote:
>=20

<skipped>

>=20
> I suggest to backport the patch to stable branches because it has
> security implications.
>=20

You are welcomed to do it. ;)

Thanks,
Slava.
