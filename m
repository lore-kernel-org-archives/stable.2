Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17718FC80
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782444819; cv=none; b=jFC8pwlUIEq/zxRmaZcFx4iSYC/geQmeYMdtZ8S3+S6i/xWXTtE5Hc0PwBlTCSNq6UYUil7RfGjTE/FH1clpahGl3WYjy3Pq7H/U+TcEjfVJSCXvW6WeG8+skZ8XKQai87XWT9ESFxtXawd8eQEkSP+8UMTxA/z4LdEMLn/GLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782444819; c=relaxed/simple;
	bh=0HCGQZ57BsFjU/yjnNeadFJo2JebiPKo37EWE7E6eNU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YM+pSwqagrZb8w6V6y7l6vdxflSBnPYY/cTuCVSot58FAvH4XQu3gqkKSsj0rdX9cpuRe4pc6jX4MQXPtWKgDLAJbZ82GKRF+fgCxGL9GWrhplRF/YlJHIRgvfCr9JQFKUa8ErQl3X+R2BOJ6hU02NY/L98k53nqNHghPqNo3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpdVZb7d; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpdVZb7d"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782444815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HCGQZ57BsFjU/yjnNeadFJo2JebiPKo37EWE7E6eNU=;
	b=lpdVZb7dYZBVQfZG9ALV8QZZPn5pCWrHjojmjbeGjIU4iPSQOMA0ewkkkcghYLsUKx63Fm
	FoGY+IQM4XOitUE4lPfMPkCtzcm8hmMBnJ7uP/l4sNIDU4BIqK3VLTQRPgIQLuwoydkHzj
	J4haBNrsxLdlCOvXEsR5ZnsgyWgo3Nk=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 3/5] mm/migrate: use huge_ptep_get() in
 remove_migration_pte()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260625112955.3254283-4-dev.jain@arm.com>
Date: Fri, 26 Jun 2026 11:32:03 +0800
Cc: osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 david@kernel.org,
 liam@infradead.org,
 riel@surriel.com,
 vbabka@kernel.org,
 harry@kernel.org,
 jannh@google.com,
 lance.yang@linux.dev,
 kas@kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com,
 apopple@nvidia.com,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 gourry@gourry.net,
 ying.huang@linux.alibaba.com,
 mel@csn.ul.ie,
 nao.horiguchi@gmail.com,
 ak@linux.intel.com,
 j-nomura@ce.jp.nec.com,
 pfalcato@suse.de,
 dave.hansen@intel.com,
 tglx@kernel.org,
 jpoimboe@kernel.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E9EBE58-C2D0-44F4-8797-D8077E26AFEC@linux.dev>
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-4-dev.jain@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 25, 2026, at 19:29, Dev Jain <dev.jain@arm.com> wrote:
>=20
> remove_migration_pte() converts migration entries back to present PTEs
> after folio migration completes. For hugetlb folios,
> page_vma_mapped_walk() returns the pte pointer to the hugetlb folio in
> pvmw.pte, but the code reads it with ptep_get().
>=20
> On arches which provide their own huge_ptep_get() to dereference a =
huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(),
> pte_present() etc to misbehave.
>=20
> It is not clear whether this has a trivially visible effect to =
userspace.

We are dealing with migration entries here, so the issue mentioned =
shouldn't
be a problem with any of the architectures. Semantically speaking, we =
definitely
should fix this.

>=20
> Use huge_ptep_get() to dereference a huge pte pointer.
>=20
> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks

