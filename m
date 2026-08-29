Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994F3A5E89
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965823; cv=pass; b=IRv+PjT1fELDnk0Zwly1echdnw4Ivod59cR+iwQKzjkpht1PqiohHghsn8q2vnVSwAmiHyomZZ5UmbTuWoymoXldN+E4fJIT5Ha7qYqvtpyxk2BzptxS+TgnnQqLZjfGTuNCAXTMQFVRfZvtmjvJmJ70wyXwaTTYQ4RVClZbw6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965823; c=relaxed/simple;
	bh=1mrl5vfsxPOcxX49j/Nr+QxRQPhhznHCQB+r9IYmE4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjVpFLPyzZnNz4T0osPus84zYi+GLW0q3MwEa6tbTtdSgomNnHbNN2V/m8TclE0SHCrd4pq4L4tdbrJ7mvyqM4HA+nBXQuxJzXT6PK/8V+l2PTlLToeZQGStR1Z+dsIULfbb/Gu6esMCp+nmifYg5MeOSglnGgr+qb8yyJq8pUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sKdAwxe+; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKdAwxe+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so221153266b.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 18:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787965817; cv=none;
        d=google.com; s=arc-20260327;
        b=aD2ZAH5XQphm2p1xdubelxcOxs6T5iHeMIeuH2V8thtac/vKUlQPH6++ehE+UKRVem
         qhRHKFeb5OhVJMhaf1++Q9RuEShs9FHAX12USPQbce1z7Xl2deUBanqBKVZYqwX0pZvg
         IqCL9EYWKKEJVjm1IhpDSbTmhJ++Y5IgrSpwChFIVi3fyF6g9Ip3TODF2I9F5uuFymAS
         NLBgFOfXSkYY0lGamwvUyW1uT2Syu47Bwg/n/qLtERi9YREBE/qmNZc0YCpoaBjsanv+
         h+bjEJsVTuFCpmhtDvFcL7yK7fDmdk3AES476deB5GRFiNy/WUClFPdF2GqE6RPIJJbe
         QJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LDkUuQMIHGGiLSZiYVg4s5IjnV+PlGExO2xnMcJB/98=;
        fh=P9NpIStKG18miU5Lr8XKpy1PzJan5bAplhMhSolnVSg=;
        b=C0z8M1lWzDSjme7Y4474bE8Z/mQhyISYZOfNcLUi+nOCOgSXOLH9h6866cq9mUa8TC
         jspb6eL1ItLLp0qwO2GN8n0t8FlBl4waEXMtwkFfdSa8lgr5h46ECGxzGJsXs3r/mqzO
         Buz6yGq/K9m9LRuGCmB9c1ZGu3PS49mUM9veP0dHNScEx6cKb6WySMXTPB5J7kNcRA9F
         n0mD1+88PnFn8XPdOGJSlLtwtrARmhtmszJcr2U49bfl+zIZAc+/DJ5HFY3PxfUH947h
         Ccwr8j4L61tXT/aV+PZ5Gnp/zMYo25MziUEo4Tu7Cn67DpDQRAlMc/2c7d7mm1iFdE2X
         3QDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787965817; x=1788570617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LDkUuQMIHGGiLSZiYVg4s5IjnV+PlGExO2xnMcJB/98=;
        b=sKdAwxe+TdDSUVtnEMTy34PjYuYffS21Gj1+W31yG6GX2bVQxLnJuEiAGvz8+QlL7h
         gDaRTGAxgD9odwoshYI5pQOS4wOv+bG/u9uAMckdXwEmSt/rP4qomh0jT0SlzhMmduh9
         5Vl1GP1v4srPUFBZlwNuA/okJPQDdVM523TJjPQtUELhc5QBAVlPmStuYcrL3NIfPG3L
         hPLo7wxOQ61536+Nr/buUYmj7LXAoCj+WWL9r+UR/AaY8Ts5YBvOsXTa9Rdpa8CUCKWh
         eZpIJJ6NPukZ4qlZd7C2Hzs8bMLoVa31L/NnOpqWyAtq3h3i8u/akFztvDj3mfIAlA1E
         h77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787965817; x=1788570617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDkUuQMIHGGiLSZiYVg4s5IjnV+PlGExO2xnMcJB/98=;
        b=YcbPR1gDFsfHCnjcbuHghL/kl6+DZdSMyS7YKyvZJy9IZuhw0v/kHaBi0XCLOMBMOJ
         X2WBPooUqABO0aBe5HPSa2rQdyUc1OvDkWU2eTE8Cr8w5k500Qk6Pug+KHQtlj17ynxa
         eHjUBJ5ut3w1GJWB4SsekRbVc92gC/1e3K4ngZugyTSEwA7r4xNXEe20mL44PVzf442b
         v8g5GTtXqoTrVkFuHR9ey3II3BG4oQ5uMvoU1/8zErIMA7PXrTda7PWMhpKkoQpvO/7v
         6znxU5qqYUv8jdxfzoCqZ0F5cf3b7BCYhnP0dicIvYzNG3v7RJ3KDWEhRG2sctRTYM8c
         5HGw==
