Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05439B95E;
	Wed,  9 Sep 2026 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985621; cv=none; b=HUD/3P+0kjfL6u+onJpTCC2ya25g8ZGEr9RYm/HrUVKihBvraEhqSzLbgwO48HYDcj73/PNQweqF/5Ix4vPKkOXdnfKHofItNtD3GeTiGSg6vmzneucAxDbRgiEG6mopdMUFlAMwEeT6MrhMcffgfNkIMuWSfQo7qnwiFFv0oDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985621; c=relaxed/simple;
	bh=wPWaMA9QeY9PYu2XpiwSe0JmCiym5hL/O+kWagleSkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbS81jVYg5pvfi+y9srltWKhYCGOUZUfCufEin9ux5ptmzieYRoSkq40FsFqzltsYLHvQZfX8Ls/xSHK3EXs9W6gPG7wUM0rahZEigtdVJg0wnlFx7mwVWDfxbHRCDhSzDLCZ8q7sje8twnnvGgzSzZN3DB9Hk0/ea66ADJ7ZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsX7Q5Pw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsX7Q5Pw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783D51F0089C;
	Wed,  9 Sep 2026 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985613;
	bh=+2mIWwjQH7gN7RgtXNYuncCPsasjgw8T5DEt4ddNXlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SsX7Q5PwkESsYO7O7aeuAosESkUUeQS0FKDkhzuraiFuucV1jTlbS2gFmCo5AF9hl
	 zM6Hn3oAwnPH03RnE8ir3lujRUu2JUQp34BFHiQjWRYMRZTlf40FK3eQix+sVH9rzH
	 98QuzCwcmwOKF/VmtD+8h/vlpJydqFqv+BCTHIsimA+vDNy/M2Pa8v5BT+cZYKM0FZ
	 cdS829WYtc/0IfjXcDIfXDtHWyedUs8DjahHfGobep59m1ncz3QEpRE/sBEyy/myf/
	 dzUkuMRU11u8MxboCiuUWR8WXHzgh2PwJPpf5XdrHbLAJ7A+QzCvNinYMjzNm9FepJ
	 151bQwVUkIRyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Wed,  9 Sep 2026 16:26:17 -0400
Message-ID: <2026-09-09-daily-reply-0019-damon-vaddr-kunit-three-regions-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909034702.147367-1-sj@kernel.org>
References: <20260909034702.147367-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damon_do_test_apply_three_regions() iterates regions after
> damon_set_regions() call assuming the function would succeed at setting
> the number of regions the same to the expected one.  It might have failed.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
