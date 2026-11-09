Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252244;
	b=dAflyL9RI7Uz94EG/KK0GpftWMPruwbM0PL8ycH3fNJ0kN3Qq7lwfSdashZONYhxx6In
	 TzRYmAap7QPE5I5TlY1/FwIRNfUGsIWxuAfE9/j/5sEzDaxlrKYx7oT0EixO+815nglnx
	 UJtyJbTutxVdSOjfGMkG7HA8MLgqLoZV9NSqW7f7ipog4dKUCPmYjQzC610dBkDt4cXJI
	 bRD70SJNTXqkoYjOA0/FJ1iHwNN8B3bwOIuNQnbVUr983J1JfDBk5kMvD+zaZfgHkz52J
	 IZh06RiGw740MqO7JREDJbl4eSgNV0AVweYPdDVGC09/4xm1wXnstPBG6TCjewBG7Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252244;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8k2d2PhMnYjRXQ5QRw2mJbIvbUQXrtHQaaDuFIHG4zs=;
	b=lrFM0/+dQj7lcMcuJI9bXfQYQDSaZhOfM93L/TpkvG4z+u8L79wzqhXhxyQHVD3R+mLE
	 gc0ksnNeaq4+cFdBdn13Bql2N2TVYL2dUJgecxefDiR8STUeZiX/BLsaNaFL8GWSurZJZ
	 bNTgf6E0aqo6TkBUFEFmkoZ/4zN9p04cVgVX6iU/m3QHWtKCIbbzYsqG9bRUcz3fiX8NS
	 5pZTl+tPqx77oMoFXsLsVtshvGYnpTb25pFi9H0oT35P8ybDYD4N1JurZDfPSYJG01Q1d
	 4HcLsa4nkseGfj3qCBIAm/YPxrk33uYtpolhTBVXuCrp2QbGMkWvB/TNYkK8v0aMvQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IO68mBpY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770D606A325;
	Mon,  9 Nov 2026 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IO68mBpY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4131F0089F;
	Mon,  9 Nov 2026 19:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252243;
	bh=8k2d2PhMnYjRXQ5QRw2mJbIvbUQXrtHQaaDuFIHG4zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IO68mBpYnUHXGVCtcQ4aUiCR5OpZF6j7sJv5sFZ6Oy0Kg2rleMKEZyUN3oM4jSLyJ
	 G/akshB3q4eaLSzY393f0AfGLUmQmJ2ZPiEM9DfsranqkvgV2CtJWaKH10l5yP+HkB
	 6VHEiHz87BMyFX70UoUjNBkifodCfkqM+cEsTwj7FgtmPu7v8YJ0l+dLG2P50tFUmh
	 BZgEF1W5rvtsKHutCHO7Y48ytx/a73YxysbmnR2bfwag84kxXrsasMSXpPYYqzXYwa
	 fchLvg/uN4sD21ySsLnTjFNqWCyBrCaEAceQXWX2z2jql5jjQIQy+raeXnc+UNcObN
	 9S/t9G//QdLMQ==
Date: Mon, 9 Nov 2026 11:24:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Cc: 1579567540@qq.com, Marc Kleine-Budde <mkl@pengutronix.de>,
 kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Wolfgang Grandegger <wg@grandegger.com>,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v8 00/10] can: fix Rockchip TX stalls and bus-off
 restart/close races
Message-ID: <20261109112402.283c16a3@kernel.org>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
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

On Sun, 08 Nov 2026 19:33:27 +0800 Cunhao Lu via B4 Relay wrote:
> Subject: [PATCH net v8 00/10] can: fix Rockchip TX stalls and bus-off restart/close races

please use get_maintainer.pl, do not CC netdev on CAN patches directly.
