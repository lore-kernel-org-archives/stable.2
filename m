Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284738;
	b=0M2NKwUJg18mVQxT7mDRqARgyep3lNykcYn5gLgiPfs3N8QJcI8+xERd+1glTS8cdN54
	 JEtC3CGH5Jtj4+kTRkCVGB7Vf+loS0u+56XrdItEYpl4CMDpvGBPqRGwcDqAcFQmZhQxS
	 W47eLqclWi/VnE1TK3laIF/HmhesQQwONtOzj+AYLcvHsLgMpmcCHLVA0FwF8sLT//im8
	 boHm0HlY5w6soEKa2xyj1H5WB78NpRRLXSbSPAvWxviPv7tSlMpqZEBJcf/vhS3A/UaRa
	 dLElXAKOGI8SgbN4qxelCpNYla0Fj5rr6RT8Ern/2dLWaW+q6DX29hoMBAWUx1STAaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284738;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2c21uwKaYBeCH/6VWYVmdV37CjIv9I8O7v1n1RARYlc=;
	b=mGrX+xWRESftv+nnvq+hlNSA+NTLtN1lig0VTdG3Oma9jv6V3fv6iXe2ADX+0fsha8R/
	 3L8tpHwBzmgZS1tPIF4jdPiwytdh4y1rHMWRX2PsWT2hJA3Pyk+OUY4bKZ8VVlq8d4MIc
	 oQdoqB7QP1XnMs3Io5SkAFDaSJM1Mveb1nxLxBZMPLzH8bA20lHkXeB/Cr1VHWlPtgPqE
	 0J2O4CgahnbyExtGiSZEsgeTpGIqLzZpqvFCEtp0wHvbVMjV+bPoUFkaux3WDqdXnVt8y
	 XRV3MHt+9B5HjH40uy94hVu9H/g4/dHDZhQfD8066nsUBtBFWHveaGY4ZW7ugeqF0Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EI2ZiKEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCE606A31D;
	Thu, 29 Oct 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EI2ZiKEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EAD1F031E0;
	Thu, 29 Oct 2026 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284738;
	bh=2c21uwKaYBeCH/6VWYVmdV37CjIv9I8O7v1n1RARYlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EI2ZiKEnLp6eETngr78yn/yn2ccHar6UoSuvVsgfl8gUMFZLxoP2OYwsviFwtWtfJ
	 f63dwr4M7uyBi2iXINtmQPDiLCkPEjEM8cpMh1oUcb4Eg+2IFmq2QdG6JpSYsQy1qC
	 Bz9kbhbrBuSgqhvkVoIrZmLq02Gyapg14rJWwGVYd0tD3ar3Nss1lU1+qUT2HuLK7U
	 NfGzSmr1tD+EJfPXqu7Vlhxu+fjATMtcewwn9MfpLB3K9jKVYBtd1gdngvo1mZaxqc
	 MFkO7wrzJomPlfA4Kz4CPlW3hHVnzqjRml506lgwoUbiukeQxIeGeQpc/IC8Yqg+zw
	 bmd+p9qzBvx/Q==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 90D74198003A;
	Thu, 29 Oct 2026 10:38:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 10:38:52 -0400
X-ME-Sender: <xms:clrjapxZaMyQ7QlI7P-cISaKlgZNiDosPN0zr5eu4NfHb5CkkeXzEw>
    <xme:clrjajgxyRguXzgm6W7vSewt-9T60sOAe1sGAp3EddPj_Eojx8xhLnEd55RbNW8PW
    W2YddALBuUnaiTdjXr4uG2aP3GaM-TVDXJ22jHivr_4oSQ1Yf94sE3V>
