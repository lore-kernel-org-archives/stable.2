Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21372630;
	Thu,  6 Aug 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033583; cv=none; b=E8E1mlmyf2jnbu2Mh1NGdyM6l8aWicHBB8RGuLpIbfUvqjd7jwvZVXLlfPmjUpP4MmCXCGBCUfwWxIUqFYXM/lhn11VfMiIpr0aIpwUGddL2j7Vk8aTEPS9Sno35gNh1kn5SiLiabWN9Ko9L+GOBfq64Tg7u4Izg8e/wM5J9YBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033583; c=relaxed/simple;
	bh=71b6YNmp66lLVgh61Y9Ckha0QEZ3/x+A+zoIyexzidk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MyXEw6ePZ9O2PQ8ENslGU6EXS4Og1T2BvuE1VAtR7pRRxZT0AclrklMF1UczN7t+nlLHjqLZ99kLD5e+HtkIYzJJNL/lKSjhgWoEkk7RR744Ld3iOHv/iu7ZORGDy23C860KkvPwWexwYxmdLGWFhITPz1H46btOcAJuIcIlPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCI2qc4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCI2qc4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4572D1F000E9;
	Thu,  6 Aug 2026 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033582;
	bh=Jg/NzKtGUicQWYfSzQGG+OdidfzVR9+xwhvbX8IlS8E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RCI2qc4E7HelIbD+i/JZbV5at6mCpJjahlktbvQkfbRJpNdXwsOoqJeZLa6gbG0j5
	 JOydWYADGn/69AphEUC4zJQI2ZEokL9xVVeKYvy2atuFWt7is3PCmat/TnspVVlPps
	 fMnL+P09IBYhccuCp2IcoadHHft4MhuwRjXo1uNz0kOzIYdnvdky4CLdWqVbFMMfAS
	 69z7dwN4ORxQdPKO82RqOKsxJ+dovsmN2SneARRlezt22akS3CnJGrqwmZUV/IUbqQ
	 Di413xABZy9eqjoRvUQo3n+SvMRY3nUwzlEDVQzJ3lq1fOE2JsQc8yrq2qGSgNvngN
	 eZy7hmH52RCSw==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jun Li <jun.li@nxp.com>, 
 Xu Yang <xu.yang_2@oss.nxp.com>
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, stable@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
In-Reply-To: <20260731-imx8mp-usb-phy-improvement-v8-0-2ec8d6b3854d@nxp.com>
References: <20260731-imx8mp-usb-phy-improvement-v8-0-2ec8d6b3854d@nxp.com>
Subject: Re: [PATCH v8 0/6] phy: fsl-imx8mq-usb: few improvements
Message-Id: <178603357786.674490.1895923542917045365.b4-ty@kernel.org>
Date: Thu, 06 Aug 2026 21:56:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 31 Jul 2026 16:11:18 +0800, Xu Yang wrote:
> Patch #1 fix Type-C switch resource leak if probe() fails.
> Patch #3 add runtime PM support to avoid register access issue if the
>       USB controller enters into runtime suspended state, in this state
>       accessing USB PHY register may lack some resources. This will also
>       avoid regulator leak if power_on() fails.
> Patch #4 add debug control register regmap
> Patch #5 add imx8mq_usb_phy_drvdata drvdata for better extension
> Patch #6 correct i.MX8MP USB runtime wakeup issue after introduce runtime
>       PM support.
> 
> [...]

Applied, thanks!

[1/6] phy: fsl-imx8mq-usb: fix typec switch leak on probe error path
      commit: 87a1805b1c346b092c34f96f3806f207792910e1
[2/6] phy: fsl-imx8mq-usb: set usb phy to be wakeup capable
      commit: 2602012b8c625e63493647356d7290ee7c8fef2b
[3/6] phy: fsl-imx8mq-usb: add runtime PM support
      commit: 56eec5d9665cebe580d41cdf2ea7abb52d23e122
[4/6] phy: fsl-imx8mq-usb: add control register regmap
      commit: 01e9e84a43a1b4e9f67b5bd36be3d127d773a223
[5/6] phy: fsl-imx8mq-usb: introduce per-variant driver data structure
      commit: 2d9dcffd5d3995ba04feeeebe800cbf1c0d4bbbe
[6/6] phy: fsl-imx8mq-usb: keep PHY power domain runtime always-on for i.MX8MP
      commit: ee9e2b39ea4890f804b0c75c8a40a0f68ecd8d0a

Best regards,
-- 
~Vinod


