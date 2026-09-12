Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9C42C51C;
	Sat, 12 Sep 2026 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226785; cv=none; b=AwG3vhyiHREOQsKPSzVy/lmU41GB6z8nXTMTT7/ut3uItFyy0rDmyccpahMSJkuBPe+fQemh9h/pEYLwbjcYWq1eJ1/yL89Or+A5QL/wBtE2YhytgIMJXm7pIXFc9sAv4bC4Hede3/x58lAp6kZcaOeCQCOrkAO0AdJL47DXFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226785; c=relaxed/simple;
	bh=5KNej+rz9vVfaVtfZc9hiCsxrkka1dz0ahOi5VQ7O8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmQMzEodWOsgzmdi53iPqShXnXsRvpr2ICOf9gI+uOgFFPp7YmeIWr4quLnvuGUmDA2yxbDmbtxbbyOJRMoeUL3O8DUDxW+6BQFLiJXAZBhfwA2Mb/pK80CJVwTNt6dpBq7PznGJ94P8cg8w8b/t3bNPvflbin/27MTvDFoUnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxS6CkCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxS6CkCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8FB1F000FF;
	Sat, 12 Sep 2026 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226784;
	bh=TDJIzQWqsOsISqXG0JZjfAj+hlNjsIuLPf7NWL+sE8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxS6CkCfXErMUv0gDr+LM/aHQPUAmSBikB4lA2p0doW13+g6kzuBifOJggTHKHyIc
	 InWHZq6Mr1Ctb92iT2qJYnJJ+CzDVohKtQhLrPfCIbbYK2TjefheSO1wHFv9gez6SU
	 Fgt8JCU9CkhwlNMccVHSr086lvmkv/M2rUrjfCiRvaWWQZWcJoX6nDYCm9HPsNr/ft
	 KFmepOXuUiPHg6h5crnMO+AIq8eN8UwV/BUukgOJyIXqLb6xJ3fHzboFXFhTqCf9Sz
	 JRb18NKQYN13As8WgCsv90JYCGDRGNQCd5LurHB/JwNRqqg8RFwlorFP5o5pWOnlIi
	 ObOFf6UTjJ2vQ==
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
Date: Sat, 12 Sep 2026 11:26:11 -0400
Message-ID: <daily-reply-0001-re-arm-smmu-v3-devm-teardown-7-2@kernel.org>
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

> Now that arm_smmu_disable_action() manages normal teardown, invoke the
> implementation callback there while the command queue is still alive.
> This prevents the subsequent implementation remove action from releasing
> resources while the CMDQV hardware remains active.
>
> Fixes: 5994617e09ee ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
