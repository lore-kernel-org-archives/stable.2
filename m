Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819258;
	b=0wYwHknoPACnHVE03gwMlqR6KSoAfDZoJzQCEoUBN54hihe/aj4LkxAFUAu4qZC/6C8m
	 hlyCsoGqjgJF2IzinZ/OZwdY2UkcC2mbTxrW61fOJ2ZsHBiAcj1k195ZNNAHi5klRfIll
	 oETm9HNc++XrFjFuTh2mJLvl5O4C9QnkQqPWRywndLeA7Ic/M0MEOqjFFBDhIttugmBQ+
	 XZU59EUV9Uv4zeA5SH56jjQAH56d8aKQo5L1CvUZVA3Ca5MAM12DDww5LUiLuwndRhRsE
	 fL2KXz7iv5/kobtD06C64qBsPogGhkgNyCjMT2JKSBVPv/T7AOcR+NaI4g+caV7nbQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819258;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wZJu/F9JcabB87hqeAwvNRzYDaRsgQTCgDWDmmm8eww=;
	b=LB+s6A/27kjYCbEGcWnHmQ38jaIpisERCS5BfHQGUH2RHNG+IodlUZzPyPz4//sXBhD+
	 i2Ukau2vXTmjL6c+qPDxZwgEKp9D+3KhkQW4h1TQFRCSII5zmE/Zzsi/raS3aZOs0lAKO
	 AJpk7Uhe/8QbXdFtoiU7BSC12wIqUQD4opZo9JHRwI0TdVI/NEE0RqZl4XZz8DIwSeB44
	 C4ctC2vSIgkKRN4KXF3PAnYBhDTVH5G/Mz0qmUtUgN7sTtB20Gh88MuF4jhBN03ALTk3X
	 E4vXYOwyy5uJHxWCZ9d/a4K54voNHYb1TIoJEMsC6pOXmbJoHICFgQLYiqo4+9xcz8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeAqpjLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C8606A31C;
	Mon, 16 Nov 2026 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeAqpjLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95AE1F000C4;
	Mon, 16 Nov 2026 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794819257;
	bh=wZJu/F9JcabB87hqeAwvNRzYDaRsgQTCgDWDmmm8eww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZeAqpjLWTiHXTS4aceJvRXEjCfcTIhLjjjy6BcPvQdiz1WSK7S+fg8seZpXzj7RkL
	 8kvb/ATz0COkPyqYl0GJMgOAmblG4zANfigzgvv1SsXIu/iLwY0XMcFLHg15Ulxpj+
	 SvgB2ABW+aUMivq6pTUKwmODz4goks5i1+n+rvrFsxv6R1PXG7nbjzRiVwsNfA3Af3
	 1oSzZkb89NRLuoy1qqwxPAudNKbQCQH1Iwxk64p10HxiM5nf8rR0od7ckeerrmZiGA
	 R3G2PgWTURY/Vw6OX/SVaz1PvrO5i0wPEhKuUhYL5zEVFe5Sez3rquA/TsXi51Hbkz
	 aDXyOjWOFVFEA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xSsTf-000000033jK-0r2E;
	Mon, 16 Nov 2026 09:54:15 +0100
Date: Mon, 16 Nov 2026 09:54:15 +0100
From: Johan Hovold <johan@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: fujita.tomonori@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, stable@vger.kernel.org, hfdevel@gmx.net
Subject: Re: [PATCH net] net: tn40xx: fix swnode use-after-free on probe
 failure
Message-ID: <avrEt3hhG9i5hrd2@hovoldconsulting.com>
References: <20261110100051.2567443-1-johan@kernel.org>
 <179452098811.2199510.15081106290449010908@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179452098811.2199510.15081106290449010908@kernel.org>

On Thu, Nov 12, 2026 at 10:03:08PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch rests on a wrong premise and adds a refcount leak of
>   the MDIO software node, along with a dangling pointer into freed…

The bot is indeed right. The driver is dropping a reference taken by
another layer and works around a swnode implementation detail.

There would still be a reference imbalance, leading to an early release
of the parent mdio swnode, if mdio bus registration bails out before
taking the reference, but AFAICT that would currently not lead to a UAF
either despite what the comment above
software_node_unregister_node_group() suggests (I'll fix that up
separately).

I'll send a follow up to try to make this less subtle and fragile.

Johan

pw-bot: cr
