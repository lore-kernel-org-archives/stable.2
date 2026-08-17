Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA441B8D5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970356; cv=pass; b=DELvKLCZPnVWr4SSIfHV7W2f8U1R57u5NHdIy8zTtZ26iYCqR99ZPA6n4eeM+xzzWj+ebXQ6IwRqfFJ8JSM6VI2gZ+SwPrbc3guBBRrLI/BamHKBmNyZWUNsIpUdtGxnVvYwH9g55YPg9x8nCNG+CDembFZseqvWzUeWi94tqfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970356; c=relaxed/simple;
	bh=MZ7qGVaJ7rnWH15e8hVtHaFbNv4/mRLVsvxRBdrx2Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugw41ZFt5b3MIcu9VPGRYQX/3dLG+/m9Ax7pvDGOa+5okYYRSPWp42gA30vhOFkgpL3aSAkRnNa4tHunqYfZnjCrrySN6npKh3G+kq2UYnrOywNNpEb1XlRoWJ317kSIohsEGewYtL5lFFUrGZ6J9QM3HVcHLxUwe+4awSzFdFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYVA0Po9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tpn2UMu3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYVA0Po9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tpn2UMu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786970353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
	b=ZYVA0Po9Tvz9MyEBNEsj759VCFArmXZ1gO49c9yaFEQrXRwFM6hOnhtB8hqV0QCL6qQtQi
	p36bv9QgMYXR0ZYhhtcYXGVeNQtls56V6zIdTLOHoctrjTvtTDheq7Sn4HfYYn9IV9bCaZ
	x7JOzMXfd6QynmRrP3t7oEOvGjBptQM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-yHAOpy91OEqYxrhq0ZMR9g-1; Mon, 17 Aug 2026 08:39:12 -0400
X-MC-Unique: yHAOpy91OEqYxrhq0ZMR9g-1
X-Mimecast-MFC-AGG-ID: yHAOpy91OEqYxrhq0ZMR9g_1786970351
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso3824561a91.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786970351; cv=none;
        d=google.com; s=arc-20260327;
        b=WJJNcDfcIWTSD87fwLqtJUKNMvWNwz9fVeN7XhiphKOyIYBFKt0Ar8gz13aKXN7yOA
         hF6j9yxvAe1QDxGlF/Q1/jhU9m6yFyeqOHiTRpLIga+lUHf0nEGAVGNPuxX4hQ0nQYEB
         SaJJ/xd93t4A6vQ0j1593qfKIz2kZ0nYvSWlHmnBbPRJDPgyU/8VLtXMSajZ5eyCgdPL
         7jqpe2OszpMO0gcpTkI9nqs5S7D9ks6aHvEJmN4O3qi4dZzVO6yDQVlyWGZG/Dj2qqNA
         VoJ9zHfqwc0APv32k8iDqCTw8t57yyTe0LgZLhbcDeHW4PcZgBnhe5dzQGDDHdqrsE5U
         9mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
        fh=+imHysRnlgVbcnW2fxPwF9J1oTwKt5IDscyxJj1EZ3E=;
        b=D78/VigD9S101pRpGkZaw6Dte+npXAWLIN0TeOHzu3JXxfXvFCW8LgtipDGmgmcgaG
         r7inEOLJ35+wReZyVJcGOdK0yOxM/zB4MFXwTAifHw1NkSobM5QaP+RarvtsQFtT+CCH
         mDTuqBXa3KHnfCiYdugTSifSDpxucVbEt7gAQwMCJfYqywvMvRqaWQU67A/vbENChOky
         Nivvc9LkexHExshBFRJ14t0zJzm+iBTOFoO+ZMfGe5HQ2qlcsQII2GahIrmKXjSZvbXy
         EvHGLLKkxSW6FayN25TRUQRvQ7cFHNOukQ6zBSx5QFhGi0ZUfvMEl3xNdCqN0qid1uqD
         3E4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786970351; x=1787575151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
        b=tpn2UMu3fKp5645Y/7Sk5d0C++58803B83jHh8vj6teI7QQSjZcc10fkCl/wq8KKQu
         KM6u5EACsGq5MO3xc+qGTxJtdxMUNE9wtFJa7dD7r3PCheRFVXXCyKw+/zUvCykYfn9s
         B5b1b/1hvZW6Hdg6FdoTgd062cR7fQdCUajF7Hx5EoAdFp5vyNJfJEFaBt2UEL5E5fWv
         yW9g1ovc/5fOMuasBBADdh/3roiduSLiHSoDjjZaDmDnVteA963fGaicKfMmyKkDbVXd
         EKqTeAY8mI1fNU6PdGh0uarYZImrqzzEmSuUgZzDAv1KqixMdbjMfEHfASo53DVn8G6v
         eH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970351; x=1787575151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHH6tnBGIN4rU3ZB2nxXbmK6lis9375DMRzBzQgBH80=;
        b=Xi8PYFAnftQ/Cw0qGrKXNmKdUlhgRrpBSY8KTR7wOy7ETlrpJv6iw5AucNqc4Qw4l/
         OzgRAB/IzOj9Ii+nOKOPIN434xJbqNOcmg5/2ybdn9ZgqeMlwzu1viBjvX+ZwRW00+Gi
         aeUqGPVRZMo964CBkyvC+RIP4P8VGXAdYT00JwINA7Lq7yt4lWPiavuRssU1cki+nw0P
         icqIq/iKezDUJLY/JWEkeKUUVqh7+laVnxf9umb/6PqxfTI+k8msG0P0+C/ckRgD8Bhz
         eqcMWWPvmmzDq9jsYi4PP3fiiAn21YyDFRoVTzsN/3wF9RYEcu1uciMd873toAzcK1zA
         tLZA==
X-Forwarded-Encrypted: i=1; AHgh+RrpHWdwDmjO9EWq5D9GHYxqEt/79sQUmwbyat/i/wo6W4KMJZmNqWi0NIl770pyVqGezaTA4eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwOFwf/JZVez8Lb4C9tASjghC9Ec1yu5/mzlOw9pU8iTbuMUN
	WJ3miIaRAegTK82x2pW6zSy91r3Q83vZIqi7Fye65crAh8S2aTAc+rw3OOEMBjZTpKk+BSOvVHP
	sjJ6wOhc1XhJdNETCxQe7B24h7H15P/hJnBCka2SzJ1VP4Yr7Mz8bZgNaeTknRSwBtCWaT6PT64
	Y4vpXeOJFT8Fnu9SwwI5YwjUODD4qI+w4K
X-Gm-Gg: AR+sD10cbwRCYwcm903uQzdSmls9wE8x0Sm4bvMpVHfTBCzuAPc3PaSoaUl1eVhS33s
	Z/bWz2whaVcNYcRIfFdRTf7yGcYbcJfHB7QeiLGgtGklhZJpaMSwayjAstGhI9j3o0QHiErz38+
	dX9K6wW+4hBhEZI1EXJrmeXn8nJyukA1+DXBOsFABA41t234rPvPLd3QSaamGTbtS6swP0m/6TL
	q5IEUN8bxad0rdhb8TYaIsYiXg=
X-Received: by 2002:a05:6a21:8cc1:b0:3bf:63af:85d with SMTP id adf61e73a8af0-3cc71ca38a5mr30285485637.18.1786970351449;
        Mon, 17 Aug 2026 05:39:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:8cc1:b0:3bf:63af:85d with SMTP id
 adf61e73a8af0-3cc71ca38a5mr30285393637.18.1786970350836; Mon, 17 Aug 2026
 05:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812201915.1783578-1-max.kellermann@ionos.com>
