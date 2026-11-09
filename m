Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265264;
	b=I9dp8wU4jPpIxAW4Y8eNluzaT1QvOUz/VSEDeZQ9wJpw4XvJCBh2TX06KCTWtuA6s1Dg
	 aUnWsDw7E2oI1PjuZQcqTX6ajMN8uXJN3oB0fesM6lEF/G+MpofvL09njpA61Vs1tjq5T
	 cXnWQZtylqQfSeC+Mm//zACEbvr6467IGCtNZ2JXkIw1v6as3f15//sYJG+9yeKNBu6MQ
	 RosB7RxX6yXI29G3H192fr/qeNWekwFJWFBfZ00BevnF8m/PFqDdeJBHwYm39b4uNfJsq
	 2oMEOwivCAvjaGtuABrYCS5Ar89rHVf+FO9iDPeKJZBxX7JagJHH+e/8dnnzaZePmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265264;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=zL8FK8P5Vsdfkx0MZ8+/mUpFCsZNRdF7JxzCjScEi5g=;
	b=iFpbjK1b9UCAk77e+xDlgMN7XPICpdpQ+a3r5TRiAdNXWtmFLOmlu7lwFftBH0on6fck
	 JSb/EA2Af69VOphpIJK0f+2qznEyiiy3CflXCcyHgAeGALpDh1me1x+SZlMddgA91o/Fv
	 Q95xAOvrCN+IktRa11KnFhF0BCFp8bERG9E1OyGZXM01uBkz9R8CJj0gyieOT2g7AJ2xh
	 T7RVRwomJG89crESWmb7g7FlRCKwIl8U5nWp5sy+V6Hbd2IXJuItG6Lrko20H5PJgu8PB
	 +iZ1yPcKuzrfJANLjNZ9EM8veJHrueavk1yxwy5im8TT+BtMOB871jL9V8Ovqr7wUxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=oEqpXKT3;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E70606A333
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E70606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=oEqpXKT3
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id QUb5x6vWUOOJnQYMJx7CuY; Mon, 09 Nov 2026 23:01:03 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id QYMIx6fwn8cn4QYMIxBM0R; Mon, 09 Nov 2026 23:01:02 +0000
X-Authority-Analysis: v=2.4 cv=Qrde3Uyd c=1 sm=1 tr=0 ts=6af250ae
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=XwxYKhIv0tpjMc_zibUA:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zL8FK8P5Vsdfkx0MZ8+/mUpFCsZNRdF7JxzCjScEi5g=; b=oEqpXKT3wYL1wg/DZ1OCAmn/KQ
	8jKL+gRhBFw50kw3/1IbtF+x3BKxyHO8/ZHuegflaUFp2X23elHmIUyEI0IVUD7Mygm00WsTG6ceO
	JdulNAYghF6uY2e6jDXSkzFEmMkUNdPGavsBr/HVrzI5TO5K6PvbnI/THmShWtqcMHS9lOyBYbyUs
	RWywmG6oBdddctKk8NwopLi1ceUUvqlrfkfydPoOVyqiIWoye4Fs+5P3RD/H4ypAbRDN4ekm+pXZ3
	/z2LXMfAIkRCZJArqkzHeEjxwUsJTCSbqMzWIS16vBnedaTksTU+Lo4KeEvhybi+KVl+gSYZZke62
	u8Musk0g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54458 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQYMF-00000000mLs-46PO;
	Tue, 10 Nov 2026 04:31:00 +0530
Date: Mon, 9 Nov 2026 15:00:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: gunyah_wdt: Re-enable the watchdog on resume
Message-ID: <bbff9c33-0647-4608-9cd7-07a6801791e0@roeck-us.net>
References: <20261109-gunyah-wdt-resume-v1-1-fbd84545ce92@gmail.com>
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
In-Reply-To: <20261109-gunyah-wdt-resume-v1-1-fbd84545ce92@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xQYMF-00000000mLs-46PO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:54458
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBQzpwgKdvL6aJZmZ7p0Bbd0I7m2WpmTEhB5xVznEWxeMC4ZnjadyvLymtXv2BeHgjk3wiUSik2fVh2FdsPlzhW/FnmwgAYiz0BjuEzoUknVEGFqPe0Q
 4ZRg5gKsMq6kvtL0w+vZp9ZeraLI+RBth2cNtlyB6c9vguBbN8Vb6gvsGq8mM77ntZi3gjcFgGGl8dM0A21v/Xs6iXozUpVJqunQ9BQDFje0tETnDWshw6KY

On Mon, Nov 09, 2026 at 08:26:52AM +0000, Stanislav Aleksandrov wrote:
> gunyah_wdt_suspend() disables an active watchdog, and
> gunyah_wdt_resume() enables it again with gunyah_wdt_start(). start()
> first disables the watchdog, which fails with -EINVAL when it is
> already disabled. start() ignores that only while the watchdog is
> inactive, but on resume it is still active for the watchdog core, so
> start() returns before it enables the watchdog:
> 
>   gunyah-wdt gunyah-wdt: gunyah_wdt_start: Failed to stop gunyah wdt -22
> 
> So after every system suspend, the watchdog is left disabled.
> 
> Move setting the timeout and enabling the watchdog into
> gunyah_wdt_enable(), and call it on resume, where the watchdog is
> already disabled.
> 
> Tested on the Samsung Galaxy XR (Qualcomm Halliday) with s2idle and
> deep suspend.
> 
> Fixes: ca316e145c35 ("watchdog: Add driver for Gunyah Watchdog")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>

Applied.

Thanks,
Guenter
