Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF293E51C6;
	Wed,  9 Sep 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985625; cv=none; b=mDKUFBH+nrkbbvrcDbnwPZzXHGyW/FpM2QHLg1tNMyZVY2Ih5HvOQZVlnS9w5Pp4/jZ9UpGlzeNjdeehw5ZSBV+eXXPoI5Bog86iCFAJ/V064MvmdMoDvZI8sD9bLYbzRhkjwYpovsXFeTvAjBZOdo57BRnyCFe9CYKRUeSUQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985625; c=relaxed/simple;
	bh=TwenROTe5qOuhf+DhwSindGNCXFAbVccY2zR9xx1Z6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWN7UL1mt7Whv0wnqEGdMUWilWPp9TnFTif5Zf/+aqx4rqibgsXdGKujErblo5D0edtzLlNiNudgO/m/lxghZ2sq1EGI/agbEp+fwg1r9MC+6HMVhPHKPobAWYjRE8ZtiYo1uo4ojzpE1ajYAekwVjBr2iRkKFvPtikor4jrF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3Uk1EbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3Uk1EbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FA31F0089F;
	Wed,  9 Sep 2026 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985621;
	bh=u7n+KZ/EKQsXqZF1Swff6cySNmNLYRQVJZxv8nZUy48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k3Uk1EbWlOrbmkiQGJsE218aII5z/oIef3VHot6Izx0acP/M8ZziwlBq5onh9GZIz
	 mS1Z8Kov5FiL4ah/DfzDXY/ru302fyS+hAezmaOjv8pdqAObUMgvO+U9/1dZ0q90ig
	 w+xLEgxubefcA8dvN4D9jb+0tOQXbUjeHQV42vg68QReyaKVbdcGFpv6gky9iMrty6
	 6QU5lM4QJFe1cxWPIGNLGfWwi8vGdZSeovNylFZ42XCUxFXyLdKPGHR4HXggE1JD2t
	 f5YeFhsgYoB2Kk/OiMMbISFtk1f4xc5fA90XfHZaWDHIi0tEREH0utmkNRTU+8gMId
	 X2hvD/evD0hcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Wed,  9 Sep 2026 16:26:26 -0400
Message-ID: <2026-09-09-daily-reply-0028-damon-merge-regions-test-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909034257.139428-1-sj@kernel.org>
References: <20260909034257.139428-1-sj@kernel.org>
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

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
