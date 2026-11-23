Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464566;
	b=wL9HP+xbxuySq4DvSUAw3/k0l5NE23gyI9ymDbRbY3ir2ztL3NyT4ulgxAHYLfrUUSiS
	 lBlXt8yMmLs52IMv8bGNp7Q+gnljLcPp4LKmUNHtUsOrrenplnEDv+TjKotXVYhSFhbZ7
	 w83jiDWdGa/kcMHSmjst61k/ys3gdW+VlQAY7RsJv3dcT+lyeuulIBN2tnIyK/p6k/Rsy
	 3jX21HD6eVGaZ0AIoLH9sM5EREynu1vTYsLdD5APGQO8VfBIgYwkL3Dg7BxXwryf+OtG5
	 pQ2+fP9kyRQWbgPcZxm6EH5bgA5se+ZSR/SWedzxHP9VX2WQX/Nagwx3gWjNgubFH9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464566;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=9otpOx2hP3p80r8IPXZCT5/F27bYm6jkIoRrVSHHchY=;
	b=T/Akide9kCkYdNXMYEIFTpCnjspPZTW3F+WzycL8JgejRIHYSJnCxwLuufVJegmJAUS4
	 1L9/VVj65W/Ahds5K0b8MaXgqM7xtf7iVhGqubgvKW2ndI32WgTbE42H5zSgTvk9/yL2U
	 rn3WZIAfobJiGPtnV99ySlDN1/D+Jv9nFy8IGuKGZ38AOFdB76cvK2FNAYQRRicO0WbX1
	 BELNgppL7rpU8XsQyFJ/qompqL3TH/l2QfctFpfEQWpIe0WxjMsFqThE62m2dLXOADzSj
	 Mwg27ySJ8/AuOeg+vw07CWV3JNr7BBqJNj1kb/3HuBL97CqUI6SRc7J2OWeU34qQMVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="ic75w/ud";
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92C606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D92C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ic75w/ud
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id VZmsxMNFYyb4YVaLoxtkCP; Mon, 23 Nov 2026 20:09:20 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id VaLnxjy3wdRrRVaLoxMCJT; Mon, 23 Nov 2026 20:09:20 +0000
X-Authority-Analysis: v=2.4 cv=LOhmQIW9 c=1 sm=1 tr=0 ts=6b049d70
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=xxfhDY9pAAAA:8
 a=VwQbUJbxAAAA:8 a=VOs2tEXDhbcqsyWIaPYA:9 a=CjuIK1q_8ugA:10
 a=rMMjO1C7342AHnzdNuLM:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9otpOx2hP3p80r8IPXZCT5/F27bYm6jkIoRrVSHHchY=; b=ic75w/ud+cdIswe45SPGb+z7qR
	GUCAxW4rVDPyeg7Esf5GgiW5gCBSA/e3N9yYXyGtIz4FrO7JLzSNt4IZ3ccHcoDhhlhss+n59eLN1
	KBPkd/6Lc5XGdvJEu8GkaR/ctYZ9A7yNnpCpNj5o0IeXzQXu9BwxN1t7u3WVanNqVlnMW+nbPco88
	Z9DOrpmobmZt9XIx/JmJFSax4R6DwJ67mKF7ki4K1IaZClFTMjw6tsAZI+ebueOV7Rrz7I+m1T9MB
	8YjJLK8EJBUXGvdY1H12cPv2hUMo3uOUr1pQAhsIHKd87gcgWjhHq5okT2lLGthvck7iag35Mu5sT
	JfBrig/w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54720 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xVaLn-00000001ckt-2Rgv;
	Tue, 24 Nov 2026 01:39:19 +0530
Date: Mon, 23 Nov 2026 12:09:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Markus Haberlander <markus.haberlander@rosenberger.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>,
	linux-hwmon@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (cgbc-hwmon) Add module alias
Message-ID: <4a9db021-4352-4578-badb-5efaa504ee79@roeck-us.net>
References: <20261123-cgbc-hwmon-alias-v1-1-3054681f984a@rosenberger.com>
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
In-Reply-To: <20261123-cgbc-hwmon-alias-v1-1-3054681f984a@rosenberger.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xVaLn-00000001ckt-2Rgv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:54720
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPVdTI7uuLH4A3aekIghNsi9AwOrrYRgymWv7xLJdWDpffAqsM9xIlcn+rU5DEqr5hFfvxplQvVN+Jm2enogE7LIu/kOxYCUnbLxQ312AT6uhwekLLrw
 GyQOLBYrfBOpLUHznu+3y9paqox09iYkSBt8T7hbvBH91S+2jUvdYvPsSLZ4cg8XbHp0AmTh2c90oeF90qHQzhThPvkuPcWBobpKs/cZsroaK1lByqG+Jz5G

On Mon, Nov 23, 2026 at 08:27:01AM +0100, Markus Haberlander wrote:
> From: Markus Haberlander <markus.haberlander@rosenberger.com>
> 
> The board controller's core driver adds the hwmon cell as platform
> device "cgbc-hwmon", but the driver declares no matching module alias.
> Built as a module, it is therefore not loaded automatically, unlike the
> GPIO, I2C and backlight drivers, and the sensors stay missing until it
> is loaded by hand.
> 
> Tested on a conga-PA7: with the alias, the driver loads at boot.
> 
> The patch and this changelog were drafted with the help of Claude
> Opus 5.5 and reviewed and tested by me.
> 
> Fixes: 08ebc9def79f ("hwmon: Add Congatec Board Controller monitoring driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Haberlander <markus.haberlander@rosenberger.com>

Applied.

Thanks,
Guenter
