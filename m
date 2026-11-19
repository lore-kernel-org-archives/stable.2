Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058563;
	b=cBJFTUsIjmeT1CPs0RGfeLkmSL/t4LTodJ8oJKHgyz+eyzJLuLfDo6BenTiBERAIab0Z
	 Sh0GEo9nbKbxeWNA50MxNBq6btB6aKBUBnqq4L4HX1SRriQ9iVTeTKyssCNecOMOWCAQJ
	 NlI8VayG/mH1q/F/PusCsu1k/ADRF8Zd7b9Lulkf44baLfCcKPSJjX5JsnvtD7Sh+fc46
	 MUaTbxuj3hk6nR5pxMHNITjByaXaAi3a9b7Mxyd0OL6kDCd5nlqY4nXlqGx9zY99KBkpW
	 /p6betQrNNYy6/bL5UdvcHh7NI4+ez6i2mSSh/jL/OehwHlN6oD/ffYMnCBcN7Lfczw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AKmYgMCE5Gwxj78QU1v/OC/KdP6R4MGCQSDb6SIyFlE=;
	b=eoQqfs2O8Xt3qisfnYzllPX9Hj+N982ofiUA48E9AzMCkdAQahG7vF6IjosTxvxqoYzJ
	 pmhq9hEbj1ATuhWvnFgXK4nFm07H2grp1sb5bCAp09CKhJGSWH+E2jAC6nsEjZF86OoHx
	 4q8B8nFN6ZnPO7XZRPdnlYG1F/otp7bZn5Izsvx0w9QO+2opQ9zi61nJzXX5rAwcG3Cth
	 UsR8il0yqoV9QdmpmChEsght7kKs3ApS0GEAqKh6G0jh2CUCLIM3s19sl0tdMUoUi0eAQ
	 dzaa210EPz+zPZ8RHx0RAWo1YT1P7VXK0FMfUmeaBFhsMtJgi6MQD5skdegej6Ji+1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Y+p0QnGY;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE460A2602
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7DE460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Y+p0QnGY
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso17083075e9.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795058561; x=1795663361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AKmYgMCE5Gwxj78QU1v/OC/KdP6R4MGCQSDb6SIyFlE=;
        b=Y+p0QnGYHN3hsp58OCbYS4t+5voIG5O+BkmXU2V4bUstIbYoKzU2dw2341PyKZY3Tr
         tVkJ5Rwpn1Y8rb0FVShqIExaaRbEjyRgDJP1/8CRkY3PnWpousIoP0QVqsR4aaSoP0VD
         aUBK/zTGYoJow7SjVg6VFMSoJmpjr8w3VdRL9fTIy+8gDpvEMCnKZbZ7RCXRInmkrCkz
         NwikxOTqox1sMwv5WOQi6rEP3OdaWo04Pex+lCtXx9kaQYREgemBzDhyx4gEE0+Kfw0q
         YsGEkxsbABtFJ+/nS9SWv+SceFkdodLi+6C1x2nIOIZPrWHkruW1fgAToIJux6ib0Kuw
         yjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795058561; x=1795663361;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKmYgMCE5Gwxj78QU1v/OC/KdP6R4MGCQSDb6SIyFlE=;
        b=x0mKuMhxSCQfEOo9qtfpnG7GgphEfHS8+i4PzkxsHguFZn2OrR5NgWydFTxZmK8Nnw
         J1XotcBjWhLWR/lzrXNFT7c9zsapea9SzQhyMiRyrmzt9SyYNp3B0kQgtSzlw9HMfBdR
         48+qyu2Dd8D5BtcEDmSU+P/ECKfjWxk1zefiHZ7AtBTPCuN940+g6MN4V9KkJAYZT5SC
         DVXVVFzAOvc7h5z7I5F7jaDJjdhM4QVQa4zylfbXulA/R4Sr1WAhARXbGwSeRuB+RGE1
         cz6D5yIDifKTOS3ihRl17lB9znxpdlGXFY9GLm1umWw7Oi20pXqXbmZ2KNklVmSoR7v/
         ZDkA==
X-Forwarded-Encrypted: i=1; AL+hErEuY6PgpZLYmV/RC61TcyjpeXg2nsPIy6ZplyLRlvR/fv7Mz8VhsAzeU2rl2Pdvmkq824Un4sA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y+8YE76MRkk6acipucuSDbk85HROiaSt0CxC+NGBjE2QTB2nm
	1sUGp2QbfNpk2m0KKXe/9B3KoeqJVtrnuO3/MLQQzbrc8fE9DUaEOw4=
X-Gm-Gg: AYBFou2W2icydC/DDBfQP+qjnoTLPfvFjpGX+TJG1pYJ+V0/mWWw7Ejd3ew2yJg0Ykf
	ceFO+rZJOhNSNs745n0Yag+Gn+ACiKCyEPpLdaO1x+GyAL2Qxdj5tMZGP3L4cUy2vcDmTvJkCJE
	x4lgndlL0geUVSpNStJCzK6DWAAEg/Dj2S7bkvwS4cDtGFVx4JTdb8Hr5k6nlaI6EgC/SMbWGkT
	Y3p+2Lh/wfmlRiQYv7hwKkHqoBVUcYprZJ7oqjoTIF4YXgLDNOw8b0RwDCwFtmGF10dqU8Pw7tt
	l17R/2yEsW7vLoeYMjOV1ZxeEsNjAwXV2QoQ64sd59CFOSiPuS8xEh0t+xwBKrhwPDTjG7/d0fT
	o1nEe50/1UpbIlFxifuUsL9b9vZZHHoXeV/fuE4A+6lnA3RIjTcbnJ8hhRHzp9ZUIrl+dH8YMv6
	DmS9FxOY+woKUbpAamMUO7w+ozxMP8pARgv7UkS8Z5TRs3Q5PwGnHsj39oPbr0fa2Et6d8aHmMv
	I8ogALg7dx5cZxkJPEUSC3cKq1EmaWatR0LmWsfuYL/bkse6U/sM/3zpGZSfd3JKlL7g8/lVM6h
	nAlQQGDDnbvpJgy6ZY3GGvA6A/gwldWu2nUUnW12sCVQXqtulljEaF8EZ2dm9mEHevHIe4WmuFm
	4+lLDUg==
X-Received: by 2002:a05:600c:348f:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4bb7da4784bmr85514715e9.34.1795058560948;
        Wed, 18 Nov 2026 19:22:40 -0800 (PST)
Received: from [192.168.1.3] (p5b057d66.dip0.t-ipconnect.de. [91.5.125.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm5941125e9.0.2026.11.18.19.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 19:22:40 -0800 (PST)
Message-ID: <eaa1f85b-44e3-4f95-84e9-3500327be809@googlemail.com>
Date: Thu, 19 Nov 2026 04:22:39 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 0000/2151] 6.18.65-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150121.603863898@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261118150121.603863898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 18.11.2026 um 15:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

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
