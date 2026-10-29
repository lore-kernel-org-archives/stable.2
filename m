Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288577;
	b=KV5mB1pSdhvUQKZQm07GgS5QihkzvcypTVIxAESUyBHZp8t05Pzk5aj4aJHfzgktAngH
	 Yp4RRc9+Xsxjj1f9TS536Eb/BxQzTL9lu1nUMKQmz8Piw+6dLnYhwzw+eXhDmaYynqagh
	 FOMHpwG1ckneZGQ2I7e22zjSppBNARrnU9LIieZGIk/tUOT2E/JrpLSVzTGbxC6Krdu6n
	 e/LXgfGaLKggBAHfHNq1vhvdhCxhcvrWXrm80vRRIjDwPzz8PlilvlOsL9kxQhXRmpKYF
	 PiTTV6cEO1bPFd0uR4PIqVgB5o9g0xjcbxAJt6W/Khpd1PoN2NUnS/Nks7RT1lyAg5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288577;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=x05fCxndf1hYykwEJ06qD0sbC4EVKTE/sZRMpUPdEQc=;
	b=f6yj0LSVW+IUN8KAbkkSz3bFNf/Y5nKd75DEpJcuL8U3hV+e0yU9JP4nfs9lmq45FCUL
	 rhb2txmC6vIH5whS3mLqxCJ3BLCjKj+z+yRxRFgiS6CzeuD+IMlwAbfCMh7Z28FIc/iVO
	 s1U6RipoTUQWPdDq+rKMYBLQr+3naDxh98LikbunNlRHOy5qP1IG3BEEculEvaItSJkLW
	 UjLDIuYmQzi2nIXm1SrSIs9+sV7cC+X+sii+9Dl8EkOl2iuPFT3pnx1Las6caksogVML9
	 TidU93yrpDrEbzruBNBpHOrnIDxXQmlkTeWEXQtpadl16HmTgIEHCXsv2msefjDlN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VBWpMU/K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF77606A32D;
	Thu, 29 Oct 2026 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBWpMU/K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F621F01825;
	Thu, 29 Oct 2026 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288576;
	bh=x05fCxndf1hYykwEJ06qD0sbC4EVKTE/sZRMpUPdEQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VBWpMU/KLAu7f/e/8Noc5/ky4m6uYCqrAnbDe7B1Eiyf3YKYYuSJu9S6rMUBwAHRq
	 rxdNuSkxQyc4TOUMzaXdWdtkkmG4SSedqSFbH+UiVGUvDBhSbF5ps5Rj1N4WC5Z+1M
	 nVg6ipTCrheIKd6OSnlqmCHY40aY5JuHQMktjBDTz0bNGDllpKtBpr67h+uTjX/02/
	 BPVwPJ/jrEhMjy1lbZssZEiGQ47CW+eoOvd7LM9X+gXcm1M/wx1zx2VQ/uyO8q67C5
	 n6t0zAffCO2JyYnGumXddDp++ELqcS68IiiH0skAk3Y++ZmqpXAGKI8OP//9xNZw14
	 KXjSab75N39jg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 55D60198003A;
	Thu, 29 Oct 2026 11:42:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 11:42:51 -0400
X-ME-Sender: <xms:cGnjatNYCDeDF49taWGwFnFA6DTBtqFjLkJEWyZ2h7-8tO1hYgeSTw>
    <xme:cGnjalcGilwgpzywEq5-9_Uax-LoiciY26Hr9Dx2NdLZKDVOeYHxJNoKbsqoyc0HV
    fMpRhpRtFCi6EkHPOqVKO7Qgcsf8k8JabM2EeZbLZYt0LPRJSrAX1Uy>
