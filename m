Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AE2E1746;
	Sun, 21 Jun 2026 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065041; cv=none; b=PxACMC6TuaQevwxe5Rscv18mPzb98gzUIyFdo4yvmG2QAXLOraHcjgJAjtl4+zfS2wrBSqSbFWmJCGBbGCt4HAF3O5l6bKkyTLML/BMmzku7Gnu6LdrpCVmx0m+feXNMkmtCGO/N47w+F/URvLVnOtpqnYldtlyIoKfVZ6j5y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065041; c=relaxed/simple;
	bh=urV3/Hya5bWJMcInGDRFF2WF7uruU9KgDFH488Jfv6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq+k3bA1+izlgqdZUF8ZHTk8sWpGM/2uuzZJwlRRXhxupz/BCHEQ/QYGLCyTxotW0Q6fJAopGlcG63mvv0T6oDrBik9CfXXVZNXGUCg0nRZQHoSMt8oFmA4IFqtg4S6LCTBCW3XmV8HlYbU9xzjqaVTO0WT3d/pXd4/xb8Wo1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0YSS5Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0YSS5Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA0F1F000E9;
	Sun, 21 Jun 2026 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782065039;
	bh=54TyF7XxWkGv+SmhhNpIN1Mr1dGEVPPbVs82yylKPaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0YSS5Dh6e/G7+zzbyorV8r97fLmf6IUEwf9ogcwCELprQUPx6gmVUJBhK/HXRoY9
	 LKPQPCvnZz8IsJgmWJBIMS6Fcy9C6R3oOu2zQ1v7xwOgL64Xu7Ito4qX+U0S195aB5
	 6X1juTWcf3xtoFh6B5GWEDcZRmoZz6fvC8kMuzoN5hlfpT6XFawpT3EzVGqxIAxGFd
	 w7REcOpnrH9uc/RNYlfP7MLc7SEi7Ncl/MOQ3oWmP3BXN4EfMKHU6+XWmXERQgWcny
	 ogQRLZzMMUgQkZZw0+bBoBjC5jf62bDT2uWZLlehFyQ/HmK3xDBAZ1X1sdN24e9MFW
	 KI3Z+FScSoCJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Sun, 21 Jun 2026 11:03:47 -0700
Message-ID: <20260621180348.92118-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621154808.86431-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 08:48:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_max_nr_accesses() causes a divide-by-zero if the sampling interval
> is set to zero by the user.  If the aggregation interval is set to zero,
> the function returns zero.  It is wrong, since the real maximum
> nr_acceses in the setup should be one.  Worse yet, it can cause another
> divide-by-zero from its caller, damon_hot_score(), since it uses
> damon_max_nr_accesses() return value as a denominator.
> 
> Fix the problem by setting the denominator in the function as 1 when the
> sampling interval is zero.  Also ensure the return value is always 1 or
> greater.
> 
> The issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org
> 
> Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")

Sashiko found [1] another bug that was introduced by another commit.  I will
repost this patch with a fix for the another bug.

[1] https://lore.kernel.org/20260621175849.91990-1-sj@kernel.org


Thanks,
SJ

[...]
