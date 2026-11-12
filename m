Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446839;
	b=aFYFEh+3VPfIlA2ppzc3lfLdu5ZUovCSi1i3IoUdKr5uROs96IYb57nSZTZgJD8wIGjx
	 +5asv8GdNZZ/U9LUH6iqphv7SxVU+ZPLS1tMtYyA4omLu3cFdoyTJoWiK86DeDS7VfBmf
	 Nw3ctow+9lsszTsl5IdKJFZ/oB+Z2B0vHDHvEMlZznLyopRmdL9n4FkF+67N3qk8gXXbv
	 EYFUB5D8AbYx0pa4qxGLNNLmSY1Qg5k93mSM59zAb9Z6BEmO2iO4hQuVOnXmtJaOXs87z
	 iZNJUwcK4YGUx0GclIXzbfJrcqtCPPdcJOUm0lw3bcOl7uHTva8yCk+K/IN3mv+TzGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446839;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q/lveT1bVR64vDjyJJw1kviu+yZQdYmoJOsd/WaZ6p8=;
	b=4OuVXtTXq6s+rlpaKoATEXXc+2EJ6bfx6CDEHt2YfrV3jdM0RzEJTKQqijUaVvg8A4xt
	 qFZoaLBuWuEo4auiJRSZslmH1PbUFjaYTRTZZZilZg0hQPIA/svhe0HM6Be30hcCymKxo
	 8qkh62symBEzt46FChxUekpR3O250MSGpsJQUSczf00vuwrPzuJ7+WsJ/AqtIIBtzrvcm
	 7t5oBh5qe7gUFBBMNmEJFljidiZRuPoSFpyYrmkyrCSkOyrSPlEhff331vDMWVSb4AdUW
	 tHDfyVfD7YhrMB0IB+QbM4pt41cbJ4sBP5TOM40fiRfYqujnTVXLhiiUyWYJuUdkf8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0Xse3nj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A64606A31C;
	Thu, 12 Nov 2026 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0Xse3nj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049761F00A06;
	Thu, 12 Nov 2026 01:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446839;
	bh=q/lveT1bVR64vDjyJJw1kviu+yZQdYmoJOsd/WaZ6p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O0Xse3nj+TS+Yj85esN1+koCSwhjpteuHkg6I6K+JLFc5/NSltJSsE52iDqkk9BOo
	 S9pwUKkYTWjLWAcLdNB4N0RSsGYgceuDGY2J1tTw/jZLRILLR+MOw2sEV6HUwD47Q8
	 xYY8wIJwEIu8Vh0f7SAwTYnADSXXD+BHQkCvDY0WvrVa0u7jwZ6IFk/F5qF3Kcc/PK
	 DTJN5HT9oY+6U0lKs/YIoNouNI0EF0RVwvQbQCm1Aap9HetYbiP9Nv0XI9B3k9C4Ug
	 SS6XsYR+1TrRcww4XrORI+9zj30p7xb4nC31uvo4Yf2PE9Pv3en79300Ha212kyUYj
	 hST/dL2X3LYIw==
Date: Wed, 11 Nov 2026 17:27:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
 Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: iosm: cancel adb_timer on cleanup to
 avoid use-after-free
Message-ID: <20261111172718.1e41f48b@kernel.org>
In-Reply-To: <20261109124933.1603575-1-hj351016@gmail.com>
References: <20261109124933.1603575-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 21:49:33 +0900 hyunjungg wrote:
> Found by static analysis; not tested on real hardware (needs an Intel
> M.2 7360 WWAN modem).

Please don't send these low effort untested driver fixes for networking.
