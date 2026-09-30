Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F55172CB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787717; cv=none; b=lsJuNNKCO2oA3sXdD3QIXhXgtop+nPB2m/eHX5kjM34zF2PJoQlQtVqIkwsFBJ7LgFyYXW/rOOfY4c/4d+9xNcZx8KKWRcSIiFsI1Aph0nBRdndkZKZIF73mgMgJXU6zrOGAtkpoRY5rfnBGyzAHnkDtiuv493ktqeblPvkSb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787717; c=relaxed/simple;
	bh=XWeEzXxDpkMmNDypWoIhf2yRRXW21sTTifusYA/fKyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebN20tukLflXdVwdFoDWex1fYlboyskJD9AiUCyNNlCEmpViSmwRY8t5ewwjRYN7x4xHZl6BrAAEV9SvT2f3ADnqgsKElhyDyOYyWWn2DAx8mmAUkA6xy4mFIF/7AEY6eEVA5uymmH92N7vG7C4TvnlehGuFqohj5MP/ASlWvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=TLhEewDj; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="TLhEewDj"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac47074ae1so10816127b3.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790787715; x=1791392515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/K23H6l8P+7n/vgMZMU8enzS+4DMqLYI7tKT7n06Vo=;
        b=TLhEewDjRzycySUdnpDm0rrQOgPZodYah7AkQXQUdnW5zOJzSC+FJNB/8oWhSWm3ua
         jT9yU+Ndv0Ftgq58tqZ2Kg1AG4tNoY+uUrpOXuv/QS0UwLrL0v/9ngHqnx+8D5bZ6YJv
         6xR6HxqCZOGyBRwQ5EA9iwutpCiZjqhveD2OZyIFHW5r31FL0TIIche79cumSFSUhijs
         RrawHY2sKRm8Db2EoC9gLnPomWG+2hsQX32IQLBiFeUzcyCwsN2C2YBfUBsNKmcPNbYk
         rh6tFL0HdPvEEYdB4LOhR7QkLwtenkLg3jgCjoQ/J9ZxWoq5fAUB/++PWy2bP/yuXcXS
         TNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787715; x=1791392515;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O/K23H6l8P+7n/vgMZMU8enzS+4DMqLYI7tKT7n06Vo=;
        b=Bpqoa2RVGgVY1DPGFHdD1FTbiwKJjUaJl/N4KZRuDOCVyyFrMPNbg7ruTTzyOiAesy
         EFw41fg1XYnK0y0rNC5HBnk0JijkoEDoXDT5F9yq1MkTqKUI+8LGn6yr25AldXutF+Lt
         AqN76AIz9yV+0SJ850JBF61E7fBNGCgqIVJ7a1LNJ21ECUZjjLg/bPURtdmkBbS+ynSi
         bleF64fV7Ba5pJrFLVKzxU6qHhucVJFbdJhhiNm5sw/upeTsACmZ85jEnNLcURKRTod8
         iA1+0BkQFYYmc+SSS3kUgEGVhiou14Zkh7L9fbEt3I7LWng0JW3FdGMl64GAcWxQ5Apj
         KMIw==
X-Forwarded-Encrypted: i=1; AKwUvBxpPT6wPnI/ODwlnanGTHXB8Ztneu1CJw3EEzbyEdz3ofi6AB333s4aId0msXiFMzYP29J6bdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIstJf0ZhJWFCW8FiOhec1BJDnQHk+rb+q3/rVdco6rGIzxonHj
	X/KUwRwm6gdlBRW06UkbeMFh8Xdwcourotv6xBZn8Cq8fYhcpNZiLsTfecRqmlmW45E=
X-Gm-Gg: AYBFou2s0AK9pIawruWrI/FRLIQAQikSe9x+4keiCXCKlkQRAIyVxWL7l7v3io6v+gG
	FuYAwy6PPT61EOP/EXiWzbfdz6BdGFUYYsVhe9nfRx0Gxsi2YWBg3ynFrVbryCeyYmAhoNV02bm
	AyApMbarLy9UIwTHkOMbX2ttCmHSZmAkq3dYn/DMe8jayUH0IeH4A6G7bBVPLbyMlxMLtDOZFFb
	+LGBfAmsjF5dR5bpvvYvbPxgT8sqC03nM7OgcmhB0p+E1UDN+bdy7oayTk4xVoy/9KA5cDLg4T+
	hfZZZUYLmFH7EWRzlKv8bgQrgsf4Mh8RKINK3DGGJtBFZWjn9JXGBJb0QAUdnexoScnoKax8kNa
	O9BxRANhQZXf05W8czkzM9j/LJ6EfXNzssdYblpSqWwOfSsWgV7NIvEs+WW3un3X5nEcaZTbh5Q
	WRnOeUcknOZdOTRlOD/sqQDasK2cRoN6mG5/Qs2the7aCd5uTmZoiDxhe8htxzoZQBm27cMNcKV
	kEGEj/XoRjE0qA6Y3ftzh+YDebYSHPLKvsvOIVvxmh76SMqxrjnTYanaKXlEYorutrGj8fweLlB
	b6i97tBegjnmaVHta5tkcaKGOmY2bNqJqZKsihfHg+QWtSXchbJTA53clQz4+YA2
