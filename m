Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F33D8908
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839933; cv=none; b=Er9IFYQ/fgAKd5j7K6jT2gE6BGIF0TcgFbLHUmk8aS55dORc9hl2no9st0QU4hBSmhTrpwHoZjl3rLP5AVWpl4sOFO/C9DXSWHUHad5RYNPC5rXEKiGpmGCFYh8sBbWT2Y0t0ww7f9oBVuoyz+Rp6MRMUYTZPmknBiZqGrqcGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839933; c=relaxed/simple;
	bh=ELdBCMU5f7/O4ZMIta9o4UVKjIIZnw/X5SSJeT3GM90=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5SUp0WZcd3v4o0+U/VSTiyCCun2xyq/nSiqoik6rOgfAgporEU46k3d9pBB9WY5CGUJ2skupQmOIX+YO4IlT7EFGURDVqFGPPuxqNTkrlQuW9XDp7cRLeEEbcssutpmzqySObfWPAl0H5a8ElVibm2aHbJ2Vu3jTgFyNtkrIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9ED6Xoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9ED6Xoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E48A1F00A00
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790839930;
	bh=ELdBCMU5f7/O4ZMIta9o4UVKjIIZnw/X5SSJeT3GM90=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=m9ED6XoyFU6f6NSxPdVX7ZgGtbARjsD/CvfZD8tuhOkiZ6dKnPRKSRSktb3gLidmc
	 VPbCeYi2IKHwWOv9a94mqT6hb1QyGGIuQBER4nXjiOTZRozsX037c2spwbLmYAMdft
	 hSocy81uy0QFI/ZtDOvX28+07QuujnXHssLX3bpIUqE7ULrFoS3pV03E333y7RCNzK
	 HsH5YwqLVDE8Ag8eULAvrQkln7YBVbnRdOZn5XnVa80W1ViRxENJZnXfTYVrjFagcy
	 G3vUUO2AFJbwfAf2/N1XRAUG8lpRgJF09f4ryfCh5u+wg5DjSHuu95Tq7PJHOpKRZi
	 qrKAsvE+hguKQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba42966d5fso788310e87.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 00:32:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx1ekII41hIuzmogDJniFQoznqa+56Nvx8pP39OPrJL2ymFrll5q4i+5BltgB68OxAPgpj7rU4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKU8ysLvG5sf4/dAL2TaeyuphLZGdS9Ldvs8orK6yB1KRMzjLF
	3LvlNwWYosg6l19KO3PJHOMmiLt1zMNuh6mfOc2ndsRvOQK69q1u7ANF7fxegtIEAzUf5+6YZZN
	/nzNC2La0boOs6aIeCk/Ydnw3CU6aZjqBO2GhlkBMaA==
X-Received: by 2002:ac2:42d0:0:b0:5b8:f97f:7a22 with SMTP id
 2adb3069b0e04-5ba405ec7a1mr1161789e87.54.1790839929167; Thu, 01 Oct 2026
 00:32:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 10:32:07 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 10:32:07 +0300
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260930163334.60b4a88c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com>
 <20260923-qcom-sa8255p-emac-v15-1-e82f33720737@oss.qualcomm.com> <20260930163334.60b4a88c@kernel.org>
Date: Thu, 1 Oct 2026 10:32:07 +0300
X-Gmail-Original-Message-ID: <CAMRc=MeUx2iHf8-d9yjZZ=n7VaG_GROvO2dW-bxavAS+XbGMFg@mail.gmail.com>
X-Gm-Features: AclHuK8P_ZwjJ__3SNp9LNTCdpGSDaQAP4RQWoM4JsBj1lq1vbQDeX8sSTrNEMU
Message-ID: <CAMRc=MeUx2iHf8-d9yjZZ=n7VaG_GROvO2dW-bxavAS+XbGMFg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 1/9] net: phy: aquantia: fix system interface
 type not updated in forced mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Christophe Roullier <christophe.roullier@foss.st.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Radu Rendec <radu@rendec.net>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 01:33:34 +0200, Jakub Kicinski <kuba@kernel.org> said:
> On Wed, 23 Sep 2026 17:14:35 +0200 Bartosz Golaszewski wrote:
>> aqr_gen1_read_status() decodes the MDIO_PHYXS_VEND_IF_STATUS register
>> to determine which SerDes interface the PHY is currently using on its
>> system side and stores the result in phydev->interface. phylink relies
>> on this value to configure the MAC.
>>
>> The autoneg == AUTONEG_DISABLE check is not correct:
>> MDIO_PHYXS_VEND_IF_STATUS is set by the PHY firmware based on the
>> negotiated link speed, not based on whether autoneg was used to reach
>> it. When the link comes up at 1G in forced mode, the register correctly
>> reads SGMII, but the early return prevents phydev->interface from being
>> updated. It stays at whatever value it held before (typically 2500BASE-X
>> from the initial autoneg run), so phylink configures the MAC for the
>> wrong interface and the link cannot come up.
>>
>> Remove the autoneg guard so that the system interface type is always
>> decoded when the link is up.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 110a2432c520 ("net: phy: aquantia: add downshift support")
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
> Sounds like a real regression, is it? Should we ship it to Linus
> tomorrow so that it makes 7.3? stable + next does not compute for me
>

Yes, this is independent from the rest of the series and a small fix. It sounds
good to send it upstream ASAP.

Bart
