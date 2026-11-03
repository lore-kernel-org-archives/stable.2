Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704269;
	b=HlU1T2EqtIhSY0Ww0367aWJ5Dih9R0JmkWHOekRpRqH/Xcl9VpVSNvACAIa2SlZ9EA8V
	 pq0yscNZucZmDv93vkybg16sP/7yHHQnA9+dT1ClXLb6Pef+UADvduS1tUGM+z6UAUQUa
	 BHpTh9ZRsHX13hBEvTuWE3LJWhp9pyDbe+TCL/RGRcMizC6r4Zmm+YJ36aTINLoZZSRS6
	 v00/XGwUJILzWu4Wndf7kFsyifAzxuWMasvjoTNCAonq7vaHOL5+T64ba6p5nuGtfZOq5
	 JaVvp9jT9uOt0DUpIVFaUJTOtSEwGMbxZq4/hDqZdnaS5lnwY/aEo+SrXk5yw70ONZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704269;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FpQlMQJewUjSCH03T+lvF2s4ZsB+JiwT2xWSf8S5qH0=;
	b=ks1ltPOkMhzqDRl+QPqb6wzo/iSHEUa4UPgMZeWHBQ7XT5cl3OuRAzzLhi7ILlzx5DJ7
	 /8OdMCd7dG0ZbK+sxHPVzEJD2U+OS+JfbqTJLPwTvCzsl8U1BRuza4dKoXJSETaK3wpfe
	 N0kCRDM8g+CiRom9+hmOAm9d0lmU5NKStNOnvk3LeP6grstOAlcOOs4fri/jvvDpLCDy2
	 I2HaQwMTXTizJnoCN7mXzhlCUk4JSuzn05oUNd5si902oi0kTm5Zd5zwFttuSGIaL+Xyd
	 yXgG2hLw2Q2p6T31junpQV47akM+vQeKFMAq2wTWZDvnieBRR55k00GnX7shr5g+4pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zvv5nbwW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8F60A5BC3;
	Tue,  3 Nov 2026 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zvv5nbwW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC181F00A02;
	Tue,  3 Nov 2026 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704269;
	bh=FpQlMQJewUjSCH03T+lvF2s4ZsB+JiwT2xWSf8S5qH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zvv5nbwWsLGPZp4Xywj7dxPso9Zy0Ne1ukAjQZIEgJWgEVRMqmop5Xxuj4przbrEs
	 EW1Rgi27HGxlCMg9b9tYc1YSQIf7O6H8UxInj7eYhnqJlCSFr4eFzeld81QvcLEp1I
	 x7WSAvomCJy3JcborHWX1g2jmGN+FnBdvzI+OxnzugZAlMcd+Wn+soMWK4H95AZNcN
	 puFaMaLvgJwfRIzQw63jxRdfoavLXgjGG/WGkgo+y0SECuBpxtRsb+rQJqCg44Ybj5
	 JxZ7lXUPQ1JE2VJSCB7bAiiD0aGFwEWZbHmpnyJ0mQwR7YW5o7g13DEpZDB/1VEJEH
	 4XA3/eGRdJ0tQ==
Date: Tue, 3 Nov 2026 12:11:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] net: lan743x: disconnect the PHY when PTP setup fails
Message-ID: <20261103-vengeful-magnificent-sheep-ab33f8@quoll>
References: <20261103102852.1340530-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103102852.1340530-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:52 +0000, Wentao Liang wrote:
> lan743x_netdev_open() connects the PHY before opening PTP, but if
> lan743x_ptp_open() fails it jumps to close_mac, which skips
> lan743x_phylink_disconnect(). The reference taken by
> phylink_connect_phy() is then never released, and the PHY stays
> attached to the phylink instance.
> 
> Add a close_phylink label in front of the phylink disconnect, as the
> pre-phylink conversion code did with close_phy, and use it on the
> lan743x_ptp_open() failure path.
> 
> Fixes: a5f199a8d8a0 ("net: lan743x: Migrate phylib to phylink")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




