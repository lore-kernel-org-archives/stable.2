Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20C457E42;
	Fri,  9 Oct 2026 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583308; cv=none; b=GV4P8QK519dIDlIMM0sI0GIhi3vmpElGrMc1eMNP7enb3VnifdwZfFZFgl8T4k/HIDAi9PVd41i9VvnnpBrsG6xp+qw+1wMIYhPRSfZ1iAIhcZ6r902UMDFZ4ujLJzSTNpRd29PgorJ36X72/qf6jM8lM7jzlLkOwXqD4p/FMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583308; c=relaxed/simple;
	bh=rsU0X/5aJ5/A4d5XI4sg6AQtivlBfkx3NW13GRBRHd0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RbzDltVOQez9fOkcId5lAcOM1OeD3l/9kSWUZP4xD2p14OaxqwnYiyTX64B72Jmn4XjVSLmb3VAA4AtZRUB3mGhJ9Wam96iqZQsSUrY7mEkon8yB1huAjHpR+cyNK8+jidagpsZUx19osM7FkJOFm1c+ZQ3JZg3kXyx28OZscno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyd01UUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyd01UUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3101F00893;
	Fri,  9 Oct 2026 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791583307;
	bh=TTCx9PFQv0ShdU2Qbs2KSAhCu1qreOHnw3YuO1Neoeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eyd01UUxQ6qhRmehbhPdsXIL2n1AOKrBGvRB/Xg2foSSGPDKw8Qn+pujwIyTxlsEZ
	 sGK5a7KzOdusyr911/cR7GIT2QCL5KZYKdH0ozjKUaGJA62D/UxAGn6LMf8ZVv4zXk
	 yDkidS4aMJ7pJ+DLuEpMpMkTGQdM11BtzoG0mWiCuzhQZvMy4g7AaL/wvfbmbecglR
	 lGMT8NoL/Z6z9MbjZ/9G34dw4IT/LNURwoSyqR3RJ01NlgR3p0YJuHcXUxEh18cK12
	 PehBNvS4mQOiOestTAy5/TqeKXQL8XEv1xdkVVZOhZqSUj0o8KGCw0k9AJzNr03YKm
	 mrQIiPNeo6zig==
Date: Fri, 09 Oct 2026 12:01:46 -1000
Message-ID: <6782b5c7b47824ce6a89c506cca1186b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, yphbchou0911@gmail.com,
 etsal@meta.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Serialize user DSQ destruction against deferred reenqueues
In-Reply-To: <20261008024753.4096008-1-sh_def@163.com>
References: <20261008024753.4096008-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hello, Hui.

On Thu, Oct 08, 2026 at 11:47:53AM +0900, Hui Su wrote:
> After the initial grace period, take every rq lock with its deferred lock.
> This unlinks requests not yet detached and closes the detach-to-cursor
> window for active consumers. reenq_user() leaves its iteration cursor on

I'd rather cancel the pending requests before the grace period, so that
exit_dsq()'s assumption holds and its WARN keeps catching lost schedules:

  https://lore.kernel.org/all/20261009220001.196762128-1-tj@kernel.org/

Can you test that one instead?

Thanks.

-- 
tejun
