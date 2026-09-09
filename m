Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F463D6682;
	Wed,  9 Sep 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985615; cv=none; b=VX0BXE9WASJnBXtPCtOQLhL9G4gEx4GXby26gXz8dTSE/lTgSurM97VirkMrR5R006uv64E0D3CcATmYUMXbdQ5V44NofYYhyLih+pprkBfCk5Iqs3k9ZuchLzKzokXz1JaSR+JIoHiKmHoDZKrEYW4ATldGYzWbjtdddDXTW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985615; c=relaxed/simple;
	bh=LP5MmyOV2w8qvYZFF/z7VPZ0sRcozF09vYIhpW23+TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB9NV/cMCiF1hgnViXLyTv/mcV7UNUGnodaoOKkStA5k4W5ODSdMC3chJxkFQBYCzmeyxYQgAzLG6kOKroE9M4FIwztmFupTX0SL5dOEZ23wkln7G5w7TgcLUSDH95CNky4ccoB85op9+aypnKPRj4FAkAj5IUnf4f9hREQhOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ6CIn5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ6CIn5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D2A1F000FF;
	Wed,  9 Sep 2026 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985608;
	bh=ZUPjrQWCnBAOq7WYirxLc6Wh4NjUd0hrbX/d711FL5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CJ6CIn5lYWkYM8Nn96ajDGjxgEl3bNNwpKLcUILDSq1uKMG4O/R4Jo+o1zf5ftGLO
	 Ys/XQpFE7jpqMB2rCG6MSfdr4kB9uZmuiVwQGL5h1xNbRqThD7JHR6gCeX+E99Cc6D
	 PDLbUrmCxURloljXPFoaA78ocCEtbVKjIVd0IbYIYoPDBGu5jjUadVaCokYSZUU8Q3
	 g8SQBAWSNVTvZ9BRY0SXgdj69vm4ZgV1DNlfzUspNl1yccbC8I8lh2jGYQq1ZnBC29
	 z/Vyv0ZpTbeQ04gIsfzweTveYsDCzs8bKwEAFVnu/dM97jD8/rB7ztE01Ihvkk823g
	 QMfEyrqIrgVPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/ops-common: use nr_accesses moving sum for quota score
Date: Wed,  9 Sep 2026 16:26:12 -0400
Message-ID: <2026-09-09-daily-reply-0014-damon-ops-common-quota-score-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909052700.238595-1-sj@kernel.org>
References: <20260909052700.238595-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since commit 42f994b71404 ("mm/damon/core: implement scheme-specific apply
> interval"), DAMOS scheme can be applied at any time.  At that time,
> nr_accesses may not be fully aggregated.  But the quota prioritization
> score is calculated using the not fully aggregated count.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
