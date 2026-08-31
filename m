Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B743387585
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195134; cv=pass; b=A/2JN25RemVKe+fopVOINbgD0o0p33DCGBqQ9QQCavUeoIP6+MMyB9djmRFMMBgaHenpEL3U2HXU5XaalhIAmjsNrxGfspWd/j8iIqkBxTFDycZYwhIrDwEm+rSXWJCOMXziGBlV4SvT9GDy2fsauXfPdG+8ZvKvchFxPbFS4vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195134; c=relaxed/simple;
	bh=ZXciYJHRkksEQipZcqQCYJUB+kYIr6B9V7Na7gJA0HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Riw+F54T0SfB2e0FzbbiZ71fR9aKOXN4Lg+NUm8zeIXer662P+dlvzN0seSw2qzmohgm+J8JCvpBngssFhr5XZ1poVSMcXoOWHlCNOv4p0ZWynkbZSQoKfcobxZSDAB9omeokt4++QqDiWyp3B+tT02+YKmM+am2lV7jLPorlXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Te7jc4qm; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Te7jc4qm"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c160420289bso486925566b.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 09:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195131; cv=none;
        d=google.com; s=arc-20260327;
        b=TY+US9v+KXgpEVaenrIcqx3ZJwhi2xm58Qh3HuHWIScINS3I6kdnpnnsE3QoL9uXtH
         au+MYBBWvkuU4zpyT2M6LCv0WVx5zXe02Gwc0OtwnOZ/AGePB0lw1HynzUCUIDVUbBZg
         SvbVIgpGigrhxIZpHTRXqgsvOsyhH39NH9cwFNjRVYMETSFyj5aetAjZc7qyZPRapfpj
         CeqBUFMt65iPAXqZNdqDQ3wLX9PZGZo7r3YTfJyksm23msJ0NCTKQYR4W8g2O8SB0PhF
         gs68Jm3rHUSICGy4kFLOOn1CeF0LE09ytojOWRWbr1uMw31qRGTdbYNXs1b3TPcKciqA
         pXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmT8nUkVUuQb1uewm46Ud8rp0grLkwqQ5xMhiT5eYRU=;
        fh=il8uih1WxhthgKtP1XsdnKswvzuF5DJfpHYiW39ZH5k=;
        b=lDppmgB7YJIt+9fGTXaWGH+UN8ie8ZnH3A07Hn6Yi03vGchFsJguP4m/L+Zndya174
         oqs7SGb6nirqVOSGqOilvbpwq2HWCnZaMU8VxUUraj4Z9yR5pJ8z6XzgP1xyFeNbPS1u
         AbN3Wl2uE62JUmN+ZSzxeJfy59Hev0vcAPdwqaw9Ropd4X4hrqrKl4N5oiOeNWAuPVXy
         XS5VZ/o5gE583fF3Xzn2lVKzZkX2qqeOeNExcihfrwzGkRY4tI5ZSQNsFev7fkgVSXva
         z0CcQGQFsS938lRcE4xPZOCsQFUBrBZ/6/pLAsBZ3YWtKItFNMHbzP1a9eW9ldtNTOWY
         xUsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788195131; x=1788799931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmT8nUkVUuQb1uewm46Ud8rp0grLkwqQ5xMhiT5eYRU=;
        b=Te7jc4qmWDSjBHTDtseoMl/rZOEsG9EALonWXXCaOxIHfi3cNFqOZ3pvR95RoLbM+M
         F8dxsNqpn38BIPobl5nhD/b0E3/q2Iqa/3Mx47BM3cSGjKH2kzGCzKSdl1SUtxxRdnRy
         YOxpRa23H6Jqv4eQksr+TZtW8FUlqtt5Pd747NXBIUVBOxgcxHvsZ6Yog4hMzbbdVvSh
         P+M/vkoM2kEs/H9gquD4PhwwC/s6D0m4To0xQcDiAgAKO7Z0cBFGAHklG2N/6H8RRtms
         boyw/F3VDdgZaYW78qdLFAvECAwOQzeglOCNnpAfK93UVOhIZ75mBq22lE7luc0DpoFC
         8M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788195131; x=1788799931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmT8nUkVUuQb1uewm46Ud8rp0grLkwqQ5xMhiT5eYRU=;
        b=PVsCHJJBM4v6SPaXa58k5jsXko4GLGasPfdZZxGBY3BQI8YCwY+g0EQ1uQmC5jSmGy
         SZsqfKxaA6toaeWHJEJMKm9DMSe3EA9QJ3e2ACDx5POZGo+FaOXrSI3Rkig4ck2hh+nZ
         Pl0+qHvnVUCvEtrsGlIPMlnstKKlR4JQwgIpvh0y1FC12EQt4L/3o8kztS8DMc6a87Jh
         7mpTvMos3b9J/UPNz+frBSwTqOfiO8RW35cVtEJJhZkKBxQOUr4bUmdio1yOB50L+Tqo
         chFEAEhWQj7/SlDX3R0iHPVc3FaA5o9VOsZAGqLyUGGPpANAnnIwjgSdcvNj4q/vsnws
         swAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rokmb2g1+fxTegHuh1DxOVOzL5lLvSGENEFpv8mgwYCG3g5GNKlRp8324dnLw//aUn4mQJkBsw=@vger.kernel.org
