Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313455;
	b=f7hWQEZVJRsaKlaox2ylOdcXUCKkS8vVyHFSUEtDipX+zKshYKpKDFvK1lqo3Y4hRgCu
	 Kf01zIvx/HbklEDAxDRxlkenoYjUABIpx9H0sGPWEpKyjhdiktpRBmOcHPgbKItMHlW/G
	 mXH6OshxiYV+/5SGCPiV4Qhjz67GIP7jD7qF6T+MwrX8Pog7bCl3V4/qcWIPB8xlUzZ+T
	 wbmGZztAXvjxpufcZP57ZJsDPufewaqb9Azp42dXhiY93FcMEKs2Wbi+mY3+Pn9IjQMpZ
	 zyntQuizpUsN2awOBmJcXEYfK4yyZpOTUaehtyBe/sDJC/I50ncsCmUgtdRCtEh70Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
	b=t19k+d78OjtcrmE+gfnv07qvQBAsAQFw2KRLEETpoWtDzAIqHTZtTWLHLzna91hFBlTx
	 o09/1jwvF6d9hemyXKHkWjg3MO8RdoNjsWVxu39x/3vzPC16U2be1QIV/k9KHBjuVf/qO
	 R645T3rRRB9PByRKAu7WOsaKLYKUDw1oxunPhiiV6ZLND0QXvjMIgOUkZWucSMRcoD3rg
	 E2iAO3pUgf+27+OfmPuJ1gUCMfr/gL8nrCdNEfTT71b5tguVmekKROcG0aOh79bQ/OX8m
	 YJBuN8hRr1TpQQqQoQeKMWLzGuisxnykvU6Cg+eLT6CLK4rTIuXjs0rf1QFA19GiyMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Dj8dQusc;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EC606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 343EC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Dj8dQusc
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b9e758c50so1457796d6.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313453; x=1793918253; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=Dj8dQuscI3pp1qYG8b6KcXsqNxRwgQE+IOWiM0vtUQjEIGh8IwfaD3RVp2Sq+NkZSs
         qHMoSLCbstd/15wF5Qxa2sDK2cDninOwTqsTFByb6LIZeWLpAf55M+HCw+VO3z1ZiSFz
         Z6Y4/NbXOjcmI5YX9a9L3/cxo+EMOJApGFo2tjQ4Jll0Em88E0c83dh9v9h6SXqNx/On
         2wHea5ofylJY3o3NA05JXNgsRQace0begultrDe7a7ROFS6WKgW3x6gh7nqOxJ4i7bJv
         /LExpfmEtFE9vVmiUbQF1EWeWQYpAQErRDpp4Wwd5p72d7ZyNPjiJeWH54OxSiUGzSXi
         GcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313453; x=1793918253;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=MtEpuj0O5fWsAF4KyaVIVii497d2gVZmt+2nxHhOLgf/sEP+9vmj3by5uWAPEJoblm
         Omv1sdg5r6/GSvEQ1hEPLviNwAnQ4pxMIvji6ZQB7hukkx+zKeCBF0lUelC+guXEhC57
         ZXwCm4hdjogM9cxxCaHptY11DYnjKgF6AINQjp3TxOWVFb47qcAvlf4urH7apaE6CWiz
         fChNmDdzgd5dEU8gCLh2QK2FS+I5y2YT2r7oxfaS2Foq3cbxtWwI+oManHGeTuGBSGl0
         eTq0/bLwMgMZvG7pcL8okMjwmy2Z7A/pILemOsnRp3H32uCA3mgH6rwtOfqPovA7NKh0
         R3NA==
X-Forwarded-Encrypted: i=1; AKwUvBwfcqFJFDd7flht+6Y2Y1C7rGJ3MEaInS+IXZtzHMLaIvU+dIqWp0QtdunUlxD1jvqIAtqah/0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTiZqS0l+gufS1DEWRnWCK9O+fnov0+36hhQU8yIYTjE2xsgpC
	TN2PeVvk80sxr9yJcSGzi+xAkY6tVya0s//aMf5uQEiRhCiaK1oJuTzVhVc+gq3ZM3A=
X-Gm-Gg: AYBFou3VrQrilVMKULauCr0HgQm8aeUFwpzAzOjh1RdGr9DPPY35ZpAiG2DqWaDSCtK
	Iv8mV6hK6TqBzQSIP7N1KKBRiFAl+9k49uLg9PAR7Ma2gCsZq1SULUTWprgZ4PPcjWKJghwXhk+
	NpNQvIrpHzTzRsGt4jIyTA/o0ThvX3aAQEs8wl5+4v1qVAyhnLLfsVKJwfZ8evleoN5bor1P9fy
	/tyr/4TFO2OO8yUOhRwzpfoHwz6c6K633b6baqDhBAuH4DICmLSYhqhUKDIlhqKeTLeqSJRWcGh
	Kx0o/jrz/Ovkydmw41f3yC2qcGuMsi4+fwz16j2JA4fTuEDjAOQp9NHMahBbbCbLsSLl9oJJIxk
	cS9XG9am6czf5w7/++HAPtaSwqyk3q8QikvcNncYmarQOWTV4bJk89/UUoUsjo9g1TfOenUWPFV
	55xTb+3TwPl6TT7EMCCcXwY7yiHOqqN45+qwr2DQPbRji+knnkDbdrvOhek5OcY5FQ4apnTfepr
	hvmpNTUKCUBc9fd29GpJ5HQE2VNRwLnqebu1F3BznwUXKWc4VZ2aGTZBP53YI3EmeuonPb5/E5W
	2vgLg1CM4TY4HicpgUuLy5Vh9RzZCNhamvyK7oF6GIdIO70g0N2QyYR1i1BQmEZMPlKpPjtt5Jn
	MabBdoWkKaB0m+k8tL7hSbA==
X-Received: by 2002:a05:6214:401e:b0:917:c073:1b98 with SMTP id 6a1803df08f44-91c90686fc8mr65881526d6.15.1793313453118;
        Thu, 29 Oct 2026 15:37:33 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca6855ea1sm646896d6.8.2026.10.29.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:37:32 -0700 (PDT)
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
Subject: Re: [PATCH v2 13/47] mm/huge_memory: fix truncate racing with PMD
 zapping
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:37:31 -0400
Message-Id: <179331345102.2127828.8211829708894165734.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
> If this was the last mapping, truncation can skip unmapping the folio
> and proceed without waiting for the PMD lock, racing with dirtying.
> 
> ifs_set_range_dirty() can oops if MADV_DONTNEED races with
> ftruncate() on XFS, when we get the folio set dirty after it was found
> to not be mapped anymore.
> 
> Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
> matching the PTE zap path. This keeps the folio mapped while updating
> its state, so truncation must wait for the page table lock.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

didn't have time to run tests, but this looks trivially correct.

Might be some backport ordering issues between this and commit 14.
Hard to say, didn't look into the history too deeply.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

