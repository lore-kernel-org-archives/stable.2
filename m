Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA6411670;
	Fri, 10 Jul 2026 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687326; cv=none; b=dKhMLn3BLL8+aPCT47KpI17Ac/Z3mZjijM3DDXAoJsFghRp/lY/rMgiL2HgvMEKaMkmqT3FIyaQCri2vzAB5BgjHIv8zlG4gUdba9PvTjWK4YW6SEvK8x+Ws64kEUuUPNEKF8ekQ6pZOAh/wJZP8C/XcB58GwHm8BVuE7bQeKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687326; c=relaxed/simple;
	bh=S2IeHExeWGCelQ6yRVBVZdCGRMLLewZl+jKUKSaK+X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNtTagNUkhdsy3ELne8emllZKJ43x6MWmlsc4f0mEkarwBVgXt4wXMJqWNnebt47zoHXZraUG9EEXcBOib/0nUC41SJnZFZLtohmViPaaTAh5xuvlV6wGK4ydWGwxdBix2Fukd+YUEtyNPsGYu+3kUXZMbmiuGGbvsnUMWSrXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTPZDjsZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTPZDjsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24331F00A3A;
	Fri, 10 Jul 2026 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783687324;
	bh=Ul3sRLhwjrxQoJQnvumZ0PUhmDQ8XYv0aOjCqcjQNpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iTPZDjsZPGmzN5+vwYYtBkEavSQKPLJaVniKtsesqVlHMN/bvuWdgrvmGVDmu/eiH
	 0mFYun3HE1zMV87WcauZgUZ/3c/TWL/epVu6UgyTKU6mIKmXn7kfrvo30JHrExzZ93
	 X0yO+L4gkL0ZeJ8rrZMydc/xZP7/aqXzrgI1pMOUdKVJ/q7uKoXfnCOKh1wwLD1krj
	 czDViz5NaH24tW3yoRoR5Pqt+4HEm3xe8wt1/sHbty9xwk2Utg+lnbWql4zc8/5uzf
	 P+K3LuDd6voF3tR0LCtb6Ov5bHRppYcfIbXZUIAiSUDzyZN8xMRW6a1G2fNe2yGFp4
	 oFryCi5+eL3wg==
Message-ID: <82607f71-8fdd-4a97-8350-810bb6c65f75@kernel.org>
Date: Fri, 10 Jul 2026 14:41:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm/huge_memory: skip device-private PMDs in
 madvise_free_huge_pmd
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 balbirs@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 byungchul@sk.com, dev.jain@arm.com, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, lance.yang@linux.dev, liam@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, npache@redhat.com, rakie.kim@sk.com,
 ryan.roberts@arm.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, shakeel.butt@linux.dev, hannes@cmpxchg.org
Cc: stable@vger.kernel.org
References: <20260710105557.1987433-1-usama.arif@linux.dev>
 <20260710105557.1987433-4-usama.arif@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260710105557.1987433-4-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 12:55, Usama Arif wrote:
> madvise_free_pte_range() checks pmd_trans_huge(*pmd) unlocked, then
> madvise_free_huge_pmd() takes pmd_trans_huge_lock(). pmd_is_huge()
> returns true for a device-private PMD, so orig_pmd can be device-private
> and enter the !pmd_present() branch.
> 
> Skip device-private PMDs in that non-present branch and continue to out
> before calling pmd_folio(). Downgrade the check to VM_WARN_ON_ONCE() so
> an unexpected PMD softleaf logs a warning rather than panicking. Drop
> the thp_migration_supported() guard: it expands to
> IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_SOFTLEAF), and both
> pmd_is_migration_entry() and pmd_is_device_private_entry() already
> return false when that config is not selected, so the guard suppresses
> only the case where the warning would already be silent.
> 
> Potential trigger: an HMM-based GPU driver races with madvise(MADV_FREE):
> migrate_vma_pages() flips the PMD to a device-private entry between the
> caller's pmd_trans_huge() check and the callee's pmd_trans_huge_lock().
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Balbir Singh <balbirs@nvidia.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
