Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E4313E31
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094300; cv=none; b=KXn/RqCNjS1WNNrGTF96Vxc8A5KClodLXmBAexvc32F/HYnqJqD0c5NlCnyMu2+p3HS096YeSK2jkpmn9qcqzqvWc5FeLMnIhtAqq7P0Pos7vooJ6/8Gxd9w7s9WPHaRlyQJlifqGFsmLalmjDPNvEeFYRyu+HJDj1CHuc58IuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094300; c=relaxed/simple;
	bh=jPoslkIrch5pGS7H1VYUPULNCHIu+0vG9BS3QyCzvAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+emkNn/s7org8Q0WbkSPwydDGsdcBHhz1pxg9DKgupBMvYDnh70pQBRUqzlZ8uFuTjZrHSCi1GYfNApdFhzOdGFQI5SFFj89oLnRIP1xB1F7N0xDO1l3sVKUPPGW0OP7amcL3CXyTy9W0/fSWcM6ei5H+XRXsmDIo2+/oIpiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=d1V9VMIp; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="d1V9VMIp"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-679aeeddc6bso560863d50.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792094296; x=1792699096; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6F6+u6wqk7hzKwJePinLCdyx1x0d0YFmhnOveG+uojA=;
        b=d1V9VMIpXBwLdHRbNTVM30YGZToOEIfRknLJDL+e4fQBo/Y3uI5h0noQl1fBuumNxY
         7/ZUcufi1E7T7pewBq8rqfkxgzZwYpoOJg9ebnNWC90C4Di+2CSMU5mBMXuXq6bZNbXV
         Mskxs+Ybh4bDcYzhvcIWcOWNvAQ4pfMiatt0ZNuvrq/K3Aoz32DsEikmZexPoEpaYptM
         PE5Lkxw+ynAlJLdgzHXeA4xC1IxP+4jqHD+KVMMXMAzf4KUyPcwPH+CVsgHDu3OKUg1j
         HOeNv/OfSOoG9QWUkcNKXwwNGMWcL6Bn5jofA5y1JvdIh3Ka/c9FY83/j0GXO18xOaCv
         AWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094296; x=1792699096;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6F6+u6wqk7hzKwJePinLCdyx1x0d0YFmhnOveG+uojA=;
        b=Fjp7zkMQWcOMUhVd4Km7YrZ0vz8bN2oVYr51hu9NIvvEEDXBHBXDJKRkeqLFLLfImd
         15gAk86yaRM36pbpH6ctct7A58cVHWJF6o88pS65pVex2uJdDpFYC9scjYFTQpYHRPHw
         RvW8W5CHh2e7uIjIhzmTBFBCt8GH4rlCl89YoOAKVfVrHcrm7yFJX7pRo70vrVnAdQlC
         pYYHdGUD8AMjHVNNo030vQKIKDZO1MsIEiKRrePB0bWTUwG345efR9M5ZCJzInxdkyFl
         tiVMIycJMJL9ju3mgIlkKls4Iw1tFegpNK244P4fptm/WyhRMNNENYswu8KYkNBiHf7H
         8Gog==
X-Forwarded-Encrypted: i=1; AKwUvBxC1Ik83OKKWMKqGuZ9epHRcIDN+pVkmbRD/WlyW+S3O6sh/+M0E8vWvhhyXLyoe7VVUJSePgw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW+ifGviLvPoVnp167hZ4nc4eWOYfHQGux0P7d2dmG8Ejzm7ki
	G2HGEIPGwnHtnDnXXI4janWzSEPB6jd9/FncD7UVpUMZLSeJrFdgyZjFXN9qx82iklA=
X-Gm-Gg: AYBFou3bn2vOvvwkyrC4SgQ3iZIgyVzQnXL3ldNTHQj28jJ0JK0TteqS7+cHMT/+JKP
	m+Wq++Scty64Aw5LtuKHqZerq4pHe0ZOTUgYmjIWPM0FQ6pb4LM3t4KuBQ/MWb7F9G1Pf0NQTS3
	wtAlVRjbFg+YpZJuzjrj/S0vvwwvgyv6jVhI3WSj9TfFGhMLncerWQYazgBY5FvH1n6y7egmsF7
	irHSOOlIRPkCTT+7PEvh5twdwvJVwGDSZci6/H0I6k97+tv78dKA1JEOQcEFtuAxFRbIst7V9iu
	767piq4zP2tUVCKJ16eFXswXLJsNwjAsAFAe3q+cBy40VLwE0Sr7mPPngPHpyO5UhEGrf4a+uCs
	Iwkjn0uCCJWkngGFmUed0OXrP9zuKOmpb0x4nCEOr0iSPWhqzxhlO8bRi7z2Cvs7T3KrspzfFtu
	uEPKHumLD+d0DsnceB6u+xEXim+75QOULl9+ph6nxj5FhwRdTIFFUPgIO4xwUtYBgC0FvCnm5pX
	IZtZJSqR10w/4CsJ7oV76E8dSTyMxX3qDQQRjyZ3v62xVhToC0zVF5rPxj0pTgxf6rwauIWTWr0
	yoKs+Fk6yoaclUyPd74opehBlWtsgFSjhYzeIioCGDiU55/H2Nnow+6FaTVv4RvUOZTzpg==
