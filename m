Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793426108;
	b=M0rhNIbiSgMlmlzrJQWxDIivlbgMsBUWr8+Si//F0zuHNGUt61MROxYIgEraxHbzK4vO
	 6GqTYSXZZVIksadS86V6kXwfUuNUC2PqCw2OP2pNSuXUkfMfojcdYItD7RuX6FecqoLml
	 0c0aJsPAlU8AToETKI2nlw/K8cF68rS8nfVipOZ2D4uu5Rr13AZx8+trH9tYWk3+yZkuk
	 jmRV0Ju+md9hMjhHKehN7W3M9/wPSmFGkPa6xWbhWrGvcwBuxnyaahOl80MhODyoNkwvm
	 TKmuTVmoAWDi0AdXu+28JxQYsR606P3xgE682JIj2+ikHOHwNb5XIGc/yj16oCKVLpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793426108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mCgjURrKo6HedSLNTmVowrdbKxaGNL1I2PpeVk6fWxc=;
	b=F8bxNaaIXfKr0WVbbK6Q8SJ8npwDHKkjM+Kx208VwmWOx4+/OnnVZJ0wt5AJUSRKrTO5
	 2Cn3ndscG4Xfn4IgaJ7eJDILy1Bf1/9CzXyE2SYgrD51atmQkklhLoelC19xMNhWKbEii
	 qnnLzRDBposNOUdWBxUWwnNyieegoY8FriMM0io79ORTydFrfm7cKgKnDH3Wq/P+PcDUA
	 d2bhIp2QMTqhS3DaxuQuaj/IyQ9wIBOxShkL2SnFkGzznRzVMYIZ/tgdN2EzruZd2Zl9z
	 s+8ctnTOXGMmj85eB8fihiVqmz05uCJxziqplnJjqJQT2kLaREXrlV9P0c3YmmFvN4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xV7PJY0o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3D606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 05:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F3D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xV7PJY0o
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4395d31228so207513366b.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 22:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793426106; cv=none;
        d=google.com; s=arc-20260327;
        b=WamHzdjs3/oJWHRAgeWypstArPfXWTczWYooqVgcEn5CkeKE9MNfAfmxyWspqTj3zW
         lEVy2+8qe9ekuQsp7yP6jqhC7zOPf+L8jrcgzQ/lnLIrXhpPoa5QQTtgEWsdpSBHQdWB
         WvFVMZrFj4dFM41oAk7M1+7yhVww4vm5VhozW5ZpwDKzG2e2stb3E/k1cd6vTbN+dE+E
         UCDatdiYg3GogFHj15ua5ttqWpvf2Nf5nCSRPmbhkzh3/erTogYrO59M0BO3+0UtExNj
         21SH3awqIBR4W5QdPOXuUhuv+PQZkzcPQRtvoF/Kl3a0nQk7PfafT0EmH0KfyHmmA7qf
         88og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCgjURrKo6HedSLNTmVowrdbKxaGNL1I2PpeVk6fWxc=;
        fh=Dcybic+5/TL9o0JIg3iv6lrId8folIYtRBqLzBYArOk=;
        b=A+mCaZEYoEEUsIQ9aJ5XPYqmld9hFGoi0l1NBlE1bUC4sTTn3E9psNXS06vGe7rfec
         kZY/8jKui4dLUjlaep9tv9T46ySWdId+kouOMATDu7kUgdHXTgTeH06IcGp/0gz3t356
         i4RAxaLwxJK0CS7uMasFVP3Xj3lAzCyRLhouHuIDqS9MMwPHNDeQ4nOvAyW3z1haVt0B
         k8Zcg2MjivIvoq6/kwBWc2q3m8OZlRts83fCuYpYco1MxGglI4X1yFQj1wa1j/18Bmnu
         QtHctK+6yrWZhWKE3xOEWmP1NrdSZQFuxWvSddgJrjqHXFrjD6tnhItE+6a5e2TqRCn4
         bAQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793426106; x=1794030906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mCgjURrKo6HedSLNTmVowrdbKxaGNL1I2PpeVk6fWxc=;
        b=xV7PJY0oSGo3+Jmw5WWOaPc0jhDEJMKkRV+2fYmDaQsyVjcNO2rT+mEUN8CPQGwZ+H
         SLvGGuMp5UAfvdn+TSsSNDMpC3NmqwB27qotDk8PQa+gO/e7Ho0aAkfftj2Pr4xi18Bw
         JX2i1FOODLAERxdXq4lYYCkEsIJKkSluqSNtB73P6ppguZRZ9aDrmFcz34t6VjlN2b9N
         8iuYGEdmx5wx1ud7ElRWy4zsm5l1riG9HFw3df7bGHTAbltFEhxj/K1Aj19iKRLb01p1
         /TvVbnnhJjmBC7gckFQrrelkB8mV4VAyPEA2V64ci+1wZs+/7a4pW7AEutEKtBOm/MwF
         FHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793426106; x=1794030906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mCgjURrKo6HedSLNTmVowrdbKxaGNL1I2PpeVk6fWxc=;
        b=YGHTHWHZAD/BZStHWQTymFyQ5eT1eiP3T4cF+CJV/G2krw3/WKEHd20RwlBjLhf6by
         Eu3qSKMzJBISrh+zK+ylHn9GPFpJp10EsLRM6TlXp2vBHLzQVMK8OEUZ1npxx5A/NVtq
         htx9gTbRB5BytdVNRqo3L0cLc51BHwSnL+qqgZlIkxLy8PBeh2/rQC7Cfzk2nRONf1GC
         /LN1vun2RC+NQ49HVYgIP6x8gd47hmvLD0FQ2+9zIT4nxJI7m1sEM7DCcNl6/Xz24O5f
         GHnT6k/6E3AaMGcwVdluIOv2i8rUBvlotUHodlvSPZ32W699dUuLMHHpLR5CvU3WXWUb
         w/jA==
