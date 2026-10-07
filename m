Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787C547076;
	Wed,  7 Oct 2026 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355721; cv=none; b=q79naEgOCU4YWL+EVrqV7uR9rqlO0EECkuqmBqRTgqCWnyLSrpCsRW4Y9ioDdWjsn4k+rXvu93QdDxdUsHL8Mszs5VzKgLVk2fOyuImkUVwbua5+nzakBDulqQVG3ZDBtr4GPMfZrvqtBSg/xpH/uHq33UcFace4KYKCs4FVgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355721; c=relaxed/simple;
	bh=R1PBjr/KTJ4iL34W94AE3eV5wrZGeENrOBlhRuNyMUs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H33HCCTYnhTA0RAqNKvuBFMZqb4S1e6n8lR4Cf3DGr/a2hBV8miKmOu/oXy+84pjnJ9B29XMR4pYugqoSARW2mITsi1jY0jCdK2JgsvDpvXWfvYCbT/9tRu/JJ0rcgJ8jFtds5AUAeSGW5Vz4GSZ99N1RiE9Fz4eN4gNsXierAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ez55cBrD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ez55cBrD"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3D30020844;
	Wed,  7 Oct 2026 08:48:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v1BBXX8DiA9i; Wed,  7 Oct 2026 08:48:29 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 487D62074F;
	Wed,  7 Oct 2026 08:48:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 487D62074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791355709;
	bh=wNWl6+bQFVTpmYCTe0SWoj24ZSXLF9U7TB+h9CNRmv0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Ez55cBrDJsz29jfC2HMqZ5zUgZdCUivl4clMhYSLgilYfjbzOTNpaiG2DtCsjtH2F
	 zMIuANTz7nTUjg5ltlE5PoyZCZijo7h7E2urfAV07mjplpy3nK+oL+i/a26oYZDsvw
	 nc/D+NqUeTMLTv1GvdnfcbAEdX6Vq9cjtjIQFZ8vJqZSH52b/hCCDcFCamYenF6q5K
	 jYv4aWYGThSAvquWRe4wJ7Is3fbwfSvBjvcTQbAelj9AbMfytPHdqq0T1ugsYEZX4r
	 cVbzzHhJc3qkKKUxWCjePo5ByBHPiFvSYVuDEtHUrzyZsB6KennFaFeOzRgIQy+0jS
	 Z5gxQ93FVTx0A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:48:28 +0200
Received: (nullmailer pid 3303040 invoked by uid 1000);
	Wed, 07 Oct 2026 06:48:28 -0000
Date: Wed, 7 Oct 2026 08:48:28 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <stable@vger.kernel.org>,
	<yuantan098@gmail.com>, <yifanwucs@gmail.com>, <tomapufckgml@gmail.com>,
	<bird@lzu.edu.cn>, <ronbogo@outlook.com>, <zylzyl2333@gmail.com>,
	<n05ec@lzu.edu.cn>, <eulgyukim@snu.ac.kr>, <jjy600901@snu.ac.kr>,
	<kuba@kernel.org>
Subject: Re: [PATCH ipsec] xfrm: espintcp: reorder operations within
 espintcp_init_sk
Message-ID: <asXrPCMX747L5_tq@secunet.com>
References: <dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net>
 <179085931198.434549.11976738723347461302@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179085931198.434549.11976738723347461302@kernel.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Oct 01, 2026 at 12:55:11PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch does not fully close the race it targets.
> 
> --
> 
> xfrm: espintcp: reorder operations within espintcp_init_sk
> 
> This commit reorders espintcp_init_sk() so the espintcp_ctx is fully set
> up and published in icsk_ulp_data before the socket callbacks, sk_prot and
> socket ops are switched to the espintcp versions. It relies on the barrier
> in rcu_assign_pointer() so that callers always find a valid ctx.
> 
> Link: https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/
> Link: https://lore.kernel.org/all/20260819155349.3555804-1-jjy600901@snu.ac.kr
> 
> > diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> > index 3e72b9f067b9..1087a8dd94f4 100644
> > --- a/net/xfrm/espintcp.c
> > +++ b/net/xfrm/espintcp.c
> > @@ -466,9 +466,23 @@ static int espintcp_init_sk(struct sock *sk)
> 
> [ ... ]
> 
> > +	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
> > +
> > +	sk->sk_data_ready = espintcp_data_ready;
> > +	sk->sk_write_space = espintcp_write_space;
> > +	sk->sk_destruct = espintcp_destruct;
> >  
> >  	if (sk->sk_family == AF_INET) {
> >  		sk->sk_prot = &espintcp_prot;
> 
> [Severity: High]
> Does rcu_assign_pointer() actually order the stores that come after it?
> The commit message says:
> 
>   "rely on the barrier provided by rcu_assign_pointer to ensure callers
>   will have a struct espintcp_ctx available."
> 
> rcu_assign_pointer() is smp_store_release(), and a release store only
> orders the accesses before it. The plain stores after it are not ordered
> after the publish. These are sk_data_ready, sk_write_space, sk_destruct,
> sk->sk_prot and sk->sk_socket->ops.
> 
> On arm64, POWER or RISC-V these stores can become visible before
> icsk_ulp_data. On any architecture, the compiler is free to move them above
> the release store.

Sabrina, do you plan to update this one?
