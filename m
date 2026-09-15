Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB53D0BE9
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437844; cv=none; b=ZsBkE0i8Hkmmp6nbjtr0hOqwl2ByYTk5wrrk6Aq55HDR1dk8fuQYc7auzDEMZ2UVtY0qpzeMMCwwR3KVgv+em9rhaP1B5HUNM7S8RMTbe+odVNObJifg8DL6uO1bpcyJx5p9/0ycXnKWl1XwfJq2hJTLXY2jpR2+UhZ3W5SNo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437844; c=relaxed/simple;
	bh=Gv6tN3a6Q6P65CXBa5Wpv7Esikf/enVC2dc40ZVRgmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQJtka5yIKdkBMoC5VEjW4DgGXUNVop6Q5GMWNbkcaOklWXCB2hEqlOwFdLz+PVtTNbSdtKfb+t3Xf+cEdaxn0VlzfbNgc37yHDfHltjpCjcMsBhzpy6X6NcviXE4wR4cVKcUd+toFHBNn4o9Qn+SVnBm1kac0fAixm+p6Sgau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjvrVayF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjvrVayF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A351F0089C;
	Tue, 15 Sep 2026 02:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437842;
	bh=K3ISQMo/SQBwlYFqO2e+0Esnhs8jBO7YspRnICa6F3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjvrVayFJTgOPeZRvkutZQvzsonL829fC3KyyhbbpQeUUjrEi52qbZmRrrZt7jYll
	 eq75xLle8Fw+nJEfI9ChYqwoIwyU/AhlTfOhuGLWaD9doGPaFYDAc+tkNnElv8hYlB
	 Q/anq0WosR2EZiMU+6rdF9Q2AIzPla1dBMaUxXPn18mGZ5N+UJ4QBZI897PuLBFI0q
	 ZYB3TvYf4M22fb2mwRu3XxoyZhDyR+gYvgqWEPZREA+pXtshgbwXjDBqbamnKqaAgT
	 ASxlSaXvq9LyKEWRdmcem5vmApQ68wELVr0LEiGKJiqI25+6TQId/8BF2NEGhpGN2c
	 MjGBm351ksLlw==
From: Sasha Levin <sashal@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Mon, 14 Sep 2026 22:03:34 -0400
Message-ID: <daily-reply-0018-re-huge-memory-folio-split-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DLDJWF5NE46Z.3JBTVOKAYOYGU@nvidia.com>
References: <DLDJWF5NE46Z.3JBTVOKAYOYGU@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Done. See https://lore.kernel.org/all/20260912182926.1326147-1-ziy@nvidia.com/

Queued for 6.12 and 6.6, thanks.

> BTW, I see you also sent one[1], but it seems that it is using a
> non-existing get_mem_cgroup_from_folio(). What is that for? Thanks.

That one was generated against a tree that has the helper and should not
have gone out for 6.6.y. Please ignore it, yours is what is queued.

-- 
Thanks,
Sasha
