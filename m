Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356295;
	b=ZK/UlwgSr6Ww5+kGqGeKHnRJCFFfNFWhXWObNBZUti0r0sHZJj8qSGffK0BVAf9N1oHZ
	 2uWur/LGhP+TXVAh6InBziCfxXVURFdan2gjKUQHti2+2OsM+R8wUqo9xQ/7ph4M7ooM0
	 QyqqbUpwYab8r7OU+0S1Wr+Ye6/plkAKVgsYZGn3pQKhjxVG0acFIW0OV0a2rGaLk13Su
	 HBegZoY6VAFHnqiAq8xzHPRupv6Dn36uNTMCxSlmrSNgGLVqqhLo9VWSzok/kL0JwRBVw
	 zOY6CeBHRcOTtn3TjLgd9hfCIaJaSBkKSEec5/5uW6SbjgblB/8B+fS+pGVEWm6FCnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356295;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+odUupFlBPfIWlLIIHrecttuzzglpzR9hW0hhIpLUuk=;
	b=g8/dv5GPJA/UlnX1eGD1jtZQqIwde5dKlvaBoL62/zpIJrF11h54y2OcEH5hlZnTEAxc
	 83obXxhmEpT6hkh/Zt9oqKmNUBv1M3DwSwxxhQtctVJYeofol2fB4CKxC4ynwZodMvwoK
	 M7K+p5mOfVHxVHSJh9bAR9rHOa9dguRB4tfeaDf97nkO8ftDZNWldkjB9ll1EuR/4CrFK
	 esJ19YMoyqFDLB3rh6hD4aZjOI2pUw7Ee3VgBEGG0e2QhjJgMug9RfFGoUPqPB7euQ/fK
	 yRblnIrSe0WPs8PQx8OnS55cm4kUJryP8hH+c9DH8Z/72R1239guQwmjyz7ibIkC7Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e5q8K4jk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hpiCLJJM;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98E606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D98E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=e5q8K4jk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hpiCLJJM
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E6517A017B
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:31:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 06:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793356294;
	 x=1793442694; bh=+odUupFlBPfIWlLIIHrecttuzzglpzR9hW0hhIpLUuk=; b=
	e5q8K4jkQESFMadK+xZ17bV6sjrMosO7tjB0RmqZHu7zQ3r06k9hd6oE7KelED1L
	YMXkqHU9rbYMsjR62QPCw1nzUpgkFdno4Oj8EdAvp7D3+AfEzQea3ZOg6UVucuHq
	TB/HhqIGx5duizGIKIuTE/f2cQlyGcPMjm5MQX0cVgxmYFa0Ixm2o2sMU6glBwOZ
	wkZe6ZoaFCuW3geDzdwto079fiWZ23lIlKljXAgEweQ2eJG6O2yofD93vmnIwhCJ
	umRvDlzRJ+ARfz4zF7AAksgOy5xL6XbKaX9g0JJoDhelkicJ/DrkGNS+sRM4q29A
	P4VednrGM8oW+eg5f4xV1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793356294; x=
	1793442694; bh=+odUupFlBPfIWlLIIHrecttuzzglpzR9hW0hhIpLUuk=; b=h
	piCLJJMbdJjzkhZ+bg55FlZMRNItCxz6stFKOlqmnapBzjuIVBcS4hW+Zy3ck4wW
	38s406w+LAnkRgAx2D2dxfO8+93ZdwzB7ReofVjWQD+rN8j1pyDTq0NEGXLgVQPD
	1Y5gbYWk8fH3E6+eYgb/fIaebr29wujxrIc7XqeR+TznByE2rQq9R/X/sA2kh9+X
	HyAZeGAcM3BZE+YKb3bcluLtds+dBeo0J8hjoUcxuGZLLSrajUYWdklYREef6ZN2
	0BIBihcMtpqvc5Ed4bO7Z2FDBH+TRA0nmxiJx5FwVfOcqbfAEWKX4T5titQVbsnc
	mxcgRlQI6UpjQoHVI+5TQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793356294; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VFrp+/fRCClK8Ml0H3w5hxxxng8CdSGilrQUhWR8bkS+Wjw
	WDwfGiPHjIwbucTzJNJ8x38UQmLPDQwY76Clrunv06I5NCpvIVkpKHdFpOoQ1QAG
	8SXEjxdkmtC/NBHXGSvHdoYAImHUqlHJblq/Hh2K0ls76M3hvZQhgvYCcTLx4/h1
	lZDd7x+uZZkEC5dgXNSEXHcdThZYUyPVbdsq4xYHp/etsB6edMewVu30xopb/4Yh
	Mj1zbgiSk+KHS1xeC2mD4YHDiGVau3aZsdrNi/1a+G5bwHblhJk//jkYaEd0hmw0
	YqwDgSrb+Cf6HWlKuS80gEyJI8aYFFUz864R+PQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JwT+WW6TYVidP4gIWSqdUyCrPSHuYgzk6dZHUxW8FA0=:8v0yoNLjBiupfOwKOZJYNqTd3oll3AUQi2enYI96140=;
