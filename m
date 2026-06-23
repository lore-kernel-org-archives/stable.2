Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF2379C23
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214864; cv=none; b=rEZH98y8wNUd3mvGJ219bpbJeQ4BOiPfW8xG7hcPGoJmcck5qB7NdXJqsqFw2O04epjEyn13hlwnzYUaiZeNCJISofNLa1WlGnJRCLKxDgSTyanhpjYh/Txq0/UNrXuXLHUVlYpd+BQuQkTY8lfGknBiNP6TdFm2hmqjSGhbEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214864; c=relaxed/simple;
	bh=g8jduOyiWy0B8mnnrt/rrd5sTEje8WVrXChbwVgRBQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzM+0SuHFq6LMMrAMif6zP/q6u951laQJYGAPaWWnU1VNLJf9GfZ0RvuSUURbra7xW/9s4dctPOEzmdcAi8wqXY7zwshz0ygH2fxEfaPaDoP/iOaWi54dHgppdxvu2+v/uykWdJhuP9tkibxNG9AIxZXnqlG/zpx2GgynqKB7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaTs0w2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aaTs0w2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D561F00A3D;
	Tue, 23 Jun 2026 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782214863;
	bh=dsaYxsMb1EimdZ98sPE2h53JZZwh4ERS19yygJ6FH38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aaTs0w2zqzSMl7Rf3DeUMrWURyja1HP88bR3ExxbGB3UVVXr3fU/D6fumNNluxalY
	 RK3/lSzpJ4wUuKWvalug3KVSn9/d7asHq7hHw//1h8fmz3pwZQaC2XlZeCMMxsFayY
	 Yl6jfoei5KrzoSQV/bgJ9fP8wFjjYrhOg0k3GjXM=
Date: Tue, 23 Jun 2026 13:39:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Pratte <slatoncomputers@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] s2io: only arm hardware LSO for GSO skbs
Message-ID: <2026062327-unengaged-apostle-5728@gregkh>
References: <20260623112131.752148-1-slatoncomputers@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623112131.752148-1-slatoncomputers@gmail.com>

On Tue, Jun 23, 2026 at 06:21:31AM -0500, Michael Pratte wrote:
> s2io_xmit() enables the Xframe/Xframe-II hardware LSO (TCP segmentation)
> engine whenever the skb's gso_type carries SKB_GSO_TCPV4/TCPV6, and
> programs the segment size from gso_size:
> 
> 	offload_type = s2io_offload_type(skb);
> 	if (offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> 		txdp->Control_1 |= TXD_TCP_LSO_EN;
> 		txdp->Control_1 |= TXD_TCP_LSO_MSS(s2io_tcp_mss(skb));
> 	}
> 
> Since commit 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
> tcp_transmit_skb() sets skb_shinfo(skb)->gso_type unconditionally on
> every TCP skb, including non-GSO frames where gso_size is 0. The driver
> therefore arms the LSO engine with MSS == 0 for ordinary TCP segments
> such as the connection's SYN. The Xframe-II LSO engine treats an MSS of
> 0 as an illegal descriptor and aborts the transmit (lso_err_reg reports
> LSO6_ABORT), so the frame is dropped before it reaches the MAC. The
> result is that no TCP can be transmitted on these adapters since v4.2;
> UDP and ICMP (which never carry SKB_GSO_TCPV4) are unaffected.
> 
> Only arm the LSO engine when the skb is actually GSO (gso_size > 0),
> restoring the pre-4.2 behaviour. Non-GSO TCP frames take the normal
> transmit path.
> 
> Reproduced and fixed on Linux 6.6.67 with an Xframe-II adapter
> (PCI 17d5:5832); bisected to good v4.1.6 / bad v4.2.2.
> 
> Fixes: 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
> Signed-off-by: Michael Pratte <slatoncomputers@gmail.com>
> ---
> [ Not upstream and cannot be: the s2io driver was removed from mainline in
>   commit aba0138eb7d7 ("net: ethernet: neterion: s2io: remove unused
>   driver"). It still ships in the 6.6.y and 6.12.y stable trees, where this
>   bug is present and the patch applies cleanly. Please apply there. ]

Why not just remove the driver in older kernels as well if it is not
being used?

And if it's not being used, why is this patch needed at all?

thanks,

greg k-h
