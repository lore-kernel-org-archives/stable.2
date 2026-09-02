Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D933D4107
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335856; cv=pass; b=uFzdT40uMviYQdHfV+kj2AsA93gR9eFwDSc1qaj9GZEVRf8s02+/CA7+LJvwGwPeFKGexrust9x0pmToeOkkGabdO/C9sQFW+k+ELrw2feRnX2hBRXH9rBT7rMXVB3RTGj4KZcXRNJoi+65JSGSdgtRx8CNfQqc87nREMmIOz48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335856; c=relaxed/simple;
	bh=C9yhoS2wDr9terSt8QmqfM3/ppuciDNPDvKtU9GsrQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgBMSe50NPhL5ge1FwN+LjmyfuewP9Fz+KTvuTPpHk8hzMnDYhRYapmi4fMoCGBI9ZO7qLBx8mSCVlR63iSgw3dSbcA2eXB44x+u6uaB55ZxfdolMMPHYoDOWss17xifwfDOiW5Jc0vxVB8mhc40nh3tOd3pIHQz5Ibs7Qgz26E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmPm8AnY; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmPm8AnY"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15e2dab83eso123205766b.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 00:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788335853; cv=none;
        d=google.com; s=arc-20260327;
        b=oWGUHyzbNPEBoZkSlAw1EZheUbXAtffiJzreaCxUZnoA+l4mvPvUmi/4oWPzme+RGZ
         s4LI42MCf1zFMFgiZfxj/yLqsk+ly3nLJTVs+B97nS7JqqHPW+4gSCLJhrBYi/Qzh9uk
         O2b7EHG/3ORBsKwSplUaJqgjM7UAgzr1ZwBiVyWasK1A3mjkAZZb4Ii1ji4W+DQLAlpI
         moAK8bSDtEjuRdqCQfzYKiCCgpDQrFISHR9oqV2l0k91DkpWpMDrU5nyINwcMG8LB2nX
         gxDVzCzs9/xvrdtlE+V7EdtntMQHbrsxCDvFCrg1lgi6jZIB2pYfUQIyH4XZXgXcJ4v0
         oY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UImLSpeTRi6CYxj4WkV5KPFdwNJZKQmwY6Aw1Kbgw5s=;
        fh=IDh94xArQMR/2+6KbFdeZ2mpugltr2IP38c5cfcmteE=;
        b=fFOSDWlR0gUAxnLJXI0mY7m/yuMU8+J3y6zUD8pgGiIhbteoUWZWT58wCV0IRAlk41
         Kcwz2G4PoEhe20xi25htab7HmveJaeX6g47jJAQ00NCveQ3AYtfLA5aCvbi7WCJxmJBD
         JFXe/L+ckZkj2fSDmXo1562nTUQxCE28dTe+8S3k5WdbiqMHmWa2qpxIVuUF+HGghigB
         As6r4j3fEOmQ+/4yTpII0VsjHlPmr77Rzw/7XrMFV1MJvRYgYteTu341Alodo4SPYPR8
         ZjGnqDnXULc5RwG0Be6/TKvJXS2CcfgQ7CckO4wWDhf5tM3cNoFXBxle1C4A/AjMIAhq
         Dy/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788335853; x=1788940653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UImLSpeTRi6CYxj4WkV5KPFdwNJZKQmwY6Aw1Kbgw5s=;
        b=PmPm8AnYqR46R7OTeoAmI74mZBJdROGlocHTpotcTL3DKakRNucyugH5y1y39EJM4Z
         eiVxnUsutJDfZSWWEAw+/CWmfucw4iZqXUjygHR/eKfWJZ6tgs/wR73fEQyRjydpBosf
         KkjBqKBjP2HyNo023HdO3pV7gBR7iwY95wE6dkR7UbQJhIV9DwTAWGaz0qaIneqwvFRx
         1Ko8+iu7PSpA38zfpgszeyWHZ/mToVKDYWmhQc8kRejN/VaI8zAcbWpyN41olIZOjfLZ
         rUj0hdv0lVBdWRWc3Y5ffANkWCQNHOnwQr1Wvz6v7AhZGKI5TiyC3VM19IcwdXPK6P82
         KefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788335853; x=1788940653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UImLSpeTRi6CYxj4WkV5KPFdwNJZKQmwY6Aw1Kbgw5s=;
        b=LGGOyEg+6YGhbH6NDJt+u6FLqw4wYiNuAKtXRv+DaLuk07/Nev6GKpFOIWu5Uhr+kZ
         RWHyQsyh//91KJ/z+8Vv+mhFMooAW6DmxrTHYhbKVQygqE+3DFpIzsdK2czmtV1x2iNd
         RRUZhxTeWyZIOHmtg8FyzZClA0IJAyn0X2nFoHjadrK1ltO7rIeXNcSAcEKeIe06o+ok
         hC3JHB6AUBpClKhkKBx4hOZzpSZ8NbjxVuknHemmP8KUKzxBcF8m5p/hBa3KqhK4AmZW
         Nr2eD3MyLoGIrQP4EhqmgdeFGr+IFN9F1dm+nDZj/p9016bKgFsmJRkN3JUt04nNASfE
         6BZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzovqDCXEcpZiU8hvG/PbkM7aMlnaPZyDgxaV8v78Q5R3shG4ObKoNlpfs4hcDvME2Md8G6jr4=@vger.kernel.org
