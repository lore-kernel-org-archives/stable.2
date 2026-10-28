Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228056;
	b=FDog2pebCfX3SxPZbaWa4ZXveKzAaCV6dYmqpmrOfN9tvNqHV8ml2BtBxQDmtz2Ikkeg
	 It+fi59yxsxpKieRDWxxnPQj51Rfs3SQBxLVL2GXSLItJD4sSCYkOPKsNk/3P3G1+mQD/
	 fazg1xwkcfO5mcxSngJtTNjKifKsAPaltomh6jiAGzG0K5b+9jGwCl7eWQO3mnlRkrV0Q
	 BgsJovIH3uu3q5+Dq5pPoFBNlmix9WymnmUkOhcxYy7Z77+t84XDvO7TPzhCFz680t+Tl
	 OrlLxJgb5igO/4rkdd6O1893JVWd6QlJsX+U+FfM10uahWixExZiKfT4F2GcGEeK6Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
	b=t4kmGu3GpQv9fdZBF+k3P3bCTCKociCF0qEtKuHZUZ7FGBH45WMpPE2ZDaHsjeqWZrNQ
	 fVnKoFgQUsib2MxD0Zaw8hcMBlRVhTaTWrQwZ0eiJUG6vFkrPJ/u7d7jS/S/K3ZGT+ZYG
	 LI+JCuOpqedQ8n86i31l0MASUm9M41CQhvbm3y8bCM80Bd/Itwx3rM7HmGAtWPKW8Yr7P
	 1ToOUIw1l3RBapApNIZcsoDlU9duxy6eCbNqTJl725iP1KHDFAr0QSG+VbtlOvH2lfgqS
	 8FcdZm2ZFs5jigxvN6NRbPy6p4uEk3o8O+fTwdRSkvR6koFe94dgGODJNzX/+ukKaCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Jd09Eqyr;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EF606A332
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0EF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Jd09Eqyr
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so1855514a12.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793228053; x=1793832853; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=Jd09EqyrE5Ah8cRBCETOBxDbT9b0oGnFriZ7N/vtIFnR4atxKwoVXBEkw9jWiyscaL
         9cBv//XvhVx0QHadjkJLBobkr5XoWyssGxmav1gWZI3g+BwjlhfZWo65PjCsgnm9H3K3
         xu5Gt8LjlHXosZzQxl27itMRU6XM03eBrNEUzaUgmLacP/vWk9QUrBawj9QiMopYPRXA
         tFTTkouWxIpyyRzhMiRtstmfu3ZGpQ3UoEM6m+ucddIsmxmD56hyTjhxLKo4VCQBrV7A
         s99qsxF/HxZexb7mRhlnvehngAX2PDIIfWSoapPGufqyJfpOj/CE/u6FaQ8yHPJb3EEt
         tvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228053; x=1793832853;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=f6w9fS6J90d8eaJ3RVYk8ic9F47tTE31VPydj6ye+Ym+hxYFZXXTsYzYgqb2+neUUl
         Jt7NVnuloMxpQFJEzP4aUz+Ld3a6CUsE/uEzMZOgBYwOfTI3y+jKH8XVRdy7fVWfC5m8
         6iSkfnJIXnaNKtstM3bU3+G/9tHHzxKaHVHC7/NfK7Bm9kGYvazu6QlWik2m9XrMFR4T
         AJRVMyuUwFaDC1X/lRO9OHz2Cl0iRkAwzwNvdVIZ2RZNqM65t2O9y4re2wVtFO961sxg
         XUIV39DytJ29MUlPgo5kclYPXxlwOJ/aKx0Jty2adPZV2QFAg6PGJxvnUVDJvnL6be0Z
         yKKg==
X-Forwarded-Encrypted: i=1; AKwUvByHbW3x4MxAykF9+4n6iFIwm3vpqg/h+uRkPrHI/h78bm4Rdf/jfHSgSid33C92O4dzrsf0mYo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGK1G0LRYAsUpad+2e9bHro+FEs9KAJrE6+0ifBWkhX76+lKbm
	nTz/kiTEIUmqbQHvzkFaZFmH9wG8COJ1737Lm3e1COkE+O1AQ+cPahPb5Mq1CupFJtw=
X-Gm-Gg: AYBFou14zaEF/3uApMaeAI7Vmwi7x4XEgcJm6LIZagAhyyCOWeOTUFElv0yZuNLeXmF
	EZOYY98Zbz+53bh3+D7TDSM+oYIZcBWmuW98jNjb7ac0QTWgCrFMi19As7AkaWtyMKsLhATLCaV
	NUjs8p7UbSy+JAhSbLlXjyKKQfqxID3W5X9P5x3g2/TWf/lvDOG+mZOjbAdB4ZxYSWXdpl+nHFo
	dc6q1mff9ShdWn8vdDgEpAbe4kU/x/1b3IyV3Y9+vaCWs/waS7zC6PLQMTZ77u5o8bj1pzyw0hb
	5GJ5BAuEhOe+x7CiQjNlR8vusDtsYUgT/f2wZW4eFCirv21AJjMvTB0Dgbx7UEH2z8RPMyO8opq
	TXemoqe4YaACutV63DQbnDpUIlNKQJn/A7z+xOEtlRjvJWzI0nU7RONmWzt2T5bjX14bsJblYCn
	lXoJgEich055zB8btkiv5ozvIUsWFavbmJfIeIoFctwAgvTjw/LRlVSTfUS5ZmsuKg98xd615BW
	WDjaLhF8IZk9DnuNb3pWcALj73Q/UaeIQULStmA03Y8rEEMf47/2NOwaj1l3fvPoUkwB3gmOifC
	L46kSsTpgK/5xZSy7TklT86ElmSLw46SjX8SyTykoHc=
X-Received: by 2002:aa7:d0d3:0:b0:6b4:78c3:b8bf with SMTP id 4fb4d7f45d1cf-6b49cbfe65cmr2043596a12.26.1793228053385;
        Wed, 28 Oct 2026 15:54:13 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:49::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm1991741a12.37.2026.10.28.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:54:12 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 45/46] mm/memory-tiers: unregister empty tiers outside
 memory_tier_lock
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 15:54:10 -0700
Message-Id: <179322805093.453251.8441529644965692562.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:18 +0100, David Hildenbrand (Arm) wrote:
> When offlining a node's last memory empties its tier,
> clear_node_memory_tier() calls device_unregister() while holding
> memory_tier_lock. A concurrent sysfs read can hold a kernfs active
> reference and block in nodelist_show() on that mutex. device_unregister()
> then waits in kernfs_drain() for the read to finish and release its active
> reference, while the reader waits for the offlining task to release the
> mutex.
> 
> Return the node's former tier from clear_node_memory_tier(), making the
> helper more similar to set_node_memory_tier(), which also returns a
> memory_tier pointer. Let the caller unlink an empty tier under
> memory_tier_lock before rebuilding demotion targets, then unregister its
> device after dropping the lock.
> 
> Fixes: 9832fb87834e ("mm/demotion: expose memory tier details via sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
