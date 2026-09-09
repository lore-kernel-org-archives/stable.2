Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE923AFD1B;
	Wed,  9 Sep 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985622; cv=none; b=D3RTCmOkgIz8c0R8kZjR/S20li1BlNu/xtA3v11Y85JaZ/QkFRfd73+ZAGmou3QmeSz7sm++Jd6ISUMpK7AiVeJhyX3+SmhfzfSRpWssBSoDjkxjcmQn4cQ6obftaXbx4tqUaoda8rXMREgzkTjWGcEtqBGY2tyYQVAXNTTFQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985622; c=relaxed/simple;
	bh=mzdEOCRyslb/S6lOTJPQj8CJrIZf2EpTrrQYRvtI4NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZTsI0RyC1z7U1I5zVuCeHLHlmhWl671/+f6CC2kICueP3l6GGoNQerbNgIz19Wu5nKy9DQr+Sv4CQrlN+qPGQzb0vL+NnEnqk1xc67baRc/1oAwPHaI8meM72SAb59vn4K97n57HFGGPJng/pQ/J3UrT5d/2fFYXphKb7Kh8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mACSFW0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mACSFW0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8FA1F000FF;
	Wed,  9 Sep 2026 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985618;
	bh=PISqUpw4wxg5OSSB52LevkuGoct5tBOIbFstVdDwPdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mACSFW0QfQeiPQnOhwP9cN+tj1iFJpl8rRniofXyUfAKZ3C6MCtjWilKnnen8mxl/
	 dh5YocyKusP3PiLhpVBHBGOp1eTVwFCGnlBZgnlj1bpFWn5jaMWWEXwccABQ+1rsGa
	 hBZANxGiBhvWuBzwaJsYkharrDFe1rJZWpJYJYyMOl5VPPjn7oTb0vFRwt2tUoVUCb
	 LgzWgMiIn9hstD6qJk8fbY4A4tn6718tvcuI0L0c4BTd3evXV+pRq+tFe3CwjITrT3
	 4JxK7w2aDn5yFEqhjt4VJ6Kzj4bQpqUYHRkEIwwWPYmqWShmjdGmI6hURfNYXhSwDh
	 Gn6JPPVbQO5kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Wed,  9 Sep 2026 16:26:23 -0400
Message-ID: <2026-09-09-daily-reply-0025-damon-merge-regions-test-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909033217.123340-1-sj@kernel.org>
References: <20260909033217.123340-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KUNIT_EXPECT_EQ() does not abort the execution of test code when the
> expectation is not met.  But damon_test_merge_regions_of() code after its
> initial KUNIT_EXPECT_EQ() call assumes the expectation is met.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
