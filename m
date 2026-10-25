Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917582;
	b=Hr5qAPkYNaCnrjiPZkg+x6Cxslw7POHUFuhucPP9weqC63x/QP5e5IA0SPDzkgDsaY4x
	 WKRXOGcH76TyNPhvGDf2jakz8Rr3yiRbpCqOdJPJeIsY/Z0nJjnxWwsMKW5DqNVIUeODf
	 eJYLp6ae/ErvNfyQodb6lMcWLV5q4/Gumv0Tle1FzjIz8xiteIuOcCz+JJd8acTw9kypi
	 XbtYjetxlcJDM/zQqmrKoYHQ8+0Bum+i/ZW0f6/Cil6NsE1hTAXsHgkIqCvKgkyRUJ8f0
	 K1yM9a2pi//PKAMGAXYPoK5xKVaCqI3Hh/ZIVPp/SCXH8NwlmHY0F/iu8yj8ZaCFscA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917582;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=QIvHb/Rc67O3Ad74PTIt7MT+VyYCowCIFdRrBb6xcP8=;
	b=XNJyQNkyQB2FMvgBmYZFvh3WYl9FYZOmpf6J0IooU45gX1QAQ/+F8pDQLM2wajEpLsnh
	 j+DfyGOcghHsABkZcj19OgZcvpuOO2nlwOGqooXVaImGCiUUa8Qpaj/wNJ2bW6Hy3TC40
	 lCVG0ScMjTlRNsg6yShLrC7dZOq4opvVSaSz5s5+YcE7FWNkMN+EkmPwGqcUp3auQ1t2z
	 KtWVswuocTFfhqaXFWtT/8091jLaBfb2Wbpu38uD756+znTq4BxPhU8Yav4+9CYetkjcC
	 u6mVSpP/eHTaRvRGnwlPCkwhsNtqL195eHi/FovD3vda2ihLG4qBN9SGR93nE78xbgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelscan.io;
	spf=pass smtp.mailfrom=kernelscan.io;
	arc=none smtp.remote-ip=217.72.192.73
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B48606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 08:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B48606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelscan.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelscan.io
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MjSDU-1wsl5d2nb0-00gf7h; Sun, 25
 Oct 2026 09:39:31 +0100
From: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sun, 25 Oct 2026 09:39:28 +0100
Message-ID: <20261025083928.80554-1-steffen.pfendtner@kernelscan.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261024124932.5507-1-steffen.pfendtner@kernelscan.io>
References: <20261024124932.5507-1-steffen.pfendtner@kernelscan.io>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5u91TN0rz+Y0/5Hr9eKjB2fLv4JpA3xMkwhHgx6LF9qouBQFo9I
 cuuGNnb4Sx9jnop3evN9CXSLYok60wXG/4Kh9GXtzoqOwXY8C5k5tk94lxk3RMV2OHBIdRL
 bMM+/N7Lrx/f2yxkRTXuUCAtSSE7aQ8gHyJB9AKxASxIgV5IDaevKPxMM7hQmlbcD40E17L
 D51/+/TYYAbjtk7nA9VGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LPaDSW4i7hA=;JoM6yHqASzvztV21kWwGEIlY1Uq
 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
 /NpaZqFI/UZybC6+6AVQ==

Please drop this one. It has the same problem Sasha pointed out on the
5.15.y version: 5.10 also walks the live slave list, and bond_enslave()
links the new slave before it increments slave_cnt, so the slave_cnt
snapshot does not bound the walk and the original skb can still be
cloned after it was handed to a slave.

A v2 for both 5.10.y and 5.15.y follows.

Thanks,
Steffen
