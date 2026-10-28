Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205641;
	b=1h7zxGbTzuyBdUIIVSNR371rjFI4FsCd66jKrHovnQfenTwHeWieTBa7iC64I3MvKJCj
	 Ahrmr5gfJJWFPppP/6xXBR6CEE81NVFfULHOhd0hYuPZ2y2s/iK49G42gNqJNg/zkhdd+
	 6o6nWXku6Lm3WTrAnALO1W5AMYdCJLRhqhv7v8MCNXHSijWX+jv5xptBhpaAfRuW8SHBQ
	 Q70d5Cg9BkwTO6CsffSMS2DVJD1dMj8KHLLTREj11uSNbmbL900bxw6ufcSWqUAHSmpGl
	 HIeex/cIqGG0Lzmq80n3gM56iZPAVMh1rrF7F2B2calhFTjenRYpa2b3vtizNc2Bfzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205641;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3q7TO+ZwaEbqoqmLKPrIUPjIISzIPUN3/sJr3wevERg=;
	b=oGE6GcfS68dOW74aQGGlX0sdMozCqGznQ5BOmVmlz5Xs1/pY+DxK84K1fi03K0kjnjvi
	 rgpdPwnL0q+sARDyt5oNfzKEIAALv2aeGXZz7MUVCsiFVAvhDIZccuMrlwMocetsWw513
	 HQQuTVrAcvi/ztUdIzZ0UluvDW3Tnw4l8Yhvng3hQoP+Hn3YkEhsmRABE9oXHIQU/sAC2
	 1s1bPOSv/ID8yyewd7FPnvTYvLA12n32JIk8qN7J9L7uSTxGGVaMq6gYAgwlarEXMMYE/
	 PgjAxFT43kQ9BqBxYZ990ZTSUdBojvlqerTpvT4gU7TermVOE0YwP3NzrwN81EArhTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrWSFKNl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAA606A322;
	Wed, 28 Oct 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrWSFKNl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B8D1F01825;
	Wed, 28 Oct 2026 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793205640;
	bh=3q7TO+ZwaEbqoqmLKPrIUPjIISzIPUN3/sJr3wevERg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JrWSFKNlihySPv8s4lmAnMXkX/dtX6szCvnGeflYs1hARCipDCoTkDPY/lHrNu1TB
	 ExsFxdXFzSYz8EttGQc73I5P69CU4a8ag5+HKBcv7+bfJyJMMn5VSCeGPZrvUq48Jf
	 +/MdP0lmtieSO3QbGNT09JTEs1HDFgYZ1KeDBk3cy68fzBJhmij0dVkjTvrWea/uvB
	 sA1M7qD9HqqJm/s6dYIEQIb4tp+8zJdJwZ9cSjg/NtNgHQC3bgC4ceoC+GcBmi0LSB
	 T8Q/h5Aod5LXIo4CP6cNwhisJq1R3DzsQ97GK9xhbZMhqT6p28JuwvkZD3/rs0nJKp
	 tPSEwhDqkN9vw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8F8CF198003A;
	Wed, 28 Oct 2026 12:40:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 12:40:34 -0400
X-ME-Sender: <xms:eCXiaqiN7uW55pdnDLmQfMCpgqKssyEAlbg2kEo-5uT2EnxoO4ZuSw>
    <xme:eCXialQiwOxUKOiOgRbMVzuCX901N_ygNZZlIGwGmhUSPEOO024OPL_frpYc5UvRF
    ufzO0DZbg79qizqZNu3oZPsAJjfr-Rc3mcV7MSCwYMa2c4GY3IOmUfF>
X-ME-Received: <xmr:eCXiakFBqwymY7_RFYo0Ad-7d64WPxU19dNbSVic6uXNgnkcXdts2JTSFpw>
X-ME-Proxy-Cause: dmFkZTF9BSIUpdbqdcQtRDBoZ6omZu6gkWuOLh6CEtsiN9GCwL96yShYRR0sGWUfB/BAqE
    WZ64unNfK3Oe0Pmq84aQBKzz6U4bNLPGOt0L+3it1u7lBgkGfJBxf+KgimcC8ODml/Bvs4
    tVarhMXUh7RcWdDG/2JFwnscmJK43/IZh/RFjzDX4hQQAHQgOtEMpiD/6x6mNoabLgV1Uh
    8N833SkC9jtVG28yAz+w/Ea9Sw7TZ1VqhdC4+mQnrllda/7izabJuHYqT4SfvoZvONJ4j5
    MPW1Gk8oi9Trgp5oDcZSI4Pe9o74RJVHkS7lxxR8lsEZd8CIgsegB1KiHE2T7Z5xehGBqQ
    3UynFVkTFHQUjTSucs9dm2AKKwGlYfQ+KZouD3lwtJq+CNgLVrRX8hnysY6WtAmZYn+2FA
    UMKoGHv2nyQcjhytg8JcnhDM5D5FH8oTePRRudgezShXdD3VQZaIwdMFryvIDXfmNdG+xS
    x3FgXxCpjM1Dnx36WNsJr9NZywtGtqeBnpNa2CcH7uZItXr/EJtDkKFaLLDYrmrMYoRZy6
    9WMgAdXyW/auCalGZ898cnS6rzXymDqGbDfabqdqvexVbud3Xyfh83yzVJNAJb/KZJB0Dr
    RwkvxvaWvVMVXraC6fhht0GDpCcItQ8xXgQ8CizyTFww+xm1P2qA5dskCNwg
X-ME-Proxy: <xmx:eCXial92jNgSBQTxWlBjZMWgmR6TBvKzWaFSBoP-VAqjL0ukcNqioQ>
    <xmx:eCXiaiF9yjc9digKd5Ya1GDuxp2814mB5aHgvCvd4OHzLNuho0A7Aw>
    <xmx:eCXiarjoMRi8d9X-XM92nD_cnaj5ysHGPELtUq4mL-3Vs4NwrN19_g>
    <xmx:eCXiauHvY_LuyMcaATsWdR4V2wsHPU2Pnegr0ayYJWcc1st6zamU_g>
    <xmx:eCXiav1OXfLSRm-Vd5XTlOvlVQyXslpANnXfV-qVihMApMQBeiD5C2MX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:40:22 -0400 (EDT)
Date: Wed, 28 Oct 2026 16:40:21 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auIlVgNRuGsBrRso@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:24AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
>   CPU0                                CPU1
>   write(memfd, "a", 1)                write(memfd, "b", 1)
>     pos = file->f_pos  (= 0)
>                                         pos = file->f_pos  (= 0)
>     vfs_write(..., &pos)
>                                         vfs_write(..., &pos)
>     file->f_pos = pos  (= 1)
>                                         file->f_pos = pos  (= 1)
> 
> One of the two bytes is overwritten.  Two threads writing 100000 bytes
> each, one at a time, to a memfd end up with a file that is far shorter than
> 200000 bytes, while the same program on a tmpfs file never loses a byte.
> 
> Set the flag when the memfd is created.  As for any other regular file the
> lock is only taken if the file is reachable in more than one way, and
> nothing a memfd does in read or write waits for another operation on the
> same file.  This cannot be done for all alloc_file_pseudo() files: anon
> inode files such as eventfd are S_IFREG as well, and a blocked read holding
> ->f_pos_lock would lock out the write that is supposed to wake it.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
