Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723834B04AC
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121082; cv=none; b=eaQJwikj7xE6FdpBBk7LBH/JNyH33rYN8ZGJzgYjE9tUwDqi7lzFl+a/4Rb8ZVbFO2I7lmE7QvE0rnNLAGOm10K121oKGamaXCQq8rDWW+GR7nAGPFTah6yxMwd3y++l87zkqClGnIRnIdoJfc1VDWQUZhMmPxF5L5lKhFMgtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121082; c=relaxed/simple;
	bh=+LbwcBxTcVL6TE8Xa7VF9oYYHSPpansJnznnqPEwo64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKYPLzzNVSvGZGE/+NszIpbqjovzqlx0BeLDDjZb7qJsb6TKl2NZUfWLcRDWh3gRX9EugDJ2OBZCPMlHPnQR1PcOlGTbwCq3cz2qMiXc5gNEQN1aaCyX0AH3cmWFFkFx+vjm8Y4RKMk63KH29SwuguLocgfiVhZHyBVWPiKAt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8PSHLQH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8PSHLQH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2244359f8f.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121079; x=1786725879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vPWw2J266KWoCzUTs7KvPsgaoOdOp2O33Cr+Xyu+Z4=;
        b=E8PSHLQHGw/j+CuTVIAUl805DcGbM3iUEG+Q0rGXNZncL7mb64gaQJxPAXW1c/IFDn
         WsVjQbdDOhlsEZW2eBXj/sjRb4ba5FyTwVEC+scdS+h4UdXwMyaSchYYUiOR/TfW4UXG
         GRUR0VVXHeTjsLzixoECwg9EJw+5t/hXyt0YhcX66bbdXZ8/B2NaA+ckz9vZqHhZ81o0
         htYBCUOCSqddVBGlb/pmmL0Qy3wIXiaQxyhgmvT3vVlfF8o4SKiovNP+oQFoBdkvlyDt
         OrPRdt6Ue/kK2nnr7i/YSLwmdIaHLeKfeVjJkzWUldB9KcepD8AbK5K0nfgasOasMCgu
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121079; x=1786725879;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vPWw2J266KWoCzUTs7KvPsgaoOdOp2O33Cr+Xyu+Z4=;
        b=pfp2pHqDFp+FIR5L5dhmCCHuGkYCwKQ7geHZaItIB0+YfXDZDlS+ATkxkVg0FyTEms
         w+SYEYE8gOnAGYY2ALkKPRp9c6Yf9qp9F91uvBzDn9IgahuorWyawTNbHgdOAL7H/oms
         ZtPIqC/UDJ0S2ro107oAx9EpzJrhkAjvOLhwjL/CaMJssP06i4fd0D8NmAbAQTdaR92u
         0f+9ZsgKXKMTD0Uc2SF9TqfBFDhhvoIyfQGOM6dAOYj0YdCK/Xv0mbpC6KMj5V81KaXZ
         sC0mGp1c4Cx+jCXWWBw2S5Ombr9EOx3sxqTM1F3ztHzVa9Df+uQttbSzDOqeidCin6bP
         YkmQ==
X-Forwarded-Encrypted: i=1; AHgh+RofnLaInL54goo/I1+tluzr7/kGEjjB2Gf6Y9DggbrRDM84zBHdSDwxJgeXARu+Fn3IRqwetvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2p8HstxLmCWtLMYuvv0vtHpigSZlg36seQ3LgyRGAw2vTgCKK
	NeIfS/vkeOpedKRJW/ioFqcpiscF4g68BBp3M+qWS9dpYuIvUxr+f3Cx
