Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9063ED5B9;
	Thu,  1 Oct 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853881; cv=none; b=auhqen4pwvZCoW2wtmMYdDJ6yLSGwdmbh3X3rOKMxrc2WIQy44SFgLuVJYJytueGOaEom88Qd5EOhXd9R8EZAY5NGA56UpyZAQkM1ffhCI85kYSGwLnVuhkyYmvMFW45PERT+AmNgc+kiW6i9rXA2smWZOqK6VMG7iWKUF4gr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853881; c=relaxed/simple;
	bh=1yeC2Ala8kjHqSeElIeGucZmTGwWWYHJvkN+sOD3Y/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4BdjmC5szwECPad2M7aLpaxCmLO9nLrv0Ci27XUnR8PMvuqJUnDqUCrjdHl4uXRKQMA06Vbr4ZTy9zoF3eEXd91U8JaBLaFfK24/cx54JlELlxb9/EiidNH/659m+OMwQTjBrzuF+eBvOduTEhDik1sx1uTBU1SUS01rtJ+898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qfvndtrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKVy4BA9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qfvndtrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKVy4BA9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A6A641D000D2;
	Thu,  1 Oct 2026 07:24:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 07:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790853876; x=1790940276; bh=sT6PG3mIfAw77vzZCaQEU7kdaHnu3XKc
	Gm/VG+fYkSM=; b=qfvndtrAynukcgg3exeMCInvKXc4v+8Ch9vZskDNGZdNCQC1
	1pPAHJUONn5z1A8k41LFkgZXgj6m+xObSUe7NSyocXJ36ef3FzhObdySsCKS1MC+
	ofkP8kA04Sxutn4cYEUw3ZvJTvZanQXeG4U4JOUxpzRSC+VqDc1x7JMJ2/ORAOWH
	5KWAsTawlxeXK8xjQvMmjV2c1Gj/xymlzIiJuEiSazddQdL0X5TisApwkRXKe1R2
	JHUe83eT3TI54cCoMSukDHBaNOBOWDt54ctFQh/NLMs1PQ1lrLYWQ1qBbF+IoKZZ
	T0oeVP2+inTAI9DrBYGa/sAraJ4IwtvXQsFULg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790853876; x=
	1790940276; bh=sT6PG3mIfAw77vzZCaQEU7kdaHnu3XKcGm/VG+fYkSM=; b=l
	KVy4BA9pRs8Vl0CmvkPVnQBn0Ee6KPekR6R1q4O8G3KEAj9XAAyx/fDYJHEXRuSK
	1kNbqueaP8QhUxZZ/FZIdalblrfTsq72w6SIP3ilb+q3XEZIPhddRd6HvuiR8Qru
	mG4pvH52c+HnhbrrCwdAUSuQ+nQb6T8pUi+f3TbC3mQJKpiK5VcsmotOFkH7pOMD
	DuUqctxju2NXc4bYmV9RrwIZ5XQSwsSwoBPWa5+W6/i7dhBdHyBTBIem/nG8pP4X
	EIoP4Mq2B5BKmORqeoaT2H5qAod31CS013aUb4QJjeRyg7dVysk0HAroxe8FOj2I
	e+LIJ+q7sbQ10WiKdJwcQ==
X-ME-Sender: <xms:8kK-aoz-gppFY91RIYjZ2hFrWXz7uNAUZrXRykeOzimRZ-mC52UGWg>
    <xme:8kK-akb7hrZMkykPNBtdHRwojQAf-hoPzK55leMgER5xfg5_r-K70P7wgCLrbxWYQ
    HHZU8k0BR-3faP3M8CaJT8hUIdaKw8yceYX9dd2i4m6uoOhGnJ9KZQ>
