Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2727427F84;
	Wed,  9 Sep 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985608; cv=none; b=i8rDvZm/m10xqZW6+hJLBsuqYXOSibAtMp5qar8Ze323a0ZmjuNQcXIMBPUUtRqAASDwwGIuAHELXJWpB/GWyTKyD2xr64MvjGKSFPXrwmvvuKsNn8QdkMi8NBF7paOoO6liP3XLwUx2HSg7y4qqlLViwKtIJdjT7dn9zNybQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985608; c=relaxed/simple;
	bh=6XFIPkccwtFTt9zM2Tx9yG/it56yLKTaFGBnsYCW9k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TALYUDzO3u/P11FfDzwVQvBFIshpiirEACGTLciIFCcFza2rbUWAVPXGsxKgjZf6t64tJSqmvhxMXS4MozB6hmMgt80F8+p7l6e6bM4DnLM+1b2JCmG0v2riYh8aKaiDd19XXQQMQGzcxBQ3ACgow5E6S43kIIZVxH78ZMzssAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfLWzolr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfLWzolr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B06D1F0089A;
	Wed,  9 Sep 2026 20:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985602;
	bh=4jauhr50Vhr1JSR/2XIR1kRIUoNU7gawqPy2Hjf78No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfLWzolrJdp1z89BCp+3uF1I7HPwhBpHPtl1iVig6Vd016mpoKZ58XIGBwOU3N0w3
	 ZSYrwsS4O1abv8ZeffxRpJamQ7ofb9zbWQFWGnfK0KLgGKWvbTzeOtWh1H6+65HPsa
	 9tPceEc1J0mr6ziagNFm63jAU+HN3wYVKie++AiUMIq+kErcm/DvXTPEisSxuxpoWG
	 DhQ/laYk2sCM6v49urye0BQtxD2x7xJ2DwJRqCkTzDlg9+5jswywkTdFwxGEGQWm2g
	 ktdgqiofdlfJpXkFSFpTGXk5E/fRig11b9fA6gy/zQ1igIDWcteULOqYqnQjUwKrVb
	 YEMxD1OoJRLwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Wed,  9 Sep 2026 16:26:05 -0400
Message-ID: <2026-09-09-daily-reply-0007-damon-core-kunit-split-at-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909040016.165245-1-sj@kernel.org>
References: <20260909040016.165245-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damon_test_split_at() test next region that is assumed to be created by
> damon_split_region_at() invocation.  But the split might fail.  In this
> case, the succeeding test may dereference invalid pointers returned by
> damon_next_region().

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