X-Forwarded-Encrypted: i=1; AKwUvBwwSr6V+vKUweAwsJjKxvETuHZRmPy8WuCjlAuoQ/4UWW7dAfbvXmFJpp807+3KXeDhs0tfSMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnrB2ZIyUS3Z1OFzb/dIqX4ydQbiOR+K/TOx6zwLXWIM8oZVM0
	QjY309id4uYZZBLN1IuWh9EdkhXycvYUg2Uw7avSw5zkDJHLYl/1ai+LY+KGLv/FJryZLNFw4h/
	Er1xWYWSBV2Y0M6U+kloZd8BbAKFQHEQ=
X-Gm-Gg: AYBFou30JBRuyXVFsDhjuHT/cd/X2aXA5mVTE+ED8Q7E1vih9II7Dm0qpoBZJVuc9qh
	MkcMSVPe3z3KThge5cJ8qmc9YGw/bO3xPyUXPh978ko77JLnZqWJ/Pk4ysC924KyHLaEN3aloQL
	G9CjfpZjTuTb+xgVfwRo7qdRVCCslCHA7exPQyIiIez44wIaHbl/XK0xzK8OED1j4slH+j7DR1r
	Q1j3AQ5zLG05qbVOuQfF87eusc8R3rryc/c6rOyndoa01x7Bq7IY317LO9cwVo0UC2+9s/mQdJi
	Su63FpacIalsf6C0xYhIn951d9b/IzXDz8sEBCkHpYH7g7icsNXIY3jwpg6Cez5boAfElJhIEmr
	ndT/uT7n3CgCr8fX1v5iYABvi8vVc22ksc2YfjUOzq3bPmDLOK2L54KtRNfRFBC3u8yKUS54=
X-Received: by 2002:a17:907:2d25:b0:c41:1e13:8896 with SMTP id
 a640c23a62f3a-c4ca7a7586fmr378054666b.28.1793426106050; Fri, 30 Oct 2026
 22:55:06 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
