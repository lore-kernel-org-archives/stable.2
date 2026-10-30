Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390562;
	b=Ym/tE2tCCxUN2G150stNBfz96/rbOULWROjZ3jetVGSVlOr6U+EocDKhipCJOGGwWOYu
	 xQXI5xcNAh77XMAzw4XyEHyCOYQAL8Ujxgo4NstNGhip/gtj/Tl7fj3dsesh2Xxt3iZ6U
	 ECPpswGKUldJT3ZdyIOCS+bqsS7isalvDfaeIg7jxfTKlZ3PR51uQD/rAFl4h/NLCQfR2
	 1cvHhFVOOVGExm19UfuPw/ArhZQfHSyyCxfmDgjIA/kfwBsD57kgZMVdFgezOuXag0Pa8
	 fChjaaBu+nv6rgoc9HIuAXEjfwhLseMDxBMzUyTVv+bVYFjag8VhwS67aHEl55hk1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390562;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CdgjB3iMB/xpCXm7PRSva07wAj5gmWKOsYwxpue/r48=;
	b=mNSlN8ldhvDlnyfZcAlFV7ANByTdeST9rYDgwfnVQrK2qaLlIEhbyT144bFF0Fdfg/ww
	 9b/CSw2xY7WLUVpoOyynWLjo7ZYu15djQXwL/KhgrFikhPF1wA8+NWzBFrJZy5LWMneRS
	 m9AnY0UquX2maLGWf+ftlDXlyLUxAWxmLWJffGsRhP9sdaWr883NLemfOWCldXivsOfRs
	 e+XbDZ1Lbz553p3cGzUva9phrIJinMUs0utN0zOjsgJJu2yyIA1c+raE6offHquNh8YW1
	 DGhH1ZOnC7azR2PtTUSMv45E18oHHERv1vJ+mIh9ZMRb/F3saczw2R/1mfwTEcXfZYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nnvYecgQ;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D891A606A31A;
	Fri, 30 Oct 2026 20:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D891A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nnvYecgQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CdgjB3iMB/xpCXm7PRSva07wAj5gmWKOsYwxpue/r48=; b=nnvYecgQBjPgn7ZIxAbvE6MhR8
	jaKDY1bguj0p8uWbaxpsbCCUBMj0m5XFVq5bkZ8CmnhNN8WsKg1XXK5cQRTx/3r1ae3dNSqRCTNtc
	3qcYP2vfr6YmksJg689a7UiNps8aeXsiEhfngI+9gDKJoA2gjhpxx2DBqQljUNfNp2xY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMso4-00DQaS-L0; Fri, 30 Oct 2026 21:02:32 +0100
Date: Fri, 30 Oct 2026 21:02:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the
 interface is running
Message-ID: <8bc84f9d-4c9a-41db-af34-28377cfb2b1b@lunn.ch>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>

On Fri, Oct 30, 2026 at 12:02:04AM +0800, YuanZhe Liu wrote:
> lan78xx_disconnect() unconditionally calls phylink_stop(), but
> phylink_start() is only called from lan78xx_open(). When the device is
> unplugged before the interface has been brought up, the attached PHY is
> still in PHY_READY and phy_stop() reports:
> 
>   called from state READY
>   WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0xad/0x380
> 
> The same warning is emitted after an ifup/ifdown cycle, where the PHY is
> already in PHY_HALTED. Call phylink_stop() only when the network device is
> running, which is when phylink_start() has been called.
> 
> Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")

Why did you pick this commit?

    Andrew
