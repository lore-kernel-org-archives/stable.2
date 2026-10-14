Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3579329E79
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007779; cv=none; b=lnVT6/3EzHUa+0xlEaT4n3TV2EMd4MqmI30pTKumFsQs5CryiQ71KUFEF1IKaULka1aijcMVyOVc1xhVGkK+4vUPuc3Ssjlm79NnqnTISGbuFzXeO+Mk5UyfWwJrEzbQGLEnrW1MNoDURfQZ14XrqUhUB32a/vcMF/GdbOBA9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007779; c=relaxed/simple;
	bh=5Ar0vHYezptJPwslRv/GvPNEVe7PUIqQxl7J0bC+V70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA0ErfiluzkNa871Gpa8f7r2Now4SzmsWEEGgTW4FZPnCA6Ff54Njojq9Vv3bjqc0JrjRkd0zOfmlVZAxb7f/MXaD9CSsm78yRB3pBhjmra+1GdR6ouoSb4B5D148WE8txpTDNdmdx46RWOvFxQ7gsNyQSpORKGK/4yPnFphuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+TzbS7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+TzbS7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D01F000CA
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007778;
	bh=JW6T2NVrNiSYii9ZuXsvqcqsrQBmXx3CI/QXZh1Cb9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j+TzbS7TpAFLQtfLh1lkHLvzP2ycFzBbTshh8XeQkiC0R1GGqa0kq70T3nMbVFMzz
	 oILQB6aIFUxczmdVLzPpj7turEsh1dfJMI0A3PgBTWCItPfWpYyQ9FeOv4H8Tj1nKF
	 qpPWqBmC3rG0WssOv0ncVsP8lIjSc8dSqQQ+45h9wEI2P+kCcrre0MsxEMbeD/CkmM
	 OnAFweOqTkmPylhDqjEE/AcaGeFGo/G3kzj20d9egHMLjDshpq5Wj27Yma4O1eaxWl
	 rr8EQuCuH747XSEGyO58H09Uz1Vut1iKzrVvi+DUKb0Zh6XzKavCGBD0HY/3HUBWpu
	 AAjADlI9hKP6g==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e706a6ba9so581299585a.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:56:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFTg294j4MtfnMuf46i87FuMGUzf7zDTj6qtINos+SdCZRdXtxnlDI1KJYryGdbxcYKRvcyTg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsVi6H3WmSnBlCBiYJvfK6fcjwAC4HkCdEUY0SZXlFuqlTS32c
	OMoMkME/BefvvOvGVaj7bePBKmo79bunnCuHr6xsrLUwMhn3Vvc6ft6SwYgl/jypvfdN7cBPx+F
	Ee1l5Sv1syqxow7Hnb1SJJAI8W94bdIw=
X-Received: by 2002:a05:620a:6405:b0:93d:e031:5ad with SMTP id
 af79cd13be357-93ebd224911mr2634160785a.17.1792007777727; Wed, 14 Oct 2026
 12:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-folio_pte_scan_range-v2-1-00cf9bbaa364@kernel.org>
In-Reply-To: <20261014-folio_pte_scan_range-v2-1-00cf9bbaa364@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Thu, 15 Oct 2026 03:56:05 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xMhtUWwZ1qCRkY=WjxwKGBTD-CSdQcp5jxcLW0WcMvFQ@mail.gmail.com>
X-Gm-Features: AclHuK95frzik0jnDRCFT7tNgkatocH5THJ5EMTKIH-IiD6HCFI8xOfwA0yawbE
Message-ID: <CAGsJ_4xMhtUWwZ1qCRkY=WjxwKGBTD-CSdQcp5jxcLW0WcMvFQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix address wraparound when scanning large folio PTEs
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 2:34=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> numa_rebuild_large_mapping() and do_swap_page() can be tricked into
> generating an address wraparound, crashing the kernel. All that's require=
d
> is to map a tail page of a large folio close enough to the start/end of
> the address space to e.g., make
>
>         unsigned long addr_start =3D addr - (nr << PAGE_SHIFT);
>
> to wrap around.
>
> Let's fix it by providing a better helper, folio_scan_range(), that
> takes care of staying within VMA and page table boundaries while
> handling possible wraparounds.
>
> There are some nasty details, like not being able to use pmd_addr_end()
> in this context. Add some helpful comments for these cases.
>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapca=
che")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Barry Song <baohua@kernel.org>