In-Reply-To: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 31 Oct 2026 13:54:29 +0800
X-Gm-Features: AclHuK-xDhrqISf5wq7z_z32la-j7uMJ_BSTSk-mqM8zIBPegNWP5UzqHeqNVC0
Message-ID: <CAMgjq7CwaE1Fmdz1Edm60HVyqSWWpFrUo0n5GZFdJoCZUbhKbA@mail.gmail.com>
Subject: Re: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in unuse_pte()
To: mt4022@columbia.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 3:12=E2=80=AFAM Mani Tofigh via B4 Relay
<devnull+mt4022.columbia.edu@kernel.org> wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
> for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range into
> one large folio in the swap cache.  The folio only becomes anon once
> do_swap_page() maps all of it, so if the faulting PTE changes in the
> meantime the folio stays in the swap cache while not being mapped or
> anon:
>
>   Task A (fault)                       Task B
>   do_swap_page()
>     /* swaps in large folio F */
>                                        madvise(MADV_DONTNEED)
>                                          /* zaps the faulting PTE */
>     /* PTE changed (F not mapped) */
>
> swapoff then maps it, which marks all of its pages as mapped and
> exclusive, and the next fault on one of the other PTEs crashes in
> do_swap_page():
>
>   [    6.424485] kernel BUG at mm/memory.c:5195!

So what's being triggered here is this right?
BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));

That check is a bit overkill to be a BUG I think, and we have been trying
to remove unnecessary kernel panics. Before f1879e8a0c60 we can occasionall=
y
see large folios got stuck in swap cache and partially mapped (e.g. failed
writeback, see activate_locked: in vmscan.c, much less likely but still
occurs from time to time), but the ones still referenced by swap PTEs don't
have PAE set so we are good.

Now the problem here is unuse_pte() calls folio_add_new_anon_rmap()
while only one sub PTE is mapped.  So yeah, that's a problem.
Still it doesn't have to panic the kernel though.

>   [    6.424503] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   [    6.427654] CPU: 0 UID: 0 PID: 67 Comm: swapmthp Tainted: G        W=
            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>   [    6.432665] RIP: 0010:do_swap_page+0x24eb/0x2fa0
>   [    6.451035] Call Trace:
>   [    6.451567]  <TASK>
>   [    6.453841]  __handle_mm_fault+0x13b5/0x3b40
>   [    6.458525]  handle_mm_fault+0x16f/0x480
>   [    6.461143]  do_user_addr_fault+0x312/0xa30
>   [    6.462044]  exc_page_fault+0x66/0xc0
>   [    6.462846]  asm_exc_page_fault+0x26/0x30
>   [    6.476708]  </TASK>
>
> do_swap_page() already drops such a folio from the swap cache when it
> can't map all of it.  Do the same in unuse_pte() so that swapoff swaps
> the entries in again.  With the fix, nothing is reported.
>
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within a second.

Great working catching this!

>
> Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_=
SYNCHRONOUS_IO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> This conflicts in context with patch 41/47 of David's v2 series [1],
> which changes the line right below in unuse_pte() for KSM folios.  I
> can rebase on top of it once it's applied if needed.
>
> [1] https://lore.kernel.org/all/20261029-fixes_core-v2-41-a64ce7f83abb@ke=
rnel.org/
>
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/sw=
apmthp.c
> ---
>  mm/swapfile.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 189f04d8838f..b0b75ff16835 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2518,6 +2518,18 @@ static int unuse_pte(struct vm_area_struct *vma, p=
md_t *pmd,
>         if (!folio_matches_swap_entry(folio, entry))
>                 return 0;
>
> +       /*
> +        * A large folio that is not anon yet was swapped in by a page fa=
ult
> +        * that did not map it (yet). It can only be mapped as a whole, b=
y
> +        * do_swap_page(). Drop it from the swap cache and swap in small
> +        * folios instead.
> +        */
> +       if (unlikely(folio_test_large(folio) && !folio_test_anon(folio)))=
 {
> +               if (!WARN_ON_ONCE(folio_test_dirty(folio)))
> +                       swap_cache_del_folio(folio);
> +               return 0;
> +       }

Force dropping a large folio for any swapoff doesn't seems very
reasonable.. We really should reuse the common large swapin code between
unuse_pte and the ordinary fault processing code, and there has been quite
some patches just for unuse_pte just because its out of sync with
do_swap_page.

But, having this fix first and backport for stable looks good to me, clean
up and improvement can come later and I'm trying to properly split the
folios when the PTE backing it is partially gone during swapin, that seems
much more reasonable.

Introducing a helper to avoid code duplication from this fix is also a
good idea.
