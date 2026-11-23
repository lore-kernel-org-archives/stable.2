Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449729;
	b=1YxwwNOuQbSkm1H+IVAZoaaxrNZYWcWUkMVD85vYZYnJOkFSCnvECx8KsHz+i4WSjwPB
	 jq8J4FpGRbtEUVPMVDjUnTvVEwSQmORGVY+ZoTGFL63CyHhbbkuZ0oCznqbLgCg/55Ujb
	 YCJ3MQnOHXD+OzdxaBoLB+rOU8sdeAE/NCllQLmnuf+c0hCbzvS2diBdu6eDOLOpIPn7y
	 /wxxclg1/YH8F2oJzuyumP9CFhXU08ciS4TQleLCLvzPsZy8/4LgyBYJblg70CxEibRvo
	 bcDLe1Ea8EiG8BdepsQCwd8NlmHd3ITVHRG0yHDcKBDNPbU0EFj1uWqZmqprpk2i/pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449729;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=N1Kph1Jnk+DxQD2xwzYoq4HTvoREjcNCOFAcKHlvXLQ=;
	b=MGsCRoPtokpzbIGu76I5l4yMQYQEkNR5ktGNoCkZ7KUVs1peX2yYUaehUwpBg4a90JCJ
	 RXXNv9AjVML4CDlzpCqGzWcCjrTJgk1+n50c4o0T7gjgDnNCCSS9uLM+FGABRqbCiw6Td
	 EOO3cPs6E/9mJnH6dIbAHkpHgaMCnKMJBI/1RYmXGbsgOzG8tDivY8p6vvX1l8HAhRYgC
	 W2pJxyw4F9GGokv5DSmichK9IW974q3AoxkhFeYFfL/5UEl2fEKgims/jcbnXi1H4FYlJ
	 BgHT/rVtsZF4uWzHOY7qi56RMmL+eX+BQrExVPJskOrofoocrOWw5FjNmeJ6oG+p3Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbe9rZ1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F33606A321;
	Mon, 23 Nov 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbe9rZ1M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E901F000D2;
	Mon, 23 Nov 2026 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449728;
	bh=N1Kph1Jnk+DxQD2xwzYoq4HTvoREjcNCOFAcKHlvXLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fbe9rZ1Mv1u8RJWaAxnCXG49oerJ+CjiUI0zg42zlZTlVgKSbRM7B7/pXkEAdbaNj
	 IWTlVDP4ABD5HLR/QmfRjs/cj4KIbOQ0B2chPcGTfz5qxNl8H9JbcnD9GX1BVVZyrW
	 is0BxM+OAQDFWELHwPJhABcimE7uC9rnYVpv2/mLvzaIx5rtlV65/do/WKiemXp6rq
	 WMTrLCHChMnIUJq+Cx9HaT9SgIyuvlNkbvLX7iugA1rxo75MXLAhdVgYcyMMV1uVpe
	 xm4OrfE2pmRC8bn+D4fMl6jFugDJckS3YsXafVR7kACdUJ/uL7vVNDwXqIFvjWeU8X
	 tqb3wafxFup/Q==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261110-9f141e6bc8-phy-rockchip@mail.sdu.edu.cn>
References: <20261110-9f141e6bc8-phy-rockchip@mail.sdu.edu.cn>
Subject: Re: [PATCH] phy: rockchip: inno-hdmi: Fix potential stale clock
 provider
Message-Id: <179544972583.261285.10042942204136038609.b4-ty@kernel.org>
Date: Mon, 23 Nov 2026 21:32:05 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 10 Nov 2026 22:32:25 +0800, Guangshuo Li wrote:
> The clock provider remains registered if PHY provider registration fails.
> Device-managed cleanup then frees the clock hardware and PHY private
> data still referenced by the provider.
> 
> Use a device-managed clock provider so both probe failure and removal
> unregister it before the clock hardware is released.
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: inno-hdmi: Fix potential stale clock provider
      commit: e7d2f93a4426ea6b33dbca1ce585a9876e3a7344

Best regards,
-- 
~Vinod


