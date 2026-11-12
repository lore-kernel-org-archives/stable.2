Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449858;
	b=KLkNmekeEZE379MklVnnQR1EvvO3IFQUjXPXPcTZhhvD2sCUrH9Bvr7FD+/yh1CZ6rLe
	 JBEUvrFi01qt1u97O+TkOsUy4rygM50EqNes6L1URnP689/lCEIjPCIW5Cs+SooZ14sGW
	 84ZoytzLe8pTbx52xp+H70d6ar2RgFnCAfjIKL+l0JygaPggvFu5Cm+a4lNv0BfXgrm//
	 oazTDzood/xtnCknqRzuLl2iew3IOcbl6n5GtScuM2Rwg9qgk/14YqeXvsAPWhFHrTi/H
	 Xm5lGg565gPqIpW+qHUagCnQ8loZYY8IL14r+aWdHsR4dbOqAEcT6nZv5Ea+oWKH70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449858;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2lsD1pQ6+DDqGPxcO7ETihmN0CAHUGLXXhPg7tK/8Ag=;
	b=dhsKwOQ1Cn2vL0+9hdTMOjjhMigG9kBMXxr0cCT3CcxrIM8peT+C5cnFwZ8peXKDLQr8
	 SA818pRUiPWbtssPC3b5e2xDqfWmJMZVzC0lz4SEjlSa3uNXhmSrhml3uNCoXDtrXSU2E
	 uXbp56u/Rs7lhNAHTdGQ0d/wXHtNcc7h0Eu1+3fMU9PSJLIST8b0pQ+4zC21VzMXdMAhg
	 S8sAWwEAcvSh9ucCe0GZwlQTGhm0q1TZBpdQa/7U2NlQmY579LTa21zHActaIpq0T0CQs
	 nBt2zYSZPW8lLGmtBOShl3A9AJsHIGKfa2P7u7iUA13l/fOJ1H2iNzCMsov0RCv0Xuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVFhp9r7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC99606A323;
	Thu, 12 Nov 2026 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVFhp9r7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8F41F00A05;
	Thu, 12 Nov 2026 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449858;
	bh=2lsD1pQ6+DDqGPxcO7ETihmN0CAHUGLXXhPg7tK/8Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SVFhp9r7elGbFBAM8BQvrwEyKnGqiYIYBfesiP66ozgkCONxbK1epepV3kzG4dARq
	 50X852UzZImHRcRicEKYNbIMxz0k8miZVLZz3fovWxTA2C6gPbFgpyvgA6qw+EEfjb
	 ipXqJCQxG95v6rcP4GzT9YJq9j4bzRp2GxatEEK+HB0t7x5fL+WP/BrXSR2mSycRHR
	 lSZ22qe5n+Xx0xKPQ18RJQ0fHUpfM9bLdTdtWNvz5ScGqPL2lvnP68jNaNarkJMT1a
	 zMOhNKGTnyVpmfNO7Gscwm/63GrG8svxP/4AnG7E0IbAi64kfXmlzDucwPu9ywSPtq
	 nGDRl3OeraBhA==
Date: Wed, 11 Nov 2026 18:17:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: atlantic: stop TX again before freeing
 rings
Message-ID: <20261111181737.3b2e56dc@kernel.org>
In-Reply-To: <20261109071935.2945421-1-hanson.wang@ugreen.com>
References: <20261109071935.2945421-1-hanson.wang@ugreen.com>
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

On Mon,  9 Nov 2026 15:19:35 +0800 Hanson Wang wrote:
> +	/* Drain external XDP transmitters that passed the admission gate.
> +	 * They can wake TX queues, so wait before the final queue stop.
> +	 */
> +	synchronize_net();

Is this really needed? presumably you removed a NAPI at some point which
implies a RCU sync.

> +	/* Service work, IRQs, NAPI and external XDP can no longer wake
> +	 * queues. Drain SKB transmit before aq_nic_deinit() frees rings.
> +	 */
> +	netif_tx_disable(self->ndev);
> +	netif_carrier_off(self->ndev);

Double-stopping is pretty hacky. Can you figure out a way of avoiding 
the race instead of stopping the queues twice?
-- 
pw-bot: cr