X-Received: by 2002:a05:690c:6113:b0:8ab:318f:1b61 with SMTP id 00721157ae682-8ac9321853fmr10252457b3.41.1790787714466;
        Wed, 30 Sep 2026 10:01:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:487b:bc91:650e:71d4? ([2600:1700:6476:1430:487b:bc91:650e:71d4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdac9c648sm1568277b3.14.2026.09.30.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:01:53 -0700 (PDT)
Message-ID: <43aaaa19a0020c532e4abafd8df197bb14478fc9.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: don't give the extents overflow file overflow
 extents
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Date: Wed, 30 Sep 2026 10:01:50 -0700
In-Reply-To: <20260930162726.144048-1-ngocthang2710.1999@gmail.com>
References: <20260930162726.144048-1-ngocthang2710.1999@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-30 at 23:27 +0700, Nguyen Ngoc Thang wrote:
> hfs_bmap_reserve() grows a b-tree's backing file via
> hfs_extend_file()
> while the caller holds tree->tree_lock. For the extents tree itself,
> once its three MDB extents are full and hfs_add_extent() returns
> -ENOSPC, hfs_extend_file() falls through to insert_extent and records
> an overflow extent for the extents file. The next extension then sees
> alloc_blocks !=3D first_blocks and calls hfs_ext_read_extent(), which
> takes ext_tree->tree_lock again:
>=20
> =C2=A0 hfs_ext_read_extent()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 <- hfs_find_init(ext_tree)
> =C2=A0=C2=A0=C2=A0 __hfs_ext_write_extent()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_bmap_reserve(ext_tree)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_extend_file(ext inode)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_ext_read_exten=
t()=C2=A0=C2=A0 <- hfs_find_init(ext_tree):
> deadlock
>=20
> The extents overflow file can't have overflow extents of its own; its
> extents live only in the MDB. Fail with -ENOSPC instead, returning
> the
> just-allocated blocks to the bitmap. hfs_btree_open() already rejects
> an extents fork larger than its MDB extents, so this keeps
> alloc_blocks =3D=3D first_blocks for the extents file for the whole
> mount.
>=20
> Reproducible with a plain mount + ftruncate on a fragmented volume
> with
> a small extents-file clump size.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De390d66dda462b51fde1
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Notes (not for the changelog):
>=20
> Reproduced in QEMU (x86_64, lockdep) with syzbot C repro
> 11c3a202580000,
> and more simply with mount + ftruncate(0x100c17a) on the same image:
> "possible recursive locking detected" on ext_tree->tree_lock followed
> by
> the task stuck forever in D state. The image's extents fork is
> consistent (one 4-block extent), with a 2048-byte XT clump and a
> fragmented bitmap, so the three MDB extents fill up after a few
> extensions and insert_extent runs for the extents file.
>=20
> With the patch, 3 runs of all five syzbot C repros plus the direct
> mount+ftruncate case: no lockdep report and no hung tasks. ftruncate
> still returns 0, since hfs_file_truncate() already ignores a failed
> extension.
> =C2=A0fs/hfs/extent.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index f066a99a863b..5e7a1f1eb395 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -457,6 +457,13 @@ int hfs_extend_file(struct inode *inode)
> =C2=A0	return res;
> =C2=A0
> =C2=A0insert_extent:
> +	/* The extents file can't have overflow extents of its own
> */
> +	if (inode->i_ino =3D=3D HFS_EXT_CNID) {
> +		hfs_clear_vbm_bits(sb, start, len);
> +		res =3D -ENOSPC;
> +		goto out;
> +	}
> +
> =C2=A0	hfs_dbg("insert new extent\n");
> =C2=A0	res =3D hfs_ext_write_extent(inode);
> =C2=A0	if (res)

Sorry. But I decided that I would like not to review or accept patches
from your side. You are making the same mistakes during the working on
the comments/remarks. We are not making any progress. It looks like
that you have no memory at all. So, I assume that you are using an AI
agent without any analysis or checking the output.

Thanks,
Slava.
