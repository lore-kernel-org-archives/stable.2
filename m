Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704225;
	b=S5L7fRFw0e0Y1tDJ0RL5elg5sO7ttuJtakusDOJyUlQqRIO0XWBk/Olqb00jdyjyq1IA
	 tl09C69P6zdi4kcG+HA11CH6+OfA5CRcbGkVaruxLsLkFut+diiftGYpEWLdbvyLLis0z
	 Ejg/33VizfYYAcrZD/BzSu8Syk2wEqVCMrpSqDed56M/G57fRRljh1yI56q0tH0VoBiSd
	 VH//9FkGgiRGcI1jxkzitS7H83EPtn3d9kFgR6BCo4hkf3sJvGzh0HDMv4bn3ax6LHZEE
	 ho2iqPevQcpLvPWvboYbYO2ti2QuyU5hb2kSpwYhqy0sth2ZDTNL3nU9tU06K1SWQFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/W2mjbTmgpq1pqBSl49B/N5yASScZpRogYzJGRRzFXs=;
	b=49dOstsocsoT1ZfjEKdykMF9JYxnhAWXRdJ/0Fe8wsjPM1o8+ruIq1endH+Qf3xuy9rn
	 STz+AjsXpN/g9iQfQDYC2S050bmKHP0TQyprAr7legkdMND3PAYloizrBuGaA/MCXgAdy
	 QyDC4fI2ePE7q5vqp4IgM1tCyleengHQNNDZkgkDAzbl3FwgoQCGbDeDxHkCMsK6wljnk
	 4ddPWV5nzIWZyodJXajg/lA4bgImMoXSp70tmGODNGubLMKg18ujCKGxiqDI99P7qLUjO
	 0i1Fu35JzB5VjRfBTwLLtzxVthvInO5O0z6ZUkNZv5sK430m3vJR1yLFTviYLQ7jizA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chPTcyEu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF3606C573;
	Tue,  3 Nov 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chPTcyEu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344011F000C1;
	Tue,  3 Nov 2026 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704224;
	bh=/W2mjbTmgpq1pqBSl49B/N5yASScZpRogYzJGRRzFXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=chPTcyEu3+6/DSswsWsAKE3hFccxSLecUPqONvn2808hJLH2u9pAFZDufqnPJqcRm
	 2hTmwuqSPEHqO9LT5G6bbCKKJVixQIQd+2rephmmTvsZXJokl1bIy6nSFv75ODy1Mp
	 gMrs9tbcm2WRe2e5tI7F0ped9GCj1PxSEaGbJN+PU9/UI9UrcKPDhGt+928fONZuLf
	 A+bX2wFpEf7Dm1bTv01iVW685qctvFwn00OIrHe6nPpLQeV8HMbc4ovZlNNgg/3b6R
	 zUJpUi2FU66L8L5rDQSpVLkqqPTLrG+wUU5FF+xGQl+7mCJ8m3yQPCuEksYTALFdZL
	 P3Hxm0F8QdNCA==
Date: Tue, 3 Nov 2026 12:10:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Vinod Koul <vkoul@kernel.org>, Shan-Chun Hung <schung@nuvoton.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jacky Huang <ychuang3@nuvoton.com>, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] phy: nuvoton: fix USB PHY clock reference leak
Message-ID: <20261103-tall-elite-otter-d99ba5@quoll>
References: <20261103104242.1373863-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104242.1373863-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:42 +0000, Wentao Liang wrote:
> ma35_usb_phy_probe() acquires the PHY clock with of_clk_get(), which
> takes a reference that must be released with clk_put().  The probe
> error paths after that call return without releasing the reference,
> and the driver has neither a .remove callback nor a devres-managed
> clock, so the reference is also leaked when the device is unbound.
> 
> Acquire the clock with devm_clk_get() so that it is released
> automatically on probe failure and on device removal.
> 
> Fixes: b48baf69db97 ("phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/phy/nuvoton/phy-ma35d1-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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




