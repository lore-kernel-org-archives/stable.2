Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E387459AE4;
	Wed, 22 Jul 2026 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756440; cv=none; b=Jar/HjsFPZWeDcL/HiazDxVE0VbhPdtQHK5YwCMK2121Op0j1UxuuxO199X8LsBe+5neOBfAvS/5/O0HCK0BSKLnLrTC3303HFa9wj+6owpPVhNTmv2atNtCW0C2yjw11Xo0iwHHLTUU29Ruc7kJaoWZByViW1o/Qvxgejo+w/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756440; c=relaxed/simple;
	bh=MckdYUhkymM6GJqClufqPlW4QCBKQDuDeQJK4GjLGs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNEPHru5mCKrrxEt96rGFjUKLG/lNjhTkj5p9LIrBHt01SSmqPLuVHcBp3gyqWIJsuBC32bqLEGyyW1HelFVHpmwWawGrJGuukNt+IK/M5yJKR9NnCQ/uhYA0Md9pWZrADD9NU9qMALY63u7wNIAT4bLNi8v2yg76b1JznjCVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1Ne4bJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1Ne4bJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992F91F00ACA;
	Wed, 22 Jul 2026 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756439;
	bh=VreZlR22uIJSW9Y1Ny3sD1w9jpLjsK3e+y886oL7jrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1Ne4bJaCJ6d0m5q+gRM/kubemSTa4N9Nxm1NyQoDSzfrQ55KFZMIDGKEqF0dK7G8
	 ZFxbURFfbJIIi8x1x6fybFglWS+XiUvfytF2Dkv2pxwVLXbKhz+MASkpIKCJ5dDckk
	 z7rA477DpoMFzLCy3ApiCmg6cJ0Shdcc8DXUWySgBEBmCsv60L49ObDolWZyAFhiKo
	 v5du64nAFF4LhCRNTnv/PjVPv9Xqrb+Q9bYiPemIkUMk325MqpJ0yWILei2EY3R1eG
	 XQoizIyuiN6SRZMjWEe9o33kOiKQTdEsl1jUCESZx2e+IHEs26jAPVe+3COSAXyUIh
	 teANA0TY0Eqng==
From: Will Deacon <will@kernel.org>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	robin.clark@oss.qualcomm.com,
	joro@8bytes.org,
	robin.murphy@arm.com,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
Date: Wed, 22 Jul 2026 22:39:34 +0100
Message-ID: <178472575580.2876636.12194314237571577379.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716085313.207069-1-xiongwm2026@163.com>
References: <20260716013229.91014-1-xiongwm2026@163.com> <20260716085313.207069-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 16 Jul 2026 16:53:12 +0800, Weimin Xiong wrote:
> Move the list_add() call to the end of msm_iommu_probe() instead of
> adding cleanup paths, which avoids the dangling list entry problem
> entirely (suggested by Mukesh Ojha).
> 
> This approach simplifies the code by ensuring the iommu device is
> never added to the global list until after all potential failure
> points have passed.
> 
> [...]

Applied to iommu (qualcomm/msm), thanks!

[1/1] iommu/msm: Fix dangling list entry on probe failure
      https://git.kernel.org/iommu/c/6bea37b176b8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
