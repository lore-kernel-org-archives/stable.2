Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775942;
	b=deWLil9zAoL6A0ua1lJHJN3R9rNswdahgfbuP6sozQWNpqKKcl5DDCcngxNAz0W2Ubi9
	 9PfyHlBSjO7dsOVnWniJKQmz6X4HbW/Znvvx/dNtRiCyt8W6TIWiFf+Rq3mGiGAZGA/0j
	 Ump7UnNGGCQW01CFubOVGbREWtF474zWUcZR9IlCSNAF2VCop/RYmvJbVDHp0ZTX7dWcT
	 00xSgM8QcNs0MuRmy4oijICMAGnVkGMAuSRUTT3UNmmppcw/n9siSIZTkea/XyqTkr+ch
	 ZQXp1CEUA/7LZxapgfuepKGqh6Q7eDVVK5mpKp6nLfuYiUyIbU2iEWEpqUt1IlOQtMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775942;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u/AayYsTiNYt6mqT7iE2EqkKwoSn9pQdkbKI6ZILgR8=;
	b=jflRuC6tsRvibHYwML3L5aQ0Ib3bp1NJcrbWmQ8hrPw/SGb7Uk8PFvQVufsAcVQZmGwf
	 L9+V45WcobpkSRuJwccH5r37t7+1omZ1lXTjY0fq1hwk/csF5Sc+lc8zcbsB+EGgvDain
	 PPHwshQ9w0elLsNSbaxiThMy31l5Pi6e1J5n+nbbt51vFNDRLsFYxc0fzGwXmntPJ8pzV
	 ASgJ9O2mPZ6pOevwy4Zbbbsf9wjlHr9RY6v9XBn1FaK6DGRWV/E2UI3Yqn2vNel4s4ezK
	 IEIMCRlaS/UBwFIE6mYfmzBFBnCMp64VaEoEQUJB7XGpUwPWL+PCUFhKXvcf+WL3m/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BApUzOSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B9606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BApUzOSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E25E1F000C4
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 20:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775942;
	bh=u/AayYsTiNYt6mqT7iE2EqkKwoSn9pQdkbKI6ZILgR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BApUzOSFrTeB5M/BZMRwMpckJyeCRdcjwZBO7NzEQqC/50kEG/LDPNIp9vhETuJOp
	 G76eGYelS9dsexMz07LwFVcrUtpS5NLYdf/5ksciheX+nl5XJL9wJZe3lChcWnovuD
	 Q5DSKtBjKgT8vU/rCFJftXTM8inADbP5J0ieCUoVw6XhLGSGHPm8oeJFAM/ymlhn1J
	 akCHeaty4ugqIR9FIqcxQHrRZQAtcdp7A8oSeUqo5VlzskapF7g7qQliDoB4Drqqmt
	 dOaOvWaz5J14Of7/8N702ZitJp14hxNe7vL7Vai8erOm8yQ0yyp8viZQDxnRq98HgA
	 DXKlN+9ZofxLw==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f2049ea7aso233297485a.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 12:52:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEykWp1xJvHo/2SvG7AxjHNnzr64/ImQ+FW1iE/+I0UA5N9NOIgRsw+iVn1sPiT4eAdfC5UFFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bATa/Ba2i/CH13guRaxGABQvIhyPBtztLErEmSZLtoGRvCUOZ
	5bf27RmC4DRGVnQk3q3V3Hr4BV1O4eUS9d9czTvoI55krlCHALGo7LJAr0c6kpmCChF6UtAp+3x
	f9IyXnLW+6934YszyOOh1FH8HqpdyEYs=
X-Received: by 2002:a05:620a:4607:b0:93a:2e8:5aff with SMTP id
 af79cd13be357-9494bbdbadfmr1497787885a.21.1794775941628; Sun, 15 Nov 2026
 12:52:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111000913.22943-1-shakeel.butt@linux.dev>
In-Reply-To: <20261111000913.22943-1-shakeel.butt@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Mon, 16 Nov 2026 04:52:10 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yjZAx8x64dbfSbPZ96XEWJKL5v8pHxQMiAu9i_QUnM8A@mail.gmail.com>
X-Gm-Features: AclHuK-EujoA04rdzSgJCrEu29bOyojsuZv1EugGr9GiyaZaSxW-KoiDaQwxUno
Message-ID: <CAGsJ_4yjZAx8x64dbfSbPZ96XEWJKL5v8pHxQMiAu9i_QUnM8A@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a memcg
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Noah Feldt <noah@feldt.systems>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 8:09=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Noah reported list_del corruption on single-node hosts running 7.2.11,
> which already has commit bf4ade7dbd76 ("memcg: keep folio's objcg same
> as its node"). The bad pointer is an MGLRU list head in a freed
> mem_cgroup_per_node:
>
>   slab mem_cgroup_per_node start ff31bfa36a3c9e00 pointer offset 528 size=
 1920
>   list_del corruption. next->prev should be ffacf881ccc70e08, but was ff3=
1bfa36a3ca010. (next=3Dff31bfa36a3ca010)
>
> When a memcg goes offline, __lru_gen_reparent_memcg() moves its MGLRU
> lists to the parent. It moves only the generations (gens) from min_seq
> to max_seq, and it puts each list at the same index in the parent.
>
> A folio's gen in folio->flags can be ahead of the list it is on. In the
> parent, the same index can stand for an older gen, so the folio's gen
> can end up older than its list. Once the parent's min_seq passes that
> gen, sort_folio() puts the folio on the list for max_seq + 1, where it
> stays until the next aging.
>
> If the parent goes offline before that aging, the folio is not moved to
> the grandparent. It stays on the parent's list after the parent is
> freed, and the next list_del() on it touches freed memory. This needs
> two cgroups on one branch to go offline one after the other, such as a
> container and then its pod.
>
> The parent always has MAX_NR_GENS gens at this point, so every index is
> valid in it. Move all MAX_NR_GENS lists, not only the gens from min_seq
> to max_seq.
>
> A reproducer that drives these steps through the lru_gen debugfs file
> gets a KASAN use-after-free on the freed mem_cgroup_per_node without
> this patch, and no report with it.
>
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Reported-by: Noah Feldt <noah@feldt.systems>
> Closes: https://lore.kernel.org/all/20261110132853.71228-1-noah@feldt.sys=
tems/
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
