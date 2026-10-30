Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793381947;
	b=aDAIrsDcP+KbXv5GAqJFJ1SykUPY3yNrksxX5Gars9Ha+tW6C10Brb4RI3Zd7yuti+5z
	 BaWhvPjdqXjJr/NbXRX2RqD3tgUn19RAPXAHXnhnvhejc5Jqd5mx+6/JTSUZBHoZHPnw1
	 Hih7+Ru50Xr4YtoMyWOfiS7ZH+HRfnBJO+iNkNqDqjWFmF1D12Qlo1yfQ2+rha1Dj1sl1
	 kuOAQPCVgpj1EvSMU9Y1bKr+EeysQA30vzKK5EX1+idemaZQKxenk6IEphYkjiVe2KeAo
	 GKTr+larPol8wAdmhhP3vu3e8oRaza2iswv6E7XXWQzCSpq8q0jrRhpXLLSeBe7HxWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=espr7eMUoL4NEp1fFPw2X7cY1hYHDQwWESfnyLsQmNw=;
	b=5ZvRCJuVMgJUVjgwq7eze3XSHELdGf3BRsh2/Yz811OUoDUmAkeqPn0Wos1jjN3qCXnZ
	 6MBSlP2duxDG1N8YoWAmdkxeAstwpGKYvE2OjdEZ4HhBsScNtIqjads4iJ4O+2aY4jOhg
	 KCWlVTuidrNQ0AjPsuOwU4cVr2UpJAY5lTUDR6xn0NuQ4VdjF8G4ZQ8lHgHoWqfKUGRvp
	 zcRgLmvL16qWGjYcU7j4aTSbtIOqRvFxcUM0xVgkYRB23gHSKwQY4fdJKl2owVzTnpNl2
	 TBwCStx5jM2MjMzyNvo5LVQX/NZcH1FuOQ8lvmWAH72NuuR2+TLNbFpQdUS5K/ePVsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phsogC6Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097ED606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 097ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phsogC6Y
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-943e8d35f74so89814985a.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793381946; cv=none;
        d=google.com; s=arc-20260327;
        b=FYfmCbO++CTwHQlfeC9JOBdnGB502i4IqtS/3NwCf8S5cApHRjTB+/+3L+0868Qxhx
         W87ttgX15WDLS5lAsIqoaliDWDOUtOgG38aHI9HvF9K2uIn4rlmPuNOu167kDdA86I90
         G+HV/B7sfQjXUMmI5g0uW5W8s1865sBU3WUmNOA4OG/Ek/IZP38WEnvsMRMkOaxvVyp0
         QC3rxNHyQ6eY33YqgPY/vVXghSv0wZn8nVna0QiWfLfD3U5mwjDz7eu8n2UEEtr8boxt
         /BHjGS/OJCcX1qJ2qhinCIZSOJCk6EMkNTq5lx/aWI8KiHsypd7vBLepbt4jpycQ9vyW
         MoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=espr7eMUoL4NEp1fFPw2X7cY1hYHDQwWESfnyLsQmNw=;
        fh=NPjUW9hMScUlY6xYREQHN3YzJWUbBBMGYkz3K15VtR8=;
        b=U0DidGHj5Dtavf9aBG83MkOE8iuvi5CtN9O0QTARck12KWmKbCC3Ia5SWATHvyqgSE
         RK44ko+gY4v6qjLFFVbglSCPvI3MzrzUk/3ckHY12E32rMRDzFWcBAMgUnNEYwgDfo2m
         njebkcyETh89dPUKGCbvW5hi8Z24Iyf+wIGNN7FEt1zLPF8WOY6Ssx0AId3daoE7I2Tx
         HFv/IGFP2o7FSD3flr52prdanx1fJXVh5OvkFaN+CgXko2XgClmtMNrM6TQOtasd/zWh
         1eJF4xhLYu+Fx7PKjLPkh8NWe0adICfM8JFzjqAF/vrZVanaUEJQyhyUUkADW+cwLJBc
         ev4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381946; x=1793986746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=espr7eMUoL4NEp1fFPw2X7cY1hYHDQwWESfnyLsQmNw=;
        b=phsogC6Y+qtsb0QGVFGSDDf5T5Kh20EJJXMOsGlfuqX5VlyD6VMPQ8vSmR/mCfXDMo
         2GFmmgqHGJeNJVXfLqFbsvCh324IQWNuBvDyY3Pcci4A5ESkB2Z3hSC8Q/GovLQZtU8k
         Iwd/evxgoGgJvL5OMRp8Or9unuzO0a7dxUCCb1SUwkmIRNALmNb/9AEo3rA8zEPai2hS
         6s703AX4O2RsuiJcwFc0vfd5vPLtYQXa70N6TaP01xJsrNXxTVYKk/fFr3SOLlcEd4s8
         RDzu1j9SEC0hqsaxOtJpkWxdEywO/uUnHQY6XgxhjDO0E+SPt3O/kmthnolh6hc3rYrL
         CNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381946; x=1793986746;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=espr7eMUoL4NEp1fFPw2X7cY1hYHDQwWESfnyLsQmNw=;
        b=2yg0z6SRpcXfWYKvW2z8GlEiWTOpnwQQ2rStCd7+jKHr54Avumse8NoeHFvYY6PlxY
         vH9nwIFLQlduxwry/sjwtUdnwJa+eMIQvlTsSe7lsJWJ2GwY+6mHcDEsllA9gdNoV4/1
         uwOQf8ZIIOUtyA+nHV57pAESOD/QaYAxMGCfGjHc0UA+XYnUSmuts2HnF5ATo1g4OmlK
         HrV8zrkviK6VsIpvEeXY4BGRXuGfmS1s47Sb6uQaSXpFPt2pK168HN2jbxLPYFDxSg1p
         3dcoUrY2aIdb4R95GsZ8IuiVflRUDLJmCBTWzG2Dpd9vAlRV4dyoXgZXAzhWl6UxVcoz
         cG6g==
