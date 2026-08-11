Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96430C63B;
	Tue, 11 Aug 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461345; cv=none; b=lo73AbiBNIR3L04JIdMPnnqNEPY8cYuusVCJaHEThZuouDXqh/Qh5UMMmtfnia3CAT8/yb1KVoQ51IDpFXOGZp9bVZJzl/mmGnVpNlmAZ8zsN18+eNknvGDntUG15ZuBnO8cCHVniOX1ruJzGrdcCWeAHSvjhiEdEo9Qcys1xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461345; c=relaxed/simple;
	bh=0W0i9LiGDxlOyNw906bbI2dfQkZTLP97Khq4p/vGNgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJ1dwjFzTe61uMlOp/jqIb1l4BsyZGbffq+8orQtcubVoWghGE0sOY4WUEdw4WYLvfmnAJoYDUhmUU1Wdla7itRjY+fFyfis7dgQ7Y2EB+kjfEEiNaVxIuswOQM/VUKpVdBMb4T3Ku68zAIBfUisKsK79E9DWda2Mn9zAWmL97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QINAOqwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QINAOqwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC93C1F000E9;
	Tue, 11 Aug 2026 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461344;
	bh=0W0i9LiGDxlOyNw906bbI2dfQkZTLP97Khq4p/vGNgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QINAOqwO4s7waJHhE1InONiDEgxg5D3uMH6sw2gkasSbquf8oGPbnuaM2v+u78WT6
	 GHoxeP4Rb+QvC1UYlE1RuMDQvoUeEYeb06Li22mqxVxiOgYyC3QVPLcxnCO3gjFp3M
	 /JTQ8P2MqCR63fmoLq/PBBWZVnHo6VD3VZdYSlrFExXQD96BaNUdFNMWgtgezaGWlR
	 /zsuf71kI1QDmeug95bT6/9mke8ZsFX/PHIFSHz0DR9wX6gP5+WSdFocLoU6YgM6ER
	 0nIIKemH2oiddcB9Sg3zi87kreOjygPCQB21C9ueCoWsytLgnLayGIJZRS/2x9Q5s8
	 qu0gvgSkORYXQ==
Date: Tue, 11 Aug 2026 08:15:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: David Laight <david.laight.linux@gmail.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <20260811081543.26d18828@kernel.org>
In-Reply-To: <ansQ8gHcKdS_Q_ji@gmail.com>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
	<20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
	<20260807174402.2dfc12d6@pumpkin>
	<anm9gImFEz6EkUZ9@gmail.com>
	<20260810222159.409357fa@pumpkin>
	<ansQ8gHcKdS_Q_ji@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 05:19:17 -0700 Breno Leitao wrote:
> So my question to you: can you point me to actual software that
> passes a "small" optlen and expects the kernel to write past it? That
> would help to decide about the two options above.

If you are very confident that no such SW exists - we can try to queue
this up for -next. (TBH I'm not, mcast specifically may be full of
strange one off manually written user space (as opposed to common libraries)).

If we decide to change the behavior- we will probably have to wait
until this makes it to an LTS release + some time for people to deploy.
It can't be a fix.

So practically speaking it may be more expedient to add some hacks to
cater to this case in the conversion, and then remove the hack. That'd
be easier to revert if someone pipes up later that we broke their SW.

