Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701589;
	b=F6grtBg6p7/Nsgg0ih6+/hb5sepG61oP14Q04Y7KUH0j/71B+7lrUyfvHubK7Z/qe0BY
	 YMu74YGkHpiy3IitJkMHSy29dsfm190rtn23c+ensWXplzDyO0zd3iLc/s3BWRkQegV5/
	 wLubGPQhQZjlVKhMGRwjZZZwqtiyaTAmpcq30P1TKYJSh9dCojaf/4lUHGXaGiM6IESKr
	 noLer+OqfRbeTR91eBr1ZgiMA5m0CFkpzjAr/djtsZ3Sxj94bpxFqze0JsLHGH3rV9WUU
	 /Jg3XsA3Oh6mQPiTqJnwKv7gkyQNJ1zyeNfBeHS13ZvWa5cPRGFJLPd7PP8P5Y6nmyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701589;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rIlYC4RGaBYFb8msoJbR+EejQjSODQYfHSJuVWGfL3U=;
	b=nnSQsirMUt3OGQj4CuH9GU9kbx3q8MdvqE6Nt7iBy5m+LTWmEWjSa0EZNNnufEYNcSd0
	 SI4H4kQklM5fObU8nRqWQvB0g8+DtMXr4yFN12uz3ERnFZFHGzT2E9LDXF/r7Av2EbsfI
	 BkdgBYCAgRz/yrUglN+JIELjJef6uehDI6dYVqu0hI506wgki9yb4Tbh88DG12Q7ZcS+0
	 qEhdupykjTA2hhKBluOLcHQSnBfT45cyz7aNsrrvbisXpsOcg2XLj2yrjfkWnYQ0RM90m
	 yI2uUwtsqBSQhmZCrbK+UGiXhJy2mpYC9vZlEJ5/RNxzCdPOE3T4K49iyDSMTygzR2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlJLy8eM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B861606BA78;
	Tue,  3 Nov 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlJLy8eM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2FC1F00919;
	Tue,  3 Nov 2026 10:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701589;
	bh=rIlYC4RGaBYFb8msoJbR+EejQjSODQYfHSJuVWGfL3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZlJLy8eM6LcgBzKjbZG6s94R+zcLzCqKvHAN+PzsR+gn5D69ZF1XwfBbzG9kmOHly
	 rkx6cHR0QurRoj5qxtYCZDjTPCVdFiKLa01IqHlDkYLlr0U6emnYFh1GkgOwkl29Vf
	 YYcYd9z0J20m/jOXF0V9o1yjzCvDA0fSiC7iGZ/He6apFFFoRwKWRlbyCgBq0abnTp
	 f6y+/FVq6ZnicYtpiyoYDHka1LPwP7926QpyWYlq3w3LKz22OexFpMCWiSEjxxe4w5
	 vIP5CzZfUWwj2Bc8IevU2OltJSpdiTFr9MuhLrcjcioMzEtUmPafbDpcUmwutDArHk
	 GYSgoUkqgNTnA==
Date: Tue, 3 Nov 2026 11:26:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Samuel Holland <samuel@sholland.org>, stable@vger.kernel.org, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, Vincent Mailhol <mailhol@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] can: sun4i_can: Use devm_clk_get() for the CAN clock
Message-ID: <20261103-competent-tactful-condor-50b96c@quoll>
References: <20261103100520.1309743-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100520.1309743-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:20 +0000, Wentao Liang wrote:
> sun4ican_probe() obtains the CAN clock with of_clk_get(), but neither
> the probe error paths nor sun4ican_remove() ever call clk_put(), so the
> clock reference is leaked both when probing fails and when the driver is
> unbound.
> 
> Use devm_clk_get() so that the reference is released with the device.
> 
> Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/can/sun4i_can.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
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




