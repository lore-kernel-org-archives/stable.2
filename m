Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104530;
	b=pEEv2xMHtkE5Q/by4BncNxqp661Sh78RWnDVQq4DgDLtGxGT9BW6PXm0SF4hV6PmEfGw
	 xvw2T660czYDfq75iuT5T7Uc+nauUyiqQ7PiBk9OU8aLG02FWU/S3SHwEoCiLq9aSNbWz
	 a+wMjov/tP9YYgq0m5QgdhYdDIX7AN7bQWipuNMFnimJ1S9WGDLXVsxpO/OvrcsB/x3r4
	 0ZxOxzqzQgLiPZ34orOmfHzPB+fehPr4k9iWg2utfZZs+ZxswKeaBj17w9rUqYk3yBX3C
	 66P0b7ARM+O8A7G+qKh0kU+B64Nr3rkyJW9jwol2u1uD8MahB6JQ2uDVQdsTnzrDweQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uZVCdUYDZzyWG6KXXRD1ficthwqZTr8WqOGewrivrZQ=;
	b=VT4eihCcemuThcc01bSRi04VI6+Z/AIfvUHcgUSDaWyeJqjpMn/LzshmdBv1vHt/UQbh
	 K+f/V2rheOzszlEypCfhRHNzxHWMccIyMk2FICZhcGTnZ7qcV30evpALIONRZE91VYlKk
	 4ppUr0am4aQ0H3kq98i086s16mjMk6QTA69vDJkkvbsLZxN7Qx+RiqPNOocMBmO2PBclq
	 nQpxlyvMK5iEV95CvK6d0nrMYSf5zM6fKFm1qJUpLV/Dju/6K7dVRFUE6PznPr8baL8dq
	 UORbF2cgtRbIJOLeKAfQFS83/b0R9fumc1w9YaD6kq1SuOGGIcDl+A0TETDGuaP32Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R57Tkyux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3D60A2602
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R57Tkyux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6136F1F000C5;
	Thu, 19 Nov 2026 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104529;
	bh=uZVCdUYDZzyWG6KXXRD1ficthwqZTr8WqOGewrivrZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R57TkyuxJSPVpnHedcUrMxd4F9dmXHz+9spLPc/zw8tqfd0XNOSPaj6Irjl0hxxf1
	 mnX6U9S0FQWYoRTr5k3IAnS76ZGAz5LZO+QWXSbUsgIs66Qb/LrbUzWPvfmNeXFB9s
	 fzJ5eRQAdm4flz6IwNe7KDDIfmIyAgv9mrXChjJY350lxK7uP6hHYYrdVL+s/z7bhQ
	 4UBLY9aEgoANreDkVeTksf5teCi24pGypT0dktBM1OVMcfIrNgcqkbCX35pS2oKh/8
	 r+jHr3jaQDr+WdAuSNbmsvO8YnDUofsSGw+bx49vhIR/nFT6PFLJ/4GkaZBLSXd7nY
	 KTy0puGbrbBsA==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: =?UTF-8?q?Re=3A=20=5BREGRESSION=5D=20stable-rc/linux-6=2E1=2Ey=3A=20=28build=29too=20few=20arguments=20to=20function=20=E2=80=98pm=5Fruntime=5Fget=5Fif=5Factive=E2=80=99=3B=20expected=20=2E=2E=2E?=
Date: Thu, 19 Nov 2026 11:08:17 -0500
Message-ID: <2026-11-19-1-daily-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179500675212.301701.8262514497119491246@kernelci.org>
References: <179500675212.301701.8262514497119491246@kernelci.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> too few arguments to function ‘pm_runtime_get_if_active’; expected 2, have 1 in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c)

Thanks. This comes from the queued ste_dma40 series, not from a release.  I'm
dropping 12787e3f2f93 ("dmaengine: ste_dma40: Check runtime PM in IRQ") and
c96e9f056095 ("dmaengine: ste_dma40: Validate disabled channel indexes") from
the 6.1, 5.15 and 5.10 queues: those trees take two arguments in
pm_runtime_get_if_active() and return a pointer from d40_hw_detect_init().

-- 
Thanks,
Sasha
