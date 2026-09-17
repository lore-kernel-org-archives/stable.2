Received: from mail-lr2-f13.google.com (mail-lr2-f13.google.com [74.125.230.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962A3546DE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624481; cv=pass; b=GRstJf4r1KReA7PxvE2444D4xloWdqukk+cMdCFTtjPF0SkSJW/eT5zAeJkaKK0c4coZHuUdtjJIsNsV9yGnyBuXiZkjvHmE1IJb+iDgQNlRgxBQuLzkfWBWJtDCgB57NUBmmJkop4qTsn0axeVTQuwUigEEod+c2J8KGgTB7Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624481; c=relaxed/simple;
	bh=aZ9SeR3phIMgV3BYgxn90OwcFOc2AJJCVlqwZ4QWULk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNCQhol3htdkUdlrHm3BqzRK/z7BPN097Em0wu9UN88yEUlEwG+RglFAgqVzkQCRqnhcmsUw/bl6b1SpiFns5GsdfzdNoH6PFJBk/3s+hWLCLOs7Xx9EtSZteXs3s03m3GO+iuzDdGnt+7XzH/+upU7MGv8Yxl6VYiVHFbG2waE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExkrfvVL; arc=pass smtp.client-ip=74.125.230.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExkrfvVL"
Received: by mail-lr2-f13.google.com with SMTP id 38308e7fff4ca-3a302c06eceso4112281fa.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789624478; cv=none;
        d=google.com; s=arc-20260327;
        b=MWpEBS3C/mcQwFuvvZk4vo8ux9lVFGYAdSpviPZIkWr4DvQZN7l1C15DSIU9Uaj2B4
         a/aul5bUePyX64Ic/FWGtTp2jbVqBIR7xgKcpPGZHz7DqhwdE+O3H8XO063vSB0kz0zx
         4GEUvpSFTHzBXVo1IEqG+KiAS+8AP96vp4je+0x6ANHbriO4/7vAKjmu8r1Dy81Nv0o9
         nE0c+E+uGYxu5MBnjKtaFG3oZVszQK8g62220COVX4keUILxf6/2kidCkTUF64zyk84B
         YCv0Z/KJAUkuGiUMV6AlDBKN5+mGSpv02qvnU+QQx6KnpBAGc4ru2GdlLCT6l1nb8aMr
         hIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Loxv+QhHSvLuHlVpy8FfAmdK0Orcs+Qj7V2Brl/51zo=;
        fh=K5OqraMuJzPlscY0ZJwOxrKMXjg7JqVl47VQFr6wZR8=;
        b=SELxiWei56NUGnEnAQqT/Yn4e0D6/9GXzoc2mfKn6WvPn0T+husdW8DMCSF0Feiw2t
         aHck+S4HM7xrKzeTrqgQ7arxaek3FJULzJpyyx71BO695ZI9dEfFYOqw8KVfqbD0DKA6
         tPwcyUYV3bMAW5iFqWxFCJpvIuzp2LHdObEBmJzjY31+RjHcHLGV/VCpUuU0NeJ72nFG
         ZlKIej8sF4cvzN41OdYQ0wlcoI9WtpPS6FzvrDN5HBlSMw2+02btnbAUu8gFKliejBvU
         tcIXBtMsAvMbkzgA+rhGTlAwFShc4tA6oIuptPTiXjpvsyLLXHw+ZsqYodCR6Bwa8J71
         ZtsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789624478; x=1790229278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Loxv+QhHSvLuHlVpy8FfAmdK0Orcs+Qj7V2Brl/51zo=;
        b=ExkrfvVLESVYhTjGFLig3lY2GMnIZlD571sRoFKYfHAIy6Q+hQi0a6qO8mjjACFS8Y
         4JuD8qtpd+5YrxuZKkBe6T+CW0wfwm+x61PCvMfdEBZ7QTY6oaIfN2ExYZkqFMV6gP1x
         Squhkouh7NZy5qolYnpdIUHx91yQqxvoGDUXNd6UCwJuA0VjY88JDepxn6l2SqO8grzN
         vUbOB0SaBqfEEitOBp4z88fjdxm9d2yclhAJYvhIm2rwE0Z1u/Vw2lgwM3a1h+ZszpaF
         BjuWm6tc37PdLzXIBgguuwfVgQPlaSubiKProbRQveNOZ8TwvP1sBhxSAg3LUZkSpcrb
         H1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789624478; x=1790229278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Loxv+QhHSvLuHlVpy8FfAmdK0Orcs+Qj7V2Brl/51zo=;
        b=GLvvWmPAr0sSO0Y8dTchpPBtJ+TIU6c4UNeE8ovBJuy1ghab2/eCuZkIp0WrMOOgbw
         cCBjjHNi9Hnf6E1DumvXrEUotX7dogTyIu/YTrXbjL733mvvXXwwjCTFhxBYIIczEgth
         708Lt1dQ51c7s3M6918oss0eKLeYYsGykRtyjFW0abmzBFZTb+QC+VfiWV4eXdj31Jdl
         K+4Sqw17+n8DaUg2YHeSTyND0nI83//b0gwOSSRxScU8/zjvoAI7ZCkBsBZQ7OgOtbQ2
         5DH5+FfWUVw++Unr2oysZ42cru1YIk54Ctp+9zYZO+OFiVjKA0w4JxzZKIruG6233wrI
         NoIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv7/mjOyjuTyK18kzhjAahPguMoVGc3EP6Uydrj5lwokWXK5FarWgxjEChdpBXjnqle0UqsE4=@vger.kernel.org
X-Gm-Message-State: AFuF++ktbZ+syTWGfe1L1lCD67mn5nKl14ds2P12TcQuL4ScWMSNwZJ7
	BmVa4IovYxO2eze/R2qtTM0HWQHmfHVfEASRcydc7DVq3ldqPd62JSaHRZ0mVTeCqW2ex5J2Vp1
	3oLi863aJIWdFHHQHpTbCDmYAEGRdc5w=
X-Gm-Gg: AYBFou33rm1Qq2T1s4yurEjwWrZRBZVoHmtXucIb2qzFjpDLqEYIGmSN3SJRYHA+Rb9
	zRLMBYDYxTneYBWDAEsVHm1gXdAjKLyT3xHSWb5ZfJFLFAZfvdcvc2rIRnwByOGKsr1PGmBadGd
	gg3qQ3KxtdMwFiEsqRtsrgqFkvsFcytpC+rwm53VI2lkerHfT5NmLnYqkXRFQABcRrVOKEqnca5
	j6xBG2rdL4oPUe0/rcTvOOAGTnXFZVTQ53KLxllgzARgym7rQwWKNMqItRMXwTuhUY9JaXXkDUh
	c8BostvzKNBMFRzaB8ZAmUK7vVOnoeh6SUOSeIilfaYchh0NgDKcDhqAeizjb8J/8as=
X-Received: by 2002:a05:651c:1502:b0:3a3:7681:6d58 with SMTP id
 38308e7fff4ca-3a5dc9f3bcemr9547401fa.16.1789624477503; Wed, 16 Sep 2026
 22:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902112121.2125383-1-r772577952@gmail.com>
In-Reply-To: <20260902112121.2125383-1-r772577952@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 17 Sep 2026 14:54:20 +0900
X-Gm-Features: AcwNN1WD2-Nx19sNxSzkTzJTuC6ajr8ZESmiVDKvdEkAcL3pR5ww_y0VMIQv66k
Message-ID: <CAKFNMomt1ORpeCrVyNEzJNB6aRv-1v2bdCxqB_d6YZk3XFwX4Q@mail.gmail.com>
Subject: Re: [PATCH v2] nilfs2: force clear dirty state when restoring from
 the shadow map
To: slava@dubeyko.com
Cc: Jiaming Zhang <r772577952@gmail.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:21=E2=80=AFPM Jiaming Zhang wrote:
>
> When garbage collection fails, nilfs2 rolls the DAT metadata file's page
> cache back to a shadow copy taken before GC started.
> nilfs_clear_dirty_pages() drops the dirty state of the folios in the DAT
> cache, then nilfs_copy_back_pages() overwrites them with the saved
> contents and warns if one is still dirty:
>
>         /* overwrite existing folio in the destination cache */
>         WARN_ON(folio_test_dirty(dfolio));
>
> nilfs_clear_dirty_pages() used to clear the dirty state unconditionally,
> which is safe here because the rollback runs with the log writer
> stopped, so nothing else can dirty the cache while it runs.  The same
> helper is also used when writeback finds dirty folios after the
> filesystem has degraded to read-only, where it does run concurrently
> with the log writer, so commit ca76bb226bf4 ("nilfs2: do not force clear
> folio if buffer is referenced") made nilfs_clear_folio_dirty() skip a
> folio if any of its buffer heads is busy.  The rollback caller shares
> that helper, so its clearing step can now return with a folio still
> dirty.
>
> A DAT folio can hold a busy buffer head without anyone modifying the
> folio: nilfs_mdt_read_block() submits read-ahead for the blocks
> following the one it was asked for and waits only for the first, so the
> read-ahead buffers are still locked when it returns.  With a block size
> smaller than the page size, a locked read-ahead buffer can share a folio
> with a block that GC dirtied and keep the whole folio dirty past the
> clearing step.
>
> Add a force flag to nilfs_clear_dirty_pages() and
> nilfs_clear_folio_dirty() that skips the busy buffer check, and set it
> in the two calls from nilfs_mdt_restore_from_shadow_map().  The
> read-only fallback callers keep passing false, so that commit still
> protects them and the WARN_ON() is left alone.
>
> Fixes: ca76bb226bf4 ("nilfs2: do not force clear folio if buffer is refer=
enced")
> Closes: https://lore.kernel.org/lkml/CANypQFZSYrtcshnUzOPiqatyLd-M8_OReOe=
wQoAi_V5yY0dTtg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Assisted-by: Claude Code:claude-opus-5
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v2:
> - Keep the WARN_ON() in nilfs_copy_back_pages() untouched.
> - Add a bool force argument to nilfs_clear_dirty_pages() and
>   nilfs_clear_folio_dirty(), and set it to true in the two calls from
>   nilfs_mdt_restore_from_shadow_map().
>
> v1: https://lore.kernel.org/lkml/20260901134430.1292467-1-r772577952@gmai=
l.com/

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Viacheslav, could you please apply this directly to your tree?

Both the patch contents and the test results were exactly as expected.

Thanks,
Ryusuke Konishi

>
>  fs/nilfs2/inode.c |  2 +-
>  fs/nilfs2/mdt.c   |  6 +++---
>  fs/nilfs2/page.c  | 50 +++++++++++++++++++++++++++--------------------
>  fs/nilfs2/page.h  |  4 ++--
>  4 files changed, 35 insertions(+), 27 deletions(-)
>
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 34e6096069ad..64437aed8390 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -163,7 +163,7 @@ static int nilfs_writepages(struct address_space *map=
ping,
>         int err =3D 0;
>
>         if (sb_rdonly(inode->i_sb)) {
> -               nilfs_clear_dirty_pages(mapping);
> +               nilfs_clear_dirty_pages(mapping, false);
>                 return -EROFS;
>         }
>
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index 2a435349fd21..b50c88b65183 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -405,7 +405,7 @@ static int nilfs_mdt_write_folio(struct folio *folio,
>                  * have dirty folios that try to be flushed in background=
.
>                  * So, here we simply discard this dirty folio.
>                  */
> -               nilfs_clear_folio_dirty(folio);
> +               nilfs_clear_folio_dirty(folio, false);
>                 folio_unlock(folio);
>                 return -EROFS;
>         }
> @@ -648,10 +648,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode=
 *inode)
>         if (mi->mi_palloc_cache)
>                 nilfs_palloc_clear_cache(inode);
>
> -       nilfs_clear_dirty_pages(inode->i_mapping);
> +       nilfs_clear_dirty_pages(inode->i_mapping, true);
>         nilfs_copy_back_pages(inode->i_mapping, shadow->inode->i_mapping)=
;
>
> -       nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping);
> +       nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true);
>         nilfs_copy_back_pages(ii->i_assoc_inode->i_mapping,
>                               NILFS_I(shadow->inode)->i_assoc_inode->i_ma=
pping);
>
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index cf4f1c6798f5..857926da9f21 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -369,8 +369,9 @@ void nilfs_copy_back_pages(struct address_space *dmap=
,
>  /**
>   * nilfs_clear_dirty_pages - discard dirty pages in address space
>   * @mapping: address space with dirty pages for discarding
> + * @force: whether to clear the dirty state regardless of busy buffer he=
ads
>   */
> -void nilfs_clear_dirty_pages(struct address_space *mapping)
> +void nilfs_clear_dirty_pages(struct address_space *mapping, bool force)
>  {
>         struct folio_batch fbatch;
>         unsigned int i;
> @@ -391,7 +392,7 @@ void nilfs_clear_dirty_pages(struct address_space *ma=
pping)
>                          * was acquired.  Skip processing in that case.
>                          */
>                         if (likely(folio->mapping =3D=3D mapping))
> -                               nilfs_clear_folio_dirty(folio);
> +                               nilfs_clear_folio_dirty(folio, force);
>
>                         folio_unlock(folio);
>                 }
> @@ -403,13 +404,16 @@ void nilfs_clear_dirty_pages(struct address_space *=
mapping)
>  /**
>   * nilfs_clear_folio_dirty - discard dirty folio
>   * @folio: dirty folio that will be discarded
> + * @force: whether to clear the states regardless of busy buffer heads
>   *
>   * nilfs_clear_folio_dirty() clears working states including dirty state=
 for
> - * the folio and its buffers.  If the folio has buffers, clear only if i=
t is
> - * confirmed that none of the buffer heads are busy (none have valid
> - * references and none are locked).
> + * the folio and its buffers.  If the folio has buffers and force is fal=
se,
> + * clear only if it is confirmed that none of the buffer heads are busy =
(none
> + * have valid references and none are locked).  If force is true, the st=
ates
> + * are cleared unconditionally, the caller should guarantee that the fol=
io is
> + * not being modified concurrently.
>   */
> -void nilfs_clear_folio_dirty(struct folio *folio)
> +void nilfs_clear_folio_dirty(struct folio *folio, bool force)
>  {
>         struct buffer_head *bh, *head;
>
> @@ -422,24 +426,28 @@ void nilfs_clear_folio_dirty(struct folio *folio)
>                          BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
>                          BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected)=
 |
>                          BIT(BH_Delay));
> -               bool busy, invalidated =3D false;
> +
> +               if (!force) {
> +                       bool busy, invalidated =3D false;
>
>  recheck_buffers:
> -               busy =3D false;
> -               bh =3D head;
> -               do {
> -                       if (atomic_read(&bh->b_count) | buffer_locked(bh)=
) {
> -                               busy =3D true;
> -                               break;
> +                       busy =3D false;
> +                       bh =3D head;
> +                       do {
> +                               if (atomic_read(&bh->b_count) |
> +                                   buffer_locked(bh)) {
> +                                       busy =3D true;
> +                                       break;
> +                               }
> +                       } while (bh =3D bh->b_this_page, bh !=3D head);
> +
> +                       if (busy) {
> +                               if (invalidated)
> +                                       return;
> +                               invalidate_bh_lrus();
> +                               invalidated =3D true;
> +                               goto recheck_buffers;
>                         }
> -               } while (bh =3D bh->b_this_page, bh !=3D head);
> -
> -               if (busy) {
> -                       if (invalidated)
> -                               return;
> -                       invalidate_bh_lrus();
> -                       invalidated =3D true;
> -                       goto recheck_buffers;
>                 }
>
>                 bh =3D head;
> diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
> index 136cd1c143c9..c3ba3468af5c 100644
> --- a/fs/nilfs2/page.h
> +++ b/fs/nilfs2/page.h
> @@ -41,8 +41,8 @@ void nilfs_folio_bug(struct folio *);
>
>  int nilfs_copy_dirty_pages(struct address_space *, struct address_space =
*);
>  void nilfs_copy_back_pages(struct address_space *, struct address_space =
*);
> -void nilfs_clear_folio_dirty(struct folio *folio);
> -void nilfs_clear_dirty_pages(struct address_space *mapping);
> +void nilfs_clear_folio_dirty(struct folio *folio, bool force);
> +void nilfs_clear_dirty_pages(struct address_space *mapping, bool force);
>  unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
>                 unsigned int from, unsigned int to);
>  unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
> --
> 2.43.0
>
