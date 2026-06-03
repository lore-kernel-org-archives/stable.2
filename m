Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF433DF017
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519897; cv=pass; b=WzrPJo+Ley49QJeqn8NmDQtBckZabhJIS34jBeiFhQsXKB5CgwQ5w8wLm6vCOBPeeabPwP74DN5u3s2Kym9JXrVZXjo5+oJiclPFBgXj3MgATs3lsvz+59XN+UiJsYiupoVgvoOZEMlA/VYsPLBqTilfIRLsL2L1015wzvo042E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519897; c=relaxed/simple;
	bh=faanJKe8rIUqjysBcTbPF8u9knLNhZ6mBd4V8VpbAPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbWPnb4XgzZRAYfoiJUvBKI4yETuu6qY8DDGsI80ynJr9TmjB6DA43Z/fN2wp8dxbMeB+kI8y6Bu5nf4OxOzitxXVy3IYl2Gt0O9mKooPaXsp0I0e/jWnIhWtFRpcWaFmN+sy2a6nI/m41+SdA3civsih01cNyCvW6s8CJAbBsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD8QRV55; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD8QRV55"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69dc2c38f6dso5702eaf.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 13:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780519895; cv=none;
        d=google.com; s=arc-20240605;
        b=auK8Qkd5RRHns4LkCSSHWPED3j1jkj56M8mcCXUYPHmP9JUS20fKqOBejJYEUtyWzv
         E9u6h2R8kigZ4XVfp3RUvmp+VwBgTw6BmD0gcY8Oj+leka71Ak6MrurnKrURSCcGrg0z
         mkDPHUmTo+RRYayC1lg/VUQ5ukU5V8ac/dP4K6tNXE33ScwY5VjG3fH8Se+fGupdlo/9
         Tip7nL/3rWC3s5sYY/ndDQfHXl/4dQsTezzKMafTTVrBFGXOGIi7POOmFDXMzB/np4Dp
         aa/ibB1zrZzTaVpqtRRxhV9EC9pi8v12tZSoD9Yh3aj3eFvAamMQ3oR1R1nWB1mTQhRw
         uDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hTxm6EsNp3ZZn91hRFR6ginSU70UVDxdZM5vbNNjfA=;
        fh=T/cLFrInWDVcTIUps/tGDGWLJLW9hE1qoBFa0KhDNms=;
        b=fDfVgTLMR83iJTijMnAMjnZumzsfNVV8Al7sjcW3LLMP+VPQZuVLA+Zyv0m5WYhH/2
         1nu9pudbfTgQ9wiAnRi920CUkO2qGDB3ALbAvfW6bdmyaczZ0e+Ccv2BM6dzJOjQgPPh
         LIOKlCCfXFy/gEIZJQKU5dKc9cWldA6TnWwRI5nALBjH5SrR8a5/vD/UFLK9osF2fwr9
         BKV9JsN4a+ajPQ6Gt3nxfujRUabLE3ghP9akj09wxXyN+x8Lp3wx2fp7Dm/qoFb5qxkV
         xzcSHGXmZzzPKnIQTaYZFE4yFrwbmZcxfOdAVgjr9P7TjIFuxrt4jjj0FJkZtOKrTPzV
         wy5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519895; x=1781124695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hTxm6EsNp3ZZn91hRFR6ginSU70UVDxdZM5vbNNjfA=;
        b=gD8QRV55aLRAF/6iD1e1J2Sq1ftAVREq7/Kw621ncxG5fVrDs1U2lDaDFREfL0KIY9
         ucs12QzLf5jIQA0QQDo6/EwwWBAE7mZXlP+KYHQX8bQRwhGCkclI2JvUij2KMUfAHEkd
         7x9hbux6gES20tH40N1wTkIthbwC02LiySkTwlb9MVzNkKawQM4NuhxmMXlY70fBv9pf
         8sbt+Bdhl0qxNKCQHy1qyf8Rhvve9LYu0eLcUiPvKRvonrYWtGxTSj9eKFtmM+5qOoZK
         5DyaOx3CDB2Ve+M57nmKk1KXuB2iY1WYEtmfyAIWYcwH45XOHxjEASjyOYhRpUyhig8v
         zTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519895; x=1781124695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hTxm6EsNp3ZZn91hRFR6ginSU70UVDxdZM5vbNNjfA=;
        b=IWGKPfg+dbXXFAirg2giSw/B27aky20lIrL+Im+cXDNvNQX2d2BVBIthCHm+wzDb6c
         NDxINHL3tWZVn1fR8fluKyp20WmRajJDgattqvG2yxplxgkVXKBTIRDx85+RPmpPpg3D
         rCovOPBQYJj9hvrNJJxq9Uc7wwy+7z1Hu/DRmxvZ0wP0P7kh6v2X62wCwy55UAdnRjio
         QZsIecokK5OB2QM9ErzcC/bxFSzNejUxHTDa3xU9UNX3kx7sllo0dxXv0CNWFUR0uNvk
         50cKHOB3T4c5zDSJfTBginIcHKrzGqN41kUJtMpuMTUIDCr4IhadIqlEDVlp8TcAzF7M
         A2bA==
