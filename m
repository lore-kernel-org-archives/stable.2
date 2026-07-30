Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572037AA70
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379255; cv=none; b=AiNaHYMDB34ODTk7+b8y7NBD/P4M83tRwEPMqkse6qFd5NU5585ScmK+n+1COhuaqSxw7/rMuNzUQ/J2a26lezrOdw0c2zzmKMmSV52BJmkJZq/Fe7Ve8U3q3LcfWfGYHTZaYF0UsEkxE+mH3JWHGeVJvsp+5kwNgMJhtV1kMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379255; c=relaxed/simple;
	bh=2vdfco+0omR6njqAg2g6cPcLjYIz8c9GXkb4aCRjUb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8fOqBlSUN0ZWG7DIL3S0kw1mbVqLdewprSLBJP3arDNiHcl8d165du8qiSSml6RWZQ4fwdL9GmfFg9FKKLqMZjMH40OZnS/TTPvT5vMdtaDYVVzMVJSjzqq/YwY0m8LZlmMrR7hafbvlaAoK/PDHAoLkLUxqpDYJNAZ/xSNBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsYGd9Wg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsYGd9Wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A51F000E9;
	Thu, 30 Jul 2026 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379253;
	bh=RyTEnv63di/ZnQ4fhrUnlRJJkfnhOs7V4O2VKHjPxrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsYGd9WgE51TM77R4ABu6+pF2/ZAW8i7nU6Yf2v+5pDxEBQTB+AVukdHIyxNYaC4G
	 scxsvywfgC5vsZE533bHXPT/tElR+BpMVGMgQOlpQu+l4+lO2TQFdkxAHOlg/0B7RH
	 RX/uobQqi/i2mYlkD1E/f0h3Gr1sj9GHMBP+gf3OHKTJH1OHCsWfxyJI7xL8DZia14
	 dRWpWA6zadcJzpdsdVACBbmb9EXmdzrwRK3BR3tnkbSg7d4CzT5zoSbkTNRgJMk7SX
	 oRQ66k8pgh/MPVD/Ku97mLhIQcdwT67l6ed5TBrcMwi95Lj1DichTVu93NLb/mqS/S
	 ZdfzVzrjI9oaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	sunpeng.li@amd.com,
	mario.limonciello@amd.com,
	Harry Wentland <harry.wentland@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH 6.12.y/6.18.y/7.1.y] drm/amd/display: Fix DTB DTO updates breaking live pixel rate sources
Date: Wed, 29 Jul 2026 22:40:19 -0400
Message-ID: <20260729223316.stable-0026@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729063340.9287-1-matthew.schwartz@linux.dev>
References: <20260729063340.9287-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y/6.18.y/7.1.y] drm/amd/display: Fix DTB DTO updates breaking live pixel rate sources
> [PATCH 6.6.y] drm/amd/display: Fix dcn32 DTB DTO update breaking live pixel rate sources

Queued for 6.6, 6.12, 6.18 and 7.1, thanks.

-- 
Thanks,
Sasha