X-ME-Received: <xmr:8kK-ap3uWh9ULnOOz5tN-5qF0pwGiCUl9M5VimlwgW-l6HupPuf1M5c_08CO>
X-ME-Proxy-Cause: dmFkZTGU0fCkmRKIppoxiioC6Nb4u9iBBZn+1//42GW1UnOXuRIOBj09xlHXhCST6FTO/a
    dSg7n9P2kfQqecOcIy3ucsTZMTr3nRW0ZsSzMCXKHkUhqIpdpj3HOT8AOh/lbZbFi4PRVX
    eLY9DRpE734CL6DvfWNdk78sTXZJtLKT/roe5Uxw0ScvLRa/WZTzyEx6F2M1EzbqumYSU7
    bdqa78HndzaODuYaplhVWokY1YShJSlmPo+cC5zMFvPibMi04a8rhlDNGMkMiEbb8YfIxw
    c4tTkn8zsxYZ/nqkJ/oCPJjiNYL+1a8sks7Ewh7YRCkHWDR/5QD1t+J7NHDc1AHTsb4VEN
    zaVGNfsGhbnMnXnf8hWsfZeARtJBtruBK66hfhDDQX7SJJ/njff8wOZ5VFUF7K1QMj8d1i
    oD7Q9DguMmO6k+euntwsy10naUCd2m9Xilg0WifNCjZEkJ0h3YYDtEEFz1Jv8JnFBh1Q0H
    5K5CzFLP9eS/JqCm3EyfEOGKytbf84qdAy6LZf93cJYFRcCRzF/Pu4TUq7Ah0q82V/ihuy
    yCkcBm6heREo81e6DuYHKOt2yWMjATS9vHRSpijWDSNxe2cjDugbU5gPXexfeTpkSV/gTg
    Abk0weWlaZhD/85O22JsqZjbYWUUELS9cLScLnL3jR5/iEF7ZYOpChxrAjHg
X-ME-Proxy: <xmx:8kK-amclP30fykSNq1CD70bXO-sVzI5JI4ZIcfG4unfJcOTfGmcsGg>
    <xmx:8kK-amKYYVlvrTvk_3x3MpRj6x3swvNn5Zf6GlFp9NCJSdUSNZtLjA>
    <xmx:8kK-akqNO5nm-gjv_xOgUMA2FGcXTc7yFO4uFs80J6F7C259bBg2BA>
    <xmx:8kK-akuvbcRVI4qdmhGTGCTa5wiX83ehWww94AVPdg5QZ-auzDyEOA>
    <xmx:9EK-ajP6B5BxIa4WcTCDjdA6TjhlD-7QGADzZpBuoGugt-2O0s5OAZI8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 07:24:34 -0400 (EDT)
Date: Thu, 1 Oct 2026 13:24:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 7/7] xfrm: leave the sequence counter unchanged on
 ESN overflow
Message-ID: <ar5C8DDMwWn-30iV@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-9-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930144523.435271-9-Jeremy.Jean@oss.cyber.gouv.fr>

2026-09-30, 14:45:24 +0000, Jérémy Jean wrote:
> When the 64-bit ESN counter overflows, xfrm_replay_overflow_offload_esn()
> rejects the packet and rolls back the stored counter. It decrements
> replay_esn->oseq even though only the local oseq has advanced, which
> can later induce a reuse of the last sequence number and the
> corresponding AES-GCM nonce. Both IPv4 and IPv6 are affected, yet,
> processing about 2^64 packets under a single key is required to
> trigger this bug, which is highly unlikely in regular use cases.
> 
> Leave the stored low word unchanged on overflow. The high word still
> needs to be restored because it was already incremented.

nit: using "low word" and "high word" instead of the actual variable
names doesn't help the readability of your commit messages

> Fixes: d7dbefc45cf5 ("xfrm: Add xfrm_replay_overflow functions for offloading")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  net/xfrm/xfrm_replay.c | 1 -
>  1 file changed, 1 deletion(-)

I ran into that one as well while I was reviewing your previous
patches, but didn't get around to posting a patch.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
