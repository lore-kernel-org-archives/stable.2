Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33D21A459;
	Sat,  1 Aug 2026 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785544532; cv=none; b=Ej+94KKuofZxa8HSHDnX+w7JeEaduVNnl/2yUrYFmFvAezO36cwOd5tYRP/vcDHq4tp0YfHliUaElPG/xBZNq7y883/1B1QyTLSbXnzL6tDRvu5ag578vsPNS/R8Vn2Ta0RTCnYeduhWICBNYywCGt2ZTSSH/vS/O+PXNejLrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785544532; c=relaxed/simple;
	bh=kFNPUf3nnfqfZfQU98wSE0rwkKlsgeL32eAvFj3Eywc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oK+3+Z0y3fboLD01kKaz06cLS9K6/FH+Ywyt1zwx+Et5m6WDIX7j61ZUAXXI54IS3jSy0G6iAuSl1tZl7b4nSSt+Wqn6jcxsiU8o6jia02VuC9BynvrMGgVrFqKMVBGH2SF6OXK7yCqY0i02bDN1JYbKjx+vQ26dokBXt9U7J0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uak10O1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uak10O1k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83DD6C2BCB9;
	Sat,  1 Aug 2026 00:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785544531;
	bh=kFNPUf3nnfqfZfQU98wSE0rwkKlsgeL32eAvFj3Eywc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Uak10O1kfSVvtmCusuqvW/oOAlsYMUTh42Wh8PRirDS7eP4/9DJoVeHxHsw+sh4p6
	 JAZImJZbuTjzmaQmz9NODgbEtnkE8R+hPr67ku2l/Q4ngZXBTDeCC0YRW5v/xiCTpV
	 rtg+/sbyNBrYfAvUFm6Q9U5ZqseRWR3/dEe1GET0CY1BxawhhjETAggtLsSfiLSjgD
	 YueJHoXU8sbHqRIrq9dGjh5KvNPCNbxQsNoQ2ayyYKdB2w3D2dBKNIWduXYNRnx5vM
	 V1Vx0jxVWxnl129w96ZEF7+QE1NOGmjv/Z37nApi+v6MiCoB+TldwrYYth7AgCl6/P
	 jic/3/GSPA9Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8A9C55172;
	Sat,  1 Aug 2026 00:35:31 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 0/4] Dongwoon DW9714 - correct vcc/vdd supply voltage
Date: Sat, 01 Aug 2026 02:35:19 +0200
Message-Id: <20260801-pp-pro-camera-v1-0-7b4d90788f9f@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAxA0atI1gZaFZG5yuAitlEjqCVVEcS7T
 0eXb/H/BZFVOMInu0D5kCjrkmDzDNxIy8AoPhkKU9SmMRZDwKArOppZCclW3lJfNaXzkJqg3Mv
 5/L7t67h3E7vtP4H7/gHafm74cQAAAA==
X-Change-ID: 20260801-pp-pro-camera-a14d1af483cd
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ondrej Jirman <megi@xff.cz>, 
 Olivier Benjamin <olivier.benjamin@bootlin.com>, 
 Manuel Traut <manut@mecka.net>, 
 Alexander Warnecke <awarnecke002@hotmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Martin Kepplinger <martin.kepplinger@puri.sm>, 
 Shawn Guo <shawnguo@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 phone-devel@vger.kernel.org, imx@lists.linux.dev, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=kFNPUf3nnfqfZfQU98wSE0rwkKlsgeL32eAvFj3Eywc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqbT9RB78Gi5Ef6RsTjwbROwWR0JA3cAkM3fw24
 7XS9hPcL9+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCam0/UQAKCRBgAj/E00kg
 crkRD/9UmsyBi/RwaU1Vjh8viYNgJJWAcIj+wICF7ZXkmcfaWQDJppVmp1ssckklT5/WM1j3DHN
 mTDmszRzZ+jz0kYiF9kyc5mnk9+fQKcLKp+m3o9z70bpShyY7kqN5VxmuyK9n2XqOMKGN+jVNFc
 GuZ8EmzC0ebIYPzmfD2woBO3I5o9xobiljACx5iWwmlRsGGX0vPD8OvrFOYPooy39at8p/tJalV
 cwPOgvz7VN3oSIbRfMS2eJ2d6kKBRUq9ssjieIAR+AOI/fOyYpWafxUOpIt92EBozLE546tS5O/
 movPjfaWv4oE3jj8ETBQSzPekesMgb3b6x3lSVJm8brFyx/a3cpQw4STJ0/KkMVTzMMpfQ7mZ/J
 bCPG9Av/0lzUssfmFG5PoPoZH5L71skTRft/XZZheeDgv1QkxsnhFu5e6scKJsKy1gbajcSGuV8
 a3833Jn8j7e8UPsnCJ4raXKgNSYY2uO/u8SVqv1kJafYVLVU/G47No9MpBH6YP3hTdU6pwfo5d3
 nsQGpF9PzEdcEySihLXoVkvpAyMwoCC7uOUiYldqUZn33kGial16lPxVrWMf3jxJxg2ypEhYlJa
 0dmMESW99y+cHGyU+6nmpKc3LwZZAtcGE0sHo3QBz3/f3gSHGnnltifwyok79NHoWZlcNSW2Xux
 YoDzD8cdfv6beMw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

So much mess, as people defines 1.8V i2c level shifters instead of VDD.

I don't pocess any of these devices, so please test carefully,
you may need to in addition to this change put regulator-always-on to
the 1.8V which was previously abused instead of VDD. Careful about
combination when camera which pulls in 1.8V (usually iovdd) as a byproduct
takes care of i2c supply for the coil.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (4):
      media: dt-bindings: dongwoon,dw9714: Example shouldn't imply 1.8 V
      arm64: dts: rockchip: rk3399-pinephone-pro: DW9714 coil requires higher voltage
      arm64: dts: rockchip: rk3566-pinetab2: DW9714 coil requires higher voltage
      arm64: dts: imx8mq-librem5: Dongwoon DW9714 coil requires higher voltage

 Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi                | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi                | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
change-id: 20260801-pp-pro-camera-a14d1af483cd

Best regards,
--  
David Heidelberg <david@ixit.cz>


