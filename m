Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE24B1466;
	Thu,  3 Sep 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443510; cv=none; b=aEzeVzro2GFX9/nJuEerruZDx0NvNaORt+skMEazaGnf20mdxktGYJfh7mmn7vAJna44nYnWiACOR5cyvbzR9L/7/aVTcqFEL9Ucpyvau37+HH5yAaCJLk5JKEkvtTUXGT8qQnLff3eukFZBRmzaXpMHgIthaphJnoHURxcc8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443510; c=relaxed/simple;
	bh=UrJvtxD2K/cNA5cj0gFVfE4SA6Se455/gWGMNBHC5hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPzpjnfF+TMVZIlWLoHdP+Pu8pSbz2AcSiyglaws2NNZNqDb4PYJIJDUdv6lYU/T39kIsG0WqzHaJwAWT4n3v9vYeDN3r8BK2/JIr+ID5wyB9tk3h735Svmlof6LW7escTujZp4EfD4bA+tOiOCaEWJ55yI2GF2QVIPv52r6xds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI4ZfLtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI4ZfLtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8481F00AC4;
	Thu,  3 Sep 2026 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443492;
	bh=wwn+e7XYFkZ2YAWRETWCdW/iWdxBQOPcNHMzT3rsYDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VI4ZfLtxMcJNWHtm0wcwWDXgJgZzfNxCwxI9IO9vDJNLh0Twh0damukA1JtIipw6E
	 ZKOIFVAisNr1e3MRfEXV1OfrbaecwgayHobdHwSl8FYxKX1Cz1nMWmUIOyTgevolZr
	 89+CshcRRQl1Ncp4IeqHF6iRBXBqYJAlCz5QNCO98saaPMNwDBgIwwEHKK2skaFih9
	 POnfEHQ09qtF1fLeiIbWiKHpQ2+7xNpf1d2r1BWgp+yoDkIKPFNblENtQ8Gvr1O72E
	 CywAHgqdv67tS9MPgQQYYfFAPQP26nu+rNUpepwrx3RU3RbN60xFwM/L4i4Xj2lrIn
	 /85OQHGPBfEag==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon: fix misc bugs in kunit, quota goals and sysfs refresh_ms
Date: Thu,  3 Sep 2026 06:51:19 -0700
Message-ID: <20260903135120.98408-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903031345.82679-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  3 Sep 2026 11:13:28 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Hi SJ,
> 
> > Patch 1 fixes the DAMOS quota goals commit unit test to cover a
> > mistakenly uncovered case.  Patches 2 and 3 fix the bugs in DAMOS PSI
> > goal initialization and eligible_mem_bp online commit, respectively.
> > Patch 4 fixes the bug in DAMON sysfs refresh_ms file handling.
> 
> I reviewed and tested the integrated four-patch series in mm-new:
> 
>   a20e38846efb..72dc8fdaae62
> 
> The integrated commits had stable patch-ids matching the posted patches.
> DAMON KUnit passed 42/42 tests.  I also ran test-only eligible_mem_bp nid and
> two-kdamond refresh-isolation regression cases; they passed 42/42 and 43/43
> tests, respectively.  Both test-only changes were then removed and the
> worktree returned clean at the unchanged series tip.
> 
> These were functional UML KUnit tests.  The fixes look good to me.
> 
> For the series:
> 
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Tested-by: Lian Wang <lianux.mm@gmail.com>

Thank you for your review and test, Lian!


Thanks,
SJ

[...]
