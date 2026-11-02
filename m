Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793653277;
	b=h5mU0T2e1U+/JhmEDXK1dtwLNZr0scgaP89VyejcngV/s/WF5eSjDbeFQ8V5KMHKJolY
	 HQNZUV+xWI9JGDVq8C93fmU9o1E1omNwfqvbkqh5IUP+kRt1lez5rbxURJ57wI9Njpgjl
	 w8Dh21oc3LJndu3t3/jueYQoeL4GZ6fNXPtee5urSogAi2NcWFUsgIz3ScuAOf3f6tWdl
	 2KtHHy2dPn7k8wFGIaJ0Vn9tLuVk2gLDcVYHROXxECdWxVDMMqoFc5Eq4+6ZrvVWkV8Nq
	 hhqiWsaL0UmUc5oSk4Hx3qV+EWWnlfdn+37negORhNRYllBZizBKAciVSz0RvYS3ixQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
	b=c6I2qRTGKW+BSVkL4Gn2oml72Ea1XbUUvwC0i51mbbUOASU7So+LAUSF49/MLLHOjfS9
	 C9AuwaDOo3x5MCNZzW5YJk0U30rWXPKomGhj67RCVMNDOKYdSKQnyI867a4FOUHfTkU27
	 qKYjfsjp70t8Jb6C2ItcYLXNR1Ob6nqNiYCVZExztGmOM7tztAaKYdaLyq72dC5wL4xkV
	 NIS5TChnKmBcdkoutOXsgNXzqdC70A7pHo/DTcDd/8CoDHJPXHwz/0xZ0SpXZcRW1E47T
	 kI/B7fw/ugycr7fB2KKno5hcErbptnNVnjaQxDpDSooQ5S5nMhwklyVNaN7taGDlrKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IY+K5/MB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DF606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 657DF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IY+K5/MB
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7c03a445cb8so2430351137.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:01:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793653276; cv=none;
        d=google.com; s=arc-20260327;
        b=nxaPaE52gjUWU8vlsYIwkDo0p/hCOWZmj4+JGmAP8ptR5De3rO1PvnFAqMd3+xzqqA
         n95gGrfXRkrxD4VF1wDnm2wCc2DDuE7iFWwHNgHU5aIyRw0fYfLJ34hu0AuuJ0cj9wef
         1iQMnKEj8m2Us0Xar7jacP9cDS9T8c8EpPrTJ3XEkTJFpm5PH3/VV9Gg1N+1wVOXJtj8
         yBlwQ5yCSSF/IlSGuTEh/aVChsbviA+rO4+dOindo6iy4O8ZFph43oG/bGZAtHgoWbym
         HktSYHZECBCUP+IapkBTjO6ois+yDzUUAbOW4Y/7K39NmKPDRM8sZKObGICYOdD8+I75
         vg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
        fh=RsDyH1DAFwsOfYrlKiU91bjtptAtVu1M1c88uwHQ79Y=;
        b=mq8VzgFqbSu706ZI7T9j3Cz7gVaqXCEC7z8os0xoS9HNXXhfeagJJHBqq9PLc3HfOJ
         LCgm6xcBIKybMvjdhkhbUF6l1Cs0pGSYGyNsJ92P2SgIBMkOtpshmIYRf1u5aUO2+CrG
         yliIesYt9JG3gIA/A/KxOb4pV1RIZKav3zZWz2fIrRHedzT17DzYVTdIURoeoM6dbXDk
         EJqQLffngb2tQdbrYlutAZ2zQ+6QEdJB7HoDiqBrSbpfJW5twfh4m4c7YFAxhP6HLBnR
         xT7LIPy8e1wQCcIX/wJycTARcL5Fd89GP3KzrxKs/OgeejrNYNIAuwCDe5ch4pVFRg4w
         khjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793653276; x=1794258076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
        b=IY+K5/MByhAcoYjByg//SwKjCLd7vCyBUD5AVnFYpbtetV6vtXkD4sgYdXY8Wftbfk
         pKtw1qnW+SQ2farNcqPSdjuclT1D1/IAsjncvY15A462e1+/tPCnqNhRsBemKwY+Duvb
         z3vle4ycsu6NzurclTI8thxVBhz6OOWt7cxXd7RdUTonNDCZ8bbj33Z0iDOJgQxE5sgL
         YjP4MtBbY/0WF6rq80r2NIfm8XOJlmu8Jc09xpwIrWmI8DHRfhV/7xx+pCnrJVjpRsdI
         G7pnyiTzNIJLCItK78PpopvclpqMsppDovbdzrPdD1oUIsE0p1mXQS7hA9yqXlu3ipNg
         L74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653276; x=1794258076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzGy7urIpGHew7dVJqO61fkpD1EwpGhPhtimR7hndxE=;
        b=c5vpKO1Nu3cxgrgQ+cPq3ZRMUAK5IqDMMC06uloMx71ijJ2LY+xNiw/1/93xY9z4FQ
         FgTkf8vdq+jAXi+haxKTuLHQIeUG3Y5n10kEc838OA6A9sD69PPsdKgs7nhWSBJtV7ty
         efbS+8N5xTjIXPL0mGBhQuha9bYzc7ZLZ3gUc1Ss6jKwsNdRuBeIYFH0NCtdrxwkJ0Sp
         wXZHN/I0L5t55CNyhcTtnYF0pxwoXW/RGuciDrcG3KoFrGqHA2wsYl34ni4WY9Ci5vYr
         EMgZuIHq++HFH8l/+9GS9R+eBCeveLzKbptjSqeoNb9IwNFUPikvYXO1ntahb+lPVEvh
         YwxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrIXXXiNVUSVdhmhdu/ZWo/EyfajHxaHjJy7D/SM894DcxedtKaBDcyB+FifDgWBVy1bxlAdg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VuboH4A+PCpG2twylObWHbB9IALEF/pTB6i+n7SXUDtBy54uZ
	9zHIM7dDnoG/lNC9u995rMS5FnO4nno3nyTzd8dc1adFReTtn08CZUFC0c0CVBXz7VO2Wz5cwki
	pdplsI5IC+1N6/eBROQnV2EYo3QkAx20=
