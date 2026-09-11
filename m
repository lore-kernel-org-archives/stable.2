Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF540443C3E;
	Fri, 11 Sep 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125696; cv=none; b=bg0FyObH6mTN3ULorXFutMrRqlUuj6vjEaAQancc3nMu0l3dyaxHpy4Fv8NQ4BisbQ1FOpZVRTocdjZ0PIDNnKCVOZA9vvYOGZgRIJkVreXeMW4zIoV27mB6V4ukl2/tAkzguNVxCkrDqDofwFMUyPssNf/UoAm4buDC8qp0I9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125696; c=relaxed/simple;
	bh=Mu2UQW2MtfDaZ72L0x8Y/YixeO0Wbttc/bXs10fJozE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIeLWgmahotiCHy7ychvZHjrJzzu6JM+nprL3fQ4TVUcHgt+WGvY3wtThzySgVxKtt6lUHf7enFRQa/15UmPRWOSTc7HZSHmfMnB1vpIl8whHWc9Hv6SoYo5QofnSC8jfP3HFAmDxqb/D8mZOfwMyxT74KbklFRc+2noZi0Z7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr6w7z9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr6w7z9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701881F008A0;
	Fri, 11 Sep 2026 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125687;
	bh=LC+/Oasy3YzxrJ+xcR6YHpRRPYhekqR2drvQ0c+ugYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pr6w7z9jOHBtcBu90TmuUd+SNELbLx52X8SgihZxsdWTcx/Yf/cpGaK7u88rhwOXr
	 JDi8auGQ5AkB1XyjA3Os5QmtVwZ6+HZnHmS/XfV7Ef2H2jU/mI61GuAx8jfqD/IItu
	 EO3hzoaPtGNKrm7FnYdmMvXC9wTh8+xCM14qVpChGC1JUiNgoULAPMT2B7qFL+gMPb
	 6OlvBAglX9dO/QPFxzm/sMVr5aQKRQ1/RFXCmrCn7VNpAPXGK/pQJjopELA1TIalxF
	 8HbpEiOhjmnH3E4v8jwLx9xmbBmx7M0c+ZJ2NyoUW+df8sqPZhrViM5FRXmmY4nz6D
	 GqsSBXRwNMuXw==
From: Sasha Levin <sashal@kernel.org>
To: jgg@nvidia.com
Cc: Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolinc@nvidia.com,
	skolothumtho@nvidia.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations during devm teardown
Date: Fri, 11 Sep 2026 07:20:48 -0400
Message-ID: <daily-reply-0029-re-arm-smmu-v3-devm-teardown-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910065429.1703706-1-guanwentao@uniontech.com>
References: <20260910065429.1703706-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The Tegra241 CMDQV teardown fix moved VINTF hardware deinitialization
> into the implementation device_disable() callback.  However, its
> stable backport preceded the conversion to devm teardown and could
> only invoke the callback from the shutdown path.

This is a stable-only change for 7.2.y with no upstream commit to point at.
Since it has no Reviewed-by or Acked-by from an arm-smmu-v3 or tegra241-cmdqv
maintainer, we need that before queuing a stable-only fix.

Could you get a maintainer ack for this?

-- 
Thanks,
Sasha
