Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787554;
	b=0VD5zBjPfCPUcUkByGHSNUnDLR6cutsCuyprPObJpBfGFc0bGLEtmqq7xS+3k3W8LNPp
	 Yscf2jDgf9raS4D5dmd69e9HdVhOaOFXzBzJIR8w6pgJM9e717P9E3eebrlxTkJ7wUo1b
	 ttotF5wuaHPXqjuXpId4OvOokVbsiHN6PZBHyi08qHGz3ewcjEvtP4n5wbFjvQZ7SF0od
	 aMem95MEM7i3F0bq03b7pv0D81hSupohQBLDPPVeI1xSo49FtpOCsYXWJxwdgL1WMjAfd
	 Thb/sdg88RmtfswVLyRPUjKiAkb9I7T8LLl5MFqmOWpX8tm9jSwdSb+BLBBFqdOUq7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787554;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nbfDLkQInsfA1IHCEvKdeWx/1DsneQC2nd/T70CuECc=;
	b=PTp7F6hWCim/1xt0WZow6O9dlVz41F+PKvSaDtb0sRbbWuYIugEMbieEGkyutjgMGVzm
	 G7tMxpQmOmPhClQWJ2cBOqCq6iDjCjodF9Ucdj4UE7GeZGgaRdqhNvyfBPl6o7uCA8R5v
	 KTY6SaU2WXppnei23lEG2BaNfnAGFy1ctnfrDhGTqtKWli5hAKsEX9EA4pMXW2oXfXBUL
	 zbEkKMV6Du2t+15jI0wdavruNnMosz7mPVjqg/WhScZIDSH0Qr12U+PlAyX3U8QEgFMe7
	 ENREEvlGm0HjjtMDt9uWhyipmRGLMyvkzSfeQHFInbe/rRfqKmog7MzEI3rukgPs4xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqdjKXtn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAE606A321;
	Fri, 27 Nov 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqdjKXtn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DCD1F00919;
	Fri, 27 Nov 2026 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787554;
	bh=nbfDLkQInsfA1IHCEvKdeWx/1DsneQC2nd/T70CuECc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fqdjKXtnxsPzwEun/XtC8U80ZnUo3i5anNTLRddpwxDrFy3ZC1No5srHiyVpOFpho
	 pJ7BAq/+6K0/I9kwETk/jbldSFOVX3CbyRLbdXB4TWr8+Q8a+NMlxBm6KzGMkbFxT1
	 nFgeGxRIaiQXggtfrUZDbxhL6Lf4cZEOcJAu7OCFYeEnMa3w9ZaJIpn2rodgVP/b7E
	 Zx+rjrhDZavLNCChGDJEdbi445bx1CVUYzdQATsbTjhmJEZq4eL162bln+FctpmNlm
	 tDx1oP98oOvwvmKZKOY8nGjMFcwG3WgwVxBrcrKY5Pu8pxFNxO3xPPnyEUNL5Ww3G7
	 aycTN63Q6uMKQ==
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
Subject: Re: [PATCH v3 2/3] phy: exynos5-usbdrd: return the Exynos2200
 high-speed phy init error
From: Manivannan Sadhasivam <mani@kernel.org>
To: Soheyb Boulaa <soheyb_boulaa@proton.me>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261114064400.45572-3-soheyb_boulaa@proton.me>
References: <20261114064400.45572-1-soheyb_boulaa@proton.me>
 <20261114064400.45572-3-soheyb_boulaa@proton.me>
Date: Fri, 27 Nov 2026 19:22:25 +0530
Message-Id: <179578754564.13164.705776957228110174.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=mani@kernel.org;
 h=from:subject:message-id; bh=elvZh/n5AbSfHdAwMngQCW+FoiVHt6RbiZU57XJW9s4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCYscDiUsjJdO4wJHJUYgxKKxeSu5mO+mfR918
 FApd7jSIsOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawmLHAAKCRBVnxHm/pHO
 9UudB/0SFlnl0zp4ide23j0GiR1TYrxM5vkeEzD8JB8Sd2mSD9S/H9QKug+J27y22IF32ODX2LD
 rMm3oA/075zLamZl+mCoSFRDslxcMwyHPUNx7LoG0ivX+twErJ++HUCI5WnondrkmoM77TzqesI
 +NVu/cIppSJeeLIkJyhVRrMO8Cdy9CDHd5xszerOlO+5sNZkY0daEuKZZTiHZEosqhqcll22rEB
 GAvLDkxLrx3afCI5m9d8JqoS8fvCNww+Ing6dNRigWzALhm4DAqisOvEKflNjxyctEX3rPHcCKU
 3X3kUP+C5unZgulHgNvlwEz7ssJIsCIci/q37LnNkUxAm1rv
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-14 06:44 +0000, Soheyb Boulaa wrote:
> exynos2200_usbdrd_utmi_init() ignores the result of phy_init() on the
> high-speed phy and returns 0. When the high-speed phy fails to
> initialize, the UTMI phy thus counts as initialized, and the controller
> goes on with a high-speed phy that is not set up.
> 
> Return the result of phy_init(), so that a failed init of the
> high-speed phy fails the init of the UTMI phy. The next patch, which
> exits the high-speed phy with the UTMI phy, relies on it: an exit after
> a failed init would otherwise take the init count of the high-speed
> phy below zero.
> 
> Fixes: cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm controller")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-phy/sashiko-outbox-205724@kernel.org/
> Cc: stable@vger.kernel.org

Drop the tag please.

> Signed-off-by: Soheyb Boulaa <soheyb_boulaa@proton.me>

With tag dropped,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


