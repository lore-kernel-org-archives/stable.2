Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388247;
	b=HJmRmzoYTZnp9Vi0sYPiE3r2yBdmPFUKg81EnPkWyltP9nkNoBG2lhxbf2kdGD23gLbB
	 cyPTddR8SQfQ28LOtuybLRB3VFl7+qhbBwXNb7jO7ht4sc1UnsMjUw4aFDVehi7YWr2ls
	 Nbe0Lv3SJROgRlGk9tgdHHW4xS0icCfTXzqY+NEpU3p4awrHaxCz1JyXHi78gLLwQDbpm
	 13CmlL7GA5ydvkcA9ulz7kTsKXgqEagxDXl/0hRqj/kbxrYobp7a9u9M8QX/XEHzzxp7v
	 jXHBATLfv3rurLBKoBUM9cWTmzsqMEvKNaOXGs47OwMWyYF31LshybUDvx0PdTkiFjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388247;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8GCuJY73Lsa0NNOjZqzp++3lCpwlyy5DVpqOdFWNrq8=;
	b=zUeVzptqNduEZJUsSpxxZgY2bvg+A/940jylUscjZTb6/rlfYYBG1zErPD4igbyhZXah
	 eAI6ojUAvoNys3AIxADChHONqfZhc0qlvCf8ZVUDrPneIF3/eozyQi/HiS4NM7QKBpaj2
	 7MRb1gQ778ykLDsjz1auNz1CON3hukIlIXvNoOHElIO78GYrrrzOQg1Zw660ZucHzqZhH
	 oixwGVwmo/nQ5FqL3qCRvWCsFFal6m0v5Z+CVYRCn1j6kv1JHgwUShiKomwDi4e0ZDQAQ
	 CZVgmGGFIsS/ex+eLV3rGxkTrOP5Zj8RTkbK7kgW530AjcoSgtYa9U1D5Tg7p57gwqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ILTjHSgy;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BC606A31A;
	Fri, 30 Oct 2026 19:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ILTjHSgy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8GCuJY73Lsa0NNOjZqzp++3lCpwlyy5DVpqOdFWNrq8=; b=ILTjHSgySSUD1kcu7e/RjSDi70
	K0uEJ8kexI+KTOCtukJCvllnB5PVTn3EkpNXN3Qrj2WRPHHUey/4rJqXPb0x89bqupV5sz0AGniPd
	xjCuSeBThZc4OIqA+0Px/LtJaXrT2n3rD3uvnm1PVXt1dvDYXFXbcgTVJOzus6f8nPeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMsCf-00DQQq-3q; Fri, 30 Oct 2026 20:23:53 +0100
Date: Fri, 30 Oct 2026 20:23:53 +0100
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
Message-ID: <eade847e-27a6-45ed-8492-dbb52712e30d@lunn.ch>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
 <20261030.pref-13.995287b5f6e44468@stu.xidian.edu.cn>
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
In-Reply-To: <20261030.pref-13.995287b5f6e44468@stu.xidian.edu.cn>

On Sat, Oct 31, 2026 at 01:38:41AM +0800, YuanZhe Liu wrote:
> Hi Andrew,
> 
> Could you please review this patch?

You should respond to what the sashiko-bot@kernel.org has said.

    Andrew
