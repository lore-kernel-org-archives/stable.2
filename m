Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599543;
	b=Ad0VncYTM38TWjx7MHejntYgktR8gwNnBN7dUGq6NnXOzHuKE1afkQLbFNkS4qM2Suj2
	 fhxJ7Z5hHdG3wJFdO/YMm/PI30w/SZtJcg+mOpm4ZpDHlAS+VgxLnirWgSKcLWo/6p0Jz
	 z3Hk4I82BmnRv+V/4TD6wsKS8T5Gwo2W8vTEIEM24Gkmm8jMVq+sr40q38RayHIRH0TiD
	 3jB0iJ6igLQrh4+DsHpf+cj0/4vQ1ue2POMaGJ3zYWCeSi1tqxoMAQyB4CKoDAZTSrPLA
	 XfJcVYAYboNZY5GaWuyij4RFpnteYpHBpo+O0KuDbOeWNAxqhKG6mZenGgf8qp1jmXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599543;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=gRcRRaZ0zBHR6AzzngEkus5puXdP7+q6G0foB4y3g6M=;
	b=yQG/IOvubfY9TsPpMcca1e1lJtY1jAT4JixAuRsAxZ4mPBBM5E+eBcQDLEN6NCoEcboQ
	 e5iDrlER7F97rNJUKw41A7MUp3HYzlbJV3gAqXxkS402w4Ucx0TyQwDkEhH2kepvvIoz6
	 fcG+bTqQ527iG3pLs+VsBmz+WOV6Rc3xPmWAUTuwobvXolKDHXkR48G3rzvdJrnRaLbSI
	 tMbfwYBtW4zPaoVaEusGbQfi+gCLkjpilbGlCg9EIrP+KsspL6SYuHi4KfImxyGBodaTO
	 Hpp1S6FpBHbHsTeKyGOAM0RTSTw/7Uh39ovR/NuPiCT2CdqX4YISChdfBl4kEdmiVLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=BShmhzl9;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9E606A335;
	Fri, 13 Nov 2026 19:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F9E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=BShmhzl9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=gRcRRaZ0zBHR6AzzngEkus5puXdP7+q6G0foB4y3g6M=; b=BShmhzl9dtAhEXDTPI+MxqFOmI
	ymDsimlTtgfmpYEY77qbIna11D3R9X0ady2NKvpRJHx7EqkRD1WjlbPeN56FoZB4UKqyoDdkRwyGc
	LWN/mOZpHlON6O5VlpmLsmk/sSO2grns3NwCpBoXkKhR5ztd9236ugXebx/59fDl9j9hifB2EaUE4
	aOnrlfwGmm/2YTXQV2RBpJLsHZReDd1Rp6xLNH/J/VINijLSGVLYXuVaM5v+zSqt9UsEZUEMCY8ww
	kuBD+yHdFL4b6KsbCXnA9UAl3NEmSAw8bQCOC/L3Vt2bYxjSgwHNq9g72qY7JiO0RFi3Xz11SnyP+
	ISjIkexA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH] phy: rockchip: inno-hdmi: Fix potential stale clock provider
Date: Fri, 13 Nov 2026 20:52:15 +0100
Message-ID: <lm0TpB3cRZ6mCNfPP6bL8A@sntech.de>
In-Reply-To: <20261110-9f141e6bc8-phy-rockchip@mail.sdu.edu.cn>
References: <20261110-9f141e6bc8-phy-rockchip@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 10. November 2026, 15:32:25 Mitteleurop=C3=A4ische Normalzeit =
schrieb Guangshuo Li:
> The clock provider remains registered if PHY provider registration fails.
> Device-managed cleanup then frees the clock hardware and PHY private
> data still referenced by the provider.
>=20
> Use a device-managed clock provider so both probe failure and removal
> unregister it before the clock hardware is released.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


