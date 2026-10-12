Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABF4F3906
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837845; cv=pass; b=myKwnwRc/hqV+5bypjGlHeZHkZyJ65PwfycLPxSRg3Z4shjfOW8rYrQPw03rvNqyZ0+QaiOTVy/KuAaQPgFdO7hTsNmtrpdgopKvCsBzLR6Qwu/wgFXL26RHIezrq95v09fT7bBGafmHIz5FStwqkVV2HKHdDYnaZ+0S0S/YxbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837845; c=relaxed/simple;
	bh=QjRpgYjJa+kkNqeLuccwGd0OHr83JO9DtZuhqfen5Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1AmxGjEJJN9CH4rwQ3C/AcT9JR5uf3YS1XZj1sL8c3aongbcsZZlymLCl9Go2DFqqQ6ebKdJuH6KUCFx5QyNEtQMl9oPxH1eZA9pkOf42BUbRE64r2uQBxyg/yQaflM5mpOSFufOZ5bCL0pM2s4cIGz8jIqf5rrliGXn+KGNWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=D7u/48+B; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="D7u/48+B"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6711f05fb14so1818919d50.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791837842; cv=none;
        d=google.com; s=arc-20260327;
        b=FubTcYGv8Ouud9RuGvVDPVK5Sb0hiqu13sQr4gL9468ovy5AtCblSpbWBK2RUSY64K
         hSSvXVMeQSzdJdqWYMjgih1UqVabCG5C+4X03mAogVDMpT+dprR7kGWy52bAjmtIFlUZ
         14YKlDT8F4bc0HazFtF8a8G5HLRKRh3YgYgp9oi2yq5f2uGwEvVp8y45JgpQIIjdm4oo
         j3gD34+hnISjf5c8nWo+hF/Ej+TzZwPEVa0B4a/gQMrzl48GDuOgzBM9MizWHAuPgbQC
         o1frW5qGFWUYExmqpBb6zKS6KxENkfgGwP0jvr5+IQEERywLC9Hchbep2oiMnvec8vMz
         PYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JSUNRjKa8PC9uvL/lbt0WMhZ7tNYQSXReFk4D0bdIN0=;
        fh=iYra+b6qG9k6NhIZjWRtg2ztIg9ODmHomk2UqkyObgA=;
        b=K9KKd9Syh+0l7ERrDBGKaB/xrd0nqpXI4jZn9c2O8QF5nkuLfgTDfA6x5j/3CpGjxB
         OwsHjF/mxna59gI6uDNakkZ+TF7v1Q3RKAplbW1tre5M/HvKxCj9aQsr7pqCxz3PePHp
         kQufTYPEaVPRz7zKIkF8Euh+KRmPGUCo6iJqHDam4Cu14GCllD5ytv2RwCSsqR+rYDOO
         NfaLc7eXl/YLVbmqQNe8V+fIuKYMxgvpUsKywAS+ukZjZQPWKOGPonYr/RPm+fNJwmSx
         msI5EjmZipLsYAp8pZvyuLlL6gNa9yaRNy6YcVhM2tHIvxkgz/K3ziFCoT2SfMkJH+OZ
         bPJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1791837842; x=1792442642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JSUNRjKa8PC9uvL/lbt0WMhZ7tNYQSXReFk4D0bdIN0=;
        b=D7u/48+BkhquwqL83JibC6JgxsN8Kx3M8KTl/EaWI0hClIeSKBnGxRAjYIKcIaerP1
         AhCuc8cIBuUPAxBh7w+Bs589EVhpMlgFN87LPvmI2TGtD+Obrkvk/F9SnK2bk0bYrb31
         35plovSOrFZfREygGZ/UHXx9VgASlDVumkHxFw1+JmmX9M8FJPA2pBfL2yZgSxoE5wHK
         lOZj/LZASEkfcOshiZL552Iby9uW96zVEbXodU4Z8ZgEiDaBpCyT2QBs/Gbk+A70BYzj
         fK8SRtswc3xcyuBcQ81gMnFr3khxkPj1eu3Hk1rYWLWcR+qRbaVRX/OcvOe41QX+0CUA
         hubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837842; x=1792442642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSUNRjKa8PC9uvL/lbt0WMhZ7tNYQSXReFk4D0bdIN0=;
        b=ZEcBUtiMr/irddvSUf6fX5FrjE0YbZIBe7QPljObmXMz6tu/Ht42of6SKInKdMLqXi
         o422MsFuNgTClmQu77Mx2mRV5/avnlmTH8TBmglXZ/hGkbsNiDHdTDpxaGCEzSM94fy+
         BvZs3uZ0TuuGjnJHP+JSUoRyiEr9C5zV0m9ASxD9+fkmGQPeS/MA+gBOXIbKUucklX0I
         gPSbF1jIaY/LWLEmMnrRwER9+a7Q+KN/ux9Riw0w4uRBQvbQQ/hfk+zjj4QyHRQWdfqH
         4CGExPoYAzQ5Fu+wP7dCIGaOjHj+nxdKZmgTXSLrnRRNFvKH/sBrqRC6yVinXf8vA8ca
         m/+A==
