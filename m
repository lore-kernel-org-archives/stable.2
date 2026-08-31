Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1B37DAA6
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205279; cv=none; b=rE+fk+jFXY9JClpF3EZnDG8vBz0aK+cfQ76ZCFu3vpJ5mAqmdeXgN0IeDYU51/MSQjlve14r2H7p2+DqR310FIHs0PqiVg2gE2eylDXSYEXFv7bzW6EjKRHU03IQx6MPWyi+duMjV6yRNDWhr+O1MoNqBcioDHTrANOMboQlmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205279; c=relaxed/simple;
	bh=3lDcvEcgr4+onaFRlYHaSNZV0ZlWUMowCmDvvcquADU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfzUOouwdzHDnDch5LkVIunozmngHynhSv3HXVWj6xKrPO2/43ObEihjY2rcGXeRqZirlmSFlT4gmFdnGqUi1UAEcSfCN3sNX5YSt6CPzxJ4krc4t/8ZqZt3rVpBHWEOics5jnTRBhONIICaedJaXTcbZpj0XNf4YgRa2VPTh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=E6ffMjkp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E6ffMjkp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49954b88fffso27470025e9.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788205275; x=1788810075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhxWwWFcvK+eSFYY3JAtOiS/hfjCxl8syl0ArgsjgOA=;
        b=E6ffMjkpH6EYrTlCIcro7lCi7NOn8PfwtU1YUC0BMqu2TNhlMh54QxqkqdbxnmcPmI
         hPGDwAjd86HgT1vl92nugTsolwob3W1FGDUPiwPEOGm9ow0cHJofXWZEpMfZ3HOq/0Be
         K/0FXbu3E/mgY3oa99qOMmHfXxB6E3VqAf6T9HytTT073mJBmWhxnA3EB/8Mj0Bnwj0u
         XRVcujkym7dBUkLv2ip8hOXQcISMYp83W/BwvNKc0YRiYCoxkh6trldtviOxUKdTfGti
         /ORmVCOHlpm8yay9VaUM4UBdKYmCjAd0M4okU9qVeoYbLVMR9eAewSGrSIAEb11JDIlI
         1oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205275; x=1788810075;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OhxWwWFcvK+eSFYY3JAtOiS/hfjCxl8syl0ArgsjgOA=;
        b=eH7YIMAY80AX0UtdY/QBxEV/FA68VSLqprU2dJVkTbowyWMTxx11iE//Um+gLByn8p
         2hWynTZQ9+8XEYutVI6bONXxCDY6h7zQ+ZQxEYzpbnV5zPi/PBGEnHteHAadNp9zkh6+
         ggXVeUCkAqLW3pI64jzxYjcSmBY7vzw4CWV1Sf9TbtR74Kh6P/cOsG8C1cj3SYTTMwk5
         iMEiwc3pjhlVy7vzsquhnjTZq6UQ6xnEQVGUU6MvU7war0mUuqNwQwsl1GDM3zQHkgWq
         B13WH/sCt493R8009roxlSBe/5E9H1biHMtGp6SUgaKjEGThypfwseO6x53qzh/10Ono
         clYA==
X-Forwarded-Encrypted: i=1; AHgh+RoCjOP+BVfNry0qApQ3AM++nFTROCWaOtH9ZimALM6H+NSW28t0nTLsmtgQw9AiQ4U5ywZC0N4=@vger.kernel.org
X-Gm-Message-State: AFuF++kG5FKUNxGoHoQUmEH/DfWBtkoPyMykNFLRcDFhj3Zm6ZvkngM3
	RC3XBBwPuTlyQu5mGOCI9NCoVvJvW3Cp8mciMAS4WPkzE2LQ8sDO5ro=
X-Gm-Gg: AR+sD12TfUadi+iYCHGCKaBakGDdw5RFaS+l+iHHeisW4XnoGgdlb/Zo2iDcwqy7yW4
	iyeLXEhuoV1x0BYClwkqW10areDnBVvDVacn1UdW/uYGeGLivIshK4DTdryAbw+42BNXEP1WrvW
	ACrNLnf5swPmbs3HO3Thwf3vO0SGEGxHPQ8VuhiBF4mTR0TMxJTw5Wo9qwPY3yWggesEtF8qPXM
	sL0YBYAft39cPkvPVXrxTawbDK+1ZWarfZ2ncWbx2mWAgm1eKVpoalkarlPXXVKM18UHKLCnKgg
	S076433C2DL7vH9qTGPSXzMMBOMGamfNbBteSUNSf5tq3NMce7gSbpcF6MeSrC+b0+7NUhsTE7H
	LGxR9/r+zNWfYWM1ccIXYymN5PPU9zGrJStVi3rjauNPlpMmL5HHeqcRHF00TTGqcr60kFJyO56
	XMUwVs22pNwaOdZMXN7rqnRe2JjEggCiyH/RQWtZtMizTitTS9hTV/4Uv1kYIzxhVNaTx/eT0XM
	OYjWPWlqjSEdWRduscseZTq+79aPjDuVPzjCN/xNh3LRweS4A==
X-Received: by 2002:a05:600c:198b:b0:49a:a101:4157 with SMTP id 5b1f17b1804b1-49b91c24e71mr452535615e9.7.1788205275377;
        Mon, 31 Aug 2026 12:41:15 -0700 (PDT)
Received: from [192.168.1.3] (p5b057bfe.dip0.t-ipconnect.de. [91.5.123.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c52fdbsm232753215e9.0.2026.08.31.12.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 12:41:15 -0700 (PDT)
Message-ID: <15a79ea7-cac2-483e-8dca-60568fe76502@googlemail.com>
Date: Mon, 31 Aug 2026 21:41:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/92] 6.1.187-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.482388899@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260831133359.482388899@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.08.2026 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.187 release.
> There are 92 patches in this series, all will be posted as a response
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
