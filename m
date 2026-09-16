Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF63B38B1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534743; cv=pass; b=rjgx/bvuama8ulckglpb94a8HikF8IQZV3zD39EPJyb3HMkbqg1xxIBE83CH2jt6Zs5L2Esy8iOawy+wsoJ0fpthJ+2BYdw+RTC69PCd1nFbQrvYQf+iPV5Krb3id5T3lz14EkNmw1EwjYBzhflpwWapLBmXiRre9x924jQkQ+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534743; c=relaxed/simple;
	bh=dp6n/uACwesOIsl60OkMBUsm7Ls461X2eOET2t9FbmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+27/FyUmAsH2GubGyPWmY2KPJAXgd5IyQHjp1nAWrS/K5QH2hhbbcbdCgyHg4Mmma/44K9sru9HAX8Y8nE3ZoRdxNSHWxvuNWyGNta6POA6flZQPo5fPXgEHDwuHxw/P4c5GVmYHRMh3ij6wMWSFClRMObfGWqU3uq63AeYEkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ps5hCgSp; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ps5hCgSp"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c264788fd58so84110266b.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 21:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789534740; cv=none;
        d=google.com; s=arc-20260327;
        b=SesEW14LsQv9v/nDU4sGfyxaCkybBCd887FVTGYpM9ICiCUYObCvZlARIvEa5DzfEh
         L5ZXe7LxLhQapPMuno25K9MPrGBsMecEV9MWJL6uj7dJp5qP6nGF9vfkAbat2aRYyx41
         cMcQ5uVVdZEtzNLFIN79zlnKjXQYDoRFeg8ZdQnKM3G7eJSZACAL8c9Z3uvwBdUC6utr
         rf/EdkybKbHozIOxZtca1SHp3+dwz1PufEaB0xeEeRLGL2BKfFS8yKnvJ5YpQjroww/H
         VHos3MNbvUxZ6bDdhGrIMhFbvRq/5SDPPSp7Fq2z1N5A1L/vK3BTvXdbYotPmd7SUcMS
         YGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=07gw2O5Xp6RugqG2tTqxFnRpDG3MmGDKXARV+mqZHyw=;
        fh=yHq00+Y9CjvtJRZaZME+yVJvqlNuuT341L2rnQJDeY8=;
        b=nC2yIjQv52NswbNnJHQsCR9zCfU4dTks7nWuuQFKnf7y1p6UTNqC8ZJddphFyXwcu/
         wQ539cFZPXgl8I/VlD4x5ZkaOlkmCy/FRkFSBHkHDSC8S9BBVf9DQHe3Y3XFntecsvWr
         FFRhNa2+/tT0jJFakdpExq3opXANbpaphdYC1wQPHEavzRZ6Qa9tu/IwEXPIyBfGhJhp
         3TbZQYQ5Fh2w7OFGWCBbG/uTSOeWA9H+z31QKd0L6wFY6rthXQzsGcS11zgaExfBx0II
         kruIjetvBPdYihrR2lq6ImUZXY/fGquH8rr3/uPgiXsKt3doJb8vgZimKeAo4cwWvLvQ
         W8bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789534740; x=1790139540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=07gw2O5Xp6RugqG2tTqxFnRpDG3MmGDKXARV+mqZHyw=;
        b=ps5hCgSpDuCq9rqbbPplRUiD+I74mE4LY9m2vc7uCbyXstcuYyj0tQ84voQfSLn9yg
         nzPK56PsMdVx6Wei16lyqOAxKzRRePjVlwUpmZxjjOPoJthabA0nvp9K7H2lvjdZ9haa
         LSOft6t3goxXb2noheUoYS4piobr3rU+cYDg515o8uVXa6zXTjBPbzPFQgUyj/TXmd0Q
         7TaQMss9mXr2xAsWQZGVr+rGtmDUHz5Ya0QG3y8IBuUg2VP8QhN7aa3vr0n2kqc0lJBF
         kUcx1e6EYK43nCuHHtBqIfa/48GrvFYCqYlaDSnwvDqHCXQOyrkXWfxSHyaU7pn9njF9
         Jq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789534740; x=1790139540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=07gw2O5Xp6RugqG2tTqxFnRpDG3MmGDKXARV+mqZHyw=;
        b=Yd/MOnb9euDiS8LSMrUQ1eFeOhrJx/kSfTORnrBMwc2MFkqFCkm+TBhm9Y6RJZxgKt
         hJcDbclEN6zMN3G9bQz4LBrx8h9Z+4dw+vWydRA8YCi76HRJ4HzsHHfWimm2Gnd/Ez/P
         9NhvkepKzPT7gkLYFVbxGU+fWfUhVK+o1SrYif30mQyX0npi+ugpLzwzH3pqn6orEeJw
         w36XpaOgEFrnPKEqNzqUEdEwAMzvwZcKSu+KJrmStxCyOLrSfXFeH3YGlb+h8FWF2v8Q
         90o70CriqFgIRFNBjmWzIb0nuBxlr5PYag8EKlrW2cj5cbr2GiOwO0fKmbIfbAJTNzR/
         6dug==
