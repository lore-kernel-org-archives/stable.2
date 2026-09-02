Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D642147F9
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311217; cv=none; b=UDnJkMZ4hwQCLYC8dr+rSvTrFHilgpScLPplQlvZ63XovtjJQJZ3phRZkxllcmQguOXFXVrPVkvbictd4jQJxmQboZEE7QxEslzzZGuYICOglz9BqslD6FK75lmlqiMjLqbS+Iebd+0hak9dgovojrHy8DhWMtZXhrIIQ778Dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311217; c=relaxed/simple;
	bh=vktDnoMVFzqEI8/NuzDTqrkKE4xBRWOvevvNYuiuevA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAsizfjmPQFSHYPmc9KDWSILUwwFC2ET9jlmL94f5CfIJutXrY3dCJcIE8f6/Fy3u0ZY7HT4Zc5koLYnGS93CSBlPiZAtgrhUCkB3YYFVPVnKKCExuILYldN0z0QtCRjw73Cl2utA4oaZP0cWd0fc1bk3nhWkYupvcJ+op8K9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Taa7y7hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Taa7y7hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6CD1F00A3E
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311216;
	bh=jqxk0sZkbZ9KoV7KU3DYdNlHYVVbXm+ovykDBW729c0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Taa7y7hfdXQCnOe7c032ELYqZstGm3BFQaM6x/+BbLq1aa9zAXvrVXltpBI1Ej+r2
	 k+UCLz+KXaLmNZptw7mEyktiJUtzdsuuZQc091Hg8kQzZWaNUvV318LScZc8V0+UPq
	 ERJVAOVa2ZVwe87ysIai6KVv1ofJ2Sgi2WZp29OfAw2HPeKoKRu5T/IaKixJMdlJnY
	 Yp+kXovm0SMHj8BSP9eojdoIiDSQj4g8rlP8O2fjpVSCt1ii82w6a9vlJxEcRm8yj5
	 6hgobQRhTWgej2M4ik4tJt4TYlM64g6sXi4RJMJHbWfTTtSkzf2EpqCHilKz3rAgPK
	 Sz+ifE6Df5sLA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c250c6a6a6eso60819166b.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:06:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq8asaErbCF6f/1Us6X1kXtiyh8yJOjz+X9j+4V2u0zRV69e/jPEybjCLqx+3fRQRw1BoNeLRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nMSrgDvjYNmyDYXwmtV/XOuEts3vkw6Mej/wjv7KMtVM1eZF7P
	hHFBrVruNY1gbVZTGt13fqcrnHlDvH89X/lLRfvELbvBFUE93lmZSjriqrqxz0nVWcCVm3JQMjW
	3bxJfdLSnwwCzs1B248faiq1SuVBQN48=
X-Received: by 2002:a17:907:94cd:b0:c25:5d2:acf0 with SMTP id
 a640c23a62f3a-c25d5274bdemr64308366b.8.1788311214539; Tue, 01 Sep 2026
 18:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901024551.528056-1-zenghongling@kylinos.cn>
In-Reply-To: <20260901024551.528056-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 2 Sep 2026 10:06:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8dotRFBu18HOZGr6AJn4EfTwj=ZtfwheCTy0H7tbLfFA@mail.gmail.com>
X-Gm-Features: AcwNN1VIQF3MFhyiXi3o0liM2BjTlHAmpqB7BC2cSPaiZbZ7-OBH0vpghrk95IQ
Message-ID: <CAKYAXd8dotRFBu18HOZGr6AJn4EfTwj=ZtfwheCTy0H7tbLfFA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix lost volume flag updates in set/clear helpers
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 11:46=E2=80=AFAM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> ntfs_set_volume_flags() and ntfs_clear_volume_flags() both read
> vol->vol_flags outside any lock to compute the new value before handing
> it to ntfs_write_volume_flags(), which only takes ni->mrec_lock around
> the actual write. The read-modify-write is therefore not atomic, and two
> concurrent callers can lose an update: ntfs_sync_fs() may derive a
> "clean" value from vol->vol_flags while a writer concurrently records an
> error and sets VOLUME_IS_DIRTY; the locked write then silently
> overwrites the freshly-set dirty bit. The on-disk volume looks clean
> despite the recorded errors, so chkdsk will not run on the next mount
> and corrupted metadata can persist.
This patch description explicitly identifies ntfs_sync_fs() as the
problematic caller, but there still remains a racy issue after
applying this patch.

static int ntfs_sync_fs(struct super_block *sb, int wait)
{
...
        if (!NVolErrors(vol) &&
            ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
                ntfs_warning(sb, "Failed to clear dirty bit in volume
information flags.  Run chkdsk.");
                err =3D -EIO;
        }

Sync thread                         Writer thread
-----------                                -------------
1. NVolErrors() =3D=3D false
                                             2. Set VOLUME_IS_DIRTY
under mrec_lock
                                             3. NVolSetErrors()
4. ntfs_clear_volume_flags()

The volume can be left marked clean on disk despite the recorded
error... Can you update this patch to fix this issue as well?
