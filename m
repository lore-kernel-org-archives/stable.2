Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679B46D568
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016197; cv=none; b=tABr464Ki+aBte6wmnNnwJZUrE6eQG6OiXkjqVk7JvrAOFmRcexSAm/mEu09eIfJJN6aqEn1N+7AilDd0lhvCDSBuE+rdGKdHIKz//il7IMRYAm5gIsD59i94yYGfof5zB3QtZ2l3ZU6WebaqgaFUp26TvHWX6hYgogI+tunZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016197; c=relaxed/simple;
	bh=PBQYPg0npf4mRNIWIouaEusDX46vlGzhWsg6Gyw/q68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpmwtQJ36m8bXezjGA2s8Fbi2UBzJ6K1pi8F6H3u6ZgnJOgxO2O92eA3WrZpjBwtB7Dl/Me+oku48mbqhTKp1KPcxQGumM+kJYe6/BwtfXXQuwbdVwuCtNlun19EbUOY//jBOr4DkXvwMF4RrxhRPEEWlC8Ymx23shDArdn0Zfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7dAMR46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7dAMR46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F431F00A3F;
	Thu,  6 Aug 2026 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016189;
	bh=ysJoMXA0J9FGp5OMbgay0v4HrXcbX4uBHe67OZTQfs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7dAMR46mrYXcYfyKXf42522cBc66afId+ThTCffYZqLv9+TI1tmI4kcCL3xYKYY+
	 TSmn3sjGTuV6+5qmAR3KV3843+z/lb1gTIO4OqAK7Q6o9b96BY9N6hs6gvZIlrx597
	 tzSUDCrx60cILNiFgfQJ9wZ12pMAqO7zrFhzUCNEWUdoP0jh9paUMmps3l0faKF6pu
	 dpKQVLyFKgDW/DyXOOd7jOPL+5DjVlpO+BAUitm3PBe6n3NeyHESRhz3+HgfYMY2vG
	 l2zZ12OFYfA5dNYC45oMmVyvrBQpxLfLRKF1lR5Io5ba5WP3biuXK8kj/03myHq6XC
	 OHe2yKMmBrLyw==
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
Subject: Re: [PATCH 6.6.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Thu,  6 Aug 2026 07:36:02 -0400
Message-ID: <20260806021809.0009-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134519.2776859-1-kirill@shutemov.name>
References: <20260805134519.2776859-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:45:19PM +0100, Kiryl Shutsemau wrote:
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
