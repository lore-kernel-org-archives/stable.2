Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799F3DCDBC
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789705744; cv=none; b=tE7RSYU45aUpyieKrzjR527LB2SScqnvTTxJpkpXpgNiu7I6fxjid+ccwBsk1ghpansbpd6p/cjTd48CwHlhMZTQlguq0JU+hfWVczGAhf3sX6ZLIRaaxxsg/OFkN17s/H1Dg7ChHYhJVhOrR4LUGhz/MWazy8zdNihp/rSsqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789705744; c=relaxed/simple;
	bh=pUwrfId8xrhmJ2g57KhzeZ2XOYZKadzxcW96opEoR6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpRrSPiASisWek30CdopFWbnlW7QGvOu+/U8Syf3SUEp/3nzpnIbCLqiN6qy+IlQE2zn3rmk+RZ1DVZkWFMkZQPgGx8Fm6e4Aiju3rq3eL5W2o98oa0XsfzYWG/sgEcc/vJIdGBK3eXnaOGE0M1XMnqRikO0VN9FvG0Oh48ql5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCHIJXXE; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCHIJXXE"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a0so399415b3a.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789705742; x=1790310542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9evjTjmaoaNHcsDFp62eIgxEFkqZOTYV1LthHKdjAKc=;
        b=SCHIJXXExnmgSfQz3mtwdAEM+htOdP3KlXXkJmXy+eLtLDgl18sMtIslorCBmg4XeG
         eYxIlbyPWOuELM6F0hTpbKqSfXCFfr9RjJ4BIsCV5OK16xZ+ReEfsFUpv99CxbF+8Gc4
         Ct3DI/nba4Oc6Gk7DWAmfPGhA6Pj6kuXK+rGH3D3dvd7KNbC8V1ZFzYTM6RAt7AjhIFV
         KRayYWfXdQfS7wlTYp5wl/AECS6OQDwTi5im0KvADvqmotVaK5ciWQh6zUUV0IiImBE/
         gpcTsIMwpJ+41CZbgwQMlQyW7jJfiTzm7F+AVEunWjke22GBEtSBejYE1YcXENT785jF
         RFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789705742; x=1790310542;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9evjTjmaoaNHcsDFp62eIgxEFkqZOTYV1LthHKdjAKc=;
        b=cbj4HAdcBllGxc47cToa7JpPVojnzvWsFPr+K2AZ/YfgnQl6iZk71eifUZWUzzfv0t
         7H3YDgWIP2yvFKyQ6xbA012puz3ChCkPBpkEzbi6VF+LH2lA6hk0tAgK2e58qzUp8i7o
         wj74xUPDAlDBmcRdCL4w1CuOatmF3EXAyhvAFLDybVv73QtVzVxCh6nyKp2Vf2+cVJ+I
         VV0NsE9wXBqwJjv9WZlQRzMUi2tklvI/z2QssOSlxXt1vUoD8uOMz5ngKcOT28uyTTz2
         Ns0tSJILf/pzwuqDvlOY/Xn+3Eo9RIWI1VpzQ0B+CySJKUNPu+Ja2YwT2eGhhT8Ux5Yo
         lWtA==
X-Forwarded-Encrypted: i=1; AKwUvBws3Y5pj0t3u88u7T1m/h6+5zy9+FEBrYph/uuVFm+CaUodVvDaFVgVxXf3fSKeLT1qSUsKxTc=@vger.kernel.org
X-Gm-Message-State: AFuF++lVNRxbAfccHl9yggHgHfz2OQwPlXwSVC69OXXAM56Kaw+bRifm
	P/0Kkb0A2kp6AcG5IZVFYW/KT8Qo6g189lfK+qlMNlXCaaNTiz9Bq/u2
X-Gm-Gg: AYBFou1dKiTg5OFo2lDGon3gaP1NcXcqlXqHJPa5yD1XQ+kjx+XypTfPIt7CX6hcPwP
	rvamZrxPN3nuTl64Sv/mlT0Q+Z7KAcK+fsC777MnHUcTu/lIIp7qPsnVh2KyQILZTOnLkSHi2qd
	tAngTAwiEL91uD1sFXF+rCX6c4xTaOFe3fTD/T8jRCeoyGYPe3k0pXZpu/qaS/NFNj7lsdyYB3w
	HW6T3K2JykPOheGtrzuUn5w7Y7+sdInD6kt2CbtBAp1yxKtRLBH60p3swUIZvcagFpU0RKAvkEc
	lEuVQIhtPD2buxXCyAfcIFZv30BkPXc2vO1UBbzy8GSXfoGpyLqBRxc7HGOYBCg0pOiztERhqYH
	NC3KddsbNtGUzYby/CbY3xcUXnRQUOC4HAi4h/b2oSJ6Ou7qtO2BClne3jAJ+Yqvsnm/wqksfye
	X8VPCRpF9IWSdfrNVgvi9EWxsbT/BjDmfnYl3aI3zuGVPadpZUSZSsOA01deNGXHMB+O5MlcUmz
	E7k+20TdBe2tEXuNnO1O9w8Qr4uURLhr19meuV+0WRp68aq1+6LvEveLI0=
X-Received: by 2002:a05:6a20:5491:b0:3dd:85a9:55b3 with SMTP id adf61e73a8af0-3dd8c59039emr3060420637.30.1789705742002;
        Thu, 17 Sep 2026 21:29:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5c50997cesm219135a12.11.2026.09.17.21.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 21:29:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d08261fc-605f-4ed6-b7f0-b9575c2de55c@roeck-us.net>
Date: Thu, 17 Sep 2026 21:28:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/935] 5.15.221-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260912065526.833703348@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260912065526.833703348@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.221 release.
> There are 935 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
All alpha images:

Error log:
arch/alpha/kernel/traps.c: In function 'do_entIF':
arch/alpha/kernel/traps.c:373:35: error: too few arguments to function 'alpha_fp_emul'
   373 |                         si_code = alpha_fp_emul(regs->pc - 4);

This affects v5.15.221,  v6.1.188, and v6.6.157.

$ git log --oneline v5.15.220.. arch/alpha/kernel/traps.c arch/alpha/math-emu/math.c
f55e039ce84f alpha: don't leak hardware-fabricated FP exception bits to user space

is the culprit. One of the calls to alpha_fp_emul() was not updated to add
the second argument.

Guenter

