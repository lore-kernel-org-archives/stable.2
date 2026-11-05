Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893186;
	b=hvGolKKxb2HcEd85Wz45RPqPc90L/JU7ygHvlJkSgV9jnAzMjvgVX7qmqo1GQBvtVIVt
	 GpQHBKDmvIlw98YCjClRwgxoxSga47h8HtLNW1O1/Raw4DDoDmhF4nkSj6ZjmjfEmMqNB
	 C+p5EpQWywNFF23pporgow3S8MUhKPaLQ5qqy5aNhTFdoDenbdRB8zI44VTKkJijMJxUq
	 DqEb6J9W1O71jFiv3+HBxKCzor+Zdoa4r5bPuAjaDwS84lhG/FXR4p8lam0inkd/LqSvL
	 G6sODAJ9jN9RiqUURVCtj6mYEPu5jOJjurOhXBEMV+uJSEQc/lOjF3sraz3Co8JJitw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893186;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rrLFK5eWrBXc0loP3mJGaIySnco8t1hp80KHEN9vJv0=;
	b=NYUgC3jGGfIobTvXk3xpWEniRBifTEmWo7ZUa9egHVLP7Wn2K4cnbX+xp6IcFnAwdgbH
	 +eaM302li+9+ObufYD4j3cDOTAIJWsM0MxRh5U6pLtoD9VsFJd1qmd3Ni4v8YMQgXjlOq
	 HG2TkBSvYlY0FC8IMBvqwQB7XjGtzugPhO/oRgZYEgx2dF8ZwVSsMbTcqOH908F8t6/oz
	 vxpZIzWOZeP7pysMheD0EPZmJsyWIvhfcOgZMxS4//6c51Q5zUHNyPTePkX27yd+9GoUi
	 F6TgdOVi8Dyu5OLJztIdL3PPYhVld6Na65jK39+OGyHODCsQNfVmsQimG2gQyIvomhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqePU26M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE733606A333;
	Thu,  5 Nov 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqePU26M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103161F0093A;
	Thu,  5 Nov 2026 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893185;
	bh=rrLFK5eWrBXc0loP3mJGaIySnco8t1hp80KHEN9vJv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dqePU26ML7gO+U/2yg8vM1PYVhkWJSdnJ633spLV7XwvAnITGa4GGpvMGsArk1pgm
	 jljmatc/r7ixiYDkbghNibL2wotD0DXBk9Gubb/KC0pUg941/wk59HneG89+H4BN2d
	 kBnRNUVukKtMaQpIUkpRRjPy2YONwRiq2n49zdPwRmzNqd7d7adNxSRiI3Q81Yvzk6
	 +yEp0JRzTBJ+L6LX60qpKp2HmGXbstw77ZAUApBYdHpicVaTV86soXOpwHB04tIKf5
	 82kfs1jmElf8p4zMat2XGploymu5itFb2uSpfHZLsNfmS/jlw44weg91IWbPY/DVc4
	 h4H3G1JIYy+sg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marc Zyngier <maz@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Janne Grunau <j@jannau.net>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261024-pcie-apple-perst-gpiod-init-v1-1-f92f30f205ef@jannau.net>
References: <20261024-pcie-apple-perst-gpiod-init-v1-1-f92f30f205ef@jannau.net>
Subject: Re: [PATCH] PCI: apple: Avoid PERST# deassertion through gpiod
 initialization
Message-Id: <179389316726.20463.7171297669724795496.b4-ty@b4>
Date: Thu, 05 Nov 2026 21:09:27 +0530
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=353;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=I0up2dLk+Ywfolzsqis1NwtJvY+337Ek07YtxlvTJOc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7KM7O6uKyQ12J8XNJljUKgcItORJA5C+nqVmM
 IDbXFsO+DmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauyjOwAKCRBVnxHm/pHO
 9cVvB/9/0KzTUrowNyG65RSPQ0wmzSbtwi9As43NFLgEt9G2JVQmvT0mHxmtWKDcZhpp5Ul2Ivo
 lQ/sKwDu0hVvXFrRa/rynY0YqW11C4fPYMzMGAZaV+NztM339V4+ubzKgyqrWV+rte3EItK9Ljt
 yZY18XPZkFVIzgYI0VUouRCRDMKuPNua+pd5mDp48GOkl1c29XRrp/G8cvaGzyIPPeovZYIIy1n
 dTpbAVDhv5iPsgPjhsY3OxS1GJ7P22aqqpX0dY2Yevpr2LttATnfTX2hGDwDEg/yrLXxdVYTqOM
 R6Bc8xtnberEVdKbB4b65ZXgveb4SsQPJpneeMb2Yvu272f0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Sat, 24 Oct 2026 18:46:54 +0200, Janne Grunau wrote:
> PCI: apple: Avoid PERST# deassertion through gpiod initialization

Applied, thanks!

[1/1] PCI: apple: Avoid PERST# deassertion through gpiod initialization
      commit: 3368c2962701c9eca5c6095196f3ce587930f8a2

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


