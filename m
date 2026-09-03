Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03D41D4D6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470929; cv=none; b=I6ugCb+6tzmo7BpeaahY0dUKc/zBoq1DTjwuq41YGhoVK/9E4VVssxwcszqTHkA5hHSLf/J6/Ix9PReN6qHK7g15k4jY3Iql6eJbnM7Dy/mTg4xNO1yn/nmtwRXJauAYFcPQiaGZo6T00QY5U8BEw4knOCf4Syf50MSf4dPzgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470929; c=relaxed/simple;
	bh=k0UGZFBcM14tGAANtsBQoJQ41jp8M2g/X5OqTmiEaO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0pSvWy+eY+rQdpHUdDPNnN99ASjIET/PVCVwOzZk7deWqkHA+8q230bDiKluXgzXxcFSRC4D98zCOu4kH/ywRIM+zqzX5B+1u3f82WAxjIgbQawkuE5rWUJUL/mQF91omfXh8dMVghyn1wjH4lnCBApIJhJWKS7xjg1YHAqX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6LLObSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6LLObSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389141F01559
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 21:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788470928;
	bh=k0UGZFBcM14tGAANtsBQoJQ41jp8M2g/X5OqTmiEaO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i6LLObSLtGpatkgwi6KPh3eawDHXxEPmL9XWmOukud9xDMYe73W6TDF+yI+H6LDAV
	 HLKP3nZAkecCFDthJecFI4tVVADwf1Z6bEb9xHCOd1+VDsn+nPXBsut9flDwiOuEZt
	 5sS5Z9P3yoZ5erFjno9cpguThjpLJdTY8e2FCIzHE+IGurpKiaxiFaubgl8SSOMj03
	 Vdpj3IlfsDh0F5fNZJPMqNE6uIHA+ywXW55sWzy8pATHcrOn8Fu0O0SzjwrvoA/N+6
	 Rgs1DWr21E0kV33xsjs1BdaJx61raLLh+xSJ0gIux4qDhhYv4y2e9T9F8XcOiAfHlV
	 I2gahjG86Zxbg==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90e7fd978beso6401896d6.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 14:28:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwBXGsdmPH3m5uI24IKSoy0KV47FHbG3tX82qB7FPYoW7H+ixybVom2B/8ATIFUkmo/CW+DJTc=@vger.kernel.org
X-Gm-Message-State: AFuF++kwceHiVDkA69RVnJSWvNiQxEB+gqoj4V0/W/FO5yXv1vJrc1XH
	zCQZxcV2H/9KQIR4tb/VBn9uYy/+bgapJyxbSxyeWmdk+Zo14qX2UUHrnxJsfvr1oy9wAmhiNom
	ebm3HZLx26lXD7pQ09qnnkvPj/sRLRRw=
X-Received: by 2002:a05:620a:21c9:b0:939:597:e7af with SMTP id
 af79cd13be357-939804784a0mr126943385a.35.1788470927443; Thu, 03 Sep 2026
 14:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com> <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu>
In-Reply-To: <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu>
From: Barry Song <baohua@kernel.org>
Date: Fri, 4 Sep 2026 05:28:36 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
X-Gm-Features: AcwNN1UfF8fjF6Gm62yh0ikVnF99aXRfOugf7CCehE6ggJ06AxtYcFJ6rS-ls8g
Message-ID: <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Tal Zussman <tz2294@columbia.edu>
Cc: Wenjie Qi <qwjhust@gmail.com>, willy@infradead.org, jack@suse.cz, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, axboe@kernel.dk, 
	trond.myklebust@hammerspace.com, jaegeuk@kernel.org, chao@kernel.org, 
	qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 7:59=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> On 8/30/26 6:25 AM, Wenjie Qi wrote:
> > From: Wenjie Qi <qiwenjie@=E2=80=8Axiaomi.=E2=80=8Acom> Fault-around ca=
n map ready dropbehind
> > folios without going through the normal page-cache lookup that clears
> > dropbehind. A mapping represents a competing cached user, but writeback
> > completion can currently
> > ZjQcmQRYFpfptBannerStart
> > This Message Is From an External Sender
> > This message came from outside your organization.
> > ZjQcmQRYFpfptBannerEnd
> >
> > From: Wenjie Qi <qiwenjie@xiaomi.com>
> >
> > Fault-around can map ready dropbehind folios without going through the
> > normal page-cache lookup that clears dropbehind. A mapping represents a
> > competing cached user, but writeback completion can currently unmap tha=
t
> > folio. A later mmap access must then fault it back in.
> >
> > Retain mapped folios instead. For a mapped folio,
> > folio_unmap_invalidate() can call unmap_mapping_folio(), which takes
> > i_mmap_rwsem and may sleep. Retaining the folio also avoids this path w=
hen
> > folio_end_dropbehind() runs in non-preemptible task context.
> >
> > Unmapped dropbehind folios continue through the existing invalidation p=
ath.
> >
> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when wr=
iteback completes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> > ---
> > The mapped-plus-dropbehind state was reproduced in QEMU. The patched
> > kernel retained the mapped folio and continued to evict the unmapped
> > dontcache folio. I did not reproduce the sleeping-in-atomic warning and
> > am not aware of an existing report.
> >
>
> I was able to trigger the sleeping-while-atomic BUG on current mainline w=
ith
> some help from Claude. The reproducer itself is straightforward enough, b=
ut the
> configuration was a little finicky. The atomic context comes from using
> threadirqs so that virtblk_done() completes requests from the irq thread =
under
> local_bh_disable() and the vq spinlock with irqs off, so in_task() is tru=
e but
> the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so completion=
 stays
> in the irq thread rather than softirq) and ext4 -o dioread_lock (so end_i=
o runs
> inline instead of on a workqueue). With v4 applied the bug is gone, so:
>

Thanks, Tal. Then I'm getting quite confused. Since with Wenjie's
patch, we are no longer going to sleep for dropbehind in `filemap.c`,
do we still need all the complex logic in the block device and file
system layers to move dropbehind to a workqueue task context?

> Tested-by: Tal Zussman <tz2294@columbia.edu>
>

Thanks
Barry
