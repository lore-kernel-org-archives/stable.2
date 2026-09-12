Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422503515C1
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789234393; cv=none; b=LlGS3PIZvc/5wa8AscwLYOKi+tWtn417mj8kjMSRdn4Sx77TI6GsHWsH9BmZyfBgxn7SLGbe89lCpJLN5+XemHCERq+y1I09UNHEyCJik8OzF9gizrIvJ3SaTu6noesMdzbFx8YOFrklcPEI66RVEjMJBWP3SLFSbzouxoY6sa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789234393; c=relaxed/simple;
	bh=EiAEJfMZTtWgNFlG1Kn6MkmrA0T0OKXP3d4n4uNbVVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnuZrPd1JHKEKyq4lNR+oLGu9c4Uzb/G+ScTIDIC07TaCtsGsU6zjK8yd7OIr35vGt1xXlCBJWdBF3CwTAGof1qlEU4e0O9wfH+fdMmcO66Y2AWT0A+r5Q/bu4wusfASre2vjs40c+J9e7cxlf7Z4yUQ5yLZ1yRjuS0q2XW/qp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JYuM/GRo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JYuM/GRo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso7783955e9.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789234390; x=1789839190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B870ygeANjcpypjK7/JSP1iclhPyzN0EU3DaKZEWjNI=;
        b=JYuM/GRoz7HvgqOVtOPfN3+u0H8R8CXaGZ4PGwzCQWymRtVbXsJL8YQ4t9LZE9EoHi
         Xs1PiApx2cTlL3Y0+CqdAz07uyVBeeyTveDhwUyqKgsEPwV8ItWP1Ezqpxdu8Zntfbv1
         2XNQtHmgjNB6alQjdzT5f6Awy7u7SMzdIsWIfAjv142HGp7dC+cvshy9oee+ERnMlsB9
         MyJ368q92BTwDlUEM9xLCYvcJIUKQ8++DGZ6Zn8shiV7yU7W7okP8qskn9QYTN8wTvKp
         w2Ir7fpBA964QO5a2o47xoU7xeoi06Uth3eVSwaXe8z0r/gbi2GQjyPPYCpKgmgzkd3U
         0Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789234390; x=1789839190;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B870ygeANjcpypjK7/JSP1iclhPyzN0EU3DaKZEWjNI=;
        b=bpiuSexMdLf4DbbWAvnmT/lMK3WQFrOsMX898xOzeQb2yuCt62wWonrg2dais7Uz1/
         ogsTLl5hFVvw5modzpu98YAC6tNSyXH5WUDJNJDyhmaTZJbR9A8Ql6OD06goUynpJQK6
         Cw8GuBEI/M/jAFjMeRTEDbk9pszimclI83VxiByYSqY3WzQpS0FWDGtOT4DjdcfpHr1w
         o6OjBL8j60K6GBehCDBrxHT4jJkBtN+yAmcBuYTqug10jtOLMEvHUhXzmB3bgwy2qJ/B
         fHYZH5AOFurh5kqgmpcsBE1DscqO29twy7hygnoJwNWlFSuE++oSpcLJX0iWVWzEW2Bj
         xSEw==
X-Forwarded-Encrypted: i=1; AKwUvBwzjSU4Hei0JlnS80AobfcnW2a3imoTYVdW2Eju0rTSmCwFK1zNRpLdJYo2CyQvhomBS/H84T4=@vger.kernel.org
X-Gm-Message-State: AFuF++mJKiBVcQmFiXYkWnhDRfBmHb3SHgqGRYZleoFkq74DwybvUXhm
	yW1MVI2WQqFSdVWRcQI3Rl4KLczYkI6a7eZ30PI7ijdbzcvc8t47H/Q=
X-Gm-Gg: AYBFou2OVP0GG1Lqq9eTsae5u+3yVYJt+Ng30q8X+1VVBf+l/v5ibk5T7Wp6ECUtXN5
	OAqbSwACXR7HECCHOCsnyM2fZ2epQ8EIFCfFw2avuc1bsfEO3ZMjQOhctOFUIw+DcDmInCmvMH5
	ofRQqb0L8x8ZelatJtAHKDnG+bD7m1jzzNN0UN/0UDuZG+i6fpa7SsVkDRxTNMQ6nUNd6h8cpGM
	albNWHmqBJUHbEL4+NgihKmsEyK8H9TMCUB6H2vyqmvkIshN1DAvv76DYOWj0FQAGpkYjN/dBgp
	od828H/zEozimwj1jbcA4ol7swSkAmnCbF39MzO5duwb5W7c+QKO01CFua4oYl7xs+w77vPPFka
	4ifWH5LhC2O2WnJyNkIJifhhGlrYLpjomAj0ftlqA5OidSDtx2/RLEgrShuhqRj/jgk681NugWz
	I9eO+e5HxdJr8/Nq450TWSwvyMahev6Jay6Fq9RlYj6/9JOAkCUXSHOIJSH8NiSmlCWV1AdsLvz
	i0tZIeKJe3fReWvtEVtPPWk4ZD7SsxmopND1KkbZk9EH4R0AVms
X-Received: by 2002:a05:600c:c48f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e619831b6mr112079735e9.1.1789234390460;
        Sat, 12 Sep 2026 10:33:10 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac4da.dip0.t-ipconnect.de. [91.42.196.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm244057125e9.3.2026.09.12.10.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 10:33:10 -0700 (PDT)
Message-ID: <ef6ea817-371a-4038-a73d-274fece32f4b@googlemail.com>
Date: Sat, 12 Sep 2026 19:33:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 0000/1518] 6.18.52-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260912065623.398859879@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260912065623.398859879@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.09.2026 um 08:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.52 release.
> There are 1518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and seems to works on my 2-socket Ivy Bridge Xeon E5-2697v2 server.
However, I do see the same strange dmesg warnings that I see in 6.12.110-rc1:

[    2.397237] Driver 'sr' needs updating - please use bus_type methods
...
[   84.031323] Driver 'ses' needs updating - please use bus_type methods

And again, these warning are new in this rc, they did not appear in 6.18.51.


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
