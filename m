Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D5339719;
	Sun,  4 Oct 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131426; cv=none; b=MrIfQB9CV93X6xNmofGTrJkB3z8BzZaj84lfKn9+QWwUnPhFo+zTkPmviaGxOn6sHnsXlfI54F6JMGIUq56AVd8xysiaEEnOx6gXV1fvczVYisqNSQXVt5bOz6qVxLSdw7N8MT/7Xr0I2ctJ3Se0X4iYgpcbGKTo+7VL20uVuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131426; c=relaxed/simple;
	bh=hgdppLBc8R3oXIpC/R+MsreYCZG2s6GWGpuxHGBWO78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZuhZSy4inCwiTvGSS3CuT2os0wuSAAytjNS3X/r3NcTGi26gRDlTBlKaVRFjcRQ7//sZh1RJhxCiyfKgz+LosJaPXC4jiSjHE8GX6UWRYochJokxO1hnVMMWSs0l7MUwBxUdVgXKuRWjBNKO1IOrsfonqdtzGSFVvu5AnRLzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/H6OEw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/H6OEw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AD51F00893;
	Sun,  4 Oct 2026 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131424;
	bh=vXlolKQiTYSOLQhCm8ad1YUNOY84PG857e+1oHNMmlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d/H6OEw9hUH9QBmndLutyB2+xUE1vGuanwBe0BxdQ70hIQ3HcBVMhlDUXF9kXAkh3
	 JcuVhKwh37Fn9AVnmC8Pw4muqqCowsrsvDU74RYpk14Zu/z1ETVR9nX3hU2aifEy9/
	 u9twb4L0qD5tFl7rn/f9fKI+pdZA6g7hT6R3cy/6nbiAYRL8ALSEzOzF80lHfbaPex
	 u3pdzHSz3CNH/wrOwd1DOymHY5XtHo7qtNtdR/Y4elX+NrKY/VC5+/Q+usGq1Cfu2b
	 tIAtZnbIN0KxMBdRzqyCepUt8ARBvkeqM2Qq/t9t4PQY+/Y8Hceds02LddvgpCEQq/
	 dTdGU6pMA02uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 6.1.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sun,  4 Oct 2026 12:29:49 -0400
Message-ID: <2026-10-04-1-daily-reply-0011-damon-adjust-quota-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003155119.28683-1-sj@kernel.org>
References: <20261003155119.28683-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> DAMOS could unexpectedly stop working when a user disables quota using the
> online parameters commit feature.  Fix it by correcting a wrong quota
> unset check in damos_adjust_quota().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
