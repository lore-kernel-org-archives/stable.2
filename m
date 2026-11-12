Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469221;
	b=IpD9kzwZvwkKApuPVXZv4lv3zOIyRnSuJWNweCF3BsK39QTo+wky5Knia0UC1E8AlATj
	 hiFwJdDqzufb3W64DqMOLy0Y2G+ao0DHcKjmro3BKrWfKs8poxJoWcBjSMr4plmErYOYM
	 jBjesG3kA3N1DE7mBgPpR/U3rLr+dS+jZP2R8wcmsH03zUnGT8jhhyy7ToP4CujzPkUfr
	 tXRKnW3+LcvLGpwRXN5PjVxS2ul+Voe0kVzFZvdKLc9qM+yerAkh+n0kgLR1IJK+NMHl/
	 8Ih4XUKqfbTI+EVKFM2FjJGSjHiUsn6SYrbdpua+yixr9oOZBziOnmdPcfSTVask3bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469221;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=K4R2hK0snJM7f5RU+CVLzgyyCzxkNvFTXNS07H9UUHI=;
	b=3h210U33qAgXn3yROJ8TMtxJ07JkHYSSQu4/BwGi3SeRTlwDDx5ejvzPROVMTqpQNmOS
	 KV4atDCX6M0R6g4Kb4Dny3KD6Ps0YVqogGE9ok3AEX0LJln3m2/EqgocLiv5nOgx4u2Oa
	 9K2YuVHcm+1LjNWiIIZwJIf0t2kXZQN/pHRSCXgPYCvzRTO15dqZBQM+z9qckTefmJGk3
	 bxxG82znpRenynhuzmuvqwr8vddJDiXYEl4jPllXipzN1swUNchkdjMAIaXP0p7Sktjzb
	 MCe7Of7D7QE20oxJkT+A9GPjmB4y8DazIyLnt4j48IZ3ZF9c90QCeCa3JhejI3d397w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NnFb3ZDC;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A532606A31C;
	Thu, 12 Nov 2026 07:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A532606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NnFb3ZDC
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794469215; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K4R2hK0snJM7f5RU+CVLzgyyCzxkNvFTXNS07H9UUHI=;
	b=NnFb3ZDChKFrrGDk7uliamI91PduZwoYT1lbfS6P6c2M1Amkobiqg1Li5FbHxIBY+jK2ar4ANQu+zPUUqKj+e/NNduqXMID1gWb+/S44dBfq7YF2X7OEr12xu3Uu1ee64LcRLZo094Y7mUYZQEZ/XMgnQDdi3f+SuvxFR5mmBzI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0XEbHbqg_1794469212;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbHbqg_1794469212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 15:40:13 +0800
Message-ID: <c92a3132-da7d-46f7-bd06-6beffa3d2e34@linux.alibaba.com>
Date: Thu, 12 Nov 2026 15:40:11 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fs/proc/task_mmu: don't read young/dirty from a
 non-present PMD in smaps
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev
Cc: stable@vger.kernel.org
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-3-usama.arif@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261111113904.650722-3-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/26 7:38 PM, Usama Arif wrote:
> smaps_pmd_entry() passes pmd_young(*pmd) and pmd_dirty(*pmd) to
> smaps_account() for every PMD, including migration and device-private
> entries, where those bits hold part of the swap offset rather than
> accessed/dirty state. smaps_pte_entry() only reads them when the entry
> is present.
> 
> On x86_64 the offset is stored inverted across bits 9-58, which overlap
> _PAGE_SAVED_DIRTY, so pmd_dirty() returns garbage: a clean 2MB
> device-private mapping is accounted as 2048 kB dirty, and lazyfree
> accounting is suppressed. pgtable_64.h also warns that the hardware can
> set the accessed and dirty bits on non-present entries by mistake.
> 
> Only read the bits when the PMD is present.
> 
> Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
