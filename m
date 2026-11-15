Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702596;
	b=S9Dp1nwkKTysIBkHqzo/RNpIvZ3DlbNdxTwSglg+zThOcZuma73J1I4fECRMJr6K7Onq
	 EVj46uhpEJhht2CQMD2tLIVerhQvTgYxOBm6YBRHFF4KrhxpkVYBTr6tTKQBK9wbeazJk
	 I17Q2jC/VX9QfCVa4jkKLunRQ2UaOsHACK+PXB8EtQ+d1e4HuNvrfTpNbMn1X63yKsfvn
	 kuYsabrzn7JMcK7/LqgZHVNxPq8R97Vsv8YSMNZBphD4hazom+S6vSEVlBGMzt18qSg2s
	 LHZ926EY0XGyAqzcJ3Nwibg+H/Q9hSyb9MYKjb9O6Rd7h6p97qhypdo8wTHTAZaw0bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702596;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=enBhx9VQimcvOxaezFBJwJ0l0s5cxrvOgc+zxqU4vkc=;
	b=OrxnmDw9aGJF5d0yCfArphpC+n+LY74mncwV+tLivbgMVQnq0iEWIykVfb5DGvM6wvHB
	 XDwAoPwcU6rsyxpeN4v2HyBjO4YWAxhPpTHusKbatYzSWlugp+Zg/H4lgHVQbf9K5Ms4Q
	 l9jUHYQO0IzmaYrny0FP0vzauYQpXRMikQUnvmgsJPhAeShnpKHNPe1QnWALaB/GANUzC
	 1BD82oBDNI7Pp1Tpt5eAEA6AD1KsLwZ7Z3cGN7Xtv7jT7G1mWWP87EOhZJydjUoVD3nQi
	 ew004gImC1i9S+RoJ6dG80L2JbM6DC3gUjH2LMuBDL0Di7cBJhaBI37ARALTS5DXthg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAkZs5v1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2D606A32E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAkZs5v1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2581F000C5
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702596;
	bh=enBhx9VQimcvOxaezFBJwJ0l0s5cxrvOgc+zxqU4vkc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lAkZs5v1XjB0EGqNipWP9Yxvhrwg/oaCSXGwoZzKsIQ8q2Ils+eZnEziSuHaKavSU
	 GIgfQ3FADf07Sy095edgyeBPu9H5cdnDk420H07oR7XrK5/LsWc+XnvjAeN71rpHtI
	 9L5FzFCcV/9hCP79aMiUyAjY6Lw/B9c4EUpFfxdUwOuFPePubtNQWR6BHnL/RJ+6Sd
	 K/ET7+pWkgqo5zeZfLhq48sdLVdWl9Sghj0hI6TPlKtqmzVHoV1+mtgFH+M9QMWLPP
	 1cF4oVO/Po4VZreRkUMdTHc+u0CJnWHIkUeo3rj6XgSDWgGtM02Zm9Y7pTXDjqX8rr
	 iQODlsRjxVHSQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c505186727fso424793266b.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:29:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF3JA4FifNbc9Kn1H7JmFcJAkKmLTKTs30ZP4Gw4hZJya+X/pUTuTVjBmJLWoXOF2Q8UMcFxkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z99wvOtIDoSDT0fbRpLnwKfgqQH1ISmAwvOXlN2xEZ+32MFNG8l
	6DK2RretHcQW1LDVXtELjifzbeqX41n/Z1xm1j0Bz6nKyplbZoanC33hBus3PLICO/MwZrsDhLp
	XXNztrJ5BzF8wL9ZbixXzMlqQeg5unfo=
X-Received: by 2002:a17:906:ee85:b0:c4d:2895:e492 with SMTP id
 a640c23a62f3a-c509636a10dmr492344866b.21.1794702594951; Sat, 14 Nov 2026
 16:29:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109173229.1921147-1-wahidzk0091@gmail.com> <20261114073451.367708-1-wahidzk0091@gmail.com>
