Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FA44A409;
	Wed, 14 Oct 2026 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962882; cv=none; b=mlLdxW1wTe0pbg4iErzXwa9fWMI+57ABWXlY+mAO36Hvb/bbjHf6ZN163U0XNK35DqNb27LubYxQlM3akls6Bl3whrhYK800pdule0S8JNkd9i6WFUmHDxrFnqubOslSDkg3XeWS5aMAbZGoqLyF/D1OQRd8kRUEmPyuTTdnE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962882; c=relaxed/simple;
	bh=n3FTo4mK9R/lIGl5C3jeelRqRYzuENdY8tuLlXHAZOc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=vB1QUnbUz+uO1ZfC5JjNmqGHv+KyNqqf03s4gSdYZICfEx0VBBdmv6YsQJIv2+Ek3R+2k9J69KA3FapiX8kjG4xtQ654n4KBq1WhxUuyqnREsPdtSz1w8TJ9KJgVKzR4u3McqS8iZbIe1V3Libqn4j8dW3nyR93G+aFWv299zx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0AA1F000FF;
	Wed, 14 Oct 2026 07:27:55 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is
 already valid
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: =?utf-8?q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, 
 dlemoal@kernel.org, linux-pci@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260911211559.207990-1-ehbello@gmail.com>
References: <20260911211559.207990-1-ehbello@gmail.com>
Date: Wed, 14 Oct 2026 12:57:47 +0530
Message-Id: <179196286749.38040.5597453767131590054.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=n3FTo4mK9R/lIGl5C3jeelRqRYzuENdY8tuLlXHAZOc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzy72A6EYqXUa8oem4GQlieL7BdAjqrbq/LHus
 95HXXNGgXqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas8u9gAKCRBVnxHm/pHO
 9VzpB/9GLv7F5DEMWwQ3WZjJLu4Q7SDngruevsqLwGdrOGO7UOVSUAgVdr7yQ57EUHYIaeZF5jp
 Pl/kg+HBvpSxkjLex1X5MQSkf2u1VGWSk0SZT/0DsNYYQzNE/9oBlSZLEzdCZJeu/+/OyRl6Xyk
 LCuLsMqwOy+cVpFLHNsNLqxRjcnKBlDyVo+76vBGsF/woWmS9WeFOWS/I9RYFhJ5M2Qjrx0zJEu
 4UGxgjsyHy9OhBypKbC/c+0i59rAqfwMZn4NxjTHpwQEkQW1zgafnsKHcXnSdc2zrYqzVA3jBv5
 CkBZWRKvHxzrhppg5Wu6eG3LH4WUTlgxkkBZoiHvsH+0v0CG
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-11 22:15 +0100, Enrique Hernández Bello wrote:
> Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
> rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
> behind an rk3399 root port almost never becomes usable: the link trains
> normally, but the endpoint's configuration space never answers, so the
> device is not enumerated. On this controller a configuration read that
> gets no usable completion is reported as an external abort rather than
> as an all-ones response, which on arm64 brings the machine down.
> 
> The change added an unconditional 100 ms sleep so that PERST# stays
> asserted for at least Tpvperl after power becomes valid. The wait is
> performed while PERST# is asserted, so it also extends the reset by
> 100 ms, and this endpoint does not tolerate the longer assertion.
> 

This is hard to believe. First of all, Tpvperl is the min time specified by the
CEM spec to allow the power to be stable, not the max. Even if the bootloader
has already enabled the power supply during boot, it would've taken several
seconds for the kernel driver to probe and execute this delay of 100ms. But
claiming that the Endpoint doesn't tolerate this 100ms delay, but still several
seconds of the boot delay is quite hard to believe.

Maybe the issue is with the delay between PERST# assert and deassert? Is the
PERST# signal polarity on the board DTS correct? We used to see Endpoint
firmware crashes when the polarity was incorrect and the Endpoint got confused
with incorrect PERST# sequence.

> Tpvperl is counted from the supplies becoming valid (PCIe CEM r5.1,
> sec 2.9.2). On boards whose PCIe supplies are always-on -- vcc3v3_pcie
> on ROCK Pi 4 is regulator-always-on and regulator-boot-on -- power has
> been valid since boot, seconds before the driver probes, so the
> requirement is already met and the sleep only lengthens the reset.
> 

I do agree that the Tpvperl delay is *redundant* if the supplies are already
enabled by the bootloader. But I do not agree that it causes the Endpoint to not
respond.

- Mani

