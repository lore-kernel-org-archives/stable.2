Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD443537E5;
	Mon,  7 Sep 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788804510; cv=none; b=AahCrKrpzy05NkR79u1jMLbwSgJ5x1NPJoNdXoTkMn5lyqypVqUzPClDZbCxEGucs4ynQZ6ARlOox7xyQWLi/txFJriWJZdzAj6IgTJ/AJK2LT83DZxaAtQxgx4Hf6HOBFQBqbUb8oHnekD1MS3P07qEaz+Y5Vbc5sCfRCEqoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788804510; c=relaxed/simple;
	bh=nsTn+f5p/oeOk9s4FDodU0ZT+xHIuz5uH+mNqdXYbuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwD4X18kldSWcWiDya71eReuCyNATlryGY/T6js25fJnyfFwdOe/qe+7RdztVcBJhad9s4IqQC1c6F2+I7j+V2nloKCz+RslyE4C9DkT6fmTeblWUgBkA3PwEesU9Lf4WX18cDP3Ncb082cWzvLuY9UtXneyH3wUPs0CLvU2vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox99Oq+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox99Oq+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEAE1F00A3A;
	Mon,  7 Sep 2026 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788804508;
	bh=MuZcYPh1omkK8HEZAXjbGNcKNlLfSUT4dmGoKmWIVI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ox99Oq+E1x0aCR9QfZaBIpMRK10/Kaz+mG8KeuckNkgLWjCTRzhtUq9JVB0EC7Kk4
	 GyF6+w9CgAafQfKNTcgK+OP8NtRg9l+qZXkBt2D6yc2VcjVIY2v2tPr3FvBO7hZ+u9
	 HOw9PmMgwLbMYu2z5RcvdsT/8Q/SeNDZA8eNY9EC3VrtEtjnrn+VC1Yd6iGZlxDZW0
	 dkcwA/ZsTTylD0Mw6FVLZYdzk5AdR37rXI8Ztz/474zp65yfHdeSBoT7iPhimRqcL+
	 KpFijJmccHuhawmLpX4haPNle7le9+KNYH8p/p3WO10Ba3uBmEmtMOHTHyJYRb4YcB
	 QBSh6NQgvMcvQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()
Date: Mon,  7 Sep 2026 11:08:20 -0700
Message-ID: <20260907180821.102875-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907170358.100168-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 10:03:56 -0700 SJ Park <sj@kernel.org> wrote:

[...]
> +static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
> +		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
> +{
> +	unsigned long psize = huge_page_size(hstate_vma(vma));
> +
> +	if (!pte_young(*entry))
> +		return false;
> +	*entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
> +	*entry = pte_mkold(*entry);
> +	set_huge_pte_at(mm, addr, pte, *entry, psize);
> +	return true;

Sashiko says [1] this might violate BBM.  But this is only for accessed bit
change.  So I don't think BBM is required here.  Also, we intentionally do not
flush TLB because this is just a best-effort monitoring.  Please correct me if
I'm wrong.

[1] https://lore.kernel.org/20260907171613.A09B11F00A3A@smtp.kernel.org


Thanks,
SJ

[...]
