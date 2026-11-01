Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793529778;
	b=GACoARljyO0LQKHxiD5LjIWo4je+xicnzDCVVxP56MMJcTTuM3jH5IyzJZmDJEwYwutp
	 B2RX2UXrsMkfR4/5XUpqXtecxv6QDVorMznsp1j2XGT7ieFPqFOiqrJddTUjIfdEH4Gpx
	 Kl3g8Sl1ZVTU+NUUagEPtPBaGqnZ3xjXfV5IwU0Oit+h89PErAcjGYkNvGto7rhzMtS7S
	 A+imYVPCmecipFfZnGg8+82G3TmWze7wpNGYsM6LtnRS+EBk3lYaep/VHiPpizDqkU5nd
	 1ZfM0ORYsmxvkS4Fg8JQeceaCF+x4SDfKPm92XHGnonbzLC0M1I4Wd0iJ3c0qbY3XSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793529778;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PBPRx2QNJQ+QM0zRSUMWWFQHyRX2kqxgGvHiKxzQ5A8=;
	b=yxz8V2K7UAbjqOv5PkCwc5VDzTq2rnvOXQ9jfCPl22N7nyEOT40akfiJFqaQIak/k2bf
	 Uz0Fc3v8f+TF6r//7bGq5kKBjrNvvu1mOAVQ230UR6cuCdnjYMgEAyEfqeGGWvhKkuSOz
	 VRpQ7Zm9BsBSwOVpXgT6jJKEiCNsd1Lo0CAg0Wrt+NrTDllL7E9M8Q4iSOxKOhIlhPqUn
	 bUj7dHqrOkiAtltJOQ6Wh2yCJpb/Xsu/0aUFir5r0N3sX2KXEcglBn9+TMfTrrC+JFe/E
	 DqLJReX0r8NoWhDkMvb7uO9Bf9a/Mlkw3CIjXXWbkj3DcYXTj1iQ6aWugnCtWMl8Ggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAVAyA4K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564E606A324;
	Sun,  1 Nov 2026 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAVAyA4K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A576E1F000C1;
	Sun,  1 Nov 2026 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793529777;
	bh=PBPRx2QNJQ+QM0zRSUMWWFQHyRX2kqxgGvHiKxzQ5A8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=nAVAyA4K5Ip5V7nDF+Ddov3KzTwTkvAZnBZmkLfMpOZqAe1W8jpTswCxwjxApOF2d
	 uWEVT6cMj8ncY8daPZBjhBEsqO36OInN7OvrtgfGMYcEfXIHWf3p3l+FVp2YMsGk94
	 ADLlsbdSH1CJd+nTCA4eagDj8bsKHs9bylLi+IjC9xYXiz3hhHMz7pRnmCbP7YpkNy
	 MWZD/MKOHPMKK+MgJupBNVZJfyBIyoUT+6PQA27VGQK9fHw6Fayu36ch16MWpstNKK
	 m39RSM/CnvSIv1hS1043R9jz73UwfFFwsliLHPUAuI6PWz8fYp7jXis93pieVx7Tzm
	 1Cbehw7Uvr+6w==
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
Subject: Re: [PATCH v3] phy: exynos5-usbdrd: Use dynamic phy_cfg size to
 prevent OOB access
From: Manivannan Sadhasivam <mani@kernel.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org, 
 krzk@kernel.org, peter.griffin@linaro.org, alim.akhtar@samsung.com, 
 pritam.sutar@samsung.com, andre.draszik@linaro.org, kernel@lvkasz.us, 
 pengpeng@iscas.ac.cn, kishon@kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jh0801.jung@samsung.com, h10.kim@samsung.com, 
 dh10.jung@samsung.com, akash.m5@samsung.com, hongpooh.kim@samsung.com, 
 eomji.oh@samsung.com, shijie.cai@samsung.com, muhammed.ali@samsung.com, 
 thiagu.r@samsung.com, stable@vger.kernel.org
In-Reply-To: <20261020063559.3530901-1-selvarasu.g@samsung.com>
References: <CGME20261020063617epcas5p4ba00854fcd38bf211c573629ee062621@epcas5p4.samsung.com>
 <20261020063559.3530901-1-selvarasu.g@samsung.com>
Date: Sun, 01 Nov 2026 16:12:49 +0530
Message-Id: <179352976902.2955.854677236716853573.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=mani@kernel.org;
 h=from:subject:message-id; bh=Q6hkz49Y7C/46IdSVDugqi0a1zuCwlweH00ODBFmM68=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5xeqiK17PAEwdnRzSQo+D+kWeupWASL+RwRYy
 NV3WdPKLxiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaucXqgAKCRBVnxHm/pHO
 9XGwB/93eMHO8R0XGhK/8k4EB0U2PnmWNCJCVbfPamNyDOKKBeiGai1NuYr6zulXn84LOYsKIPS
 eJ91TdkDlTCufw8wuxVITUBLc0xvlUXosHjAN8pWjLaHVSDeJc7dxWgZ6UD90LLJeV5GFzdHl/H
 d3G2K8pVPbv+Ot4vEAPJ0PJx+TUpvudlXs/9XLkEAqpvSEzdFcD8ZOBxKkJCcDU1Sga2/Rbr4Nv
 agRLt8rVuQYShZjkpqsFyQv3KDguFeokBg+zG2igGGZpNzAhI2hlobQezJZJn1hZNRqL727FwZ8
 j5e6gLrC2VPPr6dv/uXfFA+4y/BR+1PNQmP0DMHC0QPp+FgJ
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-20 12:05 +0530, Selvarasu Ganesan wrote:
> The probe loop currently iterates using EXYNOS5_DRDPHYS_NUM (2),
> creating both UTMI and PIPE3 PHY instances regardless of the SoC
> capability. Several SoCs (Exynos2200, Exynos7870, Exynos850, Exynos990,
> and ExynosAutoV920) provide phy_cfg arrays containing only a single
> element.
> 
> On these SoCs, when the loop reaches index 1, the driver reads past the
> end of the rodata array, populating the second PHY instance with garbage
> data. Since the configuration structure contains critical function
> pointers (phy_isol, phy_init, set_refclk), any subsequent access to this
> PHY instance via exynos5_usbdrd_phy_xlate could result in a kernel oops.
> 
> Fix this by adding 'n_phy_cfg' to struct exynos5_usbdrd_phy_drvdata to
> store the actual size of the phy_cfg array for each SoC. Update the
> probe loop and the xlate function to bound their access against this
> value instead of the hardcoded EXYNOS5_DRDPHYS_NUM.
> 
> Fixes: 59025887fb08 ("phy: Add new Exynos5 USB 3.0 PHY driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


