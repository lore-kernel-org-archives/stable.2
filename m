Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34094521228;
	Thu, 15 Oct 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068933; cv=none; b=Xm2ToKX36QVr3Qb1GykmQTyIkPz7UeeQfpYdKMKjkBWY12uBW1Ca4MCLMZGqcZ/jzDb0WpOS8YbjQEQLW+HcIwujzCoQhw2u8OBjE4UBpP1RtiGOgTEwmORr946V3+axzlGIEappy9ajhVS8NqrieVf5cqv4VYNpxaumLvgkh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068933; c=relaxed/simple;
	bh=7DBp+1phuyFtsy9CKcOsQZlKRPdN0E+MHLNqjGsXSLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS6yV9fg7Ghr4/7VpYzcJjHVs3bP3F8dNKoQy/VtrBX5rp6sohBhMUu325Q7X7qZLmUza5Aovm1s/jHoUMoL+80l1FzdRak2ahHtbC5V4re1GCeLe0G340P0SOekwHRwxFb9Yn7FjIhvhJzmlDC71R33jlyy3I4zPQKlz2BCNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTiix9Xg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTiix9Xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FF31F000C4;
	Thu, 15 Oct 2026 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068931;
	bh=clp57vnClQVP+nCheYCqZXPNnTl55WO/xc0j2+TAHUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jTiix9XgOAqINvZR6bBWHZkWxkukxvVWHBigSvYyttYP4WCdUAK3ug6NfdyHF0Xom
	 6CElzymUseQSn99vTklK0xyJoKCdJuC4jKujZlICBkJwe4umY6OUwcelJmMWNaAPW6
	 xmfjAGsw+JX8kt0coGIqQ53dWGbaZx/OqBuCfdNVzw3B4wcTlDBy3T27/AMrBOX4GX
	 YoV2lgw8DQkl9/aP3/rzA8p1yOg4nlnL4E3I1B+IMSYTZ0GeM6aotR8vbEtL2fXA0x
	 gquDnP9jiclizoXw09TJTXFFnKduBNvMQE/pEKRLQGV7FV8okTDUV/6gpTRTSL9W9q
	 MoLASdh0CoWUQ==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.ams.internal (Postfix) with ESMTP id 98E18198004A;
	Thu, 15 Oct 2026 08:55:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 15 Oct 2026 08:55:29 -0400
X-ME-Sender: <xms:Ps3QauruKha1RaTfSbJorefQoWrO5sC1GZTxGDEtT6iwvRfoXTnxNA>
    <xme:Ps3QavAbGBJLEN6dY-z20ZQ6DtGwyMVrPgKtNQrxjV-a_4_Myh7Pmbz94QaVFS-Eu
    vmiA7kGkPTVTYeENlib_vXjh2JE4EV3TaWejBE3zRlVm9KElicDjAA>
X-ME-Received: <xmr:Ps3QaseGMDjM_RzxtK5GG3WzyCjra6Si_TRxn-EASt6Gg2a6jyWWK3JrM6M>
X-ME-Proxy-Cause: dmFkZTENeah5jCyIIexJsBjsOW84TqH2gO5rqiAOue2liPsjxhJZVfheu5qG/L9bNI7vZP
    O56axSZ1Wv+bTUUudMcDhq8xMBTsA7tgGR/i3ipoz6XNgpJ8FASKYlVpoWG55dt0ppMuMe
    c9UrZ/xlGXys176GvhcEKtHQ/ed0Rj8PJD+28gZatuRokFMbBB1hCyDumbQerfaqidDsU9
    9h31i+E4VRHRE8eXq00ymlPNkbhhutz5ixoC1ggrRIo6Jb9JjFLIHyGaOOqdgQtzmbYv+M
    VI3K/8qaxFK/Fezlj/6k3b3fWpdpMMzbtWmoN+b3zurRSSR8fiqqa6hkYACGX4hI3WgoPt
    IirMy5el1faMQe1WSd0dX9YsMwuu5yeN9bde+mswRyZSJKUDjBlnFQSe8AJJ5ywzeDEvEI
    aGnUbIMhtUFDHoOwLND8Zb08YrUQU21VVlWqXe/A5IcMcYZn0oAujblX+iYCNNyuEj7lQL
    Cy2ESt1imr0U35qn3Tb/p6kjom1TAS7L/mwHMDO+NDSTb867rANutnqTlXYDz0HMmilFUJ
    3CfgqtLOYct/PZnalIpHy+/41L+LY1Bo1MSpO8UFb47vo+Kvjr5KnQjRjNqfd12rWpoWS3
    FhunUymkYp9bH229QCAlwcww0dzWLmJ4t4daxRfL2nkJT5ua7SC1q0RtDpOw
X-ME-Proxy: <xmx:Ps3QahDY9OLuq4Lvb5ErDpmJPkc-ntt6m5HfzKAf_cwYGHr-vtHSlw>
    <xmx:Ps3QagRokeyqCDKS9Jozm5Fc2a-hFwELMmlV99lOPj_JVTIXwkhi_g>
    <xmx:Ps3QalcR0uZZ_zK5Dv32EWTxhRkvmoZLTPh11jjmBfbipPPVpVKTMA>
    <xmx:Ps3Qajoi2LZk8-4njLtYjq9AisXNOOdY5kyVToTAVtJd40WLKewlZg>
    <xmx:Ps3QalbxEL27mxEe6tb0xbg8C-QSzpxw4S6szaBMM0dOmOjW0So4a51i>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 08:55:25 -0400 (EDT)
Date: Thu, 15 Oct 2026 13:55:24 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <atDMN5MoGrwJNpAj@thinkstation>
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
 <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>

On Thu, Oct 15, 2026 at 09:16:36AM +0200, Vlastimil Babka (SUSE) wrote:
> > And agree 7.4-rc1 with CC stable is fine. Sadly, not sure if anyone
> > but Meta is using the feature right now.
> 
> I thought it was there for a long time but it was only added in 2025 :) At
> least the enterprise world is slow to adopt things, AFAICS.

I was thinking to propose a patch after merge window to make defrag_mode
default. Do you think it is too early? I don't think it is ever going
to be truly stabilized without wider exposure.

We also discussed with Johannes to make a stricter (defrag_mode=2?) mode
that will not give up on fragmentation ever, but OOM instead.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