X-Forwarded-Encrypted: i=1; AHgh+RpjPHfJjvwVISCaPjHwhDupESU8p8GoWAcAso2tBVou4axdGhdeIUGHnpPxO8HJ9uEk1zIstgc=@vger.kernel.org
X-Gm-Message-State: AFuF++ltCk5WeKgSBNdVwod1NulpK2K3hovRBxwKMIbVuA0y2hA/4xKL
	C04QeKkef6ChYzF7ydoTV/jrrAez+TH0criGOw2ewJhlT4zWi/a6sd0lKzvT4oh9KKDGMNCdvNd
	hCMJs/kMsO5aCP74BgeXRIv6AASXnwj9wo3q75MYX
X-Gm-Gg: AR+sD10Nd2WBtzEmS3VfbcVguhMDWWjezrm3nRfolyP23zHs8FGe+nS95uv1rJzV2ze
	xteX1zT2tey/maiwmCeRhKr1n9d4HUBO8/HvrWIQx8hE/BMjququU1Bm92Kca0W2GEX+sgOoiUU
	rrZvyjuinaU5WKTxgUOkbo5UW/vfUbMb6pir6KlrKguZj//MnOvOzy4YJ1hc5H/OSg9DCrq4dwv
	Fcr56nv7ZvzGhC3qrtVrjboKPDpq7+kyubU60LFl6V7igApuQA9RbwQa5wAdUoOmtKk1nIqxeqF
	EBJTq/eDMS5r7jn9XmFxKoVNvaHB8qRuHdjnqgMgiYxq6OjoKkfo/BfZUDBlFU4IYM+93bYLYhu
	jvrQih2LkyfUvrZTrqx4QJb7tiAofjpeKegMdeC1labcRrEeLObCFGQR/F1VVSQJ9l4qit6Rdrd
	/HGqDimiQnjkx9
X-Received: by 2002:a17:906:f592:b0:c25:d03:6794 with SMTP id
 a640c23a62f3a-c2557416218mr792240166b.16.1787965816803; Fri, 28 Aug 2026
 18:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828222640.1638457-1-jthoughton@google.com> <20260828173302.29778f1bf802a1db932778ad@linux-foundation.org>
In-Reply-To: <20260828173302.29778f1bf802a1db932778ad@linux-foundation.org>
From: James Houghton <jthoughton@google.com>
Date: Fri, 28 Aug 2026 18:09:39 -0700
X-Gm-Features: AcwNN1UYXr9aSh6ZJb7y7EO3U_vx_4UVQ4qPVOOoPdPKw3zhEMSrjR8DApQcQpU
Message-ID: <CADrL8HVzfEXgE9OQfULhe6wh1kMMOALsYuCNOUkgBqtzk_LUVg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/khugepaged: Don't install PMDs in
 uffd-minor-registered VMAs
To: Andrew Morton <akpm@linux-foundation.org>, Lance Yang <lance.yang@linux.dev>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, liam@infradead.org, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, Yang Shi <shy828301@gmail.com>, 
	zokeefe@google.com, hughd@google.com, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:33=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 28 Aug 2026 22:26:40 +0000 James Houghton <jthoughton@google.com>=
 wrote:
