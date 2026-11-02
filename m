Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635339;
	b=QbCaKaSSWT/QfaZAtKgYT5ktRTBJd9VPpLx8h6Pls1PyuEoOv1sKvMwCmkr2xSzYHSFh
	 nxURWhXdlE6DGRUXyhHAZWV8Ba2wosTi9/4p0KEh6mcgUUStMN34lWbbo0M1EyapWRd1X
	 n0qR6VweWPjY28eYtLmMQtFOetHLi3tXCYlhUKvs07AS2wShgLZcwa+fgd2+eYy2mp8Es
	 3s4pX3IBqEEA6jD4QsBhZjKxcLYjwTGKLpMxSpc4dgQEBqppu+nhkwaURngsM7D1Pwkqn
	 bJVW63yBdlDnYm9jywEt8s35NslZnuM1x+9UVQcZBjvNBMZKSbdo2+FfYcHgUbhr3pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635339;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=my3Gy4VhBcCnxn3lpGePp3/MUKijhn1RD2kN7QnV5ow=;
	b=sNLgoK6ix5nodFQGbSx27862lXrDJVZnXZL5uwnWOMT5xvd3c78ODs1MZh8ThGN9tJUS
	 uhZCZUI2HkOO/lcaSWKGcgzDxoHZm4Jgw+DhajG1s/4pyEP5NSLltILltK+tsw+lE739X
	 iocKEY7EZO5c9sw3EcC+4PNLqFwXWL45dfpDBXmikcX6RnjWzWkmiFZG69jOUlrFArKVG
	 GhKdIW2MX3U1r8MEeus3C4dH6WscApdFVcBI99ISvWCi0dcCasWnMKPwSGdriB/Itndqe
	 7dz0cVsyWuos1Ee+/Yk0m9R7fKq3LuyuWiCyddKwtybEUeSBOYTe1UhnagrbSqu6+3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJ5U5Pab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52670606C3C8
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJ5U5Pab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FB41F00A24
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635339;
	bh=my3Gy4VhBcCnxn3lpGePp3/MUKijhn1RD2kN7QnV5ow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DJ5U5PabOmA/ey/5VjSH6gWp7xcsN6kcQEujnrwH8+5TEy/9vQyT+8QkLM/rdd8+4
	 /9Feok7QwkpV+5tHZ3qaBHqaleIelJ+CJVi9Llm9JosTvkF2T5N6JWsRqkb5YPBk5G
	 egTyxaSZ3B4YcHsINFY9oxatYAUBFFP+UZgN9LwGQMw3qqBKyCaZW9uAjmb8igLIIj
	 b/5z7rAJeWMccktDeDU0dHO3oAYBc48vE5+b/6WYPnL92ynFGemx/G/txA8UiJG/bd
	 mNLD8YCSC95hMpOBhCVE1Zk6FVAB5a80/J2tuLR1sPIu4LhBJ8kyNVwb1FSDkSR5Uw
	 +ZBQv5SmG0j4Q==
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafb65e204so843426e0c.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:02:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzYjOqMEpH1mh8JoGL0RrsiTxU/0b9C5ZV4Uq1XXUKwk9OCqakzXuMz0QM2RTmrQnm+IC4rWuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i1UHdKZamr8VHSt9AA9ocELZ+4u5HD1cHkNg9Tr5mWGIQ+Sdw
	ykV+4Eum034jgAyOaGqxDbMxB1k7PYbTLVkP0T1neAVAj45xGgD5Fd3TNInT+rVEtpsPAJgbvjD
	/QrayzxC0//+H/b7pl+T3rIGCeXKC2tg=
X-Received: by 2002:a05:6122:9006:b0:5e9:5e79:ab3 with SMTP id
 71dfb90a1353d-5ec689b817amr4907502e0c.21.1793635338188; Mon, 02 Nov 2026
 08:02:18 -0800 (PST)
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
 <20261030-b4-btrfs-data-integrity-v1-1-f4d4196731e6@toxicpanda.com>
In-Reply-To: <20261030-b4-btrfs-data-integrity-v1-1-f4d4196731e6@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Nov 2026 16:01:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6VYYcfH+WHVZW482_6f2EPoyPFE-_qbyPfcS580LhPhQ@mail.gmail.com>
X-Gm-Features: AclHuK_KPgnKhXM8k7V-XuqKmmKo6NZT17VCZXB4CaNbVG-gg0vK1J3OI0FLct8
Message-ID: <CAL3q7H6VYYcfH+WHVZW482_6f2EPoyPFE-_qbyPfcS580LhPhQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: don't drop the error of the last split bio
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
> When a btrfs_bio had to be split, btrfs_bio_end_io() saves the first erro=
r
> of any of its parts in the status field of the original btrfs_bio. The
> part that completes last is supposed to load it into bi_status of the
> original bio before calling the end_io handler, but that is only done if
> that last part was successful:
>
>         if (atomic_dec_and_test(&bbio->pending_ios)) {
>                 /* Load split bio's error which might be set above. */
>                 if (status =3D=3D BLK_STS_OK)
>                         bbio->bio.bi_status =3D READ_ONCE(bbio->status);
>
> If the last part failed, the assumption is that bi_status was set at the
> top of the function. That is true if the last part is what is left of the
> original bio. If it is a split bio, the assignment was done to the split
> bio, which was freed right after. If the original bio has completed befor=
e
> without an error, its bi_status is BLK_STS_OK and stays like that:
>
>   original bio (tail)                 split bio (head)
>
>   btrfs_bio_end_io(orig, OK)
>     orig->bio.bi_status =3D OK
>     pending_ios 2 -> 1
>                                       btrfs_bio_end_io(split, IOERR)
>                                         split->bio.bi_status =3D IOERR
>                                         bio_put(split)
>                                         cmpxchg(&orig->status, OK, IOERR)
>                                         pending_ios 1 -> 0
>                                         orig->end_io(), bi_status is OK
>
> The end_io handler covers the whole range, so for a buffered read all the
> folios are marked uptodate, including the ones that were never filled, an=
d
> read(2) returns their content instead of -EIO. For a write the ordered
> extent is completed as if all the data had reached the device.
>
> This can be reproduced with raid0 data on two devices, one of them slower
> than the other and with a bad block, by reading a file whose last stripe
> is on the fast device.
>
> The saved status has the first error of all the parts, or BLK_STS_OK if
> there was none, so always use it.
>
> Fixes: d48e1dea3931 ("btrfs: fix error propagation of split bios")
> CC: stable@vger.kernel.org # 6.12+
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/bio.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 2c6234f6182f..fc0b021cdefb 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -127,9 +127,12 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_st=
atus_t status)
>                 cmpxchg(&bbio->status, BLK_STS_OK, status);
>
>         if (atomic_dec_and_test(&bbio->pending_ios)) {
> -               /* Load split bio's error which might be set above. */
> -               if (status =3D=3D BLK_STS_OK)
> -                       bbio->bio.bi_status =3D READ_ONCE(bbio->status);
> +               /*
> +                * Load the first error, if any. It may come from a split=
 bio,
> +                * including the one we were called for, in which case no=
thing
> +                * stored it in the original bio yet.
> +                */
> +               bbio->bio.bi_status =3D READ_ONCE(bbio->status);
>
>                 if (bbio_has_ordered_extent(bbio)) {
>                         struct btrfs_ordered_extent *ordered =3D bbio->or=
dered;
>
> --
> 2.55.0
>
>