X-Gm-Message-State: AFuF++kD7WMbLT1wKYzQ/ANlooc1fA90vVr1pELv3S71mda8lIQyuy7d
	7Lyc/bvjv8hb4vCXbuRIm293tXwFUpfyw8XkPAN/80Fl2vtFvl5LMlUZvaU1cy7fUkQxMOYtnWi
	25vkSGAl5WDD0Pt2YDwc+Bgmro+VfNvVkHLcB1yKq5w==
X-Gm-Gg: AYBFou0kfaoHjx5lWA4BuPQNJ1p51dSzRLSR9I7495ruc4tApI80fOfZwS67ViKkALf
	hEPq1ASj83O1hn4mnUwp5A8RhyqoWO6BqcYvF5lhOBEemLRI1EISRqyy1240Wp5qlWQtiu3svah
	ftQaqw6o9uujqgNqfywR6S74TXswubuVzyblBLQkjqXxISJ/XsQoL6P7MTXStkqk52Q2cOwLGRd
	Qdg+rXrmHgFNNG5RDs0wqSwY2Ymku0FXH59paynleHQKA4OcD+de/PiYJYHS+74YWb+1c+fRWLB
	2Vyuo6IFUph/67MjNfv3ghXObuHtoIobx7uXqR9i8GLY029uNpem21FT/g==
X-Received: by 2002:a17:906:ba8b:b0:c12:83da:7eeb with SMTP id
 a640c23a62f3a-c25d55b872dmr163073966b.19.1788335852442; Wed, 02 Sep 2026
 00:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901134430.1292467-1-r772577952@gmail.com> <8472de4405ebe1459a4177c25bd08c2bfcd1b6b2.camel@dubeyko.com>
