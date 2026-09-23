Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837523EAB4;
	Wed, 23 Sep 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189946; cv=none; b=F64NDk34V6CvR3fxti7sQAboWWyDGvb16zH+9v0u7FvnJ/Cfke6gLel11bg5KdOldgBYghLPcbwG6tN5/8nY+awsFSXxAy3GaD2GOjRzAjcRPnecXpO/kF79mJl7+eF0PRggDZ20QzKDd+ULHSsk8U5mCMSmS6JcalxwdOvSUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189946; c=relaxed/simple;
	bh=+eRroRBUu0Ticgi50hMmFGo0lqD4k6fU3P9bG1LD7h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn5QIHyR7Iu9EJj2z4QUwwBoS5q74KZIyjmrlEXnHo9Q3UnTLKs36/ldUuaaZoys1PLzTzt4FrOSmqrhX9+49Zo2Xq+VTvbJ2XfDveWFACkwpYxRkMhEU6RHuN6ggN1nuI7UOEB9OyyYeXKcMSjWMkhDrS+K2a9al3cAsoBKnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iby9M76E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iby9M76E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A3JBkXtCW1FVJdbuHt6ARwllcCUeB+jrfclewLqz8wc=; b=iby9M76E8ioxvXhdHEA6pxssM7
	eABklK4sehH0Awp7ONaQ2oZ9XKHGrM6452KASqPQ0oAvfsf1wAcSEJnHYXd13K19hQ1bkePmdVCmd
	TjMaSQnzfgmrFTpIuQ8K850wZhktvXxz8/Et3Bto+Io0gmq1vYXB//jscFLSEAWddNl4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9SBK-006rWi-AG; Wed, 23 Sep 2026 20:59:02 +0200
Date: Wed, 23 Sep 2026 20:59:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Message-ID: <f5247cf6-f3c1-4fae-ac6f-c84237f848a2@lunn.ch>
References: <20260923141154.2415545-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923141154.2415545-1-qwe.aldo@gmail.com>

> Fixes: 6605b730c061 ("FEC: Add alignment handling for FEC driver")

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please set the Subject: line correctly.

    Andrew

---
pw-bot: cr
