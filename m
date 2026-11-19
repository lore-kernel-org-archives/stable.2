Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047201;
	b=pAYJ8FzQX+OLKkTf3CQCsTxsXukUH2AxGh/xfzmb0rZa+4n3M8u4hvBRkku7bCWTxYkr
	 rN7QuZtnX5/RxRUveThCJCGNXvg/BehguR1/u0sJ94hwPPDzgfskyfkOmpo4CPdVx31rP
	 JYxtHu6vvAErdWAOskv0TxrOEdvMjj/X+zkFza6YxvdJTzNLjNLRDctlKaLZEtdfxyhFQ
	 qFYizLqe7jLOprqI6PWrr0QGJoWh31xFEVRgvRSFngdNkYl3QwENwNRcIsB4kGsuuvV9U
	 Igmh6T9/ZW2maU6o8RFq9jpdaetRZwzpKbKPc5T/qSP1NfpjF0FDLzmcW3uTjlBvYsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Z+4T7HksHFh0HyOVyESymA8Z3DhRY0Y5VmPHJCOWPKw=;
	b=kQVQTGvBO2yOJFgib5vxHeKnpuE6WisEObBoNlGjscsAtL/SSYj8AJY4F05qKkocqp2B
	 hRxQDgHEidST02h0QMgpFHJ/480FZkp0RBrV+0+kZ8452lrYRkb0eHOSRFvq7eSGIeBAk
	 LDsRHpbmhuN7F1v3EUjSp/7U+17qIKl0NofXKj3vNnRSJa8qXB8Cdcn/lUNiswZTL6+QY
	 Osc99znKA1lBESHxV9Yn7ZKeaxoYCtcdPX9k2Imi9s3ZdhfRRxIM5hgJi1tF+KvlGIG7i
	 HeTuYDol59PNFxZ9N89XlWIqcXxEmczHY9jKHCmOXsXanfGB/D4JQU4ViftK+jHNUdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=lWVk3evo;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4460A2600
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA4460A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=lWVk3evo
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677d35fd1d2so1554342d50.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1795047200; x=1795652000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z+4T7HksHFh0HyOVyESymA8Z3DhRY0Y5VmPHJCOWPKw=;
        b=lWVk3evoc6XTkw2CnC4EGTAjOmPzamp1BoH0fhOMMjRFjnFLY6dIsMgCV0rv3fkY+F
         M9yCs+mo7CKMDz3fcCwbyWJHoZmowmtYXno7TQkZm5mpNgZDHo0/WNEJ950gc0c/YPqS
         hPuVhxncNVNCwigIKaGRJreMz3L/s8na7A6R1ZVzuYN4GBeF3yB6m4zz0cB4mAbzQsJM
         3d1Ex8eu5M14sGf1vxa5iPGC7lFgk5xvJJPJGBQbhHz33YdlsJfx+BEpqPe567WouOPj
         95I4jVPKgvWXqLfPUuCdRYR00NP38TlzQRiJiHckdLTH8EVIKk2/F4xme9sPlnCM0vLR
         lYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047200; x=1795652000;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z+4T7HksHFh0HyOVyESymA8Z3DhRY0Y5VmPHJCOWPKw=;
        b=U9ckPve4O7GaOSerNH6SpTG7j85nGUaRgQxQhHlj+EgDk271Cu+Gm3hYJiHwE0dZ7I
         gY5EbE/q6fU8NUf90PJD4a6hfLZwjm3k/gLZYDT5pqMtEc79Is24NrmkbMFU6Vk0AP1B
         uNWCE+CzPKqWEczXaaUaqlRgL6jA54X3jLwt3VZDKRaMeU0XmzPzRTCsLWAeJhFgjOt+
         yfllWJOBIObwpr9nPiOKq7TyWDKaQiPz7TzUdFDiA/nDKLebotsjxQhUbKev8U3Monaw
         32XvRcnuFn2Ji+1BxREZQadef92J8qhthBwD9Lt85AYAuc0lC4yLxEvWj4ZnFs91vsXf
         O+Yg==
