Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342337;
	b=TLS0RBr12p1GUFOltpahbWJL7CR++gMm59xTw4f2akKLfKSPPssZstDcasOWPHcwC6FF
	 TXuiQDCiglm7tnA6XaXpQe2qFhQVicnIXWzGRbaPjLYPtKYoMBEITtG++PnGNjyAS15hF
	 kKtHvKld8/7mKWQ1borup/uL3wE2QH5b5SM2kzxcq8Ks74Sm2JrkiLC7YGbiOgtD85hsm
	 5QcUcsO/u1VWdv4t1n8D4OgnGJfQlZCma1vuKgTDGzFj6ScpyGSVkLgtevlnLPG+xnzte
	 qmFUdj08Youf445DCox9sWwMA7dfkoD35RAMl3GWggGzvvFlFeqDE6rbDNga25nTpGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342337;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WsYeUNFxqTV/OrzlGq8nTsJX+pIO5uXJFjiMxn/sKnk=;
	b=5VNgh9jHoFDkqR3+Ip8/W89q+CaIYAlC56uMn9uioX44gbEFLbJ0FolnQ5CDq8m4hOnv
	 mNAFRhl2q8NocqGGDlH+QIIARwKU/I9XoP48tVO5iWPs3cS9LOgeAJi277XhVLIpXFch8
	 W5WHi8QVKBVhbzetwxNtKSkJDmIYMZvsWFixRw+9n0XoMzl47n89DgoM+hKM+e4tLfoic
	 haFZeK1DiKnXWQxe51GgNaSuMxpleNGDi87SIZsxc3VFVlCfLanvjYslaz/SSaa9N9ye0
	 cWu2OKjnoATKNxxKSfEDt2z+vwuz7gZ1U+P/TdjfXqgQ+IcmmxACBq3JOMNmlSPLFhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqDRPYoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE01606A883;
	Tue, 10 Nov 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqDRPYoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D6D1F0089F;
	Tue, 10 Nov 2026 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342337;
	bh=WsYeUNFxqTV/OrzlGq8nTsJX+pIO5uXJFjiMxn/sKnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nqDRPYozbIG1nBv8/k/gcOOKng47zpBZqf+DGqN8vXDDlb035WFKnFUBhO37LQoAm
	 GHhtDOwe9m1mobKNKwOTWa3Tx0JGnTKozylJev3ktIgKNdniSuawX9Vny/hp6yevXJ
	 Ry/fIP8qQeAbR3fgm7Z25ik21jwFWmixWizekQNKoaHtSA/5DDoaaRO53Y3j0U5Xtp
	 g2ih3XCQo6iamZfoVDyYa+PpGnUs1XZ3YKo+gfQBtmjSZaA0bwWIquVaZMQqmHzYWn
	 MYAzyDQ/VmuLAR2k4YEgwrvFfKG57bRvCoY9OJqhC5hVUTgmhEb7/azmvbGU5MzmZF
	 KUuLMKHmywd1w==
Date: Tue, 10 Nov 2026 12:25:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Schmidbauer <opensource@grische.xyz>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 stable@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] net: stmmac: dwmac1000: stop hardware from
 dropping checksum-error packets
Message-ID: <20261110122536.7cca85ce@kernel.org>
In-Reply-To: <20261104151914.2651241-4-opensource@grische.xyz>
References: <20261104151914.2651241-1-opensource@grische.xyz>
	<20261104151914.2651241-4-opensource@grische.xyz>
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

On Wed,  4 Nov 2026 16:19:13 +0100 Christian Schmidbauer wrote:
>  /* DMA operation mode defines (start/stop tx/rx are placed in common header)*/
>  /* Disable Drop TCP/IP csum error */
> +#define DMA_CONTROL_DT		0x04000000

Maybe just me, since I don't know the HW, but what does _DT stand for
in this context? Other bits seem to be documented with a comment,
let's document the new one as well.

Not sure what the comment above the new define is deferring to, either.
Should it be removed?

>  #define DMA_CONTROL_RSF		0x02000000	/* Receive Store and Forward */
>  #define DMA_CONTROL_DFF		0x01000000	/* Disaable flushing */
-- 
pw-bot: cr
