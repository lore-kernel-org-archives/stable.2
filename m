Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251A246788
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828871; cv=none; b=RK580912H2N3zpq19sh2SVQecAUCYPttIMaNJurtJSlDIAIcjEy5f7h/OiHbLfcjLiI8ZDq7D+vtmIqx8Mt1p1IQFVcj9uln6tltrYEH8p1jlTIncyYm1rsCxVZXa5x+CovatZS6fqht4rBOk/WqpPu9SaaAOXvLjhKM7ADXGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828871; c=relaxed/simple;
	bh=vv09QCylrlfNvL56Kj5uRDs97x1TXAAduw0Zz9LXaxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VslMVp66xQPMM+U/frBUYQ8pi+zIqXGcK+akdRdzx9AH3kXWjXtAMBwoDf3YsAmKGjSA8NEiiVRxF0XLrgUaAa7J4PHXNkVZKuW7YoDx/yGMiTNhO3qgehCwHwwHU1JySCFmoi1biH4Z1octwLS3IHKidRCnw65ux2QcUml2F1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxsUmkGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxsUmkGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A411F00A3F;
	Tue,  8 Sep 2026 00:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828866;
	bh=31AWs2kVyHOYcRZI8JpmDHCh1SR9goxJz+KIlnJEu4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxsUmkGS2sAYmpAPMFCFRrYseushUOkVXYMyy43RebH/eSJEZ9IHZk0Ku+aCBEdmv
	 CH7ZLgkmVE/6Dlp54cOHae8dnJbfB7R5nv5/c/zu7yLGH2lVkmTzzbVlzPW6VnFzcn
	 BhHk3RH38aZ+oJEsl4dy8vrounXKUrV66UNtBvMdow1EcqLBgGQuUM5j9cpIZrsgPL
	 yS7Y0PCuW2+7X9tGYzPvSOZAgXKR91bLqE/P83OuRHq7KI7dXSfCi2OfydQ+8ZR4Fj
	 hYGaOdqVlFIYy3QSZEIwET4beQGwqlffGi/6ZaVqALOURqBwb/DSXDn7sRn0Zsjxep
	 l0+he1cS9IbaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Mon,  7 Sep 2026 20:53:57 -0400
Message-ID: <2026-09-07-daily-reply-0018-mm-huge-memory-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DL8LKM3Q9LGZ.DENNSVG6XK1C@nvidia.com>
References: <DL8LKM3Q9LGZ.DENNSVG6XK1C@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> No, this is not needed. Before commit f1cf8d2f36dc3 ("mm: memcontrol:
> eliminate the problem of dying memory cgroup for LRU folios"), like
> v6.6, a charged folio take a ref on its memcg. During split, the folio
> is locked, so will not be uncharged. As a result, its memcg will not go
> away.

A review from one of the mm/ folks will be appreciated here :)

-- 
Thanks,
Sasha
