Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E386223323
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574113; cv=none; b=tCeL9wTepSi34JNBDmDiKlOV2JzGeNMS2+PKKNB+deKa5GhIPM1SR/SYoZcYTrlv3GeW1e8mtcP5rdp2M1PeSeh++kC7sVSLZLeDfb3qZ2XsBm4yADSsgzmuiGzdhltsrGZG6ENuB6g2fXWKXfXjmlgUPu6IlmBp8owMROKEsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574113; c=relaxed/simple;
	bh=CBTuGAaSO+Mj6Xd9zM2Dy/TQHDvuh1uTIenUQEv3ye8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcM2HroA9vJz17bXyxYwWCPfdkvja3OjQLitNkztQoMDeu9t79pH2nHgdeJx72SYq8YCgt6BBpVL5xxm58/p7SKvcWGEYd8IZshgeJVG3RJEsV47EL0oceVk5xc1TYidH4ysi9yqhlRGet6wIDTMTHj9jxL1FRM403BzBe+GbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=hntZ1oT8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="hntZ1oT8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d004f135b1so18441115ad.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1785574111; x=1786178911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/pZ8m7pRzCz8D91oW/VyFl59Ql2se0V6HINSg9JYJs8=;
        b=hntZ1oT876WG+B50DD6Rfv1ytRErqAhdgAnwdGLjMZ1sq93p0V+YL9yfjIcFeiEW3D
         nUy2TiFOhB0yr+nDi+Aoyyu2Egnbql+BegP4n51OfWJl0juTPtg6v0R2EDPrY5oN3ENQ
         Jno2zrBps7HIAuJfA+aTEg6pUwDHyK4JDp840Dv0BkDj+6ul4e9eB30ydxLdsD373jgu
         xqlX4ET3UmUrfF/6DpPh8HSgJzVw/Rd99TOfyptCeTyq9DYMXxVEXcwqDfLdcTKsJKPl
         siEZWlrCbJ6UZo6mdRzqoOtc/8t97l5q8IrJZhtbQTpf2ESXnG6enPCuYNmjB3Yt0imA
         mOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785574111; x=1786178911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pZ8m7pRzCz8D91oW/VyFl59Ql2se0V6HINSg9JYJs8=;
        b=X5oDEgdVwOqHoq8cRiw6opLjfOQf2kdgmCdm79fmEIIfKdtQ4Pk3lr1oJhK4Er1RSC
         pYq7fK47cUCqq2ia9YY5w+TNADdbfdkYcYukgJA51w82jovHtS/vKdVyar7WXGKvsaq9
         bO/cVnDG7jWvlqZS9rbwR8VdBb1WrVvlLc5EsjMjewufbF1WLaaAHrNignpZcgKKZvE7
         p93oOIJav7dOYZCmJ/etcHzUKx0RGrdiKnml2Aumg3b2MIkmiCF8FMtVqlNRYAG2JHDr
         K9XKPeTyvIgaNrb0BPXZDdPIEYeOU+9XKAmputbsJE04VFGrSYrvpFe9kX3/QRC80U9y
         dC2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpwbaQ52KRjwUNnLuQxixMRC5WTfXmP3cWQm5fkdIqRWiUvCNrfLNQ2DhoF1WuT0rmSh0mnQus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6OeHS3aO5U4tx6v7/O97GbZNoHSx1F1dx01OmumaquXGIaix
	8U5l2qp+70Q46BD/ZimQNnbQOAB7cmJNsKy1YMIDzOTRxp3AE/XAiseohQdQJ2zX6yQ=
X-Gm-Gg: AR+sD11cB92viBDR/dPOBFBjktH9M06vxb88dmhhn7DcI/yKREZCV7uUxxLFQMBbAa9
	pcUoJrNov7aicWHm2cffxc5UrW3ozX8ywDHErt7yiMFTWefQgPICQ1l8NY2jCKMLDXc7gdHNzOU
	pnxmo+J9t0MLPDUb8mNbbJ1pYAqv3/JOpto6xAEza4rXtBrePWsJY9KOGvzpGEbOOovdADzT9Kn
	zWrwsOsaqEC4GeY/O3oxeZYRCnlBTkGGnYcYk7nP6POVuuSBOtF0MRLvgHfmErIj+LbIYoHBoGf
	m4ENYhNahsLs+TIXucZA9FiIl3tH+agsZBh3k31da2S1EQ77Xy78aJtiY0g8CljnzpoCWRjD9Rg
	sllKyTSsxZeQfxfu/6Od3XOrn6d5Gidl8tsqvi8HzdUbuzksODtNah+R1QPu/pomSezscTuJwdV
	ZtQF1KtT59WbqeSinxOpvnyqmYMbffVevt0FSlnbRJoG8b9mraGI1ykDlHHcwa9EXj5b14NXofl
	drWIg==
X-Received: by 2002:a17:902:f541:b0:2ca:5970:732d with SMTP id d9443c01a7336-2d0524810e8mr29279355ad.41.1785574110963;
        Sat, 01 Aug 2026 01:48:30 -0700 (PDT)
Received: from [10.104.119.12] ([129.127.204.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb598sm15724405ad.51.2026.08.01.01.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 01:48:30 -0700 (PDT)
Message-ID: <166588b4-7bd6-400e-9be3-300dd1a1f9f6@tweaklogic.com>
Date: Sat, 1 Aug 2026 18:23:19 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: fix PM reference leak in
 apds9306_read_data()
To: Jonathan Cameron <jic23@kernel.org>,
 Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20260725051048.5616-1-mokshpanicker.7@gmail.com>
 <20260727033151.0ea0cb9d@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20260727033151.0ea0cb9d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/7/26 12:01 pm, Jonathan Cameron wrote:
> On Sat, 25 Jul 2026 05:10:48 +0000
> Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> 
>> apds9306_read_data() calls pm_runtime_resume_and_get() but several
>> error paths return directly without calling pm_runtime_put_autosuspend(),
>> leaking the runtime PM reference and preventing the device from
>> autosuspending.
>>
>> Add a goto label before pm_runtime_put_autosuspend() and use it on
>> all error paths after a successful pm_runtime_resume_and_get().
>>
>> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> Good find.
> Please look at PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and matching ERR macro.
> 
> Using that should simplify this fix quite a bit and generally give us nicer code.

Nice. Ditto. I have to read about it too. Thanks Jonathan.

