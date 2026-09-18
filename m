Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2D4B44A0
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719410; cv=pass; b=fFUBUNj6JlclI9hrkIxcYo1q6MIDeBmWZ68SnYVfrZ0GhdUgcsxWCOQen8rsnbeDVF6SILd8to5TEvrlBdcX03fOMRAVJZKZG5DwRfjk2vm5rKXhoY1xqLzlKc9pwgv0SIR/pLR6yGtm9PAY1SsjIXIKBZELzq16gUFq9hnNcv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719410; c=relaxed/simple;
	bh=TNDOvls3vgiRBkknnAdh3h0dArjFRoCxPy7si575vY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upGrV6jkYwLOHq3CcSvZ9aiXKoBDJZwkNGQx15pfFQoqxAXy4hVsAnXSp8kIh8aGPxg/NWQU1hXyBa+thmD5e6OElKAOmYgOSbztQ02KfIvv4IFzEELDFpScuEYRho9+sLz2/xTXPqg9qJqp3qRkEfuXn1+0CY55lxAVKaM3INI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=Rw1T6qIP; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="Rw1T6qIP"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so28089066b.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789719400; cv=none;
        d=google.com; s=arc-20260327;
        b=eiHzG+BDv0ftWnvN4/9y6Jigd6roi6Q9wRoUHyDTlfJy8J4peZC6fI3aglT8t/Haot
         xkQ7/QEi3zFjpdu8iDnG3F8uUl1cfFN9jKtRxHcLf6/sgSo4MgOlhH5KWRwdDenwQtBo
         ysII/5ASNk3KbnsHzgdHDRwZkCm7VMS+uJnwFtEBVNVTEmiaV/WFWePQeWrF/sYh6Ilm
         Ujiv056bJVqGI84kaqluAN9Fbdh0Bz5cVydhjaMPfsCvvC0/FGbKifkiF0YrCcE7/IFR
         HVdawpP6zPUjnf5qeJY/bg7Om7/F7LUZanlbOM1oCjuIqxuUznsHJ+QbB5E13pnzMEL5
         a7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QK2RniNBtO2vqqVkyo1sh54+0yZPIP2ozVhRKL6eWs4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=WrjvS09ZZismSV2lDd43Pjxa8IB/9uq1tgsVFLFAuPogT+mpZfEHsMCleyhmiqw9cz
         OQ8f1LoZhKqA7UTMuVJ2iVmIHjbwfbrKUBHp0uyi4psnfeONRErDji2P22mS9u2Maxzj
         +6TGsafnFGeNVSSE4i6L/0ioDr9k/OgB/pKQx/kEUArwENFur/kfwbAonoxtBZbdF6DF
         09Uv0TCUqoyqq5z/r7xbogJzfsclko8dvTT/OnYA1JAM1QUBV1xi9B1RJva3qjxTiWmP
         tZvihTZiQTfqSEdUzAG8BiF+Tnu3AqtM7CzD+TxrAQL0oUY3m43emSVEVeni74tBhnXm
         MnOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1789719400; x=1790324200; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QK2RniNBtO2vqqVkyo1sh54+0yZPIP2ozVhRKL6eWs4=;
        b=Rw1T6qIPJhS0Y7NzlwAziQAIIWr+L9Qw5zsucyBvCw6KEbxT8eviOb10WwWh0PGbYK
         2kGm6bq2T8MNlhhtsjy8KC+6eZsYc6P0qSzzpPov0R++Dj95GURZMnSCeM4fJNxR6ygm
         4ZjlT4U0XBZFJsSjwJoJsdk0sHpYjOkG+8Z/Su5SB4cbcyAR0K4OhsbAnIAWvnPMuaH2
         J5EGRlg4OtV1ywwb46C3aEevUUj9ERa3BlkMMv7VuKArc+0kyeCJdWHLM2V4bc4H2gbh
         ZefNzmfi3sN0KxCGJ6UlTy84BdwcqdfaMUAzIM/ACSYaN785bea5IJwFGysowpPj1z9C
         ownA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719400; x=1790324200;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QK2RniNBtO2vqqVkyo1sh54+0yZPIP2ozVhRKL6eWs4=;
        b=Rw2SQOks7Ab8K1mJUJCE8FklvNjVPEPqa0NUx+K2H49iYtup/vxHZnaST0MQM6kjUB
         08HF+0NbJP+OAmMvvNsrJDzE30t/esV1QZGqqCayTys9OdNSA23o5X2F6l7xAWR05i8M
         pRzyhpd6Q+TdhUjO1XIbIxdUn5WyvNMiBspSlVhcSxv7J2QwxuQvDBJrpZ4whI4uX/9b
         nEM3g8qEMpr5hi0ZsFC/2SXgegbW7Iu75GfRoduWa1ldzWgrCi8Dq9x8xgnlSONq/pKY
         SnGdW3XdRWKOnrlTEoM6nxyeZUooK0kUa0Eq0NLH9S5w3fZcOrTDufU4zeEcuqxjRh2n
         S8kg==
X-Gm-Message-State: AFuF++lylCCeEhUsPQoCn79d9Hr8f5PWUpXPtLU9E8PFdMJAgS4seqRH
	pEb/6EJPfhM9Slk2Ugr11+7FTEyxEtQJxqKc+i201jwNaOyippk4fFylwAB8wkpnkkBos0ws9ol
	whc6TXVYgRljR7/8r3NyWy5MnS9ort1YnXqG/d8Uq0Q==
X-Gm-Gg: AYBFou2GzFiN3gSXbhYzZhWrrTXjeaVPHQsvP5g80Hu0WdJvsSY5nWB6gmCX4BaVc2J
	CMwNqkZ+OhFUIdQ1aYBCLsfPrQSV99fsY5ALPzJMlP6FKRiJwL9wu4VoSpTpIQ1hvKYRgDj4oF8
	VmvBbatswMvGWygARwWkTcxat45e/BTVgrX880QZR4jGOEXv4IfqvhpSWFrYV56yHSIPCaVJFdp
	rC9mdMxQ89OPZy7nrT7tOvAWLjViE/m0u4Hx5kd4WZHHH5oRXG1EcNtFgPTJEh9AhGk4f4g5INP
	2l4SBDehDPQibhTnwbE4nwzWc5MMlvHGGWohBZ57gSxK5ieKwuBhfNCusEAteTvFIIp+WZPnJ4t
	PR2G/L/rgOjAxLKsgHdTq6HCmb2BDaEiiMt1KALYa7CIgxLOPVXm2WkxW2tim+5C+oEiRx6W52I
	stto/G+A6UhUc1K35hrjSB0A==
X-Received: by 2002:a17:907:1c94:b0:c25:f7db:4be9 with SMTP id
 a640c23a62f3a-c2a16555e01mr184141366b.15.1789719399510; Fri, 18 Sep 2026
 01:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917151350.597953846@linuxfoundation.org>
In-Reply-To: <20260917151350.597953846@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 18 Sep 2026 13:46:01 +0530
X-Gm-Features: AcwNN1XZmitjPyByb4HhRsoztvZ-v5CbuVYZ54pDo3GeAR4HAdHrMWruHo8HW08
Message-ID: <CAG=yYwmjqJ6jBZb0UJPbcxTyv=eFs_GmNmu0sNR9Vbm0FAx=qg@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/733] 7.2.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

  hello,

 Compiled and booted  7.2.7-rc1 (using qemu-system-x86_64)

No new typical dmesg regressions .

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
