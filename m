Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BF4CEE45
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978555; cv=none; b=RAuN/rys6q6hlORH6YxZ6YWxYFgy7OdpXlPybyvh6p5wqflW/XPLPOWBGBlb69vSpdUQd4HHYBFNosV/JLHpBn4DJvrdba+Al3pufBvNUys67PuSfIGcGKmjhu+x0goBW6gfA9A1XHa4j9TLkdf/dkmrfZJoGFtPrmzIh0ggduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978555; c=relaxed/simple;
	bh=z8r4MRtUi0LNk7lRzCoa0ekWmE4fhmo2OSQMOtBUgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjwhB58yDIt5mvl8tdAw6yWDl98fWMdgUHFrCSEHgoGcj/5FCRxM+dWGsJzxV5+PvyTHCqpnNGJ/N0tYrjkC58hwdSCdEGhS5zCxq+SPra7HPkoZJLFXm3VZyg1R857ovR+Hm8G/0FgNO9kUHZz5V89xSpKBF7JkId+bVCP5AaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=N23a4QPq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsJpoFog; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="N23a4QPq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsJpoFog"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB9CB14000AF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:49:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 07:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791978546; x=1792064946; bh=ljC1EWPWgR
	PS5tUHzsiAKUkPoihH7ZlQU23a6W9iHaM=; b=N23a4QPqTIewXlHX9ZszNsRyaq
	KDk5THBTQPf9OLUHbQc4Wcehe6S3A5fym5r9fd00o6BowcsFoKaW73aIRdgD3P2z
	KJ6S8KGY94vChChxK2cen2ijs2J4GzhMaGTUIEvJWd3/swgXoYJwCJjx2jSY/xAU
	NB3RMwsDSZLm0Q/lssr9ouH0USAR9cgCZJaNREfQk9cg/ZSCtSnEg890ne2X7cNB
	FfdPh6CTBNHc+vWXWOINYtrFDgNXyxk/ORhQ74/kzA4qgI1cdhkoMM4cLTJx08WN
	Zvl4UIqJ9LbM4JXJIhjmia4+V9g+1Mcb9w/Ua1jsh5FAAvdIieN9t0WBqutQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791978546; x=1792064946; bh=ljC1EWPWgRPS5tUHzsiAKUkPoihH7ZlQU23
	a6W9iHaM=; b=SsJpoFogEkA+tO5b/0cjDz3BuyNIbNkn6CUDHXdwGSYbQm4dyP/
	MjiJ/XTLWnKJQLCh5ZE6E973SrPLUgs5GY6/CKurl49HTF8Vv2bQ6UWiRuChBdel
	cNTHVJRdNy5TwG/A1mkLjam8u+guR4qT0N80B+8p3P3TVOEz5c8nFYw+n4YEbSwd
	smhZ7TiNDnG7h48eWJEUoYfC4FmVVUQ+GEUj6nBzyCuBGqZflvMxX8eqEa/LL4Dh
	cgRDBz31kxqcVLTGoW5UEl6FonwU+TZRRlLglyd+5ojgmHc4cz/wfa50v0ZYBrtC
	in4iVNOKlctHg9efklSL2EN+EmWcgAt7dQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791978546; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eSTXIDzOWLiZekTj5TFW58y9j1C3qX2aJlWYtNIPWM3SvWJ
	cSDDQoNE4xDS4t506rO6MpPIAsaSXT5rqAZaHxSmHfUuD9Ym4VfVkAaY/eynOZDO
	sMCQYMfOaiOAM805Bm4NF6RsCsjjZPMzfWzCKy5s97mTSgiJK1NaSAIgpy6lscPV
	M5SRxkvOk1CoV+vFu766Tmbr3NmTbiIvt0pnNZRiUjS1MUf2FsCvtUJuFNuji2rI
	hgesJsbU6vrYBPBH9w7w1cbbhXxWvcvBe2w0hojDjvvnEp13BkPN+2YgA8583bZZ
	0ZCXWFwJ0EGLIDo+WayeQ3XrAhop/JNpt+HcILg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NXqvzbL0EcVKcRouoKFLpRAfiCZ+PZx2mcFB+LVfxPc=:z8r4MRtUi0LNk7lRzCoa0ekWmE4fhmo2OSQMOtBUgZ4=;
X-ME-Sender: <xms:MmzPameWf_PJcdl_rjQhk9uJ5MSlJqRy8becgbBDPU0YnwvLad5Q4w>
    <xme:MmzPanxj-Z1HmhJsPZQcGKoXtDYrDhH5WB0keUdbAdKzBJgMGgqeg2R3PUDEimiVQ
    1iIaBLeroS3jov8d0yF-o7AYmeL9GEVYvJUqmrVI_Rj3q8FnRw>
