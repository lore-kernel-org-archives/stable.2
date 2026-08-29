Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641402AD32
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787977056; cv=pass; b=r05dI0UvZYRh4ssHnnAAlG5OPQNYwj3R6P24pl6lJlNP1jA8OJFTCu9al0ZT93EiaWmq4s1AdiPzVbl5aADzvtOz5qkb8sNes3mZmyokky20uWWzhiBJQ9UEQL/KjjyaoMJT/LlTqHhjpiU5hepvbSP49uhvy4ZvWjveIPGas2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787977056; c=relaxed/simple;
	bh=bjoY9oqvolGqdtDc6vuGgUTcnhPEKY1Ns5f4rbZ3UYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNijekXxiwWRhdRkqxUPAriQ9Y7tzJ1lTVnezbGjY+L7ZSureGQ74EQw4d6DJnUcVv9E1xPgr5SoPvPiYfPD0x3JEB09xU0xOrYbqiZZeBrsDOlSYcbvnCB3UuYzpHTS+pU1GQC5lSoKCxJfPreFSS7wKhiWpoQehzygxBI+LOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU1BCn6f; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU1BCn6f"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c86945164so11795971fa.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 21:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787977052; cv=none;
        d=google.com; s=arc-20260327;
        b=gmPzDo5TWS5SKLEEow4vSmd+dZAvLiX3LR3YdLRY2iGRv9w1FLRonH4U5cq5GpPU7b
         JsBKzn0tJKFUGyNjkOZYXInr8XyxJx037ju09JEctVC8hlNGMO5JdeQpHl21tQDP3snp
         IRtv+kiDvtyGb9r2p7Y0phUN6P9y25qvlWdOeN5yv/oEenoxAn96E5kqXbmy+VFy6db0
         6dkV1FWpfQFrlfpxGmiZ/QTBkQXLw4fNiFIA7v3eV7AguSeVZePKQeNVACDsu+a3FwgE
         /X1spqy/5fcTkjx0nGrAVas6dNCCSnpmcOnJMjFTVDpWQPONnM+ihTBvP//wsVYYu6aD
         1H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4HqNZvyx47EZ8XniDObZvQkzh6muds/7cAeMJJPMM8=;
        fh=sKAsviq1zY30DvQzG9nLi3la5ATQ7bFTpm+ocH9N7ts=;
        b=qpINOefxYI0qgAbsrUj8KMlxhEsKBkKiiFKocFZgfShwJE1AYFtf3ZwUX66eRAwgIx
         4D2Ui1jX9Tml1DtjCwKi43Hi6eC98lbzRDIxl9VT8fDkQwp+oMV1NmSB/BCd7/A+n9NS
         Ae/J2jr615WaKOagH73t2J075hjDQHQnMZj5CObFxcjJf0IBFU7ShxEsTyA6eoABj5nK
         //1uYaFObkxHfT71FPXCfTYtXTCvQ1irIJSUfgqOZCBmo0Bx0kR2+pe+8TOPTnR6ZOby
         Q3C6JVlK8QQOt0fLHCmSJrqI9XreKFvy7dA2XrY/6gSQiqpcfPHLt8am/+HEURGZorAG
         rLDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787977052; x=1788581852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4HqNZvyx47EZ8XniDObZvQkzh6muds/7cAeMJJPMM8=;
        b=ZU1BCn6fZ9YChf61sYCTW/oCYRNYdhnsj3vDs7k4f5Eav4423wZwXkYyXend5G9/KE
         O9QT1oIK0SVXLFZtysMa7sUEkM4jJ9tmSLWf5JN9tSTvJCbU4SKzANHhSjtCa16FoPez
         7bPRHPiwB7yeBn+l9n4HyNO846BBYUNKsXjzzKw/2ewcZ/3SPzKjDeZq8y3JaavwAK0g
         m90Y/RRn9xxOdv29En6AP9FZsjIveD+RUMJGCWJesyiX0eEyzNy/0Se8tFfWAWEh03Qf
         L7sNGybeMLosldBNxaIFfLq4xH65POCaijtE6uKanTr+XEWpdvQ3hQ0B6Hj4wQDqTALt
         Wong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787977052; x=1788581852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4HqNZvyx47EZ8XniDObZvQkzh6muds/7cAeMJJPMM8=;
        b=ghIYrPOf3HJvr0XxC/JAK2byz1ScJUTESo4i8d9TSGBYgMwNU6SxnQIuYINoc/foDR
         Z8X2EcBmrE2qN3VXN2g9kKrV2OYIl+KZYAlT1wrZ4Y9qmM3PDALkOZr8BIMgRj1ENk+J
         fpyJv18q+FgLWCQoVAxzBJ0jbhxoRReE9JJ41S8L8UJFxxIEU9VSMgvzj9V+Lzku/+WK
         ybw9J9SFU9q5Su45zZWqvdl5ajQD2BisV7P6EJntCbgSBYR60URU6O1frQlZ0FOa/dtP
         rEWZ2VSF+XTTB+zl0jqck4JFDHrY+gKbrLBGcohuO+ejEFW8yVI3cvW8u4sYq3L+cj9M
         VfGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqqXZ7WqMhgiARCTTrhvrOvaPJb1oCb5FZ/t7v5mMgmxKCPE3jE0HmKQhMM2D2jKpiysys6OY=@vger.kernel.org
