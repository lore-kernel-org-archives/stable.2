Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712981;
	b=4WzJRN5Bz33fyREks+YmXoElalcEUCBVkSZEY0aHHH9O2heQacEFU2Ehjumi2lkLsMSC
	 eRh+XLEcZQaL/AWt4lB/ZfCsFeJ/ysoZcWzI3hk5BKUDGh6BVaOj8u5wd8ONuEPvVwFUB
	 XqIyXodqgmAOTeZ8GqGGwb/RqZ4uEneJY9RskFm8yWXMpFTpvzjpQ2ovKfkt8uFDKmVzi
	 4FD0eNckqmZ/O8CeMjcvrwyUXp7x28DK7jOBzMF+h9LJ2gEVyHXhqhwXEGy1OBPc4XqgX
	 2VDXm1MdObQwI2puJVv7YlybxLcn/aqXarX8Xmu9p/aM3wiNRCjMvPj5bqct+xDjZnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712981;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=p8pRKIIdkCJcS0p/9hJ1x1TDgrprRrlCDBxylB1bYH8=;
	b=zF5R4w2iLcM/BachA12tUkppSmyJn11B5NkPTa2aoYshqI5xbdhLXh1D8gZBMGHqxJo2
	 6hbQnVUNjRtlYvUTGoe7l9XBblpREU+4xPMeuEnEa0jhVSl0IhvA2rHpxbMh6cFafMPAS
	 soTLWtINQCuBI6XOPvqzumUxHWN2Wo1H5jHP87OCydA4PBxQgpDCeXkSV7qQguoDgIZwz
	 5ihS2FjAFCmkO+ye9KBXwQRPQF80mNa9cvm7gDdY2oEETZvnHACrBtCngJ4rOySSxRIUX
	 xvBlgVLxhzQrt9ncklliRggBaLo90H4ZfW2YQygcptiw/vVlyCZx416cWjfQ3ry1Osw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KA6tWNOm;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7A606A332;
	Tue,  3 Nov 2026 13:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C7A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KA6tWNOm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p8pRKIIdkCJcS0p/9hJ1x1TDgrprRrlCDBxylB1bYH8=; b=KA6tWNOmwewtOpgEmq8Kqtospd
	KFJSyP3k1zNCZiDKEIebNDAhxpEUdI2rQdxPxhg1KK8Afd4KOK0GQ2STo/w4IXXfmiNGohdE67eXq
	C6RMhAWq8tuWdhiAHpeZ/EY9iBKJt7fy27ujmeftgqJZ1eST1ATYgglqaDzlnj5w6bbU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOEgO-00E44o-If; Tue, 03 Nov 2026 14:36:12 +0100
Date: Tue, 3 Nov 2026 14:36:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: loop: release netdev reference on registration
 failure
Message-ID: <2bea0e6e-5bff-4a3d-aeb7-5b199924fb3b@lunn.ch>
References: <20261103100529.1309887-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100529.1309887-1-vulab@iscas.ac.cn>

On Tue, Nov 03, 2026 at 10:05:29AM +0000, Wentao Liang wrote:
> dsa_loop_drv_probe() takes a reference on the CPU net_device with
> dev_get_by_name() before calling dsa_register_switch(). The matching
> dev_put() is only done in dsa_loop_drv_remove(), which the driver core
> does not call after a failed probe, so every failed registration leaks
> the reference.

Please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You must indicate which tree this is for.

And please think carefully about which tree you pick. Does the issue
actually bother anybody?

    Andrew

---
pw-bot: cr
