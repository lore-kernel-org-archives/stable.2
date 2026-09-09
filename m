Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979841A92A;
	Wed,  9 Sep 2026 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985610; cv=none; b=aWAToke50AOxCnb8vZrbrQiDEwD6fBqT/l1HnIu/k2bfZjM4UzFsvfo7W1aqkYYlJ0aZJQKxZGcMDmkOsVe9LlMQbSieVzxr6kGS40DIg3faEECPaj+kFqpj6PtF70g+NpDnIQBM8JVWI7wTjyyWq9a7ENTJhNjm75K5jqF376w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985610; c=relaxed/simple;
	bh=Sby4Bwn8DZn4++z23i+dpKBPpgPFiE1yqXhQ0NjMzV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5l8yfKkWiGY6L8zM/QJ2b5M3h1SYHFMWWBQdL4rOjMyRd/i4l2+biikIX0a7XxeQDlhlwueVWNtgOhbaYFbN7xLGH946nRsQ6W19hS4+IahPUut/AvuPAnjhVo6Pw37gbOzTFzdb4gVMtoMekvRRV+06+a8zSW4fLi6K51NwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0z10daV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0z10daV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B34C1F00893;
	Wed,  9 Sep 2026 20:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985603;
	bh=Ny8z2vzB+zbLDn0Nuq6PHsHEDF3KJwWKoBOoZbqbBmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a0z10daVO0S9/b3dnDg0QP5HaXInJ+CsgsyMCtnSeKw2Q0mqKTKZbqsWnK4+M1VAt
	 /0O+w/tZ2OcsWY9LDmIMdFHoT7XizMPqAsLucGeUx/UanweBRBrHbEdP+YllaSyR/a
	 MHTWIx2y196bO69O4kXFh/r3LEdwIXxcf0muQRJcds3Ci88KHqjLJUGYWSzx0p6Fkp
	 zQv4q8rM+SjUg6REEGaiBJuKvh7Jr+rd2ZyMWBELA+FOiBXGbZHwp9FQV/wlT3ObLO
	 pm3aP8aDea2EoUKew5LDUvYvb1N1mw1SVBT5RbhK14bJHmrfWMNumNJ5lx9BrhR7N2
	 uWqWOKJ+mNA2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Wed,  9 Sep 2026 16:26:06 -0400
Message-ID: <2026-09-09-daily-reply-0008-damon-core-kunit-split-at-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909040237.169081-1-sj@kernel.org>
References: <20260909040237.169081-1-sj@kernel.org>
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

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
