Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701577;
	b=Xz4pTwBIL5kjFrRfYCFxMasTXQi0ifJlv2IM9x+ryUFxzlc1KW/65RCfGxFzwqmBmjo5
	 SJsqHxnL9qZ35fDKio5CNSDi4x3RyGsRhDk3zAl+HR0QxAOOv8VJ2t4aKA2rSrtdsD3oh
	 O68oWbuEM15GBnLqeGnFReczO+kmeMn4vXrG2NFd2ECBYqb0o8cNqHsEi5TTBAqDDmp4P
	 kURTzHqtec1DUD+Hn366AxL2YDAk9poVnNj6tBDI+J8Ow7/NBK01YicfjxvGUkA0O9W6F
	 MwsaL4aZqmpyWIob9VNTAOTbpbHgvutIe3r08rffSKpXoco5KNQGGQ+1Akv1g/5H8zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701577;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9clrbqdXgsnOrqBlmLUFDxai3Lw9LgBHe2HqLH/Q/qQ=;
	b=2CevA98rTB3XfDblPzClneoU/L7qIDKzwJAzhz+gBgNTVJB9nikqxlgI2Cj6k9y2H+kS
	 Z2MgW++e8vSPjj4fLH0cEo9JK6SYHIEUtXRyUR5q+WN3CVRQC9hTy259YjjcSWHLYsG3/
	 6Kr5MmsUZvwkDrg5GBKblUUKCROinA5YVbyCS9dN8rxk7tde6O4F6kMVTTUQtzdkawdFk
	 TPnZ/Yv7oJjW6W3wjasMXLuNernUoQVn2dLQM46r+pdl8VljQCOtuHDMkBRQfUCzMcDvx
	 nZNjwiB+Qk90098lgY9xo2sX/B6aXSHJra4Ws6RA2OR66Smihy2vYq2ySV0PIuecIjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeahQ9Dq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E1606A32E;
	Tue,  3 Nov 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeahQ9Dq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE941F000C1;
	Tue,  3 Nov 2026 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701576;
	bh=9clrbqdXgsnOrqBlmLUFDxai3Lw9LgBHe2HqLH/Q/qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LeahQ9DqABmAbcGyj0dThYoT0DpdsUvtLcNFqMLHA1CJdSENL0/8DLpPsbhNoS2yF
	 zcOxZYbasmxfKxo4YZeIUek1YLFILiJ8neYYC0APDRMf48s08rTmCq8neceielPrL3
	 hyF1Dqhx0guchGXSEienywv2eWIJ6an+TGlo4kP8r4WkDJ1GXr7Qkz7Ue8D6qY3dEK
	 9HLopgH7WABUEAyBdBTMut1Zy0+Hq2w+WavwvK4y43pNox32G0NkaHtBxjlsho8L+K
	 gKZopNZOxsyBRuthlcghJwvTuYddNK3Ub7b/NX5KZ3b5Rf5I89o1iLT/yvxfSA+z7v
	 CNzEO7UxSdFwA==
Date: Tue, 3 Nov 2026 11:26:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
	Richard Weinberger <richard@nod.at>, stable@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] mtd: rawnand: atmel: Release the HSMC clock on legacy
 init failure
Message-ID: <20261103-watchful-iguana-of-criticism-257adf@quoll>
References: <20261103100602.1310416-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100602.1310416-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:06:02 +0000, Wentao Liang wrote:
> When atmel_hsmc_nand_controller_legacy_init() fails after acquiring the
> NFC clock with of_clk_get(), the error paths return without dropping the
> clock reference.  For failures after clk_prepare_enable(), the clock is
> also left enabled.  The caller returns the error without running the
> controller removal path, so the reference and the enable count are both
> leaked.
> 
> Add error unwinding that disables the clock when it was prepared and
> always puts the reference.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 26 ++++++++++++--------
>  1 file changed, 16 insertions(+), 10 deletions(-)
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




