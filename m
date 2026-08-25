Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE13D8123
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692458; cv=none; b=F8k5QOZS4OmL1sPy6U1uyYtbCdVHG9ETDkq+ZLNVK/GRgUv400y0iZjZEiWd4+Qx4pnwQjvKJRmydylrtQkrDGR4sz3a2NV7mDKBf0McKD75gK0aJRRpjLs780UZZjl6vcd7Smmyuq/eh+BlIr5UI1zJBRUkSgNtnUlrMTzlFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692458; c=relaxed/simple;
	bh=yfjHf3oacadvrlyyDrTgxD7NIYF+FYS1f4+hS2zmuFA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gVND2QsDQ9kc5V0BZkHfAEsw6Jc8J4aokGAp4CT3pOBmBozNklUgz2hyopILvXb/KDlz/M9gIYPdoaxw37Xw6wL6bMCAENuRPKHWSfz0RgZMdkzrsZNM4W6Vx1V43D8D1tVyHxpTrqpYxiAZMJQ59htPOFR/P8dADIwrpBauXmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldfS22OE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldfS22OE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6c4a867cso13452285a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787692455; x=1788297255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQ4W8vFJosNYzvgFRlXUoBjGheIiHAM48+78JXM8Oqs=;
        b=ldfS22OEHcBBJ7fpfUkf4N1IlcufZevQ865CKpXiciDTewQNwSsiZwR1Uec/1mnago
         9InJOiv7rGaEaMXerJf4VVGSKAidrwIr7xJoWDlMGNdAmoxitX39vIx7GaMX6W2TukFL
         s73Dn2rEf17QPCAUswGgySeeJWNn3JUj0068Ng4qnEYmx1aJJpr9zxNlC1Ok6mFvDrKi
         2Gti3ZjtWVWMudi/ank2O+kxoR2vNV9d0PoyVffWDazHC9R20TDmH7LhfG54BL/7ugN3
         Q33sblfAb7NmJoox7sJELk3itXHBGzuk87gEqR0SkmSTqXCLNuS0CB3wJilzz/YY3xDy
         4iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787692455; x=1788297255;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQ4W8vFJosNYzvgFRlXUoBjGheIiHAM48+78JXM8Oqs=;
        b=ihDglYwD48QLZHX3EDDiSrVbaOVMqufl6RCbXWV5i6ej3+22/w8++25YiEbvmvIt/U
         AF6+v24Ci1hUuI5tIhrXm+wg7vLbwqeJ8fTHoq7P7U5mJN3d1fO7ny2f1lK5xT35yi0D
         OdYQxuyvdjcaCFpFUXQ/F+AsxXsw4pB4zZZEs50Y68BIrDhHyWbKMhJCOgwP5bPb2W2A
         Ej3RVN6Q3pvuiUPgXgULPPQ6ny/kabmXAbWW2fgL50GVr88E/3EKM+2021Y/7EbzdawT
         Db4+pmroE3jg1YW1upPZG6JUOBLqvKs0X6Rb9DkJ70RtDuDpTAWinJFIWYc99tGVPh19
         HAjQ==
X-Forwarded-Encrypted: i=1; AHgh+Roh4dmBoIC/KydesWrIhCOwstQP3tY8K7y1J9M0+vNhDsLr9EA+deE5Dj1nwPWj5RWC2soFe2o=@vger.kernel.org
X-Gm-Message-State: AFuF++nujcsCMyl3RlkaeZowsbe1L4odQmE2ukEWU0tuYWKeAmgO8nxE
	y7CZqdcT8c3QzIVPTTsL4vcZzpBQYjy1ubRARfeiGtc5Pjx5k+kBK5M=
X-Gm-Gg: AR+sD12aJb2RHa5mtpqH8Vr1WC1Ros+Q3L0MqqR3VrTsBPGT34se5RF75km4+IJXV6V
	pE0cDCJRAgV1fxZ5q650ILQDInDRM5xueJ48NIg0WzMqchjT9hZ7Jz6VHd1+hu16M/qCntL8wPU
	TkrISfNbxmZyNps+b74fM7gYrv+2J1kyMnHHQkVIp+T54dFq39s2I4sCAAXU3IF316v5IzVtjGI
	/XAsytlqf+i2e81cTZV0Pow2kgBcrMU0ycW3yhS6XS81GKNY7SF4UGUziskBSDw1Fcx3sQwTnu7
	TQzef2QFDxBH70w6PSzxGxnpLdqir/69oYh0zbfrquTMNducZslykNEjC2Vfaukb+76ln92wULl
	XQ/qrdkpsg9t69oaQV2cmlYZNKzHhaUfLhh8lyPWOwDYbV2UuCdSQu89UX79FaX18o3VBJgH6eh
	MnUky9y44tIC1gY9munGFVhlUqG+jgKE4idzXvQpy7rqHu/NamVb40S3uDuf+K97etqbRmnqSpB
	XMwvB16UsNw9uio
X-Received: by 2002:a05:620a:2945:b0:936:695a:185a with SMTP id af79cd13be357-9378046b550mr129776085a.44.1787692455455;
        Tue, 25 Aug 2026 14:14:15 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e30ed19sm69914685a.8.2026.08.25.14.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 14:14:15 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/57] 5.10.267-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.342390421@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <cc27b74f-b7ba-7004-27f9-16aeb3a6577d@gmail.com>
Date: Tue, 25 Aug 2026 17:14:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101
 Firefox/140.0 SeaMonkey/2.53.24
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260825132541.342390421@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.267 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
>
Build for i386 and installed / booted on 32-bit EeePC. No problems noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

