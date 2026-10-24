Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804787;
	b=R4uZwh5ols1+Ki+keA7CimpVub35XDHQO2qHTNF5eHF4YBXqGVcokjLeMnQLhLHTU+gu
	 M73oGIEVJAri7Y61dLX2rQ2non4dtpj8c1ReJuj4Vgg5ZQtW8799YPXQtxhUyVY/iq/KW
	 JA4FfGR8uL+4BxEGF+Y56YbcH5I7x3y3d1nYfSWMBr8Evt5ShPHKNqBiBmPdRd3xwqC9d
	 wRyRd6WbPoF+bcHbvG9sOqJpKMpgQBGzNnNDxaeuW2unETFPkV27DErLEEJGDkSU51AHJ
	 OgyxGrBbfzAW6LnPyH12w3XVGhZvk/pG+4BwuqSFtYM9XnySpS3cnbZrlaOvUcxj8AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804787;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=C/NM1GxStjl6GeGc917cQZ0BTXn+/+y5OZIqEah8ObM=;
	b=uoZ0Gj9utSP5ZrMVPzHJaOwEOfaxLT1g1c9OOoEEqrPLi4XmFl36fnn5in5PgRJwmwEP
	 1wpNdF/M6YOEvnHUFVJUEdi03YVeIUd5EkCqGgggcgy8XNcjEO+bz9fnCTcFsR2UFpG+5
	 JWANANpQ9O5NQ1Xg8IXFchWbn7UqSYvvPnWIlPYTNQ+xOUfE06cKO88RFKEnMNvRPU/Ly
	 VaCJWd3VlHLStbwyjPqPF156loDfz3smftEVN1pTNnhS8qm7hsurokfKpufH+Za9zGpsP
	 rLUyQOXhHL4EF/FZtgqjQxvRNctDetFUHQbsqdgG34qZ6Mu6BKcWak50F83Qy9Fnj9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A57606A31F;
	Sat, 24 Oct 2026 01:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A57606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1792804779; x=1793063979;
	bh=C/NM1GxStjl6GeGc917cQZ0BTXn+/+y5OZIqEah8ObM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rWF9v3ETX2cQMvhWs2Z2Jo/MKwHh9b6kz4bfiJFxzccexAdUPCXAcpum5CbSl0gVQ
	 jZFInXsMigM9vY+WrzB0J48iXM7oxvXRCf5KhVqWMIqyjCqjGwrZomDSTSfiIy/ia9
	 dJG1YInvHi3X3Je5GKFf+GLq/jZRyy4x7nqSHYtcq1Ffq1LKxOAJXiYfY76wpxOATv
	 +Qk1ke9g1hIK6tTGLcVeqQOAPZXGLZRZ7MPshLCWrfu9xwk+nrUlwMOn+vkanXNd/6
	 geo79nmLaBTuSBNIbOApqAXuW1CV0q1Fw4L9xTC7HrwqT9Ysez0dasN3V2TE5J5YLO
	 3N9F/JROUi5Yg==
Date: Sat, 24 Oct 2026 01:19:35 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, magnus.karlsson@intel.com, sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] xsk: restore UMEM flags after failed pool assignment
Message-ID: <vvEqZnjjwNbZSyIzO-MRYs4L5Mco6TaN1GMF1ifbua4Ojw6Oc-UNUBY5dERQP0ZCYvFimM0VjrR8CDsuYEmyD-au3AbT8ZUD3MwVEmpPNOE=@1g4.org>
In-Reply-To: <20261023161211.74b2acb6@kernel.org>
References: <20261021224705.2078753-1-p@1g4.org> <atnKf5dNv0Vk1sCo@boxer> <xFs3DcEr8aRQdjIeuzTZ4fmeQ3Ay8_x_94KB387XkLZDamj_rLyn4IGiFdZMi0u69fpiYrPQq9P6o1j_xixC1WbF-tl3JxDLmcMZZkPk70k=@1g4.org> <atpDcGN3zWhixRj1@boxer> <20261023161211.74b2acb6@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 751057c4b617e4ef159747570a1017153ab4729a
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
Content-Transfer-Encoding: quoted-printable

On Friday, October 23rd, 2026 at 6:12 PM, Jakub Kicinski <kuba@kernel.org> =
wrote:

> On Thu, 22 Oct 2026 19:10:08 +0200 Maciej Fijalkowski wrote:
> > > Right, evidence suggests igc handles it gracefully, I had attempted
> > > to provide multiple examples of real world impact to satiate Sashiko,
> > > but only igc survived final edit. It needs to be open for the failed
> > > bind and successful retry, it can be closed after and bad state
> > > remains. If you're looking for greater impact, look at stmmac. I'll
> > > send out a v2 without naming drivers specifically soon.
> >
> > Not really needed to go with v2 with reworded message. Let us wait for
> > bot reports first.
>=20
> Bots look happy, but I'm slightly confused by Paul's "only igc survived
> final edit" statement. Was this issue discovered in normal development
> or by an LLM bug hunt? Was it tested on I225-V hardware, or LLM just
> suggest that HW as a NIC that would be impacted?
>=20

What I meant is that it was admittedly awkward the way I left it.

I do use LLMs to a certain extent, but they have no autonomy or ability to=
=20
communicate, I am a CS major that has a long history/love for C and =20
been configuring/compiling the kernel since 2.4 (old gentoo user), so I=20
didn't wander in off the street. The bug was found through development,=20
I have a little n305 with dual I225-V, working on v3 for that initial=20
patch I sent out, I now agree that it needs to be reworked. Currently=20
experimenting with tracking frame position and these are the side=20
quests...
