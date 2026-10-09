Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3A3B42C3;
	Fri,  9 Oct 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565848; cv=none; b=JwbtcHbYTisuF1YhwfLAWsSVvqVFLqf2q1bS6Tgxj05uAQO4uGd3AZlM6qMIeH6YI6HTYI7UT7q7Nci8Aw0QiM9WWK4iSukSCdEDKF6m39aBnyi20OmZ4+vm+xxc+U2Lb/mwo02hl6PRqLa1iOMZVRhw5x2YD/0o0so/0yR1phw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565848; c=relaxed/simple;
	bh=8H5jqbu77LhvialV5HvS4AC9i7FuQjwiKhM3ajWAtuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL8mrTaYeDvy8nfvP/qouPiLVvAsx8KLyIeOGEoGNorfPlondB0sef9WPu49osXqtW7KKa6K40Ji0lIDO4c8ZSDy1dC4XJbB00Ua1+G/39jlrsYLmMUdftUsqCGfEqpNiBwuxamI+OjzVX4xA6r5WcxYbQaXmmgAs5Bet4oPrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFBPIZNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFBPIZNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB96D1F000FF;
	Fri,  9 Oct 2026 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565847;
	bh=Aqd3uQwMtvSY/3gTS9yVRJCLWNsanEVfWT4x52uKYqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oFBPIZNtXOKKLziQtDBIjQML3/ed7XwmHPaL+By9/WkziS9pwYeFXF3X520kOgZJl
	 Uz9GeMxFI5V6VKNXnz8YUrKzhfUROljfvi8BQ5BkoEAifBUCsKxDy+1rDE+konmzVX
	 adFRgyRlEAfEig81DddlSRnaNpPciKivC6ZOoFjVEpbNNhw3E09fX5b3TFBC2ZTg59
	 jvKol8EK0aEceFSwpsaN+bksgihSFwZGZnoIxCBUnMas91+F4bFecNgAxUsW0SisAC
	 iHtoPTf2BvQX7iB0EWmvhJO7/gbsnP9jLphVrjmBP3rVc+PHf6S5ABuCB2BN/90G1z
	 w/5WFO/h2pg3w==
From: Sasha Levin <sashal@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Zi Yan <ziy@nvidia.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	stable@vger.kernel.org,
	shinka <shinnkka1@gmail.com>
Subject: Re: [PATCH] fs: Free any excess xarray nodes in clear_inode()
Date: Fri,  9 Oct 2026 13:09:51 -0400
Message-ID: <2026-10-09-1-daily-reply-0014-xarray-clear-inode@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5048a2c0-8e55-429f-bb1e-4b888a728579@gmail.com>
References: <5048a2c0-8e55-429f-bb1e-4b888a728579@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could this commit be considered for backporting to the supported stable
> kernels?

Queued for 7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
