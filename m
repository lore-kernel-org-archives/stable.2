Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3203B3BF5
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134640; cv=pass; b=NNJq9yPIN39gkHcMRYPWPUgrjQpluhxBtHSUHb4Bm1eMUR6DbPNg4CzJ07SaT8ryCBQO9TUekyj9zP1zV/COxZwhQEOjhVfQ2EBdGL5WLcdkViCNlTcgPyZH3F/RI+4FSSQ/vz4wIcFWuyE+/NzKxpjhcvu2K7dJizyBLrxTMGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134640; c=relaxed/simple;
	bh=cqOwlRB2cYciytVAI/aGHMBa2Mc4vzqaQ2ijpe+WEQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRE/CFiC7KZCJve7Vd20i+CDBLROC0JQktVkvgFGDBv6kyKnVvJsJ1HcRBBmRyTBasPQPGN89G8foXZGdwgKfYy5X37uQ3HA5wmvb4+BzpzT/YYPq9C6hyx1PRQ6UIVFahmstVBj/OOrkuXQwhf0mBmOiNCAAr/E3WjhUFgctDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgwRbRr5; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgwRbRr5"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so3456760e87.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782134636; cv=none;
        d=google.com; s=arc-20240605;
        b=eJav2NGPzMCjMP31j0VTRwnpnw5FgM2nBWcvU7+Wmh/DFNGNZr+L56IggkjMt9y8Ok
         LHquw4MYb7fKkdJugRPInp/sPPX4QAokd5LIDLe7koBmTYBbEq5hcERXvZhF7u5eCHld
         hfrlPR5RK1II2Jh7FNFKwECDx2LiPm/LBqXm1r6HOYq9mR3N+pdr1yX01jHof16fVVAE
         pmwUyKA6fNC7+6JfbA1aN5KddSgdeEvuEH/BOozyeMw516fnIaF/lqwcYU2yCsHkZyhh
         vkGD4bw4zTlM825cMnXImC9R2DqIQ2yAgzyuk27xfCEGtl3GhuFHZzR4v1LX6WwQ/tYG
         OHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rU+oHCPcXn9BhjAvef88TGQxC669FX2Q4BW71gODPzw=;
        fh=vCDFjBqGLzIfFo8G4II118NfKAHThdsq1yagIVuoe2Q=;
        b=DZ55ZcwxPtKB8rh143nfqz6I5JbwZHfJ2sbfV5n7X3UzLFueuuB/6Odmn9i23d0KHx
         Vta4DPXprVJ7OaTqzz/SG+gRVPU2YBMi2kNOPq+ITpHnmaU//u488M4p2nduIi/Jp0Cf
         BVsxMsgdsewWRirUaMbRxt267FrShQs7VZSFiaNDU667n45/ERehS3g/l1S5cgR7wPcB
         Vm0eLsIel604h2pMezTVVj1aAqC5Y7NJG5wo7Il/hyckXJm7H1v1teKYREMJDmyM+kFR
         YSKMZvwxXS7qWid4ZrKwtyln2/TFxeEX5xYB22JpjVbag/jwqdQrx68PG5feZ/SQ83I4
         rSeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782134636; x=1782739436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU+oHCPcXn9BhjAvef88TGQxC669FX2Q4BW71gODPzw=;
        b=lgwRbRr5CMtzkdfyF6e/lOJmHZnG/e1tbAfOvy7+V0X7/8CbTgm+61wS8mibESdJ0a
         W7xtUk+pz+CkvmApg2mutTmp7roWRNNF1z+VaMTdgaS1BI1/dAwy24Xk3IofTY4RSCtb
         tma8cfvJMA7vYOzKBWBc6h6bqtIiF9U0x/Kdu90rHMJZENyqxEhZIEygGhZY2moobRTf
         6OPHMWmoEq1EuQ0Jf1BCjB6MYTp8v/hLa1pilYkH3lFM8qNq11CsDwzLZCQ/weZnlPA+
         pt0Zyf2xM0z3T/KUpaUQHxi10QRo0FSq7ask9dp3Slnpv8R3wXIOaH1KXI+EwhzeaM0z
         Sbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134636; x=1782739436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rU+oHCPcXn9BhjAvef88TGQxC669FX2Q4BW71gODPzw=;
        b=PEKa7i7Dgm8wyIrhBYlAcJUybPAzt1p8qqgWMkM1iAJDL/PHcCjcyfUm/t4MLvexns
         9KQ4POs4Thba+eFhu0x4CW+iyStWJs0Zoyw6mCedW4E5BDhsmdK+A/VC0Vg/wzE/HJZz
         HW58vHJzTtPU9omfEjW8Q93cu/fTtteKKMhUoQpmbeaO5efs3BEQyzbf10JsyHDuWkvh
         cv9tCp8/tqllpN/vSuOWYKwbk87f8o70d7MYWUzGXnoNKbS8PhRcTFod9JaigZWVvBSt
         j9knFDsBuwdX3TdDJt9Y2j4GpLhd8/WvL7sdaQo54tbP4m/cxZISa0K/s9O2pv79JAdx
         LH5w==
