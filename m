Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506036;
	b=e1y0Na7qdMfTYREdyIk+gGH4rFDUFrCELGBdKwYx2G6WIYFyXvKUC216L0cqIAnOA+Tu
	 LI4AvpYrnrsesCubAe6rpM3lO/D9v2M1YTGXo8VdKZG66gdILMjTi50kg+cswD/SSp/2v
	 5ha5OlOgkAKsiZSmBK9fXutLKhZeQ1n6qnA0KfEvgV3xAKgcvTbcLmXqI7Ipm9/MAjSrY
	 9I9laECaYTHGd5L0XQCy9EK9lf6o7BsIlt5slLjSuFNbkQw6G4vuqvQHcUtymZTOGZW5B
	 tVr/291DkbZQ1eIBbDhKtWmJAqC4l1ONFlKrA+Xj1QlXT1JvdNoMhM7lljn0ExHBXoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506036;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LJ6Ku6C0YuQTJPX4zbWKhssbUO84vJW0kaOLYxp+POI=;
	b=z3XeWxDF6iuYhSnjaUX3EAkZc8lIgjs1EL1qIASv88zzGZ0cMnirtaA02Trd9MDzAJKI
	 CB/f22JzaX8usXIyB2vnr+Z8/Z85gV0H4+aLwBdBA4Iq2hWm+P64RRBolI7rfHOAXgDHe
	 L4U9eHzKmnudaEmbpQLXRSuTqrpHwK+RlWctCl+IulgUd4gp0gO3dd390sdY75pUNNTV7
	 2kPy1PQWDS/4JxktNhwnrUOW9XDLVouX8cRBCXZvhBolEO0lSLpndjuE4Zew+/nFD3PSt
	 Jt9LuIiNwyOWfYOoHvJwtD2AadTQXzW0sY6KVQNMfSbDM+vkT3XNAWvRb8a4cdMobpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxoX7FG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A27606A31C;
	Thu, 12 Nov 2026 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxoX7FG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E821F000C4;
	Thu, 12 Nov 2026 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506035;
	bh=LJ6Ku6C0YuQTJPX4zbWKhssbUO84vJW0kaOLYxp+POI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DxoX7FG7m/+lAyL3t1PcIMm4wHPLccqLZXYnUCH5Lm1Yf/rI0kt0XwNIIPGga7SWK
	 5Xp5xnBbCLJwQGVOWRrhDQKN7XlbQWVCh43gGzQbL4SchM4OwJsSmdDdcsTy5ckVHi
	 o9pPmZxdKl92KnLUfY8Vr2XU8U23VwM0Tt8Xm4UzCiedNV3NgX1HUIu0iSY3gyPgzg
	 Vom1pyAuXN64n/xljpEU3npZS5cNjOsLL5C4qXHHhUEEtWFvO3I1A91KPt4e3bvyGB
	 Yz6AstDF9PpE7cwAMsF+zU+VJvp0JESBkk2X6jD4sSusw8N3kz+Rn1WYzW8+KNID5n
	 VXT/4ZrEvtCUQ==
Date: Thu, 12 Nov 2026 09:53:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joas Antonio dos Santos via B4 Relay
 <devnull+joasantonio108.gmail.com@kernel.org>
Cc: joasantonio108@gmail.com, pablo@netfilter.org, laforge@gnumonks.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] gtp: free the skb after handling an echo response
Message-ID: <20261112095354.3fccf5b1@kernel.org>
In-Reply-To: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com>
References: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com>
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

On Tue, 10 Nov 2026 09:03:26 +0000 Joas Antonio dos Santos via B4 Relay
wrote:
> I do not have the hardware to test it at runtime.

What HW? Isn't this a SW driver?
