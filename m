Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620C3A961B;
	Tue,  9 Jun 2026 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004837; cv=none; b=FaINuqJayAHv8x6wsflu3x9+a1F+NlaYa8acFecq4kcsytRFo322kRoS5Aq2CPr7f2CAhb5NQCG5lAOAfv0SeMCY1pjzaY6aX9OMXJZFIkdlj+ZadbfC0uuEJ13Pd3AW3HBE2JQAjhPe/BNQvmZAf80OqBsd4nYeBJ2MWkBUgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004837; c=relaxed/simple;
	bh=cwytvaQUMxEx0pLof7ZQcdFc4hVZEP24cGqRX/fWv8M=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CzSsLD9EviJPxB/CDY1+zlm6cmNv5VcYgwL759hw7WLq9O4S8QLOLSGt+vgxLPBxNdC2kbcXQIpJ7mPHTKBuJlg9nNI3LBV1yFBoqGtDy3TXEYWE/Qn3hBsgGvKQgyOgTw3W0wR4Q+o8xTxbpEg8cWxOF/Fj6Kj93NbOTO+1FKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=NncCrnBT; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="NncCrnBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781004836; x=1812540836;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cwytvaQUMxEx0pLof7ZQcdFc4hVZEP24cGqRX/fWv8M=;
  b=NncCrnBTYGpP9tAokN8+R7DA8paC2Jd/Na6aaxK/k6SwEIk+WsWFaSKJ
   ehlOBA4Wi3+4cq/DmBr3XGQ/kMDG1QBXQsrsMD3e01HvX6l7jmDn4n1WZ
   zd2m0ZglAVHmOgK8RWQSfmbtIeMEGZ5TmNXkFvxQKhxBVkeW+urBureBz
   sv3l3LYyvgnWs1OwLjnDDEeesTjsoGYlY3sP+0d/Q9Rf/aLzaF6hUXmSI
   7gUYf7AJyRHhOrHjtOOXMYw1ynR7p4nCUPGF2LaPYtFWpn7B9FDWEMm/J
   8uukoiI5X9O9Wb1FTesDefiOngUtHacI5C+7u6ZucOMO3fb3GA7B5hOPv
   Q==;
X-CSE-ConnectionGUID: 7b/UbARdTTi6u5dr4hAXOg==
X-CSE-MsgGUID: r18lWL52TtGQTHXQPrtKTw==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21386408"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:33:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:27987]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 8c1fb2b0-9479-4c6f-9568-8df99759ceda; Tue, 9 Jun 2026 11:33:53 +0000 (UTC)
X-Farcaster-Flow-ID: 8c1fb2b0-9479-4c6f-9568-8df99759ceda
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 11:33:53 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 9 Jun 2026
 11:33:50 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Sasha Levin <sashal@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>
CC: Sasha Levin <sashal@kernel.org>, Qi Tang <tpluszz77@gmail.com>, "Florian
 Westphal" <fw@strlen.de>
Subject: Re: [PATCH 6.6.y] xfrm: hold dev ref until after transport_finish
 NF_HOOK
In-Reply-To: <20260608-stable-reply-0012@kernel.org>
References: <20260608082454.2786663-1-simonlie@amazon.de>
 <20260608-stable-reply-0012@kernel.org>
Date: Tue, 9 Jun 2026 11:33:49 +0000
Message-ID: <h6dsx7bo8dk2q.fsf@dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Sasha Levin <sashal@kernel.org> writes:

>> [PATCH 6.6.y] xfrm: hold dev ref until after transport_finish NF_HOOK
> I'm holding all four of these (6.6, 6.1, 5.15 and 5.10) for now.

You probably need to hold the backport I sent for 6.12 too:
https://lore.kernel.org/all/20260605141254.1177152-1-simonlie@amazon.de/

> As adapted, the backport leaks a netdev reference on the nested transport-mode
> path where both an async and a sync decapsulation happen: the inner dev_hold is
> balanced by a dev_put that the older trees don't have, so the saved reference
> is never released. Mainline avoids this because it has b05d42eefac7 ("xfrm:
> hold device only for the asynchronous decryption") as a prerequisite.

Sorry I missed this and thanks for catching. I'll send v2 for this.

- Simon



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

