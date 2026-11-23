Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432843;
	b=v1HDbDfFQNiC9XevxFXDvyNIOX5UugIIWQUsIkMSvQlvgp7YkGM12Gku17iyy4w5DImt
	 rUmtUlgRzlNoYaXVfHIlBEYt1p9iDHNsQFb+zdhYPccKGXyiOuS4rF2EJba81BRqhVulG
	 qzCtW2LYnmje6SviSuait03np7biFu92Cg8buIH8lq9nFJDLfEEKEkT5ZGbA/svGjG+Qf
	 EI4utDxZveKkk1zRylvAKpWkVDz3N04FroEF6J+ThuFkivstO3lxr5QVISDpMeTAIgAjr
	 i0UryGMwiE0g3uDqCQaWzbe3bQQy9NgrgTx07xr7UF0vOInqy1lh4KC3DDBNU/fm4yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432843;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YyQadyN6ID+xOR/IaJnSz+0LR49BykcDWRB6rfujXWk=;
	b=0nSCFk0DLO9v8scCeP84cKyD8+yJXz9pjbam2ODBbq32Wd8eWRU/ePP5yP5NgTqPJ7y3
	 y9peNAVoBPOUSubXMFW2QcSoMfZkYBfV0++a657Zha2rXf1AMDPmgH70M46/REukeChEl
	 zpa+1KmRnOm9qPLe5lrL6sVjuEfeoaO4nfJGKnHmCEm12k7mR1lGC+6tpTVrAIG5gu0Fe
	 hMVSQAf6UgaM4aittZHDof4RhFXQIkef+mctb+32wCDOTS2L/7e6SRUF6YXbBUewcHg9s
	 lxVfpJBb6Z625wwnIRYudrI0mUwbexDQpsikFXptgCt30LgtRt9uly9mAR4xY7xp/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaBEg73k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0C606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaBEg73k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3911F00A01
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795432842;
	bh=YyQadyN6ID+xOR/IaJnSz+0LR49BykcDWRB6rfujXWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NaBEg73krKGNhxT+0TASqSajX1rTNNznbuChm700gzwcysmzqR/8mQ7MSCrXRIR1w
	 NcO/2CyctixT9KHwnzqCvQtiJu0NIjv+T9HcVcFx9yNFHsz/89iWbCpDe41uBtyh66
	 cnfNzvjXCMfh81gHlEArk+3bDVeeJPS3KNv7ShDwk1WknDJDorIPBNnCGW55BcPYrg
	 /k1358ZvDCRIZXfL0HOZ2QpEp9rlVu28meWpkJ3hGxPWOxXk+2MlldsOej1WUPUKQN
	 Ze2AycCW5XpHW/jVuz61WT55gAO+/3Nc6vGEhXxVTppYQdySRCUqIgAWPMsHOhZqv9
	 PkyvFZ0SFlr1g==
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2db6408cfso1789258137.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEF94TTgQN6gtKfO5RfOITbOZBcCSYUcwjSxuzGXPxlZbLVNCAFkrW1nhlPcoMMi3QgNQB/ugE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Mi0RBFfgoy1i2uCsHJv4srNBld4K+fFlqiSn1GMeKJmD7JxxS
	bOlsV+cv7TF1yl39Pz2RfiRKexj1zLI9QlmhesZxe+ErtwzumTSFUvzwDsd2CcKdhEEDEdeI/5o
	TnPSKHP7SVABjiUFdArjxY/ow3oJHqTU=
X-Received: by 2002:a05:6102:508f:b0:7cc:174b:f7c3 with SMTP id
 ada2fe7eead31-7d739674d2fmr4405418137.30.1795432841398; Mon, 23 Nov 2026
 03:20:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
 <20261120-b4-btrfs-data-integrity-v3-4-4de4b91b826e@toxicpanda.com>
