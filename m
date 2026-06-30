Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090ED313E34
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811202; cv=none; b=RtDF2mp7Drw9WgUlp5jea9+w8DhM7ENDs6+XaaZVZqrUMp81N2cnlxWgYurit1gnyL39gUxFnaltAAM2FtKA1XyZYG4bHYCj+5NiOm7oaft1VYLEMCNloqfcOFIfFybcVAK4FucoXflef1oZkitIJK0Nc3QyO75jdvsbrcdlW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811202; c=relaxed/simple;
	bh=Rz9u1wL+cfAoqAlVFh7Bm1MXtHcdFkD5ED4Y8Ra58IU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=I+6zjnInmLseBtfgNp6YDiP3WkCamuAxy65oagXduad7vLXYEww7CdKpUiK1roECFMmZnxNp3AGpqoa0dmlC94DlSzMDXJhAcOR7674TabzKsqyTlETtpdaL3c9kFb9iJpgc0UBLfLBqDda+JiaLB6GguLyqu7zH/gXHOn35mks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MQOn4K22; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MQOn4K22"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C4B6FC51474;
	Tue, 30 Jun 2026 09:20:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CB6060233;
	Tue, 30 Jun 2026 09:19:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F5EC106F1D29;
	Tue, 30 Jun 2026 11:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782811197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Rz9u1wL+cfAoqAlVFh7Bm1MXtHcdFkD5ED4Y8Ra58IU=;
	b=MQOn4K22FB+ZSukXRORS4ivpsz2hVhO0/wA9SMAODocZazKzX/q4DeWw232cyAXUltY7Ka
	QowY2GcacH16AvrJyWJaYU/PHqgxHAblRdIaHy6J9GKzYQROGQDvvZYmuHPX5DL2Jogg39
	Z+9NjcB8llBOzvodZpJfYNxnvIUwFnssGgn2MAw5JQrcJDK1PA8IZxlqTrv17xilh7FthK
	GdW9ntLZtVateNC8nE1AvJj6Zb/vvyqc/WEifUGkEA/cY9avP//uclSNPtpC2bxz3KaRkw
	BnhAT1vRne7EhOe7iIlKSJVk2d5UEv+I8Cto4veLhTBDIMh1JnmXvft/XM7ZEA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 11:19:43 +0200
Message-Id: <DJM9TJAOURO5.1QAA84FHLOMEF@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v3 1/2] net: macb: give reasons for Tx SKB kfree
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Haavard Skinnemoen"
 <hskinnemoen@atmel.com>, "Jeff Garzik" <jeff@garzik.org>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
 <20260617-macb-drop-tx-v3-1-d4c7e57d890b@bootlin.com>
 <20260621144047.3db74e2b@kernel.org>
In-Reply-To: <20260621144047.3db74e2b@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jakub,

On Sun Jun 21, 2026 at 11:40 PM CEST, Jakub Kicinski wrote:
> On Wed, 17 Jun 2026 11:17:29 +0200 Th=C3=A9o Lebrun wrote:
>> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
>> Cc: stable@vger.kernel.org
>
> Interesting, did AI suggest this? It's fairly uncommon for drivers
> to care about drop reasons, packet loss on egress ports is pretty
> clearly attributed by tx_drops.
>
> I don't think this belongs in net, net-next would be fine, if you think
> it's necessary. Sashiko seems to point out a few more clear cut bugs.

I don't use AI for kernel code generation, only code exploration and
reviews.

In MACB we know our stats are pretty broken (including tx_drops) but
fixing stats is a full refactor that will come later and is too large
for this bugfix. So I used the drop reason mechanism to have a way to
notice dropped packets, otherwise we have nothing.

My commit message should have covered this in more details!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

