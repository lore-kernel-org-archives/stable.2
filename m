Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794411997;
	b=qdJoAtxBU7qBXJl/6RTmqlr1grrsSNhzMfePAA2Fe5IiDMXfJS+GI3SricEuKuHVrp/X
	 CbeYGPG1R+in1UnKJXOVCDeaoEcUZRXBThgh8SLC7SczhcgiH920nHUoC4GI/6Qs6eqtd
	 jDFGm7arRdWXZNi+6KSTKjACB+U0nK5+PUYEeFUO1ciJrlotz16OQM7fk5Vtyd5L2KZs9
	 5vJe/e6zSuGZxNoBpXO+4zGSCP+we2bL0rOt0CxCjkQ924kip+tzIsC+Yprp+w7IpWTQO
	 Y1/YUPFizRD4rdqjxvfCS8TknGDRfXC9DGoaDQ6pNEVqWJS5fPwcLFg0xNPfXAcQ0Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i7mcrqf7XWOgEb4YXjGMz5tqNzLFKqEiO04XvkJXxpY=;
	b=2hxfVgirDQ3kNf7nhHMLKnw2pICRrrTTm+622oHbvWgIRJQJ2JZQ0ZG00NJXI2BL2Tz7
	 J30O/xjZbSHtfDWOFscmW9NBosCcLRVpweo00dsV1Uvvf5P85M3KZiY2BWbIi2P/Xb47c
	 aCS5v0fFX/zlb5k6tyQ25pUlMbi4ttkJII0YwzaAVZpL0F5qnsqa2zVnNfuNHQRRbhn2t
	 YkeFwifRLccsjKB2RgQQXaG3TwtOrzKho9Sbzq57474oWcbXyMXsvc2GG0PDuRoE4mjfV
	 tkvgleJBOWb3s5QqUM7cm6SqdEbZXUJu/w1xxiX6F12S9h6bn4xFCXwc9+jTA9CXMIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSfFbW6V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A3606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D4A3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSfFbW6V
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so4027594a12.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794411995; cv=none;
        d=google.com; s=arc-20260327;
        b=b9n8msK4ogUPpEMpCtbkHo8zCVNQ/lfQFe47ksrAO5LcVDWZ5ei8RQN3ZWPWjtmGSL
         GD0hdeQe7qHF6n5XTaO3YHNGmJB14KwLs65BPe4TJg+iFEYVyY9rvN44qoErF+qplX9y
         OE6cZetw0PRHAoQTwbk0RqtNyRP5z2t2ZVmALJpuBG28//HxQIzCV/NohjaO17KDXbBf
         NOB1wVawOhBQ57FMnKmT9Ibr5hSYcJeKeh+XYHFM5Q2mtYHeS5IY0Yez1serOFmI/E5W
         jiadm2gmzLSZGQbrjSy5j9MCFL7rweZLagUzhsGaRKMjAobgiHpF+l2Ldep+F1kxJBmI
         +Haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i7mcrqf7XWOgEb4YXjGMz5tqNzLFKqEiO04XvkJXxpY=;
        fh=awVC0NaBuMxOE7GqW4JU9MdOI295XB3k5kFLoR6V/Kw=;
        b=Xsw6AiTtF2eBn1PuSdYkFLgsNSP0NXFQYaUIFjexh+jdH39JQEMRlkVfjOAdBM9/pr
         LCpNJr9nze7k+RJLyHkITjMVGd9JmThikbTkpYyZV1MKX1N8uUsEKH0z7lwwturwysz/
         W+A6cyZX1EkNtENH+nO7c+UFBnbnUT0eQYce2MmvlKI0UK0CIq2zXJfNEJT/28l2hsSV
         vj5VRY87Vzdl40cvqc136N3T5YiaNvJL1wrQ3Mt02HL6tB1vmbJblg28XyxmXzUin7ES
         zqGps6NMQUbkRN/ePbMJKKet+oR19en+wKXyOek8V/xF6pavuxhUZf6WQrd8XvKf6jW9
         P0rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411995; x=1795016795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i7mcrqf7XWOgEb4YXjGMz5tqNzLFKqEiO04XvkJXxpY=;
        b=jSfFbW6VC67CVNhVajgcU8srNdDouOy29cnmzd3h4TFxMNAiC2lZ+RaoMVTQXtT72C
         MGGPtxMFw8gm1SHJXzM61XHun4iSDqiut6z5LEMDWu1hsAjG7n20ymhFMcOJAuh4oVrE
         xSHkuJJ4SSBFWafIAp5osZrvnwYL81VnfoCVjZRU8mvvfhBClNHvj4/JBbNI7en7aLIU
         IY6nlwhcqaKmBlFygbGumBiV/HVYp2zHhFhVXucqSNW2Kp5KTd9B+479kapbJs0P/Yhj
         cbOvG1Jy/eIjQ/fvAGrtWVsexYeIgN7Q5nWz2dpkwat/zeJLjAo3arrK/iFNzimCV7Yl
         40GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411995; x=1795016795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7mcrqf7XWOgEb4YXjGMz5tqNzLFKqEiO04XvkJXxpY=;
        b=C/EUtFFqLFvchl4KNoGH05JET4rsRJH27y+etBtrQmA8IlQ3gQ+2e/Ty30LFxjIbV0
         gkPzIutEkOhIQAPdm5AM8sVyycLGawcd89rAYaNSisup8N45VwEY6syFKGCimwctLVz6
         rO4lD9ZDvronM1QMevUrphCjrdAt10C/AbzI6UBHTqyNHAPGY9KvcnqnCQVCyZ1Eisfm
         +JMiEVhJsh7XwePe85KfgqQjTwmODzp97ymDoCbJ9G9cXavgIpPYsZfG/TIdhHGPHc/h
         LTm19Qfoyb0GsZe+/YRrlRw2ndpvwegJN5qNQnv6FXSoZGnec0VRxf5y3RDsvjZLLvVO
         BrkA==
