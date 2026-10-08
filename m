Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B64A092B;
	Thu,  8 Oct 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464418; cv=none; b=aJjhsrfTDSUE9GL3CrHL0jaXzDTT5/xNmti09tW5hD0T/4QAYKZpRUYB9zUNc8Go3ppg3GmhFzhx8WvMIWiYGM4Vc7qOM7rV0RP+pd3hQYXZCTb24ktnH4aHk/x9vJ/N/avGZcZZSp3M31+g8n20JCPxb/8isE0T1o+e6iP6t7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464418; c=relaxed/simple;
	bh=7mcO4IJ0qvNbPE87EW+lwG4kqnPNldps9fmnc96NRYc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZlzMmAjcxHP4n41LSmcMLv8qbyCpyZ6R6GIQ5QsNU5YzFavNE3hWGm7FkBVtB7hlswOPRcx8hmc99+BQPrquU5kSupDZmIcn/ul5C5y3edEFQjOCw8K6IFnnok2NGdHdUqnR7r6oafWfZ2ysEeCMagnlhcRq2Q3OWs9+pWzarPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GD7jwf92; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GD7jwf92"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8D2A01A118F;
	Thu,  8 Oct 2026 13:00:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 603D460341;
	Thu,  8 Oct 2026 13:00:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0E74103302B9;
	Thu,  8 Oct 2026 14:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791464412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oSZG6dmnuIR+9apVNS7t5YXATSgltycCVix57s1onZY=;
	b=GD7jwf92tDHnef84bIJbxwWQsZ6qaiGak1sPQbw1PlsHrfs0uRaQ+38alGnxOFcY9O0im7
	9nEA0xfhezl/zMRnR/Y6jVAOL31d4S8pGG+v08eY7oTmyz9bypmP4rGQF3LnbtNUSBiwbU
	gTrxCdGMpiMkZYNGAwKPrm/ww4R1J4bGeROmVNulcMQfIm+L/URrcMdiCDULdWGM47HX9u
	FAdXSF154TOUIrZxPRpcRi1E467DOZKmem900HKi3fgk+X5hIxT+b/w+OZokDjCYNI0nIr
	gv4PODjglaROZpmgyqtWQjh+5GdjYayeiD0U+oltWv11GPYTWJR2rAJvPdlCSA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 14:59:55 +0200
Message-Id: <DLZH4LPJ36YW.1CP7RL0J77DHN@bootlin.com>
Subject: Re: [PATCH net v4] net: macb: rate limit netdev error info print in
 the data path
Cc: <stable@vger.kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jeff
 Garzik" <jeff@garzik.org>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
To: "taozj888" <taozj888@163.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261007053211.572073-1-taozj888@163.com>
 <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>
 <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>
In-Reply-To: <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Zijin,

 - I'll stop replying inline because you seem to be having issues with
   your mailer. Please fix it to ease the discussion.

   See here how your email looks:
   https://lore.kernel.org/netdev/63731290.3f0c.1a1198fe993.Coremail.taozj8=
88@163.com/

 - Your V4 commit message says "Fixes: 89e5785fc8a6" but that is wrong
   with the current patch, it shold use 4df95131ea80. I don't
   understand why you are talking about the changelog at the same time,
   this is unrelated.

 - You skipped over explaining why your dropped the start_xmit diff.

I'll have to stop reviewing if you skip over parts of the messages.
I gave you a TLDR and you skipped over the first bulletpoint.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

