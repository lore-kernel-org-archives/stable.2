Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7D2D0C62;
	Fri, 26 Jun 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496486; cv=none; b=lV8N2BMdkaJdnronbBF0MUUPxD28Xc2TQGrGbjgVTMIA002xEVQllwwzPTaQ4bXuDtk28CVaT3H2/6z6Xessg54mvOjpHP3+x/Xtpj4lV2f3N7iul/YVcmGwmUTJE2afGjKxYycp+p1VPzzF2wYuu44//dHJ5TfxPPu2aOWTtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496486; c=relaxed/simple;
	bh=UHeMgYsEFPFa7fjEu6BlWGRq2scTdgJgwgSRkL6rGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUADuj0dJgcpzetizFn3aCpoewMHx7UFd0Pk3PeONWh/NBzOV3d2KIQho0eVhHq55l9d5Wv0bqpDv/Rak93wZgTK5aGNaMEHnXrIlfwz55Xx7+K2XsAG8Asv4hjIrcSjMopJKRIwDQO71AM0AMgIqmiIOCVJOEmsV5M+cAOtK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL/uvHU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL/uvHU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738C91F00A3E;
	Fri, 26 Jun 2026 17:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496484;
	bh=4P0w2YkHaT7J926lwF6hEjqu7vYpYBfmrEfUE95GkIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NL/uvHU9nw9WmwCaB99aZ6QwI44OEqvTGdd9X7I3y5sh4NG5LVXjXeDjzmV5Bbsr2
	 0HZX6umbvCAq/dp6MrRPeXxKQyKMSZIk8ftkNetahX1B465OWkoy3kzddgT9jn7qD4
	 bimGNOqh7UEl6fE4GKJQgTYYICX1TJS/jP49Zc12IEFcnYvJF8C1OB88giv+SVIEdd
	 1S+5Lq8XyMJO5sV8TX+H6DPfWnuw1uwgPGLjBErmIIJUH3nB8s5eEQIt4dAaJlHkJC
	 DWCwBxIMKImaB8ILFTRGrR3BqDETBSj0R3SdKz+hkkUUEZwKBtiBA8fx61cmveFQob
	 GA/PR+PlppF2Q==
From: Sasha Levin <sashal@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Simon Liebold <simonlie@amazon.de>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 0/2] Backport dependency commits for 616b14b47a86 ("perf build: Conditionally define NDEBUG")
Date: Fri, 26 Jun 2026 13:54:16 -0400
Message-ID: <stable-reply-item002-perf-ndebug-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625133222.3412820-1-simonlie@amazon.de>
References: <20260625133222.3412820-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y 0/2] Backport dependency commits for 616b14b47a86
> ("perf build: Conditionally define NDEBUG")

Both patches queued for 6.1, thanks.

-- 
Thanks,
Sasha
