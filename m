Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482823;
	b=GRQ8nSIjluv+wWevV9JrF8MSDkxnmT/9D7I8bVPizq8udoUQvoLrzLdOx8AlQlC6Z6yc
	 FHiZ99R2eoknLfwe1phxvmLuXJZWPMiaM1LN97qHaUYvm7t8WH8sCT3WgvdxlKzrj+DEM
	 WFnQbaWE3EB7/JOiD/JJHcA+U4wSnftTn0txUaZOVNd7fNgj1SKX2F/xFtMOONCY2PEch
	 DRo5obpgQDNchCuaQy/naLEUTYD7eExUWzCleB91xyz9p0whzXGOBf2Oj6RvcHgNn5+yW
	 6V/8vQw95bbZdaEdI0QWrVNrcbwTMB0OXiiP3RoJg94MYWYWcmJyw9FBDGEfpTkU9DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482823;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=O4AXPfiKbyDpre+CB6uNRY4elkcJBCP9G8bvuRhJYmw=;
	b=XnyxEjfMkdezLuKHwfdpoBrIGHarBUaDbT+GG8+ktWfE/xLYeKvXY/nse5k7KIyg02f7
	 DDa9n1XfgRFU9tn0McFABObvs6RHOLLBC3Iat+D7kTmDdz7RqbDXGNrki3h6kfdFOSWQ6
	 Q7nouzaupjiLarAH4nDAc3XOujmbRPPTzlH8cWrMD+RKz85vuvWO+lwQFAQWuuOgiMCk3
	 1lP9pX/hyCGv8XGJGeTbXHrhTA6/fsaw90E5BT/UoLSKbKF6RcLcskV2l73dW2N46bfkm
	 eOjB3ST5YiYy+eNi5TscFnqg7z7P2hs7758x8EJUDk4HCxDPCnesXDSsQIRV9oaYWZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ybcb8Dfv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3975606A331;
	Thu, 12 Nov 2026 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ybcb8Dfv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F951F00A05;
	Thu, 12 Nov 2026 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482823;
	bh=O4AXPfiKbyDpre+CB6uNRY4elkcJBCP9G8bvuRhJYmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ybcb8DfvJJta43gpnhAApzXPdEbGDIo6BxvlEiV3cgQi+hMbTguU8+tzxFY970n8H
	 lAf0aUSMrjjvueWzhwLzG6mzZKi1ac+ij1FlV70wuRR5ENj6eVsvPW97/aZ4JFDl9P
	 SItvqxet/FaHTHTzOGOQ8X46vnSiZhtIqp/d45EAvfiRzPqQ9lddb9AxQllWdN6taf
	 PueIJHjQIdLyGkXJSDlJ6OZjXr6Ii+w6sH4Sht/6omTTRlRL3Z9FM4Mi0E+9GpHbpw
	 vuNphCR0M9x69chCkgI4+VW8ChioDcN9xpBRgREkpqLRjhMuLpd49bcMFxfoV2WSiH
	 vO4Hfn6M5Wqnw==
From: Vinod Koul <vkoul@kernel.org>
To: neil.armstrong@linaro.org, mani@kernel.org, krzk@kernel.org, 
 peter.griffin@linaro.org, alim.akhtar@samsung.com, pritam.sutar@samsung.com, 
 andre.draszik@linaro.org, kernel@lvkasz.us, pengpeng@iscas.ac.cn, 
 kishon@kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: jh0801.jung@samsung.com, h10.kim@samsung.com, dh10.jung@samsung.com, 
 akash.m5@samsung.com, hongpooh.kim@samsung.com, eomji.oh@samsung.com, 
 shijie.cai@samsung.com, muhammed.ali@samsung.com, thiagu.r@samsung.com, 
 stable@vger.kernel.org
In-Reply-To: <20261020063559.3530901-1-selvarasu.g@samsung.com>
References: <CGME20261020063617epcas5p4ba00854fcd38bf211c573629ee062621@epcas5p4.samsung.com>
 <20261020063559.3530901-1-selvarasu.g@samsung.com>
Subject: Re: [PATCH v3] phy: exynos5-usbdrd: Use dynamic phy_cfg size to
 prevent OOB access
Message-Id: <179448281584.507383.1286765834477602323.b4-ty@kernel.org>
Date: Thu, 12 Nov 2026 16:56:55 +0530
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
X-Mailer: b4 0.14.3


On Tue, 20 Oct 2026 12:05:59 +0530, Selvarasu Ganesan wrote:
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
> [...]

Applied, thanks!

[1/1] phy: exynos5-usbdrd: Use dynamic phy_cfg size to prevent OOB access
      commit: ba6618a1e7c02f384069f7817133ff8cb5c793b8

Best regards,
-- 
~Vinod


