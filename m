Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D03A3E96
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499669; cv=none; b=IJlwWMrlGGsQEtrarQ6yM+yo7/WZCCRROx28qnAL/ZXawydZMDJKrx+JeNMYDFEvx3+I5O5PT5wwNrkozXM06qdpw0+856PhNs8L6SK9wRuSpMtIBm6dQMGLJcb4UgQzbf3yySb56A2tClRSMx6q+dwcccBPOtO4hCdTsJMbj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499669; c=relaxed/simple;
	bh=sjcXNzDvMWLnougut1Xm2R9iWgn/b40utVotxbfz1Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrAaQ4lIgPMHAZ3iLyT6ZtxB5f0ZCulIYyX7CQpVv7sKn+tbdPHYqYgYZj1H4nKdOeZ+HzUcgjQizj8xLM/dugRLDeFWRSXaGhUSl9f5HRiw+Bwk/Mc44gFuhaJwHRw/NdGWhpJVfmCX5mwDcb9GVgiVWAN872k6PspD/NJ4CB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPTkBfu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPTkBfu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B6F1F00899;
	Wed,  3 Jun 2026 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499668;
	bh=Aq028AynYYctYnzfZbArV/GKcGfBvb5dUmYBpDOGCSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPTkBfu9XhTQZh4UVyuDOm1BBIW9y2slYIXZ8q05Z8QCMNc7TTinn0cPSyjjwexbJ
	 az2fCIWYK5lOE/gr6+Aw9kE180vyo+nf4Pn/UZb7BZTPUAbKM7w8l72Uju6AYSXAme
	 KYsxgmiw7qH9tO56ZLg6Yzkg5XCegLiAZhP7KaHFeZ88V39HlZhWKnw8zPd9ZZGbuC
	 XYlkqe6hOGikd+eCfE+jH88TplH+/lmTSVqRbS6JFchBtKy+kSI69F8cbF6IGuZsMY
	 N3rBqN+bsuq9Vin/ZN5WOwaC51KyDT3ZMP5U/inkZ2o+OuO7piq8wIZiaTj6VW/VvV
	 Wfxj3ptOQbB8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
Date: Wed,  3 Jun 2026 11:13:54 -0400
Message-ID: <20260603105137.drm-amd-fpu-guard@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527144428.1095001-1-xry111@xry111.site>
References: <20260527144428.1095001-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
>
> As the mainline already contains the move of FPU guard which should
> ultimately resolve the issue, it seems better to just backport the
> final fix instead of adding the temporary ad-hoc change back.

Thanks for the series. Unfortunately it doesn't apply cleanly to 7.0.y.

-- 
Thanks,
Sasha
