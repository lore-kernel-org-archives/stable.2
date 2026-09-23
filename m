Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7D53B604;
	Wed, 23 Sep 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175271; cv=none; b=RJXeJYHneo4W/64IkBR142he/hZqlAGRoYeA1xTMUxZO3OiGuzCfjkTXQzHFENm/QJck5xXZ2OKjaK/IzU9Oh2fCpyK9eXPRMEQUbk6zhydDAXFGOJwjkTix/E928N5GKYenjRz1MRE/R9uA/JcP/onYiUDe5iKu79/YWJyD2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175271; c=relaxed/simple;
	bh=D53GyH0Tb6ROoRk8E1tIhj0ShQs6mzgmyconHj1dkUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0CgIyyWxavcIcHV2j0ZV/ws/U9dlVjpcyk027uH+6sHtaMIaw/X9Mw24zDqDqn5DrsFDKrYJm7JeQAQhMh9jJsOuU1r29JGfcY4XlnnIphfjIrTxNQ3ZMWlxIE3UIjsfYqC4jUEOcT7agqy8VavT/wkbmZYOkA7sRCZXsxzRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0BPuiK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0BPuiK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152C61F000FF;
	Wed, 23 Sep 2026 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790175270;
	bh=UgEqI04yL+VQM5M2VBuGJl0XwzPFtN6t4fu0Tj3qgzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0BPuiK0XBil6SmBlNlC3vBE0M3O2STfGE8/Vj6xo409s6JQ+jC/uN24x3QMxhykJ
	 kW66Pm5lzye3kO4iM7RM56buomGHrWLpnDbIQi6beU8CfyAn0trqtuoc4ScZA1jn+U
	 6q58/j/ZOZz5OZVx59YkhKEwGOkWgQmImpFdPbX7dzOWYEsDKkTuUfPwqN6EpvF0oX
	 D8yb2FncJPfjRQjSFx9+712YOFv/IK5/JugbG5zaDLYIOtWSKNo9XywkdPe/fiVIqk
	 lLYaQx+WmRQRkBXzXLAD6YbDERcbx/1bFtIB1lmwcC6HpWRSSquwcLQ+EQQXaieuim
	 mW807FOWJcEag==
Date: Wed, 23 Sep 2026 15:54:25 +0100
From: Simon Horman <horms@kernel.org>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH net 1/1] net: ipconfig: bound DHCP option construction
Message-ID: <20260923145425.GU13925@horms.kernel.org>
References: <7808dfbfa2162dfd0b19f59aff5742d6e0db2abb.1789798023.git.xuyuqiabc@gmail.com>
 <20260920072503.60706-1-xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920072503.60706-1-xuyuqiabc@gmail.com>

On Sun, Sep 20, 2026 at 03:25:03PM +0800, Yuqi Xu wrote:
> Sashiko reported the following finding on the patchset page; it has not
> been posted to lore:
> 
> > Blind copies in BOOTP extension parsing (`ic_do_bootp_ext`) cause
> > out-of-bounds reads if an attacker provides a truncated option length.
> > location: net/ipv4/ipconfig.c
> 
> This finding is about the receive path, not the code this patch changes.
> It is a real, pre-existing issue; this series does not introduce it.
> 
> This series only touches the transmit side, ic_dhcp_init_options()
> (net/ipv4/ipconfig.c:698) and the new ic_dhcp_add_option() helper
> (net/ipv4/ipconfig.c:680). The function named in the finding,
> ic_do_bootp_ext() (net/ipv4/ipconfig.c:919), is reached only from
> ic_bootp_recv() (net/ipv4/ipconfig.c:1156) and is not modified here; the
> diff contains no receive-path hunks, so this series neither introduces
> nor worsens the issue.
> 
> The receive loop is:
> 
> 	u8 *opt = ext++;
> 	if (*opt == 0)
> 		continue;
> 	ext += *ext + 1;
> 	if (ext < end)
> 		ic_do_bootp_ext(opt);
> 
> with end = (u8 *)b + ntohs(b->iph.tot_len) (net/ipv4/ipconfig.c:1078).
> An option whose length byte overruns the remaining space drives ext to
> or past end and is skipped. That is not the case the finding describes.
> 
> The truncated length in the finding is a short option length, not a
> length greater than the remaining space. After switch (*ext++), ext
> points at the length byte; the copies ignore it and memcpy a fixed-size
> value at ext+1. Option 1 and 3 always memcpy 4 bytes
> (net/ipv4/ipconfig.c:935 and :939); option 26 always memcpy 2 bytes
> (:968). When that option still satisfies ext < end, those copies can
> read past the declared option and past end. Options 1 and 3 do so even
> at length 2; option 26 only at length 0 with 3 bytes remaining. With
> skb->len == tot_len that is a real KASAN out-of-bounds read. It
> predates this patch.
> 
> Since the receive-path issue is independent of the send-side overflow
> addressed here, we have kept it out of this series.

Yes, agreed.

Reviewed-by: Simon Horman <horms@kernel.org>

