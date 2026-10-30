Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386334;
	b=PpUmR526dMIIVChBpR5+M69gYl5haTxcLnbii1Dd3c9CUhqLP92FxhyyfZhjdVEfVjwN
	 vpZ7aJCAE/pJStWeL+WbGfnu1LGYlUHAGCnc4ce01eklWNkdoFZS1uQ2PvqyFbXf0MgBw
	 hswPJVnHGEXJcTJwwgVBK0/hOSCc97S/Ryw5a5PevpSdSsfomAGefDHtHAe8+y2yz+Jr6
	 PzVr7boTCgqaM/DD2YlEE84NOSncc2NcbruGybyI3ArygpADoZFF2aApDVkKLzb/Eujhm
	 2daHjzja7T6yES+PAT0Fv7ZtjsrTrsvN/ZhBe/ijhMHk2MMVxJCqJbIL+y80mw6rItg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386334;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=fGK1L58Lf3KlUE/BnOLYZCvLkUopon9B8l3YkkbBlt8=;
	b=0KsiZrKAkGU2aYBbdrLQyGrMgJ5ti8IJkLkDlyWfwhQOn8OXsy+O7O2ikOq7Xrd3HFCV
	 /Boe7xJAPYgZUV+NkOuQzy6elmU8QlgIuv+NT83ZikQ+6Pw8VVmO7cFcCvd0yjYPpRC4j
	 gpqUid8brFPZAXFazF79QSHPJimFKvpn+GkNiL6mRobS96bacPQl+bIljY3C6y0rJRATk
	 a9R+akY5B7CMcHjrOHTPWVpREFFtzl3fYCrd+c3Dgvu+fQyaiwLUevn4GghBkarji2gPn
	 0g7IxK7QHVs9jkWh7nTG4Mi1KSgiY4jeuT9RruyKXyUaUUcFSQiC4/ZKYulGZcbWGzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="MOuTD/8R";
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60901606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60901606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=MOuTD/8R
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id MgaqxEDwKMylkMri1xhn1y; Fri, 30 Oct 2026 18:52:13 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Mri0xezuie0duMri0xI6X6; Fri, 30 Oct 2026 18:52:12 +0000
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=6ae4e75c
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10
 a=KPP-o6cSiqYLzsj49P8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=fGK1L58Lf3KlUE/BnOLYZCvLkUopon9B8l3YkkbBlt8=; b=MOuTD/8R2b9G
	uUkLcxvcq3P2gzLIWaRhw2GmWW8rK33rq3ol/B9qZkaT8VKEcqpEfJqo9W/DKFfmUQ9KJDz8TygPK
	bxmA7cf/TQAN5PVoCujcLDd9mA8lhmUfPHI/SaZCDM5jXeV4R+DZbj8esyNEl+Zm59usbEhboBvuS
	JwMKakeCmviSNGyHhanmjDduJPoDh8RCtDUOL/xz8dYQYfq8LnWMDKY67CQ85Qn3uu8EfZlIO43yC
	kjyBt09+wqaLOBKZ4F8BHevy4Pbh4iLT4+gc6a4pwAJQmpaEh9SD8nMtMPpuoPOqeTTvqe3W0TjZh
	d/f34+lxvh3MTbWDEWQYpA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:42656)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xMri0-00000003QrP-1EQW;
	Sat, 31 Oct 2026 00:22:12 +0530
Message-ID: <670a3995-b83b-48e3-98b8-e6c86dc6dab9@roeck-us.net>
Date: Fri, 30 Oct 2026 11:52:11 -0700
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
Subject: Re: [PATCH linux-6.18.y] hwmon: (lm90) Consistently use our own mutex
To: Jean Delvare <jdelvare@suse.de>, Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
References: <20261030092410.0e585c82@endymion>
 <2026103057-sinuous-halves-9ba7@gregkh>
 <c0c771d373e863dbac55e6d487f00a0a0875a5d6.camel@suse.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <c0c771d373e863dbac55e6d487f00a0a0875a5d6.camel@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xMri0-00000003QrP-1EQW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:42656
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHyjYgu67bKHdDDjGR0+Nkbt7bYfeuglIYL6J0Y4ns+j/O6bGnCqwp4pwXOheahd96dD5/g5alD7R22pjtMtE+jvyIwCXTANhsK/NAAoYtFXiTMu0ulA
 IvEmiDh/oOAdDaqSsMolyGLqKmWPifNqWYRTcrbGM1lpblwFmTY7jY8usmJQhrqmI4uSgMtVdNhiyoqWGeOE+075yuxlZyRAElCcCZWllzM5q1rDBUcV1nvs

On 10/30/26 11:21, Jean Delvare wrote:
> Hi Greg,
> 
> On Fri, 2026-10-30 at 09:41 +0100, Greg KH wrote:
>> On Fri, Oct 30, 2026 at 09:24:10AM +0100, Jean Delvare wrote:
>>> The backport of commits b09a45601094 ("hwmon: (lm90) Stop work before
>>> releasing hwmon device") and 873e919e3101 ("hwmon: (lm90) Add lock
>>> protection to lm90_alert") to stable branch 6.18 makes use of the
>>> hwmon_lock()/hwmon_unlock() API. While this API is available in
>>> kernel v6.18, the lm90 driver was not ported to it until v6.19.
>>> Mixing the use of different locking models within the same driver is
>>> unsafe and should be avoided.
>>>
>>> Update the backports to consistently use the driver's own mutex.
>>
>> Oh that's going to cause problems over time, right?  Why can't we take
>> the change that did the port instead to make this easier to maintain,
>> otherwise we will be hitting this problem constantly for any changes for
>> the next X years that this kernel is alive.
> 
> Any lm90 backport involving locking will have to be adjusted for all
> longterm and distribution kernels < 6.18 anyway, so this does not cause
> extra work.
> 
> But you are right that it could cause trouble in the future if someone
> backports a fix without paying attention to the locking model
> difference, as it will not cause a build failure nor even warning, as
> it has happened twice already.
> 
> Backporting e9b64fae44be ("hwmon: (lm90) Rely on subsystem locking")
> should work too, I see it applies nicely on top of kernel 6.18.59, so
> you can apply that (to linux-6.18.y only!) instead of my fix-up patch
> if you prefer.
> 

That would be ok with me.
Thanks,
Guenter


