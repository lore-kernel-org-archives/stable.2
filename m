Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21E46D558
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016191; cv=none; b=L8l7PhHaEMDrQgT79K/Hoi82UoxMjiIZqumW7v/I7iZp84/615WmG9oKffNpiKS8Bvd4k7DozlAdhlUTRc3a28Iq+Q5EJzCrWZ8JleDew2gelavmZ6M8PQVgfU9T6iG3zctI7U7N9zzxso5wSJaqW/4oG9nGef4EIc76M+KTBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016191; c=relaxed/simple;
	bh=62WVbLOjtoslb3FT+/a3yeLVwcqQiYjHLH7AoSLN0Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omQ3k1X3fQjfCsHaHfPz1Tlj7MX+3UCfxQ1mXgcrYjmq3PRrTW6YOSZiIrzOSM9+/Qz+G6vu1S7LpMBOdlojr2MeLD8jsp9Bv5BQ5cPLkbu+cjrnIPI+tCyx9hOEpOwhwQ7kM6LZsD/LCF2Tpi7K4ttbRrNx0QA0ZKpUGaYi9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCEqmmuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCEqmmuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794CE1F00ACA;
	Thu,  6 Aug 2026 11:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016185;
	bh=bvhSZN+4ajsvjmrAJR0yputmI6TLgQgs6dLGE2bZ2go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCEqmmucGcLG+RFidYTRxamh2qIlZ80BwEGTWscD5t4KzM/Awtxg4hIlGonNy2Qtq
	 DdXPufjaMASLn65bAHcjSm0rWE2w73Md54NjctfHDHwdp++APfJ/vihIBUONThzsCY
	 Yqk4mWNDJk2pUXvmbncmLuJlOlLl+zUhB5NcpZdkNXZ+qpLKapefdNq48F8UfplDp0
	 fi53UnXCgjUEcYuv8FY+U/L+f+0n/7g8AoDmRv8+VJVn8LRNGORTwOaC9kCfQp7ol8
	 2tKUrhQe+oconouOqDIRpQsvEtFv8k+gRP2V/YTkWbkPNDoW9D7bugQRr1mrdDQ/HB
	 8eEjzwJ7Ut7nA==
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
Subject: Re: [PATCH 6.18.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Thu,  6 Aug 2026 07:36:00 -0400
Message-ID: <20260806021809.0007-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134525.2776879-1-kirill@shutemov.name>
References: <20260805134525.2776879-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:45:25PM +0100, Kiryl Shutsemau wrote:
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
