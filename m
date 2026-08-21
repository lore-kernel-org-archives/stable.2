Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1230391832
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315092; cv=none; b=RNASYRTqL0sxjy+SqPUL0b+nNRKwNZ5z6iDwkvv12oPwpUfZiKKBwSKCZAx4v759F0sRoURYFfJcBZBEJkmJFBY1elSv8DPjxiAF3b6GouynivuHv9aBkmDpTHsQUPduPCQJCB3vpboC116KFtrUF2WMt6VlgRExVEF7ty1TUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315092; c=relaxed/simple;
	bh=kzUKGErSXeFhGcKEXAfHLLGBFtintv5H5k+rxhgNBck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVOfXMawa6D1LdF/w0ozqjuZ5Mt6//sXnClm3RCYNlLg/oq5T3Zmz5uEyuTxhWTUBj43v8iPv8GDBjKZ0DQUQg1tXZDMMJXn46zEUnNdDssQAb2GcA+WNacfO0gXM8dKYSj42pyKXx3bRCEEyshEpkALNINDzjkdX5Fl2BQMXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=D+mfFNos; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D+mfFNos"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1670dad7a8so173868966b.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787315086; x=1787919886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PDXaXwtv2p+1+Durrc+bPegBn2jN9nnuU2DeJAAOzU=;
        b=D+mfFNostn89kb4TUySCiqOlf5O9L1un5yO046jllXODl07Clt68w3c5SnMgoIgJHH
         0yZUkzAOuo4ZJFlFDINWuG373StWhNUqtinXL3Cli/OVWrYVm70c2pVMBdrDEj2jr3Jb
         D7wYuGHWhTSC2ydCZQ0wMokYi9mGfvgSOctQAp+jZTBpFTfpyHWpR0K6WgPElpgpuBak
         YJ5AIwgYxxLgRrKCY6oGfcSNI+oryLsFDyVm7lDurZypI8SlUmRew9m4sXqtxzQvvp+t
         KfFFFsMH5QWpD1kd+etUdfwybNLGfygOFjMwNcyNbhno5RZCkj+XNmS4+PWkdsVnZ+kd
         n0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315086; x=1787919886;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PDXaXwtv2p+1+Durrc+bPegBn2jN9nnuU2DeJAAOzU=;
        b=R4kJQjKHH/8SFwV9NbGvJP4uEvcgoSY2Iy0EHW4rEbSXWZuiijMwlfAEDW56wR147Y
         y3MRHdOlo8WoKn+EBP/vS0KB284iHZ2mbdtL8D2NXkj32EjNQCJwu1A0sN5Mt1iNxnKx
         zbkJCI2TKFUmMs+IOv4qhZj6Xy15WTu2SNBteqxS1UnQq08odi21oHV+/Y9bvF0cup72
         cafqRU1K1jnp12Bpkib4p1qU8o8DnR6HwKHW3O6gQk21vkwsJ6LIRgLW2F8+gzaDqAyY
         6u0z6ae7nx+7MZFHhJzsUG/fROkpBtMqtRflMeehlAvJlpAx+pms+xjM5qEc8hhSZhdK
         pwXw==
X-Forwarded-Encrypted: i=1; AHgh+RpW0ICVgREI31SjgJVDkXdD0AjP9aarPY3Sa1IKLspV1RIYWdmHEazBXzRFsaKxPsPpZcz+DH0=@vger.kernel.org
X-Gm-Message-State: AFuF++k+VFpg3ptz+pCwBez+G9oUKJTyEF5QkB6kM0NA1C+mNT86dedS
	hWmUHkk4nhCE9JNN9gnW2DPa9ZEkcvn7H5xCLpKHLkgINhM+KeQA30k=
X-Gm-Gg: AR+sD10EvF6E4WE8rA+kWvl8ZlkmrRa3K0V9696smzdPHB4pk4oenF6sJQTSyfpttaW
	l1qT3IfD2vd8vozY3VNxDpvq6sx40WLGr/zYkMmLtbL9+Us0ybvYcq0HrFKf9TwhhslKnCR93+f
	gY5c1s7hANMvicZeWYoaL4LfFKfmbMpZhg/6+SLYASRW0Zrxn7pxB3OxqWTlGt92Tdi0b07TOTg
	YbT9yVzc9ezlSLf3d4jL3dvYOKfMC2QZp1u0f62lzd35lZ7rmzYvTSO/DgddLuvy5AbqTCqGbTr
	SKkvVgNAaeLZQqaPPqdwd0emQN3vitVzRsMls007G+zkSPZYiJajawkcQXXOXh6XAxVeIRItu1E
	nmrpTXepLorhPyqzXoS/tnSYl8nQl9Xd1AcNyV61dCfD0aU6YmPTb0JtTHoNr4NzmIyKr8MLRAk
	JRP851yNvOrKWRFaoyQe08wRcHlqL+tvvjz3RQiZvmy/oy9iCHVAnemEeppM3DHjGreTcLVgsKg
	Zl7rNQnmNrIdiS8l1iGVYJPwnNzK3a9Xv/25wgGMyo=
X-Received: by 2002:a17:907:7b9b:b0:c1f:bda0:a771 with SMTP id a640c23a62f3a-c246a68427amr634334766b.13.1787315086010;
        Fri, 21 Aug 2026 05:24:46 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac6d4.dip0.t-ipconnect.de. [91.42.198.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff177970sm5983397a12.26.2026.08.21.05.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 05:24:45 -0700 (PDT)
Message-ID: <75eab6c9-5440-4c63-ad10-164d6f8e53ac@googlemail.com>
Date: Fri, 21 Aug 2026 14:24:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/220] 6.12.105-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260820145223.480031205@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260820145223.480031205@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.08.2026 um 16:53 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.105 release.
> There are 220 patches in this series, all will be posted as a response
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
