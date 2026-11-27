Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787687;
	b=BE8CkqgSIh4TASwfBXcIrrM6G2YFMgWzjr3nlnSWVbDZrzIZnVx+FjnRI+rZLncvFFAD
	 BVYBT1QZBXvr38EFqsU7Kcj9Bkm0pSJF2X/7KYvWFR554YLXeQqERk1U/QC+r3KHnKtb1
	 8psKa8uHu7HsD6ti2x1tcD21zEz4II1shUEOi2GdlWQKpIIKPaic1gPWHbGnhkEVoJAUv
	 JFp+zIxPcE1aLJmRZw7v5D5UpMKjbrywZKJhuZGgn/6ASVBiJnNW5V7B1jGoq6BmOk18y
	 eVHrp4wSPGl8ZyUVsH1sWeB9SdgjdgPrKQfAwi6B6iGNm0HhW+M28k/hBvhiyXUD77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787687;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ihaNk17hqENSXbY9COGf+8Q0e2XiJjXPQdUUyev7UHk=;
	b=oNBartppeLGdQaIUGRo9PnwKtEQFV0djdE4eaWqdyJaMu+ETTk+myHpS74FTBC++9hae
	 Q46NGPuOlJkoDHSjiLze9+pm/rJhiUYtf4/z9iKXRFEhPHKmRqHV5PwqIeVc9heQvXwbm
	 7Ke6454acL/S8yJjojCs7aP/GzHx/5mjMe+p0jJLnM2uC51To4IhfBdaacrsN0s35TN9Y
	 8hYxda6slgJkd2Ij+o/EUMU1F+6X7bffPN3ACbI16CKcVjxASZ8cx7SOjtadZGamCT9jh
	 k87xl1x5oXFbicJkBfNQwvBQjQ8YUUVjHrL9Zee23VZIG4wnCvjl4GA2vukiveZPhTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBrzati9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684E606A32C;
	Fri, 27 Nov 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBrzati9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B21D1F00893;
	Fri, 27 Nov 2026 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787686;
	bh=ihaNk17hqENSXbY9COGf+8Q0e2XiJjXPQdUUyev7UHk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=EBrzati9JhcbB2R9MVAsDvs/3N6Vf1bh0Aooa1tg26NApbNA1dZUlgFy7q9FHDcxF
	 pZTMotJWV+a6HtIPzZKNausCBV6Fg6CNo60U8ojPUYPIe62LoyXKaPshYUZKu1c0VN
	 8bSRRe7DUvAJyO+wSnJRAA2S+Ph57kUimsl5vIy8YkkxJmepEq/UPFwqQzWbrYJmNl
	 XuBFLMPPA26+L7aSjqmru2GCE0/rFUezd9LcOFx6xmlAW4AQDwLsAS+UCSXfvLrpF8
	 CL3thFbuTn1DG17yeQ+wrRIpy6fPt+4dQ2P3d5vta4sqYiZB8q/EW8q6ZpQbcZP5MY
	 NtTzH8tclBZbQ==
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
Subject: Re: [PATCH v3 3/3] phy: exynos5-usbdrd: fix HS phy init count
 imbalance on Exynos2200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Soheyb Boulaa <soheyb_boulaa@proton.me>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261114064400.45572-4-soheyb_boulaa@proton.me>
References: <20261114064400.45572-1-soheyb_boulaa@proton.me>
 <20261114064400.45572-4-soheyb_boulaa@proton.me>
Date: Fri, 27 Nov 2026 19:24:38 +0530
Message-Id: <179578767823.13164.4595964054834995547.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=mani@kernel.org;
 h=from:subject:message-id; bh=moU+LPCi/fmXx4hUo8rYp5XjV9/dvpjSZdoJhSaoZnI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCYuhDHABi5d4RO5C0tclXwG3gZMS18Mt9rZYQ
 xgayjpt5FSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawmLoQAKCRBVnxHm/pHO
 9UYYB/44Ifkb6x2lMRRwQqwm8z+PFDfp/Kd7Y7xK7P65lr4oG7LHKgHYysohIcfbkDRH7FGkR1f
 ecofjz7Fz18DVur6zlCgp9s19198l0YjtM5PpS8U3CWrfNCOWUg6dwH+VvO7lUifvZMlF2L9Tgw
 2GtLfpsQ1q59Q4KuUbS6q9bVpWdUdYQX9aCn+osfepYzVxrfQbMyp5zObPdMOxYrv4Lhml4QfvP
 USFMxBhpc5RVplx0MurolHM9hgDG1V4l75Qr5tIR43aJUpnLEKIhMwj+4Ce/Hu59io8vCzaCs2c
 w7AVM5hiWTvDqdW+4My0Ii35ijvNrWu7CYG+DmUUpSq9Y6gp
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-14 06:44 +0000, Soheyb Boulaa wrote:
> exynos2200_usbdrd_utmi_init() calls phy_init() on the high-speed phy,
> but exynos2200_usbdrd_phy_exit() never calls phy_exit() on it. The init
> count of the high-speed phy therefore never drops back to zero: after
> the first init, every later phy_init() of it returns early, and its
> clocks and supplies stay enabled across an exit of the UTMI phy.
> 
> When the high-speed phy loses power while the controller is suspended,
> it is thus not set up again on resume, and the DWC3 core soft reset
> times out:
> 
>   dwc3 11210000.usb: DWC3 controller soft reset failed
> 
> Exit the high-speed phy when the UTMI phy exits, last, once the rest of
> the exit has succeeded: the phy core counts a failed exit as no exit,
> so the high-speed phy has to stay initialized along with the UTMI phy.
> 
> Fixes: cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Soheyb Boulaa <soheyb_boulaa@proton.me>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


