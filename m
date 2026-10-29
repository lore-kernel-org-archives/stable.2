Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308570;
	b=mh+xXA84/kbDWcDXND7n5G337MXOyOl5dGzmbjwVmjcHHjSZvuuOC4jMp8KFjrPGOUUi
	 YVmXlNSCiWB9J9OHIZbvLd5q02iUgE+cgJwehW8/F18+x6cN/g5eco92No8BJOi0lNX03
	 BtApTJZ9SvbWN2Ja4zxYM7y/rGEYl25TxFQWpXT8D1xvc0d6dpJFZPhbL8lK1lITmulFK
	 iMhLTpIOQCVRdj6VWRmFDl42J/Z/k0lmWD8hzQUXOEhqni5uHRA2nSV0DKi27XpimtkH8
	 QsCPsrUGP/lO2HCeb2qAxlusBtL2Jo0Ek2SShuFXSX45KXLqzCZOKNfEq2L4sfHIXrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308570;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7HPc+rMGPZrFziNDFBiRAZO+y0q2SHxYTSQY6vu6qns=;
	b=5Lk8ylOrRa7UpO1xa3XdvgaEVnC7sTUDD5nFqeZGHTcIPPFRpu6KT1+G/pJQzXsfos1H
	 x7R5SRrmZ5Kojlx5P7VElz1vBNt3X5HFOl9mcWogI+lojQOnGwSeeUIjP2UFUarS4LYno
	 t4AtzxZnBLBXhCr1YShgcorp6qcr6f5SmWju91DJTUPYANXH/zUHRKuuSNoQZtpLTaPlE
	 yoPTAkNV+ngE0/MBDtDLvpFiVd1AsGFVS+ZMV3LSkvCHzswHRi+k8jfOEkmCW96YeKfwu
	 vYAlKBUyWqcVE23yJ3iLbG3renPSFbK1rkWITlLtczB0QV5Y168ctbs32292ElKY5NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjDnZcPZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3E606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjDnZcPZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3601F01824
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793308569;
	bh=7HPc+rMGPZrFziNDFBiRAZO+y0q2SHxYTSQY6vu6qns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PjDnZcPZxZwSTafleHkQ33qoE1Iuzoz2P4Lz8aFvP1ktGboBUmwwCpmJod7gkifqi
	 UPVZRyMr1VAJqQMrSBjmm/PpoYC95+h2DT0sPQseKt9K2skglmTtJIeHDZrDqYsFql
	 DJi6xLqFr6KOzLghr4zOFoVaTFJw4WKbB5tEiITuISFC5NPqCFMEUZTBWlmzEvTY2L
	 zOKT9TJS9GCHwlzdz3OQ/FM2PwUfSAPwjB3tMt2V13N7Usm7MWLdriZyz1+KphdaYf
	 WZ5Y2Q+Dth22arg1Sm1R0bs6PBrf7xW4y2619gL8G46/b6ycZKMSA9b+eZvuqbcRDA
	 KthZ/+i63KBGg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so14483a12.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:16:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByMJ1eYuoothkv+J++p9QlVEe0zTAFefuazThVBmT6NG4bCYRPLVPzg9ybHI4ZroeWUv2x7P6k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDsxPE3IMHWLs/1b7nALlSvE9dtwYcE8O4q0+eTrYbup6GShke
	5arWu04z4FFy2AbRVcwxz/CvsgLN4oHGJcOoPcp4Y3nksADCwoKf9EZYjATwdMOmJeXqkxcnI6/
	QnZVZJqpxmN3WJcYVrC2+srrVaxjYpCI=
X-Received: by 2002:a17:907:3d89:b0:c46:645f:cedf with SMTP id
 a640c23a62f3a-c4ca7a0708amr27430266b.15.1793308568498; Thu, 29 Oct 2026
 14:16:08 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com> <20261030-swap-fixes-v1-1-73f73a59f2fc@tencent.com>
In-Reply-To: <20261030-swap-fixes-v1-1-73f73a59f2fc@tencent.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 29 Oct 2026 14:15:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOwqiCzqGP_eh0Po+0cHSCLC-T1xoFqEo9bC0A2z9V-yw@mail.gmail.com>
X-Gm-Features: AclHuK_UcWeTFbGNfIrkG08As9JrhrqrnG737h-qpITyGjdoPDrLwmIQ1HgUGbk
Message-ID: <CAO9r8zOwqiCzqGP_eh0Po+0cHSCLC-T1xoFqEo9bC0A2z9V-yw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/zswap: drop the stale zswap entry of a zero folio
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Usama Arif <usamaarif642@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Mani Tofigh <mt4022@columbia.edu>, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:32=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> A folio can stay in the swap cache after zswap_store() has stored it,
> when a swapin fault gets a reference on it before reclaim can remove it.
> do_swap_page() maps an exclusive folio writable and, for a read fault,
> keeps it in the swap cache, so it can be modified and swapped out again
> to the same slot. zswap_store() handles this, it replaces the old entry,
> or drops it if the store fails or zswap got disabled, "otherwise,
> writeback could overwrite the new data in the swapfile".
>
> swap_writeout() does not get as far as zswap_store() if the folio is
> zero-filled now. It only sets the zero flag of the slot, and the zswap
> entry with the previous contents stays in the tree and on the LRU:
>
>   reclaim            fault              zswap shrinker
>   zswap_store(D1)
>                      swap cache hit,
>                      map, write zeroes
>   swap_writeout()
>     zero flag set
>   folio reclaimed
>                                         zswap_writeback_entry()
>                                           swap_cache_alloc_folio()
>                                           decompress D1, uptodate
>                      swap cache hit:
>                      maps D1
>
> Swapin looks at the zero flag first, but only when it has to read the
> folio. The folio that zswap writeback leaves in the swap cache is up to
> date as far as anybody can tell, so the process gets its old data back
> instead of the zeroes it has written, until that folio is reclaimed.
>
> Invalidate the zswap entries in the zero-filled case as well. The folio
> is locked and in the swap cache, which keeps zswap writeback away.
>
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap"=
)
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> [kasong@tencent.com: fix zswap_invalidate() arguments]
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