In-Reply-To: <20260812201915.1783578-1-max.kellermann@ionos.com>
From: Venky Shankar <vshankar@redhat.com>
Date: Mon, 17 Aug 2026 18:08:33 +0530
X-Gm-Features: AcwNN1Wd7jBR0vOwrWQOfLqaaohCkivUYqze-nDZzzed79MIbQHTEapwBdYzkE8
Message-ID: <CACPzV1k6LZk5_L+iQGcM=98WB2jt_wME38yQyktfj+ULOVGf-g@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: force a cap message when a deferred revoke can't
 be acked immediately
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, xiubo.li@clyso.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:49=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> When the MDS revokes capabilities, handle_cap_grant() normally
> guarantees a response by setting `CHECK_CAPS_FLUSH_FORCE` (see
> commit 31634d7597d8 ("ceph: force sending a cap update msg back to MDS
> for revoke op")), so ceph_check_caps() sends a cap message even if the
> client would otherwise decide it has nothing to do.  That guarantee is
> skipped whenever the revoke has to be deferred (via revoke_wait):
> revoking Fb while dirty data is still buffered (writeback is queued
> first) or revoking Fc while pages are cached (async invalidation is
> queued first).
>
> In those cases, the ack is left to the deferred completion
> (ceph_put_wrbuffer_cap_refs() after writeback, or the invalidate
> worker after invalidation); both of which call ceph_check_caps(ci,0)
> i.e.  without `CHECK_CAPS_FLUSH_FORCE`.  Nothing gets sent under one
> of the following conditions:
>
> - the inode is retaining caps because the file was used recently
>   (file_wanted !=3D 0; retain |=3D CEPH_CAP_ANY)
>
> - the revoked cap is still used because the page was re-cached (e.g. a
>   file being re-read)
>
> - the MDS has meanwhile re-granted, so `issued=3D=3Dimplemented` and the
>   client sees nothing being revoked
>
> The client then never emits the cap message which the MDS is waiting
> for.  The MDS blocks on the revoke indefinitely and logs, for minutes
> or hours:
>
>   client.NNN isn't responding to mclientcaps(revoke), ino 0x... pending
>   pAsxLsXsxFsxcrwb issued pAsxLsXsxFsxcrwb, sent 964.899182 seconds ago
>
> The client-side state at that point shows the full cap set still
> issued, nothing in the revoking/flushing sets.  Thus nothing gets
> sent.
>
> This patch fixes it by remembering that a forced response is expected.
> When a revoke is deferred, set `CEPH_I_FLUSH_FORCE` on the inode.
> ceph_check_caps() replays it as `CHECK_CAPS_FLUSH_FORCE`, so whichever
> path re-checks the inode next (the writeback/invalidate completion,
> the delayed worker, or any other caller) is guaranteed to send a cap
> message to the MDS.  __prep_cap() clears the flag once a message is
> actually built.

Thanks for the patch, Max. This probably fixes
https://tracker.ceph.com/issues/75735

>
> This is the deferred-path counterpart of the existing
> `CHECK_CAPS_FLUSH_FORCE` handling; a normal (non-deferred) revoke
> still forces the response inline as before.
>
> Cc: stable@vger.kernel.org
> Fixes: 31634d7597d8 ("ceph: force sending a cap update msg back to MDS fo=
r revoke op")
> Fixes: 257e6172ab36 ("ceph: don't let check_caps skip sending responses f=
or revoke msgs")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> v1->v2: fix CEPH_I_FLUSH_FORCE/CEPH_I_FLUSH_FORCE_BIT mixup
> ---
>  fs/ceph/caps.c  | 40 +++++++++++++++++++++++++++++++++-------
>  fs/ceph/super.h |  5 +++++
>  2 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index d7283fb54cec..8ad17787b172 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1410,6 +1410,7 @@ static void __prep_cap(struct cap_msg_args *arg, st=
ruct ceph_cap *cap,
>         BUG_ON((retain & CEPH_CAP_PIN) =3D=3D 0);
>
>         clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> +       clear_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
>
>         cap->issued &=3D retain;  /* drop bits we don't want */
>         /*
> @@ -2038,6 +2039,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, i=
nt flags)
>
>         if (ci->i_ceph_flags & CEPH_I_FLUSH)
>                 flags |=3D CHECK_CAPS_FLUSH;
> +       /*
> +        * A revoke whose response was deferred (see handle_cap_grant()) =
must
> +        * still be acknowledged.  Replay the forced flush here so that e=
ven a
> +        * check triggered by writeback/invalidation completion sends a c=
ap
> +        * message to the MDS.
> +        */
> +       if (ci->i_ceph_flags & CEPH_I_FLUSH_FORCE)
> +               flags |=3D CHECK_CAPS_FLUSH_FORCE;
>  retry:
>         /* Caps wanted by virtue of active open files. */
>         file_wanted =3D __ceph_caps_file_wanted(ci);
> @@ -3757,13 +3766,30 @@ static void handle_cap_grant(struct inode *inode,
>         BUG_ON(cap->issued & ~cap->implemented);
>
>         /* don't let check_caps skip sending a response to MDS for revoke=
 msgs */
> -       if (!revoke_wait && le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_REV=
OKE) {
> -               cap->mds_wanted =3D 0;
> -               flags |=3D CHECK_CAPS_FLUSH_FORCE;
> -               if (cap =3D=3D ci->i_auth_cap)
> -                       check_caps =3D 1; /* check auth cap only */
> -               else
> -                       check_caps =3D 2; /* check all caps */
> +       if (le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_REVOKE) {
> +               if (revoke_wait) {
> +                       /*
> +                        * We can't ack the revoke yet: the response is d=
eferred
> +                        * until the writeback or cache invalidation queu=
ed above
> +                        * completes.  Set the CEPH_I_FLUSH_FORCE flag to=
 remember
> +                        * that a forced cap message is owed so that defe=
rred
> +                        * completion (ceph_put_wrbuffer_cap_refs() or th=
e
> +                        * invalidate worker, both of which call ceph_che=
ck_caps())
> +                        * actually sends one, even if by then the revoke=
d caps look
> +                        * unused, the inode is retaining caps, or the MD=
S has
> +                        * re-granted them.  Without this, the cap messag=
e is never
> +                        * sent and the MDS hangs ("isn't responding to
> +                        * mclientcaps(revoke)").
> +                        */
> +                       ci->i_ceph_flags |=3D CEPH_I_FLUSH_FORCE;
> +               } else {
> +                       cap->mds_wanted =3D 0;
> +                       flags |=3D CHECK_CAPS_FLUSH_FORCE;
> +                       if (cap =3D=3D ci->i_auth_cap)
> +                               check_caps =3D 1; /* check auth cap only =
*/
> +                       else
> +                               check_caps =3D 2; /* check all caps */
> +               }
>         }
>
>         if (extra_info->inline_version > 0 &&
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 1d6aab060780..878440a2eb3b 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -687,6 +687,10 @@ static inline struct inode *ceph_find_inode(struct s=
uper_block *sb,
>  #define CEPH_I_ASYNC_CREATE_BIT                (12) /* async create in f=
light for this */
>  #define CEPH_I_SHUTDOWN_BIT            (13) /* inode is no longer usable=
 */
>  #define CEPH_I_ASYNC_CHECK_CAPS_BIT    (14) /* check caps after async cr=
eating finishes */
> +#define CEPH_I_FLUSH_FORCE_BIT         (15) /* a revoke's response was d=
eferred;
> +                                             * force a cap message to th=
e MDS once
> +                                             * the deferred work complet=
es
> +                                             */
>
>  #define CEPH_I_DIR_ORDERED             (1 << CEPH_I_DIR_ORDERED_BIT)
>  #define CEPH_I_FLUSH                   (1 << CEPH_I_FLUSH_BIT)
> @@ -699,6 +703,7 @@ static inline struct inode *ceph_find_inode(struct su=
per_block *sb,
>  #define CEPH_I_ODIRECT                 (1 << CEPH_I_ODIRECT_BIT)
>  #define CEPH_I_ASYNC_CREATE            (1 << CEPH_I_ASYNC_CREATE_BIT)
>  #define CEPH_I_SHUTDOWN                        (1 << CEPH_I_SHUTDOWN_BIT=
)
> +#define CEPH_I_FLUSH_FORCE             (1 << CEPH_I_FLUSH_FORCE_BIT)
>
>  /*
>   * Masks of ceph inode work.
> --
> 2.47.3
>
>


--=20
Cheers,
Venky