X-ME-Received: <xmr:MmzPanLOi6t4eNWWsTgrDhEO5zHSmIG_u5EUciwgD-k1UxSWBq4BMnU9UGu4wSUUrMBzLDisQ15IpB9OSa9R60Z99S6T3HzuKrut4qLLJLI>
X-ME-Proxy-Cause: dmFkZTFVeTgRVt8VgVVuURS2y6F5bHP7SB45kgAV0kCKhyd9ylXqJwTwTvQiC9dcAZHsZi
    Gzm+qOu5tvWIrxHx2wabEmTkbqM3P3tmYKUrsv7fKbngo2A1CSxt1+W66E2w1AOMbrw/44
    /DuO2vurJ8PdA2BlrizzP1+17Z0exNBIjKuR9CJMOeG+yPX3kdWzUtl3bEqrCMbrbuZxy5
    cU+BCGpxGF+D2a3Lzk1jE6/Hg13tLZBeYPZ24aKitB/vGGmHm2my/WeQPKXFqm41W9y9o/
    kfkwBDUcCHEKKwmVv44NAqBrqms/zQWhszG1mXfU503Umoc16Scr+LVhmzcnElsrlXmNbZ
    BN1xzR/L1QALRiRIjjHKeILJP7hk9NR8fi8urAlsL9Yd2pFIj8XJK+0NRkRVR2a2fe9OoG
    ZF81uS6E6JhxsXj5yph4xU5G5mp19UrX327WpmCrqzx8tIaxSmSNIawn5VwQRpSHBklzz1
    ILOMwSTlm/7HoUS1MHj53utuHYOWZyKjoYwU71JW3QwQ0LsCi4iKJ+OmZVCKEE+9MSK2Me
    A4XL5Xv0UZIi7x59RGNs0slviFZqKmZOQ12s/noV1wu4Z9X7zmW9vnQ30EnhC2j4TVn9g/
    1uCH5NVMk475dW0YKgrrQbLhEIZKMLYPJhc0ic7kgV06ei1s7iagcR6OyABA
X-ME-Proxy: <xmx:MmzPaguyzIagqBPJK5lCiOS5dYZqijTcxVuZoo9GyqP4_yb7f_alQA>
    <xmx:MmzPapQ4kw1vl1-10HVBMG9rqVy5oclyB43tFIoCmZufAEphrt4AoA>
    <xmx:MmzPahRNemxzYHX6tOPYjDaGK6uMu4i6d4-XzAYAxNZpONHSzcoSyg>
    <xmx:MmzPalrlvu2b7OMy9N5m2x1n8TWAro6x-B-_RoTejnfL3bzLJyXTug>
    <xmx:MmzPankJpyqJwFusYsMiEFrgPhGGozDou4tKMQ4Z9rScsNlGDDrzGRMf>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 07:49:05 -0400 (EDT)
Date: Wed, 14 Oct 2026 13:49:10 +0200
From: Greg KH <greg@kroah.com>
To: vienna-0FFH <viennaoffh@gmail.com>
Cc: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com
Subject: Re: [PATCH] dlm: don't warn when closing a node without a connection
Message-ID: <2026101400-roman-landmass-d03e@gregkh>
References: <20261014090237.395-1-viennaoffh@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014090237.395-1-viennaoffh@gmail.com>

On Wed, Oct 14, 2026 at 05:02:37PM +0800, vienna-0FFH wrote:
> Opening and closing a configfs comm entry without ever configuring an
> address for it triggers the following warning:
> 
>   mkdir /sys/kernel/config/dlm/cluster
>   mkdir /sys/kernel/config/dlm/cluster/comms/1
>   rmdir /sys/kernel/config/dlm/cluster/comms/1
> 
>   dlm: closing connection to node 1
>   ------------[ cut here ]------------
>   !con
>   WARNING: fs/dlm/lowcomms.c:1455 at dlm_lowcomms_close+0x12d/0x470, CPU#1
> 
> Since commit 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
> the lowcomms connection has the same lifetime as the configfs comm
> entry, but a connection is only created when an address is configured
> via the addr attribute. Removing a comm entry for which no address was
> ever set up is valid and the resulting close call has simply nothing
> to do, so it must not warn.
> 
> Reported-by: syzbot+04dfbd15d442517e713a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=04dfbd15d442517e713a
> Fixes: 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
> Cc: stable@vger.kernel.org
> Signed-off-by: vienna-0FFH <viennaoffh@gmail.com>

Real name is needed please.

thanks,

greg k-h
