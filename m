Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2C31E852;
	Tue, 18 Aug 2026 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042985; cv=none; b=PssmQh1PLhQg4yGjrRSFevfOUNonZ5LeYUqURHWJ2JsIcXkChioDaxLb7nBxFQZ76fHQnIz3vLd1lfyWpEUQe6o6+defriOO7PtWOsm5x5K0RayZNoNQuISjG6ZzuakKlTZ4C1s4mlCfIcI5wPZh5icz55zdB0wJZ1ges1FxXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042985; c=relaxed/simple;
	bh=PZSbE6LnHGS9FyS5pXPmC1R05eO7J51O0XgZJRpTxlg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnCvB71H6UJZdpGO34+plXLGZ4ykvRwZ4RfeJpc5WJtOxbqO1VWYZqNwICIorCY3Si9suS4Sf6kTUiiiweBWwZYpZDqouLfjN4iNoWflDLG2LzrXAD5ckQSrM1vK2AI2MoN4WkO6XsP+nRDUcH8lOi6yMczKV6Z8A0qwekVA+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nQeB71qB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nQeB71qB"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AEF23201C7;
	Tue, 18 Aug 2026 10:49:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WCTn9nWIDhQh; Tue, 18 Aug 2026 10:49:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6CAC0201AA;
	Tue, 18 Aug 2026 10:49:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6CAC0201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787042972;
	bh=zqDcXO5pUdUgchoaam0ohQz3XH401hpRmwWhmc712rA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=nQeB71qBGb+U3cHFgqyjbIz1Cd14ErFWcAAR3n1uweFf3cwBWp1O+mKHYPmPxOScB
	 r/30ypvPtJWQ5Sbg8+tcJHBvKPI2juc9EffvHepyIPVOXoKFpo7IQSPhy9wgkzvKL7
	 OIVg/Ge80nzBxhq77ZfJHl+0q6SNq+2BcMJhQqCTL9W56qNyZCoVc0M8MESr0ETAxw
	 tVkV8mFUVgm++yTApOxNBuizOjEPtSMArkVC8S2MZykcgps+uru8nQeciy0yXSN+uJ
	 qtDKqZAj0xI50J0gYo0Xg6bchfgYovIXFm9PDYOHwgFbpZjuQvAFKVg7RKi+jRUryP
	 X7oi6d8uJKNpg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 10:49:29 +0200
Received: (nullmailer pid 409395 invoked by uid 1000);
	Tue, 18 Aug 2026 08:49:29 -0000
Date: Tue, 18 Aug 2026 10:49:29 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zihan Xi <zihanx@nebusec.ai>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Vega
	<vega@nebusec.ai>
Subject: Re: [PATCH ipsec v3 1/1] xfrm: bound nat keepalive state collection
Message-ID: <aoQcmVtl0RLmtd3u@secunet.com>
References: <cover.1786987905.git.zihanx@nebusec.ai>
 <4fadde7d28791a4e1196664cec692fdebce99bb5.1786987905.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4fadde7d28791a4e1196664cec692fdebce99bb5.1786987905.git.zihanx@nebusec.ai>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 17, 2026 at 07:09:56PM +0000, Zihan Xi wrote:
> The v1 nat keepalive fix allocates a GFP_ATOMIC object for every state
> while collecting references for phase two. This makes the worker's
> temporary memory use depend on the number of states and lets -ENOMEM abort
> the scan.
> 
> Replace the allocated list with a fixed-size batch. When the batch is full,
> return a private walk status so xfrm_state_walk() leaves a cursor; drain
> the references after the walk releases xfrm_state_lock and resume from
> the cursor. This bounds temporary memory use and avoids the allocation
> failure path.
> 
> The v1 fix also moved nat_keepalive_send() out of the walk callback. Keep
> the phase-two drain BH-disabled, as required by local_lock_nested_bh()
> used by the keepalive sockets.
> 
> Fixes: 763fe700b7c5 ("xfrm: avoid lock inversion in nat keepalive work")
> Cc: stable@vger.kernel.org
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Applied, thanks a lot!