X-Received: by 2002:a05:690e:b49:b0:672:a02c:61bb with SMTP id 956f58d0204a3-6796fe86253mr2633374d50.41.1792094296306;
        Thu, 15 Oct 2026 12:58:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f74:f3d:4fc4:4a6d? ([2600:1700:6476:1430:f74:f3d:4fc4:4a6d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1e11207sm382123d50.8.2026.10.15.12.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 12:58:15 -0700 (PDT)
Message-ID: <45b692cfda51e3b10caa27ae51609edc34efb0d0.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 15 Oct 2026 12:58:14 -0700
In-Reply-To: <20261015110114.1649059-1-hengyul@cs.unc.edu>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=mQINBGgaTLYBEADaJc/WqWTeunGetXyyGJ5Za7b23M/ozuDCWCp+yWUa2GqQKH40dxRIR
 zshgOmAue7t9RQJU9lxZ4ZHWbi1Hzz85+0omefEdAKFmxTO6+CYV0g/sapU0wPJws3sC2Pbda9/eJ
 ZcvScAX2n/PlhpTnzJKf3JkHh3nM1ACO3jzSe2/muSQJvqMLG2D71ccekr1RyUh8V+OZdrPtfkDam
 V6GOT6IvyE+d+55fzmo20nJKecvbyvdikWwZvjjCENsG9qOf3TcCJ9DDYwjyYe1To8b+mQM9nHcxp
 jUsUuH074BhISFwt99/htZdSgp4csiGeXr8f9BEotRB6+kjMBHaiJ6B7BIlDmlffyR4f3oR/5hxgy
 dvIxMocqyc03xVyM6tA4ZrshKkwDgZIFEKkx37ec22ZJczNwGywKQW2TGXUTZVbdooiG4tXbRBLxe
 ga/NTZ52ZdEkSxAUGw/l0y0InTtdDIWvfUT+WXtQcEPRBE6HHhoeFehLzWL/o7w5Hog+0hXhNjqte
 fzKpI2fWmYzoIb6ueNmE/8sP9fWXo6Av9m8B5hRvF/hVWfEysr/2LSqN+xjt9NEbg8WNRMLy/Y0MS
 p5fgf9pmGF78waFiBvgZIQNuQnHrM+0BmYOhR0JKoHjt7r5wLyNiKFc8b7xXndyCDYfniO3ljbr0j
 tXWRGxx4to6FwARAQABtCZWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPokCVw
 QTAQoAQQIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFXDC2tnzsoLQtrbBDlc2cL
 fhEB1BQJoGl5PAhkBAAoJEDlc2cLfhEB17DsP/jy/Dx19MtxWOniPqpQf2s65enkDZuMIQ94jSg7B
 F2qTKIbNR9SmsczjyjC+/J7m7WZRmcqnwFYMOyNfh12aF2WhjT7p5xEAbvfGVYwUpUrg/lcacdT0D
 Yk61GGc5ZB89OAWHLr0FJjI54bd7kn7E/JRQF4dqNsxU8qcPXQ0wLHxTHUPZu/w5Zu/cO+lQ3H0Pj
 pSEGaTAh+tBYGSvQ4YPYBcV8+qjTxzeNwkw4ARza8EjTwWKP2jWAfA/ay4VobRfqNQ2zLoo84qDtN
 Uxe0zPE2wobIXELWkbuW/6hoQFPpMlJWz+mbvVms57NAA1HO8F5c1SLFaJ6dN0AQbxrHi45/cQXla
 9hSEOJjxcEnJG/ZmcomYHFneM9K1p1K6HcGajiY2BFWkVet9vuHygkLWXVYZ0lr1paLFR52S7T+cf
 6dkxOqu1ZiRegvFoyzBUzlLh/elgp3tWUfG2VmJD3lGpB3m5ZhwQ3rFpK8A7cKzgKjwPp61Me0o9z
 HX53THoG+QG+o0nnIKK7M8+coToTSyznYoq9C3eKeM/J97x9+h9tbizaeUQvWzQOgG8myUJ5u5Dr4
 6tv9KXrOJy0iy/dcyreMYV5lwODaFfOeA4Lbnn5vRn9OjuMg1PFhCi3yMI4lA4umXFw0V2/OI5rgW
 BQELhfvW6mxkihkl6KLZX8m1zcHitCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29Aa
 WJtLmNvbT6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQ
 gHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSway
 DwYDvgWW5EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb
 16Uz3PC93nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8
 E0O7lVJ55p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD
 4Xg9YE/X8pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLV
 mWWSbgosZD6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0
 ZlStfp0kfVaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7C
 UjbX9DHweGQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZ
 TyOLVJcAAlVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWH
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAabQoVmlhY2hlc2xhdiBEdWJleWtvIDx2ZHViZXlr
 b0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBFXDC2tnzsoLQtrbBDlc2cLfhEB1BQJoVemuAhsBBQkDw
 mcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDlc2cLfhEB1GRwP/1scX5HO9Sk7dRicLD/fxo
 ipwEs+UbeA0/TM8OQfdRI4C/tFBYbQCR7lD05dfq8VsYLEyrgeLqP/iRhabLky8LTaEdwoAqPDc/O
 9HRffx/faJZqkKc1dZryjqS6b8NExhKOVWmDqN357+Cl/H4hT9wnvjCj1YEqXIxSd/2Pc8+yw/KRC
 AP7jtRzXHcc/49Lpz/NU5irScusxy2GLKa5o/13jFK3F1fWX1wsOJF8NlTx3rLtBy4GWHITwkBmu8
 zI4qcJGp7eudI0l4xmIKKQWanEhVdzBm5UnfyLIa7gQ2T48UbxJlWnMhLxMPrxgtC4Kos1G3zovEy
 Ep+fJN7D1pwN9aR36jVKvRsX7V4leIDWGzCdfw1FGWkMUfrRwgIl6i3wgqcCP6r9YSWVQYXdmwdMu
 1RFLC44iF9340S0hw9+30yGP8TWwd1mm8V/+zsdDAFAoAwisi5QLLkQnEsJSgLzJ9daAsE8KjMthv
 hUWHdpiUSjyCpigT+KPl9YunZhyrC1jZXERCDPCQVYgaPt+Xbhdjcem/ykv8UVIDAGVXjuk4OW8la
 nf8SP+uxkTTDKcPHOa5rYRaeNj7T/NClRSd4z6aV3F6pKEJnEGvv/DFMXtSHlbylhyiGKN2Amd0b4
 9jg+DW85oNN7q2UYzYuPwkHsFFq5iyF1QggiwYYTpoVXsw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-15 at 07:01 -0400, Hengyu Liang wrote:
> Commit a06ec283e125 ("hfs: add logic of correcting a next unused
> CNID")
> made hfs_correct_next_unused_CNID() use the CNID of the last file or
> directory record in catalog key order to lower next_id after
> deletion.
>=20
> However, catalog keys are sorted by parent directory ID and name,
> not by the record's own CNID. The resulting next_id can still be in
> use, so hfs_cat_create() finds an existing thread and returns EEXIST.
> Commit 6592287869bf ("hfs: fix incorrect inode ID assignment in
> hfs_new_inode()") exposed this issue by correcting the inode ID.
>=20
> On a freshly formatted and mounted HFS volume, run:
>=20
> =C2=A0=C2=A0=C2=A0 mkdir z
> =C2=A0=C2=A0=C2=A0 : > a
> =C2=A0=C2=A0=C2=A0 : > b
> =C2=A0=C2=A0=C2=A0 rm b
> =C2=A0=C2=A0=C2=A0 : > c
>=20
> Without this fix, creating c fails with EEXIST, although c does not
> exist. With the fix, it succeeds on the first attempt.
>=20
> First look up the preceding CNID: if it exists, it must be the
> largest
> remaining ID. Otherwise, scan all file and directory records for the
> maximum, including files without optional thread records. Follow the
> leaf links regardless of node numbers, bound the walk by the total
> node count, and acquire a reference on every visit so malformed
> cycles
> cannot loop indefinitely or reuse a released node.

Before diving in the deeper review, I have some questions:
(1) The goal of hfs_correct_next_unused_CNID() was to fix the volume
corruption issue. Have you run hfs.fsck tool to check that volume is
valid (not corrupted) after your fix?
(2) Have you run xfstests (especially, generic/736) with your fix?
Because, the patch had goal to fix the generic/736 failure:

    generic/736 [03:18:33][ 3.510255] run fstests generic/736 at 2025-
05-05 03:18:33
    _check_generic_filesystem: filesystem on /dev/vdb is inconsistent
    (see /results/hfs/results-default/generic/736.full for details)
    Ran: generic/736
    Failures: generic/736
    Failed 1 of 1 tests
   =20
    The HFS volume becomes corrupted after the test run:
   =20
    sudo fsck.hfs -d /dev/loop50
    ** /dev/loop50
    Using cacheBlockSize=3D32K cacheTotalBlock=3D1024 cacheSize=3D32768K.
    Executing fsck_hfs (version 540.1-Linux).
    ** Checking HFS volume.
    The volume name is untitled
    ** Checking extents overflow file.
    ** Checking catalog file.
    ** Checking catalog hierarchy.
    ** Checking volume bitmap.
    ** Checking volume information.
    invalid MDB drNxtCNID
    Master Directory Block needs minor repair
    (1, 0)
    Verify Status: VIStat =3D 0x8000, ABTStat =3D 0x0000 EBTStat =3D 0x0000
    CBTStat =3D 0x0000 CatStat =3D 0x00000000
    ** Repairing volume.
    ** Rechecking volume.
    ** Checking HFS volume.
    The volume name is untitled
    ** Checking extents overflow file.
    ** Checking catalog file.
    ** Checking catalog hierarchy.
    ** Checking volume bitmap.
    ** Checking volume information.
    ** The volume untitled was repaired successfully.

Thanks,
Slava.=20

>=20
> Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused
> CNID")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> The fallback follows leaf sibling links independently of node
> numbers.
> Bound its iterations by the tree's total node count and acquire a
> fresh
> node reference on every visit, including when a cycle returns to the
> tail.
> The budget check runs before acquisition; exhaustion returns EIO
> without
> using the partial maximum to update next_id.
>=20
> Tested on v7.3-rc6 with GCC 10.5 and the unchanged KASAN
> configuration:
> 14 normal-volume cases passed, including predecessor lookup, ID
> holes,
> missing file threads, concurrency and reordered leaf node numbers.
> Three malformed prev chains (tail self-loop, a loop returning to the
> tail,
> and a loop excluding the tail) each returned EIO after exactly
> node_count
> visits. The on-disk next CNID was unchanged; no KASAN or BUG was
> observed.
>=20
> =C2=A0fs/hfs/catalog.c | 80 +++++++++++++++++++++++++++++----------------=
-
> --
> =C2=A01 file changed, 48 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index 490c5e130da3..2d90f1857781 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -269,48 +269,54 @@ void hfs_set_next_unused_CNID(struct
> super_block *sb,
> =C2=A0 * Correct the next unused CNID of Catalog Tree.
> =C2=A0 */
> =C2=A0static
> -int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
> +int hfs_correct_next_unused_CNID(struct super_block *sb,
> +				 struct hfs_find_data *fd, u32 cnid)
> =C2=A0{
> =C2=A0	struct hfs_btree *cat_tree;
> =C2=A0	struct hfs_bnode *node;
> +	u32 max_cnid =3D 0;
> +	u32 remaining;
> =C2=A0	s64 leaf_head;
> =C2=A0	s64 leaf_tail;
> =C2=A0	s64 node_id;
> +	int res;
> =C2=A0
> =C2=A0	hfs_dbg("cnid %u, next_id %lld\n",
> =C2=A0		cnid, atomic64_read(&HFS_SB(sb)->next_id));
> =C2=A0
> -	if ((cnid + 1) < atomic64_read(&HFS_SB(sb)->next_id)) {
> +	if ((cnid + 1) !=3D atomic64_read(&HFS_SB(sb)->next_id)) {
> =C2=A0		/* next ID should be unchanged */
> =C2=A0		return 0;
> =C2=A0	}
> =C2=A0
> +	/* If the previous CNID is still in use, it must be the
> maximum. */
> +	res =3D hfs_cat_find_brec(sb, cnid - 1, fd);
> +	if (!res) {
> +		hfs_set_next_unused_CNID(sb, cnid, cnid - 1);
> +		return 0;
> +	}
> +	if (res !=3D -ENOENT)
> +		return res;
> +
> =C2=A0	cat_tree =3D HFS_SB(sb)->cat_tree;
> =C2=A0	leaf_head =3D cat_tree->leaf_head;
> =C2=A0	leaf_tail =3D cat_tree->leaf_tail;
> -
> -	if (leaf_head > leaf_tail) {
> -		pr_err("node is corrupted: leaf_head %lld, leaf_tail
> %lld\n",
> -			leaf_head, leaf_tail);
> -		return -ERANGE;
> -	}
> -
> -	node =3D hfs_bnode_find(cat_tree, leaf_tail);
> -	if (IS_ERR(node)) {
> -		pr_err("fail to find leaf node: node ID %lld\n",
> -			leaf_tail);
> -		return -ENOENT;
> -	}
> -
> +	remaining =3D cat_tree->node_count;
> =C2=A0	node_id =3D leaf_tail;
> =C2=A0
> =C2=A0	do {
> =C2=A0		int i;
> =C2=A0
> -		if (node_id !=3D leaf_tail) {
> -			node =3D hfs_bnode_find(cat_tree, node_id);
> -			if (IS_ERR(node))
> -				return -ENOENT;
> +		/* A valid leaf chain cannot visit more nodes than
> the tree. */
> +		if (!remaining)
> +			return -EIO;
> +		remaining--;
> +
> +		node =3D hfs_bnode_find(cat_tree, node_id);
> +		if (IS_ERR(node)) {
> +			pr_err("fail to find leaf node: node ID
> %lld\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_id);
> +			return PTR_ERR(node);
> =C2=A0		}
> =C2=A0
> =C2=A0		hfs_dbg("node %lld, leaf_tail %lld, leaf_head
> %lld\n",
> @@ -331,42 +337,52 @@ int hfs_correct_next_unused_CNID(struct
> super_block *sb, u32 cnid)
> =C2=A0				pr_err("fail to get the keylen: "
> =C2=A0					"node_id %lld, record index
> %d\n",
> =C2=A0					node_id, i);
> -				return -EINVAL;
> +				res =3D -EINVAL;
> +				goto out;
> =C2=A0			}
> =C2=A0
> =C2=A0			entryoffset =3D off + keylen;
> =C2=A0			entrylength =3D len - keylen;
> =C2=A0
> -			if (entrylength > sizeof(rec)) {
> +			if (entrylength <=3D 0 || entrylength >
> sizeof(rec)) {
> =C2=A0				pr_err("unexpected record length: "
> =C2=A0					"entrylength %d\n",
> =C2=A0					entrylength);
> -				return -EINVAL;
> +				res =3D -EINVAL;
> +				goto out;
> =C2=A0			}
> =C2=A0
> =C2=A0			hfs_bnode_read(node, &rec, entryoffset,
> entrylength);
> =C2=A0
> =C2=A0			if (rec.type =3D=3D HFS_CDR_DIR) {
> +				if (entrylength !=3D sizeof(struct
> hfs_cat_dir)) {
> +					res =3D -EIO;
> +					goto out;
> +				}
> =C2=A0				found_cnid =3D
> be32_to_cpu(rec.dir.DirID);
> =C2=A0				hfs_dbg("found_cnid %u\n",
> found_cnid);
> -				hfs_set_next_unused_CNID(sb, cnid,
> found_cnid);
> -				hfs_bnode_put(node);
> -				return 0;
> +				max_cnid =3D max(max_cnid,
> found_cnid);
> =C2=A0			} else if (rec.type =3D=3D HFS_CDR_FIL) {
> +				if (entrylength !=3D sizeof(struct
> hfs_cat_file)) {
> +					res =3D -EIO;
> +					goto out;
> +				}
> =C2=A0				found_cnid =3D
> be32_to_cpu(rec.file.FlNum);
> =C2=A0				hfs_dbg("found_cnid %u\n",
> found_cnid);
> -				hfs_set_next_unused_CNID(sb, cnid,
> found_cnid);
> -				hfs_bnode_put(node);
> -				return 0;
> +				max_cnid =3D max(max_cnid,
> found_cnid);
> =C2=A0			}
> =C2=A0		}
> =C2=A0
> =C2=A0		node_id =3D node->prev;
> =C2=A0		hfs_bnode_put(node);
> =C2=A0
> -	} while (node_id >=3D leaf_head);
> +	} while (node_id);
> =C2=A0
> -	return -ENOENT;
> +	hfs_set_next_unused_CNID(sb, cnid, max_cnid);
> +	return 0;
> +out:
> +	hfs_bnode_put(node);
> +	return res;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -420,7 +436,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir,
> const struct qstr *str)
> =C2=A0	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> =C2=A0	mark_inode_dirty(dir);
> =C2=A0
> -	res =3D hfs_correct_next_unused_CNID(sb, cnid);
> +	res =3D hfs_correct_next_unused_CNID(sb, &fd, cnid);
> =C2=A0	if (res)
> =C2=A0		goto out;
> =C2=A0