X-Forwarded-Encrypted: i=1; AKwUvBw+MygdqfY2qbNMPnxKl7vg7BkJml0hKNeo5P6bl4qhBWd+nXkzmgDOGQ3ybLnzKeG7dvONHVo=@vger.kernel.org
X-Gm-Message-State: AFuF++mIzOGzPu3J0v8RcuQF/puCFOHXkbc5a/HDtj0RO88QSzvi81Yk
	W9+leqYnEIM9IxjBQIvXDVzy8nqacwdr78eK130auz+oblLVDkJlPTgwFhuQjoRi6D2bsdqiYeD
	nJibT/KbCcLf92p7QvW9Ok5hF/jAFuEI=
X-Gm-Gg: AYBFou3EeSgdghSQ+NUop5U3iiXumPPDFYgJ6m1UjrTTd1u2sM32T1zVSQG9LKDDXrf
	OgifYGrsQNu2QsBxjsJUvii4xptaxBPtX642HqSBQO7FBXjkKFNh2WmeTf6uIBKtqOVyjngOTI8
	Nst/3liof9oqeLYiyDMZ9EoDkIZzPIU5EmKbVbb04Quk22QwxFWpJpgadnEwwd87u+WFHrgscuo
	tqh/ygPZ9PirMYIPw23qnQ7DkqID3IFDW1WOZLHBH23MRpSlhSIG08WlMz7ajebfz3C4j0HDlUi
	B6GoaRxIeql4e2gjmhYL0mvsNoomuC4uFSa6Z972m9f4j8fYw9jouxsBBIiV6jtqTc5KqsvngI2
	Vc/0+ShphLkB6WePcGGQw0x5h
X-Received: by 2002:a17:907:1c93:b0:c26:2751:3da4 with SMTP id
 a640c23a62f3a-c29e520779cmr62267866b.13.1789534739880; Tue, 15 Sep 2026
 21:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFZ05tpth0Xc33gmP6jgPnkY4VuezyHcsajV-SqCsmN_gg@mail.gmail.com>
 <20260914034940.4070970-1-r772577952@gmail.com> <20260915180721.1914e74dc8da69e58399d7a6@linux-foundation.org>
In-Reply-To: <20260915180721.1914e74dc8da69e58399d7a6@linux-foundation.org>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 16 Sep 2026 12:58:22 +0800
X-Gm-Features: AcwNN1XWNjEvri-VMKCiL8OQIH4zlV-VX9cG-PRAMHrS1MSoqZDebFVeXaI0vHs
Message-ID: <CANypQFZMpExoykmy8kM=G5yYN0hJvuHmw0hVMKDvzZ7-qX6ang@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: fix chunk number of the first chunk in a local
 quota file
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=881=
6=E6=97=A5=E5=91=A8=E4=B8=89 09:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 14 Sep 2026 11:49:40 +0800 Jiaming Zhang <r772577952@gmail.com> w=
rote:
>
> > The local quota file in OCFS2 is divided into chunks, and each chunk
> > begins with a header block holding a bitmap of the quota entries that
> > chunk has handed out.  Chunks are numbered from zero, and that number i=
s
> > used to convert the file offset of an entry back into a bit position in
> > the bitmap. ocfs2_local_quota_add_chunk() appends a new chunk to the
> > in-memory list and numbers it one past the chunk that was last:
> >
> >       list_add_tail(&chunk->qc_chunk, &oinfo->dqi_chunk);
> >       chunk->qc_num =3D list_entry(chunk->qc_chunk.prev,
> >                                  struct ocfs2_quota_chunk,
> >                                  qc_chunk)->qc_num + 1;
> >
> > The predecessor is looked up after the new chunk is added to the list,
> > so if the list was empty, the prev pointer is the list head itself.  Th=
e
> > head is the dqi_chunk member of struct ocfs2_mem_dqinfo and is not a
> > chunk, so reading qc_num through it lands 16 bytes past the start of th=
e
> > head, on the dqi_gqinode pointer that follows it.  The first chunk of
> > the file is then numbered with the lower half of a kernel pointer
> > instead of 0.
> >
> > The list is empty when the local quota file header claims the file has
> > no chunks.  ocfs2_local_read_info() takes dqi_chunks from that header
> > without validating it, so an image with dqi_chunks =3D=3D 0 takes this =
path
> > when the first quota entry is allocated.
> >
> > ocfs2_create_local_dquot() turns the bad number into a file offset with
> > ol_dqblk_off(), which shifts a 32-bit block number left by the block
> > size bits, so the top bits of such a large block number are lost.
> > ocfs2_local_release_dquot() turns the offset back into a bit index with
> > ol_dqblk_chunk_off(), using the full chunk number, so the lost bits pus=
h
> > that index far outside the bitmap, and clearing it corrupts unrelated
> > memory.
> >
> > Compute the chunk number before putting the chunk on the list, and use =
0
> > when the list is empty.
>
> Thanks.
>
> What's missing here is any description of how the fix affects our
> users.  And that's really really important.

