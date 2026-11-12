Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447777;
	b=Q4xasZ7Hccxi844/t9mbvFuMS2ckdTDScneLQfbhwDWD4CXnuBamHPp5gfnrCidaOGic
	 l6hs6k7wmkFnkKUV3xYhUNGPk+Lolh2aIwNJcDloIiInEubUQOUwGUrjZWmxMxYgqcA+p
	 AZBN8u8NqVEWgopQlwd3znNf9/fIg7kFrZ9gKC7LU5wyrurDl2bqka9LhTmWxtMh6giaI
	 P5f2cLVdNNoJjeMxb5XSAFVtLDmoKS4EIXZnLjxra90Uzxqn2IO/lnqmfl2UnzY747Rlo
	 lbxiBtyvzn/UVNdU57rXVi4uaA/dSZ6bYPBwA/BkHFkYGNxQ3VPfOdiy4ywdrEswDag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447777;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2amIad7DCymXtxktdk/h5Rd2UGWk5E5RRoIzlxgbm1w=;
	b=qyvWkC6soXEe+OhhY19jsYcgW+pzj/mUrREa2iYMCh/D78k1d46EMSH+wq9V/OcIuvYL
	 HiY4xe2OL6HNEvfzT+GmGlEgkVIVA3OOzJHzZtipgvK6FfImpaFCM8bu7mmKoW0engkqJ
	 9GgwBg2spLKKNHD0RMtAh1/iv/cBMHXa1exN/rX7+GiPnTxId/d11zsYoJ99WBetaCjii
	 nMuXoJEHxMq/8fz/A+d7QG4Hbvjr14GKzB7DqRtM0Jh8xpWO2SpBEiLkth2QAG9GwqN7Y
	 +u/G39pP0f+q4238ncTXZj/PSvXcQCAX4EvAZ6LKqGvCsBcpiL3XDTTdKQtwiV69LXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ueqOyERD;
	arc=none smtp.remote-ip=91.218.175.54
Received: from mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2429606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2429606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ueqOyERD
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2amIad7DCymXtxktdk/h5Rd2UGWk5E5RRoIzlxgbm1w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794447773; v=1; x=1795052573;
 b=ueqOyERDup5z6Gcwjqq4RksiHf2hxsuXAgGZTIirFSsM8zPUGgZe+0Hsp+BD0oJhGNKmaUk4
 /HZ14RNCxZ2vJ8lmQWS3FlXo7J1kdC19Tia2jdrxj47fHAYkEYV9Bj4FWKs4aUeZDLFv0Jw+Osw
 bodN8nbLIFRmGsh+0s45/B0U=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4e91415cff7979f9;
	Thu, 12 Nov 2026 01:42:53 +0000
X-Mizu-Trace-ID: 4e91415cff7979f9
X-Migadu-Flow: FLOW_OUT
Message-ID: <d81fe81c-be1b-4766-8030-9cbbe83428b6@linux.dev>
Date: Thu, 12 Nov 2026 09:42:36 +0800
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
Subject: Re: [PATCH 6.18.y] mm/ksm: fix userfaultfd protection during merge
 and unmerge
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Samarth Narang <samarth.colleges@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Bobby Powers <bobbypowers@gmail.com>,
 Brian Geffon <bgeffon@google.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, Doug Gilbert <dgilbert@interlog.com>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Martin Cracauer <cracauer@cons.org>, Marty McFadden <mcfadden8@llnl.gov>,
 Maya Gokhale <gokhale2@llnl.gov>, Pavel Emelyanov <xemul@openvz.org>,
 Rik van Riel <riel@surriel.com>, Shaohua Li <shli@fb.com>,
 James Houghton <jthoughton@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, SJ Park <sj@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Mohammed EL Kadiri <med08elkadiri@gmail.com>
References: <20261111082809.32654-1-lance.yang@linux.dev>
 <2026-11-11-1-daily-reply-0026-04883abeb32ad63ca89c@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2026-11-11-1-daily-reply-0026-04883abeb32ad63ca89c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/11/12 05:54, Sasha Levin wrote:
>> [PATCH 6.18.y] mm/ksm: fix userfaultfd protection during merge and unmerge
> The 6.18, 6.12 and 6.6 patches are based on released stable and do not apply to
> the stable queue, which already carries 2efc6332f18b ("mm/ksm: keep soft-dirty
> when merging a page") in replace_page(). The fix itself looks sound. Could you
> rebase and send a v2 with the two uffd-wp lines placed after the soft-dirty
> block?

Sure, thanks!

> The 6.1.y series for 990d6c2194a9 ("mm/ksm: fix userfaultfd protection during
> merge and unmerge") applies fine, but it has to wait until 6.18, 6.12 and 6.6
> carry the fix, so please resend it together with the v2 of those.

Okay. Will rebase and resend all four as v2 :)

Cheers, Lance

