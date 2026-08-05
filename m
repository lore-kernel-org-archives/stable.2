Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EE1DB356;
	Wed,  5 Aug 2026 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892137; cv=none; b=pmLV+/33cAgv5D1YGZFXlkswoskvPxzqNFub07DiQHSedDdXUd4AQLPmlC0LFLCdjcX0yLrn4cUmB5Pmc2ZWb53yFU1XWWrVCSZ8EkwLVZjKSvPQgYB7NafIXyhQnT0+QRHuuJq92aVWUq0jQyHJK/ZnGgm54+lG3XUDFnW+vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892137; c=relaxed/simple;
	bh=KyXC8feuaEwiE1v+rtrh60OPMmURyZRg6MbrqQMoesw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJJssS7NYCX5f20GFGQGuSkWmf1OveUs/R+VSYqe8RvqM7LWAhI3zr4hMZwYwfsjpgNkX1/k+c7E6gPr9TbjgWo094tgf6LLRgZAb4StHSEiEHHlwCG9VYTw064i1qNFS1kcTC1U5TOcZwNisoInemEcjGyn6jUqPzoJR8Y2PFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpZy8BYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpZy8BYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EE01F000E9;
	Wed,  5 Aug 2026 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892136;
	bh=KyXC8feuaEwiE1v+rtrh60OPMmURyZRg6MbrqQMoesw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OpZy8BYYE8/75HpczToCOwF6uDp/BCRtjhwyM5VnMGtnXEZHzVp39YOhuvcCHwmbk
	 yaUUuUv000v/y46BaeiZi+y6UjxF/xjakjzl8QVisqKC6sqpUjvTIC6c9OLeT+S2Og
	 L2uTD56Xkgrs4I/wHlKiJ9cqyfjMgcBrs5LZQ90OTkc99WsSNYtfTV4L+7HfS9AjR4
	 T2wTwr+QsqRhKLi3N44Argiz4wNFfLCj45gyVas8rXKG3EWdSUBGY31QgjC5KDypTX
	 wW6IXnNvJbVYhdoEZl2qEFGRDhZzVA/7GkgkvsSAmaQsI/bXIDrYyvMUxvBluGjsxk
	 0ERkmg/mXIx4Q==
Date: Tue, 4 Aug 2026 18:08:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@ragnatech.se>
Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 masaru.nagai.vx@renesas.com, sergei.shtylyov@cogentembedded.com, Xuanqiang
 Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ravb: fix use-after-free in
 ravb_get_ts_info
Message-ID: <20260804180855.75f6c91c@kernel.org>
In-Reply-To: <20260802121727.GA2716708@ragnatech.se>
References: <20260802090750.116215-1-xuanqiang.luo@linux.dev>
	<20260802121727.GA2716708@ragnatech.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Aug 2026 14:17:27 +0200 Niklas S=C3=B6derlund wrote:
> > The PHC is registered by ravb_open() and unregistered by ravb_close().
> > However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
> > clock. Since the netdev remains registered after ndo_stop, get_ts_info
> > can still pass the dangling pointer to ptp_clock_index(), resulting in a
> > use-after-free.
> >=20
> > Clear the pointer after unregistering the clock and only advertise hard=
ware
> > timestamping support when a PHC is available.
> >=20
> > Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn> =20
>=20
> Thanks for re spinning this,

The AI reivewer has more comments, but at high level - why unregister
the PHC when the device goes down? The clocks stop?
