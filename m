Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207D449EA6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125688; cv=none; b=PeYmuBUpV5QIDbSc5ryW1jYgDylx/vRYu4GdLF0yWQBCUCDbo/0K+LDUXbw5r1XFfZ5kb67KeELm1ZH7xFHnHIQsnlT6SaS7gC+cJ+b4S1ALFo7CpZWNQvYMgyz3QoXmcxOsRmemht2+qp8RpigoD6vcxxI2XYj0dqD2zc/y6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125688; c=relaxed/simple;
	bh=OzREpvT3obZ+X+3F9GoFh+UrqtunAGy7jbb3g9mZzxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBbHRXwWx4UmsvJxIvQhVWvX6gMLpFRFMo8DjNRiVg+33LeWwn5Q9u2N+dr/1EA4nwzoslssH/QMRVkTKoZ70xI+5ZGnFBmJZSgfPSv2KQYLQehBu4UIKuFO5mKfB0qCX7Uf3A+JWE5Z7AFcHsumz6fi3osGhNU1NuZPRXG1NBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GylsydIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GylsydIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBC51F0089E;
	Fri, 11 Sep 2026 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125682;
	bh=sbbj9vZ/SQgZrdbRuAdjgYAnWy/an0EHiWOj9mvh+eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GylsydILRHVUQ1upsNjJg9H+7y6SJwiNjz2c847MYOg/Nal0JTnt0MjCV8dijvPb6
	 Adk0KLZxA2ijiGbsZ7cyz9R9k2ysZuAWGK4gAew6wkh7nPqeFlnly9PQnQFzZBTQpS
	 xpz3lQeqVGdQRYYAFInO/j3Pu3SSpg396ZTXfxR9ThTYABJrBLM5Ig4GUkbOdRmZQp
	 AG6Pylx6aolrbGWsdk4MFSkvBw8THzzuAx6WDUv60CWrWmK7lMl2T6BPiWwXZiTw7M
	 JDrHJ4nAqCUXK9txZZWTQ6rd60rcLz4dizxLPy59LDJudOZJhqlxJA0SfpQ9QfsCxt
	 s1xNg1iwAFTWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	doebel@amazon.de
Subject: Re: [PATCH 6.6.y] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Fri, 11 Sep 2026 07:20:42 -0400
Message-ID: <daily-reply-0023-re-perf-sched-register-pid-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909210503.199459-5-doebel@amazon.de>
References: <20260909210503.199459-5-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 5949d339f5ec98752d56dcd4e36f619a59d513a5 upstream.
>
> register_pid() has several issues when processing untrusted perf.data:
>
> 1. Integer overflow: (pid + 1) * sizeof(struct task_desc *) can wrap
>    to a small value on 32-bit systems when pid is large.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
