Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163552;
	b=y3gX7q8EsyDEzUxbz/uYkqAHD/jXhSyG6O32yLO+A98ihpt9hWUGc2+F+CB2yp4Kr1iR
	 WckQsHWC79VA4WhF3DB82St2vuTFsgKzV2IbYStr+HZ0a31xIPAW0jcj51Rc8syJzBe3l
	 C29YM4JXMA4QOqWKG7ukdQP+XfdI2mgVL3/U0zUkVevtkVhIR1Zs+6wO4cVsQVrVm+ylM
	 L7M7xkmGm4kEXZVUG6R5ACD+OIK0fbBNa4wkPnmiNAiurAYNSVuSUEXzfAu3Wj6qVSVn4
	 027PqdKHgF9UC3aVUPBvKbPR6ORslHYaYYuZmcC04qdIxp3Vvb0JOfHLcCeOkRKswBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163552;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HdV3apPdLyC8bMjqmehVYLY7PzMWkDboquQikZWI4nA=;
	b=3b15wZEYDwZayUKUQRJbCzYsVYB3BW9L6WA9GNRVeokKK9HkzXjcCs9lOv3oqCMr1yuq
	 uTt9p8xXsI2/OD9TRZrTK0dAmvnXzxSUl8OIHVCVhS9isHzHtkhoCjX2aTzXS6cM41S9e
	 yeL5RC7GIvqUwyBxIxzYu9bYHzjk9Jmqpb6DZA9FqzL6lEnfiawDoOz2RVE2ETvoxQPMQ
	 M8/XvZGth0dV1RggyAfEUpduqFEZB7n18ge3btWHhDoOzsymLmMzTP2ojAybcGvBU6bgp
	 yOPsMoCXMoNauGHWzth24Z0/32lL0qSpP657qXjlditvbB6H0CLbTYI7wLdyd+W5upA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyLM+F6M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D6606A31E;
	Wed, 28 Oct 2026 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyLM+F6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7855A1F01829;
	Wed, 28 Oct 2026 04:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793163550;
	bh=HdV3apPdLyC8bMjqmehVYLY7PzMWkDboquQikZWI4nA=;
	h=From:To:Cc:Subject:Date;
	b=VyLM+F6MHcWTFromvSCOBqhXHWYRMbinGuWPugK6lmzkCwg9gmaiSrBSGsIGxAUdZ
	 9i4lxi8niWvi0du/oMmqh/2Q7osrc9R29sVo8FXGNVGR/ST9NlTV1W4H6NwyS8DnuT
	 TU+i2btygCBSYC1s7E8FUZnxB7p8uQLpLtBPfErZbwsMKsKzi3kDiOM7oX3gtqneMY
	 Rg84AzUoEvaxNWJTvSsw2RWPqbeQZLLt6UHD4W+xBM/uKpEBIbGUlrSqI58BDT8ITq
	 eft7TvOBOBAxi21bZPDoGAG7+Q+C4x1xsUQkMKZo0HXZwqzGalhXK7keYjKegR2Wki
	 JMUwXSkXJ/mkg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.6.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Tue, 27 Oct 2026 21:58:59 -0700
Message-ID: <20261028045902.148624-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface can leak pids due to wrong error handlings.  The
issue in the mainline has been fixed with code refactoring.  The
refactoring is done with commits including 7114bc5e01cf ("mm/damon/core:
add cleanup_target() ops callback").   Porting all the refactoring
changes to old stable kernels will be challenging.  Hence submitting
this non-mainline hotfix series.

SJ Park (2):
  mm/damon/sysfs: put target pids for damon_start() failure
  mm/damon/sysfs: put target pids for apply_inputs() failure

 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 4d7468bef942db9da779a5960cf42694e84397d6
-- 
2.47.3
