Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308F370AF1;
	Sat,  3 Oct 2026 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991034; cv=none; b=gOMCJoN31thaj9QB6hWiZmHAJ8cfjiMCdsWnLCgnq26y6BpM+sO+KCjWj0tskGoh+AGyTUFznJ8cqg5pYzXb/ZrSQMgrDXbQmiXyHVWNoylRqxvWe4QdSyx/ZibAMhBjpdqhwpPWx0e9qodV+GNKuN3ey59RZZIPqAXwTUOJqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991034; c=relaxed/simple;
	bh=sKUWQDFqjZLGs+YRTauCUVJjWEgbdfMnBtfPsPHXtls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWSWMlXJRskS6SXVOEvIGp9jNLURLoWIC+n7xBkiwgzfc66QqYcfT9dY0FCYEmSWMsJimFJgC++mAGFZ412vrkBbdX84hZjZi4LEFNP249Umlvy18MXrBvmXLF0V4p4lZSWMPkcTPRbVerpAvGvlBwzveKT9fj2ie2a4cmvXjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4WpyFtA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4WpyFtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82C91F0089B;
	Sat,  3 Oct 2026 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991032;
	bh=CItS/zWgrIg5kKOatrfL9GJj+0e9m4dKbtj1MKAf+Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4WpyFtAYLjkr7KPPAFAoitkhNVm4NxF6Bc3vyTlMLNUUWTrircsQGYH2hnKBHYtQ
	 Ain0e6HhY7nHOsKk5qJOTvv8vTu697dRpVacMB95bvPDx530QQ9/3/BIU2PuDkyNdc
	 RL2AqubLicNeTwjKVALA85EGhcAEwSAHBwVvVb0ECxKybkNOnrqJDxW6ScLiniPPGn
	 sDclN8NwDUco6m/mSbomG550Z3CAai20FCctU3iRmraho06oPxVeDKEl8odEPjtJft
	 Hin72Cg7sq674CSDHkbRqU9NFpOCYQgrBzAz8JTIwiuqr+uKuSF6Fzz5NNrqIrBHk+
	 kOq9k30144T6A==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	rppt@kernel.org,
	peterz@infradead.org
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	4ncienth@gmail.com,
	alexander.motin@truenas.com,
	caleb.stjohn@truenas.com,
	ameer.hamza@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while perf record runs
Date: Fri,  2 Oct 2026 21:30:23 -0400
Message-ID: <2026-10-02-rc-reply-0003-re-secretmem-sigbus-perf@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002175651.811343-1-ameer.hamza@truenas.com>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since commit 97d34aa65c29 ("mm/secretmem: properly account locked
> pages"), in v7.3-rc2 and the 6.18.52 and 7.2.5 backports, touching a
> memfd_secret() page for the first time fails with SIGBUS while the
> same user is running perf record, and read() into such a page fails

Thanks for the report. I've dropped 97d34aa65c29 from the 6.12 queue,
and also removed the copies that were staged for 6.6 and 6.1.

7.2.y and 6.18.y already shipped it, so those need an upstream fix,
which stable will pick up once it lands.

-- 
Thanks,
Sasha
