Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BF46EC67
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016200; cv=none; b=E/lQKGefKFjWYwbLU6NjCHa+YIHJay9mlUgFp8lpAQeKCkJtnvRn75P4NfRgglgDzSmb4HChAbRgTLnUini6G3RQ4w7VesbSy4pPVurpiZu5CUzYsfsFzM7WwJSWnE0rYQrQ8X0s7LvaQxWwIB/wSSaZF59ZDUJQLO9Q1n9CaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016200; c=relaxed/simple;
	bh=VOhvelfjhf27g3VGniVgXAJzKf904Dv5SpkN5+f8cg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ5f9maBGlKe0uwx0C0wljw/r0PK2hq2b7YcI6lqFWjURUP3ah0j4v3z2HRYX5+uxxV9Rw7xje4UTlR7xFoajuvsBUd+HrEuxQH96JyH34O7FjEgefGBvqrjhsnaC1YqFelTRA8etyIfz9uUmHVq8dkL7SjaGZRXNNs/12I0cWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ0XSgQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ0XSgQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D77C1F00A3E;
	Thu,  6 Aug 2026 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016191;
	bh=FxQwoqv/P55LntkGaALvsv722mMKOVreTf5eVmU8Pr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJ0XSgQBaw8tR8FCzFoEJuS6kIZlRTkm2/T5r/mw5z2QX4djWG8CnxDY72Qe74tsV
	 oGtW+FwKDTym4kocZlPyd2sYd5I/oJ0Y/LtRy3PRBAFcCxqFxlgGfao8UC5kQhdJV+
	 4xLRBTvwAjG7SCBLWwP1aMY1cGSgrdoNOzj3Bt49AkjrWYqnqHTv1TfcT0S9LnCQL1
	 dipAy9f2f1U04rOwWdDZEOPEe3fam2LgH7dw/4gYm4dFsg3D5x67R78TyKiqzZ+CvG
	 ZNmWlYHNLc0ipJmbZJ3t117d4HQrWXr3vFtsZcKmZBlYD+1csAc8gYLYPCrFspUNER
	 LQ2jr1VYur/6Q==
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
Subject: Re: [PATCH 6.1.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Thu,  6 Aug 2026 07:36:03 -0400
Message-ID: <20260806021809.0010-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134516.2776849-1-kirill@shutemov.name>
References: <20260805134516.2776849-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:45:16PM +0100, Kiryl Shutsemau wrote:
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
