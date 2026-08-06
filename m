Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47046D0AF
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016199; cv=none; b=eU4Ld/+TVLK7LJWLJ4shsbfcEqMpyAsZ+guo03Tin7PwlSq/GCwKPkXeJZFFzS62mQjXiQvqxUkAMBVfzDXp3zZBPGtNqWi8Vy8tmrB2p2khARPQOcO+Y7USJ5WktC1vZTFydYVAnDrSvHEgEU/30xEqVKNYHBrhMF4JWxvveHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016199; c=relaxed/simple;
	bh=2n/VP300EvPZVzkt9GC09C1QastHRSlcFlJK0pFIavU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdXL/ayb70SzPt6fp27cPFAV98/+cnUhf0rSLT9kGxnPTbZ3JXLIxwbwo/3+lSa2tdQRRiScq7nqP3QKaqsyho8r8NmHAy1L4re4+fjNcNgB7ZjNT3+fXVkoFxTlVn6KouyM+XZthtUbYUZS9o/ltU1YOGn29izUpOgf1S7U0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEnap/Wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEnap/Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C611F00AC4;
	Thu,  6 Aug 2026 11:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016193;
	bh=1ne5liH5TsShl+ooqirpOYa1hSiSmtb5mhUPaEN6tVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEnap/Wze3Sz7R5uoXOj0khJXi1dFieqPBlmzPnfO1t2wBkkhxEB1dex5S4Z4Q62t
	 x5B4Tk3PI5xC0BKdau2IZNI5krJaIr3objFEHSAVEmsw1cLtBbTSb3Qyqkjy0ccJJp
	 HZOTxAvLzX/i+n3cvyCSVXhmw52GwK1Bj4N3FD4N2pL8clbZmYhdjvDeklrA18tgjJ
	 pjPb8ILwqr8fNXOZ2P4RWsJpMHeenGP5nZ+MS37wemqG0+npD2V7H/pnNCwtGpZf2C
	 Cae97hLC3VL+TdDlKQRA8OCIC1nadpAQ5ZjPFNil3kGfjMvuKX8BTBFjb/yhEUDjXe
	 Iz8mZ2xTwTScQ==
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
Subject: Re: [PATCH 5.15.y] mm/huge_memory: unlock i_mmap_rwsem before releasing after-split folios
Date: Thu,  6 Aug 2026 07:36:04 -0400
Message-ID: <20260806021809.0011-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805134512.2776839-1-kirill@shutemov.name>
References: <20260805134512.2776839-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 02:45:12PM +0100, Kiryl Shutsemau wrote:
> Do every mapping dereference while @folio still pins the inode: drop
> i_mmap_rwsem right after remap_page(), before the loop that unlocks and
> frees the after-split folios, and clear @mapping so the exit path does not
> unlock it again.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
