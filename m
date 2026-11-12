Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490420;
	b=YrkN/ahGZdg6udMS9AEOQZNquyPVX1RyNNr53EzWPb8/PQnc9wMiS6nuFOjaEc9CB8rK
	 9n3cRRPUCwJNsQ6W2Dpr/ViYRQxvanm0YZSkJ5rhcGvgJ+AL+FUkasGMrLu7PNvmT2Aa0
	 gZ6bOmn0/FHma/BmsrnKdEPpf7pGP567rW0H2VI4VcxICX+yIMPYfOERCLuRGdQ89hHSG
	 oNx5oqTcKPF4lV1eva9ZZBUJAhvFtLmauD/o9vMjJROSu7oIGHEucuQsqZAACcKM1Hh87
	 b+SpfXwx3/sdJfJIWnhwmWJz7wwXGzwaXJXNKaC7RaXj8bszMXxnOvzYGbdDmheOFPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490420;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=4yQyCnFXam7a/xJGAAQUTq1NHeylziRFsi/y0Ps4bZo=;
	b=bJ7AmI7UafzrXyiFDGbHwjuf7TIXp4FWNDkmGELXcIKftWiDZUpsz2loqllFsOE0HOX2
	 SZ6OxmA9hxKX6ONOMyk6WxZz3bpjNjwSnDZ1TW63pwzdeIxt++llRYTZ3WqUyw3VFmEe0
	 Hs7EcBbQAubt0uNGaFASwAr0IiyWfynD0chi0AsVCfgfuILOvF8MfPD2Bv4VoihtDmAoh
	 ydFeK77v9ykVqZG68F2gac0LTQZ5+N5+KAUW02X9VGNdF6I7pYtNJg1Q6bxIsyTNmIdW/
	 OAB0V5rv9M1NzHUQnYYne4vhJNbvWC5XzeWh1YkCYYOuef9Z03QQLcmRdXTHujcB9Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=TocpljBP;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FF606A327;
	Thu, 12 Nov 2026 13:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A1FF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=TocpljBP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4yQyCnFXam7a/xJGAAQUTq1NHeylziRFsi/y0Ps4bZo=; b=TocpljBP7BQ1Yxg0ErFZmjLIDu
	cCdNsaJFzUi4vNuQO9y7/lZIwNAkJ4U1RJKpTeiUxsXAe0ZDNqUH7HxI5rkUm4FpNKyQwuJDri7cc
	KZEH+0m/XZUIWzV3vrDrQ0pPxFMdsceY4ocV4AufTJZm1LSdFlJ+toQ1MEh0nLuABKPOW6+tV+4dL
	yL9ewflO2f2LNmsXR2gsnJWKO+fwYgbYE/swF9ZIaTs4JLCoIrmTbERaLmNFl/RpKRhu9owNiC3CP
	pe8h69ODqbmh22LC2m936jQYuB0x/6td0DJf0+nhLtyLBTvJze0T88FHYJaWjFa6ZfTQSaXGda2pJ
	CBSIYLZg==;
Received: from [::1] (port=55812 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xRUvr-00000004875-33dk;
	Thu, 12 Nov 2026 14:33:37 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 14:33:35 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Florian Westphal <fw@strlen.de>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] xfrm: fix selector matching for IPv6 atomic
 fragments
In-Reply-To: <avW9OrfvkAF99uP_@strlen.de>
References: <20261109213803.1785516-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261109213803.1785516-6-Jeremy.Jean@oss.cyber.gouv.fr>
 <avW9OrfvkAF99uP_@strlen.de>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <4231ca089dfd7e7ec42d85f9e72ac535@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-12 14:20, Florian Westphal wrote:
> Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>> +		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
>> +		    ipv6_find_hdr(skb, &offset, -1, NULL, &fh_flags) >= 0 &&
>> +		    (fh_flags & IP6_FH_F_FRAG) &&
>> +		    !(fh_flags & IP6_FH_F_NON_ATOMIC)) {
> 
> Since you need to send a new version anyway, maybe avoid
> double-neg, i.e.: (fh_flags & IP6_FH_F_ATOMIC) ?

Thanks for the advice, I will consider this for the next iteration.

Jérémy
