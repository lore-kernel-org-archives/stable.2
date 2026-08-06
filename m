Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5B46D54B
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016194; cv=none; b=NBX69gEvcf/GG2bEvq12byOIEGdr1gRuNEVXYdWm4UotnpJftSxH59sep7y0ZpUq2r2DzJkMPOLEsUeZE8vsocJgugAdxb4PSpSfLNXBTYvqXINfBqbDAWYuGXAjRPIUughGTNSyZr/5GHKAoZlhcY0EKq8kNyozKwBF1HXs3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016194; c=relaxed/simple;
	bh=dbpCwEDvMIoxNowg8gb7jYvFIXkpamCQ309RbQzlf5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHIgHhCQoZD044HSeCrov8jE5ivtt1XS2La3B/qEFwEiP4rfgXcJ5kJk0VoUZszbGgSZHc+uzNgjFgfgGzmZJY1h5sn8E+KETVvkAq6efP4lgThxq744lCbdxUhYE7c5CorvoEus6WFXKfs6mV5RQFJoOCoS50wsF6IbCDepUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN9qOeSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN9qOeSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD4F1F00A3A;
	Thu,  6 Aug 2026 11:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016187;
	bh=pBsR+cwv4fPTYh4nFsSRNXkfKSBkiwNLyfd5Gmp5F8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BN9qOeSpiukTEYyAXCHzdBsnOCwbzpNOljKV9TthJ2XnR1+F2kBh7n8jTbWjS5cy0
	 eU6R0PC1jg1Nc9/K4+cIH+C9+4IQUIFTY9z1rgVAO6iJsGnWOpIF2AC2l3rslW9KjU
	 DmaylHIFyDXfOZta1zAivaiXwC4MnYMYuwRE2WWSI4lCy4PjBg1llZGzSH79hkO4hb
	 2/EraQQIkH1Kdt5jLkq2t1R32a3nkFIoaA8m3TljjYB9cladhZClCobOEXARG8U96B
	 4PTqmeW3JhYSkyScs45EgwVDL3kj+pWCL4BkS//sxS6bXcpi2dSsS6Oc+3vWUJSKLf
	 WbR/WJudsqAWg==
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
Subject: Re: [PATCH 6.12.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Thu,  6 Aug 2026 07:36:01 -0400
Message-ID: <20260806021809.0008-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134522.2776869-1-kirill@shutemov.name>
References: <20260805134522.2776869-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:45:22PM +0100, Kiryl Shutsemau wrote:
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