In-Reply-To: <20261114073451.367708-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 15 Nov 2026 09:29:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9s8NSv9oa=ZLKXDD8UdB25SZ8ftTYO0Xij=dF6hSvL9A@mail.gmail.com>
X-Gm-Features: AclHuK-m-Sdmrwl51aOuB0L1ae5zj9gizIwQS7njO6zY9g4NU8zJZfCUozdHAng
Message-ID: <CAKYAXd9s8NSv9oa=ZLKXDD8UdB25SZ8ftTYO0Xij=dF6hSvL9A@mail.gmail.com>
Subject: Re: [PATCH v9] ntfs: convert a named $DATA stream safely when making
 room in a record
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 4:35=E2=80=AFPM Wahid Khan <wahidzk0091@gmail.com> =
wrote:
>
> When an attribute has to grow and the mft record is full,
> ntfs_resident_attr_resize() walks the other resident attributes and
> converts them to non-resident ones. For $DATA it always opens the
> unnamed data inode of the base inode, even if the attribute found is a
> named stream:
>
>   tvi =3D ntfs_iget(sb, base_ni->mft_no);
>   ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);
>
> value_len is the length of the stream, so it does not match the
> attribute that ntfs_attr_make_non_resident() looks up for the unnamed
> inode, and the WARN_ON() on entry fires:
>
>   WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
>    ntfs_resident_attr_resize
>    ntfs_attr_expand_locked
>    ntfs_expand_for_write
>    ntfs_file_write_iter
>    vfs_write
>
> It does not need a damaged volume. A file with an alternate data stream
> whose record has no room left is enough.
>
> Open a named stream by name with ntfs_attr_iget(), as is done for the
> other attribute types in this loop, and keep ntfs_iget() for the
> unnamed one. The loop runs with the mft record lock held and takes no
> lock of the stream inode, so converting a stream from here needs more
> care than the plain lookup gives:
>
> - A reader of the stream holds the folio lock and then takes the mft
>   record lock in ntfs_read_iomap_begin_resident(), the conversion takes
>   them the other way round and waits for folio 0. Take the folio with
>   FGP_NOWAIT in this loop and skip the attribute if it is busy. The loop
>   only tries to free space. The same inversion exists for the conversion
>   of the attribute being resized, which waited for folio 0 with the lock
>   held and hangs against an mmap fault or splice reader. Use FGP_NOWAIT
>   there too. The resize then fails with -EBUSY while such a reader is
>   stuck on the lock, instead of hanging.
>   Do not look for room in other attributes either: the reader keeps the
>   folio until the lock is dropped, so the attribute can neither be
>   converted nor written without waiting for it, and the loop would only
>   convert other attributes for nothing.
>   FGP_NOWAIT also fails when the folio can not be allocated, so on
>   failure look the folio up: only one that is there means a busy folio,
>   otherwise return -ENOMEM.
>
> - A stream that is in the inode cache can be open, being written, being
>   removed or already unlinked. A write that passed its residency check
>   before the conversion carries on with a non-resident attribute, and
>   a stream in the middle of ntfs_stream_finish_remove() is converted
>   under its feet. Convert only a stream that is not cached.
>
> - An attribute inode of a file that has no links left is evicted on the
>   last iput() with its dirty folio, so what was converted is lost and
>   an open file reads its extended attributes back as missing. Convert
>   nothing, of any type, in a file that is being deleted or has no links
>   left.
>
> - The unnamed data is converted through the file's own inode, whose
>   i_rwsem only a resize of the unnamed data itself holds. When a stream
>   or an extended attribute is being resized, a writer of the file can
>   have passed its residency check and carry on with a non-resident
>   attribute (iomap_iter warnings, recursive mrec_lock). When the
>   unnamed data is the attribute being resized, its conversion was just
>   tried by the caller. Do not convert the unnamed data from this loop.
>
> - Do not convert the attribute that is being resized either. Its
>   conversion was just tried and failed, for instance on a busy folio,
>   and a second try that succeeds leaves the resize to go on with the
>   resident layout of a record that is now non-resident.
>
> - The lookup of a stream ignores case, so a stream whose name differs
>   only in case from an earlier one resolves to that one and the length
>   does not match again. Compare the names exactly.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
Applied it to #ntfs-next.
Thanks!
