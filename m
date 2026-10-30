Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345772;
	b=a09739M/P060ItDYCtyCUytSZcHM+aXEBr0dEoLgvAQ+GiseDiywJNv0zNykch0Facy4
	 WBk0wCMbeoa0pfn9WI4I0RCeD+11HoAB+WnBpkVtPO3273ohb8xV6uZCsLzJpRbP+ta0x
	 6LF2N0FFWF0akiE6C0KcbEh01H61okkZnJDqD7pva7sc3IJ8yuSeepS5TC8uhiLhdI71d
	 R6ADArmm4p3HQ8tPaj836sC01DR60zcQizdM31wkIHoaYr/IsAnoyaXZ0DkRTj1swLsl3
	 hAlfvJkXOd0aTVcU3nY8/jMMgHnCx8NPbVcZIre1UvnpkiDR0Dn2HRNFzNp83z4rVbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345772;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=EVail0s0Knj5AFc/cqCHQNkhbQFgYUKUKXlSh2CcfVo=;
	b=OXu3x3iIr7g2qfaON1DW706o0+fpAOFVW/KT6e5LaQyDcQEBnUQpoPq0BuRq+uLLg/Kv
	 Bis6Kz0QIWM36GyUcHFcqKwt4ivcImmunKINlPxDou7z8XFdSn5xf6SBRsAY3r0+ajcLe
	 EZ7+q7KVaF6jbK/wC9FahvbwH94P9hZaQ9E4hfOCl5CbV/R2iRY7+ubZWLoHA4MdgHDsI
	 8ktICp4Zlr51SLPBRXjw8UCw7b5/FrwotDFbjcp70KB2xVLCt6JDH/dG5vYy4gcoZ88RH
	 8OIOxfOf7PeAjgfNlu7XBx7i6Vu4Q4yMTtks6PGzX45e0p5UFBN9tYzgm75ZYMyelBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b="rizL/E9T";
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DB606A31A;
	Fri, 30 Oct 2026 07:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 149DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=rizL/E9T
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2B4D5208B7;
	Fri, 30 Oct 2026 08:36:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MEBiz5BhQybF; Fri, 30 Oct 2026 08:36:01 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 44B552083B;
	Fri, 30 Oct 2026 08:36:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 44B552083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793345761;
	bh=EVail0s0Knj5AFc/cqCHQNkhbQFgYUKUKXlSh2CcfVo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=rizL/E9To/XigvGgBLhOlA/r0YGVkJe4IjaA67XfG1PhDIQgTTIzXN8RiDtCOcpeM
	 Jr63ZKX7Z5oUONx1/rH0sgzgZ2yZV2OUJ6TBUT/PtJUPyH+2HieqKxVo+hw0AUZgNc
	 hwWVxd6hdbM59u65Mqz2Dcx/eIvpkXS8aZklN0Iau/pSCf4RuTc+TMQiufjVgoHvTY
	 ePZfFgXyvVXHGbz2W0fGPhmbg2wvB7pkgd7fF2hLfNqCHtlEDku2ByRqgMWe9k8hLp
	 xecWS6und7UPFGgj+ET7hlRxNtBGBqFMdcJEoMOxBEIT8YrI4hvab0rTTT/01/mfiw
	 skTbxMjzOxAIQ==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 30 Oct
 2026 08:36:00 +0100
Received: (nullmailer pid 3372523 invoked by uid 1000);
	Fri, 30 Oct 2026 09:36:22 -0000
Date: Fri, 30 Oct 2026 09:36:22 +0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Fourie Zhang <littleddfu@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Zhiling Zou <zhilinz@nebusec.ai>, TencentOS Corvus AI
	<corvus@tencent.com>, <netdev@vger.kernel.org>, Fourie Zhang
	<fouriezhang@tencent.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH ipsec v2] xfrm4: use a full socket for local errors
Message-ID: <auRlFmn9TurvAhcS@gauss4>
References: <20261022022627.4132880-1-littleddfu@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261022022627.4132880-1-littleddfu@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Oct 22, 2026 at 10:26:22AM +0800, Fourie Zhang wrote:
> From: Fourie Zhang <fouriezhang@tencent.com>
> 
> xfrm4_local_error() passes skb->sk to inet_sk() and ip_local_error()
> without ensuring it points to a full socket. TCP SYN-ACK skbs can be owned
> by TCP_NEW_SYN_RECV request sockets.
> 
> xfrm4_tunnel_check_size() already checks sk_fullsock() since commit
> 1620c88887b1 ("xfrm: Fix the usage of skb->sk"), so iptfs_is_too_big() is
> the only remaining IPv4 caller passing a request socket here: the sk it
> tests is the listener, while skb->sk is the request socket.
> 
> When IP-TFS rejects such an skb because it exceeds its payload MTU, the
> local error path treats the request socket as a struct inet_sock. KASAN
> reports a slab-out-of-bounds read in ip_local_error() beyond the
> request_sock_TCP allocation.
> 
> Resolve the skb owner with skb_to_full_sk() before accessing inet_sock
> state or reporting the error. This maps a request socket to its listener
> and rejects sockets that cannot be used as full sockets, matching what
> commit 6973a21ee73c ("ipv6: xfrm: use full sockets in local error paths")
> did for xfrm6_local_error().
> 
> Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel.org/
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>

Applied, thanks a lot!
