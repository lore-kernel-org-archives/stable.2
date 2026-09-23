Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52840F758;
	Wed, 23 Sep 2026 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190218; cv=none; b=GB0/RJITQoYAzXBDHssclXGz6hhCAD9WLm+OcFAkh8n2crBP8ajfvyJsCZDrpWyP/5wDeiUjxtDiz9CLVQ5962i8sR4xQ67fuwsJkjsohebEzTE4zGqRQ8FPYjD25Vw6/1gd+5xXKjcjaxIiDaXp4RTUmcNSS9J/SoPFj0zqCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190218; c=relaxed/simple;
	bh=phz2r2oh1piWVyznzyMjW0hNmh7fQ7fQSNRSSPf+d+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfQB1dJWxiHThcFJRjaNqTM23Iwzq7Y87joi3RCw59F3BLbzQzT34jxoCxrEmeB0Jg2pkOah9HJKbR8Uh8rs4JYDsZD6AKIjZiXGvq8uEA4WYx8Pv8NIpN+EmGV4Z+1QHfUV+TkK06XPYM3T97HCdNptzC9Qk2dmM6dNy9zXqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MM+PRk6N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MM+PRk6N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yjBNPZD8sb6ZwcrF2mIEaZbulZ+dibSRNcNsLQ+pVH4=; b=MM+PRk6NtNsRAXHgSYpUXoeU1m
	SznkdEco5irabuPxhBBy/gylVgtBnU2ANZauRCJkSqP7S1jtbzCSlFoHaAG35QDlMnDVGvcBrRtuE
	Mz7nDAjYhYU1Khwkqxo/ZROWy72wqM4QRgkdyEHEIpESRM4jnz8wxFnZncA6gKw7s68c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9SFg-006rZo-Ux; Wed, 23 Sep 2026 21:03:32 +0200
Date: Wed, 23 Sep 2026 21:03:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <e0515b50-8a7a-4c4d-91da-9b62c2f663bc@lunn.ch>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923162339.1375698-1-qwe.aldo@gmail.com>

> Neither path checks that the buffer actually contains at least
> ETH_FCS_LEN bytes.

Please could you include a link to the freescale documentation that
says such runt frames are actually delivered.

Or maybe turn this around, add a comment that the freescale
documentation says packets less than 64 bytes are dropped by the
hardware, and remove all these unneeded length checks.

    Andrew

---
pw-bot: cr
