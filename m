Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E64B0C9C;
	Mon, 12 Oct 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821529; cv=none; b=s71uH4vO52kA2JkOTRfrwUmrU3YQNUoa8T0LmgSFdbeS/8VGbZHx4T92vqtfeekgIJWieAWVS6gLHUR33wlpbU3UxUXXYuPDjXjXUvmex7r8vcPXBd+nbHZT77xaYYznHRf2iALkxKgHpjyfw8zXvIo6p4b6IdNVz+EKkkjj/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821529; c=relaxed/simple;
	bh=h1VOVH4BL7Ayez8le6YbqTo0p5ugOPLagQ7bqhsNpjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSFmmNE1gnghjSDuRKvGCk2Byqm/Z44SVR41cfJkD8oYSQdcE2DKxLDAzHFQoOQwXzOQRLstYzdQOQjZlYMHwBWORSSATxTT5wnl72SdOecPdMEYdfs6eZdlvOBYhs/F4ZxmekQnOhaApr2aQKY1zRWp9uyZPU5JPmxD+a5Wz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLngqW/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLngqW/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409281F0089B;
	Mon, 12 Oct 2026 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821526;
	bh=dwOf8Dc4TxSx32WOzwSp7Q6nGhu/G9ZRjwK/NvjcHHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BLngqW/i/yi7ouv1qN2l4qytDHWZGEsgW9NgpRR52R9+cyCj/rmsP5IvvkOB+5vQG
	 R484XftbLYU9MiKQ9XKPIewGqbjy8WBgpeGCwosXf9nvFqxtfXY2V7h1uvRYbw/M8U
	 Sxp15CxL6AIr1cVFAkS6AO0wvrFJ1wYIx1ydRFdIjrAHFCmf/5QB2zGf68tf8gq7Jy
	 5OiFbxE/1SqAf4w0i5kg5CY1N1cxunIJUwZj9G4DM/cvLZdkp/nkgzF7aHVUiLEQuJ
	 1OZGsZq3J7G8FOUYnO2yAUWC7fRgyZu3qgMtmFG+lJiggWml6+EAX4lIkXs0JlzgSV
	 7p0q1lM1JO32g==
Date: Mon, 12 Oct 2026 21:41:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: bivvy.bi@rock-chips.com, heiko@sntech.de, kishon@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip: inno-dsidphy: Fix runtime PM leak in
 inno_dsidphy_power_on()
Message-ID: <as0GyAtxP7a0oqrB@debian>
References: <20260917134627.2153845-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917134627.2153845-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 01:46:27PM +0000, Wentao Liang wrote:
> inno_dsidphy_power_on() resumes the device with pm_runtime_get_sync(),
> but the default case of the mode switch returns -EINVAL without
> dropping that reference.  The matching pm_runtime_put() lives in
> inno_dsidphy_power_off(), which the PHY core does not run when
> power_on() fails.
> 
> Release the runtime PM reference before returning.
> 
> Fixes: b7535a3bc0ba ("phy/rockchip: Add support for Innosilicon MIPI/LVDS/TTL PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
