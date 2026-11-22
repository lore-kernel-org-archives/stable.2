Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795365192;
	b=l3I0XuQjMWmdrE2l4L92m4hlGFEmE5c+sYgOfY2gLbZGdesuni46hSg/kyeSGgWhvLgL
	 51CFS6HgsfAgAgCQM68e6Grxm5Qby70jCsPNwt4P9SOTn2o3YPZ+Qmx8SkSAUkUHA0Iho
	 lbNHnickVbAEjJY2pq8p24cceR4DIa5wOYIgUZWI8gA2YBW3qsr1AAnxzpy2YjZRZNzP+
	 XYHlJbLS5tLSsV/9WrDu4FGDIoLAa53PCxjIbLR5BCOUmIRCh5oiZaHhBDHRFMf/c3c7F
	 WqxxTUq/0ScZ+CMIEvbwdSezWJRXP99w7fAujlrDrDYdT7iPmssf+6M5UAkFphGeYAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795365192;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=oxiR/oDYkJlm/vmgSNXn/0eNQdL2U0MFqxfA2Te5+Uk=;
	b=z1QD6l9gl7/e98rvyJQ02x4FOjn+ucW3O3HZ8He5tWf0S6lkfB9Fi4kYWEegiHGXoDKC
	 G9oUhBlAoxvGjv8zzU35yRHqC/dbd1Uk7Jvpgsxx5DIRkXVbmZbtXCgI/6uEDStBzBmTr
	 DLNfB7O0UGk0HE0Gst2i2c4Vst1FldZibLO2cg26JX8Amg6ZxsrcxmNazc4H56Z7pCrZI
	 G15igtBbkWNP/wa3t4WOvY03qrOIhFo+PaGaMG/teDxlNMDKucPXGMXDh88NEplv/R606
	 d2E1I9hfvLCIrgdtu3vJUbd/bkv2FNpFb55va5daHwSOc/0Kjz5I6qs+oZA/ecgCCWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=PBDjuNP1;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A426606A320;
	Sun, 22 Nov 2026 16:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A426606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=PBDjuNP1
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 055F4A157F;
	Sun, 22 Nov 2026 17:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795365189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oxiR/oDYkJlm/vmgSNXn/0eNQdL2U0MFqxfA2Te5+Uk=;
	b=PBDjuNP1jLkd2CMknU31M13Jiu2TwgpX8U+M1mm8vjZWz+pKAMxVeGIkwnktuOyABYzsCk
	WbCrPvICu6bMf4yP2RDup3IHwovqqh0ocCc68eStaUQtRpKqrLdjyKlAnVwu79O1BPtzNg
	2NcZoK3sgqTi6Q73QIsM+rP8fGJhW3kfT+utpLGHcnoIzUyz3T2AIbPfwN0932aUGqf+1U
	mcdYMCKaygzmPVA++2UrphRRtfCU9IUquMeC+5dve4oj1NbmQTPWeaIDejcHJfqjbhfgBF
	vZEtDU5Bmvp5J+0hWy88ScAnWB0M7ft6d2qGmEn3GyZ3YLdL7LcSFZNMbO49yw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 17:33:07 +0100
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
Subject: Re: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to
 2018
In-Reply-To: <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
 <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
Message-ID: <fd55b3381a6ea99be2befc9bc3e6f34f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.11.2026 10:13, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> The H616 RX DMA fills only 2044 bytes of a buffer, so frames of 2045 to
> 2047 bytes, allowed by the previous patch, are dropped. Limit the MTU
> so that a frame with two VLAN tags and the FCS fits 2044 bytes.
> 
> Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
