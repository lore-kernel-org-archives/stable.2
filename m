Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF2233936
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367629; cv=pass; b=WnhZEBUe+kblx9olarJHvp7gCIXTJMBhJUmJl1TNxKbedYHw/NsZsu48UM9+ibCQ1rq/Nqt8zg5GmgcMLUPuJWZOGbPv+likzzEXLt/uzc7MWLAChLCyraQTNlqZ/sFlIxesBt6e/896tzm6ytDOQ/KIV/yU8l+MPh4lpxGACHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367629; c=relaxed/simple;
	bh=qVSQb5UUFlpMpFF0qmD+S8EfZnmOQhZUseo8tX+4a6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGls20epTk15QERMjGpYmIL0wmwc3LrGcZiv3PEVbh8v19ZqH1Q5JducbPHkpjhYrhtRjVWPZ8j1Bh/fxdR6Ii0n1ynplJx4xFb7ox1WHNdEStJHiteDyp8c53k5KQ5LYed3sN3z4wQ+5rStZhg8I1pJ+Sj2NuiBb2kh7n1pOyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK0H0Ff+; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK0H0Ff+"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c294183384fso464078466b.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 23:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789367625; cv=none;
        d=google.com; s=arc-20260327;
        b=Qctx57JwwmwDWnTXqrdCHawNgg47OuD9sT/xuMhEYg/eqKSQRL2tC5X7RGN/KacEMn
         Hx70yVexY5yyAW5FwMlmsgNXnObeaySOVQTvWkhnT7LDpbf9Fg6cDKuH6tTW46JQ7/cx
         orzu/x1YmFICHHLgHN3D8UrwKywTgtKxg7fD7VPMCVJTyk2vYiI01EypL7YUu7fecUcM
         lFy5iixVrx0MGCPgMPuVKTP6PZ+uNms8clrcs+Kh6PH6W/1AA5v8Wqk1FKRm+HQ7+ZFz
         Csfo+nbKOdari02RqTj+DuWBxOb58381g6qpqdNIFG6Bgr9hP6smGkuP3upDIiOo6+Xc
         JX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1bl/zgD2IYrG14tFUreeapLVdf9wP0XTfEPxuKsnHs=;
        fh=57jYOr4ekkvArIvzwwnsuLgg7JWqF7ZiMf2tvnLssbQ=;
        b=jvX7+g8Zjz5yGV0ArsY7qkWKzO8iXz648LTPIIwBpYFcrK4zDnGv7ob9m+aGvcfJs6
         ze96NNBD8weN3SaqVSXk8vth2TjTq4w0g3A8KxqCajuTdEiaNf2radPzRUGQdOmkVMGY
         A35S6fwewqkNgQ9KgJE4qG74C+LbPrR4Zjx36NnFAbrLSVymBTNW1NNIH1hsm+YRrhcO
         oGbq6o41D4YWevu9hrOUpK7TEIOFH0RHNiAXJEFsEeaFatkRo2PH1M7UftiEJXKbhqc8
         ZXPrJOWV3xT0bsbtEz/wxptuLhV970ejryU07sRMWdVqY3VH9wz7yr8pScWnpfSgx16o
         2Qnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789367625; x=1789972425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1bl/zgD2IYrG14tFUreeapLVdf9wP0XTfEPxuKsnHs=;
        b=JK0H0Ff+FyAQnZmfdGZDax2f7sDpxEi+EHJU8oXziFlzHW/vxw4YzGfZOlegD+AizZ
         KBpK1dR+xewxTndkOc5DUXOz7kHiXKZdfctyZUx9XKn+vsuiefBRIF440QyszywTuCO+
         R+BSyLF74m5EkXPKVrU1iG0EpcMDMc/ijKlIb6JIAz0Yhmo5ofma8dwcQ7vE7pQMsKtw
         cykBsjFbPEo8acMj2xqQj+/HEaQyNh6nrgPixlhfoH9Rpnh/4yrlwYpAHhhMCZA+VgZr
         +mP3KtXG3pNbI9DqsQjO8CPWQQ+Xvw0EXBtNGMVHMU2/ic88b/RGGVVbPwmrMKXCzXBh
         y89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789367625; x=1789972425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1bl/zgD2IYrG14tFUreeapLVdf9wP0XTfEPxuKsnHs=;
        b=Mn086MTvraVOs1Od39gYYTb1jkiZ2in4Kh4Upadk7tv6vpT6XuriXgki2/PgTTk9n/
         /c7MqsSFV700KTD8CielyFK1Yf3+VEvRUssErbM8EJocLtf+NT/XA1qGtpKUmSwA+lq8
         VJTRrJowSfUvxmIuFAX4fYhnGF8jCusnqYo5j6hrQjONTMcYVEPjR9Qsy+fMWHCsWnff
         Qr321QOLwScaDlV9KtOMKxtHI5X7C3APYfUNBw+L152xlTo41aRE0vlQY3eV2SuUlOwh
         wyFRTEyqf8lLHyUeZ8Pl9eJ/y7CvMrQThqvuAL2Er3qfjHZKgX9WNWAcVriosluDSAxR
         jZcg==
