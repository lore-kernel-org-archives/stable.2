Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199910;
	b=xJlrtLI5VNh464xsfji6XRhBDu1q1PDjeTxoPGZ3rv4O3JpkkY/bkxx9bdZnPGApTjHK
	 Vj0+WixQOfWWDdlFb4PKGX2w50c9R9SJPYGFkMDQt++4zHUXmjV2KwQ1fSgLVK0F5cp+9
	 Ea4FzoNNhu4Ze92pVYV6IqnIhU0FDEVAtG/2Vx85hGZwfA3RZP7M/lqwjhTQX7GwhW2Pr
	 gk/PF9WOOQTsO4lsUN4W1iIKQWe2Cbl7YywOCTWCZ4e9vMmd81oJc0nJChN5QK5zPcnn5
	 4r1gvW2qPHp14nTIc2Wab1wVxfxcXcga5KHL6aXkTDB0g/JvnVqXitZmutEjaGKdv9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199910;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fm9sbTCBppNJ7LsVf+owwMbgpTrjKqNrXCKuUZa34/M=;
	b=Fq0wEiz/QHY9KZGfXhDL5w9+jwPjLdTy35KiJGSpd0jiEHbhbFxDEo/Qp+MyHxhrkCc2
	 6reoO4kSHqEmDHrv+oA2UDE4RprZn7zfycOc+c3rlbu8+hnuOkAhwlo09YXzvj4owG7Us
	 ic6kmL+5y6cARDlyNgY1tpARSp5h3ywluvqIWeq23vHrMQ45PiNXLHZ6ciSzW4po4T3HK
	 kxdBoHHkWhcB3VHtAqUg9fjbnKo8tokAoHWBiHK+THv2wJlVms3wCrbdcIVSTxU/486pa
	 XWKIyL6K9K9puVdVu9ETverH7Ucq7eDDtulN4qaeUloDi0+k0Qs/r9frIeAH4PrFdDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=O3i3fhA+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C9606A321;
	Mon,  9 Nov 2026 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=O3i3fhA+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F0B1F0089F;
	Mon,  9 Nov 2026 04:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794199909;
	bh=fm9sbTCBppNJ7LsVf+owwMbgpTrjKqNrXCKuUZa34/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O3i3fhA+0dFLY5h5N14TdM038OYiE9Kpn1xq+6cymVGn26LwtjUUe9QIIKPkzp8pL
	 IKPujBdZwFLdne9QsumMD6GUHXrEZEg5uSGWJ2QTVQgANyk9ZtCD10LmkAbkgEjC26
	 7ZBOuW4hOJGENBJmmeoqGQB1nhL8eNgT86dKtUKA=
Date: Sun, 8 Nov 2026 20:51:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Yu Zhao
 <yuzhao@google.com>, Kairui Song <kasong@tencent.com>, Barry Song
 <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hui
 Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/mglru: fix a no-op lru_gen_clear_refs() call in
 lru_lazyfree()
Message-Id: <20261108205148.380c16c42bb21ed0e2c829fe@linux-foundation.org>
In-Reply-To: <20261109021611.22247-1-hui.zhu@linux.dev>
References: <20261109021611.22247-1-hui.zhu@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 10:16:11 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:

> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> lru_lazyfree() calls lru_gen_clear_refs() after lruvec_del_folio(), but
> lru_gen_del_folio() has already cleared LRU_GEN_MASK, so folio_lru_gen()
> returns -1 and lru_gen_clear_refs() exits at its "gen < 0" check without
> clearing the refs or PG_workingset.
> 
> A MADV_FREE folio therefore keeps the state it had before madvise(2),
> even though madvise_free_pte_range() has already cleared the accessed and
> dirty bits of its PTEs.  lru_gen_folio_seq() places it one generation
> younger, and PG_workingset puts it in the last tier, so sort_folio()
> promotes and protects it instead of evicting it and charges it to
> lrugen->protected[], which read_ctrl_pos() uses to balance anon against
> file reclaim.  __folio_inc_gen() clears the refs but not PG_workingset,
> so this repeats every time the folio reaches the oldest generation.  If
> the folio is redirtied first, ttu_anon_lazyfree_folio() keeps it and
> lru_gen_eviction() packs the stale state into the shadow entry, so a
> later refault is promoted to the youngest generation.
> 
> Call lru_gen_clear_refs() while the folio is still on the generation
> list, as deactivate_file_folio() and folio_deactivate() already do.  Its
> return value only says whether the folio is in the oldest generation,
> which lru_lazyfree() does not need because it re-adds the folio below.
> Keep folio_clear_referenced() unconditional: the classic LRU needs it,
> and it also covers the folios that lru_gen_clear_refs() skips.

Thanks.

> Fixes: cc8ec7be78ff ("mm/mglru: optimize deactivation")
> Cc: stable@vger.kernel.org

I'm not really understanding why a cc:stable is proposed.  Seems that
cc8ec7be78ff's changes can lead to MADV_FREE folios hanging around for
too long, but what is the runtime-visible effect of this upon our
users?