X-Forwarded-Encrypted: i=1; AFNElJ8cE0qSvy4kYbompGfGhUYIczGG328X0T4bnT9Ru0jU1soaKm5eiXEqucy4oPCc5cNOWGEQwcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaASvzlOR8n/bPQNvXIUJ0uf7yL0FqgGJ1HgNDrizz32x+hC7
	F6H9HG+KOqNglX3uyRmAQv/65tZKOg6j1pOaxeaTLbQQene2MWOanih32tcv2YHQoTEcHNaPLNB
	fc3Fg/gc9oHl3XbshPxJ/MwNbIoak8nc=
X-Gm-Gg: AfdE7cn0vrIj1KLTkRHRx2b/rEo5X4u3z3FNpfyBywY0qjlREiNrwxJrER8ibc8auft
	tOex48PU6ki3SWp5mlMhC5bGCTvvAoO0ynXgM7KGN8/42bTTFBDKvuujcg7/MHtdJjYvd+6JFxb
	0GuRdCSfHhT16/Z9yuHR4YqDDj9mvpgc7/kwif2N85ReFdIIYGjXZ+qYyvhWmCSr1O0LXJYVvK5
	RyNCGhRrCO1G/TEqgebSeHFetNwCpo08wmxl+/Uo0BaQkaA7jDoIyrPa3HyczkHHGaVm88H9w==
X-Received: by 2002:a05:6512:2c99:b0:5ad:4f16:2af8 with SMTP id
 2adb3069b0e04-5ad576e171emr3796648e87.16.1782134636131; Mon, 22 Jun 2026
 06:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618100503.2601790-1-qiwenjie@xiaomi.com> <4354654f-3aca-40a8-bc88-23e540ee5aec@kernel.org>
In-Reply-To: <4354654f-3aca-40a8-bc88-23e540ee5aec@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 22 Jun 2026 21:23:43 +0800
X-Gm-Features: AVVi8CdwS8_Q5RTN8GidR2JIEHPajLBKvISYeuzADxiGJrCeQOFsijQNHvGKnR4
Message-ID: <CAGFpFsQoZSB_YiCrJcZ31OiFtCFi03rSHKbxP7qArRFvH++FPw@mail.gmail.com>
Subject: Re: [PATCH v7] f2fs: use post-decrement count for cp_wait wakeup
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, geoo115@gmail.com, stable@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  The UAF scenario described in v1/v2 does not look valid. The wakeup is
  already before folio_end_writeback(), and I do not see enough basis to
  claim that sbi->cp_wait can be freed at that point.

  After your comments, v3-v7 drifted to a different issue: using the
  post-decrement count to avoid missing the zero transition when another
  F2FS_WB_CP_DATA writeback is submitted before the second get_pages()
  check. That is not the same issue as the v1/v2 UAF description.

  Please drop this patch. If you think the wakeup-latency issue is
still worth fixing
  separately, I can send a new patch without the UAF wording, Fixes
tag, or stable Cc.

  Thanks,

