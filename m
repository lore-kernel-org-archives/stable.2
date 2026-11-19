Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131621;
	b=lPkodlrhIftShtAbP4axs2y+ksw9kR7dMQ/OinXyGubhitAqEt6xgcujHrwh7YRAApA0
	 HHb6CHecRiWuSz9XAUlFLE20j/G35DD+E9ntcMCH6kr2hBpM55ML2XaphqZRHsHg4FnaR
	 Q4qa9D8NM8nXFe3/PYI3XCRSrbdVHa7l5FsUJ/Kbw6hc7GsQZpPQ8KKG1T0IQCO27VtY3
	 OflUCxuCswav7GDYmclhFf2dxdREqqvG60gP+Z3ah7lsvv7yRsUPbvOiQBpJ/xnYiQ9yf
	 r1slTMrym3mcnyvZhS5Ou31jJp+ZfjnfwJ1fdgP5ZX5FYxX8WtxIsZZcTqBBUWVwCuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ujRBUPW4rzGkgFXhZZSaVMhS3xheXh0mgN3K+pM1GQc=;
	b=RxhosSjXZWZ34Nb6FvjZa6vvHjcjJJyhYuIgoL6F7YtIbq4K/fM2WC43MYg0Cu8r4Xm4
	 Aft+jLNTbWGsGLiZ/YkonFH2cA6oJhG3ypncsePFGrzhM1JLb80CkpYDCcHD3rFesmq4D
	 ddhG358s636pP5M49hutqlKkmi5/OuDwimwtZvfK59fSqhgZ1YtiU4cFOSGMtzVN0fYcr
	 E/PnGgyE4olsdKVRpadb5LlxGsDr14PATVgcbmyUl7lDJXrb2VWgFgYOf/xpK3cP3EzE5
	 1Pl5HLDri1II8r7DDz3qBvRIy2Mgx0zn5AUumXOOftDFcEBqn3beMV+JVsecWaQ4Pgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=morsemicro.com;
	spf=pass smtp.mailfrom=morsemicro.com;
	dkim=pass header.d=morsemicro-com.20260707.gappssmtp.com header.i=@morsemicro-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LrSy9a3N;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3C606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D3C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20260707.gappssmtp.com header.i=@morsemicro-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LrSy9a3N
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3b4944a0eso304530c88.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20260707.gappssmtp.com; s=20260707; t=1795131620; x=1795736420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ujRBUPW4rzGkgFXhZZSaVMhS3xheXh0mgN3K+pM1GQc=;
        b=LrSy9a3NaoomosxPTFIlpShr2EwluSs1obYlE120idTnP+lnvSdwC8hexjIT8zAK2d
         YzbeCiQVTKtQJTU0YRo23uvVK9s+t32NI3p2WWeiXo7YQS1PFtcOEQStd5POd4VQgWxl
         GXJYC+zXkswSNKvnPbppox6jDLAxG0LylOvscMy56M+53p8wB/iJUbIdk/7DMZruHClS
         uPG/XVVI9tnm5IFEJ7ywZHnFgBKWC9L6Mpx4FVOlBgZqu4aaHWmuco99LKXTs+XgL64o
         e8tBUd40+X75xBjPToTDLuGj4UpDzbn4Xb3I5tPtPAjv0nDurLLjJ9G3CneS5pM4DoJl
         TklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131620; x=1795736420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujRBUPW4rzGkgFXhZZSaVMhS3xheXh0mgN3K+pM1GQc=;
        b=ioUFyo7I6KG+Jb6Ym62WLqAfDqzxR2MyxAcdD9bGJWuL6y7tDnagpFGRAAicERZIXR
         AdRjh0pu7012n3W4ElPigIJh2c5JBbrd6+4NWAwYCIPzSo+ek3uzytJwbnOSzN22jE8a
         rzRsZbiKrTT74lxuUUiEbKJftpIgwcXongNVG+MaeKTJEhtpxEtMrAI7IR6Ul8owPdXK
         nfQsregOOff4shlQv2FiPmOh7DzaQc8Rf6x3oaM32b1dpX7iTjz/vRZwMJ24MuPUgYWt
         zAlHe6jwGOQfFHrtD5qO8TDY++fLI2TaDLTUyDq4qQKLUCZ+GegE1/jPbIv26hGIoW5M
         4FBA==
X-Forwarded-Encrypted: i=1; AL+hErHoyiiv4oy0cB+AJZzQ5v6D0ef8XTrstEZ1L1ehdpm+EyPd9BZ57z6cDYykgyKdTKXGu7hfhII=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nydtM8pChZ+HsssXv+pff8oilk5FPfLWNzIjjnDw6KlsdtqaE
	VLIF2sbC7bFofi3U90xJ9PnPceq5XNWlzRoXzdjFo/puh9FYt6+qsrwj/jLY+jYPHr4=
X-Gm-Gg: AYBFou2jhJLdcH4VxsnzCiyiY4WTIf+3LK57Xi62SdhCPsEtCfbnvtVZ47YiNuXyJ81
	eCI32CnkMqhHdwJ7+0B/lpTO0PmH3/1aiauHumcLncibfJUBCccoN9AL4W5jA+SRTM3GJM1sFV9
	GkDFONFEHxN6LUHqcyTYpm4uPBoxUp3bL6dwC4A3n3n8e7Ii18Ud9vlFc4GQyQvvk3OHdhxcdHG
	fqJGVVmfdfK7kgSKrNNm0Jts5kDUvhaVTYv6iZRhbMo4y8R/h+BYU0LScZHXAp5th76ThjN49HE
	W69kwWmGM/hUs60LRVa2dY9Vlonf6r8Qlx+fY4lCbWUAIe9j9mo6cyL11439AAy73aMujdbdAma
	v+qpVFY1671W0g4KpOqjId9jJPhDqxOuaQhb3CyT2Gy3ZYnjEuKxxBLqgf6L5omulfxOA51DVEV
	k6gLisFzfm7SGZRirZwHQXUQnTEgq7o9z36zVbQ11YNiRaOULuWP9E+VDfQbAGKwgx4JcdGouKD
	6SdC0SvMNSweaMzzjVR+Ed/oZmOXFc6UIAa77Zxza7baDazvoc7wxkHMDTb534oBBnE78eMK5VV
	LJe9UEkjol6Mo+FoaabL1LSiYL1Mg8zQW8v590r2Ow880Z/IpzKDz9vMqDzCxZBDK5ZOe/vUMK7
	vAvRwQAhWhtFyM3bBRgeVBgB7BQ==
X-Received: by 2002:a05:701b:240b:b0:1b2:40be:a929 with SMTP id a92af1059eb24-1b5568b38b3mr1021228c88.14.1795131619590;
        Thu, 19 Nov 2026 15:40:19 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm1828018eec.16.2026.11.19.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:40:19 -0800 (PST)
Date: Fri, 20 Nov 2026 10:40:15 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: guohongyu <guohongyu@cmss.chinamobile.com>
Cc: dan.callaghan@morsemicro.com, arien.judge@morsemicro.com, 
	johannes@sipsolutions.net, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, 13057616121@163.com
Subject: Re: [PATCH 1/2] wifi: mm81x: clamp command-response copy to the
 received skb length
Message-ID: <pqir2s7da6p4rjj2bqdrjbgdfgrpgyowhpxwj3qnv72fjl2gof@ooe2zsoehufj>
References: <20261117032227.154874-1-guohongyu@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117032227.154874-1-guohongyu@cmss.chinamobile.com>

> Cc: stable@vger.kernel.org

Really ? Is this _that_ critical?

pw-bot: cr
