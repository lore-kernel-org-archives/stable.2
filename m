Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6483EDAC1;
	Thu, 23 Jul 2026 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792579; cv=none; b=MPTb2iAWmzMk/S4i5SdcyBfVhV0hxRm66yiQcgth7D/0OWpEnm+HQF6njyHGoRFObb0yJXwaI++AXIWPu378SY1VRQ2KEn9rSylA+lWIDkE0TvSZhW+p0GpDBSbO9zzjrpn9dhrLjSjB/u6+XkEzZEUcIgx62s9PA7RA8WE1l9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792579; c=relaxed/simple;
	bh=JcH7xcNxpCwtoir8saF231m7/V1ayCGzZANfcju97FE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec9cCrQPusHNTdQmJJTqnhrTkbqr+SMFH+9041wBF9DAB8mYpvs1gfFxxQHqa3YwK6x1RbN+6tFBg7FZJfspbl01YsIfDFlPTIbJmM7ZMAQsGm2IZADTemhSFLarZyu/PM3tegCWII+NdO3SstouPmmyMpemPwlpHDr6W0YCW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LXLZr5ce; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="LXLZr5ce"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2DD8D2084B;
	Thu, 23 Jul 2026 09:37:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h2O-s0Gejwjr; Thu, 23 Jul 2026 09:37:07 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7647D20539;
	Thu, 23 Jul 2026 09:37:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7647D20539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1784792227;
	bh=Cq6ifACW8/pbqtLzoZVZzOGTcnZIvTZULp+V6+NQzcg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=LXLZr5cexU8SyJCjbKAIIjnjh7R2GeSBUKLmpQDBL023C8ao9JOPY1a3sIrPr/Tzy
	 urp8RDuCjjKy3fxNPcYbWikKR32NB2MsaXfhf+/+4R8KimPbFM/nzayZCH9I4M9WwF
	 fgcXmeum8SlYWo7TuODYgVvSJy1RNRiksPwz5CPyMj3PAZxkbPdvG4/cJeTI7fuq4d
	 RS4tlWB0BoYhMD3LrjfWQblTRWRkCrUc0digEcJGI7bp/y3Kga4v9Rh7uCv8tTNlix
	 OTRrFCyz+FjMQWm647ork8FgSc/WIJwE+U5BaBQKFcxx25s4n+jbJxRcjR3GWr1SO5
	 +sCB/AMHwKAsw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 09:37:07 +0200
Received: (nullmailer pid 1131036 invoked by uid 1000);
	Thu, 23 Jul 2026 07:37:06 -0000
Date: Thu, 23 Jul 2026 09:37:06 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Breno
 Leitao <leitao@debian.org>, <stable@vger.kernel.org>,
	<zdi-disclosures@trendmicro.com>
Subject: Re: [PATCH v2 ipsec] xfrm: espintcp: fix UAF during close
Message-ID: <amHEooLyd_Pm_nc7@secunet.com>
References: <a62857f72af228a0781a5c0cc0f8d898d9e0d7be.1784234935.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a62857f72af228a0781a5c0cc0f8d898d9e0d7be.1784234935.git.sd@queasysnail.net>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jul 16, 2026 at 10:54:59PM +0200, Sabrina Dubroca wrote:
> ZDI reported and analyzed a race condition during close for espintcp
> sockets:
> 
>     espintcp_close() frees emsg->skb via kfree_skb() without holding
>     any socket lock. Concurrently, the xfrm_trans_reinject work queue
>     invokes esp_output_tcp_finish() -> espintcp_push_skb() ->
>     espintcp_push_msgs() -> skb_send_sock_locked(), which reads the
>     same skb as a data source.
> 
> Fix this by adding a synchronize_rcu() call after resetting sk_prot,
> since esp_output_tcp_finish() runs under RCU and won't use a socket
> with sk_prot == &tcp_prot.  Simply taking the socket lock in
> espintcp_close() could lead to leaks, if esp_output_tcp_finish()
> re-adds an skb in the slot we just freed. After this, the existing
> barrier() is no longer needed.
> 
> Cc: stable@vger.kernel.org
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Reported-by: zdi-disclosures@trendmicro.com
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Applied, thanks a lot Sabrina!
