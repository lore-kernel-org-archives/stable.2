Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A52931F4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173356; cv=none; b=X482TQpLxzZ5UZitbhHFJQ/dreSH0idc/xPvQ8AWJd52JB0MHbBWRsppBrYltMSWyTwNAv5NB76dBloiZ5ppQgGM2+0dND+8apl/o1vlL0flfGIVTIeK0nE9GwYI7JnaeMsPVr8juKL3txgC5VpQeguW54V4HgwYgDc8GInK3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173356; c=relaxed/simple;
	bh=q4lRlkxjVlQPpUfAazgm5g8N5ftV2sYNskRkPa1rMxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzl4FGJqvEAiFh8wNRCWWguaIbaKfq4v3UobwEXS8pfjp3DFvI7RtYAC7Cs46Fe9euc86sA/chJnuoWmDRCrIEcgSLy+z6KGxEZEUhjkfzR1RpicRMz51dTrKNXM0PJ2SkLcz3b3wIbkxuYd/AwL03swYpQy5rV3rHoqaaI1+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvexMi00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvexMi00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7401F00ACA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173355;
	bh=LJINlYBmvXYfyj4yqksAaH4IQHNOMyv1CAhYKzAduM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NvexMi00l3lg8KqZLaDKGv06VG8k8rtVUnRdj8Ewm6VjSGUaY/2KvTIYn/++uPQUs
	 IVlnM3GnmYWSqERyMPX9bnXuRoIQuG0VrS/UWfEyht2E3Ae94PQL9J/Tg3Qi384xHf
	 fA10XjeB2H3sPCD/ONdyy7fVK/hOt5hQ11IM+hkuRyhGjELupTt1QJZpUnpFqGykik
	 9g6dVrsfB8QC8Zh1/UWavPtALP6eFbScGp2LOHYygObzE88kB+PpgP6kR5rKESF8Z5
	 4NxHdC1L7Q1gCQnEcI1P5HzQPA6zc9gzC0e6Xji7uitmOsCyBX9pYqBlIRUf3tEjXV
	 oQj5hLcZ/zIBw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c25344a8c6cso433727066b.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 03:49:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RobwIu8vBfzvPKWN2W52IcDDla2sFv9arfZ2D+mBCsJGFx0ItlmjXIoCI5asphDxPSMuRG9h10=@vger.kernel.org
X-Gm-Message-State: AFuF++ngx/37mcePfFoTvYU66q5ppk+EQqityTx5eOke5NZy/wQgJZWD
	NP7OOmTBmuyPB0pZUJpB4gp4ouylFPQnUr+JtZMw3yNzPL6txtwCJCstxJOoxtm+oOjGzwQF6Qo
	LnEvMjqWHcrOcGtsCtCOCRO3lB4ppeE4=
X-Received: by 2002:a17:907:7ba6:b0:c24:6445:d19 with SMTP id
 a640c23a62f3a-c25571647aemr1514345766b.17.1788173354001; Mon, 31 Aug 2026
 03:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831083015.80396-1-zenghongling@kylinos.cn>
In-Reply-To: <20260831083015.80396-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 31 Aug 2026 19:49:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-u_GJsRjJ6Yar6SFGrmjHkf9dtOXN3WyMm-VRP_Y-XAw@mail.gmail.com>
X-Gm-Features: AcwNN1WR14mGOCcicpJsP9dof_zabIGOc67a1DtCHXACr9QEDzlQw5e9fKV-n9c
Message-ID: <CAKYAXd-u_GJsRjJ6Yar6SFGrmjHkf9dtOXN3WyMm-VRP_Y-XAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ntfs: take invalidate_lock in ntfs_setattr_size()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org, 
	Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 5:30=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> ntfs_setattr_size() updates i_size and resizes the on-disk attribute
> without holding mapping->invalidate_lock.  Page faults take the lock
> shared, so a fault racing the resize can resolve a VCN against the
> transient runlist state of ntfs_non_resident_attr_expand() and fail
> with a spurious SIGBUS, and can interleave with the size-change
> epilogue (truncate_pagecache(), i_size_write(),
> pagecache_isize_extended()).
>
> Take invalidate_lock exclusively around the whole resize after
> inode_dio_wait(), matching the fallocate path and other filesystems
> such as xfs, which wraps truncate in its mmaplock (=3D invalidate_lock).
>
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