X-Gm-Gg: AYBFou1/aLSGXWzJfSAFQZXI5gu/tJrQ9w5NLSv8Y4Az79cg6dsUu5s/GR6VlN3xvsw
	mdg72tF5kfzkzWkDsQfCYk0serdM3dYq1zsqA0MJvDPv4bjNhZ6nMd+P5nKh7l/CD8pLyX4vTj0
	PDSPiNyIngM0i4w2pp7XVxxsh6MfDiUXi3lWN8ksKSSsUh8U51qxkEkN1jlHEfbheSsPmWj05G8
	hZZHIArZLmfV/EP/tSS8+r18FJhTh2cB9FfVtJ+bFVQD7e/woL0Wu/EARPgYQ95Ox8pKiQ4VwkR
	cJrI+kvXzl74kaeQXpbkUCJSubmxL3DWRK+j/fbhcosNnLIZxKjI/cQYnXiAEfJ5lTiWuAtUVky
	OSeiBUa0YfCWDU9rSY5k6I67HJoKF4wDbOjZpTXFJKJzEYrYPci/hRkhcIK3tIbjA5PLmfUE=
X-Received: by 2002:a05:6102:5811:b0:7c3:b15:a981 with SMTP id
 ada2fe7eead31-7d072c305d3mr5019729137.15.1793653276174; Mon, 02 Nov 2026
 13:01:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902124026.1774575-1-max.kellermann@ionos.com> <CAOJNxRJ9rUZ4JRwcqEtOPu97D3NNsjwV1mniM6LdNytRYiA54w@mail.gmail.com>
In-Reply-To: <CAOJNxRJ9rUZ4JRwcqEtOPu97D3NNsjwV1mniM6LdNytRYiA54w@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Nov 2026 22:01:04 +0100
X-Gm-Features: AclHuK_u-vaHTlw45n1B7ztDg1G2EXvymWObtejqyMF3Kk8CGrlA6DuBbpPPY8o
Message-ID: <CAOi1vP-yKSeBwA=269uACaXmmfX+Bpjwk_x_uJNOtRtohH=ybQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: acquire caps for read_folio requests without an rw context
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:55=E2=80=AFAM Xiubo Li <xiubo.li@clyso.com> wrote:
>
> Hi Max,
>
> The fix mechanism looks right: a NETFS_READPAGE request issued via
> read_mapping_folio() with no rw context should acquire caps, blocking,
> before hitting the OSD, so it can't race a writer that hasn't flushed
> yet. Two things though:
>
> There is one existing Ceph-internal caller that now lands in the new
> blocking branch: ceph_uninline_data() calls
> read_mapping_folio(inode->i_mapping, 0, file) from ceph_init_file_info()
> (fs/ceph/file.c:262) at open() time, with no rw context. On an
> O_WRONLY open of an inline-data file with no recent readers, RD isn't
> part of the file's wanted caps (__ceph_caps_file_wanted() derives them
> from the used fmode), so __ceph_get_caps(RD) takes the -EUCLEAN path
> into ceph_renew_caps(), which raises the wanted set via
> __ceph_touch_fmode() and issues a synchronous MDS open request. Such an
> open now pays an extra sync MDS round-trip, and open() can newly fail on
> MDS errors. This read also doesn't need caps: the OSD object is not
> created until the uninline CREATE, and this path intentionally relies
> on the -ENOENT -> zero-fill behavior. Could you handle this internal
> caller explicitly (e.g. have ceph_uninline_data()'s read bypass the caps
> check), rather than making every cap-less READPAGE unconditionally
> block?
>
> The blocking acquisition now happens with the folio locked
> (read_folio contract), inverting the usual caps-before-folio-lock order
> of ceph_read_iter()/ceph_filemap_fault(). I checked the obvious cycles
> and didn't find one: a folio that reaches read_folio is clean (dirty =3D>
> uptodate =3D> read_folio is never called, and netfs_read_folio() diverts
> dirty folios to netfs_read_gaps() before the request is allocated), so
> the Fb-revoke flush/writeback never needs to lock it, and the truncate
> path uses folio_trylock. But please document that invariant in a
> comment, since it's what makes waiting for caps under the folio lock
> safe.
>
> Minor: the new branch hardcodes want =3D CEPH_CAP_FILE_CACHE, while the
> other read paths add CEPH_CAP_FILE_LAZYIO for lazyio files
> (ceph_filemap_fault(), ceph_splice_read()); it may also be worth
> aligning.
>
> It might also help stable reviewers if the commit message notes that
> current mainline erofs fileio reads via vfs_iocb_iter_read() ->
> ceph_read_iter(), so the trigger is gone there and the patch mainly
> matters for stable kernels and future direct read_mapping_folio()
> callers.

Hi Max,

Did you get a chance to follow up on Xiubo's comments?  Particularly on
whether the data corruption aspect is indeed gone with EROFS switching
away from read_mapping_folio() in the upcoming release:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De587a984d332b76ab89fab546f1594f61f73d5f6

If so, I don't think the Fixes tag applies anymore (although it was
questionable to begin with as this patch is fixing an oversight in
CephFS, not in EROFS).

Thanks,

                Ilya
