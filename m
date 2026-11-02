Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598168;
	b=LpJvTlSnVdHRAO1OprMVK15RfH8kxSS9e8z2n9E6okDpdbW0LCtULTbvsRDkJgXFS+AR
	 pOkpLNqCWC7lUvFvDN4Jyj07+qD+ILtGaH7mgPdu8PDf1j9uFUIXG1yNdDRdc9H0ZugoU
	 owpWD/9GIVqPgCJUHPTnsIzfJZX78RPG+7552BQ8SIJBPHkXevYyL/SQe2IU3aqkJxwLw
	 XHnhPmTW8P6JPQ9cjQ7bPWYcSaRW/fbN4JJyDiDQfdTD05JTtcl5R3/MTlZlBzCrBVbPG
	 PIkh0vDbq1MQKgso7acahcZi6bWEWrCKFcmBj0OVhjst+VRgB5NiHajnI8njsaVVlvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598168;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MiW8Mroe3U2+fZ+1bplzdhcNfTtvPuhlvwZ0rPfG9Ps=;
	b=LuwIqlDKLtvu4Ge9l8tmNc1l2IeWhHp6x+8HM93ZLsNzH7lPTfbwExUrYbWEF2Zp9sWR
	 tfII2HZmjknxotFgq8kXVwUXCYYGbZm5NUJmXaahVPE8k+FRrKM1Fyk4iB4yZ99QfAk3L
	 S32nmCOm71hPRvOvcajURbV2vTGAv5GUAQo93zGcxAZjRWY4AYX5lpdXr2+nX9XtZ7qkn
	 h4VQ9qlF0mUMHZzhmxKNBUPCr1D4DElvySMH9nkwrZUv6TopkWHZEtOZKKIZgVE3dBQLy
	 XMcfe4QeZAIqKebazSU1xzEasxj8mH4f8fNtk12CNXSZiNpEp/qKdO3qwsEQNAYmf0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.71
Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E23606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 05:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E23606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MiW8Mroe3U2+fZ+1bplzdhcNfTtvPuhlvwZ0rPfG9Ps=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793598159; v=1; x=1794202959;
 b=UuwuZrpRkQYutb58GVikL5ByJkdXkY5hrZ320Ad6t9zbKbpIWUeWtzUj6e7jA2gUDGMoLrrH
 gUeLCTBMp061JCHx6Qhx3sjIJSwh8MQzoBlRonU4eD5oEI2+kpHt3ULEzO6l5PK/syFv0vJ1f4r
 DZ12u63g6acTOpq0688ukOGg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9704e208af575192;
	Mon, 02 Nov 2026 05:42:37 +0000
X-Mizu-Trace-ID: 9704e208af575192
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 16/47] mm/khugepaged: fix PMD table lock leak in try_collapse_pte_mapped_thp()
Date: Mon,  2 Nov 2026 13:42:32 +0800
Message-ID: <20261102054232.36829-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-16-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-16-d6437171ecc3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:39:45AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>For a private mapping with userfaultfd, try_collapse_pte_mapped_thp()
>takes the PMD table lock before it maps the page table for the second time.
>If that (pte_offset_map_rw_nolock) fails, because the page table vanished
>in the meantime due to concurrent page table reclaim, it leaves through
>the abort label, where the PMD table lock is unlocked if it differs from
>PTE table lock.
>
>In case the PMD table lock and the PTE table lock match, which is the
>case without CONFIG_SPLIT_PTE_PTLOCKS after pte_offset_map_rw_nolock()
>failed, we miss to unlock the PMD table.
>
>To fix it, forget the PTE table lock when we unmap+unlock the PTE table.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>[ david: move the ptl = NULL handling; rewrite description, drop wrong comments ]
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
