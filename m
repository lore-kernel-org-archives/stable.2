Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794761001;
	b=Ypts+8kzsPzZv9MaxOmeouG7zSzdC7ow455eEFjbrQmEFbZ/4zjpVoWlGqzgBHVaW8Qz
	 RfQqRsqq233kHNls0mrSQvxEKdmoL3xxGC009yBkPWVd0XWKKIDNusU+DGMncb/KUq5kH
	 WyBMlD3L5ANNTUyr6uzudRD0Sd97olZ9myWyAiQQLi5Q8ykaY6ABxhL8OccKptTT+TYg7
	 MVk/fk1csJO18TASoILzKkZBiIXLlIxIx6OSkfQH3lD5xa97KgdBXCtvxCY79pwIVxTdv
	 UsxXJfEYke5nyBJROH26KyEktU9tIigoRnJRtddGbkLhnBMFoCFpYZu4byz4HrUf8Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761001;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=DjHGHXieYvdd2u523EyOqFE0gcVivPDtvXqQM7OgO+s=;
	b=OcXLt1Qj4LsShixOtaB61REZS2nrVAppoQtwriqI1Ue/n6iSLiSFDWTGVPGXqYqUBQDN
	 CjA58nlDg+pvb69yZ1zTCPi8W9oun7M/Fcg/RAn/GWtJy08xwPmfLH7flyTPmSxNRES26
	 6vPoXnVZO/Rw+21nqDOztVo7dudf7MAS/j377djaQvWWhnTe//eHQQSSIwc/GjlwPDPAA
	 2+cder5LS4M3Us9XeQwsc3/cxqKpsu+axWpFH3kp+aY0wKH+LLjOP/FzA2EM2gGcgDEVn
	 qy9dPEMMAX+GuurWaWqWDZISh3I5Fvv+f9BFUGQNgiOZYnI5l50ytwShJ1Pn8UczG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=R47HjwT6;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF4606A32C;
	Sun, 15 Nov 2026 16:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAEF4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=R47HjwT6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Dj
	HGHXieYvdd2u523EyOqFE0gcVivPDtvXqQM7OgO+s=; b=R47HjwT6FUNxouuqx2
	wQU/Rf8vaS/VcbDvtYSz6c3nUYfOO7l+Dg9eDOmH98KXCXFs4V+G4/3TME7GBpeZ
	ZnC/uwNbfrTWdRizuxS9z5DopBz73WJMt2QzrJiPataxjw1ii1FiU6EFLLc7Rn/R
	BTPfIJBGWa5YLATjdavYoPVkc=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3MRj64Plqb+v_Fg--.1684S2;
	Mon, 16 Nov 2026 00:42:34 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: reject non-PHY mdio devices in phy_connect()
Date: Mon, 16 Nov 2026 00:42:33 +0800
Message-ID: <20261115164233.942709-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <06c3990a-8f2d-4e8c-931f-6ad77a79a84b@lunn.ch>
References: <20261115161811.941022-1-zihengw03@163.com> <06c3990a-8f2d-4e8c-931f-6ad77a79a84b@lunn.ch>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3MRj64Plqb+v_Fg--.1684S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTYhFUUUUU
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7RqP32r54Pq2KAAA3w

On Sun, Nov 15, 2026 at 05:30:15PM +0100, Andrew Lunn wrote:
> > Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
> > Cc: stable@vger.kernel.org
>
> Who does this bother?

Nobody that I know of. I found it by reading the code and could only
trigger it with a test module that registers a bare mdio_device at the
address passed to phy_connect(). I am not aware of a board or driver
that does this, so it does not belong in net or stable.

If you think the check is still worth having as hardening, I can send
it to net-next without the Fixes and stable tags. Otherwise please
drop it.

Thanks,
Ziheng

