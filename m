Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9A5372E2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987057; cv=none; b=hwn3gWeHN8kpjQ+x0HBRjMteNEyqsw35+KxybJMjT5/bKGjawW4AglhoN754qFd7CDKV+D0lwwhuR2hr5RMYUr4r9UrN+xPsDkqAEE0KnKuX7/cImAbh3OchaUtmge5d9NCypfP9zqulr34g7bigCRVKFIYVVxE0WtIW0ABG/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987057; c=relaxed/simple;
	bh=kO7lS1SXEhALyFoG03L01lJuVSSoUeXxVu2mGJefl38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Twmay8Ve8ollaW9G6NkBgUM/wEGBMucxO6iu8z9eXJerK1spZUngje7oyEyT34YpVZH8ub1n8PcUX9JmwLfWPe0RgaSPp7XW1asQhEV/Kv4Bft8E4vo2z6dR/+Z5OVKhPfVlHkmPTqqiU+s3PKaNqhZuh+NzmxfBSwixRM/yvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ez0GIFIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SEXbQ2op; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ez0GIFIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEXbQ2op"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 067BEEC024D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:10:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 10:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1791987049; x=1792073449; bh=/+JI/P15xtoRWwZftZOJXqbX3O80Oe58
	eo1xQXdfSmQ=; b=Ez0GIFIuvQ4uSFb3yoWwSsbtTHnfVx9V0BJDJrKfytHzb/AF
	bblNo9J7+Jt1SxOhSHe9bClfYBU1p4eayKDVRPu0k4kAuPgGHAzoBElXC7/NdSnb
	3U8elGixGAoGS0vzFl9MYclAitW+mt8cafmDRVN0XOeHttWo2rVUgAQ3AsGLsHjF
	fPaca0mSsQatlOz3vBz4LRUYv6kVPnr6eS9CtHUVBHUwKMyjpSbBj/Bo+vLnW9cc
	wFvzwECUrSZwCNCY5NUepqeQWk6uXitcdGQbGvkfnflaSzsHghiyyC6srZTsFUKF
	nGvsHe6/YzD+2W1xJVEMwD6x9mgPiAiM6lDawA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791987049; x=
	1792073449; bh=/+JI/P15xtoRWwZftZOJXqbX3O80Oe58eo1xQXdfSmQ=; b=S
	EXbQ2opjT6F6SRve/YrGvbu1mGzGa5jBpGZvIwU/X4HL6t/QtN5Y/YKBbmJgYSu6
	8dm8OB1Jn3zty+rU3/AtzNdTzdQ+9ebIwqFMRUTnGvF/35alrnNLM0Imut1xuvzB
	Kh2C36EIk6gP1I1PdbaoX3QAMs0Idd0170q+ys76E61JuKYpT78201V34aDhfokE
	abz/nMOnwpnf4aQkxfLzyKNiw6VyTpljkO+j8pJ3VcpgekvWbiRntT8VHTCX39mK
	He01zv6EP7iCztTxtkwEbkBs+4/cgX6b5XRjkk+stRgEoIhX9NznTjk89lz6HZ9U
	c65gqbvn/Bx/Hyc0nVKcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791987049; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Y/rZGdXrQKF1EYWIamo1QtoXOkmafSdzJf/SZCxd89S3wTs
	h5GCfWUUE+EBSdu5m/iJnh8FE611PRdwiKvlPK7tGZBwkR+PbsZnQrvTcFHs6YxF
	NIdeHhd72Fh+48mRjizpkKhoHn7KqGCAhOTuWpNR0qTsm9HJm9OKLIw1s006FPSp
	rLNb6HundJA5ppp+r0V88jZqcA0FHPq7+SAjoGcrUuTE0Sm+DJCd8zJZLaVFIi9p
	FMCvWLE0LtUm+Hjon85+3odBTUemcW+3CQh+HbFvfXynIkxUV9Jq7n494hivtmNJ
	sXERF0Co7Bfg5ZXK0Qri0KZ2dssUzdibMu/7S/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:STCi2E8jXWRLDUCuCW9p3S/VP98I0v7EaMpPXS1GU7U=:kO7lS1SXEhALyFoG03L01lJuVSSoUeXxVu2mGJefl38=;
X-ME-Sender: <xms:aI3Pamb51PXnzdjpOtTXwhFvdm5zBMOOGZvubJHbatLdddXi7e9Mgg>
    <xme:aI3PahimxoxwHXqH2OV83Sn4bxWcN9-Hou08m81RQtOgoKNerUpd5X0OcgNLjrthz
    31yW83OddERFpm8HTbd2Kx75bUSf18yB-iinBvIW5TwEDKI1BJWQ0A>
