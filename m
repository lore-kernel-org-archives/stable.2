Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB6384CCD;
	Mon,  3 Aug 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764438; cv=none; b=GcMFMJpH1b3lp9OJDmF51FSYIj6zyx2tD/lm+TfrchNCZUCamEdTo7x3JpLEEbQnCZwa+BCi4rp4MpPwVazV6QW3hlBPO1e3y9vLOjTubUfVr9AYnZzUE65ejUo0FLpXpFE3Aii7aMAtH91VTT2n9d9JBRspwq2VVmqfXo8ZdXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764438; c=relaxed/simple;
	bh=UkC3QHHr5h4Uw7AKIK+r2Udi37d++Q6AMPqSLoBAEUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcAO+rHZzlPUt2flN2oj2RWASOvFj2LS6uSq27YToKbmQQAFP5Dd5FbiPKSRSQ5BwAJ4UmJXP1gUHAio9k0bBzKLhmbtDmu5YCieK9y6PZ4/ABFu2twVvHjFiXKVGD0HvDavd7nhAwP5nRslURC3V3PepzUIO0YKvROi6XGIKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAGpRqNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAGpRqNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D61F000E9;
	Mon,  3 Aug 2026 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764437;
	bh=3grEtyvv7HjTLXQt7Y4dNymnDB9y7Wt+YYyBTBraHmg=;
	h=From:To:Cc:Subject:Date;
	b=YAGpRqNd6WrF813XPCqZqeEcUR2QAnZUs2khd/cjc+J/tv5Ps2keDxHV9eJzQ3SPG
	 Yl7RSgO5/S9ndAwd81zKFJaNjrvocuim3ecUvYlSTZ3LNlovR7u7nV1iZ+l+69qKR0
	 /o7BRcpMpLLK5UQXHIFPXhRMVvg/nroIZQra8ei4jU5bi1WsA/6BWCh1kgbjo/NwMM
	 8hjhR0E+YKue41Y2TLEApRClzvKKbfGR/eO/feJTrIZYutbRrazDjiEJoni8MazCYP
	 XcYzy3T6mRbJl8sCC75BgybNGsb/CNU0dOFvG8HbgqpEG5D20uIgkhGm7KzOgU8M7o
	 +44VyN3xHRpvQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: avoid division by zero from damos_quota_score()
Date: Mon,  3 Aug 2026 06:40:31 -0700
Message-ID: <20260803134034.15217-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SAMPLE_MTIER and DAMON_LRU_SORT allow the user to trigger division
by zero in damos_quota_score().  Avoid it by adding parameters
validation checks.

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260802162050.89477-1-sj@kernel.org
- Drop RFC tag.
Changes from RFC
- RFC: https://lore.kernel.org/20260801211315.2456-1-sj@kernel.org
- Add a fix for DAMON_LRU_SORT.

SJ Park (2):
  samples/damon/mtier: error out for zero quota goal target values
  mm/damon/lru_sort: error out for >10000 active_mem_bp

 mm/damon/lru_sort.c   | 2 ++
 samples/damon/mtier.c | 3 +++
 2 files changed, 5 insertions(+)


base-commit: 3bf69d5b51b688b8f923a13b7f12eb9b1c6a284f
-- 
2.47.3