X-ME-Received: <xmr:cGnjam3XDA41P6ZfG4_oZPjd4RhksmXGacPPo4PHNrL9WQIkvxQOdIUOlic>
X-ME-Proxy-Cause: dmFkZTGrojcwHOYNV1R27yGMmE+sn2SpgiwFqzTWix470caHvIOH90SafujrsKt+HTJD90
    SN5SPP69uNBPn1MxWH6/eaMHHTJo/SvRT/z0Ju39Z9YfjzvKYsDYrFhgheSCBdJ9b5YIFp
    cIdIwys365LDAngvB6UcUIm3AGzNccSf4yN/FZLQr8sexIPFzUStpfInmWS9yXmQgvCx5c
    fmpZ7EbFXEWylssnvmmDQCnrMMUW1jHsUhf/jrVErtMG2Lbffr1bqxM2P6gj7ypN5ZdyZj
    TgAYvrVjfWikwB2MTrnw3YjFYjeMV0UDDQUTP/dXoAy/YlzoJiJh64//IR8g0ZuUVQCpel
    PcjjoB9Q6Jx3knI5olrCUi4hirBEGQQT+oSeGTeh25/h09KblyE6Vl7jNLQSnQit4V+35z
    J17GU/oPzC0n+oCMVsG/dfInPKVCtLZBd5z2d7pFm7kIyajC91WW0fXwTIMOKy3y+R1okp
    ekcKGTudIOrHnEZRx1GDJKalnfGvVV/PnxC4Qbu/41RL8DRLjWQuiSHsfiURJwHwuxhasY
    GYMOJsxXNzU8cnNcXtdtzJIfeYba/tJgBPi2qhRcbC1kxMhMglGWVDH8uH+rSsnay/vQnw
    D3Mh5eiVtNV6r+viH4MNCT1TzsAFldnQpQurl7rb5p9gSfzssla1/AAmhpLw
X-ME-Proxy: <xmx:cGnjalwWU8W_LTwkSDS4FwlbRvlMAxVh616uhleGcP8DWlPfaYmGzw>
    <xmx:cGnjaj53Pt7V4Vu7bIXzZKdpvSrEym3BIg-jYhLqD8PxloGEbD1BjA>
    <xmx:cGnjampN953BOAPY-iT_PyL1bwsUDnSFFEZwFhBzoi8zawrViQ6drg>
    <xmx:cGnjaqnZb_SLLcbp0PPUsQOS2wLwEGRm-QsuvZlsn1hfIsEUvsIcMQ>
    <xmx:cGnjaqQ6rvy28ek_52FnLx0f5zjRtsChWHkRCTWZP2DTXANVWLWIhapi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 11:42:39 -0400 (EDT)
Date: Thu, 29 Oct 2026 15:42:38 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 42/46] mm/huge_memory: split huge PUDs when adjusting VMA
 boundaries
Message-ID: <auNpU-7hPtUZeTGs@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-42-6f74bec9a5bb@kernel.org>
 <auMxQPze5cOvGbCe@thinkstation>
 <9f4128a4-85fc-4f4b-ac41-b9d348f56e37@kernel.org>
 <auNYPPlCnLdN88t_@thinkstation>
 <d5d077fe-4695-453a-a2cd-40ef30abd61d@kernel.org>
 <e796dace-06c6-43b8-83f0-594e7f1e7380@kernel.org>
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
In-Reply-To: <e796dace-06c6-43b8-83f0-594e7f1e7380@kernel.org>

On Thu, Oct 29, 2026 at 04:35:46PM +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 15:40, David Hildenbrand (Arm) wrote:
> > On 10/29/26 15:31, Kiryl Shutsemau wrote:
> >> On Thu, Oct 29, 2026 at 03:24:29PM +0100, David Hildenbrand (Arm) wrote:
> >>>
> >>> __split_huge_pud() must split a leave. Either by zapping it (what we do right
> >>> now) or by populating page tables (as in Usama's PoC).
> >>
> >> No, meant the situation when pud_leaf() is true, but split_pud is false,
> >> so __split_huge_pud() is never hit. pud_present() is true so we proceed
> >> to pmd_offset()
> > 
> > Oh, yeah, I can add a WARN_ON_ONCE() for that, it would be a bug in the software.
> 
> Ah, or I can just drop the split_pud check. Let me do that.

Yeah, looks good.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
