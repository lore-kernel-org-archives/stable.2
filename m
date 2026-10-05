Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9848593C;
	Mon,  5 Oct 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208274; cv=none; b=UCq51tmpX4teMYdsfJbhfef9kTjuXG3mFBimlnKX+vHD6PyGM7ytL8O1PNIyxkTr46+mpBgbRQbW6JuPFzKKgmKaHBFnAqLLhFVkFhTfX5oMw4LO5io6ql6kS2lk7SLh/minnwb5vDsQxkajrp3ZZxl2rEFfre7s9J/fgbQKL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208274; c=relaxed/simple;
	bh=Meusu3eavLORStnsQInG3xso+5Q4rNGOUVc3l/Csiyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4WvvWI+BhFQ7qSUhe7qnx3h1kQXufpMCriKM9CggSKafQyb+fPRxAwlO6hCj8tDAa2U53JbGEV+6eERyI+ghleW9tKo1jLAYzFx8amTAc/ob6478JRiE2AciSq1URcEj/bI6m3L0UEggh9UnHQdPSWiAVBWdxBT3w3lGU1KWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI3lQIUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI3lQIUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3021F1F000FF;
	Mon,  5 Oct 2026 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208273;
	bh=il76Im8BdpeuALM1sFOw6W1fbeqE94uHrWUDaxdBBvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dI3lQIUZgK2pOprXuWjYatKIaM/ErOfDyDLDyOKt5Ed52NWenxnCKkJvW74aeHpIE
	 aFqJu9azblDfD0CXXbwPB0SIPQQc04awc2b+ExvAJTXhjPbU8yuQsHZ9GvYML8c2Vz
	 PjWkthLoZ1/+5qVUeLd0R7eL19TsvDgZ1RvTRZFllSe3oRwfzw6eXBhTcvAL4bhHFW
	 4y+e+xjbIUaMcCYBCd+cDP0nIBMlowBPdxCYndvimuXjyh7UhKNxcvbtI5fnHHkHAl
	 W6h91u+o065N87eYnga625SRUjYYFNKhef/smeN30ESIXQr0tkWRQlqAwVWZvfSZJm
	 kojUYUjnYq7Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y v2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Mon,  5 Oct 2026 09:50:22 -0400
Message-ID: <2026-10-05-1-daily-reply-0001-damon-non-safe-walk-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004151730.4700-1-sj@kernel.org>
References: <20261004151730.4700-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Use damon_for_each_region(), which is safe for this use case.  And drop
> the work around in damos_skip_charged_region().

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
