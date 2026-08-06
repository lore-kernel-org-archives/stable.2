Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FE46DFF8
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016199; cv=none; b=ZkzkhwwBQ7jv2PABoW03wkvmUv8nyVz/sM/kqx7u62RoHQ97/OlfFsrZaHzWcFv0xpYFZHEp9WhEVmzRyB/WAtIfFyq9x+/djAra5JGpLC6Oe1F4eweK0yF4GeQlG+5k/HL2JEm7kxoXbKLSuDKcCnZKvasvswlqdTPGPglWeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016199; c=relaxed/simple;
	bh=EeWXJXr7NmGcjLcMmPPyrq8g1UBzBZYCCNCfMFXbP+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0yLZBaHHBp6yQmIw6scptCCo/Ik8X+I/Cxtkf1kC/prFxxaVB7ckF7O5nKWXtPJUQekB3cWQ93REdxaWwlRo+dPifa7BRFGxwVvt9Tfu8xKICCeInHPw5fGzVbu54ELeHHG8I0l3U5DVSXeEmMxaGZEl/Gurbj6q9VYvx8Sdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdBefCIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdBefCIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C4A1F00ACA;
	Thu,  6 Aug 2026 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016194;
	bh=RzSMjCE5aKICZ0hRoRsgDQ3CLTTMJoVJpdIzQTO4YHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RdBefCIogOv5InhWk+2dvU72salo3odOcZPX/lLPzwaWDRNSxuCp8eTukRUaGagIv
	 MOqDAzgzdsfICsN4M+cdKHI4Hlgo3SLfZIj8k79A9l+NqRAbvUlg7wFBL6wxG+tcWt
	 aF7YVVY9l0FSi0wdpxDXLJiw4x4ulF51jla0kMdOkAU5nDybxqQ+3wS9FCJp+wBiLS
	 mN0V0nL44ckdpK1/cZPAuKRSyYQ+GolTK482isFAHV3uMMbNMZu4/d3Rn2/cFU9ptr
	 FTy3RYzCCGGXa1PrSlt0UXlnRt1o49AQ9murKj+80m6EPZnudxcTnCoK9NZnxtSudR
	 QMQljvbpvW/Qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Hao Zhang <zhanghao1@kylinos.cn>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH 5.10.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Thu,  6 Aug 2026 07:36:05 -0400
Message-ID: <20260806021809.0012-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134507.2776820-1-kirill@shutemov.name>
References: <20260805134507.2776820-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:45:07PM +0100, Kiryl Shutsemau wrote:
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
