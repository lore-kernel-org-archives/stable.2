Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF63191D6;
	Sat, 11 Jul 2026 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793060; cv=none; b=uuOdM9Y4VpY+smftRBhBwgWCEjux+B/BFX3hMQmQf4hm59GFIFyUYX7yhhZYLcX+9tQ9nHajwgkKYtCrn5LK/F9jgjOLGTfiYqUJLUt4A/cHK+6X+YY+S1USOus31wT8GtWTzrn0PTpi3FkW08USiyMpMLTLow2H4FzPPArT6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793060; c=relaxed/simple;
	bh=01yyRSQtaTOfnZH20TqiP/oxMRX2myPou6PzNMPWG18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMWKCMzeoXRTsdQVhkdj/OmrTwuIZrEkY6Uo9ixyKlZaerZZYj3NlmhVrNW127Mf616WKlnXBQwp2VgC8OM5pNc22Zc8lAke54p46PheqWtpvNQkaMMx8wKPrt8HV97k5K2Q9KRI9tUblfAqncJHIT4OZizUopJxLa7R97Zrq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbgTNZgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbgTNZgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABBE1F00A3A;
	Sat, 11 Jul 2026 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783793059;
	bh=t5U9bYvWpBGUn/8z8oM/COrKkhK//jr8XxK8Ubt31Fk=;
	h=From:To:Cc:Subject:Date;
	b=WbgTNZgMZLscSz4b9bOglPLjoxPxYzqBAN5UdFSBXU8hAZhkAz3/o5OJO6wAmedZy
	 xexJs8Se7ZJZCjcQh/17dpRbaD9q2++1LnXAcKhFmaLg0gGsxu9ZfcGVKVdL9JB3X7
	 oNdyMW6T2niYH6mcj7+cdpKnFa1aBaSzQXCJKlTHAY9L3OjdQclE1HTgGPNB94Z8/1
	 3NtWdoTL4qWvA+t5wfqwddo5oHlBz7dsYmuLEyGQc9J+EkTZPuniaT7dHNiwJ2S8cr
	 NTyIf2WyTNjV4mRPLTX9skSSqA2jVbzqUp+x7hG/i8ThBDNOjQCFD600RifBHmMbpN
	 4hsHqPnYKAsew==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"# 5 . 15 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/5] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Sat, 11 Jul 2026 11:04:03 -0700
Message-ID: <20260711180409.82093-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found a few issues in DAMON that could cause infinite loop, NULL
dereference and monitoring results degradation.  The first two sounds
scary but the infinite loop happens only under unreasonable user setup.
The NULL dereference is only in a unit test.  Monitoring results
degradation is trivial since it is only best-effort, and those happens
from only unlikely races.  Still those are bugs that better to fix if
possible. Fix those.

SJ Park (5):
  mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
  mm/damon/tests/core-kunit: catch test failure in
    test_merge_regions_of()
  mm/damon/vaddr: drop last same folio access check optimization
  mm/damon/paddr: drop last same folio access check reuse optimization
  mm/damon/sysfs: read ops_id only once

 mm/damon/core.c             | 13 +++++++++----
 mm/damon/paddr.c            | 20 ++++----------------
 mm/damon/sysfs.c            |  6 ++++--
 mm/damon/tests/core-kunit.h |  3 +++
 mm/damon/vaddr.c            | 26 ++++----------------------
 5 files changed, 24 insertions(+), 44 deletions(-)


base-commit: 65b3b6001701d46d5360097bdc90dfa1c06a1239
-- 
2.47.3
