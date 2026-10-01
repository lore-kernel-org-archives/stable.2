Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27094B827C;
	Thu,  1 Oct 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843414; cv=none; b=kLAwiJWquFd0mQRiiPeWGYIokKeQtHAjaULTaNGgEmQnYbHB6p6BybcvvzN3VZ5v32L2GLDqoV03wqSTOrgK52TjXExy4ucAVQ7hgyosE24aRiHsydxWXox8OdDXvmQX9SsreGUR3ANKyzx4It+jPgrVtASTLP2UIitky7UOdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843414; c=relaxed/simple;
	bh=w0QSNKMPvMNwWEzZGS6hCPEc+nmrywKd7ktFYHv8O2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WqtDBg17EU378kPb0IhIznCGJPqaOsvw43+2O53ojdnkZeVyh8guXl0KzXme2hxndCxDGrOqh4rQFWz+jlzxbBFBdMCD65qx/uCWUQkkrozOu3+bx/i9IGK76yPle50Q8A/qXaKCVTOa2LW/KErB8uUogKDO5kyuLUZkWOiYUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byDw1osX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byDw1osX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C09F1F00898;
	Thu,  1 Oct 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790843408;
	bh=dymhJU7LE7PbeKqUDP3nU7/VgxqoggQ+VbnMCZhERnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=byDw1osXZ+/H1VZ2eU89EzCA9n5Hf21vLbCdMw7CZvXGXGBLjvzkFMk31w/CVrmKP
	 pP0P9AcKc+sxvoGGgRosCzgCLIWoir5W6JhKjRvliE7rWmtjUCYSFOLdw4Ju7iUPD2
	 pTZsBUcDcYj1lpkmAquO7bbdDopMnb6Lg4eISZOSQLc2oRdGmrfgDbMDxZIvGvuCTh
	 Q610AWOmTgW0kLNXD9jD8/moHLWfYiBA9Mc1NtMfTamVIKbLgVGNM7BvDzaTkH7kAA
	 8sRMZUUr5Ih+ZNUkGEwM4Z28ugjoESwcNdrJL9Zmc3ncndZc25merovSeQGIhPURM1
	 LI0+eJwQ8YlTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A457380CFF9;
	Thu,  1 Oct 2026 08:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 0/9] net: stmmac: qcom-ethqos: add support
 for
 SCMI power domains
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179084340677.2325520.95323259899491825.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 08:30:06 +0000
References: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, vkoul@kernel.org,
 peppe.cavallaro@st.com, wens@kernel.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 shawnguo@kernel.org, festevam@gmail.com, jan.petrous@oss.nxp.com,
 s32@nxp.com, mohd.anwar@oss.qualcomm.com, romain.gantois@bootlin.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, mripard@kernel.org,
 christophe.roullier@foss.st.com, brgl@kernel.org, radu@rendec.net,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dfustini@tenstorrent.com,
 linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-mips@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 bartosz.golaszewski@linaro.org, stable@vger.kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com, martin.blumenstingl@googlemail.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 23 Sep 2026 17:14:34 +0200 you wrote:
> This iteration addresses several issues raised by Sashiko. Some are not
> addressed as they were false positives (nothing in the PHY driver ever
> calls phy_runtime_get() on the parent device) or I decided they make no
> sense - like the suggestion to remove the power-domain-names property
> because there's only one power domain.
> 
> --
> 
> [...]

Here is the summary with links:
  - [net-next,v15,1/9] net: phy: aquantia: fix system interface type not updated in forced mode
    https://git.kernel.org/netdev/net/c/6e0022b5ae3d
  - [net-next,v15,2/9] dt-bindings: phy: document the serdes PHY on sa8255p
    (no matching commit)
  - [net-next,v15,3/9] phy: qcom: add the SGMII SerDes PHY driver for SCMI systems
    (no matching commit)
  - [net-next,v15,4/9] dt-bindings: net: qcom: document the ethqos device for SCMI-based systems
    (no matching commit)
  - [net-next,v15,5/9] net: stmmac: qcom-ethqos: set serdes mode before powerup
    (no matching commit)
  - [net-next,v15,6/9] net: stmmac: qcom-ethqos: update phy_mode to the resolved interface in mac_finish()
    (no matching commit)
  - [net-next,v15,7/9] net: stmmac: qcom-ethqos: reuse the address of ethqos_emac_driver_data
    (no matching commit)
  - [net-next,v15,8/9] net: stmmac: qcom-ethqos: factor out linux-level setup into a separate function
    (no matching commit)
  - [net-next,v15,9/9] net: stmmac: qcom-ethqos: add support for sa8255p
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