X-Forwarded-Encrypted: i=1; AKwUvByW75VME/IqWoreDhlZDKTRa/lCL4quxl6QdK7uY7bSCDh9OixqGMtTHEUprhtx+aZIJMrtJbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaqMqngqGEKKgLm1vTtWLp4mdMOTta6xm2HSTh4HhwnkhSbmK0
	erxI9e07L92tsfNIOCvC7dsXtId9ooUpQQ8xVv+V7t1cFnnvxF12OBJrpmXK4g26k5jDXPPwQPQ
	OqUZuKK/k0hBxMX2G7AIoKmecm2n+/RAEksft6Tp5Hus+5HgBH8Pe8C7JLQ==
X-Gm-Gg: AYBFou0egYB9N0rxly8px8ONXYc77A5wNzPzX0sQTA9DDMgj2DMhU1b68qXwdzMVD8R
	l6U+H49hgUtXdDkg6pgqEZZr038e4OgT66pI37EEtMEI3C3zslxwbb6ur5H8Ys5xx8aXGaccabi
	eQGHAzlc3G7iIGE1VKlmbRlNROT9hlOUcIhsCy3RsHCWiMTWu5xFr6n3FZBP1J9y2eEVaIm71yw
	GJftxQF4Lmofzqqi8v+W8SI+lFCmo4w+LLyoOezmZfpA/yqthRjXGc1JkOu95xVZtnydLCONXWx
	zicPxrrxtpzAt5/La9RcnRBXfGenq1L09Nlc+aeuFLDNODu7EogKJ8mGkU6GdkZUXg==
X-Received: by 2002:a05:690e:4091:b0:677:cb45:a45e with SMTP id
 956f58d0204a3-67935edb58dmr4559555d50.6.1791837842225; Mon, 12 Oct 2026
 13:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008222843.63319-1-lubao@everpuredata.com>
 <20261008222843.63319-2-lubao@everpuredata.com> <6855034f0b219b0b8e6a6f47aef802cf2803e42b.camel@kernel.org>
In-Reply-To: <6855034f0b219b0b8e6a6f47aef802cf2803e42b.camel@kernel.org>
From: Lucheng Bao <lubao@everpuredata.com>
Date: Mon, 12 Oct 2026 13:43:49 -0700
X-Gm-Features: AclHuK_zSM-dUK2eIXZMsKsuxHoHvQIrPR1gRleHlxNa7Z9fN_xJLD3dP1iHjxA
Message-ID: <CAHPUM33UGE849kviu4cngY7SwscHrrf=qTqkp=8OLiTX9SCcBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] NFSv4/pNFS: prevent i_size regression while
 layoutcommit is outstanding
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, 
	linux-kernel@vger.kernel.org, tmenninger@everpuredata.com, 
	jcurley@everpuredata.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 9:43=E2=80=AFPM Trond Myklebust <trondmy@kernel.org>=
 wrote:
>
> On Thu, 2026-10-08 at 22:28 +0000, Lucheng Bao wrote:
> > Commit ac46bd374c9a ("pNFS: Ensure we layoutcommit before
> > revalidating
> > attributes") replaced outstanding-layoutcommit attribute filtering
> > with
> > synchronization before explicit revalidation. For layouts requiring
> > LAYOUTCOMMIT, OPEN attributes can still shrink i_size before metadata
> > synchronization completes.
>
> The client can't police OPEN. It has no idea which file will be
> affected (particularly when doing an open-by-filename) so unlike the
> case of an explicit truncate() call, it can't serialise with the
> truncate.
> It is therefore up to the server to resolve any ambiguity, either by
> recalling or revoking the layout before allowing the OPEN truncate to
> proceed.
>

Thanks for the quick review. I think the OPEN-truncate is a different
scenario from the one this patch is targeting, and my changelog invited
that reading -- let me describe the actual race.

Agreed for a truncating OPEN (or a SETATTR size), that's a real size
change, the client can't serialise an open-by-name against it, and the
server has to recall or revoke conflicting layouts. This patch isn't
about that case and doesn't touch that path.

The race here involves no truncate and no second client. It's a single
client doing O_APPEND over an nconnect mount:

  1. the client WRITEs the appended data to the data server and it
     completes;
  2. the client arms LAYOUTCOMMIT -- the MDS does not know the new
     size yet;
  3. before that LAYOUTCOMMIT is processed, the client's own next OPEN
     carries a GETATTR, and the MDS answers it with the pre-commit size;
  4. the OPEN reply and the LAYOUTCOMMIT reply travel on different
     nconnect connections and are processed out of order, so the
     smaller, stale size is applied to i_size after the writes;
  5. the next O_APPEND then computes its offset from the regressed
     i_size and overwrites the previous append.

So the smaller size isn't a truncate, it's the MDS size legitimately
lagging until LAYOUTCOMMIT (RFC 8881 section 12.5.4 "It is important to
note that the level of synchronization is from the point of view of the
client that sent the LAYOUTCOMMIT. For file-based layouts, synchronization
of attributes between the metadata and storage devices, primarily the size
attribute, is required."). The check is in the generic size path and keys o=
nly
on whether this client has an outstanding LAYOUTCOMMIT for data it has
written but not yet committed.

This is the same protection the client already applies to buffered
writes via !nfs_have_writebacks(): don't let the server shrink i_size
below data the client has written but the server doesn't know about yet.
The only difference is the "server doesn't know yet" window. For plain
buffered I/O it's "dirty pages not yet sent"; for a layout requiring
LAYOUTCOMMIT it's "written to the data server, LAYOUTCOMMIT
outstanding." In fact, once the DS write completes, the pages are no
longer counted by nfs_have_writebacks(), yet the size still isn't known
to the MDS until the commit, that gap is exactly what this extends the
existing check to cover.

> >
> > Commit d8c951c313ed ("NFSv4.1: Don't trust attributes if a pNFS
> > LAYOUTCOMMIT is outstanding") moved LAYOUTCOMMIT post-op attribute
> > processing after cleanup, leaving another unprotected window after
> > NFS_INO_LAYOUTCOMMITTING is cleared.
>
> This is unrelated to the above problem, so fixes for this issue need to
> be in a separate patch.
>

Will fix in v2.

> >
> > Extend the existing writeback checks to reject smaller sizes while a
> > LAYOUTCOMMIT is pending or in flight, preserving size increases and
> > WCC
> > checks. Process the reply's attributes and establish their generation
> > barrier before cleanup removes that protection.
> >
> > Fixes: d8c951c313ed ("NFSv4.1: Don't trust attributes if a pNFS
> > LAYOUTCOMMIT is outstanding")
> > Fixes: ac46bd374c9a ("pNFS: Ensure we layoutcommit before
> > revalidating attributes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lucheng Bao <lubao@everpuredata.com>
> > ---
> >  fs/nfs/inode.c    | 8 ++++++--
> >  fs/nfs/nfs4proc.c | 2 +-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 3022454f7698..11432f521b04 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -1636,7 +1636,9 @@ static void nfs_wcc_update_inode(struct inode
> > *inode, struct nfs_fattr *fattr)
> >       if ((fattr->valid & NFS_ATTR_FATTR_PRESIZE)
> >                       && (fattr->valid & NFS_ATTR_FATTR_SIZE)
> >                       && i_size_read(inode) =3D=3D
> > nfs_size_to_loff_t(fattr->pre_size)
> > -                     && !nfs_have_writebacks(inode)) {
> > +                     && !nfs_have_writebacks(inode)
> > +                     && (nfs_size_to_loff_t(fattr->size) >=3D
> > i_size_read(inode)
> > +                             ||
> > !pnfs_layoutcommit_outstanding(inode))) {
>
> Under what circumstance is the client legally supposed to be able to
> call nfs_wcc_update_inode() with NFS_ATTR_FATTR_PRESIZE set, while
> there is an outstanding layoutcommit?
>

It is nfs_post_op_update_inode_force_wcc() from
nfs4_layoutcommit_release(). With
nconnect and overlapping LAYOUTCOMMITS, an earlier LAYOUTCOMMIT can complet=
e
and apply its (smaller) committed size via force_wcc while a later
LAYOUTCOMMIT --
for data already written past that point -- is still in flight.
