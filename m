Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334794;
	b=256dvlIqG2DtYWdikw380j6iP+M5dxdiW/EkgZlmYP3PiPS8dUtBI/CdeTyb6cBrEUMl
	 J+sN0Uk/rg/2VsoocgyXD8UkuwJVa08iSvwgEScvTlDKRQBaOmhoe5ScRGyMDuVnZwsr6
	 MmQ5k8Tp1HTegiwMOkdRhosj4j7NazXOAH4sM5bczrPsUZ06Q8KXlIio9l+bDeVMhNDrz
	 A5nKc0RDhWITnJo/u5X+JNhcpy6srV+bQDq6h3Qco9b7ZEpq13qbgWpB0CAJdV4OoNJDb
	 OJG5hyilQZfDGl1aaHNuvS4yMaWM8ZOiuQSxCD2OVVxR+DOBbBC8Raq0J1VOahHCHRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334794;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WTm+hFOJeybiFveuBeXB3QwAtnkwmJcq8lM+mZXSg1s=;
	b=RofszfHlZs0/CzRthpqpotkC8MLCk08Rw9gL66+GkJCcdv4PtCeQzq0pn3tPDJAm1ZEK
	 1h89ebjEEY1+JiNw0IsTEgwPcU3Q5Vhg3jaB9ItmcaOeVlSd05Dbgj2N2ts9iNbSZbVgr
	 v+mDg6QdGAR4eIYmxSpYRSU5mtU2BplhIStygwFDKZQ/borws/WZCrmcOwJcJfSNEg87i
	 0K5aBCwEg/+p8VsvxjfzOVXJS10kituQmSSiq+0y0h8cLZs4l5SwR8sOV6zIruEQ/H2vF
	 9WniA6Vy2ndFBZculo/M/50UUzBud2TExOVDYlj7nXrO4b/5d0gwP4Dbdpr7tqR9m8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq1W9XJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63895606A320;
	Tue, 10 Nov 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq1W9XJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7651F0089F;
	Tue, 10 Nov 2026 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334794;
	bh=WTm+hFOJeybiFveuBeXB3QwAtnkwmJcq8lM+mZXSg1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dq1W9XJjEqRBcfe3ffdvMkyhIfRvgm/bO6XrHLAW286y2tXZRrt06ZIWKOr0NXEfT
	 I12F0EA5QS/Vdwuysxo1dPgabDlh2RIQP2t0F+jIgtEW5MBP7k6l4BT0I7aK3K5QYh
	 mcCremilMCzlLyc9HNroCIyEp+ohyPDZu0ublxI5wgS9rtj5U+bz5qy0EJXB8PQxx8
	 L68EP9PXwXBC4OpigrKSxwRLBbyih7IBJODRc8gG/nSAf71y06IoLdXd1VjRGTZiQV
	 zXtcUMQQqz541I+vrX+SP3MOyfp8AONZr0dA35A9S/EVwhKPg481lvAQrphxmPyhl7
	 7fwo5M9SKXS8g==
Date: Tue, 10 Nov 2026 10:19:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 victor@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
Message-ID: <20261110101953.6f7b6dac@kernel.org>
In-Reply-To: <CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>
References: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
	<179406458348.994134.6942745655171316289@kernel.org>
	<CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 06:44:09 -0500 Jamal Hadi Salim wrote:
> I think i missed responding to this one. Sashiko-nipa responses are
> very erratic. For some threads (not mine) a review shows up 2-3 days
> later. For mine the average time seems to be 7 days and sometimes a vN
> review appears a few days later after a vN+1.

Response time is based on contributor score, you are pretty deep in
the red given that you basically stopped reviewing patches from other
people, and keep mis-posting stuff.
