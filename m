Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2D39022A;
	Wed, 30 Sep 2026 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811217; cv=none; b=MsJKfniWKSh625PQ6LdMbANthgm2/1o9YSrPeBjQ8J1VK/k+xoKqnx7c6Cj/69RGToFSlIjfvTRvL3/0S+8PbOPOtykOjm4Jl7JMBQ59b4n2VLQy7Rd9eRB7XkQl5ngXLEwHUeYrZVvJ3hfq23hp8IADoJMyA3eVWBgo22dUg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811217; c=relaxed/simple;
	bh=+i09NqmEGvWAgOQSu2JzfsI3KQxK9zOuELeNfrb/YCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdFc8MebTcEtRpI38c4U7Mqb5uq06qf0EMlnd/iNJXyTRs75LWwXRmQqDpC6rVaudKNL/WqEtOmV71fYcDYzMrLadjlMrDO7HykXTZO6K7vM3YoqBLjhWYvEhMdkObJXLLrV1qkoBN3K+LQP8cxFuM7FqC57T93njBwQKo5LCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM5V8kpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM5V8kpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C986A1F000FF;
	Wed, 30 Sep 2026 23:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790811216;
	bh=FNK/3xFH9eCNhn2rwMTGwfSucgaTbz1Hnohkj9sa4DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iM5V8kprPcqUUtABn8RdjhABq8ehgpbe8HkhOI6mg+s6DDKlOTP6XWs6thPr/T+I+
	 /09P8WKMmvjdyd9hwWuizmemuZFg7YuxXw9f9Brv09nH6OLcgcU76tG5N4hEZyNNlI
	 Zo+uMo1F5XPzSsJZ32D6FvkicUSSMBjkatis4KkJFCQN0t3VLq7UGK8LxQCpl1av3z
	 ZJNQithgImxzAK/2VUJnPm6zHvoU+EMoQ5ljVKWox7TTZzzayUMw5jor3CpTrJj0xJ
	 na5+drmiYFcHLS05GrUtvwtT7DGiN6sqyJpsRJ6y0oH73+IUGcfukvWLxscPl34msJ
	 IgWcMfc7EYn9Q==
Date: Wed, 30 Sep 2026 16:33:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, Giuseppe
 Cavallaro <peppe.cavallaro@st.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, Fabio
 Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 s32@nxp.com, Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Romain Gantois
 <romain.gantois@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Christophe Roullier <christophe.roullier@foss.st.com>, Bartosz Golaszewski
 <brgl@kernel.org>, Radu Rendec <radu@rendec.net>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Drew Fustini
 <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH net-next v15 1/9] net: phy: aquantia: fix system
 interface type not updated in forced mode
Message-ID: <20260930163334.60b4a88c@kernel.org>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-1-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
	<20260923-qcom-sa8255p-emac-v15-1-e82f33720737@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 17:14:35 +0200 Bartosz Golaszewski wrote:
> aqr_gen1_read_status() decodes the MDIO_PHYXS_VEND_IF_STATUS register
> to determine which SerDes interface the PHY is currently using on its
> system side and stores the result in phydev->interface. phylink relies
> on this value to configure the MAC.
> 
> The autoneg == AUTONEG_DISABLE check is not correct:
> MDIO_PHYXS_VEND_IF_STATUS is set by the PHY firmware based on the
> negotiated link speed, not based on whether autoneg was used to reach
> it. When the link comes up at 1G in forced mode, the register correctly
> reads SGMII, but the early return prevents phydev->interface from being
> updated. It stays at whatever value it held before (typically 2500BASE-X
> from the initial autoneg run), so phylink configures the MAC for the
> wrong interface and the link cannot come up.
> 
> Remove the autoneg guard so that the system interface type is always
> decoded when the link is up.
> 
> Cc: stable@vger.kernel.org
> Fixes: 110a2432c520 ("net: phy: aquantia: add downshift support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sounds like a real regression, is it? Should we ship it to Linus
tomorrow so that it makes 7.3? stable + next does not compute for me
