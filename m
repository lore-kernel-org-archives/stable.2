Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8835201D
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743210; cv=none; b=NX4OXyfhh/2wpwqV/WoyEhrpMnz0pxo541iQyIu0yvT6Y71KyPpovy8fuy6Fcr4Z47JsHayYKk0b7ZGoYeUswtvR3/IApBofn6F0kdngdTFIE9c08HPXldSneWaqZjtjtgcPGI2ZOZ3didWzmozRcUeyMZcvc7bNt1+wVsHNeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743210; c=relaxed/simple;
	bh=fREDOjC/rZzD8mmhDib12jsIj3RCLQKntJ3tQjInWlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkjLfJedqp5GBNLpSK4aRRiz2BKC32b7R6bsBlXSsUQv4nNQutr4HCIGSHux2WGoKeCp8M06UMBg1qr5Hk4c8FSyje4+Y+8Mxnn30+YL7doBCy7ljRu+BXoCYYzScN57q+43a7ELOTPHC72abQmDpB4abJ5EFJ31eTI/dWZVr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Jzqspc1H; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Jzqspc1H"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so1467178a12.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787743207; x=1788348007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdF8Pu7WrYTwQxk9ZxP/oVuw63AUNT/7Y+iY+aB9HzA=;
        b=Jzqspc1HlS+iSH5dxC6wdcef+bLXFRDQK0ZxybpKTTDlgJDg/F5NYvjvYrZKEq74Sv
         s6POEUu8DBqdM/zJg7x70zk7iwsPaEPICxJlYMTt3msCx4pip4Dk1zF+FmQmWNad/gAc
         PW1050++yhc+GbM0CMkfDu6kV+jQ/oZ2uO2l5T5HyYHzUdEYBRsRNwOg+E9WreLzMQf/
         wOnCmIHnkS4fZA5Uo2EhxruG3eXI3D7K7VjuKlQvEns5xG2LxZ6rAmK0avV2fJH5eaFU
         UmCNPsZv9DaKt+oVIRlwoYyJjecfuFhLk4CUaYXQRpleVUi4gtmV2+MBARhphDjvxafG
         UCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787743207; x=1788348007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdF8Pu7WrYTwQxk9ZxP/oVuw63AUNT/7Y+iY+aB9HzA=;
        b=SMAoyEX/sHfOdqJezg8sIJXI6Be0RmVvVlfXPWqmumFsNh1V1mWfeEbGv/mE7Ee5Qc
         NXmSxuPoP9BIZ6H6Ith84nuMmJ0WaIqjKtbLYn+Y6TxRlYYHClphJIJJE3ltMo/kDOCK
         UuVgnXC9g8nMC7M31IwJ2q1AAGYemHnBLPwUhs5ApnvgR8VxtRnmYofuehZqdeM/iNUY
         eulCzaq7QHGr3Wm5yclrrDZQt3Aqs2z2rm8VTFFOviyI820Mysehxy3POsAJlK/XBnZL
         E5OUbqZy1aVlv0HBo7Dzmhl/gpCTrpGFbbnSNsKO3vffP92rmnYxHPeaDxB/Ux8++eTH
         yFOg==
X-Forwarded-Encrypted: i=1; AHgh+RqD39PTWrNPMtASQIMdhOvvGk6QJw12D9vgX1s68C5EYrWqdXI5QJUUEUexlvCoPmLBChGvUzM=@vger.kernel.org
X-Gm-Message-State: AFuF++lqiFc2iQs3b9HE9kvzHSAS8XnQk+kQ9PZpzVMlECYmAzST/t20
	IRFd3oYue3hM8WR5xGcMCxUUnff+QdQlZXq7wNrkXtBBvqEBKbII/XM=
X-Gm-Gg: AR+sD10kY6yYtGBJsCw7s4Q4JF0ZJSRFSiYGnIyyRSkVKuIHuhCcA7f47x3Txc6XCXp
	QtGLF+ay6pk9YnC8VXP6TCQs1BaF/VAQxiYwxszdx2VXCvIu+W2dI/vnHmBTZYcFa2MH/UoRgPt
	/LG3KT2Ths+c8JqJPnDnuUms+4+JddIFxYxE4wixWT3irjeANhbix0bg5HWmWvxkqbo1hh1J7/v
	ltLzOF8P6f77wjjp/xWBU93Cjff2/TZ43SYNxJjSBVyAa6zLN0I9z4mBaZeUR8CszRy7BgTzY/9
	U/7kKUFZ2T1WqXzbGQLnWQ5XLGViXKS/DMkIvr6Xw5Wl7Gs3kZMnQttBKReAQ4+aTWWXVXsFrc8
	l/ozQ+C14+aLXEHnCv242voaPIdSTBD1txnf0R4sBy4OuK+zmIlYsU9X9VlsslQ/AlqMbNrS6ms
	9tX6D0YD3tOigdc77gah2uOhoZMrNeXlEPOd6SZsTE7frKPLc+ZiM+tDoOzdgbBEv0YgHl1nw5K
	6gjJIbuhJg4Qc2gS4zeYrqdf3aDVr8UjaeF8X0=
X-Received: by 2002:a05:6402:21cc:b0:6a5:d58a:9640 with SMTP id 4fb4d7f45d1cf-6a5df61b209mr7656568a12.9.1787743206552;
        Wed, 26 Aug 2026 04:20:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace5e.dip0.t-ipconnect.de. [91.42.206.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5deb030bcsm5163127a12.31.2026.08.26.04.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 04:20:06 -0700 (PDT)
Message-ID: <4ffa1d11-993a-47b2-90fa-07e1c8f623c7@googlemail.com>
Date: Wed, 26 Aug 2026 13:20:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/79] 6.1.185-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.677185791@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260825132541.677185791@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.08.2026 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.185 release.
> There are 79 patches in this series, all will be posted as a response
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
