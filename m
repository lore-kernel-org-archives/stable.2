Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193F2E040E;
	Tue,  9 Jun 2026 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966346; cv=none; b=FTKUVUg821svlK60wrKaAR4brB2RgotPTRho95WK88yMnfK5sFdukLsvM+wkNjENmBcceqEgt+dPNGpbP4w9UTPXmqxYOo/vDicgBj0cF29quuTKT/KTVxGpLZx71s0Lx6xIE7zPQg3ZeRHTRS3K85//fU0Uh0p/5SMUpNcIKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966346; c=relaxed/simple;
	bh=huvuw9ocJVMaJPY69c7Y/32YsqsUK8XeDkGkdakdgRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbtd2kJSjQQgpGcoRkD+cyN46ianfZyJ2DV75VGulmQFffvPaNXiTfYoI3MEiAaIOfkICA90lTih4DinYvDgCywMT6liQSAxTy9I/Dw2E73TwW1xOOIloGCCPeGfVbC55gSQH8ZhF7zTr3JgzOitC1jUn4lRUlVvCX7ih6+sCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTLCtw3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTLCtw3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2B61F0089A;
	Tue,  9 Jun 2026 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966345;
	bh=huvuw9ocJVMaJPY69c7Y/32YsqsUK8XeDkGkdakdgRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTLCtw3rpDDm7zkXqLgSU0rqtauNij+Z39bxQM16InMfMO8/XgdH+ZvQ4qtergGM3
	 lQZF5cp9zeYnHWI0y7HaSJDHon1xpD3oC1wPyCJ8XBA5+Av2Ic42XBhP29VlPPVY+l
	 JjAmDTJco/vLsm71tralhY/NdYJBhmvGtJSD1D5os8UuHUCl6Z/kl4FH/GwgoaaXHD
	 TGT6rMqX4mepsVQFEB5i/39RS4jYv0LyCf1IoA6aCiU0d5YYM8/z8oCk75x8oCC3Kk
	 vmwMrPSFSNbf5b8i6KkISi6eRTHxqr9ypkoQAcepKd8x0S1W/Y3aCH+EIxngHExHAX
	 b0HSFNm4cndbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexandra Diupina <adiupina@astralinux.ru>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Zi Yan <ziy@nvidia.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Pankaj Raghav <kernel@pankajraghav.com>
Subject: Re: [PATCH v2 6.1] mm/memory_hotplug: fix hwpoisoned large folio handling in do_migrate_range()
Date: Mon,  8 Jun 2026 20:52:00 -0400
Message-ID: <20260608-stable-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605190756.20413-1-adiupina@astralinux.ru>
References: <20260605190756.20413-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH v2 6.1] mm/memory_hotplug: fix hwpoisoned large folio handling in
> do_migrate_range()

This inverts the folio_isolate_lru() check on 6.1. In 6.1 folio_isolate_lru()
returns an int (0 on success), not a bool, so the "!folio_isolate_lru(folio)"
condition is backwards here and takes the wrong branch on a successful
isolation.

--
Thanks,
Sasha
