Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F51E5B64;
	Sun, 12 Jul 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783877020; cv=none; b=mGjSaagsIj5MwDor+bBJNQKUP5xhTgqvCrZMqNlojNybL8sPdKQ8JxNUM++8ZXS2Hd58xqGTupcU5lcaUkyztPUkwmBEuWNLFRVwZrw7CW4rU700QCRZNaDH14dButS9zZzA+eKegSpjksOOdlV++74FAhakP7Jdbt6ZZa0EmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783877020; c=relaxed/simple;
	bh=2bvgYPt+GqQeBP3pjiVPuadeJRieLBCmg5szj7F0/Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5Gz5OEcPEloFxFKTmnWaiOVfRHCWP1kq+W4B2HifzwDlipmqCCxCzlu2zbILuKsRCFysY6WF9A8Lf/5DonlOiQyLkNufFykNGvpD5PBZAZZ8Az8ZYUGmIkE6wIFj2KTrSlCgEt7gcYUwFR9g5v/Mb7uJ3HS9xoeNh2FzX3sPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJKVgeN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJKVgeN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B51F000E9;
	Sun, 12 Jul 2026 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783877018;
	bh=erlvsdImMPOzbt0J1t9Lju9UV9yCJY2fVSin6DJP3CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJKVgeN3+Qn9GQFaBZQs61WHX/XKRIQzg+VY+N85N3T4lXGBLDHUw6/kFxaqHeTDt
	 hSjbJ90rPOVOp/1M/6hIflDQN76PPxSyWqZO26rX6kvVtXrkviX6esW3Ecq/mKDDLn
	 cak6LKA9nGH4Tv0CmidCuQGTFUSRm9puODoduSJpRCxbrrX+RTjitGDi/WMLLSd1hZ
	 cGY0KNWr9a1qrorOJixlRykl4c5vVDjPs/yRFLYC8j0M6Nh1eh9HfMllpE2+979jlM
	 zfRtDJ7ZASjMRh/bLGJyhfboi66TXhAI8LRbPq7B0TJIJ7V6uU+4wbZKE57By28zEr
	 22ICvS1YigYNw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: skip aging from repeated aggressive merging
Date: Sun, 12 Jul 2026 10:23:34 -0700
Message-ID: <20260712172335.92448-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712165432.87609-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 12 Jul 2026 09:54:30 -0700 SJ Park <sj@kernel.org> wrote:

> The number of DAMON regions could temporarily exceed the user-defined
> maximum number of regions limit for corner cases.  For example, users
> could lower the limit via runtime parameters update.  For such a case,
> kdamond_merge_regions() repeats merging regions in the case doubling the
> merge threshold.  The repeated merge operation could update the age of
> regions multiple times.  This corrupts the monitoring results.  Fix the
> issue by asking the merge operation to skip aging for the corner case.
> 
> The user impact is degradation of the monitoring quality.  The impact
> should be mild, since the degradation is only temporal, and it is not
> common to happen in realistic setups.

Sashiko found no blocker for this patch.  Sashiko sent findings to damon@
mailing list [1], and I replied.  Please read those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
