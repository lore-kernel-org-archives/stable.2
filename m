Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364837;
	b=4zEULFTRunGG9vMPYYhbGKsGXKYan0Ib/H1jIzWvZMdVEbgvTk8NOThr4NhZO/WjxJ7z
	 OlHa2sXRcpP+ddsyouVbmBuKRMyFxafPyVCbKmIbj1J8gwU4sGQDXhlp6rjGN6wVOyKU/
	 9tI809Z+gdWNeK0pS43F8OMgcSNZXxDO/0zIS2tuWT6ppkmOzFGmxyeXX0KNQ7xzMMZIL
	 6l274iLXF36yj9SHi1tpR70etgVgl0ir6lSuPR5QMRjjxR8NPncNOq2Xg20yAYB39wZlN
	 S3KhdvQmlKdoWLG/e2eV5DFtOccUOJi9xI+pKKuIsLpeKUCf81EMNsDtRCQp3CbURcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364837;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=UJDeRuWL3fCKkgqZZPCGE4QtQt6Hd49+PyHfiTtMYMQ=;
	b=ECMZ6zUzKrIjFazKGSqxztTIbO+XZ8yOnBd+382aow05P+SXQmYGqwt7L+PAaJqtvyRy
	 gArLE7DdfQgfaCZpqz53gHUoJaAeGMW2Q9vS4tWKm0pR4atk5q9jK81wyKGqGz2+YXz/O
	 hOf1N28i7m7kVmxusroCRPmsOwmqYsqu7uoyeGVvZmQPlj1L0kFyO9ZMrjWNxj8UgemJ7
	 ChenLMcvBOexqb4x+nyszhhVNcip2PLTfWNAJ9HD5zTirVHnlqrWMgjr9v1LCvh+/MApb
	 McIqhduMUgbF4s+mlBBfzP8l5fN1H50yB4UumQ07y/GdqHCjdZR5rEbi5I0N7IM8iiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="TN/m4y5B";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922D606A32A;
	Sun, 22 Nov 2026 16:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3922D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=TN/m4y5B
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 121B7A039E;
	Sun, 22 Nov 2026 17:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795364833; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UJDeRuWL3fCKkgqZZPCGE4QtQt6Hd49+PyHfiTtMYMQ=;
	b=TN/m4y5BqoeR5s/NmHbDkHCSCWn3y13tFdwDza3BtVVmS4GHuxXXxqOrQjJB5L9DlV+QD5
	vz4q755E61MQHh0n+IkS6E0i6hkg40B/Rb2nZPc8b+iRkt+BvKX4923SjX3TopRb2L9UYj
	Nl373XyEhLpa8fWs91cU8xlFM6cD2UD5aq6U0Qy6lc57PaUWEXA4XC7RoDO7yfdCjeL6wP
	dFzPuzhervq1cvoCy0rq4lgDrgsJ5F6+PUXHNxEoPKjhLIamzwdl0cBao9ZboCfl+KQlIc
	iByoW4HLEmJ9pKajhhv0oeYDo2eJ6FD2A4ayYh9cP5hRQx/3rlUb6VDyAzE/9w==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 17:27:10 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, LABBE Corentin <clabbe.montjoie@gmail.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Russell
 King <rmk+kernel@armlinux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: stmmac: Limit the MTU of normal
 descriptors to one buffer
In-Reply-To: <20261122-sun8i-emac-mtu-limit-v2-1-c4081e5b83cf@gmail.com>
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
 <20261122-sun8i-emac-mtu-limit-v2-1-c4081e5b83cf@gmail.com>
Message-ID: <d3af70f9334370a1d32511504aa14725@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.11.2026 10:13, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> Russell King noted in [1] that max_mtu for normal descriptors,
> SKB_MAX_HEAD() (3712 on arm64), does not match the hardware. Their
> buffer sizes are 11 bits, and stmmac neither splits TX frames nor joins
> RX descriptors for them, so a frame must fit one 2047-byte buffer.

AFAIU TX does split (jumbo_frm() in chain_mode.c).

This makes RX the real limit as ndesc_get_rx_status() drops a frame that
spans more than one descriptor. Please say that instead, it should also
answer Chen-Yu's question about hardware vs driver?

> 
> Limit max_mtu so that a frame with two VLAN tags and the FCS fits.
> 
> Link: 
> https://lore.kernel.org/r/E1vLJcL-0000000ExBL-0GFe@rmk-PC.armlinux.org.uk 
> [1]
> Fixes: 48febf7e6476 ("stmmac: allow mtu bigger than 1500 in case of 
> normal desc (V4)")
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

> [...]

Thanks,
Nicolai
