Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525203;
	b=KdwqyKsvXSg3i6nc4yIhx8Hli/MK0N8zP/xJ9c69NKKlfjSu5+1rasyR5a8tuCS7XPQi
	 FUkHbqj1xCfvttIF3nx0Rv0GTIE6HV//WxHyNY1+Rhv8OpS4kM+WTgIF6WzIXkqElom7y
	 zPs4+0Y62nnzUIsMIfCAcUp+Yh9EBDOPu+kuVFHp95tXfI7mhNAx5DHMM4glJEpxFYpnA
	 I8fPebS70VF2apRVmh4gCmD19XZw4iVQAZMNLnnicXM95jheUdCuiTX/Gi2uNMLJ6vljk
	 yUXT4OKqucSEXP5+hfDYOkQ79a7rGQqVHQQj7NHqGS84vMQX2TEEDZuEvX8lS1S5jUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525203;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=W3j4TVqT8hQsZ4qmyL/VPY6vCz035D6HhOWfcepJD9g=;
	b=Oj/zeQ6nWc9AKUD4JsObdUNLw3g10N0ewBsXNByOQ4gZ4iYhvpE+lny3Mj9QdEyJyVDf
	 aELCLaDvHYWA8aaTYy4db4547gxtiI2MxJs63OAgyrvwjGoV0Jfsbg1vQFjHpdXMsSWfD
	 AH1oIdJCsYRGGn7KmxBK7fXbvVpFOt+CDZnZ+V6pDcn93Nb0IHDYGSkzTFg6sG73d4nBx
	 9urZ1HbEP2rDNZO/xH3DMuip79+lc4mCokK+h6U+bfmhoO45VbaHeeEeGRDSTRpNSYcnv
	 S4fI7us16kkseebVfTHbgG3PdTcc8ScKI1INXozZTJVsFPoWX0X0pfUiv/OtEGmoL8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKAM0z8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87F606A31E;
	Tue, 20 Oct 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKAM0z8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F52E1F000C9;
	Tue, 20 Oct 2026 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525202;
	bh=W3j4TVqT8hQsZ4qmyL/VPY6vCz035D6HhOWfcepJD9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hKAM0z8aLwOL0lnDRaOrATevXiE5GUHYeLFralb1XjYYUMth5Kg91ITv7MbK4/NX8
	 skWm/LHbhySS2fIzfUu/DSqK/ZVuK7cMGLzW6hwMxgG9UckvwQ8DrurKJOKms9tRTt
	 wK1k1mng7KQ95Co4dH2z5E+MEvQnOCVgTQCVfU4OzQy2Df8HpSF9I0ZqxDhlveIGup
	 1YaSUJOIVyInM+hEW4gDiNkrnzXubwctYqvFzuhWj3xqhnJa5GQrk1hcZ32b/y8Lbb
	 x9ziOMd1v3gvD3k8ke8eBcBYvJB5iKx70JhqjDGMntWk/p4pQY3nHZ654sEVitu5ts
	 To27yV2wLuUcg==
Date: Tue, 20 Oct 2026 12:40:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Denis Arefev <arefev@swemel.ru>
Cc: Sean Anderson <seanga2@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: sunhme: fix infinite loop in
 unmap_partial_tx_skb()
Message-ID: <20261020124001.655104c9@kernel.org>
In-Reply-To: <20261015114355.14906-1-arefev@swemel.ru>
References: <20261015114355.14906-1-arefev@swemel.ru>
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

On Thu, 15 Oct 2026 14:43:54 +0300 Denis Arefev wrote:
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

We don't take LLM fixes for ancient HW drivers
-- 
pw-bot: reject
