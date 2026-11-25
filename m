Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614884;
	b=TZdEpWGyiEzHke7hemk9a0O79edaLXMbnz/AYz6KDI7PlxKw1SuxhssJ4GB0rThvjJ4R
	 vDwYU9Awskcs0ES3I4z0+p7LvIqLcULBEgrLiyxbGM9geGk0Q/Uv9K6UcVk1NOIeIxzdx
	 Zaqs9HRFHxbTjeUB9fbS3lSx3Xx8Qi9k2/bXpBJeS7vDtADs8TJg7lOmZvpzipiBGU1rf
	 +Dzc7YcDAB0PQ+MzmwC3ktOl4YZJ0lv43L8lTXdlNz8+L3NhuMPEwUdDZe0XkdiQBkFpP
	 DeQnOm4Fl0bFwu8FbbNMsFZAfmm0v4wOyf27FKm3oW5RAzyxGyPSnHbSSeBb07Y204g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614884;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tRMOVhjO91YgFyCjVHMcEDWOP+GyvWo/nClKImfdGdg=;
	b=R8/SUZ88ssIXAyQQSWkVt+H4lRfefnBt+207MwG9BLBI++5Cnp4KCLtaNIQSWsnRnU9n
	 rceUN+g7UeiNXH1hE8+ozcp7ouvrNurRKCDa/OQZx/NgtcxbDIMsTTqiFELQNxItpxeaH
	 nHpWbuPwYUXnpfXofiY5rTP72nhKUhG0tTSm9UjsymxKrN+G13JpHzqg2WSWQ4WKR3eAo
	 5f39y5Qwpg74z0b2n5ypSO6TN2w7rgwlNVvdH96E7uH3AhdBCtNdJsFIvmfxE5qAQu3Fl
	 sthWSX6JYPRODPw5q/TTvYU/n2sS69ToV8/fIluBJv5hRzMcpArRgltalD+HdcC/8tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=i1favunH;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519C606A31E;
	Wed, 25 Nov 2026 13:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0519C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=i1favunH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tRMOVhjO91YgFyCjVHMcEDWOP+GyvWo/nClKImfdGdg=; b=i1favunHeeOjlEMSLGfU/YnsJ9
	px8jbVsRxoTzvw/THacpoPIm6ZOBTxMRy0zNuJyVenny5Ca40XuomlQ1Hwn4ELxr3zILng8GXHxSG
	XR27I453nvQL/DWPkmg14f2+NoThyNc2ZEv02vQ3lKmXCZiukAfn1aR2VzMLf6rGdw1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xWDS9-001KOd-PG; Wed, 25 Nov 2026 14:54:29 +0100
Date: Wed, 25 Nov 2026 14:54:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] net: usb: mcs7830: skip zero-length register dump reads
Message-ID: <7b103b24-51f6-4724-96ad-fe9b3d54831d@lunn.ch>
References: <20261125071649.7052-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261125071649.7052-1-25031212351@stu.xidian.edu.cn>

On Wed, Nov 25, 2026 at 03:16:49PM +0800, YuanZhe Liu wrote:
> mcs7830_get_regs() passes the user-supplied regs->len straight to
> mcs7830_get_reg(), which submits a vendor control-IN request for that
> many bytes.  ETHTOOL_GREGS accepts a zero length, and ethtool_get_regs()
> still invokes the driver's get_regs() callback in that case, so a
> zero-byte dump request reaches the driver.

Take a step back. Think about the kAPI. Why pass 0?

I think you are solving the problem in the wrong place. And you are
playing whack-a-mole when there is no need.

    Andrew

---
pw-bot: cr