X-Gm-Message-State: AFuF++k0ws+ppaLW9/dzTw3aHa4AFd2vK3xz4GAtUjH1Uc/4sGKH7gl+
	+U+99SXYeOIgMGH9LZNmQva5j2k+qpt3PHn/fDOAePWIq6X9mmXlLjeN6LIM+fgXst+dSAVLw79
	xCS/sVXIFcQ7W8L4ckRYjYMj/M9yqVOE=
X-Gm-Gg: AR+sD11N6PIo0yi9NTbygXzi4AoaJCnan/7erNMrYPtOe5+SP2qw2luDiHYFFxwHmxA
	dWrb8nBJQhkA+32ARzy1GFPNQEu9ZuDaR6ET1jWGfPrb7wkzoHz/jRoMja/pQ3sSOybgvSun78C
	oonVJneSkp89NOCRs1IsNOP6rjm9iV6o0OGlYvDhC6tWSYpEYja8AvX31jncsAE6ytO9WGrA9rl
	o3HOFvZInOrZsjhj91bfGLEPhO5k5YizXZVaXFWSd7GRVm1z4oBJMRj0mBv9NYc2qF2f2/kR1P3
	AlmOOSAhHrRv2FfVsyg+WUznjpxvd/WiPXFzS1aed/0pUxKDGqZ4RN3j0zOTLQgv3z80ah155mB
	5TY5O6mym4J31DNzMgAGlPpK8u94GEohXE4k=
X-Received: by 2002:a05:651c:a20a:20b0:396:9897:4cc5 with SMTP id
 38308e7fff4ca-3a3018456f8mr16240361fa.5.1787977051834; Fri, 28 Aug 2026
 21:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829031717.2581247-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260829031717.2581247-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 28 Aug 2026 21:17:19 -0700
