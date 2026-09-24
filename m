Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1C2D8370
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209274; cv=none; b=jXvCNtv35ls+rWz19CWvd79XHDILhdypupi/J5USnVwFkbdmK0hxBuLvzlwomKwq78/sfHSmLcMh8H+8U3Sb4DxiS8nXQFh77pRB68wRXHwzTi/o+Rf4kDRnrQSml3+tUp56SRfVhpYxeka3u1UyLSyTOQYigjDv2OrU3a+UeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209274; c=relaxed/simple;
	bh=zzIpO7UHZVsHPQ/krwRImNRtJsdjWHfyJxzDqa5IgkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L95AjjCMJktpdelmOzGXafi+lZ8Sg4zZO9sJAnHonuHYzPYx2dJaADVRxnSsG/zugwiIRh/aXGVIhN66JeXGllH3n6SkmbtT0WX2XF0u2FHdCrDk3Cdwebvy+M6bK2+ByOIMLLqPYj8NzEnTajfOpCiGz2TnP2uoQCyEYvK7Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mojEQc2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mojEQc2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C751F00898;
	Thu, 24 Sep 2026 00:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209272;
	bh=4oCAeM9ltUQ1ZWD4Dn7CLYhh1pTCQ9OyNVulIwch6tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mojEQc2/BxINGewY91xxPwhYyWbVs/JYR9t65/Jm9hUWQAvkD6vthOHerCO6H5VcH
	 MT5CWQc45ZtRomH3RGwAffltXZD5B0IgTPdpx5bM6ZNQH4ZtnQXGGj0aW8zWnZLB3F
	 bxTK1D4GclhPcmC6YWx4vD3UF8VWzo5tWK+/RwvcBCzrP0Vg3UeWu7nAHTwsOidtVF
	 lUHLvdqzelyfARuxTagSAbjvmkgVuHkhvT/p68vgNSYIFWWZKH8X/mOyxsjf7S6yuV
	 a7QQbQtQaRQmwloHJh19XVPWu8GrY7PaXXArgDto1HFlB2B5zxfcX6UZEgr1VWFKkJ
	 KzxaYfOGTTaZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5.15.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Wed, 23 Sep 2026 20:20:56 -0400
Message-ID: <2026-09-23-daily-reply-0007-re-spi-zynqmp-gqspi-shutdown-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922140257.668414-1-itai.handler@gmail.com>
References: <20260922140257.668414-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ itai: context only - two differences from mainline here: the
>   platform_driver callback is still spelled .remove_new, renamed back to
>   .remove upstream by commit 494c3dc46776 ("spi: Switch back to struct
>   platform_driver::remove()"); and zynqmp_qspi_of_match[] still sits
>   between zynqmp_qspi_remove() and MODULE_DEVICE_TABLE(), hoisted to the
>   top of the file upstream by commit 29f4d95b97bc ("spi:
>   spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal
>   platform"), so zynqmp_qspi_shutdown() is placed above it ]

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
