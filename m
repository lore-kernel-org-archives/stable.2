Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B73CF1ED
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437825; cv=none; b=VJXAXkLcF2Vp+tz85dHe9BjVVL7WKsyTctwzD7LVbxQ58zyBz1Ebl+h17a4Lv6zPEI4Czdot/Y78unfL/ELjtKDIBmNExrUgBvZqzRNsSPZRl4/Z56Gx6jacDSde/PcYQSpWDlaJZyqfyWTJGNg0ZtneaAfPccZKyP8LMulohUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437825; c=relaxed/simple;
	bh=QIpvfoUZi1uBDMucFZ7tA0gZCyKAD5hwddp4gfcqw9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrDlcFg3QM0rKCZczw/PF6du6kjiI6ZFH0UjgvLW2jqQFFqIc13fNs6MQX7lxj9g1AZUC59tvhwZ8NnwIJy66ggPLMfb7qcGUgpMMAdvnf6TM6/rrglsjgP8aw3pZDRKMShzVF8YEa5QBmX+wgBZXL/ZAxb8ZZVIBEgK7YKjwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7OQk4zG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7OQk4zG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2231F00893;
	Tue, 15 Sep 2026 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437823;
	bh=QEC/OmnYCPvebQPnKm5WEAJmkyNeHAwKGHDGqVwn4kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A7OQk4zG0jtWjctXMCA6TbejSGlPAOoCAIJNUwQFSfW1VjLy0UhtyzH4UtqMCAdNk
	 51G+u3TljRXQYcFbWVWz8G+iQHw76twBN9O3rzhJmehcy3+1gFdQX8MiH8vXj9exuP
	 zHRa3dLq1IlhUPuJhKcP439Lahgii7IE3J9WuypQ43acJMjspOnH4SmkHBp6nc+nNH
	 XdXOKaaGI17CsKQK0m5E3R+znzfc/eatxS65npw4uerYFy8sgEjafvIXiig2DUUFvs
	 1p4ncI/8E64LUo/ckfL8in+FSOizVrCznU5LU8EiQ8lnjNocKqaHUuJI/qacu1JlSV
	 z2qbXC2a+dk3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Mon, 14 Sep 2026 22:03:20 -0400
Message-ID: <daily-reply-0004-re-huge-memory-folio-split-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912182926.1326147-1-ziy@nvidia.com>
References: <20260912182926.1326147-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> During a pagecache folio split, an xarray node allocation can happen and
> needs to charge at folio's memcg instead of folio split invoker's memcg,

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
