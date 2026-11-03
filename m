Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707912;
	b=qNPqbVSdeZy4RVEYYjoX9/rdXJSGc4uJS7i2NLwNc+GOhNeeaAbm6LhvV5NtbO1MkWK7
	 KLGTSA3X9oqzscOtDfsN901RGR4Bkjvoe6GuyDWwtHqQFGgGrGYgwk2jGXZ+cVcCaHkDt
	 /ICXoD1oZzzN7GasSva8a6qdzLREr2QX7rgPWimb3RA1YpyHX8qKdWj0efM5aTEYMYfvH
	 ahQNK58jERKq3RQdP8usKCIKF5s0Lr09E4iOkc5xgRwin+h1VsDwrj74uFdUzdACmuuE/
	 fazwis9am508t0kkrBrb+r6bXS3Ba5sWKtabVr/4iE+MxEz65HQfMpuXR/trOJWIGLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707912;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=MVcnXM36LNxtn2tAVvi5I8q52WV5VnIZn3/vsAKnt4M=;
	b=wrtr63xzUrgPWYhu8dmtSEIhcKoJaVo4HSdxTH3Oa66yrDSoQ/ZiQEwEXQZP1gi35SLE
	 +0KwbmXHT2yZFdWDH5vOXmB8uE/VKz+ZcgicZMPH6/eAv85IdzKSQwLEQGotDVT7tGQ2/
	 fCiOCiGGFWKOjPhK3rS2rnCGdcTj8z7jr/Z33K081ZFqyDBOSp1PGMNBcC4lwZPQd6S2k
	 7amwVH1BFV1HS7y3dy/iUcZ0ZRssaym1JXGiNQ554+p/ThfG2H7NpI5Iy4wuSI3zG2o+q
	 MNT3Ujveye2j/9fpEuXY+TmXdOR8PdvmKuudXyG9cywKyuZu4KMZVo8aELJdD4Z0MlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=LwSTw77J;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF9606A326;
	Tue,  3 Nov 2026 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=LwSTw77J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MVcnXM36LNxtn2tAVvi5I8q52WV5VnIZn3/vsAKnt4M=;
	t=1793707912; x=1794917512; b=LwSTw77J4aFaJFwOs0nJWghjpGiEqi6XDnGV5eIU2EDgXpa
	jSw8RfEDle4Rrrgn6Jv+z+kGombk/EKtRSEadpZFw1rZBQfxpA5HcvkD8ZkOJDAzCWIJg98mNX5kz
	FlgzFrxX2XV4z/KPt+E38LgFDDDUv/wMDn2+XBDYjB0s7OR/Z+WtcXxmpAYew5BHbgG8u1J3KcLq8
	ddsxW7Z+EW3gCo+OjTYaeBD4YLzW7yRW02ywjiTUSi8FcUbY3cDj9Sszeasg9SFKnZYpcgTFMICH9
	BAxKQJ3KnZsH3UzzbQgP2bhGl1XRVADJ1glI4zUX9DNKsVfLN9hNz3NzoGeMJiAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xODMf-00000003PjZ-3y1L;
	Tue, 03 Nov 2026 13:11:46 +0100
Message-ID: <b9e1a5436b01804946cf76f590743fc558971537.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] wifi: mac80211: send wake nullfunc when TIM bit
 is set while awake
From: Johannes Berg <johannes@sipsolutions.net>
To: Lee Jones <lee@kernel.org>, Jouni Malinen <j@w1.fi>, Jiri Benc
 <jbenc@suse.cz>,  Michael Wu <flamingice@sourmilk.net>, Rajkumar Manoharan
 <rmanohar@qca.qualcomm.com>, "John W. Linville" <linville@tuxdriver.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Tue, 03 Nov 2026 13:11:45 +0100
In-Reply-To: <20261103110642.260244-3-lee@kernel.org>
References: <20261103110642.260244-1-lee@kernel.org>
	 <20261103110642.260244-3-lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-11-03 at 11:06 +0000, Lee Jones wrote:
> When an AP's Beacon TIM element indicates buffered unicast traffic for a
> station's AID, the AP believes the station is in power-save mode.  If
> the station is actually awake (IEEE80211_CONF_PS is not set) and
> dynamic power-save is disabled (dynamic_ps_timeout =3D=3D 0, for instance
> when power-save is disabled on the interface), ieee80211_rx_mgmt_beacon()
> currently takes neither the dynamic-PS wakeup branch nor the PS-Poll
> branch.
>=20
> As a result, if the AP's power-save state for the station becomes
> desynchronised (for example, due to an unauthenticated frame with the PM
> bit set), an awake client with power-save disabled ignores its AID bit
> in the TIM and never transmits a nullfunc frame with PM=3D0 to flush the
> AP's buffered frames.
>=20
> Send a wake nullfunc frame in ieee80211_rx_mgmt_beacon() whenever the
> TIM indicates buffered traffic for the station while IEEE80211_CONF_PS
> is not set.
>=20
> Fixes: 6f0756a38fc4 ("mac80211: do not send pspoll when powersave is disa=
bled")
> Cc: stable@vger.kernel.org

I'm somewhat worried that this is going to cause another issue on broken
APs that just never clear the TIM and we'd send NDPs all the time, but I
guess if that were the case then we'd have figured it out in iwlwifi
maybe.

I might still not want to put it in wireless/stable until we have more
experience with it though.

(Also not sure about the other patch for stable, it's a bit more of a
cleanup really?)

johannes