>
> > Userfaultfd minor faults provides userspace with the ability to manuall=
y
> > install PTEs with UFFDIO_CONTINUE. Right now, khugepaged collapse can
> > map holes in the VMA when a naturally-aligned THP is present without
> > explicit action from userspace.
> >
> > This is a problem, as it bypasses userfaultfd minor faults that
> > userspace is expecting to handle.
> >
> > If userspace implements post-copy live migration using userfaultfd mino=
r
> > faults, this situation is currently possible:
> > 1. The VMA for guest memory is userfaultfd-minor-registered and nothing
> >    is mapped in the page tables.
> > 2. A stale copy of a page is present in a naturally-aligned THP (from
> >    pre-copy live migration).
> > 3. khugepaged collapses the mapping of the THP, installs a PMD.
> > 4. The VM now has access to the stale contents =3D> VM is broken.
> > 5. After installing the correct contents, userspace attempts to map the
> >    page with UFFDIO_CONTINUE; it gets EEXIST, indicating that something
> >    unexpectedly mapped the page.
>
> Did I read somewhere that this it biting you in a real-life scenario?
> That would use useful info to spell out.
>
> Or is this a theoretical thing?

So far it is only theoretical (but please do keep reading). I caught
this while debugging a related, real problem.

The real problem was that userspace was doing MADV_COLLAPSE (*without*
userfaultfd registered) and assuming that page tables wouldn't be
created. This is of course incorrect, but for some reason we only
started hitting this after moving from a 6.6-based kernel to a
6.18-based kernel. I don't know what change caused this (most likely a
downstream change), but the real fix was for userspace to instead do
something like:
1. MADV_COLLAPSE (let's assume this must be done)
2. UFFD_REGISTER_MODE_MINOR
3. MADV_DONTNEED
and we're good to go, right? Wrong, in fact!

I noticed that there was indeed a circumstance where khugepaged could
create PMDs even when userfaultfd *was* registered, making the
userspace fix technically incomplete. That's what this patch fixes.

I haven't yet seen this in our production environment (as far as I am
aware, hence "theoretical"); we don't actually have that many VMs
running a userfaultfd-based live migration stack anymore though (maybe
tens of thousands).

I hope that extra context is helpful.

> > The naturally-aligned THP case is the only case where this is a problem=
.
> > khugepaged otherwise requires all PTEs to be present for
> > userfaultfd-registered VMAs (i.e., max none PTEs is 0), which is
> > correct. This check is essentially bypassed for naturally-aligned THPs.
> >
> > No changes are needed for file_backed_vma_is_retractable(), as zapping
> > PTEs is safe. Userspace must already handle cases where PTEs are zapped
> > without explicit action (e.g. due to reclaim).
> >
> > Fixes: 58ac9a8993a1 ("mm/khugepaged: attempt to map file/shmem-backed p=
te-mapped THPs by pmds")
> > Cc: <stable@vger.kernel.org> # 6.1
>
> From the changelog it isn't clear why a -stable backport is proposed?
> I assume the userspace-visible runtime effect is a rare and bogus
> -EEXIST from UFFDIO_CONTINUE?

Although this bug is likely pretty inconsequential (I'm not sure how
many users of userfaultfd minor faults there are), but rarely getting
EEXIST back when UFFDIO_CONTINUE is a userspace-visible bug that
doesn't really have a great workaround.

Because this bug essentially breaks userfaultfd minor faults,
*technically* live migration implemented with it can sometimes corrupt
guest memory, and the hypervisor (like QEMU, but QEMU doesn't use
minor faults) only learns about it after the fact, after we get EEXIST
back. IMO this is enough to backport the patch to stable. But if
others disagree, I don't really mind.

>
> > Suggested-by: Lance Yang <lance.yang@linux.dev>
> > Tested-by: Lance Yang <lance.yang@linux.dev>
>
> Wondering what Lance tested.  Was he able to reproduce the bug?

I assume he just re-ran my repro, but yeah I'm not sure, heh. Lance,
what did you test?

> Sashiko might have found another race in there:
>
>         https://sashiko.dev/#/patchset/20260828222640.1638457-1-jthoughto=
n@google.com

Let me get back to you on this. Best case, I'll send another
(separate) patch. :)