X-Forwarded-Encrypted: i=1; AFNElJ9M3pV5WkqN/IsdBwrk+AhJhsqKoTfP5ZmnocJdgR0rhy95nWUy+MPdgkIEXJlp2t/fNXBRU6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wod32FLo2buqgBMqgw/Pxp/FpweJSkNYYSNqu9+Z7DClbjDS
	RVj5LeZ7SoTw2NfXMzrr8EMrJ5wckrbDHHt55N3Y73kzUXA76LfJMWTdACV0bYK35ufuXG3Qez6
	qWDcSPt4YGHv5ROwRRVXKxzXEdYJ321k=
X-Gm-Gg: Acq92OGXGoqSSnDfOFMlhf2OILkVmzcG5Gi9vc3OJ6oSbDkTzC5j1SnZk1bo63Qe1H7
	JMuw59XqVJElOGvQE2J6f9IcqUjPQ8gYQh7EAQHSw70dpIN1pyBwNxDQKdy89TfeXOJ8ihnC+4P
	ghiqnUsLKo7xjAQ/dElmVguldMsh0kdGK16vOjEPPUqdGQRJXOzDv3bL/NWVezPHTsdGfWFWirm
	I9HZeBGVXgfpyU1DYUS7ArIxRBu/exzLROljGbHyRvWNkZVkDsb9Rws3ObfZZlTYhricW7NEvuw
	XaIXH+opPUj5rWuBQamlmFEyxYOs3yJ2KIouJ+HRgw1/ATI0
X-Received: by 2002:a4a:db45:0:b0:69e:14a:f30f with SMTP id
 006d021491bc7-69e4809197amr2037947eaf.41.1780519894809; Wed, 03 Jun 2026
 13:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602222358.49061-1-devnexen@gmail.com> <CAMgjq7B5sSjJPG7bMyEf0=c-W9heiPL6SQsedicyp8ahXWrYPA@mail.gmail.com>
In-Reply-To: <CAMgjq7B5sSjJPG7bMyEf0=c-W9heiPL6SQsedicyp8ahXWrYPA@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 3 Jun 2026 21:51:23 +0100
X-Gm-Features: AVHnY4KZMwp3hNbhdoqPob52kWdksNuiEmIpeP5tzG-_RR9C6TEd2POiAAL4W6k
Message-ID: <CA+XhMqwwXCaOBc2a7umw1EPKPX-Nz8vJgwdYL1VDp5r=_zs7=A@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: free the cluster extend table on teardown
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+deedf22929084640666f@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jun 2026 at 03:42, Kairui Song <ryncsn@gmail.com> wrote:
>
> On Wed, Jun 3, 2026 at 6:27=E2=80=AFAM David Carlier <devnexen@gmail.com>=
 wrote:
> >
> > swap_cluster_free_table() frees every per-cluster side table but
> > ci->extend_table. That table is only released by
> > swap_extend_table_try_free(), which the teardown path never calls, so a
> > cluster can be freed with an extend table still attached.
> >
> > It can also linger while the cluster is live. swap_dup_entries_cluster(=
)
> > drops the lock to allocate an extend table when a slot reaches
> > SWP_TB_COUNT_MAX - 1, then retries. If the count dropped in the meantim=
e,
> > the retry takes the normal path and leaves the table behind, all entrie=
s
> > zero; only the failure path frees it.
> >
> > Since a swap_cluster_info is reused in place and swap_extend_table_allo=
c()
> > skips allocation when ci->extend_table is set, the next user of the
> > cluster inherits the stale table and its leftover counts, corrupting th=
e
> > swap count of any slot that overflows. CONFIG_DEBUG_VM catches the
>
> There won't be a corruption, extend_table is all zero at this point,
> the leak on swapoff is real though.
>
> > dangling table in swap_cluster_assert_empty(); otherwise it is silent.
> >
> > Free it in swap_cluster_free_table(), and also on the
> > swap_dup_entries_cluster() success path to match the failure path.
> >
> > Reported-by: syzbot+deedf22929084640666f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Ddeedf22929084640666f
> > Fixes: 0d6af9bcf383 ("mm, swap: use the swap table to track the swap co=
unt")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  mm/swapfile.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 615d90867111..a69a26aec4c0 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -432,6 +432,9 @@ static void swap_cluster_free_table(struct swap_clu=
ster_info *ci)
> >         ci->zero_bitmap =3D NULL;
> >  #endif
> >
> > +       kfree(ci->extend_table);
> > +       ci->extend_table =3D NULL;
> > +
>
> Still a bit too late to avoid the WARN? The WARN is already triggered
> at this point, swap_cluster_free_table is called after
> swap_cluster_assert_empty.
>
> >         table =3D (struct swap_table *)rcu_access_pointer(ci->table);
> >         if (!table)
> >                 return;
> > @@ -1711,6 +1714,7 @@ static int swap_dup_entries_cluster(struct swap_i=
nfo_struct *si,
> >                         goto failed;
> >                 }
> >         } while (++ci_off < ci_end);
> > +       swap_extend_table_try_free(ci);
> >         swap_cluster_unlock(ci);
> >         return 0;
> >  failed:
> > --
> > 2.53.0
>
> I think we have already fixed this?
> https://lore.kernel.org/all/6a1eac8e.fbc46276.3c3783.0008.GAE@google.com/=
T/


 Thanks for the review.

  Agreed on all counts. 0475fde0f68d already addresses both the warning
  and the swapoff leak at the allocation site, so this patch is
  redundant. Please drop it.

  Andrew, you're right that no cc:stable was warranted here.

Cheers.
