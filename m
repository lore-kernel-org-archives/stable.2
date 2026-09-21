Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CA481FCA;
	Mon, 21 Sep 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992494; cv=none; b=ds+udbhQHbR+WTWSb7mGSLGlI71QvdxJO1VtwQF4AUlAiT6IcJcSRxR+yYhjVnLiFfJxAdxTQ6P9rslHsMYiieGHzPCPHre8Sox4lgaMDrmj2FeDwFvtX89pJ12WFL+SJbktD81l+eXISqjH9tUL9ZczbQsrTnvd4vWEE88d0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992494; c=relaxed/simple;
	bh=ku06OYHQ0i3UHM7d11/TJ5MF/OpW3Y5sNIIiJVQbWRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyQB8fpbAtwCab8759lysgPb9qJaiCCoFVaJsWsXG2n7c0haQpzcjviD3jy8hEGGhxp9f220brfAJdYwpriomNXm7dZlp9nke/YOv1FjZWHUgIQtxGwxe+flrImisCONmRpJihRfgIgix0facBfr5KklH7VkesZZFhWfCersltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fSLvIY3b; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fSLvIY3b"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e9430321;
	Mon, 21 Sep 2026 20:08:06 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	KyongHo Cho <pullip.cho@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] iommu/exynos: Initialize lock before requesting IRQ
Date: Mon, 21 Sep 2026 20:07:59 +0800
Message-Id: <20260921120759.95145-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901130527.3289245-1-runyu.xiao@seu.edu.cn>
References: <20260901130527.3289245-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c3ddc50203a1kunm056564654b610
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB1OVkhCGk0aGkodHUhCGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=fSLvIY3b+pMqf48ssjiitMaCS85rfR+3iQwB7WmtsUnawpdMvp+WRomez24HSn+ve6wTqQ0gP/7EHc7+HLflgHmJsTIpY181+yHuNZEmez7mOGcQ8zJewy8WQC/LrOJaOQgdKOyatgEAN1lowfau04qYgRHyhmIZTGeWSSy7V5I=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ku06OYHQ0i3UHM7d11/TJ5MF/OpW3Y5sNIIiJVQbWRU=;
	h=date:mime-version:subject:message-id:from;

Hello Robin and Marek,

Thanks for the reviews.

I agree that the current patch is incomplete. The interrupt handler does
not only access data->lock; it also depends on the clocks, variant data,
device pointers, and the SYSMMU hardware state, which are not fully
initialized at the current devm_request_irq() point.

Moving only spin_lock_init() before devm_request_irq() therefore does not
make the handler safe. I will withdraw this patch and will not send a v2
of the current change.

If this issue is pursued further, I will review the complete probe ordering
and the SYSMMU hardware disable/reset sequence before preparing a new patch.

Please disregard the submitted patch.

Regards,
Runyu
