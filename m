Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021438;
	b=paeVD0EUThyPRTr0NPickMpu3huYT1e/s02ei12Rc9BiyfOYfB7/PXh+4N3h+GmDGtHi
	 bsvsIWbhq86OViZeeUHbdnR5Jhehw0ZTkjeRsoJuUmfRo1lAb/hjGwz9RbXOg+L41QlqK
	 CNTWjyb7UynS6J68bMyYzJEuV2CXKOpRM9cPo4oSgwHFOPKAiEhJsFi9uvBd6uWFLj0y/
	 nFPLNJbuYQFexCilXEi2mhIHBA7Hnc0sCsyTCt5DJfD4XszsPUTs/X8qeAdXKPEJ2XhQ+
	 FDBaHZSmg4txkS6VeYbHZvO3Wzx5hvjGqWbATttcKKHsZOAz4yM3Mlq8TuHTUusBpfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=toIxbZaluxY/csBPcQI9DXYgAKoZ5TBqxydeOi+bj/c=;
	b=tLLCL+zxHJBOzVRDgpLx3Kg50kfMc3z220P6nwJ6zmqw5C63TGPB/scy/dqimhecl3d2
	 yv0UKTprDclLwHnHwciwcjC8BzW2mYvh0julI5Y5gcJxVcYQfqzC6pdhbmHcfpT8IgfaB
	 qdXw5wTRwXDmzTChKVoHzxJIqHpuufUrixTnX7RHjwrGpsa0HLBvw7vQ32oBlPg0ROI6E
	 c2RyG69uFtA6brkbK+TTqRnJyW3jOqtinmF9lSlDNOh5N7kz11W3rwed+fBPJ1WUw1MNF
	 8mXKOdQBQfU9O+qZG4gKerpq7XGwzILZC2ZwG4ciVifcEq0Vuc+No2qDf0daQQE2oeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGVZ47wI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40D606A31B;
	Mon, 26 Oct 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGVZ47wI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036271F01825;
	Mon, 26 Oct 2026 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021438;
	bh=toIxbZaluxY/csBPcQI9DXYgAKoZ5TBqxydeOi+bj/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mGVZ47wI25337aHc0NOtWv1yyF4Wr13lGlNU0XG3sGX8znCtezXzr6SETOrGIy4gV
	 i5WKCyfjhnilMzrc6VZxQnvxoqHnZtR8dV3Cp5v5duGQMgSOHt3Bdii9a8O99M+4D8
	 OwPzFtmfewyHhjItkGYU1CeJhM7ZE4noVYUAb7zp8Yh6aUfVDep8hXGd7G4cCYaaH+
	 ZHAjy6jmkKFxeRJmQj7WqJTZFkxCymp2z9q3lQdhrk8G+VQBto3BJX8CL3JTHDQ7tO
	 CdtL8rvP+tCLOF4CAcx5CMh9YpoNG3UoNLMk6c0qptiabQzLy8Rr0FjsbQWrlKRdiQ
	 Wctnd8UfBfyBw==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 7.3.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 06:30:30 -0700
Message-ID: <20261026133031.26195-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026-10-25-1-daily-reply-0011-damon-zero-target-value-decline@kernel.org>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha,

On Sun, 25 Oct 2026 19:29:57 -0400 Sasha Levin <sashal@kernel.org> wrote:

> > Notes for stable kernel porting.  The upstream commit doesn't have
> > Fixes: and therefore not ported to stable kernels.  It turned out it
> > fixes commit 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota
> > goals user input to DAMOS") which was merged into v6.8.  The user impact
> > is a race condition that can result in divide-by-zero.  Hence backport.
> 
> The older trees don't need this one. The callers in 7.2, 6.18 and 6.12
> already reject a zero target_value (7.2 also has 06befa61c427
> ("mm/damon/lru_sort: error out for >10000 active_mem_bp") and a16fd3ad9d89
> ("samples/damon/mtier: error out for zero quota goal target values")),

That's true.  DAMON_LRU_SORT and DAMON_SAMPLE_MTIER are patched to be safe from
this issue.  But DAMON sysfs interface can pass zero target_value under a race
condition.

> the
> commit has no Fixes: or Cc: stable,

I didn't know the race condition when I wrote the patch, so didn't add Fixes:
or Cc: stable.

> and it is patch 1/3 of a series whose
> patches 2 and 3 remove those caller-side checks.

I'm not sure if this really matters.

So, I think we still need to add this patch to older kernels.  Please let me
know if I'm missing something.


Thanks,
SJ

[...]