X-ME-Received: <xmr:clrjalVwF2JQJVw13J8bzp_moVCmt5ON3wHrigPuMk7lqK4nh1e0WRVZJUE>
X-ME-Proxy-Cause: dmFkZTE1JQNUF9PdrYwdkwAFugjPequB2b5GkpJPbUhdIUOmy1kLSEa6ffoj9Hd7ym4nlQ
    6c+qEKz7XJF2dLx7oRdUpSkj4b254h51buP1yG18if3BMK6dmDzoqWHXykJimalZrh/4rJ
    SsEcPs20Bpv09nkNrhslFOxZz8uVj4cr4k8j9ijyh/XBoKSuXv1p6X+IUvsZtCJM8WfE5l
    J8Jz1TAy0V7XkJjA0KShHBsQLkX2f1gt0hjvq9NIXYrKVkv94AWot0YqZ8U/rCanLqw0Ux
    nS0CeNSxqNiXe8tVlryBNbvyzw1vi48KrHlrtPOhBitk5kNMfGdDxWgDHV9ZsVHIb2WImx
    TwMS9d/rsrEBKfxdMOSo+pyt17kDFmy35KxazECXh7bqp4EIa3Fk+VlfdJbpj5ufyo9OA3
    cdQZdLaECR6tTTcrvOAoZ6f8OJwIL1rN6yn5DB/KWiV2ZbluJEJnlB1arcSbKxNW52myVz
    06ljSPiBv3EbnUa1kWyazn91XogClvtyE0OEqlsAQ638VYboUKTsedBBE1LJXDi269o4Qw
    Jo3zIY6bYwxBR4IQ787plmSM0ewfmHIgzlo56dB5tRTuxgWJ6cyyj7nxSfxzCvAomiCOef
    /nGdMay+iI3nqioWP+xUE4QMzHjon9lRnR6vq2mNaqsZfMczKJ9UC07yYVvQ
X-ME-Proxy: <xmx:clrjauN5WCjWU-nRFrKozan9UHun3tflzjyAaUsmoY-Mg1OuGX0sEQ>
    <xmx:clrjalWUgDKRASjNXAJyazbkKPoi7Y_W_Rsj-ia70PqI7oYCgb-pEA>
    <xmx:clrjatyBguzEpF6N-3-X6Q3E4UINxDQ_lRm6YB79WHIGxjn6iTUxJg>
    <xmx:clrjajV8eyec9TfZkbwyvC-8k98w_Lm5Z4HTLbuzuMzfrYU9QdUqGA>
    <xmx:clrjasGG5-o7aX7slOQu7t7Oe3RWTLaCSYJaWSafbHpQPxnDOYI-ZvJZ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 10:38:40 -0400 (EDT)
Date: Thu, 29 Oct 2026 14:38:39 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
Message-ID: <auNaOMYUUpnzCofx@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
 <auIniV8YSpA4_oxg@thinkstation>
 <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>
 <auMvYdTd_e9O9kDj@thinkstation>
 <7fab2115-6c44-43b1-b03b-8ce4a37ffe32@kernel.org>
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
In-Reply-To: <7fab2115-6c44-43b1-b03b-8ce4a37ffe32@kernel.org>

On Thu, Oct 29, 2026 at 03:18:23PM +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 12:37, Kiryl Shutsemau wrote:
> > On Wed, Oct 28, 2026 at 10:45:34PM +0100, David Hildenbrand (Arm) wrote:
> >> My brain hurts, does the above make sense?
> > 
> > Yes, I missed that the loop only goes back to start when a lookup
> > comes back empty below end. When the last batch reaches end, it exits
> > without another look. It doesn't need the split either: any punch hole
> > whose last page is in the page cache gets there.
> > 
> > That exit looks unintended to me. b9a8a4195c7d ("truncate,shmem: Handle
> > truncates that split large folios") turned the "if (start >= end) goto
> > out" early exit into the loop condition. Before it, the loop went back
> > to start until a lookup from start found nothing; Hugh kept that on
> > purpose for hole punch in 792ceaefe621 ("mm/fs: fix pessimization in
> > hole-punching pagecache").
> > 
> > Restoring it is enough, and makes the "restart to make sure all gone"
> > comment true again:
> > 
> > +       if (start >= end)
> > +               return;
> > +
> >         index = start;
> > -       while (index < end) {
> > +       for (;;) {
> > 
> > Then a replaced folio is found on the next round, and truncate needs no
> > special case for it.
> > 
> 
> But that's then another lookup even if not really required?
> 
> Why do you thing that is that better?
> 
> I agree that the code is simpler, but at least it's consistent with the other
> handling.

The extra lookup only happens when the second loop had work to do.
Normally the first pass removes everything, the first lookup from start
comes back empty, and both versions stop there. When the second loop did
run to end, it costs one more lookup over a range that is now empty.

What I like about it is one way to look again instead of two: the loop
already goes back to start when the last batch ends below end, and the
patch adds a second way for when it ends at end. truncate is not like
shmem here: shmem_undo_range() stops after one sweep on hole punch on
purpose, so it needs the rewind; truncate was meant to sweep until
nothing is left.

Your version fixes the bug too, so I'll leave the choice to you.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
