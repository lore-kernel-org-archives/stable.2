Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31F46AA96;
	Mon, 14 Sep 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388949; cv=none; b=F3IkwL73bdO2FX8cTZs7yVEPrP5DTud5aSx+XWNdeW/ZjRR2JskQnwCcge904Dv2vKeSUya5qgzOae5eCpqDrZEbiw3XIeEh5S82N3u755MJC29GylNTexCWJ0AvjtEQY78CFWp5GreRZnHhi8Zg1FatPtRZP7u4u9ztzBkMJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388949; c=relaxed/simple;
	bh=x4mgPczIT55iUhA1xnlagJmhjrrYJGyiazbuaLMwI3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxsHA6GwaRjCVzaCSDjIADHwEKmiyxzjL/v+gXHUStHkHZ5l8GPnmqGdD1Rqqtb9P2ytBswidwYIsPvx8oQrD+MSHPc0FHKQF4z7XB/KdBQN7wQ+tD42suXncAgA4T7CmlF7uoAeZpGnvAyxMDnyLDvVeSaNpQiOpaYRk9gzE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LBmuQAap; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LBmuQAap"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a63gQSvpHyirtBWkHvDv6swS+OKph9jCSC5UIOj6bno=; b=LBmuQAap7IrSNnyD9CX+/5X9Qq
	uAKdgg+Qaxs3dIVDIN9lPyLnKPQWUZVtA+Twj8e65uq0NBLYHe7C6emL0h8E8eMjWYvSVOf0br3Qs
	Svi0r5FWUlRHJnPu+thnou61y2CnzPbJee4ksO9x29+tTLJvvKL2oz0InZj1Gud6ciks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x65nv-0054u2-JK; Mon, 14 Sep 2026 14:28:59 +0200
Date: Mon, 14 Sep 2026 14:28:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: qca808x: handle the active-high LED
 polarity mode
Message-ID: <80b36921-90bf-42f3-ad39-6837154f1804@lunn.ch>
References: <20260912012819.2072067-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912012819.2072067-1-donggeunyoo.kernel@gmail.com>

> Compile-tested only (W=1, sparse). I have no QCA808x hardware

Please try Rosen Penev <rosenp@gmail.com> and Christian Marangi
<ansuelsmth@gmail.com>. They might have hardware to test on.

    Andrew

---
pw-bot: cr