On Sat, Jun 20, 2026 at 3:57=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 6/18/26 18:05, Wenjie Qi wrote:
> > f2fs_write_end_io() decrements the writeback page counter and then read=
s
> > it again with get_pages() to decide whether the last F2FS_WB_CP_DATA
> > completion should wake cp_wait.
> >
> > That second read can miss the zero transition as below:
>
> Looks comments of v7 patch is quite different from the one of v1 patch?
>
> Quoted from v1:
>
> "f2fs_write_end_io() currently decrements the writeback page counter befo=
re
> waking sbi->cp_wait for the last F2FS_WB_CP_DATA completion.
>
> That decrement can drop the F2FS_WB_CP_DATA count to zero. It can unblock
> a concurrent unmount path waiting in f2fs_wait_on_all_pages(). Unmount ca=
n
> continue through f2fs_put_super() and eventually free sbi while the end_i=
o
> callback is still about to evaluate wq_has_sleeper() and wake_up() on
> sbi->cp_wait.
>
> Commit 2d9c4a4ed4ee ("f2fs: fix UAF caused by decrementing sbi->nr_pages[=
]
> in f2fs_write_end_io()") fixed one post-decrement sbi access by moving th=
e
> warm-node-list handling before dec_page_count(). The compressed writeback
> path follows the same rule and documents that dec_page_count() must be th=
e
> last access to sbi when it can drop F2FS_WB_CP_DATA to zero.
>
> Apply the same ordering rule to the cp_wait wakeup. Check whether this is
> the last F2FS_WB_CP_DATA completion and wake the waiter before the counte=
r
> decrement. Then the callback no longer dereferences sbi->cp_wait after th=
e
> lifetime boundary. A waiter that runs before the decrement may observe ol=
d
> count and sleep until the one-jiffy timeout, but correctness no longer
> depends on touching sbi after the counter reaches zero."
>
> I may found something interesting: v7 codes try to fix UAF bug described =
in
> v1 comment, however v7 comment tries to explain what v2 codes want to do.
>
> I suspect your LLM goes another direction after prompted w/ my comments o=
n
> patch v1? Let me know I'm wrong. :P
>
> Thanks,
>
> >
> > checkpoint          end_io A              submitter B
> > - f2fs_wait_on_all_pages
> >   - get_pages() > 0
> >   - prepare_to_wait(cp_wait)
> >   - io_schedule_timeout
> >                      - f2fs_write_end_io
> >                       - dec_page_count
> >                        : count 1 -> 0
> >                                           - f2fs_submit_page_write
> >                                            - inc_page_count
> >                                             : count 0 -> 1
> >                       - get_pages() > 0
> >                         : skip wake_up(cp_wait)
> >
> > The checkpoint thread can then keep sleeping until
> > DEFAULT_SCHEDULE_TIMEOUT, even though end_io A completed the old last
> > F2FS_WB_CP_DATA page.
> >
> > Use the post-decrement value for F2FS_WB_CP_DATA completions so the wak=
eup
> > decision is tied to this completion.  Keep the existing dec_page_count(=
)
> > path for other writeback counters.
> >
> > Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint =
for better performance")
> > Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> > ---
> >   fs/f2fs/data.c | 12 +++++++-----
> >   fs/f2fs/f2fs.h |  6 ++++++
> >   2 files changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index d83a21998ec2..2afdcd209d54 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
> >               if (f2fs_in_warm_node_list(folio))
> >                       f2fs_del_fsync_node_entry(sbi, folio);
> >
> > -             dec_page_count(sbi, type);
> > -
> >               /*
> >                * we should access sbi before folio_end_writeback() to
> >                * avoid racing w/ kill_f2fs_super()
> >                */
> > -             if (type =3D=3D F2FS_WB_CP_DATA && !get_pages(sbi, type) =
&&
> > -                             wq_has_sleeper(&sbi->cp_wait))
> > -                     wake_up(&sbi->cp_wait);
> > +             if (type =3D=3D F2FS_WB_CP_DATA) {
> > +                     if (!dec_page_count_return(sbi, type) &&
> > +                         wq_has_sleeper(&sbi->cp_wait))
> > +                             wake_up(&sbi->cp_wait);
> > +             } else {
> > +                     dec_page_count(sbi, type);
> > +             }
> >
> >               folio_clear_f2fs_gcing(folio);
> >               folio_end_writeback(folio);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9f24287de4c3..db750cef371d 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2776,6 +2776,12 @@ static inline void dec_page_count(struct f2fs_sb=
_info *sbi, int count_type)
> >       atomic_dec(&sbi->nr_pages[count_type]);
> >   }
> >
> > +static inline int dec_page_count_return(struct f2fs_sb_info *sbi,
> > +                                     int count_type)
> > +{
> > +     return atomic_dec_return(&sbi->nr_pages[count_type]);
> > +}
> > +
> >   static inline void inode_dec_dirty_pages(struct inode *inode)
> >   {
> >       if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
> >
> > base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
>