X-Gm-Gg: AR+sD13FRnR4NtWpVsj4SoXXjGFxSFFtxST9H3vV1G41Hnlm7ihcuRAQxm2MWrxKrvJ
	4ofmMGS7o71yW5QBfLzeWnJNs83QRhG/oO/aWoKEVGk8koXJ5MwiVvsZLuQNfLeF0SsZsr9+DqU
	rssbh6HCJNcDiZwvAJNwEa89FOYpu0r4QkYrQD189wAskpQbvkrfQyebb54wOjWtINr/zGGCAPi
	YbnEFGlgyyDCtem1eR8RCks99bdiYXNTmT/OTMJ8imb6uEA94zqvns7E0PbLsxzkMB2fQsflxbx
	VMvqezpzjGJNZoO/A/CIQcpeB4axEI2XFcUTUvBtDpqdrLEo9AqugfeoJ7RcBkYz+g4LiUPKL8O
	wdB/d9uXnM0X2KgcQv2jt6L0l2fHZjPyzdABnr0eRDfk5ViCyAu96ZLsMX9201mRN5N2fkcEyUz
	/76ZOcmlWWTGquEgN7aJ2N2EYxwAJl2yo6XnD8chVG4mWWB7rWfhvan80GbpSuXC0CndDD3HgM0
	cANO7W0XI0VsoNIOZOq5jPULZWvsna8Gq38
X-Received: by 2002:a5d:59c4:0:b0:47f:4919:d5b2 with SMTP id ffacd0b85a97d-47fec4e887dmr36634353f8f.1.1786121078631;
        Fri, 07 Aug 2026 09:44:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm7470652f8f.17.2026.08.07.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:44:38 -0700 (PDT)
Date: Fri, 7 Aug 2026 17:44:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] ipv6: mcast: do not write past optlen in the
 source filter getsockopt
Message-ID: <20260807174437.01bf2e33@pumpkin>
In-Reply-To: <20260806-mcast_fix-v1-2-bed0a5518e57@debian.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
	<20260806-mcast_fix-v1-2-bed0a5518e57@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 02:42:01 -0700
Breno Leitao <leitao@debian.org> wrote:

> getsockopt(MCAST_MSFILTER) on an IPv6 socket overruns the caller's buffer
> the same way the IPv4 one does. ip6_mc_msfget() fills the source list from
> the numsrc left in optval, and nothing compares that against optlen, which
> ipv6_get_msfilter() has already reused for the length of the reply.
> 
> Clamp numsrc to what optlen holds, as the IPv4 side now does.

Nak, same as IPv4.

	David

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ipv6_sockglue.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index b4c977434c2e0..2c3fbde7cb058 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -1012,6 +1012,7 @@ static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct group_filter, gf_slist_flex);
>  	struct group_filter gsf;
> +	unsigned int max_numsrc;
>  	int num;
>  	int err;
>  
> @@ -1021,6 +1022,11 @@ static int ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  		return -EFAULT;
>  	if (gsf.gf_group.ss_family != AF_INET6)
>  		return -EADDRNOTAVAIL;
> +
> +	/* Number of sources that would fit in the userspace buffer */
> +	max_numsrc = (len - size0) / sizeof(gsf.gf_slist_flex[0]);
> +	gsf.gf_numsrc = min_t(u32, gsf.gf_numsrc, max_numsrc);
> +
>  	num = gsf.gf_numsrc;
>  	sockopt_lock_sock(sk);
>  	err = ip6_mc_msfget(sk, &gsf, optval, size0);
> @@ -1041,6 +1047,7 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
>  	struct compat_group_filter gf32;
> +	unsigned int max_numsrc;
>  	struct group_filter gf;
>  	int err;
>  	int num;
> @@ -1050,6 +1057,10 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,
>  
>  	if (copy_from_sockptr(&gf32, optval, size0))
>  		return -EFAULT;
> +
> +	max_numsrc = (len - size0) / sizeof(gf32.gf_slist_flex[0]);
> +	gf32.gf_numsrc = min_t(u32, gf32.gf_numsrc, max_numsrc);
> +
>  	gf.gf_interface = gf32.gf_interface;
>  	gf.gf_fmode = gf32.gf_fmode;
>  	num = gf.gf_numsrc = gf32.gf_numsrc;
> 

