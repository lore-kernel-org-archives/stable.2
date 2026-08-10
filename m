Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9142CAEF;
	Mon, 10 Aug 2026 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406275; cv=none; b=BUQddLPvRSoFqT+S2uDtpwkyf+9sQDGo2MliG8bWoN72yOeNGfIBJl6C0f/wGI6JOt/mlHXnQUii+irwM1tSStCuw63U2O3A/X9jMgvjErQVBI4005tCx1KFSRE6DMv6xE5Xx6qaY3tE8n2UabkRQmVlxitC9h7PNqjN/XUoPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406275; c=relaxed/simple;
	bh=I7hrY8tHisZCVz5/GjEbgRglpgTjJbmTHjJsYtgYCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkvlP1xq5iViT4X3wW0xP8lCURINSOIbbilyc6N0vejzd0PMIr0U1HuFvoLcjRVOZ70Skyp0iliUqT1dKQAHLETtO9x/a9/2hA9dsKYJqXRMTCJRUOPw8yjb3UuNCdxPKft1CZNeBU8b/tKZVSDXuR/gh6e/hj6xPj6Glb7uISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0mOsBH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0mOsBH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC941F000E9;
	Mon, 10 Aug 2026 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406274;
	bh=BS7a0qUYHw+L8BtiZMajenR7A4hMI7Odu3bODXBhoI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L0mOsBH9IgqUb7872UawnnIRZ3CM2XuqWemmKQ9NUu2HB3iCe1C6XRuMjSCBSeIqE
	 xUvL7yOvr46E+RqdUvIm9OMbofj9dA7ccYy5EaKf0IGGc9oZeKsCfIz8ZfQm3WMAA7
	 cyIWe7LnTf6pY9VhJ0eZtwn4rXc9SWsaxE8a6PwJMVexgv3/VQI8TKn6F+9u7AVXA/
	 5ZHIR9mWE2fCQpJZoXPtRn/KOrIt1hyYyX6S4VFcit/kmD1OedViPbbl0cADLvRgSI
	 19jExNxzkw+MC/woWOsaX0luByW7GvksYzb2MoxZI4iguyZ2kzBPBhCMBb9+SaNqVw
	 RQM/RR8ILdRGA==
From: Sasha Levin <sashal@kernel.org>
To: Jose Fernandez <jose.fernandez@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>,
	John Stultz <jstultz@google.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Janne Huttunen <janne.huttunen@nokia.com>,
	Zicheng Qu <quzicheng@huawei.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>,
	William Montaz <willymontaz@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix EEVDF entity placement bug causing scheduling lag")
Date: Mon, 10 Aug 2026 19:57:42 -0400
Message-ID: <20260810234738.0004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810073830.GC1642880@noisy.programming.kicks-ass.net>
References: <20260810073830.GC1642880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Peter said in April that this could go to 6.18 [1]. Janne Huttunen
> > posted the same backport last month [2] and Sasha is holding it for
> > Peter's ack on taking the revert without 4823725d9d1d [3].
>
> Yeah, this should be fine without 4823725d9d1d.

Thanks, that was what I was waiting on. Queued John's version for 6.18.

-- 
Thanks,
Sasha
