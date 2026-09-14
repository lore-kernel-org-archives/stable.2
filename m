Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C684398F5;
	Mon, 14 Sep 2026 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427764; cv=none; b=VhMTZSYWyiJ2uWV2wyEEMq7kyaxsULetrFh3THxkh67P8AbZW+ExL4iAHTHP/fAAAvlhYetNXxNvO2ZkBuA+DPDkHeKuXeqkCJlZVtBGQXsLxWiKFRDeveVXnVWMhxHqZarzIyagM7zpahpsx9jUvLr51Edae/MLCX+A2pXC/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427764; c=relaxed/simple;
	bh=PzXq7TWknRAUSjNmxfaso1E5sx7aLEp9WGufOTDgD2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1GIYZLXmlbMmIRpiSKmSGLBYjCd0vNkcCZ0VKw3q/IWxYM0qnEAXInXkEMj63OsFlpUQ5n5k6QFMVhO6Y6sats7eWlt0ASGuo5ffauDTFKRKJZ+rz0ZMfwUO0arJz+jYaVEOyTABzPqOHfj/0ODdRu+Pp3cHntKdi9k8/rrs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIzWyZA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIzWyZA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F941F000FF;
	Mon, 14 Sep 2026 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427759;
	bh=RwH+G4NIKOPDOx7e/oMm/7Vklp7Y5keUcHCNIa7SkMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fIzWyZA6UdmZD7hsC15psgVvwBq/uwrPdOgfhkHgj1S6Cuz2PkBpi2vJw6ldTH7en
	 4/YOUYZufDRk25xh7Qoqxd5cx9SmOhAV4UQeYqsCXBhHkYiJH7areds0K/D08KcUz9
	 wghgZVZPlV1i++y4bKcODpWeJTVjxXnOBBEdSms7NXhsuvlhDPc/bqDei2LrF0J77t
	 FZSfsmUFXNw1ySkFkB1PFaYfTDYnmIopXnBpG0BpYNTKU3NP/NFC3Lv9e747KEF7el
	 QtCPQ7FfKsKWKStI1K/XQHHdIRl6nUJA9ZvCfOs1k5HGHcRdu51e1k2U2vYBi2VTlR
	 WC9Da0tS7vBdg==
Date: Mon, 14 Sep 2026 16:15:57 -0700
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
 <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next v14 00/10] net: stmmac: qcom-ethqos: add
 support for SCMI power domains
Message-ID: <20260914161557.3b520b4a@kernel.org>
In-Reply-To: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
References: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 16:57:19 +0200 Bartosz Golaszewski wrote:
> Add support for the firmware-managed variant of the DesignWare MAC on
> the sa8255p platform. This series contains new DT bindings and driver
> changes required to support the MAC in the STMMAC driver.
> 
> It also reorganizes the ethqos code quite a bit to make the introduction
> of power domains into the driver a bit easier on the eye.

Sorry for the delay, this series got eaten by the recent patchwork
upgrade :( I will manually send out the AI review, would you be willing
to report back if any of the reviews warrant v15?