X-Forwarded-Encrypted: i=1; AKwUvBxU3qhrPgdbb1kQB/OL5XeGL6zzFFN6Jul8QmSMS0KOhBmRgWIGkMtcQ+ZAhJ3+VVmCtlIJKgg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK1wq7mfn80Jy7tTqf4yJ0tDQ8aIiTMd+t1y/p0NvKEefS0oia
	7l9CvJJO4k9bL5IbSMmd/6sAewIvBT3Eol2hZY2fY2wRN/fQ4dUdrP1/lOJCQIkc3jPTwzfK9bP
	myxseK12b0dRSWUBf6RlUXyilfLbuHTM=
X-Gm-Gg: AYBFou1HAVnUkZKXAlkcHbv081v5y0Yvgyg5TPLapsmV5Yii8vyjvCflYm5Dkb23lth
	gCAchrEhY1mFLsmVSo2bojodh43Y0IwcfQwRkdey23LdxTqEMQ8WRKYYzLxgWGvNdx+Fp4UaKdh
	8IyFXayVoaOQOrQ2CweLMQtEhqQ6b0Q+JI3buN8I4demeM4ejVn2uwIjeAnlvljHoqiNF9gtcBZ
	XrVTWgTLyifVdSLzdy7qeusj4UdtG3K6N1YeKHEZQGwZee87/kYKnxByymtkoVuGIOhPwPKLV1d
	9Dzu/j4RGS5SbRgJPf9xhlvJYr6PxWRTu/VVNF8+BzmHF1JXT46IlXw+cVKeFij1v3h/ucyxjGi
	J4sT+5x5tA7Wua3CcHuk/gVzyk/VwlMXI1la2
X-Received: by 2002:a05:620a:1a08:b0:93c:9d56:a860 with SMTP id
 af79cd13be357-944217439e4mr528491585a.19.1793381946045; Fri, 30 Oct 2026
 10:39:06 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790512964.git.lanzonza@gmail.com> <7ca8fe6cd6b4125813613bd4187ff6cdda72e4b6.1790512964.git.lanzonza@gmail.com>
In-Reply-To: <7ca8fe6cd6b4125813613bd4187ff6cdda72e4b6.1790512964.git.lanzonza@gmail.com>
From: Zac Lanzon <lanzonza@gmail.com>
Date: Fri, 30 Oct 2026 13:38:55 -0400
X-Gm-Features: AclHuK-QAySofGqN-BH0ysfW9wI2BwE9lRTbGJWzIzgQZTntV5tJ3u0NVFiOCeQ
Message-ID: <CAPusjWrmKH4wHK6LY7NFi1=+rzDY0uq5N4dgKC4FuUh_=xGhLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hwmon: (asus_rog_ryujin) Fix pump control source
 on the Ryujin III
To: linux-hwmon@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Aleksa Savic <savicaleksa83@gmail.com>, 
	Edward Blair <edward.blair@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Gentle ping on v2 of this series. Patch 1 fixes the pump control
source on the Ryujin III and is Cc'd to stable. Patch 2 adds
pwm1_enable.

I can rebase onto hwmon-next and resend if that helps.

Thanks,
Zac
