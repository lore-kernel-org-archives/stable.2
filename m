Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161D38D3EF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559096; cv=none; b=RjnhuXwaJ+y+OGxTdaz1KAIQtM1RoNGDK7cNnOKZkrSfP2qaBSrkC+4gHkj+HpVMr+msvGAJ2fgeCkg6p4S172Eqcsdvc1kSYpKQQbYRhADrREPMY3+mxS5RJloscPwCpo0bpEzgSI1DbYVosOslEA8ay995SzbmB+HNnadnLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559096; c=relaxed/simple;
	bh=8QUExRJTo2K++2VPjUC3JYAGu/pSrkUBYnVqqD0hrew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rziUFe2rolcBCleT3PLLa1PANX8cOMBsbjEpTeaFlc/UFduKpYzcgB4kVXuXL/DzV3dhRZ3ynqLwj0CvCYwrIEPgNf0rAjmxMF85kdg3RW97TJA8IGmSR9a0DqpdF7+r+zMmeK2RI0CGhznx7/L1XGp92vVM7Cw3b1yzx0biZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNCRDg89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNCRDg89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD061F00A3D;
	Thu,  9 Jul 2026 01:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559094;
	bh=8lPF4LvJLl1uWKhscqc7t8ljIdwptSB+An6FOxpXAoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CNCRDg89ohYfJw2WzoTGnSEZAVZSuSz6GE6lI2hYBfFTyKmM3G/jKNSksXQN1rxzK
	 /o2BQnxpxnVHfshvmcN78jFr2FDkQ7tFKjgOTfmdqnbuyun3QNUNgSI9AJF1q53vST
	 9NWGb59VgjWiuea1AnvvFovTt5yB7neYDW5p6T30AAm3Ir3gXtukYjGcg5eMmUOCYB
	 fJCAs4XSQqZ12lZEU2WBZajR431u9u3OnO03IY3OAj8q/rR5TdRwZhifC9Bq2unPN+
	 ljORehq12+jqGkWkKN5EJENsbpXDKxg7Ztup0cY06Q2vIPiydrokcpRZKiP48Jd8cA
	 Cg4gz0mem25Jg==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Song Liu <song@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios when collapsing
Date: Wed,  8 Jul 2026 21:04:47 -0400
Message-ID: <20260708194323.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708151357.353173-1-pfalcato@suse.de>
References: <20260708151357.353173-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix it by fully writing back the page cache (and waiting) when collapsing
> file THPs. Doing so provides the guarantee that no dirty folio will be
> observed while there are active THPs. To fully ensure this is safe, the
> invalidate_lock needs to be held while doing the writeout, so that
> do_dentry_open()'s page cache truncation excludes this write-and-wait.

Queued for 7.1, 6.18, and 6.12 (with Willy's Reviewed-by and David's
Acked-by from this thread), thanks.

-- 
Thanks,
Sasha
