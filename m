Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AE33E360;
	Thu, 24 Sep 2026 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214481; cv=none; b=EgswvXGgWxUy8owMYNLwIq5SEbepkflhP5dfWgxduT0u4IQcBRp/XvqA5HMjSNNAhGIR00rph3h9uIWZBIcb0aEe8VpPeJ9S4cu2TNTgKmuCaob7GE3sj8oon9Yj8kKKNB+Zv/V55+bIH7X8Bwz8awsHjYQRZSTqoF0NwsYYY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214481; c=relaxed/simple;
	bh=lmGPQpXumXfFpur1hcy96EP78y/ebnbdoPlZ/fYwlDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8cIcw/jNWZ0FBQrJ6NLU7LvmBigrLXSVtXVlitGQOBwwYXrVL3iS7mD7h5btNPo028KY+24+lEiXEdO+vkYHl9MWHyh1nrxPMCRKOoiY73PJgMKlZ+UEE/BdCQgBT5yV5cBXpDNKBn5/mL4mErW6BdGjEFWEo0hgYsiwil1cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXHMuT/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXHMuT/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0A1F000FF;
	Thu, 24 Sep 2026 01:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214477;
	bh=eLSt6Vwxmk27shOkhfLQbZMgEBxEuzV748Hq2D+QI/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UXHMuT/Ji6A0NeeG9D+vyST0oi8QaKq6Zbde3DopbX6ROpBiuXIm4ViGaj6mlunTx
	 sFsueO6i/W/ERX2bY/qwxqYlAFUNdZ+WnOAVFbLAw0/5XKB0XlXK7vRMFxUTIKiolA
	 f62VWH3o88SYT4M6vUf0ox8dNuDcOUhEpTq/IBhhecGh8Bn6IEwOGeIqNFHxUxfGmN
	 esk0YykLvBLGCdXYtD/DDnhsxtDu1KaMh/6haC8RQCtNYCGlvxzFXfCtRTmnDn4mMR
	 kBIGqdOR9o8mHq8Uc7oOkWM9jZU8y+GorDBLM3sOtuRR8ggEdM49XYqkhc3VJgkyhp
	 NmD9JlCfPBeag==
Date: Wed, 23 Sep 2026 18:47:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, nicolas.ferre@microchip.com,
 sean.anderson@linux.dev, atenart@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: macb: never give hardware a NULL RX buffer
Message-ID: <20260923184756.16ce33a7@kernel.org>
In-Reply-To: <179010942002.2160803.8691011751847108495@kernel.org>
References: <20260918-macb-close-v1-1-05e32ce98813@bootlin.com>
	<179010942002.2160803.8691011751847108495@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2026 20:37:00 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [High] gem_init_rx_ring()
>   (drivers/net/ethernet/cadence/macb_main.c:2793) now sets=E2=80=A6
> - [High] gem_init_rx_ring() now publishes MACB_BIT(RX_USED) on every RX
>   descriptor of a queue, resets queue->rx_tail/rx_prepared_head and then=
=E2=80=A6

If the AI interprets the rx poll side correctly these seem like a major
flaw in setting the USED bit :(
