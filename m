Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFD3749EE
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429236; cv=none; b=Lws3omYYsvqmbCe18ThVLQVKr3mx3D4RR9ZvisGREM1yu7EJPsW8hDqbF5xgT8/AStB2/P/h7v4KyGUF9zO5I+7kSqIY0Yb11d4RKhyQHyoeX3t67I4VYUu8+WNw4WlfRCua0S8ngxe+RIq4iU6RS+RfkFeNcubjOK3t8yYsdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429236; c=relaxed/simple;
	bh=mQA10aYsOEP8iIaXuNBGBc5gLNsFdb0tp4I0tLQ4MRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl9pF1wVU73bY/ZsgezEiC1xeKPMHVNiMB+AkwWUJpszd2L5t/L84hTu7uNuA/YtC2h9WygklytcQhJZhBvrLXjupdm17ISIzZ807uFjGwP6NHPqRc3k3fzRVQLqssXJ5GxRU1Dnp85Juakx5hxU6sjmQNqowyuLLU4prVframg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTXOjAPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTXOjAPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E217F1F000FF
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429234;
	bh=liBqBbhKk9zqZy2dq2M0aeZH+K42pgabEGh7x8JOI7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NTXOjAPgCxsrGC2Ga2QItnd3wztAPDgpdj6b7tHkG6jfUbpH6fVoYaOJyy7etI31E
	 B1RvIcvF/K4YcaQQkSb/pAzvYVQ+CyDcEek68/K9qV1g6rDbrrQsUGREyUl0vvYA3y
	 dpZGxdqdficKDN/zoP2AZOI1dOg7THsfp4pPs9ZSFOMMbzNLG1/TmTzqlbBUQ672+I
	 VMKRqSn8erRQNgMRrV0hmbLgO86R9F+jlYGZh4+uWUVn9lcUfVc0AakeJgQnoroHI4
	 B4SjgXkyUH3IUI/rdSFQuswjocMGYzMg67MROPdBa1p7g/48PRLEnL10fnRiJjGSqC
	 uMhBIwWsKCq+w==
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43daa8f4so21503497b3.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 16:40:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxCvSWrgN3lUfgSltK7vXJSIEy8GcbiNvAO/xb5VoIGSzdZiIkUNbqbVTSO8ES9CQx2pyhY4V0=@vger.kernel.org
X-Gm-Message-State: AFuF++lm+zlG/fJkiI0mhb8InMKe8ABVm9SVfZD5Gl9ZyinLAzVYNPme
	g9xDYDJftfAyV/qVSl4VlJn+FsO1gpQXiVitb0kVzz2KOUjZ0EFR9cxx1r1krffet2v2hAQZanS
	YhG3PknIZh3/O4rN0HJLVYX+hzAaVAKQ=
X-Received: by 2002:a05:690c:397:b0:85a:89f3:f53 with SMTP id
 00721157ae682-88d2068cf44mr15259417b3.24.1789429234169; Mon, 14 Sep 2026
 16:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-up-generic650-v1-1-d98825ead540@gmail.com>
In-Reply-To: <20260915-up-generic650-v1-1-d98825ead540@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 15 Sep 2026 08:40:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-gtdztQPov0JhTmA6f7=zoAqeNWR65LKRkrT1SLQ+8EA@mail.gmail.com>
X-Gm-Features: AcwNN1VZXXqBWE-BRBh9wu8LqploVG2Isu9AaALG8Jkgx5cPKMOEMSdHDLHfdyg
Message-ID: <CAKYAXd-gtdztQPov0JhTmA6f7=zoAqeNWR65LKRkrT1SLQ+8EA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid truncate and writeback deadlock
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 12:19=E2=80=AFAM Hyunchul Lee <hyc.lee@gmail.com> w=
rote:
>
> ntfs_non_resident_attr_shrink() drops page-cache folios after freeing
> clusters and truncating the runlist. The VFS truncate path calls it with
> mrec_lock held. A folio writeback can need the same lock to resolve its
> iomap mapping, so truncate can wait for writeback while writeback waits
> for mrec_lock.
>
> A hung-task call stack:
>
>     truncate: mrec_lock -> truncate_inode_pages() -> folio lock/writeback
>
>     writeback: folio lock/writeback -> ntfs_write_iomap_begin() ->
>                mrec_lock
>
> ntfs_setattr_size() already calls truncate_setsize() before
> ntfs_truncate_vfs() acquires mrec_lock. Reuse that page-cache truncation
> in the VFS path and skip the duplicate truncation under mrec_lock. Keep
> the cleanup for internal attribute callers, which do not call
> truncate_setsize(). This avoids synchronously flushing the whole
> discarded tail while preserving page-cache correctness.
>
> Fixes: 4e646ecd4475 ("ntfs: drop stale page-cache when shrinking a non-re=
sident attr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