X-Gm-Message-State: AFuF++mXl2mNzrruBjFgg1Et/ZNjIfPgvhyDk+6VzRUGKkoCYlxt3VqE
	KSdbBtqt3xqTZsPBzbHeK7uCVTcR9SnefFEcWsh5G4L3WIUDsyCk2D+A7w/vlDs/2Sb3sej/ibk
	IczOktADzcoN+M4nbviCkPybUC/KKJFUvUP++go9o
X-Gm-Gg: AR+sD13txZIfh2kHhLrwYcdfwlLu2ASzTiK2nmedNnjwHiX+Vegr1PnHuSAARysoLjd
	MSWvMnXFdx2AEsUBPinOYDQoaIHtfeIMYk7pLpDXboEB5sGSTKkKe4BTsVkcT0YKO6cLIIlIWY8
	GWl72faaTroQbuykEaZ4uqYVn6hW6J9eFkI0DuKlFapk0TBz0lQX7ePuMZAM63XbRBSBwkRrvPZ
	x5AjpFPZgLd0O6X0EestZPg7yI8R66UlSSMFNf/1FWaU9b9b7eO4eIVA+0dzktySPBFSEv5wF8y
	KDhgR/AjcHTqSZDDCLiTGZS6hAWWfXU3ZHmzEwkiSzjDmFZASiP/2V7tHuCDjtPHgFatcE040w/
	tn2DlYp3RhQAbRvdRYAtDUBGdA1vc4zaMOTuQmQJFQXLFFB9O1CUgGCfvQONsreUJLV2jqOGEkr
	hH3iH6o6DTPbVheg==
X-Received: by 2002:a17:907:3d08:b0:c20:1bc5:7002 with SMTP id
 a640c23a62f3a-c25b3bb9072mr147543066b.3.1788195129945; Mon, 31 Aug 2026
 09:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828094703.11081-1-lance.yang@linux.dev> <20260829052606.49470-1-lance.yang@linux.dev>
In-Reply-To: <20260829052606.49470-1-lance.yang@linux.dev>
From: James Houghton <jthoughton@google.com>
Date: Mon, 31 Aug 2026 09:51:33 -0700
X-Gm-Features: AcwNN1VQPBfCPfhwh_Qc0VZ9XU2d9ihnYQWNppXae9qOXp_k0rv-I5kwwTdHhjA
Message-ID: <CADrL8HW3=n8VqW+7YSb2kyhkHidNKGy32+2s7A0OfF+oYoAifg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Don't collapse uffd-minor-registered VMAs
To: Lance Yang <lance.yang@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: david@kernel.org, ljs@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	usama.arif@linux.dev, shy828301@gmail.com, zokeefe@google.com, 
	hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 10:26=E2=80=AFPM Lance Yang <lance.yang@linux.dev> =
wrote:
> >On Fri, Aug 28, 2026 at 12:50:04AM +0000, James Houghton wrote:
> >>If userspace implements post-copy live migration using userfaultfd mino=
r
> >>faults, this situation is currently possible:
> >>1. The VMA for guest memory is userfaultfd-minor-registered and nothing
> >>   is mapped in the page tables.
> >>2. A stale copy of a page is present in a naturally-aligned THP (from
> >>   pre-copy live migration).
> >>3. khugepaged collapses the mapping of the THP, installs a PMD.
>
> Ouch ... I missed this earlier. The problem is real, but this commit
> message describes the wrong trigger.
>
> Background khugepaged calls try_collapse_pte_mapped_thp() with
> install_pmd=3Dfalse, so it cannot install the PMD or trigger this
> sequence. MADV_COLLAPSE passes install_pmd=3Dtrue and installs the PMD.
>
> So the problem described here can only be triggered by MADV_COLLAPSE,
> whether it comes through madvise() or process_madvise(), no?

Oh yeah, you're right. In our downstream version, `install_pmd` is set
to true for the khugepaged collapse path; I missed that it was false
upstream. Sorry about that. :(

So we can definitely remove cc:stable, there is no bug here.

WRT the semantics of process_madvise(MADV_COLLAPSE) and normal
madvise(MADV_COLLAPSE), I think it makes sense to always disallow
collapsing of UFFD-minor VMAs, whether MADV_COLLAPSE comes from our
own process or another. UFFD-minor faults are intended to be resolved
only with UFFDIO_CONTINUE, and until someone asks for it, I don't
really see a need to make MADV_COLLAPSE actually work to resolve minor
faults. I don't think userspace can *rely* on MADV_COLLAPSE resolving
minor faults either.

Lance, Kiryl, let me know what you think.

Thanks!