X-ME-Sender: <xms:BXLkavNR9eFc1en5SSJTuYUok_bD5m8H8ZXGfiUuNx4k_ooBk2RR6Q>
    <xme:BXLkal2FG78TLbYgLhLIUGvEqkwi4S7Nd8vzwBCklu8NFtsz4uxvEZQ3_E17Wmvsz
    mds_rxWTX9gfXKlV91j3Lpki-DlI2a2RUCZwube9UYIHUi0Go3wX0A>
X-ME-Received: <xmr:BXLkapw9WbnNpRAcZ86V7M6UC2GR5e4qIUnWnN3IDUaadfD1jcoBi7A4gYOX6Ax467YsC6gUlSDzvbBPZoJj21SLzAn96DUa>
X-ME-Proxy-Cause: dmFkZTFURojwT9WNm7oLoP28hH/1Cxa/xbHzMwFYCokdz5sEahf0Z/oZ4l9Uc8kERpDO0P
    Seb9i/qUNCwSZkrxQJbk18JhzE3DIt7u2GcsgwtUtn0XfulHJPeIlLAPjCQN5BJpMOYIwv
    7Jjn28cKSi50kVcQQUE0yqW1HewqUuYf4+yVPrEjn0h4m7Z2ixZiqxQZPXUoIdNZLQk1oq
    j/09GmTLEgauwxYEJH77hq5Vmxoy79FPDq8Z2vpzaRlb0YPTVgVAAfPIO+6BwdwFAn3C2f
    q8bV2GNR9Kjk02pdD2chQA98RChcGkSnCtmmpu47GzQbb1z6ZDt5xRNvFvBRT+WQYfQyaZ
    4a+NEzUCxwaSBU2bWtqia3LRc4+OIUQagh6Do4dh9sUE0FFXTyR+kaBlvU9jiEamqEVPHQ
    4gbXc3NBLEiLpddndP6u88pRN5KJ7K/tGBwb0Iq5eqagfS946dk2OOSNXlcTJj6CdL/r0U
    1se7m7U26O419LntyJa18SPQ85A9mHIqVc9iF3qc79gSnNmlA8TDvbxQSOidveG+6xiAVH
    IfIpTYF58bm83gaRdNhnZdV4zJmkNrVtUBaawkPHy+SnA4jhKXwzGhPGs0KK/AbrQFbEJh
    irQ2kGoSlvO8BOARxpkZEjIfgcR+8Q7p4Z6Dtcy5qWDotE9skmnpNVthXc1Q
X-ME-Proxy: <xmx:BXLkanpNnH_o-nmQ8slmWTlEHLooWD-AyZ2EjImXwHVqoUcFcWcbbA>
    <xmx:BXLkavVRDHcxn2vS49_jmNFy8IwdcamkiCm_bNJGbGAF2GNUmFCzyw>
    <xmx:BXLkauqZGIZy05M3SN8McJmS7kLKEY_wblT-XD7O9vs3qhusfKi7jw>
    <xmx:BXLkajHmQwxfxwWw0Drl4XaMEOWSvsvY5tHjsS9OHw3GFRlJT3Dyiw>
    <xmx:BnLkahhJ_-gE_V8i3DllFX8PiZwOWNDALPnZzO64pV-kXux8Qpy6YFNN>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 06:31:30 -0400 (EDT)
Message-ID: <b221befe-572a-46e1-8474-6271af65406a@pobox.com>
Date: Fri, 30 Oct 2026 03:31:29 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/168] 6.6.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165943.089486480@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261028165943.089486480@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 9:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.161 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
