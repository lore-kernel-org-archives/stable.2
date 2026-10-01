Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D73B27D8
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854966; cv=none; b=pHi+Obyj9RPr17mBNZRa7JVU1OxyF8xOoZ6OIOTQ2tPQ3g03OQsRgBTvLPRbo8sIhgtu3R3gKOvnNqITkBwEnBhIA+5shOXDOdIPp6nTZ53uhex0Iomyoe04h26k5TppIh7gyQih1TumXj3FyLlsnQ1ymrN6qWoXxbsdSRydeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854966; c=relaxed/simple;
	bh=IDWlGcILCgeTfh64c3wWvrJ1SZ20s1bbqET00o/9NcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwN4ebPoyI00ZH2+NBOUEUfLC92DDoExR9i82UdV6cPx36FYKscf4xvnKPuK3ZPKkmw3qjHvfVwjEanivXaTxckOPHnOQpmxBs60zzp1IWXarNlOGXLOFjSfuTd26GoA2M3GGA5ovYnSnjip67Jz9XlhcEOcscPem3a0JlaeU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=D9Y1eKKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qnwOLbSR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="D9Y1eKKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qnwOLbSR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 506557A012F
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 07:42:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 07:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790854961; x=1790941361; bh=wiR7GHYhM8M440AYDtUUo2wDPugwTGMs
	7bdBVyUJwQU=; b=D9Y1eKKa4jL7dXqHWADDBgFMqyirU77x8DVPs13pGNb0SHXH
	IoaikWlkbK1yWktiSTDrnN+/Ghqlt+BsIAQCm4KWzl5UAE8AYbs2QWOp1t1U9/S/
	jqBkHhvEu0u8y7ZxjKCH1buhIgCXcd9uaUejO1PbH7tICo5cby/wPo06RLg3xon/
	6IH1moUunrRGFu2cPpwz9TtY3OssPaNObsUXPUY4lE1EZeFGF06Kj+g/GA1juNHc
	k5GdlE/TlA4HDSo5gB9JCjsBrljJWHlAxQLPF7B/a0KsCdj2N5SqM4OGf0G1i871
	7IEp/k8B7c2l7NKRZsKEIJzFP02SjGIgwH40Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790854961; x=
	1790941361; bh=wiR7GHYhM8M440AYDtUUo2wDPugwTGMs7bdBVyUJwQU=; b=q
	nwOLbSRe3u/VZ2/X1M1HGIL0Qie0nfNzKoolHpayLgf3DXK12vC2sKyHbqMqx9A/
	j/NTh9wTRhB8TxtVpm42pqejWJ3wzDUmGFCoDb16yDglVnCuwaOmUTn5/wfvEmG1
	FA0236sJFVeh0+iG9/Bj67VprbqbNAXrmkUaxjO5naq4EGoiPYe+nFFIgwG4sGsZ
	+CPpdPdxYIDB8taKcFjvfTsBqQION5FXdlZFdtzI6V6Yu3r6ZHbvcAo5vUOBU38X
	YOawh5nou6A37+a0nsTIUkXbaDFF6SojLmvfvucM/CQxDaoHGhPWV+v/1u6kVuHZ
	vRfTGSkpvCGU3VtUXfLlg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790854961; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WWVPeb3BYtHY0J3YtvSlQeULPJI7cRyx/seXmlZl3xzYOe3
	1JtIeVktTTdqD0O/jvmFkFYWW5bPfNRjWNY6FJoHq1gUhFU/wL0Ll0SN70+GCdHu
	/9dYWdJp8NA9AkImW8O+qgCNVcBCVkk8jdsR/PA3w0B5YH/BSDJ+FMuIzCt3Vp6Y
	fwmPiz071njz+NxOn34jTSD2rrAlPemlwBYwIDQKnBmaqLllzjJPLOy+v2q5QRQf
	l+GbvMSYCRrP3FoFJw+1ggskdBRM1zIaUxCK5r9vfqKx0mtNjSRtGWxxof2jnXtU
	w3T+OjfzZEykqo+I/5C5tkgle5vHoKGDN/G9rmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:w3cFYu05+oNdK9LY4Pnh9vLjVY07V07d8LU0Yb5CTMU=:IDWlGcILCgeTfh64c3wWvrJ1SZ20s1bbqET00o/9NcE=;
