Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A3538D75;
	Wed,  9 Sep 2026 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952899; cv=none; b=eOSx2cFSIvmCt0GuVVYLi2FhlVABjHkAoKgUaaabgcwH028ZmkEAfAbrHbXMHhW2jQ3eJqsiH51NJ/VrcYHKA14xumlRLrSxWwDMG/QXJED7A4zdg3k//MHBmU6oQ602n1JBj6hmGyQBGTn4Sk3r2ZPiEHhsWcn2NGb0LLCaC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952899; c=relaxed/simple;
	bh=LccrGawWBuzW+2QVK7YGzRTxrUOE/8qKgI05s8orjOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apIi5HfyxOAU1abTmfPJ1R64ZBvauKYbghrlzelgIAdN+87/in5Py6tNUJNDz0E3FPIL4SXbeaGK1qp3CWkwKkk2/H9bLMnUXfgCGMXvf6DXzrgfNDxw8IPeIXyEdTuIgHib8qsXGKdLxZH6Okr9N0G99HG9UPUr89UIrSWlQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LUr8XyeN; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LUr8XyeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OI
	Ayl4+9WuxFicDuaMQcuZ5CFN1J9J/6GS7zLNL6wDw=; b=LUr8XyeNZQnXdaBAn4
	py8csMlVVOPLVrPhKvVaywjrnbeERNTOd/cdN1SzyWeKf23M84GWv3CUimsuxb36
	cTJefsk47jpFDWX6gnpir8AzuoKMwBY+HV4nieEuhqbJjSHHZ3tFl1EPZLMPI1Q3
	FvY5ehT/PjxeNdcetLDZqCkEc=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnESERQaFqJi3hQg--.17578S2;
	Wed, 09 Sep 2026 19:20:50 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Zhi Wang <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gourry <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alex Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate_device: avoid out-of-bounds writes for compound folios
Date: Wed,  9 Sep 2026 20:20:49 +0900
Message-ID: <20260909112049.3202956-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5ae7a11c-1db4-44cd-bf67-a98cfd5ca08b@kernel.org>
References: <20260817120758.669807-3-sh_def@163.com> <4ead5df7-f000-4087-83e4-13aae036e0b7@kernel.org> <apESOAPVzggWmbcJ@gsse-cloud1.jf.intel.com> <5ae7a11c-1db4-44cd-bf67-a98cfd5ca08b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnESERQaFqJi3hQg--.17578S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWUGF1kWryUCrWDKF18AFb_yoW8Gw4Dpa
	4SgrZIyFsxWFWYkFnF9F48Xw1rWrsxJa4Yq3Z5Gr90ka1rJryFya40g3yDur17W3yIvrW8
	X3y2q34UCF15Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5KsbUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hJXtmqhQRJoxwAA3u

On Mon, Sep 07, 2026 at 02:23:33PM +0200, David Hildenbrand (Arm) wrote:
> That's what I was thinking: because how should we partially migrate folios?
> Doesn't make sense :)
>
> If this cannot be triggered today, neither Fixes: nor CC: stable is appropriate.
>
> Agreed that we should just warn.

Hi David, Matthew,

Sorry, I missed this earlier.

This fix has already landed in mainline, but I agree that the API semantics
should be clarified. Partially migrating a compound folio does not make
sense. If the intended contract is that callers must not provide a range
that cuts through a compound folio, then treating such input as caller
misuse with an explicit WARN/error path sounds reasonable.

The reason I added the Fixes tag and Cc'd stable was that I observed an
actual KASAN out-of-bounds write with the HMM migrate_anon_huge_zero
selftest. The path was:

  dmirror_fops_release()
    -> dmirror_device_evict_chunk()
      -> migrate_device_range()

My intent was to prevent migrate_device_range() from writing past the
caller-provided src_pfns array when such an input is observed. That said,
silently stopping the collection is not necessarily the best API semantics
if this should be treated as caller misuse.

I will rerun the reproducer on current mainline and report back with the
result. If the preferred direction is to make this an explicit WARN/error
path instead, I can send a follow-up patch on top of mainline.

Thanks,
Hui