X-Forwarded-Encrypted: i=1; AKwUvBw1387mSE/qNW3MQ5dOu5pzzKLIDAqk2TxHMdLw5cNMVpHvPrOgIpomjVORh8gV4toaY3gqgco=@vger.kernel.org
X-Gm-Message-State: AFuF++mOpl2boM1PzKaJ6PvDZ7Hd0uW4g3i3JdFE2zDdcThwsbGKD+yL
	s1BnIfVgydh9WfLX2Gaob8MxUkveiuI5uFGl8fKvG4z7URunQAu93CQqhuJZM0Ph4rMdnWuDSyD
	YdhDNWv+5uJWTP3LpwyhCx0EonGVI5yEem8/O
X-Gm-Gg: AYBFou2wEIoEoUI4ejCOmKGpukP2bb04vxMwBT6a4Uw0OA3Q43gcWPzHB887NKyy6+y
	l6d8VE18Ep9ie8p/gWGqHmaSeZFXi89IspQjYe2HykFObmmErVGWJSXKdiW15aqLIdTyiLc7pDI
	rshFdYo4RZfpnyzbVB/fdPPPzOqKoNkX+VrqsOQGJzh/51JwcJWLFIHX6qBQBYVRE3ZlhN4yYas
	NlOH2qLNEHMcsoBemX54i9GzYU5YTPPuuZyBP5if37gq8P7ADZo6hc1+NAyy14Fjs1JpwuDVBnd
	Lw/66A7Q1DqJrGlzUC1J9F7rsLFmHmsra7pZtvJcyHtCMuq6JWYq5i/K
X-Received: by 2002:a17:906:c141:b0:c25:8fdf:5d with SMTP id
 a640c23a62f3a-c29b86437f4mr74739566b.13.1789367624974; Sun, 13 Sep 2026
 23:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902112121.2125383-1-r772577952@gmail.com>
In-Reply-To: <20260902112121.2125383-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Mon, 14 Sep 2026 14:33:06 +0800
X-Gm-Features: AcwNN1V6HA7__x-qs1jz9zxjUs2k93iWNhWdQUddsFYjpV1H5xAynXB3NocEWPg
Message-ID: <CANypQFbTTggAnGvdw_O7zxxZ1JNY5_eUBBBPxTW4aW2dqYxQ4Q@mail.gmail.com>
Subject: Re: [PATCH v2] nilfs2: force clear dirty state when restoring from
 the shadow map
To: konishi.ryusuke@gmail.com, linux-nilfs@vger.kernel.org, slava@dubeyko.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 19:21=E5=86=99=E9=81=93=EF=BC=9A
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

Friendly ping, please tell me if any further changes is needed.
