Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790399;
	b=1TNlfG0o4uI3tTWzYCUlsYIlNphTbz2gJ5MDD/Wb/UKl1D80GBV85A0j86U9+BmpOXxT
	 MPtsHIps7oxPfryArDWiiUkow7bbS+X4RmmoQIb7q+RlrHhbiHnrAp0I2aZ8+bGmr5B2S
	 AEr41DnGIG9V5qNqvV5Kcv84xH+AUs7gsX/DRH1hVXtQRTtsyCpmkGDGpekqttixgXToe
	 /xbxbSGb+ni2EvNj6RIdPBrlX+KgXqMmvOixErmGyOfpRgIZmQG07wKgFnurGHSnuaCYd
	 CIXDlaDMB5UBOVA0OAtImd3kWz38wMUVuh4ewdkcH3x0JJNwNbPouHqh/hiXWaYP2Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790399;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e2gK7sqsQgj8MPJG5+S5M4IyC4uYfRdDO617lAQ3q2U=;
	b=ntHk+JkV7V4fvGyinChJCMR4Sku0QVEV1Ft7qwoWFabO/sEWBuPY5m682u/hx1GCU5TH
	 vOoymrSt6sT8fufRKUwblQ+oKzWZyv3qt9caSn/My9PVF4eJwRpISUwHft133Q7n0z0LU
	 B6yu/G9yjRJXKI55aXJhQx01bOgDAIdC+L7/0CeLawpCSJgHyTWuEFdkHMImoz2pKJA2S
	 Kuy/PsgmpVLYG/N6OamMrAnyRCOZqxidVccoCRbOxcAOE5A6jaFURz2glkHAuJGZSE3CD
	 CAjLNLiGngECreOxCCHfBX3G2kAHgD0XaNtooG758pFUnWKHk5wnNgiFkQIf681BBdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma+L9zsk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51A606A31B;
	Wed,  4 Nov 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma+L9zsk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B575C1F000C1;
	Wed,  4 Nov 2026 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793790398;
	bh=e2gK7sqsQgj8MPJG5+S5M4IyC4uYfRdDO617lAQ3q2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ma+L9zsk1Vg2nHJ63Wnt3wSneWvwj64nhRarWqsidaX+Hdu+J9FAbpgNf9bQykHtG
	 EZJzWj95OOOtv9aTR16dWz9TUOkL/XK4HCyeHSQPrmRy38+id06ilgqevfnt8zwqeJ
	 +7OIZgHHfmaYOfyHYtGpkXqy1NH8erfT4YOZoaSfq/lSKG1DAiwjFMHPeeMN5y7/zM
	 lwYVigyo/Ki7ymwIIpkNwmJ1XaDhObez3XobqxfZe5UqEwkMQtmHifd2/leJFu82oM
	 uyPcUPQYUJtEKHP9oNYpK2c7TrK7Trv9uZpb7b8BZLf0ox+gtlnAIKhH8KF16jgF/3
	 Hf9OjMSZtO5hA==
Date: Wed, 4 Nov 2026 11:06:34 +0000
From: Lee Jones <lee@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jouni Malinen <j@w1.fi>, Jiri Benc <jbenc@suse.cz>,
	Michael Wu <flamingice@sourmilk.net>,
	Rajkumar Manoharan <rmanohar@qca.qualcomm.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: mac80211: send wake nullfunc when TIM bit
 is set while awake
Message-ID: <20261104110634.GL792264@google.com>
References: <20261103110642.260244-1-lee@kernel.org>
 <20261103110642.260244-3-lee@kernel.org>
 <b9e1a5436b01804946cf76f590743fc558971537.camel@sipsolutions.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e1a5436b01804946cf76f590743fc558971537.camel@sipsolutions.net>

On Tue, 03 Nov 2026, Johannes Berg wrote:

> On Tue, 2026-11-03 at 11:06 +0000, Lee Jones wrote:
> > When an AP's Beacon TIM element indicates buffered unicast traffic for a
> > station's AID, the AP believes the station is in power-save mode.  If
> > the station is actually awake (IEEE80211_CONF_PS is not set) and
> > dynamic power-save is disabled (dynamic_ps_timeout == 0, for instance
> > when power-save is disabled on the interface), ieee80211_rx_mgmt_beacon()
> > currently takes neither the dynamic-PS wakeup branch nor the PS-Poll
> > branch.
> > 
> > As a result, if the AP's power-save state for the station becomes
> > desynchronised (for example, due to an unauthenticated frame with the PM
> > bit set), an awake client with power-save disabled ignores its AID bit
> > in the TIM and never transmits a nullfunc frame with PM=0 to flush the
> > AP's buffered frames.
> > 
> > Send a wake nullfunc frame in ieee80211_rx_mgmt_beacon() whenever the
> > TIM indicates buffered traffic for the station while IEEE80211_CONF_PS
> > is not set.
> > 
> > Fixes: 6f0756a38fc4 ("mac80211: do not send pspoll when powersave is disabled")
> > Cc: stable@vger.kernel.org
> 
> I'm somewhat worried that this is going to cause another issue on broken
> APs that just never clear the TIM and we'd send NDPs all the time, but I
> guess if that were the case then we'd have figured it out in iwlwifi
> maybe.
> 
> I might still not want to put it in wireless/stable until we have more
> experience with it though.
> 
> (Also not sure about the other patch for stable, it's a bit more of a
> cleanup really?)

Your call bud.

If you want to strip the Cc: and Fixes: tags, I have no issue with it.

-- 
Lee Jones
