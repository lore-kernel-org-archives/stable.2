Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C23E6385;
	Tue,  9 Jun 2026 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991160; cv=none; b=OkyeucNWkcxSABADqTgAPinof3mTuylMX0/5n3p5tYyzpRVMNaYYbVjzc7MJO8/3lVNGlETGjGUQ9MUqTAJ730TUmtZJn8wCN0wl8dbSB2xlFxDb0PghgSz59NTVWpp6Dr8b2N3YXsBLQHw/J/Z3wc/YJO2/GRtCHIPNjMDqtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991160; c=relaxed/simple;
	bh=WE+YQ0C30hG+7vy69TJLHtaaVUfA+rJYhiQlx8JUZ3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkqRvyeVPAgNLymZjT0Oai9Ly4Y6GjoM85LL71f0upwO4USpBZ8Nq21ZgDiT+I/ILgulNU9mMz4oO2a9fTreiP7RfS8aD7+6C/VYQ9Vrxzg7haibv0SKiMWv6FJxE/N6gSmlNb0OTwrVDU95ohcBMS2/Mgxe300MRTmVFIvpyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Yq5Y3d81; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Yq5Y3d81"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41a5c047f;
	Tue, 9 Jun 2026 15:40:44 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: jeff.johnson@oss.qualcomm.com
Cc: dawei.feng@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in ieee80211_register_hw()
Date: Tue,  9 Jun 2026 15:40:44 +0800
Message-Id: <20260609074044.3745473-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
References: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eab539c6703a2kunm7c282238123d27
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTklCVhhJSU4aGk4dHh9KT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Yq5Y3d81c0z0sCX/9LwTZ1gQzHAuvu46A9Xe15V6waoUyOPYfWn0hz5+TZ1/mS/inHiE2S/YxOJw+k2khc+pucWydbM3AaF5kGVDF4v9J/dIFftDrXa6pPERx24aaHnfQyV+uroDsidfYY1AGeyVdRfzIibaLjlYcpIXl9YQr2o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=4Rswhi/jEIlKnxolWs7LEsvRJE3VIBM5ijSO/Y68FHo=;
	h=date:mime-version:subject:message-id:from;

Hi Jeff,

Thanks for your time and the review.

On Mon, Jun 8, 2026 at 10:24 AM, Jeff Johnson wrote:
> > Fixes: 09b4a4faf9d0 ("mac80211: introduce capability flags for VHT EXT NSS support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> 
> why is this SOB here?
> 
> > Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> 
> this is the posted author of the patch, and this patch hasn't been posted
> previously, so it is unclear why there is an additional S-o-b

Zilin is the discoverer of this bug. We are in the same research group,
and he actively participated in reviewing this patch. 

To better align with the kernel submission guidelines, I will add a
"Co-developed-by:" tag in the v2 patch for Zilin to properly reflect his
contributions. Would this be acceptable?

> I'm wondering if it would be more logical to have another label at the same
> place, i.e. fail_band, since it is illogical to goto fail_wiphy_register when
> you aren't performing the wiphy_register function

Thanks for the suggestion. I will add a new label fail_band and send out
the v2 patch soon.

Thanks,
Dawei
