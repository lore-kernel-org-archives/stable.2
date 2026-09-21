Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED004A8421
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000192; cv=none; b=lZiV+cxA/w2/8V+OpmlvRTj/m6VoEOYsr2laWjj/71z46Yn+D80NkZlLH0C6SoJwPo0owmKMVNb1R1BuznfI+ZsqKCWuEHlzf5Whzmtk9wDu+5acbkECFJxsF51vkVk6F/aRJy0cDeEcub/zc0juc9T35f1B2Hlxjpn2yPZQoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000192; c=relaxed/simple;
	bh=XO/Iyvnz3qETNkeIWvlQee03cckRo7x8Wx3SnMguIOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMQhmL+ED2nT6lO58R5aTx24Hx914CiFxY+lCMw4B6diNOz28DHuWpLArnNLIjT4W9M3Kw27QJ507t4m3QggAp4oesN7SCWRpHDZ87ugZo9l+y37pkUYutJVkf5/NrghASsO9EG11SGeouauB0UO1hn8AuS42N4vgGlFA0ZTAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaTgBqbO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaTgBqbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C621F000FF
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000189;
	bh=VNwpL4KwapgAM2FRhULX1UUMm7aiHSA+6ZAEI7tm5o4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZaTgBqbOs/++NmaAKi8I8eqn7YVlii6TUTiSqSWVbsP+41WJK5Fe/b3gXJl+E+viL
	 AzAYX20pz/wlR8DCSByhqrPnWZmxqeUnvWQTzRBnqxl05Y4ajM7JhvLetBVe7DNXEx
	 nLmm9QYIuBF7nxOpndFjPhb6k/ms2fyk8YBDQSrXT3jiuS+wGECPpnxI2uSA2M0+Pl
	 TGihj4BUOKqr3FE+jn7EQzx04Rh+PlCHLAzLg6oGqLudn5zSv8K2UUvVt1lOjTJWMZ
	 9Y4g09xsa34Y6LMZQVU3fWqBWEnhDuy/HyMgzWYsYvC3bBr8UYg2V4t5R0UVnSIp8/
	 +Srg+SyiYUHag==
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7db0so370069066b.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBymXK72TtLk/wpT6RcL6DR++yXggleXTBZX71lJGHtKsTaBQjHI573GBh1Ts4ypsUVwR1aLPGs=@vger.kernel.org
X-Gm-Message-State: AFuF++lUr3O37Ct0oZkSm0nap4TL+XCEV1MUG3PIDq18NfupTRsHCh0j
	BE3KyTboKA3yBXNqcjzeRaoSTDlT4sNol2Qdqbi16+2OqRj+OvE341x3UwoHsPDbyFO1qROgEfi
	6dOTeTKZE1422r8v37xxTX1qYH9wb1RY=
X-Received: by 2002:a17:907:c0c:b0:c24:b11c:6c05 with SMTP id
 a640c23a62f3a-c2a156d58bemr876967466b.14.1790000188573; Mon, 21 Sep 2026
 07:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
In-Reply-To: <20260921-topic-4kn-lkml-v6-0-75069f590b22@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 21 Sep 2026 23:16:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-QufcTW7RRXASSeaoc_fhnKx8sv+m9Quf4Dnqh98RM1Q@mail.gmail.com>
X-Gm-Features: AcwNN1XQ6ml5CtRpw3KH592HGx_gkmEpWnK_Q0XDHSzzi7fG6qv-Z6j9QYfPf6s
Message-ID: <CAKYAXd-QufcTW7RRXASSeaoc_fhnKx8sv+m9Quf4Dnqh98RM1Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] ntfs: support 4K-native devices with smaller MFT records
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 3:44=E2=80=AFPM Hyunchul Lee <hyc.lee@gmail.com> wr=
ote:
>
> Make MFT writeback safe on native 4Kn devices when MFT records are
> smaller than the device I/O unit.
>
> Validate MFT I/O geometry, map and submit containing I/O units, and
> coordinate direct writes with generic folio writeback. When a write
> covers multiple MFT records, preserve the unchanged contents of
> neighboring records in the containing I/O unit. Keep the completion
> behavior requested by each direct-write caller, while requiring
> synchronous completion before releasing an MFT bitmap entry.
>
> ---
> Changes in v6:
>   * Add Fixes and Cc tags to all patches.
> Changes in v5:
>   * Rebased onto ntfs-next from
>     git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git.
>   * Patch 6: Adapt allocations to the kmalloc_objs().
> Changes in v4:
>   * Patch 6: fix for the 32-bit ARM __aeabi_uldivmod link failure
> Changes in v3:
>   * Rebased onto ntfs-next from
>     git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git.
> Changes in v2:
>   * Fix compilation error in Patch 3.
>   * Keep valid but unsupported MFT geometries read-only and reject
>     read-write remounts.
>   * Document the sync-dependent -ENOMEM return from write_mft_record().
>   * Add Patch 9, which trigger page_mkwrite after native 4Kn partial-EOF
>     size extensions.
>   * Add Patch 10, which wait for attribute folio writeback before copying
>     a new non-resident attribute.
>
> To: Namjae Jeon <linkinjeon@kernel.org>
> Cc: ntfs@lists.linux.dev
>
> ---
> Hyunchul Lee (10):
>       ntfs: read MFT writeback bounds under size_lock
>       ntfs: validate the MFT I/O geometry
>       ntfs: write MFT mirror data in mapped I/O units
>       ntfs: serialize raw MFT updates against folio writeback
>       ntfs: track direct MFT writes until BIO completion
>       ntfs: write MFT folios through mapped I/O units
>       ntfs: write MFT records through containing I/O units
>       ntfs: use sync flag for direct MFT writes
>       ntfs: trigger page_mkwrite for native 4Kn size extension
>       ntfs: wait for attribute folio writeback before update
Applied them to #ntfs-next.
Thanks.
