Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0119E56A;
	Thu, 11 Jun 2026 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781136419; cv=none; b=pFgk0HlY66+pAHDE22P6wcMlEgx626z0q64lBf8DKJNUJEWNBGybfMM4U13Ah7ShTvnduI+mz6KWm+pnMhf59wuEe403XHFMjDoTCYvd3NEce+X/pu/96ttQXwSC8Bz2W0iqZWRFVUeEKaIv34Fx+nLlZ/G+Qx635vLz8+ea/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781136419; c=relaxed/simple;
	bh=q36BwwCsV40+cFpAm3AvOUUrjVXzu4BR8KoZBT9OlPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSKF1ZHDifu4nWQvVN+KK9DMBdj5o6KbJE2i689FUqMa9ORrd48ZBYe2XcTauhSR+d64+KhEaITDDnkDL3c/yXCS3c5VHjPcocZPCGfiFldOWv34qxLYGxYddLJMzdBtpXFhs1dWhptlZBfd+YRe34SWwTH2QPW/qxGgPrRDp40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK13vhrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK13vhrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95581F00893;
	Thu, 11 Jun 2026 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781136418;
	bh=6ZiqRq+M7qmIk1c5q+OVo0ETrzZ8J3PZC8bJm21Xrmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nK13vhrBbVYUK3fkIigBoyZRmWr3HNoCWYLMmEinbOXYrfWmN49FxDfGBMrXf579D
	 UVNQD1X2HKXOqycminDynETvnmfGL96Jvo8Eh8MtMgrpnk01Dr2i6+5/ifOdypM8gn
	 ov923rhoVIr0KBLcylMaataHU/0yi7vhpZXEdLDHhYPmYscQgrQIawaDtY8tKL1gX+
	 sjQuyQkd27ub0DAeRcF+ys8E4DLlWHoPiFxiYwOeZk92kVEwwi9Kt34dH92ZwNfljM
	 K5S8jqnMFA7PDFqEInmlIxRA6N3zv7WeaYvGhgojZb1Uq9BiPY7l8GU+SwoGGjzmUG
	 FxgVS3Q+0UMjw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 0/6] samples/damon: handle damon_{start,stop}() failures
Date: Wed, 10 Jun 2026 17:06:45 -0700
Message-ID: <20260611000646.68793-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jun 2026 06:55:38 -0700 SeongJae Park <sj@kernel.org> wrote:

> All DAMON sample modules are not correctly handling failures from
> damon_start().  Among those, mtier also has an additional problem for
> handling of damon_stop() failures.  wsse and prcl also have a problem in
> their damon_call() failure handling.  As a result, memory leaks, next
> DAMON operation disruptions, and use-after-free can happen.  Fix those.
> 
> Note that only the damon_start() failure caused issues can reliably be
> reproduced.  Reproducing those issues require the admin permission,
> though.

Finally this series passed the Sashiko review [1].  I initially aimed to drop
RFC of this patch series as soon as passing Sashiko review.  But, the size of
this series has been 3x compared to the initial one, because Sashiko was
finding more pre-existing issues for every review round, and I added fixes for
those in this series.

Due to the size and short remaining time until the next merge window, I'm now
hesitatng.i  The last three fixes might not deserve to rush, because they are
relatively difficult to intentionally be reproduced.  The first three fixes
might be better to be merged as soon as possible, since the issues can reliably
and repetitively triggered.  But, still those are sample modules, and the bug
was introduced with 6.14, which was released in Mar 2025.

So I think it is better to give Andrew and Linus more time for the merge
window.  I will hold dropping RFC tag of this series until it seems Andrew
finished the next merge window works.  Let me know if any of you have different
opinions, though!

[1] https://sashiko.dev/#/patchset/20260610135546.64943-1-sj%40kernel.org


Thanks,
SJ

[...]
