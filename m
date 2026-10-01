Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD437CD40
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861482; cv=none; b=ZTAszEt9U25ABvR1jcrSpn9kvUwS5KOppNsFOpFYm6JD/VUfzL2voJ7CETH/nSealJhS7eh32dKg0RuOsXv/czdL1l7zB3K0Y1GJ49bWgZKJpKjlFKl4t8rLVXeaX5Z1NGmnqsKzFsBDOjnFEf+YEN4Gyf7edVadxCFB1q9uuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861482; c=relaxed/simple;
	bh=SL/sKAY5zs4iczrPKUN9gHqPuoP5uI74GYM6g0cHXJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLO/FURio3YvVuBmtTaEuqRiPqEaE0neMuvSZeI52BKfAp6XiiyOy2mIU6aOpaR1M7EXW5nekDg2nXijkW9fmghpZIs8JxROBv/LSUByX7N2/MkjwYgqBOnJccc9vF91SLHVJ3cz/DGWeKLgmGpeG+PKv4QtmK4lVgLCubWoVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HmFL1BAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gyd7myQ+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HmFL1BAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gyd7myQ+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD8C31400155
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:31:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 09:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790861473; x=1790947873; bh=41O/1/MT5NQip/MNbh01V0OZwDlklJSD
	dfF/XYlcTug=; b=HmFL1BALO3Gx0eZOOnHj0JhnZ0j1IA4jfg+e//ZRLogQPIEQ
	dtwDloSQ1KzFG2Mlq4HEpF9mJfy/iNtse6QOMIimXrbKTAawq+nh6K08jUFCExYa
	K6dIa6gYl3Doqm4Rl+YBgSjhfPQMPoP+4Vt/97CiQVKIK1e59UXpOfCnCza4D+cq
	HkFoVjwR1VMbNWDJ+JeUkoUbCVRLoSwO+a7MbCfngFXW+itDCyXxpC7zZ9vBc2Oz
	SwcKDp4f42RJWsot0Y85qOEyID/0FmowyY7ddEvks3Fig74igwnLqtJd/PfMJVsv
	SkLXqQRVBVwgXTkyGVlwo0+lqDeJ2Wp799AXkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790861473; x=
	1790947873; bh=41O/1/MT5NQip/MNbh01V0OZwDlklJSDdfF/XYlcTug=; b=G
	yd7myQ+Y+8QBnrCs8ELnIMi7QhCMa3hKXh6s3bc4WLjErhj641kAL7hH8DxgJF6y
	1ZjfcWRPb7v4QvE0RQSN8mIA0RZ0A2pbLASKzHKUVBVb3UmiiL2VQgrqWYR1IWe+
	dI9Wp9Fw6TN9LVRjTpoRYlWOYkQIS74WFv0uKPpiQ9B2fL9TR+ypo/YB3XTp2pwg
	eXt5FNG9nuY1lkgqyOC5JzrVN82IMgL5OnzQUE9GQhwz1U1YxSrZiw+qbmWaZama
	BF7nHmnw69WkuriwUY9swo1oilJtLrTgtX3yzhKL+GeEerHxI7sL0fpVuo6rBTKx
	30q7oDAaOXd5GW34MIKZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790861473; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qysazcTlTyIVIU+wcSf1jAc+CQJcjetF5IiHAd1gpe8zKhb
	270aufh77Yl0Da7K1DdWeCvlseA6Yjq5VKV8MVPVPicbzgRynYiRqFsLi07lsepb
	KcxNOo1G/92uTYUHi0JOJfV+jr4HJIktRANONhLVvLkCTC54pgHdpKjCQs1A9SQB
	HOJmusqBVAPZoVnH086U74bI+3X7MsGCiz3XVbS6+aR/VTbkwpKFriyxyj2w+hSi
	EnBqu87/nqWIz/fZ+tfT/1tDoAA7yNxA5YVNaYNl1+itys1YmNtPVpfmO5x4iPT1
	6yxyvcVcc4UzGWq6LEwdzuZlVync2t2fjJtivow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jNIIWvbcFQJv/sO0yhcO/j12kvEb2ZecYkZi722TOlQ=:SL/sKAY5zs4iczrPKUN9gHqPuoP5uI74GYM6g0cHXJA=;