X-Forwarded-Encrypted: i=1; AL+hErG+L3cYUlupMkKcNQh/B32epZzPLaHOSef7I/rJ7TQke1ftUfZb3vBW+xJt7vf1HfA6XReHTA0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K+3cq6923BQKbAmtksC7A68D8nGg2e0izdehmuNqpVkhFK/Q5
	CxMTwLojrVxCo7YGKTpxdsXGASUVMopVQw2a4YEP5/Uq9sjOP2RSLrwedGLF2u069d8=
X-Gm-Gg: AZFdTZdcF0RM6k2wde2yu406SJlueT3vyQR9Y4VKaoMmMPv0GVRI6zf4weRQEuuVrgZ
	ZpreQ16SeQ+1m3FYsxGCuldaFSv/+qLVmeVr09X/5Kh6qVKSvJ0fzHWoNkSaA4awpB1G1TRln2M
	dgGWe/ncPso22kCnrWRYwV8522r2MqQqPyFn8yMwjUcC0uWsD8N1mY1RJYUdTwwzQU1BnqhrQod
	khAYAI6/jlsuxweSSglAcQdqlp4I/+xbEFjzxT87pSE/9WxGzVkUTZxenGhcIuq4R2LZ/ZCi8e5
	P3IwqMJycbR3KjiTyl4RC807JayBdbpYSUX2N4fptstS/g6tFjXptbVUkaDIH03n1a4hO4N+YJ9
	o3RF6DnK9IPbViFS8ZAFonDU4WG8NAAbpht0ZuUf86/cXMHmUxGlJN9cQiQTENs4KgBNq5nHAJm
	QcCILbWUTR5Rmfm8x50eYdCa+GPDxNbmdDa27sTLgQ9PrOox7uD8wBYOtmBCuaS3VU/QNgB3ncB
	hocS6OL9axRzh2w3jw5L+OwEnL1UVa0P755poYMK6NwccGN5GtOFhZYMrpZhZ9rgXoZ3CLxgMyK
	c98vw6czPtmvKPHvalOEVEyVY/Ja
X-Received: by 2002:a53:d005:0:b0:67c:6e1b:84d2 with SMTP id 956f58d0204a3-67dd460a10amr1474859d50.101.1795047199791;
        Wed, 18 Nov 2026 16:13:19 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd5843177sm2483921d50.5.2026.11.18.16.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:13:19 -0800 (PST)
Date: Wed, 18 Nov 2026 19:13:18 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Cenk =?utf-8?Q?Y=C4=B1lmaz?= <cenk@deepfinresearch.com>,
	Zhang Peng <zippermonkey@icloud.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>, Mel Gorman <mgorman@suse.de>,
	Sasha Levin <sasha.levin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/vmscan: flush deferred writable TLB entries
 before unlocking the folio
Message-ID: <av4_Hkq1kNQUyIeI@cmpxchg.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
 <20261118-file_folio_flush-v1-2-e9e739ed14e0@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-file_folio_flush-v1-2-e9e739ed14e0@kernel.org>

On Wed, Nov 18, 2026 at 10:20:37AM +0100, David Hildenbrand (Arm) wrote:
> try_to_unmap() with TTU_BATCH_FLUSH transfers the PTE dirty bit to the
> folio and defers the TLB flush.
> 
> Reclaim must flush the TLB before unlocking the folio, otherwise stale
> writable TLB entries might be left behind temporarily: writeback started
> by other mechanisms (e.g., fsync) will not find any mappings in
> folio_mkclean(), so it will neither write-protect nor flush anything.
> 
> A write through a stale TLB entry after the folio was cleaned gets lost
> once the folio is reclaimed.
> 
> However, reclaim currently does not flush the TLB if the now-dirty folio
> does not get written back (e.g., gets activated or kept instead). Fix it
> by flushing right after try_to_unmap() if the folio is dirty, which makes
> the existing flush before pageout() unnecessary.
> 
> For dirty page-cache folios that reclaim activates, we will now flush the
> TLB immediately after unmapping them instead of batching the flush, which
> is the right thing to do. Performance-wise, it shouldn't really matter
> much, because folios with dirty PTEs are usually young and reclaim won't
> even try to unmap them.
> 
> Fixes: d950c9477d51 ("mm: defer flush of writable TLB entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
