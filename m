Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC686306D3F
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449338; cv=pass; b=X1VsBtHPoXO/rZNv4xPAygNSIzHU7ZB1TOvnD34YellU+go53z3x6G2Gp5CwVqhfslo7Hblj1kY3ZgwNJ16IN2aT+3dSfKZJAeAade3FvV/9/Q4FXupt7iPJMpXeQlUjNBp1dO7UHcCTOySDoycIRI7/o3krfS6S0Bw2nq83tr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449338; c=relaxed/simple;
	bh=Sm1Ha/cdp0gEPKuYY5svXi0U6xdYi+e6UYNhY26NVms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3f2bz5MVtolrpeH/Cp0VSjyuXLP3YuV00gOJ1Y4CJbNUDZgQrEGNOf3ZQVzwF4PZS5Ya6xB6hXxKgJw2aBG07++8KzZ07qCuhpdFOl7MoOcHXvrwYOudWj1wAjDI/CeSmCWMhUsd0T741a/zYiRT81WZqdaelSaDH2LKTVneWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=o22NVOKc; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="o22NVOKc"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8478a25f268so3589343b3a.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 11:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783449336; cv=none;
        d=google.com; s=arc-20260327;
        b=atZR7j+AKPUO5CD6D22bRtrAw2S0AO3nn5VgCprPQr1vzPRxV9nc2hejSYVBDx9MFO
         oM8OT34LVr4Olob8vMFoRst1WpM3GjxgJbz+C9xD3yYqJ1Nb6DNlWEpXV+B7y2NXp2zg
         LotrHCr/4z5YvDZiwb6DtmWueM1/OIFnTI1QyPR0j4iufvq5zJkpVa/BVn8mmjFNGlwE
         3u+ROMx9B0hQKgycNFDRtmRfddNPpkiHahXXnywv0yRzp/8+31Doawwt/mwmsZpZOP+1
         3Am+gHyxEbMBh5XCl4TgKgYVorL7PKq6nFfiJSja1T7wtb7g73C16v6PSnJBbgbvMMY7
         1o2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLDyqjY/uVeAJp5z4niMzm0kWqHh9bj9lbZDR35EN3M=;
        fh=R+WnWHfRjWuuswks72G1Mqh35ZBSFv86O3Yg29e9Uj4=;
        b=m9YS9X0/7wzpbrDLGpugWgHKOyunFPGJJIFduoIXYOrHPjIHEK5YqbN4z10A7nq20P
         79gEH2swle/1VwuRyQs+DhFgoXSCAYJwqBQU5W581Pvxk/I1M20p9a0ZBPOXzzzBziSz
         0ZCzZ/j3h4VM3qgdyclJUBu6OTDGKksMuEQjWU8Uaylt2AWUkWbYswJa3+qAF0eI+AZm
         6bQ5sTLFd9t3cwZPnqF+Lg67NQ7YGeFpkH/p/j7xJja8+zNJs9KzpkulmS6JCxjkGJS3
         sSFmW4qcStKGn176oRRQKMdlDaTzHsTVeoVFqz57l3hcPVehC7BqmXS6eIMpnsOlL5ZP
         YJRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783449336; x=1784054136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BLDyqjY/uVeAJp5z4niMzm0kWqHh9bj9lbZDR35EN3M=;
        b=o22NVOKcTsg6PGr5AV5xGnvYD5sFurgZHB3qGm7uh9uvOu+oMS06ornP6DH6l24yLy
         n777XyRJUZC8MohntLfrYNHGXD41ypVZjRFZrpqKI9PlizQeL1D4rmMHzEAEDbuIz0TV
         OW6/lExDAtLrHRqQupWiD7pPnLGrcFelVrVR3K3gKFs51xjqj1WAn2myDA5f0ulX+KQm
         jQXxu5LlIS+OEfKeZ3ua+VL/Z3v+7m7kpqgbBwYilTTFJFaTm6c6ioZ/h8dt/uB4gzaz
         jm5Wu65c+KdvBWGC4DdEfe6KuLLPnmoTa1qk2OPr7jBHi177ZRnH7fcLx3ihxZpJd7Gf
         0n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449336; x=1784054136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLDyqjY/uVeAJp5z4niMzm0kWqHh9bj9lbZDR35EN3M=;
        b=Xi46b4H3vz1Q8baMB+sF7W9EOqQMt1JjUbnTs4cvjDCFTzWdi9cnBiOG21SIW+6QoG
         Ut3WLC/3iI72iXvM2n7z6Zb9YekHkx97JFkfpoWY7ramxB46k0LZeFbgVYxl3m1atr2c
         eCrNhtFkZ02TMvLlSoZrzbfbI80k2sh9Kot0uLSnHwoIXjR5BK1zzOmQjSED3U2BerF6
         +XOorBWAhYiyJ8z4mim9XxwxeznCEjQ7FA+2gZhLS85VVRAYtnxrbtdNm3Gu+88T4PJg
         HZn1ctJo3N+Eq1swrJfN+MIbGztw18rULLzdPu6zGccbScC0GI8k0MO0aZtdY505i1vh
         sVZg==