X-ME-Sender: <xms:MUe-atFphlcj_GDw7yKZ7peGb5YxZr0-xzv0swbYsc_V9SAiLMip5A>
    <xme:MUe-aqel9_yP2GgIketUbJanWWBzcAFtNXNg5TziAXkIAS04ePxbAzVg__Qjm2qyl
    FQjZVKmFCtfaI5Qwe2EqGehmB8unVkIzzII8A88vkiC-4hI02uriMVg>
X-ME-Received: <xmr:MUe-auqf0oUZRtEhnAFGVW8ezww5PzjDORyqJfyzNkisYHmW1p5TTcC11qm5>
X-ME-Proxy-Cause: dmFkZTFq5Qn6nRJgUzJ8A0Lp07mGWxrMuWgqUOpjryDkcR5C7nDrmlxdUGB+1dHAHFMzCZ
    PM1Z7KAur5Q3p/pZj989+OOezFlAGikDMYI0syQqkku5V7O6AyfYNE3xdLQ47AdCMk7yOY
    fr2oPMfK85VfhF2E4E3TK0mxMfhHWjUHt6p8IxxgwFU0Crk0cggTLz61N3LEkyQPZTpZMK
    6Cq4VghPibym913wVLVgrzDxcOtld/RbqJzg3CNbLigF/LyjiZGcygsu79bmcvIn88VCNQ
    f4yEYoWC4OOr9RMjNNNnNAvmGtKcAqf1fV3M21z345jEEcMu+JROHXip1bwF+vyUJgcZK3
    QiNyi4F1OXt/Ihz/H5ARUs9Gm/c+cdh6cXi/pwjIdgE9LvMsv9gUA7yZO3AA6WWMdAYgt6
    F5xZM3WTGgT+J36AhWwuca87/MSmcgzh1l3OfNf0jQ4V9w64JCJp//hjsvkb09rMhd53cP
    3GAVd8O1E0oaT3TCRDveNmDx0uewuh2+lvOUZpWxMusrMI4GWz0jTcAhbKxhggTVIXO+MY
    uKnO/4C+0GGa1ROJFDJKgOGh31ZEdXHqV68KBm6uWkomyklfW3QExRCg+P3eZIGrNN/B7s
    hkWioeDplcNjSyHddgMSfLOCVl2AUxwPbWStYrJAfgyO8Cv/PMDHUNu55pKw
X-ME-Proxy: <xmx:MUe-ajDRfOCE88ukX4VW32ntYmeSriSXoLwyIF3ixlQrjROisc2D8Q>
    <xmx:MUe-avdSRq7dzQkO3g8s1LqStuIayv7p7veoHYM_FIi0De8Dcc9GNQ>
    <xmx:MUe-arvcnHV34CRoCs0eErqL8HXO0PsxYs9XxgNwNCzoi1ppzAeU5A>
    <xmx:MUe-amgIaEF6hJIE32G_bwWlw7hq7p2INVsW9wX_gQUrLtH2EMfSaA>
    <xmx:MUe-agybIW5Q2aqix3A8yM8o7-27DrhHEG6dcvMVTzzKs_A1csJNZz9g>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 07:42:40 -0400 (EDT)
Date: Thu, 1 Oct 2026 13:42:38 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 5/7] net/mlx5e: Use the packet sequence number for
 the IPsec IV
Message-ID: <ar5HLrGSiwbmr-pR@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>

2026-09-30, 14:45:22 +0000, Jérémy Jean wrote:
> mlx5e_ipsec_set_iv_esn() may decrement xo->seq.hi for a GSO skb based
> on the SA's current output counter. The metadata already contains the

And doing a check based on x->replay_esn->oseq, which may not match
the value for this packet, seems really weird.


> -	if (unlikely(skb_is_gso(skb) && oseq < MLX5E_IPSEC_ESN_SCOPE_MID &&
> -		     MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - skb_shinfo(skb)->gso_segs))) {
> -		seq_hi = xo->seq.hi - 1;
> -	} else {
> -		seq_hi = xo->seq.hi;
> -	}

I guess this is trying to solve the same thing as 4b549ccce941 ("xfrm:
replay: Fix ESN wrap around for GSO")?


>  	/* Place the SN in the IV field */
> -	seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
> +	seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));

This is starting to feel like we should have a helper to compose the
64b PN, and maybe give a name to the (low,hi) pair struct to pass it
to that helper.

-- 
Sabrina
