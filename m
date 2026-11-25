Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650271;
	b=zAJGmfzFBcvRaLAGGbECjuAsteeinfP9Y/XBy+VO2if9PCEvk71VLY/FqF69kXpMprSq
	 FW4STZB/xmPFL1Kw+auOA2B+gs1Zlg8Pa+2Yp8DKNskDnw4JH+gO9TpzZw3oJGfa5jPd5
	 WUAFVkXi7UmfPTzxrpuiXxMDoEEvyeeTpCHK1XKys6gfiF45ROnVumlJ++mpOSPppLudx
	 kILPc93RrxWqgiwojkZQhqmD+GErxUOExsLRED0RQ54W0tc//JssxLR6BSknZT/lE+yLi
	 vLZSHe5407t46nWntyAd5JO/MimRWRYAoj/V1b1kD6pNgfyyxJvYIs1o/ejKVflgeYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650271;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f/ATAjGGuvCnHn352ejN1uMtKhQ6IIrtwCiWm+JOgec=;
	b=lAiQfMumyG4ybea9QuXfPjRifd9gxsUUxUFykCs96qx6jd6Oxl5hhhjjllhBLrPUUQ9z
	 kKtIxKGrNhQUZh0W3k6D8abQYvNPTGx/9sn085pHwcdi8QTJ7QP9TIsQ7wnoqhU9cIREo
	 r+MqRT6z7e1diiGHzXU1DsmfZCUbd0s6Hh6cno7mdVd7ZQgVX97bxPiH6eD57tzUf4Vth
	 OjvCqzlpAfJNEo2oF4KK4mKdJfRqVEPLn8uJMskc+WDCXiFcqkFKmoet8itkl4xmv6M8b
	 djeZEfshJlZp9dU5901NiF9BpBafXSSPgA07F49ProZr6UQzHQqQRitpZr98NQDeC9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfkTtSt2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF288606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfkTtSt2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081E81F000E6
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795650271;
	bh=f/ATAjGGuvCnHn352ejN1uMtKhQ6IIrtwCiWm+JOgec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OfkTtSt2xtBQR9UeimfOoTw6v3sL+yc1TRUwElnClmYZrlwHdJanGTW6e4tH5HmCu
	 /ssM52sxD1/MhEerP68lHHZ2OqaasROIYX1xjwuQ6HHzNYlUZjf64/GqfLW5GZdNey
	 8NDu78Zrgxpy1RRRhqMjMcGGez/CPEcafU2I5r4u998bsnBDVTJNGADkdyqGonNP0d
	 8rY0clo9rfZHjK/mgu4HsuJwHdYmocLmWHimVsjmnkejjtqbC/khs90dLfWPk3USLN
	 Vg+PjAWb+XDt2QrKNk+9tb9bIH62ElwnS3HqSHnCpzgH0FC2MhIY/+Vz90ywivXVIA
	 3iXjXHfmqz9wQ==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9496317b730so731961785a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:44:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHLagcko1w0Wg8MSDPHZbE9LWjXWfbLNbnf3HS4iCvUQezlwzq8guqeiMY+WDEC7eSMBPQ6zOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p8UaIhj4UdtrPBxE8SvGfeRFV5toKKS0p2SC+15G4Qrkmw+JJ
	mwoSA9D/D3N7S1Re5vlFJZzOqCvaMblee3y1e3JwibwPkZoBHvC9U9vDw0C1a/JIw/4N7zigbNu
	Q/EF/pZNifwpwjViuB7zmkLtZL2Uetxk=
X-Received: by 2002:a05:620a:3188:b0:93e:869c:43e2 with SMTP id
 af79cd13be357-949baa0d797mr3140085885a.50.1795650270349; Wed, 25 Nov 2026
 15:44:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125113518.1207280-1-hui.zhu@linux.dev>
In-Reply-To: <20261125113518.1207280-1-hui.zhu@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Thu, 26 Nov 2026 07:44:17 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yTx+vQUQ44iLg8MNA718dY9Z1gAdnz9vvJnZWzVZx-4A@mail.gmail.com>
X-Gm-Features: Aa3M54qXmwUVwHqi93lcxb96GVJpfnkGS49EGx9GJPqC8qElTspz68Xy-8zCgLQ
Message-ID: <CAGsJ_4yTx+vQUQ44iLg8MNA718dY9Z1gAdnz9vvJnZWzVZx-4A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: mglru: reset the mm iteration cursor in try_to_inc_max_seq_nowalk()
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Harry Yoo <harry@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 7:35=E2=80=AFPM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> try_to_inc_max_seq_nowalk() advances mm_state->seq without walking the
> mm_list, but unlike iterate_mm_list_nowalk() it leaves head and tail
> alone. If it races with an ongoing page table walk, the cursor is left in
> the middle of the fifo.
>
> The next walker reads that as "this generation already started": it skips
> reset_bloom_filter() and resumes after the cursor. The mm it visits are
> the ones the aborted walk never reached, so they have no bits in the
> filter being read and walk_pmd_range() descends into none of their PMDs.
> Those mm miss a generation of accessed-bit harvesting, so their aging is
> less accurate and hot folios can be under-promoted. Eviction can still
> detect their references via rmap and lru_gen_look_around(), so this
> weakens aging rather than guaranteeing reclaim and refault.
>
> Reset head and tail with the seq increment, as iterate_mm_list_nowalk()
> does. It is safe: get_next_mm() holds an mmgrab() reference and a
> concurrent walker bails out at "walk->seq <=3D mm_state->seq" before
> touching head again.
>
> Only reachable from memcg_reparent_objcgs() -> max_lru_gen_memcg(); not a
> memory safety issue, since lru_gen_del_mm() repoints head and tail under
> mm_list->lock.
>
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Reviewed-by: Baoquan He <baoquan.he@linux.dev>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
