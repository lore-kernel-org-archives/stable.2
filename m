Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB1238166
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802203; cv=none; b=dV5fb583MwHmjUcCweUtn7o/RAMPf6kqX5boVmnTr5PxlTXOF5rlMm/GnOScNf8q1CzYRIgOwueYzmDOQgesYkfxxkfCpxnLwqCCGPIGqNKfYa/7qmU1oG7jHv6D3vivCoaekR4VE0iW5dNeW2k+yuazXqJI7zMLIwm4xLQHXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802203; c=relaxed/simple;
	bh=czfdUOiQXPZbFnAATDYk5b4JmkpWW4Ig3zzIBmSKRSc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Aa8vFBDhAznXGE8G3CjB7C9xZ43GDYY3MjpTqrGLCM0uPAkH7cxPTrFWm3BI1+g60JluLlou1uVCp2cap8gyeCM0VDMgbTCv9EbEX+Ba2Rgh3PkouB+hBHgIG3f2zzAjI8b/96EA9J1AikRDvMkK+mz4bZ8zRohX6fC5itKeBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp6CWyMh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp6CWyMh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c99672293cso21631715ad.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802202; x=1783407002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1QY57v2o170i5Uh1BA42HSzcmZFQxfvkMqvmdq9s28=;
        b=cp6CWyMhlUgTbqeb+GwV27PFembZfQvCUbWHY7w5WAnIK7jFkllGo79D6/Pk87qNqP
         PW26vtXAUH9BxFBp2vClUh8PBzK97ojYTAoiajCjBpLXw5QIhw5PXXxGm7cB4WKE8wMl
         slh+mDxd7CeTaLfgX1Ie5pZiLhlrKyQKB/YQy6e06KbeL6YeiMPENs6NeYhIcVJBRhEl
         8yCwDw0urfiPQMai6/9vuibDD33ZQNJ0cm5uVc3ZwKDI7LR8CDv9twLiYzQdOenfXCZs
         Qg0eFSUmInuC6eknkdvtpSuvU0PwgF5TBiRYg3/GQMH9RvlYpODwQDw0Pnxv4hIJQv+d
         t04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802202; x=1783407002;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1QY57v2o170i5Uh1BA42HSzcmZFQxfvkMqvmdq9s28=;
        b=r1SBOFoFPcjy3HaU/kJUBnZ4UMuIMslEgPwbHo9OIdiC+bYrmjRHPtaL65OxA4ZeMw
         mcSO4/b7hoHOaNcMWaaPOPm0EITezOlk1Fnd5DceQzCaHjQcjHnJQiTjVOU0fm71/mnp
         9l4gYzte5OXpiz4qoRf19uXHlGNCZhDpZHjcGdyB33Qo2ocnOpIIE0aDY4y0SllsCgRj
         1lpVodSWZMGPv5rFvhMXB01PuyZ/dSrrcSQ3rFFKvUPjme5UAIM1q8xPSHUOSoXzpMfV
         5XhzgBqAjp1tTBbn3AMpzdh+1jJIAwzlu+gf6/vOyDsWMUBhufJjF0SHBi/Q2txfn1/X
         AfGA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0K7G+VFUt+Nx5d+UEwBoKXeOO17p/d+04zTu1PyU2YMW2xLJVjYjwNJVqcgVFw/SHgEkp87w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQL9qrkvumYOWCQK2wqFv2pTgEA+LUfBM4HLHnLcXSQBFTRSjk
	llvuuIS3JON5IyajEDFdB2/iX52k1yFBY46dp1ULVEZF/UTYUshQrrXL
X-Gm-Gg: AfdE7cnLjba1V0YkHfXad+uSUekcWjjcvQM4MkElT2ftAQ9smKbJZ5S1jMRZBwIybik
	FeY+27i0qilVw+0UeW3afXir8XJtDO5FJoLNDpUShRhOHNEG2rFe584h/aHzUc6vc7L9vDXXqVg
	LoCQg+UmRppszx0xS+1v1524Hm/tp8v4kfQ/e5u+cZGAWVyKSvHY6kFF1FfffUIvhZxv4e7YqXx
	1csWA2OPZ/zRLmG2C05/GUygRDYCejA0mTB6vRnUoSMcuXALG+kZiJYzyTg/7GzEj3PRj+23z7o
	/4Kepa3l5EQw55z7Tm9Iv33HM6sDqitD0APBdrEH1gV1Iu777DXtmrvj9fPXHhz59N1iIzieqsn
	57V3jlYdOTbNhRus1vYCNsgM4NXsdRaRvfURbh5+JAijZmVkVicN2tl2+A97g3kkIGSS9hyLGeJ
	8eesPeARiqOp0RoA==
X-Received: by 2002:a17:902:f786:b0:2ca:6a1:1fc with SMTP id d9443c01a7336-2ca2d99a4afmr18114325ad.28.1782802201660;
        Mon, 29 Jun 2026 23:50:01 -0700 (PDT)
Received: from [10.31.13.168] ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a701f9sm7373285ad.13.2026.06.29.23.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 23:50:01 -0700 (PDT)
Message-ID: <1a07fbf9-d21b-45d5-87b7-d9965e73c6a9@gmail.com>
Date: Tue, 30 Jun 2026 14:49:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: frank.li@oss.nxp.com
Cc: andi.shyti@kernel.org, biwen.li@nxp.com, carlos.song@oss.nxp.com,
 festevam@gmail.com, frank.li@nxp.com, imx@lists.linux.dev,
 kernel@pengutronix.de, liem16213@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
 s.hauer@pengutronix.de, stable@vger.kernel.org, wsa@kernel.org
References: <akJ9pd8uhXA6y2s9@SMW015318>
Subject: Re: [PATCH v4 1/2] i2c: imx: Fix slave registration race and error
 handling
Content-Language: en-US
From: liem <liem16213@gmail.com>
In-Reply-To: <akJ9pd8uhXA6y2s9@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,Frank Li!

I apologize for this. I didn't know that different versions required 
different threads. I did use `--in-reply-to` in the patch email. Do I 
need to resubmit the patch?

Regards,
Liem


