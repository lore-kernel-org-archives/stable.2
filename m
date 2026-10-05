Received: from smtp-5.sys.kth.se (smtp-5.sys.kth.se [130.237.48.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482043F8C9;
	Mon,  5 Oct 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.237.48.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193759; cv=none; b=RrYOfao0kE1JkSNLjy+ITwp79BJudA4Jx9XDILUyNk7jMTd1ZMtEEJofVBND358ooELbvpU0kXHe6BEgpx0WIJmVPtju8LlKAlVtEiaReJqdhLPRGzVl3ky3JHFiJIJuOZWs30bkIpxH3hLOXDb1AvV9fSRHiX1aOLUM/riYgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193759; c=relaxed/simple;
	bh=CkglMlUP4NpYuHrM6U1EbQ8jrt3KGi1JcmxfTf6Gpk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJDRpSjjKLiA0SoP/+sX+oarO7ucOFugXLqIl43JWXnotkoaTw/xcAmLCN8PIeQtLqkFzKFWr52s4A0hFAZGx4ByI3/dHkJy8t3qEhW9GNsWLw0bY5K9wkrfGG3WnC+xqHzon1wAUdQVw+zdbvuafyjYYUODSUnhgOot7VrTOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se; spf=pass smtp.mailfrom=kth.se; dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b=FM0Waqp1; arc=none smtp.client-ip=130.237.48.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kth.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kth.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b="FM0Waqp1"
Received: from nargothrond (host-95-193-142-68.mobileonline.telia.com [95.193.142.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sfle)
	by smtp-5.sys.kth.se (Postfix) with ESMTPSA id 4hyvjb5vqZzPNPw;
	Mon,  5 Oct 2026 11:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-5.sys.kth.se 4hyvjb5vqZzPNPw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
	t=1791193750; bh=CkglMlUP4NpYuHrM6U1EbQ8jrt3KGi1JcmxfTf6Gpk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FM0Waqp1m8lV1xj87nCHk2YotDUaGQhX7AqkjqWQJAkLjsoaJsGBlQFn72KNrkdeS
	 4kdllZz72xi4QO/sVjsILinRg9X8yLVBU6wXUA5jRpoIgArOQbYrbfzpl0aj5N9Hja
	 nQfJkdTBw2tjcvzOYYrYFb0QJKzGFjD4nKFOFzlc=
Date: Mon, 5 Oct 2026 11:49:05 +0200
From: Stefan Fleischmann <sfle@kth.se>
To: Michael Chan <michael.chan@broadcom.com>, Eric Dumazet
 <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, stable@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small
 packets
Message-ID: <20261005114905.36ec94eb@nargothrond>
In-Reply-To: <CACKFLi=ja544ms39JMwaAdiyKzzDAUFxSFUWETh6kfzQmcj4dg@mail.gmail.com>
References: <20261005023812.130639-1-edumazet@kernel.org>
	<CACKFLi=ja544ms39JMwaAdiyKzzDAUFxSFUWETh6kfzQmcj4dg@mail.gmail.com>
Organization: KTH
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Oct 2026 21:14:31 -0700
Michael Chan <michael.chan@broadcom.com> wrote:

> On Sun, Oct 4, 2026 at 7:38=E2=80=AFPM Eric Dumazet <edumazet@kernel.org>
> wrote:
>=20
> > This issue was exposed after commit 447cbe95ebb9 ("vlan: fix
> > skb_under_panic and races when toggling HW VLAN offload") because
> > reserving extra VLAN headroom rounded LL_RESERVED_SPACE from 48 up
> > to 64 bytes, shifting skb->data offsets and potentially causing
> > small frames to land right against page boundaries.
> >
> > Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in the
> > normal_tx path. This ensures skb->len and skb_headlen(skb) reflect
> > the padded size so that dma_map_single() maps the full buffer and
> > the descriptor length is consistent. This also removes the
> > temporary 'pad' variable and masking logic.
> >
> > Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Fleischmann <sfle@kth.se>
> > Closes:
> > https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/
> > Signed-off-by: Eric Dumazet <edumazet@google.com> =20
>=20
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Thanks a lot! I am testing the patch right now on 6.18.55. The system
is already up for two hours without issues. Before the patch I couldn't
get past 45 minutes without hitting the IOMMU DMA read fault.

Best,
Stefan
