Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD52609C5
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565855; cv=none; b=AVlrL+VZrSbWYrcFPYXEw4qcd4uSOqSlYey6E+Jxy5mZDyITo2w21mC2kZeeQTq8+I4izGXbrweoVhsueYIh9uz1lH+3YjBEmyL+BbK/19DKUw4k0hH1IGuAh5AQYDty2fiU3SYQTfJ9flBG8sDKf9sbbhS4OdPhJFBTmNYKXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565855; c=relaxed/simple;
	bh=sF011Qe/CsB4Dn4KS46X6j33LQPQLA6nRYrwGeHYzWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoTaAdx5Q3GutrWQugEPi+vhR+UfAJDJHC0BbK0CsJ41uWTx62hocQGrjQnv+Z3xdJI779q9ZGiSp46/8TTrf+JrRDZ2YifD1ZxGx9JKg5rOycRv+lf0t4ARRmsrJK+VFdK/NGVkEvTeYU5n7yFyOHnvvCvHM+sLpUZY0ung5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixKnWkj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixKnWkj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38E31F00898;
	Fri,  9 Oct 2026 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565854;
	bh=PGTwibpsegBaV4v98XhnPgqppHFoIGCZVKDjZN3kHDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ixKnWkj5trYHKfIj325Lau0Awkd+MHFGv/YEsy9torHu0XaBTdKjf3OqSKw0sI/5H
	 /JcHlJSZwNSelteJW+NU23xrTqnrB0VB0h9bpWHEUGWba0wJ39jrOixt0QMXLMIgQh
	 wyfqD0iuVbRS912MMHM49F0UQoPGOH3aqjfVbhOuVknRwOg103y7bulG8sPAQR/LAu
	 pM/4rP5hfOha0dXHDHY9IW6rAlsADqnCulpfEKkm8Zh2Qz/AfjDwNoe7mIMUR44VQL
	 WFbwwF9Ve8hgLpsnuwu/Uy/w1h0o2o6tRni+18+bT2flJrVAbM/OK/gJIxYnMcYCa+
	 VpCntkQSbqa9Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] mm/hugetlb: fix avoid_reserve to allow taking folio from subpool
Date: Fri,  9 Oct 2026 13:09:54 -0400
Message-ID: <2026-10-09-1-daily-reply-0017-hugetlb-avoid-reserve@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926071811.77481-1-kmehltretter@gmail.com>
References: <20260926071811.77481-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Karl Mehltretter: Only the allocation-error context differs in this stable
>   tree. The backport retains this stable tree's direct -ENOSPC return instead

No objections came in. Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
