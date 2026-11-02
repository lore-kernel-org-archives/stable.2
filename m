Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635386;
	b=mY1zQjXICDvZwgMw8CWoSSu89Fs2mz+jE+5DpzpK7Nv2cR+f7umeYTIsl2QG9J9WAZut
	 E8jLGuU8gw8L/lnCD5u+PTEQAytjw0sOTnaKrHUzVdGgmDgSeL4n0xXsLiAkt+Z+Nt79T
	 Xwe+6jl3S0d+F5diHxsYfGELaA5q8XaBNhj/RvhZbutX8f5SWvstCWsw2Qs0ueEa74wzE
	 2e5cCmpvF5bZIINtfjsyF/pRPjnZDhGSHF7t9cSW3nD0OVOJmSSzoPA9TufA/5h56s2nn
	 WVvahBgHrrxdxgLzOtEoF+MeAiIiz5EzHw/q5YCl9rE/EhtPpRqdZSWUlguwz6p1tng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635386;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bZtDBjzgkv5xQcYlp5Yum+2Qy7bTJw3wf4TUeP34ezY=;
	b=mQVW+5mivxnon4knuMqVQzy2QO8Q03g1zgXM6vlf+WUTJe7ISuDrxlC34iY/Qlbb0gXD
	 XjRjeGxEkXYlKcDmsaKdbWYIzXyq/tNLlXmiku5An1bTMKgqW1mvRM5HKZZHcLNevJnOu
	 Ks5XKFfreTKGVLM6Mm9cSoyen6aYCLs51VreUArDax/BIBBpVcyU1d0RHWEOy60Nrn8qN
	 rKZ/Q9wg0lHupM5yM1GECnDuhPIGYeJcJVhoJpWanPzjgRjGKvymQzsurH30GbkhIA++u
	 etJF4rEffKvZ/H1QkePYoiekKSOImXcmv9iDfFHYPwZdYs0eLfo5rkS60iD4qI0eaKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNRl1L5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503A606A5BC
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNRl1L5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF8D1F00A1B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635386;
	bh=bZtDBjzgkv5xQcYlp5Yum+2Qy7bTJw3wf4TUeP34ezY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KNRl1L5s6/wEyvvsLuFpJ6plEXwOmrCadaiQnku6A1vaHVWQtMmYscsY9m4HRFLoK
	 eS7l2l/rzSvw7FCzbD+wftk5ezxRbLYqX1a/7EFKjsl1CClVhwnY9KF7jv0Qcyh2n6
	 vtulGe8hNAvgiXu6HVmquT9II9muR5M2r1GJpFWEDTdW/aEPK/OgvuTgwsbQbv0+v5
	 cucbeCjXYXFaA6zy9XHdqmZNiDyCKvZC4+Di0z+5y0fm6+rhR3iAyEpb28STEOFgLn
	 WkLSK37mZNco1WUUF9HNi0uLmrYzZGbJKpyuIrnnFDZJ+cJHq29ZHfSw4z2auSsRdN
	 3HiDujdROvHSQ==
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso1141431e0c.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:03:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy4ZgVxrEyWAaMwAxTPWtmeVwYL5NmNZ4NMWHrsyxR/bxbhcYvyzWa5AyvBYO1SPRsnMQXRfcY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RGFb3EEPaZ64F03jJDW8hnw4gIe4olNiO4le8ZD+d/nD0on6x
	f90gtBYpoO6ncM1e6gJgdLm0tJp0tki5azi31UV1SPmY2Sl2UHTNIas3cxVM1M3cH5o4mIgCoXK
	H2I+WWze0g8d3D6UzPxYPmySODv1qf+I=
X-Received: by 2002:a05:6122:c88:b0:5ea:d03c:f0e9 with SMTP id
 71dfb90a1353d-5ec68944736mr4322887e0c.12.1793635385467; Mon, 02 Nov 2026
 08:03:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
 <20261030-b4-btrfs-data-integrity-v1-2-f4d4196731e6@toxicpanda.com>
In-Reply-To: <20261030-b4-btrfs-data-integrity-v1-2-f4d4196731e6@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Nov 2026 16:02:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H69Ci=+6xdadWanzMNFwKJXzCzQwgBP2AZNz-GjVkSmKQ@mail.gmail.com>
X-Gm-Features: AclHuK9hJ6ZkQF9NbDoC3yqIUdGKzYNetSEDAGDD0vFFCJQvSJFv8xogAO1abdg
Message-ID: <CAL3q7H69Ci=+6xdadWanzMNFwKJXzCzQwgBP2AZNz-GjVkSmKQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: clear dirty blocks after a delalloc failure
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Qu Wenruo <wqu@suse.com>, Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 2:38=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> If writepage_delalloc() runs the first delalloc ranges of a folio and
> then btrfs_run_delalloc_range() fails, the blocks that already got an
> ordered extent are finished with an error through
> btrfs_mark_ordered_io_finished(), but their dirty bits are left set. The
> next writeback then submits blocks whose ordered extent is gone, or is
> about to be completed a second time.
>
> Fix by clearing the dirty bits and cycling the writeback state for those
> blocks, as submit_write_sector() does for a block it fails to submit.
>
> Fixes: 72dad8e377af ("btrfs: fix double accounting race when btrfs_run_de=
lalloc_range() failed")
> CC: stable@vger.kernel.org # 6.14+
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5ff630630490..3283835ccb5e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1746,6 +1746,16 @@ static noinline_for_stack int writepage_delalloc(s=
truct btrfs_inode *inode,
>                         u64 start =3D page_start + (start_bit << fs_info-=
>sectorsize_bits);
>                         u32 len =3D (end_bit - start_bit) << fs_info->sec=
torsize_bits;
>
> +                       /*
> +                        * The blocks are not going to be submitted, so t=
hey
> +                        * must not stay dirty. Otherwise they are writte=
n back
> +                        * later without an ordered extent, or worse, wit=
h this
> +                        * one if it is still around, and invalidating th=
e folio
> +                        * would account for them again.
> +                        */
> +                       btrfs_folio_clear_dirty(fs_info, folio, start, le=
n);
> +                       btrfs_folio_set_writeback(fs_info, folio, start, =
len);
> +                       btrfs_folio_clear_writeback(fs_info, folio, start=
, len);
>                         btrfs_mark_ordered_io_finished(inode, start, len,=
 false);
>                 }
>                 return ret;
>
> --
> 2.55.0
>
>
