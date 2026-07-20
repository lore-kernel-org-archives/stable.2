Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72963E00BA;
	Mon, 20 Jul 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545110; cv=none; b=LMwOHHXc40lvhMKOkomwY3ztuGWFed45VzkFBlejXDPPQt5PKS37wq2DFU2gyLqQiNXKt+xI+7OjyGtJ9DE41U1o1wXx0MBgkrQdoJwsNDnmBxH7Wn9i2rUoC/PoaBRHiZi3Va213BzSHEy0s1s+Ik11wazLqm4IoKrKqiIUNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545110; c=relaxed/simple;
	bh=ti/6xfUrMzehoDq07KlqKBlG3kMhUHZWVA6NoDBNaJE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dfcrWZBeB0Nclkm1Zx+LBPiIDxV0lCOGjXmV8vnmWeTuaQ1tba1xiFSK4ddRDzrILYKXIjq6p7n6FuoUVTzUkz3wTu7Kngg+40A92muM7sYMbZF1morYGYfyce9iOIuniCS3Xu5h1jvDYOF01ruWQG0vlIGMuU72Tf1AHvZ3IKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HGxpSSmv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxiKLc2p; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HGxpSSmv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxiKLc2p"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D6BBCEC00CC;
	Mon, 20 Jul 2026 06:58:27 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jul 2026 06:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784545107;
	 x=1784631507; bh=ti/6xfUrMzehoDq07KlqKBlG3kMhUHZWVA6NoDBNaJE=; b=
	HGxpSSmv4piJbyfCijSz7pUMCM3rAKaoXft1OtSxbf7ddoQ7cmeXa8iLYVVQBcgO
	HMzUCb3BH3f4iTVpSbveI9l+Ds/COLR82R3b6jc6aXnzBquJcCF8CY4qMYfO5AIl
	7fFpAhmE8gsSEdxTpoM97qcr7bBtyDRX2bhEI9nwl8gLfd8P/h5FtFBa4aaUKrSP
	821SVoxYCYMmhuHYoSQSRwJC/AHg2FAMpcLDTlyNelSr7ziR6Nk9MMyod1uEAnXY
	aXvcIkROMkaSQqdE71OOQF465V7MpNZdLkWNnROdCme+8EqeNbBFA7hbzaovglNg
	DhZWa8ylsB92BZCJL92y+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784545107; x=
	1784631507; bh=ti/6xfUrMzehoDq07KlqKBlG3kMhUHZWVA6NoDBNaJE=; b=l
	xiKLc2pY+fih2SWQQtzgQwQd4ZG9l50d5wpg6HpVZe18Rf8kSwHchbIANzBPpsdQ
	8Bbb2b0DxxFWk0jM94CgDNZAFlJRBKIArCeEcUeTuUA47eCoc2MOtlldH3Oah7Al
	/8+R5I07guWWz9/IzqJJX579i7lJD0W+gjhHjCTRdvkicASTMjyh6EP10PpvWC+r
	Cr8sU04zDsYykX0YmTjvK7qJ0p+s6GF/hgeau//vndSLiga392ttNeTlzDeQq9QX
	SY80W501ZY//+DAMG0CHaEYc5IE6Q6FuCaTtTJXZydmkkhQ5rby/mSAuzx+0eG/h
	WH6QzZ7ZJTHdt66ECsw3A==
X-ME-Sender: <xms:U_9dasP9cEJUPDssR3K4BnLbxFE4Afx4Vlxv74ZoN-t-JLAvwAhtIg>
    <xme:U_9datwRbLPnO4DuVbjYwG3lcxLnYlkdVm8lVK8z9feP5V6OkHl5iZqpcL5cvr1jB
    CW2fmQmbD_6aK3KPw8KlvuOcXFpBKr-RZGlvJYtgdO-2pAIgjstZNE>
X-ME-Proxy-Cause: dmFkZTGr9GAfQlJFWw9e5I36JsgIporeOv0YsA4s9bxUSsA1X0ozZ7vaSw863TsSZFtUel
    JkTOVtWp0xF6nxk1LAhqlYIe8jvdzAQ6yVOvBpoIL+OXvGges5sP/nj9gmHhiL7g66LOsS
    dMyM3YhRjuzy6v/ou1vx1R6EyuRvsE+C+BekqfpQP2/rsKpu3/tOx+hOG2cub0yMPYm7hn
    z5OH9EvBu/nnrPmG2GV9jpJgVRFvPfuEcjT+Nrlp5VqiT8OZvOxpT0ciZHmHAAHTHhO2vc
    QyGPAsEuLXdEC0PvSUYts0axRizXgeCUDat/99oRXneDa9+Px7lkCHpuc+DpTz150ZJ4p6
    m6zzY8bJWD3xHbwNKv0ifUOQ8k3+0SyH+PGnFKukYtDQAWdPRcN1UZoB5pnXxTnpuJWvAg
    X5mwyi0VQXRKsoTzRWKvw6506M0kltR0t3iEJS2WE9UmHORRYzwGTP7u7QM5Yfri5APhL3
    fZWzHyVkJdG3MqlMXpse0nhErYzvYAOQw/bkhWglvrzCJ3v2Qyy8+pWsuGCFzvqctjesy+
    tTuSJWS5MsIlU7ZMkyiA8R+iDHhliOA+rjWwiOet/WBmKls5/u8+1gm9KEdR3vzqRu3xlK
    VaU47JXQiHA0AvidtDhfA72lI/cGdChFygCJUoIInqBZ6OwtxwlpEQ/cbuOg
X-ME-Proxy: <xmx:U_9dalx4QGrzQiVe3XQ21PEndSo7khRkxu8xvigtzuVzekEOjmZ08A>
    <xmx:U_9danjrM-VBxOxm-36dquLbiDZU8Aw8ZgBqC-7ouzpG4YR1LzDPyg>
    <xmx:U_9dahnujErDnUuozKfYxS9knXr0HQIqyH0a_n1S2LVe5HB1aXmd5Q>
    <xmx:U_9dathEpxcwXL5Vn_YsK-wh_4T8GIARAp0XFW5io5D7dpo5iWhbfA>
    <xmx:U_9dara-KMYElNN1hi6k7yjn24MMBnudcCg0qiCLPlmRa40n3ZMC2-hh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 989DF182007E; Mon, 20 Jul 2026 06:58:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8o2RnYMbicF
Date: Mon, 20 Jul 2026 12:58:07 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Pawel Laszczak" <pawell@cadence.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Peter Chen" <peter.chen@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <38578902-b6e8-420a-b866-b613c12d9726@app.fastmail.com>
In-Reply-To: <20260720-endian-fix-v1-v1-1-b5681fa1ea9f@cadence.com>
References: <20260720-endian-fix-v1-v1-1-b5681fa1ea9f@cadence.com>
Subject: Re: [PATCH] usb: cdnsp: fix incorrect endian conversions for APB timeout
 register
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2026, at 13:11, Pawel Laszczak via B4 Relay wrote:
>
> Fixes: 241e2ce88e5a ("usb: cdnsp: Fix issue with resuming from L1")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
