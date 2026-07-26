Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAC30C14C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067515; cv=none; b=ISQrYQw+omH+UdZBA+KmyWGjYMenVUEf8LI7JvWU7vinMEt+PBRsrUQLO4RoaVDp1QlWM1F7v5CzmAWpw2Dmx0Ufz5grVa9ReEcI91JJzYzW5Wnj1VcbmY647+EYy7atgEp6ov2IgLos9SxhqmNc6kJcOuIRnUG4ajWQKVjTEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067515; c=relaxed/simple;
	bh=u/06WGopclE21NXdinCrRnzgaOezGYBzk9agN4m1ZZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sogVST/NSlL0xmGvFbRXgSpwHNs73AhvBaVY5p5eh9byCaZfOEchA43lchqSkjtaTdEStTMI27IUdOQ8qxhSMiRdipubbgYmRFtJ9mCjmNCC48JpUK2i2FfUrk+GJSrhrkUVghdMULkJe0w1+xoHRpPxZzSkfsO+FdPlivNnuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJqZNL/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJqZNL/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23B11F00A3A;
	Sun, 26 Jul 2026 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067514;
	bh=ipSvaNrIou8iZQ+593Cuyyng3wR5NEKkRw2dwDKUtmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJqZNL/6i5Wj4cgLi7rhIl1dyFYNlEEGWBE2VSNXj046aCnX2v+VQnUBSU3SqsB23
	 +fIMvbg6xbtpN1fYOvAmBG+HLNf5QWC5cIJAKZAhHfZk5JzyrpxvMFbINFN371AK1G
	 guoTiu+6m2cguSzIKQ9VJnaWLwzIw8ufvVW2xt4eotPpptpbLxPld/Xt+GocmlzPQG
	 kbyb0qMWx5i2Pb8d2JhLnKmdD92TRPvGRMc0T3w+Ga7fbCEZqTkemZfSL1L2Q8kwIN
	 MgP1+KCW1xaY9g66TCsW1xuxOC0Rzcwxq/Wt8HEs8qWETZcXiQfdmdtxJO+V1n+K7c
	 yPmNKJvdmoGtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCH 5.10.y] mips: sched: Fix CPUMASK_OFFSTACK memory corruption
Date: Sun, 26 Jul 2026 08:04:55 -0400
Message-ID: <20260725192000.stable-0016@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723181719.540786-1-atomlin@atomlin.com>
References: <20260723181719.540786-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by allocating new_mask first. To handle variable-sized user
> masks correctly, use cpumask_size() to truncate overly large user masks
> or pad undersized masks with zeros before copying the data directly into
> the allocated buffer.

The allocation move looks right, but the '!p' error path is off: it
keeps "return -ESRCH;" and appends an unreachable "goto out_free_new_mask;"
after it. Since new_mask is now allocated at the top of the function,
that path leaks new_mask, and the trailing goto is dead code. Upstream
(and the already-queued 5.15 backport) convert it to
"retval = -ESRCH; goto out_free_new_mask;" instead. Could you fix that
and resend a v2? Thanks.

-- 
Thanks,
Sasha
