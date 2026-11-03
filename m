Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704221;
	b=kzQuklmh256fO4pLWdC8am+Kyz4AnAJoY3XETDg7VT/P4vSdXiSnBP0xwVC9JUFvlPxu
	 kRdmKf4fDPSJvu2jPa/pv00a6/KIJefmk/y7ccEBU7sXfEHhYhjcxzpuQym/Pad6DNpcT
	 wo/inYvaXbcu/On8pLjv/m0ia7Fbjp9uQayhRlo77SH1U0/CspkNDGNlbLK9J7xwZ4MYV
	 uVgojw9vm0MMOymRvTRNn1YNL5KDY30XVAqV95liGDrZmKX2sewWOmYQnNjiKfeLOGb0i
	 1Dg3AsZ9PTwlu4ZDU+tnWL4kV3tJL68CewlnPikLkXWl+OIM4vqIDUNllaWNLhEb2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DttFhI0LxeH79eT/YhOIy6UMobLtyg9GPfkbGAxdi3s=;
	b=4ofUyBzxjngxJvkiRNCQYFasy5tDLkmsj9zZD7LscfpIHmCB1X1I8qt4FfJiAXJRd58t
	 k5QJbzaFhDYoBkvoLPR7PXnyHC79AyxFdjz8VOfXNFodwN/q1Euu1Wv3QC64/35fueHhX
	 IvTRfOQPf3uGtRha3Gp6ZmuOweAeS8+o3t0MoyCZLJDI3/HPd0Z+YShcZ89gleNPkBbwz
	 FkY5TU2UYfa8ObcL+7dva3vRLUbUehMy4/cNFtOSI1t6ZCmoxtmV1ueHqiF6WbDgs8kCu
	 o5KcBd3EfZ0uXxGUPIIWel81/HRlm39xcgYm9ZDJzMwV8EU9egOUMOhGjW13edTsRgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGGniuzx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11DC606C56C;
	Tue,  3 Nov 2026 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGGniuzx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3D41F000C1;
	Tue,  3 Nov 2026 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704221;
	bh=DttFhI0LxeH79eT/YhOIy6UMobLtyg9GPfkbGAxdi3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CGGniuzx9iamA1AwRWMQ1/ltNGuso7AezbHqZvG0a82iiXHiwroTbFy0Yv0D2P56V
	 /i8XebYAe+VzhNJoc21a+OLWcTzWVY4BArMpFynRoK/OIafQa3PAxXjLB4Yk+zcHlG
	 prmDed2NkkYSSKO+ndsUIqitcgo5/TEWdZTJqYCP5oUqCTS9XNMiPy6dfbV5UjSe92
	 jJWEsLg05NYuiRk6y1ILq5wze+65C5pZ1TWCYp2JmkkJBrnPFPHNVkmZoZr54t37Hf
	 7uSsVgkIXTA61kgSFV0HcgG3O9l9UZ79fY+oIXA4P8X06WrasZ5jU663w/uNuuzutz
	 Bly/TlxMd8lqw==
Date: Tue, 3 Nov 2026 12:10:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] phy: mediatek: hdmi: use devm clock provider registration
Message-ID: <20261103-jumping-nostalgic-mussel-1fddcf@quoll>
References: <20261103104241.1373838-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104241.1373838-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:41 +0000, Wentao Liang wrote:
> mtk_hdmi_phy_probe() registers the PLL clock provider with the
> deprecated of_clk_add_provider(), which takes a reference on the device
> node.  The driver has no .remove callback, so neither the node
> reference nor the provider registration is ever released; after the
> device is unbound, the global provider list still points at the freed
> hdmi_phy and at the unregistered clock.
> 
> Register the provider with devm_of_clk_add_hw_provider() and
> of_clk_hw_simple_get(), matching the sibling MIPI DSI PHY driver, so
> that it is removed when the device is unbound.
> 
> Fixes: be28b6507c46 ("drm/mediatek: separate hdmi phy to different file")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/phy/mediatek/phy-mtk-hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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