X-Forwarded-Encrypted: i=1; AL+hErG5qzO7ZbBM6tVxj3vg2jrB4CTrL4gByHoT4YUQmu6vedwqdzLcAEJiQC51IID8Z6TxHEaL/N8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BZZrJddZR+hBCJxXb244KnVx8tIR9vZnr2wIqUj9ag9lGySGm
	vSx0g5Ql+zS9wWQjIiy7vqVm8Ot3od1BinA42GnE7hdGLxqZylgJQv7orBqubrd8IbyLF9DFLkl
	G9HCLRXNh8/QlAXZk5q3iEBYg1C/MlMs=
X-Gm-Gg: AYBFou0kW45oocQaQIk3fi5RmYc8xrJSzDMNhCcc0b4QF5+Z+KN8Dd2EUAPjEcHAhM3
	ZHSq58iNY4XMDgPMXdcNK3JFt/yW8y1KSc9vX3BfJF9srpr+UcJx0XEc9848b1F4ZO4b8K+6oLw
	NcvjgmfMHB+fZUap8iqdqk6SMHz871IiIVtoOhffIGPZYqNqJGMo1BdUEp7MFPEBM6G6yt7ofw5
	hSjbHXZbTlMoAXGoj+2cMz3/o7Xi9RrPh+N9tND+nGGRSOnxRS7BOqTSjUy7t/ywBPD3fwdNI0Y
	ILN9F4OGAhgOGb95Gd03CSOebapbMYU1cP3D/I+OA/rdFtzwJkgZ+Z31fySczgphFWor8kikUrK
	agCoq5eD0wlPlSkFCY2JfKW4cH+k4ezLS62bRKX6yni472zTgKctSimUDDCx4LxPhdI6/1w==
X-Received: by 2002:a05:6402:1f49:b0:6b5:9714:dea8 with SMTP id
 4fb4d7f45d1cf-6b77782dfaamr2361925a12.45.1794411995161; Wed, 11 Nov 2026
 07:46:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109021611.22247-1-hui.zhu@linux.dev>
In-Reply-To: <20261109021611.22247-1-hui.zhu@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 11 Nov 2026 23:45:58 +0800
X-Gm-Features: AclHuK8H6vMQ9aNXuQur-lybZMeytisFbQmvaLjndZEn1wQmQOwgFWQhFSvLZ9c
Message-ID: <CAMgjq7BwQg8b+v18c7efqspDRFFEnuF7K=eVdi1r+MWjG2pkWA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/mglru: fix a no-op lru_gen_clear_refs() call in lru_lazyfree()
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:16=E2=80=AFAM Hui Zhu <hui.zhu@linux.dev> wrote:
>
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
>
> Fixes: cc8ec7be78ff ("mm/mglru: optimize deactivation")
> Cc: stable@vger.kernel.org
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
> Changelog:
> v3:
> Add Cc: stable@vger.kernel.org and pick up Barry's Reviewed-by.
> No code change compared to v2.
> Per the thread discussion, the __lru_gen_clear_refs() refactor will be
> sent as a separate cleanup after this fix lands.
> v2:
> Call lru_gen_clear_refs() before lruvec_del_folio() instead of
> open-coding the flag clears; drop the lru_gen_enabled() branch and
> the comment (Barry Song).
>
>  mm/folio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/folio.c b/mm/folio.c
> index 35e242b48870b..ea3adb6a89d75 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c
> @@ -597,12 +597,10 @@ static void lru_lazyfree(struct lruvec *lruvec, str=
uct folio *folio)
>             folio_test_swapcache(folio) || folio_test_unevictable(folio))
>                 return;
>
> +       lru_gen_clear_refs(folio);
>         lruvec_del_folio(lruvec, folio);
>         folio_clear_active(folio);
> -       if (lru_gen_enabled())
> -               lru_gen_clear_refs(folio);
> -       else
> -               folio_clear_referenced(folio);
> +       folio_clear_referenced(folio);
>         /*
>          * Lazyfree folios are clean anonymous folios.  They have
>          * the swapbacked flag cleared, to distinguish them from normal
> --
> 2.43.0

Reviewed-by: Kairui Song <kasong@tencent.com>
