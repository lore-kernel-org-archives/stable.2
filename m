Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD243DEBC;
	Fri, 11 Sep 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125701; cv=none; b=q/pxvd5k50n+bDe4ulyT0g3ZgLUTKe5UXPtd67UXBU0vEB7DBtJmOiOmlGpk41XD3bEJqlOsUXOHDTxH2oVkWIQ88H55JO8L3ALAZu/qVZs0xvUXOr6K/3ChcHnLnw98G4aQ5oGFEDRbm/m0bwwRYO2nD5RHgNkb6/VXMyMtgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125701; c=relaxed/simple;
	bh=yucS7wi5KfDBsJnAOd3lVzrv+fmICMAkmBKLGoFYNhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN6UHu/gR9VDsSWPFmwEVZYj4x6M2UUgPtjoSuzarfTftHTbi9/tOQi4L3hRx/PjDho3v+f1jlJmBOQ0ycZF536Fv+kbAb4KCrUNGFOQqa5H+w5HMLsEUd+cAmv2JQAVtFpfdvWscSie1/RlYPfgzFlKMVj5uEHw+o4C/iMewaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI2SSQlc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI2SSQlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266431F0089A;
	Fri, 11 Sep 2026 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125696;
	bh=BYpLH9DJcPnxHso34+gi8/2TLYle+vuUXL8cUvmy3VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LI2SSQlcrODpH+CK/DMz3AOBiVwcPpYIixSVUYn6CrIqU13Zqi/gIUnfiugFohqCq
	 CiuyiscR2sLRWAzuO4sA7z4stourrjfVhUkAFl1imLMOOgJrgEDfGYDAXGzqwTn6Cx
	 g442jT+J5rDgAIClcLtnbrcL1AT0V3m2QstqhzV3Nv/Q/xNy2pW8xycQljAkuB4iTg
	 Ekpv/Oa+c4sgKhlcxyNhk+m4avl2NuwNS68yW+itcWxO34Lk4TdeDgMTGz8l4XBLrO
	 bYQrwgmgthl7XWMnr7gz8qPZPe5tQuHFbhah04ugjNMjy2ABs7emb1UxnVy9ultHlB
	 t9+SZt5jAtK4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Fri, 11 Sep 2026 07:20:56 -0400
Message-ID: <daily-reply-0037-re-damon-merge-regions-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909041502.181947-1-sj@kernel.org>
References: <20260909041502.181947-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sashiko found a few issues in DAMON that could cause infinite loop,
> NULL dereference and monitoring results degradation.

Holding this on all five branches for now. 6.18.y is newer than 6.12.y, 6.6.y,
6.1.y, and 5.15.y, and it needs a fix here first, but the patch you sent for
6.18.y does not apply: 6.18.y has since grown a count_age parameter
through the same lines this patch touches.

Could you send an updated 6.18.y version rebased against the current count_age
code? Once that lands, the other four branches are ready to go.

-- 
Thanks,
Sasha
