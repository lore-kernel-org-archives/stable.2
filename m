Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336E3E47B;
	Sat, 18 Jul 2026 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336601; cv=none; b=Pnt+UqTFQN4juUIbfxmXyHD/L+/blA6cy3y+B1rOfNnYaLmYsIMHUGdZn5M4u3b6qj23nexWHntx/m/U8cj1PhnFDBfzbNCp/k2Ref6xA9my/MCBBSnu7ugOQlGX1JVn63vAMuickIvxhmXIIGsz+V7jwTJs77SQxWWKB0iPQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336601; c=relaxed/simple;
	bh=1P38iWfAy2/u+n0Vh/BQ/2uxERZuwJ4Fu/hxhXWtRe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba9rGyjdLbvYeBCfFYX6XKtzAh6yLMPpuufTFReFxNGokNOn7QscdrfxCR5Uj46zL+mn4CzIW/9oZv7KSrSYEjrGn9XuQZ2elZUGyJ/nH28a9cFYDl6ZHqNsbOSlD7QeI97uV2nW/HMYowLy7nGMRQKJcOpL92mbMk3R88X+I/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtgFufK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtgFufK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F261F000E9;
	Sat, 18 Jul 2026 01:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336600;
	bh=Q6G9ezbIlMVkU6BcAV6AfIPu4SPtlwXOdQ5VEzE5oyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtgFufK82hKi0p92Oz2iEIH0bsV2mt+tfaM0nxTrX+TUBsz6ayYift2JGtxF8C/f8
	 l+CcrMJavpvyJvF3GWP4kiCLpWjjdytTSAV312rky/ber7d+dTjHMn45onaD1Orn9E
	 2e8H3Yb2Zm8u7wkMZDwwojymk5sfzCVRwKp/YtKAa96bhk6W9Dbb9m5lMEwd1805MH
	 pOpaGdmNfG246HUO6aANfY19rHMQo8/bol4sguYMcAgxSX13BhrhhN4OOVfwyQa02t
	 1GE0MBCV4ZdlZdg8IxMKADAkgB8Rd1JZTK8tItUpad4aPBE/njWrmLGo+uIzEYdBYp
	 R5qMY1JrsxXpw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Fri, 17 Jul 2026 18:03:12 -0700
Message-ID: <20260718010312.90397-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718004301.88883-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 17:43:00 -0700 SJ Park <sj@kernel.org> wrote:

> damon_apply_min_nr_regions() repeatedly split each region until its size
> becomes small enough to meet the user-defined low limit of the number of
> regions.  The loop assumes the split operation (damon_split_region_at())
> will always succeed and create the new region.  But the operation could
> silently fail for memory allocation failures, for example.  If such
> failure happens and the region was the last region, the linked
> list-based next region fetching returns invalid pointer.  As a result,
> invalid memory dereference and corruption could happen.  Fix by breaking
> the loop in the corner case.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
