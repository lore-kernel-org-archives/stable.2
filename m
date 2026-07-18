Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762317AE11;
	Sat, 18 Jul 2026 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337403; cv=none; b=qE/RSmto2H1c6SPQ5WtYEcB3oDD14YCeAj+4AuH7x/h/ZKCaCaVauviB8o+XfuW96GEyHraLPTPiI0D35ssHgpRevFhyjkYDqPCEFDla/bvlwLSqa9/ur8S2K8baQ2Xuoeui5VBmDpfgRK6TiummKh62cwMKwdrcKnQ4SDFJawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337403; c=relaxed/simple;
	bh=Lqi2YwCusFbChQ7YTr8FMBpdtA//RV85o7CWGL7aswE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL54O1rk63CFilYx8KSnc+ouUsXbE84JjKrClfeTIqdqdcf31AndB2ieJ/4P72+EPzWP7n9rz4elBD6Rs8kXU7pfTzh/UN8o/9C75Peu07tcxHm4aZ+WCX3wvX0FwYrCPULj9+k6weL0SpJbpLXcimUn88GWh1GreQRvG8x/3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTm0b95q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTm0b95q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CCE1F00A3A;
	Sat, 18 Jul 2026 01:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784337402;
	bh=48yTB0Lmrlpk8mR2lJ0g6c6+HUj48QmCvaO5G2InBZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTm0b95qgrff+QxYQfesDPwKrrL3LF3vu3i5qbdg3GgNN5ixfYjsTPZ7bC+Uu9Jjl
	 ex84bPnshtoXqo/05QEzk42b9UCM4g+JX6C3lvBV1AeIwG8B7pflym4wCUF0DOBQkc
	 j8LcG+sklUYJ6v3qnwIkZWJM6VYZ051BddzuzKjGVQPWbf+RmQS/zvJcMttMeJyHVo
	 psdeX80RhJcBO7i93RIsZAG1OfAeE4C2uiPMSRs6iyt4XixqiNVzE4ZTUFOlt863xp
	 FEStjzTBRyEl8oeYSr47E8VOFH1XRqNypGOrJQt7SOTwS5i24EP2mknqueMLxLPnCu
	 q/v/ycrABYj2A==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/core: handle region split failure in apply_min_nr_regions()
Date: Fri, 17 Jul 2026 18:16:34 -0700
Message-ID: <20260718011634.94132-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718010312.90397-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 18:03:12 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri, 17 Jul 2026 17:43:00 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > damon_apply_min_nr_regions() repeatedly split each region until its size
> > becomes small enough to meet the user-defined low limit of the number of
> > regions.  The loop assumes the split operation (damon_split_region_at())
> > will always succeed and create the new region.  But the operation could
> > silently fail for memory allocation failures, for example.  If such
> > failure happens and the region was the last region, the linked
> > list-based next region fetching returns invalid pointer.  As a result,
> > invalid memory dereference and corruption could happen.  Fix by breaking
> > the loop in the corner case.
> 
> Sashiko found no blocker for this series.  Sashiko sent findings to damon@
> mailing list [1], and I replied to all the comments.  Please read those for
> details.

My intention was to add this reply to other mail[1] but I only mistakenly
replied here.

This is true, though.  Sashiko found no issue in this patch.  But that means
nothing since this is an RFC.  I will repost this patch after dropping the RFC
and rebasing to latest mm-new, tomorrow.

[1] https://lore.kernel.org/20260718011322.94001-1-sj@kernel.org

> 
> [1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
