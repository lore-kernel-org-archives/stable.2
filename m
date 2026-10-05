Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C89488755
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208293; cv=none; b=PFIPlY55fUgSvTICPd9H1wpg/A0TR6f1UfNPYg/00HkNXOdSgu3GlHMjKu5F/7PSrpx9s4itH8T+H+wl+W+ff14ValAAB3T4Dyp7gJ9XpOosmCwJAr64rt5XtEtMWIsERp0+wUnjkSdLUSVruSPimikAF7/Yq5mBLhfiJL8nJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208293; c=relaxed/simple;
	bh=HrHePazhvMNht8ItXF60cR4DRoRhfFWqdEDrFMWEK84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzP3YMR9yB0DR8MJOsTN9SFH4ZXZjeLobrO/LIMNHk95Z/f3rfRNSxgGqs4DrNVwHewoyVOjKAOW9xcq3r2i6Gy9M0QcYMJYA+tsiexDICtRfXmoeukjWQPd2NdC/WDepLPjb1W2oEZMN2fmCR5Y/DEF9W4oQifs2kSKpl86aBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmm94aTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmm94aTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66D81F000FF;
	Mon,  5 Oct 2026 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208291;
	bh=koT+oMQ3WqftJggx7juo+p1cvqa9ktKlQQOaj5Qd28Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jmm94aTaLKVa3i7Xb9oaFqJbOL173QqqbLKtzDgPSqvpJENayevaPS6raI97TYMqh
	 k9xOCXlylKgRfWJ3xlxBpzkFnHUbbhgjz7HB4uTIwfDkvm9xmb5i5mMzzfq1RS42uS
	 CGkbhvocr7qYxGz4U4WyaLSYTXIbkgbwPXT5iuo5FJFtExutUhRytQWa4LCJATIMbB
	 FQOp0RjkZlKSYaCBRS8EeKSblSKo5WW9+bxsbn7gsCrj3N4K3yeuI4rEvIW+yHSpqt
	 Ubp4+YspAxl0kD0ptknuXArSM5HzNO+64wK+11pe8IN2LaioMgFEFLHws5C3RLtVxQ
	 OHxebZJb9JcGw==
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
Date: Mon,  5 Oct 2026 09:50:28 -0400
Message-ID: <2026-10-05-1-daily-reply-0007-hugetlb-avoid-reserve-cover-link@kernel.org>
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

Ackerley Tng <ackerleytng@google.com> writes:

> If this patch replaces the linked series, the commit message should
> reference the upstream merged patch 88819619688c5 ("mm: hugetlb:
> consolidate interpretation of gbl_chg within alloc_hugetlb_folio()")
> instead of the unmerged series.

The commit messages carry Peter Xu's upstream text verbatim, so the
cover.1728684491 link stays. 88819619688c ("mm: hugetlb: consolidate
interpretation of gbl_chg within alloc_hugetlb_folio()") only reached
mainline in v7.3-rc1, well after 58db7c5fbe7d ("mm/hugetlb: fix
avoid_reserve to allow taking folio from subpool"), where this text
comes from.

-- 
Thanks,
Sasha
