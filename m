Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560965;
	b=cNtY0dom01XCGnifLtfQL8DT+hIz5Hq8Rg14vw1ip8CwmSXvJjou6Ox5cvXN72HCa3gV
	 ZCEzmNNQlesMpNzM/aRiIA4+xukZ93ToEpttB9/AnEiY9T9U4N0QFr2U1XZ/ZO+uCv3HQ
	 pTm8YUqq1R+4BROXkf7BKgu83uXco2Iwe3wpdckcSBMsy/Xv2OWQTNS5+gdv0Ieu7qcnz
	 6495FlWrNSe5rxNxMCrCZuCdsfHrxeaSQVcy9ziMBur9GmnOapEwXCUarQAIgmKxWaR7h
	 zxuf2u2JtGuSCyl1VYK7JQJS8OGTPILHRnMlajxBC0NVYewUubnBnfTyLpOu23gtFAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560965;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=kkgPxlepizBLlXhgw2TsN5llBrLCoHqm+pT/V03Io8Q=;
	b=AdtuQEJncL+HrireYWiQpHXssOsBqrKJ0Kv9DCuHP3eJTT7uwIMPrmePnBwp6CLLqMlC
	 A82B1MFprbtcewyyL2Sdi4Jcd/oISPU2FOQCp5KGRO2s/Bq7VgDcNnY7XwCvtzRYSn1aP
	 Gi/Zhewf/0uSGIPSeqpFcRJlqSlWTym+58Fa1zpw9eVcHPLa05gq927pBCaLFJdxmtOet
	 jOAsl0pw9TWi1xDiiyPChWWX47A3l2iFJZKR7ueTK3huS1iGJP0sZh9uylgTe0XheFVhz
	 In/9y5wGHD/z7yDa4JfZkG0BKV6hOKMnblp4Yb5dtVmR7uLeNsqBkVAv6X18ajJoSBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nC6Qxexc;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF722606A32F;
	Sun,  1 Nov 2026 19:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF722606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nC6Qxexc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kkgPxlepizBLlXhgw2TsN5llBrLCoHqm+pT/V03Io8Q=; b=nC6Qxexcb1LYHfJcON7cNciq0w
	P7EAHWaqH7HZ2WdN82kt8onrfeZ+ihZZy7LOkPfWmC28+EQCpsOSY0WTMbuhZApllLfjH/+UM1yiN
	+vHeRUf1JQ2FoarU7Ne9KBUlRDlkCPcc/d9OjINGbNG3jMJcZukXoCURNWjPUMt/k4FI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNb8Q-00DfA5-RQ; Sun, 01 Nov 2026 20:22:30 +0100
Date: Sun, 1 Nov 2026 20:22:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net v2] net: usb: lan78xx: let unregister_netdev() stop
 phylink
Message-ID: <2af2ac6e-7993-4566-92ed-c22eb7541bf7@lunn.ch>
References: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
 <e71cccdf-59e5-407c-b536-9dd47a49b0a7@lunn.ch>
 <179351078879.2591.15287457752530436149@stu.xidian.edu.cn>
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
In-Reply-To: <179351078879.2591.15287457752530436149@stu.xidian.edu.cn>

On Sun, Nov 01, 2026 at 01:26:28PM +0800, YuanZhe Liu wrote:
> Hi Andrew,
> 
> Yes, I did, but it ended up at the bottom of my reply to the sashiko-bot
> review, which was not the right place for it. Here it is directly.
> 
> e110bc825897 is the commit that introduced the call which warns. Before
> it, lan78xx_disconnect() did:
> 
> 	unregister_netdev(net);
> 	...
> 	phydev = net->phydev;
> 	phy_disconnect(net->phydev);
> 
> and phy_stop() only existed in lan78xx_stop(), guarded by
> "if (net->phydev)". So disconnect never called phy_stop() on a PHY that
> had not been started, and the warning was not reachable from this path.

Yes, thanks. I see this patch puts things back into the same order as
before phylink was introduces, so it is correct.

       Andrew
