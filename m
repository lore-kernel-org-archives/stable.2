Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676488;
	b=OMObHEWQHFmICpsO/RTwGoUH6oEF8iivp5iVaHTtAtpwNwJ2FelgZwlHIG8kMBzul9fO
	 s91gVSMdaf8S8r1/LjqAmCNAV79e1mK1eQAc+eg/dQ7pKrtow8Mejggs6TIAqCwrOkwKa
	 mhEkCH760kxB4KvW5Lw/GgZdCVHYZVc5j0BMdRwG6Y68ojsuhClZA4LIEjH/6dAjIE2zI
	 TzDhoz664C2Uflg0W7vfZZgz4YfxNs3OxhAuYLWmyhbsvVwtnk9cNJp1ljdapwkxxGKvs
	 3hoJ7wqqlQR2Ifkg5aYjoc4lxOv2lreYmHEq+MjK0OtRFioe2Gi/UoN4sno4TjFi8eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676488;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=GKDv0ntQt/DftzZ6i79e0BggsuCIpXWxjqNNOb2L8rM=;
	b=uHR1LIgdZRi2g1ECUic0SXmSj2Fo7bA3JCbmyDQBH4jJUZLysw+V7Zrt9mcvUoixp3tB
	 cqRQc7AChdPyXCAaihZl8e0ayUORfOkaeMAWiD5cZeF//q6HSVc6ABczGukbx5IX6KNzp
	 ajWbVAL34WLEes5y6xEd3Ny+0oaNtnEKxiCwOMApY6YUH3fZ9HbTICkX2knupl21/+ijE
	 sgLfi9MbW22YHR74AlGx3r7/qZT3IRTwdkT0Eixtis1k7/7Tx7nF4kl4qUgQwbAhQs44Z
	 9LDkFtp9Uu+A6SeF02MYcmhenQaeKVZ7QEV1KNHJUewt/JX9FmEQyOGGEguWvA94FEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=XcXgoEYE;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F409606A337
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F409606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=XcXgoEYE
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id SFkmxKdFFVK9USHKyxmUoE; Sat, 14 Nov 2026 17:14:48 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SHKxxYzMbFhzrSHKxxMrz4; Sat, 14 Nov 2026 17:14:47 +0000
X-Authority-Analysis: v=2.4 cv=JY+8rVKV c=1 sm=1 tr=0 ts=6af89707
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=R5C9hjxsAAAA:8
 a=VwQbUJbxAAAA:8 a=ougBiSQobiDs1THvT_sA:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GKDv0ntQt/DftzZ6i79e0BggsuCIpXWxjqNNOb2L8rM=; b=XcXgoEYEcXVJBU60BEfTirXxSk
	bYnh9opEB29ExJIIXG9OT0Jq4yZlcuJ4ilDsJv90eyTsh34prxKbFRVTIZFhl+lfMn/URM45MP8nm
	YOJa+FGDClo4rTHL1QDhyETS4R2Hb+Xqlhm9fpls7H1Pq+ceM3FRmnd8YWc7dFQIWN3sqhQ1FapjP
	q6umhevRAn2b+TCC1zxmckADLd1DEhjCcf8U8MXPUlQTtYMfQoWKBe4jkbMjpHsB3hnc34C6bCx7U
	lmHXmREAe/gDPIGK4Lww8aCn0GMu3MhXh7QNYQJyh0myj8oVTJFebzFRC1HDGX89pdjZ8FVNdDgHq
	GMQ2P4sg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59624 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSHKw-00000000ZLK-44bb;
	Sat, 14 Nov 2026 22:44:47 +0530
Date: Sat, 14 Nov 2026 09:14:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: zhaofeng2@cmss.chinamobile.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>, Joel Stanley <joel@jms.id.au>,
	j.neuschaefer@gmx.net, Triet Hoang <triet.hoang.dev@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: npcm: fix sleeping clock call in restart
 handler
Message-ID: <05036d3e-2d80-4b8b-a99c-cbb896eb3051@roeck-us.net>
References: <20261111064150.260-1-zhaofeng2@cmss.chinamobile.com>
 <20261111083236.248-1-zhaofeng2@cmss.chinamobile.com>
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
In-Reply-To: <20261111083236.248-1-zhaofeng2@cmss.chinamobile.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSHKw-00000000ZLK-44bb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:59624
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBfdQ6AmNfzxNYg0gi8LbVSJvYHVA7wicbdKGGFaGsKWzTF/8Soi0v0MEjKkm+fyiY/xJ/BGaPEoWtBFnfB4g+KIZts7i94bd5wxaHcU9rPWTHF0SXpR
 xf77Zy1jpFteRjSiR7mqBlRLBDV5LwNRNs8JmPfVMtQHMb9mTlQQnuBmmPENjDBkLtf8rkoXwboUKfObVqNhrYcBycBTMTyxBgr4dCrNE7S3PQDzEs3xC10m

On Wed, Nov 11, 2026 at 04:32:36PM +0800, zhaofeng2@cmss.chinamobile.com wrote:
> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> 
> The watchdog .restart callback runs in atomic context: it is invoked
> from the restart handler chain via atomic_notifier_call_chain(), under
> an RCU read-side critical section, on every reboot or restart.  Since
> commit af084fdccfaf ("watchdog: npcm: Enable clock if provided"),
> npcm_wdt_restart() calls clk_prepare_enable(), and clk_prepare()
> takes a mutex unconditionally, so kernels built with
> CONFIG_DEBUG_ATOMIC_SLEEP=y report
> 
>   BUG: sleeping function called from invalid context
> 
> on every reboot.  Worse, a panic-time restart can block on
> prepare_lock and never issue the reset at all.
> 
> Get the clock with devm_clk_get_optional_prepared() at probe time and
> keep it prepared for the lifetime of the driver, so the restart
> handler only needs clk_enable(), which is safe in atomic context.
> With the clock permanently prepared, npcm_wdt_start() and
> npcm_wdt_stop() are simplified to clk_enable()/clk_disable() as well.
> 
> Fixes: af084fdccfaf ("watchdog: npcm: Enable clock if provided")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Applied.

Thanks,
Guenter