X-Forwarded-Encrypted: i=1; AHgh+RrKu7hjLaEkXqhwECszZDiaS6IlqvmqlC4riI6oSX5gI5UUkV2qq68Cg69E9Ye7gfgEjPUXD0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWPER9IcqbT5l6uBuPhAGF7FSz8oSrOq27t8luBt7qNW1l05Z
	Sj69z7hPd5eucawGTeRmLpCi+m8kcJcy85qJfC8Y/P5rQIzHq40mPbCv0MBUIEtVkZ8dfG9nm96
	sIK7hqtKAMb/kKSq7PATOgCqV5iSzZpgixw5nZjf2
X-Gm-Gg: AfdE7cn7NqkceZTrONTRG+wiLnnfMOGCJgnnW8TaJy4MJqLFSHXA63Y6fkvTdaMnIU4
	W46E8DbyVj6y3TgvoqxAnMhSVpPkpEqUV8IrZO0pT3fScODoGDVyIFEqkk3W4qCZ3k05+pxYT5y
	IuC1vMrFUkEqUsLiqVOXaSyfAaZvHsoN+0cNREMQywjjefmDjzOt5oslTlsSbNDUrnHu+qBiB7E
	27ADnc4MjG70KINUuTZDQX+sSYAiV5N6E9GLQ8VtRgD309QR/0Al8pj+iL9+ZjprVMKP2FgYRG+
	bW5jibEkt+XMgclaDE3qPMnTLRNy3nfxy9LPd6c=
X-Received: by 2002:a05:6a20:c5a7:b0:3b4:b24e:27a2 with SMTP id
 adf61e73a8af0-3c08ee3631bmr7716392637.31.1783449336227; Tue, 07 Jul 2026
 11:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706191309.2887515-1-xmei5@asu.edu> <20260706191309.2887515-2-xmei5@asu.edu>
 <CAJnrk1Z8uS=ZR9HPeuuUiHUcydE6OW9WkmnonqSchTnfmwhk+g@mail.gmail.com>
In-Reply-To: <CAJnrk1Z8uS=ZR9HPeuuUiHUcydE6OW9WkmnonqSchTnfmwhk+g@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 11:35:24 -0700
X-Gm-Features: AVVi8CdsPtS6exApgyhrHcoPo7IUkcxUWLjCsCcbcTlZu6-y7xIEf5hVJABT7XY
Message-ID: <CAPpSM+QBNBw5efBV+Ne52JQ0CZMBneVGeQC6boGbvrj1Ykufug@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: reject oversized payload_sz in fuse_uring_copy_from_ring()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 2:29=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Mon, Jul 6, 2026 at 12:13=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > fuse_uring_copy_from_ring() imports the payload buffer with length
> > ring->max_payload_sz but passes the server-controlled payload_sz to
> > fuse_copy_out_args() unchecked.  A larger payload_sz drains the iterato=
r
> > to exhaustion and fuse_copy_fill() hits BUG_ON(!err), panicking the
> > kernel.  Reject replies whose payload_sz exceeds the imported buffer.
> >
> >   kernel BUG at fs/fuse/dev.c:1053!
> >   RIP: 0010:fuse_copy_fill+0x6c6/0x7e0
> >   Call Trace:
> >    fuse_copy_args
> >    fuse_uring_copy_from_ring     fs/fuse/dev_uring.c:686
> >    fuse_uring_cmd
> >    io_uring_cmd
> >    __io_issue_sqe
> >    io_submit_sqes
> >    __do_sys_io_uring_enter
> >    entry_SYSCALL_64_after_hwframe
> >
> > Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  fs/fuse/dev_uring.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 0814681eb04b..f6127c230dd9 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ri=
ng *ring,
> >         if (err)
> >                 return err;
> >
> > +       if (ring_in_out.payload_sz > ring->max_payload_sz)
> > +               return -EINVAL;
> > +
> >         err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE,=
 &iter);
> >         if (err)
> >                 return err;
> > --
> > 2.43.0
> >
>
> Makes sense to me. Thanks for including the stack trace in the commit mes=
sage.
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Same comment about stable@ as in the other patch - not sure if the
> commit message has to explicitly include the tag.
>
Thanks for your review. To ensure it's backported, I'll send a v2 with
cc'ing stable.

Xiang
> Thanks,
> Joanne
