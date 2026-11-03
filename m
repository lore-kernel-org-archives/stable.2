Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706401;
	b=Pq8DKi3T4ZQGtiONufIUX1NV8njFjqpDrd7+xMsaxmx2q+Bw3RetrKlRYPoI/d0yUQl0
	 HpzlAGn+6bWAsbJeIpy8s1IVKOG40cr5uS99k+f1IblzF2K9+pKmDY4HXrmcARc8p1ZZl
	 ISGjG46szqugng88mzcXqzmF5ZM8EyFlReT7Z7gydjWIMkuWWshfzGhInz6qE1L1ABR9H
	 gh/0RNUVRrFksQRzOHXaWvqyBPBxFCknM+WEic22RuGWm5We7TTDVSwkEql2s99tUwy5f
	 vUt5fifsbNETkIk/8hexZ+jTRIv+mmo6Hky/7ZXIM6zXvi/9uJw77IwJO8AQAzigoyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706401;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1h7SuxIdXP1BrmLiSW0TA0Y4x+A0dQHqIxOY0fZWzgw=;
	b=fZaTWVOn4o+9nYOfEBYxSm/Q9Wb9osYd1U5Ygqhx3URarR8615BQiUR4WeC1i7loq9db
	 jnQyJ0DkxqEG5RRCLikSvsjCoe5/yC8jqboVlS4QuUHL8KdHC02U6c/kEBh89sRDwq4Jx
	 urqhLkacU3sF8xsf09nvHtTdNeELQ4ZOL0W/eOihPKQOnYd+nXTzxWgDxu5W/E+M/IwOj
	 OGsSol6BYIHEEkqt7wgxYfAj9h81q3Dy1scbdvEg2YQ6DUt9OiDWAUFgh9IL5cC29Ck9m
	 POVq51mdmk1QQLPmAH1CSLalMsm2wNo8RoOn+qrqU523cRyMzqUKpYlcO47gMOJANZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.223
Received: from mta0.migadu.com (out-223.mta0.migadu.com [91.218.175.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77A606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF77A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1h7SuxIdXP1BrmLiSW0TA0Y4x+A0dQHqIxOY0fZWzgw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793706391; v=1; x=1794311191;
 b=M5WQx64W3OrKv3IrbfaaaUU8t9LBurF+lIi1NsZf+TH86Tb8kzcQtOfRinqCLkp6vbJeJkjn
 Wdwp+SEY7bV+SCApfixGc5g2PSWIhjsr5o8DnWz2b+eULeX3U8KrowNWRCDh9p9CW2PdjVmXutk
 fgWn2GKcQL5AnmV3qr19TWzU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c5c651460189e35;
	Tue, 03 Nov 2026 11:46:31 +0000
X-Mizu-Trace-ID: 4c5c651460189e35
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
	mason@kernel.org,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 41/47] mm/ksm: check large swap-cache folios before mapping them
Date: Tue,  3 Nov 2026 19:46:26 +0800
Message-ID: <20261103114626.15764-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-41-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-41-d6437171ecc3@kernel.org>
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


On Sat, Oct 31, 2026 at 10:40:10AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>KSM folios are always small, but their shared swap slots can be read
>back as part of a large folio in the swap cache. ksm_might_need_to_copy()
>skips large folios, so another process can map a page with an incompatible
>anon_vma or page index. Reverse mapping then cannot find the new
>mapping, preventing migration or reclaim.
>
>Apply the same compatibility checks to large folios as to small ones.
>Pass the page corresponding to the swap entry and copy only that page
>when necessary. In do_swap_page()'s copy path, decrement only that slot's
>swap count, because the source swap-cache folio can now be large.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM1

Reviewed-by: Lance Yang <lance.yang@linux.dev>
