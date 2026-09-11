Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9103D9DA0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125678; cv=none; b=QK37kHpPnctNMnV5OxM0iJHVVDJTwfQ0EyRYP0/g8+2pioHgk89rVrigLVgjkv2Rh4SdXwrw+fI4kX+aGkGiLO6SLADunzMzwvMwWj3pGiQtTVu7Zm46wsDAJlm2oDCaGfQvbHY5X8+ikfQj1zd171HLpCg3AYq/EOg5RxE4I2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125678; c=relaxed/simple;
	bh=SXBtN0BK47JLzjUQZnTPG7Hun9u0BCG4pLL8h8EVtC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/xLpN2XWykFquQjD0zXHsj3yHoO7ixspUVES92InX7VwV7UsSvUcv1bquMV0uk//K27erdjRtbHt38qFbGYICSaS3jtxgh9xfJUQrbR1P/Aktbt9geSMM/c1yj/u352fwqD8a8ouGTuRl4qX1r2PX38F4oAAXT8PFsmOt09eaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8YWGTDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8YWGTDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D281F0089B;
	Fri, 11 Sep 2026 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125671;
	bh=biQDpvqIM5rzD50yFod2AakyQjn+Rmjxmaw0odcDpQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J8YWGTDaUXnSJ/uxowC9YvpTU46h9Jsh36nE7qgB26NyG1HTId0GPPFuvZ7K65L9A
	 wuKBq9ulq3fF6LxQa9oxXUzybn6pyECGytps5xn/nwOf+SDS9MbLh2NdXYvalKATE7
	 KHhG7KtyjVQ3D8xzNh7eoqMbWM6JZz+38XszGodBnFAzWREYQJeoENHQ8On2wYNAzR
	 tpDPv3U4mcLxNW3rFDt0pHmrr4AFvnzJozyBcADKpNeKJYUVCRoqfpSdny4NMziH94
	 wBMT7zy18vxcTOEgS7CxmHhty9m6VEjca8k6Q6JV0M1Z6GKfFDq7DWJyn4BLLERe7Z
	 wNrpq8yZQ0y+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.18.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 07:20:28 -0400
Message-ID: <daily-reply-0009-re-batman-adv-dat-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909184733.946985-1-sven@narfation.org>
References: <20260909184733.946985-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
>
> When a MAC address is updated in batadv_dat_entry_add(), it is done
> using a simple copy function.  A parallel reader might only see parts
> of this update.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