Sorry for the missing information.  I have added it below, and I hope
it is useful.

>
> > Fixes: 9e33d69f553a ("ocfs2: Implementation of local and global quota f=
ile handling")
> > Closes: https://lore.kernel.org/lkml/CANypQFZ05tpth0Xc33gmP6jgPnkY4Vuez=
yHcsajV-SqCsmN_gg@mail.gmail.com/
> > Cc: stable@vger.kernel.org
>
> Especially when proposing a -stable backport.
>
> I see from your KASAN report
> (https://lore.kernel.org/CANypQFZ05tpth0Xc33gmP6jgPnkY4VuezyHcsajV-SqCsmN=
_gg@mail.gmail.com)
> that there's a use-after-free.  But even that wasn't revealed in your
> proposed changelog!
>
> So.
>
> When fixing a bug please always describe the userspace-visible effects
> of that bug.

Mounting a crafted OCFS2 image can corrupt kernel memory.  When the
local quota file header of such an image claims zero chunks, the first
quota entry allocated during the mount gets a chunk number taken from
a kernel pointer, and releasing that entry clears a bit far outside
the chunk bitmap.

The write will corrupt the data stored at that address, and the
corruption may lead to a system crash or damage unrelated data.
Mounting requires CAP_SYS_ADMIN, so it takes an untrusted image, such
as removable media or a loop mount of a file from elsewhere.

Since the chunk number comes from a kernel pointer, the address of the
bit that gets cleared differs from boot to boot, and the issue has
been reported under several titles:

- BUG: unable to handle kernel paging request in ocfs2_local_release_dquot
- KASAN: use-after-free Write in ocfs2_local_release_dquot
- KASAN: slab-out-of-bounds Write in ocfs2_local_release_dquot
- KASAN: slab-use-after-free Write in ocfs2_local_release_dquot
- KFENCE: use-after-free write in ocfs2_local_release_dquot

Note that none of these is a use-after-free in the quota code: the
chunk and its buffer head are alive.  The bit that gets cleared lies
far outside the bitmap.  KASAN and KFENCE name each report based on
the object occupying that address, which explains why the same issue
is reported under so many different titles.  In the report I sent, the
address fell in a free page, which KASAN labels use-after-free.

>
> Describe whether there's a know reproducer.  Tell us whether it's some
> LLM-found-this theoretical thing or whether it's affecting you in the
> real world.

Yes, there are known reproducers.  Both a syzkaller and a C reproducer
are available from the Google Drive link [1] in my report thread.  The
issue was found by our modified syzkaller, not a theoretical thing
found by an LLM.  I have not seen it outside fuzzing, so it is not
affecting me in the real world.

>
> I and all the people downstream from me (Linus, -stable, LTS, distros,
> android, hyperscalars, everyone else) all will want to know these
> things and I'd like you to provide them.
>
> > Assisted-by: Claude Code:claude-opus-5
>
> Great.  Please add prompts to Claude to ensure that all the info I'm
> asking for is included in your changelogs going forward.  Then share
> these prompts across your organization.

Understood.  Thank you for the suggestion. :)

>
> > --- a/fs/ocfs2/quota_local.c
> > +++ b/fs/ocfs2/quota_local.c
> > @@ -1071,10 +1071,13 @@ static struct ocfs2_quota_chunk *ocfs2_local_qu=
ota_add_chunk(
> >               goto out;
> >       }
> >
> > +     if (list_empty(&oinfo->dqi_chunk))
> > +             chunk->qc_num =3D 0;
> > +     else
> > +             chunk->qc_num =3D list_entry(oinfo->dqi_chunk.prev,
> > +                                        struct ocfs2_quota_chunk,
> > +                                        qc_chunk)->qc_num + 1;
> >       list_add_tail(&chunk->qc_chunk, &oinfo->dqi_chunk);
> > -     chunk->qc_num =3D list_entry(chunk->qc_chunk.prev,
> > -                                struct ocfs2_quota_chunk,
> > -                                qc_chunk)->qc_num + 1;
> >       chunk->qc_headerbh =3D bh;
> >       *offset =3D 0;
> >       return chunk;
>
> whew.  Applied.
>
> I'll retain the cc:stable for now, but I don't know why.
>

My reasoning was that this issue has been there since 2008, so every
stable tree has it, and the fix is small and changes nothing for a
healthy filesystem.  However, it has only ever been hit by a fuzzer.
You can drop the Cc: stable if you do not think it meets the relevant
criteria.

Please feel free to tell me if any further information is needed.

[1] https://drive.google.com/drive/folders/1-LzPTgOALEc3eOjmgM6oOfRKkYXJ-bn=
O?usp=3Ddrive_link

Best Regards,
Jiaming Zhang