X-Gm-Features: AcwNN1Vw4HMQEEq6zrJCKTUaBEKCs3TTM6RFdrxlohqFatV74PPTpjP_46b4Xh4
Message-ID: <CACOAw_yr5jqkZZRoNhzNJ=n3Y3y8Pp3AcZEt3T3DV6bvoKm-Ew@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: sync pending discards before reserving device alias
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	qiwenjie@xiaomi.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:17=E2=80=AFPM Wenjie Qi <qwjhust@gmail.com> wrote=
:
>
> Releasing a device alias can leave pending discard commands covering
> its range. Reserving the alias makes the same blocks valid again. If a
> pending command is submitted afterward, __check_sit_bitmap() observes
> valid blocks and triggers a BUG.
>
> The reserve ioctl is the ownership transition from F2FS allocation to
> external use. While the range is released, normal F2FS allocation
> already synchronizes a pending discard before reusing each block. A
> release-time drain would also not cover commands generated before a
> later reserve, so synchronize the range at the reserve boundary.
>
> Synchronize discard commands for the alias range under sentry_lock
> before marking the range valid. Walk overlapping commands instead of
> every block, cancel prepared command intervals in bulk, and wait each
> submitted command once. Use a 64-bit cursor and exclusive end so a range
> ending at 2^32 blocks does not wrap.
>
> Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device al=
iasing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> Changes since v2:
> - Walk overlapping discard commands instead of every filesystem block.
> - Use a 64-bit range cursor and exclusive end.
> - Make the commit message describe the standalone final change.
> - Clarify reserve as the ownership transition to external use.
>
>   kernel BUG at fs/f2fs/segment.c:1228!
>   Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
>   CPU: 1 UID: 0 PID: 79 Comm: f2fs_discard-25
>   RIP: 0010:__check_sit_bitmap+0x2e1/0x4e0
>   Call Trace:
>    __submit_discard_cmd+0x921/0x1140
>    __issue_discard_cmd+0x524/0x12f0
>    issue_discard_thread+0x686/0xe20
>
>  fs/f2fs/segment.c | 159 +++++++++++++++++++++++++++-------------------
>  1 file changed, 94 insertions(+), 65 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1e7e745be71d..c4fb1e5f9a34 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1069,26 +1069,6 @@ static bool f2fs_check_discard_tree(struct f2fs_sb=
_info *sbi)
>         return true;
>  }
>
> -static struct discard_cmd *__lookup_discard_cmd(struct f2fs_sb_info *sbi=
,
> -                                               block_t blkaddr)
> -{
> -       struct discard_cmd_control *dcc =3D SM_I(sbi)->dcc_info;
> -       struct rb_node *node =3D dcc->root.rb_root.rb_node;
> -       struct discard_cmd *dc;
> -
> -       while (node) {
> -               dc =3D rb_entry(node, struct discard_cmd, rb_node);
> -
> -               if (blkaddr < dc->di.lstart)
> -                       node =3D node->rb_left;
> -               else if (blkaddr >=3D dc->di.lstart + dc->di.len)
> -                       node =3D node->rb_right;
> -               else
> -                       return dc;
> -       }
> -       return NULL;
> -}
> -
>  static struct discard_cmd *__lookup_discard_cmd_ret(struct rb_root_cache=
d *root,
>                                 block_t blkaddr,
>                                 struct discard_cmd **prev_entry,
> @@ -1114,7 +1094,7 @@ static struct discard_cmd *__lookup_discard_cmd_ret=
(struct rb_root_cached *root,
>
>                 if (blkaddr < dc->di.lstart)
>                         pnode =3D &(*pnode)->rb_left;
> -               else if (blkaddr >=3D dc->di.lstart + dc->di.len)
> +               else if ((u64)blkaddr >=3D (u64)dc->di.lstart + dc->di.le=
n)
>                         pnode =3D &(*pnode)->rb_right;
>                 else
>                         goto lookup_neighbors;
> @@ -1472,42 +1452,56 @@ static void __relocate_discard_cmd(struct discard=
_cmd_control *dcc,
>         list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->di.len)])=
;
>  }
>
> -static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
> -                               struct discard_cmd *dc, block_t blkaddr)
> +static void __punch_discard_cmd_range(struct f2fs_sb_info *sbi,
> +                                     struct discard_cmd *dc, block_t lst=
art,
> +                                     unsigned int len)
>  {
>         struct discard_cmd_control *dcc =3D SM_I(sbi)->dcc_info;
>         struct discard_info di =3D dc->di;
> +       u64 end =3D (u64)lstart + len;
> +       u64 di_end =3D (u64)di.lstart + di.len;
>         bool modified =3D false;
>
> -       if (dc->state =3D=3D D_DONE || dc->di.len =3D=3D 1) {
> +       f2fs_bug_on(sbi, dc->state !=3D D_PREP || !len ||
> +                   lstart < di.lstart || end > di_end);
> +
> +       if (lstart =3D=3D di.lstart && end =3D=3D di_end) {
>                 __remove_discard_cmd(sbi, dc);
>                 return;
>         }
>
>         dcc->undiscard_blks -=3D di.len;
> -
> -       if (blkaddr > di.lstart) {
> -               dc->di.len =3D blkaddr - dc->di.lstart;
> +       if (lstart > di.lstart) {
> +               dc->di.len =3D lstart - di.lstart;
>                 dcc->undiscard_blks +=3D dc->di.len;
>                 __relocate_discard_cmd(dcc, dc);
>                 modified =3D true;
>         }
>
> -       if (blkaddr < di.lstart + di.len - 1) {
> +       if (end < di_end) {
> +               block_t right_lstart =3D (block_t)end;
> +               unsigned int right_len =3D (unsigned int)(di_end - end);
> +               block_t right_start =3D di.start + right_lstart - di.lsta=
rt;
> +
>                 if (modified) {
> -                       __insert_discard_cmd(sbi, dc->bdev, blkaddr + 1,
> -                                       di.start + blkaddr + 1 - di.lstar=
t,
> -                                       di.lstart + di.len - 1 - blkaddr)=
;
> +                       __insert_discard_cmd(sbi, dc->bdev, right_lstart,
> +                                            right_start, right_len);
>                 } else {
> -                       dc->di.lstart++;
> -                       dc->di.len--;
> -                       dc->di.start++;
> -                       dcc->undiscard_blks +=3D dc->di.len;
> +                       dc->di.lstart =3D right_lstart;
> +                       dc->di.start =3D right_start;
> +                       dc->di.len =3D right_len;
> +                       dcc->undiscard_blks +=3D right_len;
>                         __relocate_discard_cmd(dcc, dc);
>                 }
>         }
>  }
>
> +static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
> +                               struct discard_cmd *dc, block_t blkaddr)
> +{
> +       __punch_discard_cmd_range(sbi, dc, blkaddr, 1);
> +}
> +
>  static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>                                 struct block_device *bdev, block_t lstart=
,
>                                 block_t start, block_t len)
> @@ -1872,48 +1866,82 @@ static unsigned int __wait_all_discard_cmd(struct=
 f2fs_sb_info *sbi,
>  }
>
>  /* This should be covered by global mutex, &sit_i->sentry_lock */
> -static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blka=
ddr)
> +static void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi,
> +                                  block_t blkaddr, unsigned int len)
>  {
>         struct discard_cmd_control *dcc =3D SM_I(sbi)->dcc_info;
> -       struct discard_cmd *dc;
> -       bool need_wait =3D false;
> +       u64 cursor =3D blkaddr;
> +       u64 end =3D cursor + len;
>
> -       mutex_lock(&dcc->cmd_lock);
> -       dc =3D __lookup_discard_cmd(sbi, blkaddr);
> -#ifdef CONFIG_BLK_DEV_ZONED
> -       if (dc && f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(dc->bdev)) {
> -               int devi =3D f2fs_bdev_index(sbi, dc->bdev);
> +       f2fs_bug_on(sbi, end > (u64)U32_MAX + 1);
> +
> +       while (cursor < end) {
> +               struct discard_cmd *prev_dc =3D NULL, *next_dc =3D NULL;
> +               struct discard_cmd *dc;
> +               struct rb_node **insert_p =3D NULL, *insert_parent =3D NU=
LL;
> +               u64 dc_end, overlap_end;
> +               unsigned int overlap_len;
> +               bool need_wait =3D false;
>
> -               if (devi < 0) {
> +               mutex_lock(&dcc->cmd_lock);
> +               dc =3D __lookup_discard_cmd_ret(&dcc->root, (block_t)curs=
or,
> +                                             &prev_dc, &next_dc, &insert=
_p, &insert_parent);
> +               if (!dc)
> +                       dc =3D next_dc;
> +               if (!dc || (u64)dc->di.lstart >=3D end) {
>                         mutex_unlock(&dcc->cmd_lock);
> -                       return;
> +                       break;
>                 }
>
> -               if (f2fs_blkz_is_seq(sbi, devi, dc->di.start)) {
> -                       /* force submit zone reset */
> -                       if (dc->state =3D=3D D_PREP)
> -                               __submit_zone_reset_cmd(sbi, dc, REQ_SYNC=
,
> -                                                       &dcc->wait_list, =
NULL);
> -                       dc->ref++;
> -                       mutex_unlock(&dcc->cmd_lock);
> -                       /* wait zone reset */
> -                       __wait_one_discard_bio(sbi, dc);
> -                       return;
> +               if (cursor < dc->di.lstart)
> +                       cursor =3D dc->di.lstart;
> +               dc_end =3D (u64)dc->di.lstart + dc->di.len;
> +               overlap_end =3D min(end, dc_end);
> +               overlap_len =3D (unsigned int)(overlap_end - cursor);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +               if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(dc->bdev))=
 {
> +                       int devi =3D f2fs_bdev_index(sbi, dc->bdev);
> +
> +                       if (devi < 0) {
> +                               mutex_unlock(&dcc->cmd_lock);
> +                               return;
> +                       }
> +
> +                       if (f2fs_blkz_is_seq(sbi, devi, dc->di.start)) {
> +                               if (dc->state =3D=3D D_PREP)
> +                                       __submit_zone_reset_cmd(sbi, dc, =
REQ_SYNC,
> +                                                               &dcc->wai=
t_list, NULL);
> +                               dc->ref++;
> +                               need_wait =3D true;
> +                       }
>                 }
> -       }
>  #endif
> -       if (dc) {
> -               if (dc->state =3D=3D D_PREP) {
> -                       __punch_discard_cmd(sbi, dc, blkaddr);
> -               } else {
> -                       dc->ref++;
> -                       need_wait =3D true;
> +               if (!need_wait) {
> +                       if (dc->state =3D=3D D_PREP) {
> +                               if (len =3D=3D 1)
> +                                       __punch_discard_cmd(sbi, dc,
> +                                                           (block_t)curs=
or);
> +                               else
> +                                       __punch_discard_cmd_range(sbi, dc=
,
> +                                                                 (block_=
t)cursor,
> +                                                                 overlap=
_len);
> +                       } else {
> +                               dc->ref++;
> +                               need_wait =3D true;
> +                       }
>                 }
> +               mutex_unlock(&dcc->cmd_lock);
> +               if (need_wait)
> +                       __wait_one_discard_bio(sbi, dc);
> +               cursor =3D overlap_end;
>         }
> -       mutex_unlock(&dcc->cmd_lock);
> +}
>
> -       if (need_wait)
> -               __wait_one_discard_bio(sbi, dc);
> +static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi,
> +                                 block_t blkaddr)
> +{
> +       f2fs_wait_discard_bios(sbi, blkaddr, 1);
>  }
>
>  void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
> @@ -2684,6 +2712,7 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info =
*sbi, block_t addr,
>         seg_num =3D GET_SEGNO(sbi, addr_end) - segno + 1;
>
>         down_write(&sit_i->sentry_lock);
> +       f2fs_wait_discard_bios(sbi, addr, len);
>
>         if (seg_num =3D=3D 1)
>                 cnt =3D len;
> --

Hi Wenjie,

Thanks for the updated v3 patch.

While synchronizing pending discards before reserving the device alias is t=
he
right direction to prevent the __check_sit_bitmap() BUG, I see two major is=
sues
with this implementation:
1. Critical Lock Contention (Sleeping under down_write(&sit_i->sentry_lock)=
):
   In your patch, f2fs_wait_discard_bios() is called inside
f2fs_reserve_device_alias()
   after acquiring down_write(&sit_i->sentry_lock):
       down_write(&sit_i->sentry_lock);
       f2fs_wait_discard_bios(sbi, addr, len);
   `sentry_lock` is one of the most contended global locks in F2FS. Sleepin=
g
   for storage I/O completion while holding
`down_write(&sit_i->sentry_lock)` will
   freeze all concurrent block allocations and write operations across
the entire
   system for hundreds of milliseconds.
2. Unnecessary Code Complexity:
   Modifying the core discard punch logic with __punch_discard_cmd_range() =
and
   re-inserting split discard entries into the rbtree via __insert_discard_=
cmd()
   introduces substantial complexity and potential regression risks to core
   discard paths. For device aliasing, reservation covers the whole
target device
   range, so overlapping pending commands can simply be dropped in bulk.

### Proposed Solution
We can resolve this much more simply and safely by introducing a
lightweight range
helper `f2fs_drop_discard_cmd_range(sbi, start, len)` and calling it inside
`f2fs_ioc_reserve_dev_alias()` BEFORE acquiring `sentry_lock`:
- It drops pending D_PREP commands in O(log N) and waits for in-flight
bios under
  `dcc->cmd_lock` without holding `sentry_lock` (zero global lock contentio=
n).
- It requires only ~35 lines of self-contained code without altering existi=
ng
  punch/lookup mechanisms.
- It completely eliminates the __check_sit_bitmap() crash.

I have already verified this cleaner fix and will send out the patch
shortly for review.

Thanks,

> 2.43.0