X-ME-Sender: <xms:n2C-avZMNApFAFprmZH8uY1ryiPwo5k0y2NTXkrh8czhkOj_lxLhVQ>
    <xme:n2C-amiaMMcpoOs1Gwz0aJFB5gqEu_xhqGBKtdw-X96DpZCXWHM-hgAvGV6bTG2yp
    l-_xj33ui8giH3d6aI1BQcjXpI5IMkGYNbmCDvhOTcyPgtvjnptDdI>
X-ME-Received: <xmr:n2C-ahc85Ms_5yVqDhHAYnpOXUDP2BmyWpAo20IVp7NmBdM50yhH993fZxTM>
X-ME-Proxy-Cause: dmFkZTFwFg1n3Pbo8BDFATX0h2x6DYerbVlqRq7eHWr41+3wnEOunugl4MWPaoSK1q5S01
    Jy33ZHrbMLJBR3EDtJ8+g6CsnXGOMOrkjUmEpE2I60MBW0nvjLxVDpAY6vz/oPCb/e9c0H
    hiWwOtkD2Wxtw2GXfXA97rnu8hZXn0Tw/3owCCxZNtaZEDyD8ItVXD6isLw4tfIACbzkva
    p2qgJlk5O8T1bXmoOo5xCcgEDsUbll2+6kgU0o03j1XQb1ArwcjiIGNwZeZADdgmtwcaeu
    n98Ekco7Kut5n9FmAIEcpxRNlHng4Xt0agrCP080/NqdyyoMsaHcbc0dzAk/tJW9oJ1AQV
    WPKdCctrsLxwS7mDm9F9m3nDCA/Dh1kZVLMuY2UGq28sw5KZHSp40uh+naWb84ibt09lne
    4wvPr9/ZqG/OrMBG2Hy5Rp0OesniMXZnEBbLTK0oPqC+wAXwSvymbbz5VQdmQHOgY7AkJO
    UQyrF+wxWeI+DyIGF5RvibjoIAXyNrcwISGmnbu8ph7ashFtgtwgaE5ehsrgHGWKSb9Wgv
    aOLmhZ7vyYy12EazgMmRuSImjTfl5BU42gyyttTDrgHvtz0q9X/5Gz4wHuU1jQNzDfqO9L
    Ru9gYM/OxkMcEu0iSuQ+BVCCnFH9I6lSk5UYStgUkrAYo9hawYJ7NdASeo1g
X-ME-Proxy: <xmx:n2C-alm-yIcqAPfvKyio8Bi6-nByzYewsJE2aY4w7sQuiuBdFwV6iw>
    <xmx:n2C-amwjeVBaR6onfrSX_OcfNCZc-K-fOa9_-H1FHrM-fiQDK8mKCw>
    <xmx:n2C-aoy8ZM4zBdyu0t8e_LqPBd9gYhig4fT2nhpTLA161_Y07ZESig>
    <xmx:n2C-amUaRDQ4P0ZEZ-MDJYR_UMDzQlA1b9FaZeId541p1u2CUsSQBQ>
    <xmx:oWC-aoIMO3EANbK0rOH7MmuRtfGa2aHM_1fvKAOBIb2tji-3zBqIVhTr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 09:31:11 -0400 (EDT)
Date: Thu, 1 Oct 2026 15:31:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 4/7] xfrm: prevent AES-GCM nonce reuse after early
 GSO
Message-ID: <ar5gnDR81WsA0TBg@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>

2026-09-30, 14:45:21 +0000, Jérémy Jean wrote:
> In the software ESP offload path, xfrm_output_gso() leaves its segments
> sharing a secpath extension. Each segment gets its own ESP sequence
> number, but stores it in the same xo->seq field for IV generation.
> 
> If encryption is delayed, later segments overwrite the value needed by
> earlier ones: esp*_xmit() can then encrypt several packets with the same
> AES-GCM nonce, despite their distinct ESP sequence numbers.

Here again, your commit message could describe much more precisely
what actually happens.

I'm guessing you mean something that starts like

xfrm_output_gso
  segs = skb0,skb1... all with the same xo
  ...
  xfrm_output_one(skb0)
    xfrm_replay_overflow(skb0) xo->seq = N
  xfrm_output_one(skb1)
    xfrm_replay_overflow(skb1) xo->seq = N+1
  ...

[and then some more stuff happens that gives them the right
esph->seq_no but wrong 64b seqno used for the IV]

But please help reviewers trace the codepath you've already gone down,
without having to guess what you mean. You don't need to give the full
call graph with the state of each variable, but there needs to be more
than just the very beginning and the very end.

-- 
Sabrina