X-ME-Received: <xmr:aI3PagdWhyFb9_KD1h8UXVyIvIX5Z_A9fTOMJuKZXoMyMh1aK8GbWTUtSz0>
X-ME-Proxy-Cause: dmFkZTGYMSs3CFqigZbaBLa2eIXfCu/3WqZRg0HZEdFOJt3hYa0TpHT8Z+w00uZvZceQdX
    qN1Sz2rc17MbyarCihZSadaYzDKIlkaigX0sens0l2o4h57mQ+w4vs2uqtmZGN9cgtMKNN
    hQLp0HqRoljRuSinF63wdJzJRgGzxPe1s5gWsk3CjKKo2eAzKu9vxlz7QegXCOFM42tP9i
    hT3aQe4My0iSp9ZjnzZRc4sg7UjRST9Lm/OqzSduh2oG1/Xng/xwFfUhj4O8YBXGbESEjw
    z7nezSkdWThG3cHen0Hf8wIioUfL3JBcdXBl4ZOzVCAOwV5++/uPo4LAOc2nhIgBuIQgDu
    Na/Ohbg+Ca4/HNFfQAUmPBkYCrOvAGilhuuSQNc8d7unrLzC4M09VsIvmZsPVyVNYfutbx
    dGMRf6KvnHMu4UQGWis5VxgeSTakCW8sTDOhrrjYVFRQAY/IT/azUrDFzVGaJROYhPTOWT
    D0LwCv0iURxjKGJ7SqbJxviylnnwi5SeP6UtWIcTmSScPP/srrzvJzfmDrFddtt6t/qrZM
    R/Q9HYWd+2l7LEJcOfzFoBAoEBlbKwT7fYPu6pZ+VDxbraf7VrTXi0g18VIFhrzLY9JP0I
    gQUfuzRK7//IulGszVRcw9uAB/5eT86U5oqrVQhpUcrVaY6++LqJyA3VvHtA
X-ME-Proxy: <xmx:aI3PaolpyJCUUJBRyCmX0LkobSvd_QBJf0u62sOW3ZF1ngZuPNk3vw>
    <xmx:aI3PatwmYkmNXc44oVfKQBfaJj__I4YwewK4XQOFl3Y4kkIUGwiRzQ>
    <xmx:aI3PajzT8W17XZ93M8m7PYX4Ju_L7uGRNfDu5DGqMK5d6NBt8GvU4A>
    <xmx:aI3PalXj-G96hCTvbyavyVcGj44LZDJ6KI3zulUh7Je9htR6XsxXEA>
    <xmx:aY3PanV5k9Go0FYK4_LmcsE8Hv591yoFMbRydbjMDXUXotCawUo8wcNu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 10:10:47 -0400 (EDT)
Date: Wed, 14 Oct 2026 16:10:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 4/7] xfrm: prevent AES-GCM nonce reuse after early
 GSO
Message-ID: <as-NZDzUz6Cf1_l5@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
 <ar5gnDR81WsA0TBg@krikkit>
 <c24271382cde79f3b043908ae52c41cf@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c24271382cde79f3b043908ae52c41cf@oss.cyber.gouv.fr>

Hi Jérémy, sorry for the delay.

2026-10-01, 23:07:55 +0200, Jérémy Jean wrote:
> On 2026-10-01 15:31, Sabrina Dubroca wrote:
> > 2026-09-30, 14:45:21 +0000, Jérémy Jean wrote:
> > > In the software ESP offload path, xfrm_output_gso() leaves its
> > > segments
> > > sharing a secpath extension. Each segment gets its own ESP sequence
> > > number, but stores it in the same xo->seq field for IV generation.
> > > 
> > > If encryption is delayed, later segments overwrite the value needed by
> > > earlier ones: esp*_xmit() can then encrypt several packets with the
> > > same
> > > AES-GCM nonce, despite their distinct ESP sequence numbers.
> > 
> > Here again, your commit message could describe much more precisely
> > what actually happens.
> > 
> > I'm guessing you mean something that starts like
> > 
> > xfrm_output_gso
> >   segs = skb0,skb1... all with the same xo
> >   ...
> >   xfrm_output_one(skb0)
> >     xfrm_replay_overflow(skb0) xo->seq = N
> >   xfrm_output_one(skb1)
> >     xfrm_replay_overflow(skb1) xo->seq = N+1
> >   ...
> > 
> > [and then some more stuff happens that gives them the right
> > esph->seq_no but wrong 64b seqno used for the IV]
> > 
> > But please help reviewers trace the codepath you've already gone down,
> > without having to guess what you mean. You don't need to give the full
> > call graph with the state of each variable, but there needs to be more
> > than just the very beginning and the very end.
> 
> Here is a more verbose changelog I wrote for that patch:
> 
> ---
> With software ESP offload, xfrm_output() attaches a secpath before
> calling xfrm_output_gso() for an encapsulated GSO packet, but
> skb_gso_segment() leaves the splitted skbs sharing the same secpath,
> including xo->seq.
> 
> For the i-th splitted segment, xfrm_output_gso() reaches
> xfrm_replay_overflow() through xfrm_output_one(), which allocates
> sequence number N+i to that segment, and then incorrectly overwrites
> the shared xo->seq with N+i. If encryption is delayed until all t
> segments have been processed, xo->seq ends up with value N+t-1 for all
> segments. When validate_xmit_xfrm() calls esp*_xmit() for each
> segment, the IV is constructed from the same value N+t-1, causing
> nonce reuse in AES-GCM. Yet, each ESP header correctly keeps using
> value N+i from its private XFRM_SKB_CB.
> 
> Call secpath_set() for each offloaded segment before xfrm_output2(),
> so sequence allocation writes to private metadata that cannot be
> overwritten by later segments.
> ---

Thanks, this is much more helpful.

The comment in the diff could be dropped (git blame will guide the
reader to the commit message), or extended with "and stores it in the
secpath".

-- 
Sabrina