In-Reply-To: <8472de4405ebe1459a4177c25bd08c2bfcd1b6b2.camel@dubeyko.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 2 Sep 2026 15:56:52 +0800
X-Gm-Features: AcwNN1XyCliZ_ADB_gd5auwCYIAbct3F-siZ-Gth1L7zuu8EI2dnPxcYNax3RjM
Message-ID: <CANypQFY95Nh56dO_xs-B6-S4YK6p78+JLoa6A9Ha2UnESu2f0w@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: clear folio dirty flag when copying back from the
 shadow map
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: konishi.ryusuke@gmail.com, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Viacheslav Dubeyko <slava@dubeyko.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 02:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2026-09-01 at 21:44 +0800, Jiaming Zhang wrote:
> > While garbage collection runs, nilfs2 keeps a shadow copy of the DAT
> > metadata file's page cache so that it can roll the file back if GC
> > fails.  The rollback has two steps: nilfs_clear_dirty_pages() drops
> > the
> > dirty state of the folios in the DAT cache, then
> > nilfs_copy_back_pages()
> > overwrites them with the saved contents.  The second step warns if it
> > still finds a dirty folio, because the first step is supposed to have
> > cleared every one of them:
> >
> >       /* overwrite existing folio in the destination cache */
> >       WARN_ON(folio_test_dirty(dfolio));
> >
> > Clearing has been best-effort since commit ca76bb226bf4 ("nilfs2: do
> > not
> > force clear folio if buffer is referenced"):
> > nilfs_clear_folio_dirty()
> > leaves a folio dirty if a buffer head under it is still busy.
> > Reading
> > metadata creates such buffers.  nilfs_mdt_read_block() submits
> > read-ahead for the blocks following the one it was asked for and
> > waits
> > only for that one, so the read-ahead buffers are still locked when it
> > returns.  When the block size is smaller than the page size, several
> > metadata blocks share a folio, so a single folio can hold both a
> > dirty
> > block and a locked read-ahead buffer.  Such a folio survives the
> > clearing step, and the copy-back warns on it.
> >
> > Use __nilfs_clear_folio_dirty() to clear the dirty flag of the
> > destination folio before overwriting it, rather than making
> > nilfs_clear_folio_dirty() force-clear busy buffer heads again.
> >
> > Fixes: ca76bb226bf4 ("nilfs2: do not force clear folio if buffer is
> > referenced")
> > Closes:
> > https://lore.kernel.org/lkml/CANypQFZSYrtcshnUzOPiqatyLd-M8_OReOewQoAi_=
V5yY0dTtg@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude Code:claude-opus-5
> > Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> > ---
> >  fs/nilfs2/page.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> > index cf4f1c6798f5..b26d9c3bda6d 100644
> > --- a/fs/nilfs2/page.c
> > +++ b/fs/nilfs2/page.c
> > @@ -328,7 +328,8 @@ void nilfs_copy_back_pages(struct address_space
> > *dmap,
> >               dfolio =3D filemap_lock_folio(dmap, index);
> >               if (!IS_ERR(dfolio)) {
> >                       /* overwrite existing folio in the
> > destination cache */
> > -                     WARN_ON(folio_test_dirty(dfolio));
> > +                     if (unlikely(folio_test_dirty(dfolio)))
> > +                             __nilfs_clear_folio_dirty(dfolio);
>
> Maybe, I am missing something. But the main point of this WARN() if we
> have found that folio is dirty, then potentially we are trying to re-
> write already modified data by already obsolete state. How can we
> distinguish that folio has been survived the clearing step or it can be
> somehow modified in the background? Even if it is survived the
> clearing, then it sounds that something is wrong in another logic. What
> do you think?

I think the folio cannot be modified in the background here, because
nilfs_clean_segments() holds ns_segctor_sem for write across the
rollback. ns_segctor_sem stops the log writer, and every other path
that could dirty the DAT cache takes the same semaphore for read in
nilfs_transaction_begin().  So it should only be a folio that
nilfs_clear_dirty_pages() failed to clear, and what blocked the
clearing is an in-flight read-ahead buffer from
nilfs_mdt_read_block(), not somebody's modified data.

And you are right that this means the problem is elsewhere: the
clearing step is what needs fixing, not the WARN_ON().  I discussed
this with Ryusuke in the report thread [1], he suggested adding a bool
force argument so that the forced clearing is restored for the
rollback caller only.  I will send a v2 patch with that approach
shortly, please review it at your convenience.

[1] https://lore.kernel.org/lkml/CANypQFaUfeXU7S9N0PpJP343h1ibRxSJ27oJxhJ0J=
d5ChpiDcw@mail.gmail.com/T/#t

>
> Thanks,
> Slava.
>
> >                       nilfs_copy_folio(dfolio, folio, false);
> >                       folio_unlock(dfolio);
> >                       folio_put(dfolio);