In-Reply-To: <20261120-b4-btrfs-data-integrity-v3-4-4de4b91b826e@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Nov 2026 11:20:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4xYay42iOwWXFT9tkx=7jyg8bz0hf-_BU2QqUZideNKw@mail.gmail.com>
X-Gm-Features: Aa3M54p5zgPOeD-kwbilOEn2AZJ3JOlk_v_EnxQtOCbB9WsISyinG8vIgnX5-yY
Message-ID: <CAL3q7H4xYay42iOwWXFT9tkx=7jyg8bz0hf-_BU2QqUZideNKw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] btrfs: wait for ordered extent IO in fast fsync
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Qu Wenruo <wqu@suse.com>, Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 8:54=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> A fast fsync waits for writeback and then checks whether a write failed
> or was truncated, in which case it waits for the ordered extents to
> complete. The check can come too early, because end_bbio_data_write()
> clears writeback before it finishes the ordered extent, which is where
> a failure is recorded:
>
>   end_bbio_data_write()            fsync
>
>   btrfs_folio_clear_writeback()
>                                    filemap_fdatawait_range()
>                                    BTRFS_INODE_INCOMPLETE_COW_WRITE clear
>                                    btrfs_log_changed_extents()
>   btrfs_finish_ordered_extent()
>     set BTRFS_INODE_INCOMPLETE_COW_WRITE
>
> A direct IO write has no writeback for the fsync to wait for at all, so
> the failure of an asynchronous direct IO write still in flight is missed
> too.
>
> The buffered case comes from commit a11d6912fdd9 ("btrfs: remove folio
> parameter from ordered io related functions"), which moved the call to
> btrfs_finish_ordered_extent() after the loop that clears writeback. The
> direct IO case has been there since commit f13e01b89daf ("btrfs: ensure
> fast fsync waits for ordered extents after a write failure") added the
> flag.
>
> Fix by having a fast fsync wait for BTRFS_ORDERED_IO_DONE on the ordered
> extents it collected for logging before it checks. Since "btrfs: make
> fsync wait for all incomplete COW writes", a failure or truncation is
> recorded before that bit is set, and a barrier in
> can_finish_ordered_extent() now orders the two, pairing with the fully
> ordered test_and_clear_bit() of the flag in fsync. For a buffered write
> the bit is set right after writeback is cleared. The writeback of a
> buffered write that is not done yet is started first, and fsync returns
> the error if that fails, since the rest of the ordered extent may then
> not be submitted.
>
> This depends on "btrfs: make fsync wait for all incomplete COW writes".
>
> Fixes: a11d6912fdd9 ("btrfs: remove folio parameter from ordered io relat=
ed functions")
> Fixes: f13e01b89daf ("btrfs: ensure fast fsync waits for ordered extents =
after a write failure")
> CC: stable@vger.kernel.org # 6.10+
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/file.c         | 67 ++++++++++++++++++++++++++++++++++++++++---=
------
>  fs/btrfs/ordered-data.c |  6 +++++
>  2 files changed, 61 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 4208587abff1..ee09c4ecbd4c 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1512,8 +1512,8 @@ static inline bool skip_inode_logging(const struct =
btrfs_log_ctx *ctx)
>          * If we are doing a fast fsync we can not bail out if the inode'=
s
>          * last_trans is <=3D then the last committed transaction, becaus=
e we only
>          * update the last_trans of the inode during ordered extent compl=
etion,
> -        * and for a fast fsync we don't wait for that, we only wait for =
the
> -        * writeback to complete.
> +        * and for a fast fsync we don't wait for that, we only wait for =
the IO
> +        * of the writes to complete.
>          */
>         if (inode->last_trans <=3D btrfs_get_last_trans_committed(fs_info=
) &&
>             (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags)=
 ||
> @@ -1523,6 +1523,41 @@ static inline bool skip_inode_logging(const struct=
 btrfs_log_ctx *ctx)
>         return false;
>  }
>
> +/*
> + * Wait for the IO of the ordered extents collected for logging to be ac=
counted,
> + * starting IO on the dirty folios of a buffered write that is not done =
yet.
> + *
> + * Waiting for writeback is not enough: the end IO handler clears writeb=
ack
> + * before it finishes the ordered extent, and a direct IO write has no
> + * writeback. A failed or truncated write sets BTRFS_INODE_INCOMPLETE_CO=
W_WRITE
> + * before BTRFS_ORDERED_IO_DONE is set, see can_finish_ordered_extent().
> + *
> + * If starting IO fails, the rest of the ordered extent may never be sub=
mitted,
> + * so return the error instead of waiting.
> + */
> +static int wait_ordered_io_done(struct btrfs_inode *inode,
> +                               struct list_head *ordered_extents)
> +{
> +       struct btrfs_ordered_extent *ordered;
> +       int ret;

Nit: declare ret in the scope below where it's used.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +       list_for_each_entry(ordered, ordered_extents, log_list) {
> +               if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags))
> +                       continue;
> +               if (!test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags)) {
> +                       ret =3D btrfs_fdatawrite_range(inode, ordered->fi=
le_offset,
> +                                                    ordered->file_offset=
 +
> +                                                    ordered->num_bytes -=
 1);
> +                       if (ret)
> +                               return ret;
> +               }
> +               wait_event(ordered->wait,
> +                          test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flag=
s));
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * fsync call for both files and directories.  This logs the inode into
>   * the tree log instead of forcing full commits whenever possible.
> @@ -1626,11 +1661,11 @@ int btrfs_sync_file(struct file *file, loff_t sta=
rt, loff_t end, int datasync)
>          * IO of a lower priority task while holding a transaction open.
>          *
>          * For a full fsync we wait for the ordered extents to complete w=
hile
> -        * for a fast fsync we wait just for writeback to complete, and t=
hen
> -        * attach the ordered extents to the transaction so that a transa=
ction
> -        * commit waits for their completion, to avoid data loss if we fs=
ync,
> -        * the current transaction commits before the ordered extents com=
plete
> -        * and a power failure happens right after that.
> +        * for a fast fsync we wait just for the IO of the writes to comp=
lete,
> +        * and then attach the ordered extents to the transaction so that=
 a
> +        * transaction commit waits for their completion, to avoid data l=
oss if
> +        * we fsync, the current transaction commits before the ordered e=
xtents
> +        * complete and a power failure happens right after that.
>          *
>          * For zoned filesystem, if a write IO uses a ZONE_APPEND command=
, the
>          * logical address recorded in the ordered extent may change. We =
need
> @@ -1650,13 +1685,21 @@ int btrfs_sync_file(struct file *file, loff_t sta=
rt, loff_t end, int datasync)
>                 if (ret)
>                         goto out_release_extents;
>
> +               ret =3D wait_ordered_io_done(inode, &ctx.ordered_extents)=
;
> +               if (ret)
> +                       goto out_release_extents;
> +
>                 /*
>                  * Check and clear BTRFS_INODE_INCOMPLETE_COW_WRITE now a=
fter
> -                * starting and waiting for writeback, because it may hav=
e been
> -                * set while we waited, and if a write failed or was trun=
cated
> -                * we need to wait for ordered extents to complete so tha=
t any
> -                * extent maps that point to unwritten locations are drop=
ped and
> -                * we don't log them.
> +                * waiting for the IO of the ordered extents, because it =
may
> +                * have been set while we waited, and if a write failed o=
r was
> +                * truncated we need to wait for ordered extents to compl=
ete so
> +                * that any extent maps that point to unwritten locations=
 are
> +                * dropped and we don't log them.
> +                *
> +                * test_and_clear_bit() is fully ordered, which pairs wit=
h the
> +                * barrier before BTRFS_ORDERED_IO_DONE is set in
> +                * can_finish_ordered_extent().
>                  */
>                 if (test_and_clear_bit(BTRFS_INODE_INCOMPLETE_COW_WRITE, =
&inode->runtime_flags))
>                         ret =3D btrfs_wait_ordered_range(inode, start, le=
n);
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 1a4e3e34ec11..728e73baf15e 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -420,7 +420,13 @@ static bool can_finish_ordered_extent(struct btrfs_o=
rdered_extent *ordered,
>         /*
>          * All the IO of the ordered extent is finished, we need to queue
>          * the finish_func to be executed.
> +        *
> +        * Order BTRFS_INODE_INCOMPLETE_COW_WRITE, if set above, before
> +        * BTRFS_ORDERED_IO_DONE, as a fast fsync tests the latter withou=
t
> +        * the ordered_tree_lock. Pairs with the test_and_clear_bit() in
> +        * btrfs_sync_file().
>          */
> +       smp_mb__before_atomic();
>         set_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags);
>         cond_wake_up(&ordered->wait);
>         refcount_inc(&ordered->refs);
>
> --
> 2.55.0
>
>
