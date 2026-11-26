Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709535;
	b=hdT9cWD7Dyvpy/pDagcORvIIhmqlpMG9luMDuLzQeJsz2IjIVHoqkXWh9eQd8sXGnjuO
	 yQhovSDh8uxJIwGwOP3CLn5qGO4jCeiM4fq/CbBUPXW7D6psbVAtVNATHsBVGOI5/C2zD
	 MrU9miYTMNCP7Z/YkCJmVxdAEYVwYhtCycJkZA8Qv4TCX9006E3aHNZALG/IxxiuBXIp0
	 ULnh6l7GvGjs7yexZCxRlG7EG42B9Uzmt2lN7fNd/Wy5UmdXCypEVDUT1/HGhKsFNDRQG
	 GsRCLwqwYJ5WfPkwITFwktAvvVW1glTrwJdt/Y1d2GOON8kZs/stbsllwZsY0vFE8wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709535;
	h=DMARC-Filter:DKIM-Signature:Cc:Subject:Message-Id:Mime-Version:
	 X-Lms-Return-Path:To:Date:References:In-Reply-To:Content-Disposition:
	 From:Content-Type:X-Original-From:Content-Transfer-Encoding:Received;
	bh=9TlBbw2aLS2+bA5mje/QMgnKZO+YDq72LJAQAEjCShg=;
	b=mT7AwlIOhw7DyHR2NT/vJr9ZDe3jL+KrS4OFv+5wuSAwWaVU3uXaol2isGVMF75kGeBY
	 /xUn6ZyDOjBF9XuHZnrQtfQ5zLT73xLzs1JWGXKBu8YeXtjCD+5jtGX0qj/N+MKlIr85g
	 ahvXfC202fD9lcd+IUfvDv4+/Vl684Ef6AqwkEhgrJxn5bTrkXgTknmpOjWq6ieYVbJ5z
	 TL8rXL0Q2KbD3PeASblFh4s3SnPzrp1KTc1Spgl4BAZ9dP+uA6WeuKocrN1CshCwLwm4l
	 7+FmLms+QouIvtZxrHKK5j5R2y7GQOHMBqDP+X0Z+sJKJ+VVnRoapGlJweRz+a81Kaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fygo.io;
	spf=pass smtp.mailfrom=fygo.io;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=XbThLBIw;
	arc=none smtp.remote-ip=209.127.231.54
Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2A606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C2A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=XbThLBIw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1795709529;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=9TlBbw2aLS2+bA5mje/QMgnKZO+YDq72LJAQAEjCShg=;
 b=XbThLBIwQS1paxUsh8cEtAcu7UloX0sEC5nXqKwJYrnGCz3q9XsZNPVW7fodKn+bunuBId
 s7A9/Dg3zfIB3pjEzeO0Czhl4EjYjgN8mEp4DSPSfSYd3a3ZNo86voARQcN5QRVE66ROxg
 /17yU94neN2Ily960fT8izYj/lucQe7LBiZ8UAPDAQygTD753jDhlecsGx2DQISnGBrYRR
 Fc2THckFOP74e8IEFHo2KMtlusth3jeVI69sya9UDMgAe3Ad6sZ7xvKqj7JjjjRVECuMlr
 +PMI6Wx4IKEKGJ8j99JCTrUKWsOIqkwOCa6etDL8PTF14fuvVs/y2CZ4+9YZ7w==
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>, 
	"Jens Axboe" <axboe@kernel.dk>, <linux-bcache@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Seojin An" <love09010224@uos.ac.kr>, 
	"GEONWOO HAN" <gunwoo9643@uos.ac.kr>, <stable@vger.kernel.org>
Subject: Re: [PATCH] bcache: fix out-of-bounds write in bch_data_verify()
Message-Id: <awhLVBrBR51A6KmN@studio.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26b085a58+cfe4dc+vger.kernel.org+colyli@fygo.io>
To: "Hyeonjun Hong" <hyeonjunhong330@gmail.com>
Date: Fri, 27 Nov 2026 00:12:05 +0800
References: <20261126093655.393608-1-hyeonjunhong330@gmail.com>
In-Reply-To: <20261126093655.393608-1-hyeonjunhong330@gmail.com>
Content-Disposition: inline
From: "Coly Li" <colyli@fygo.io>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Coly Li <colyli@fygo.io>
Content-Transfer-Encoding: 7bit
Received: from studio.local ([120.245.64.140]) by smtp.larksuite.com with ESMTPS; Thu, 26 Nov 2026 16:12:07 +0000

Hi Hyeonjun,

On Thu, Nov 26, 2026 at 06:36:55PM +0800, Hyeonjun Hong wrote:
> bch_data_verify() sizes its check bio from bio_segments() of the original
> read bio, which is an unsigned int.  bio_kmalloc() takes an unsigned short,
> so the count is truncated before bio_kmalloc() compares it against
> BIO_MAX_INLINE_VECS.  A read bio with 65536 segments is truncated to zero,
> passes the limit check and gets a bio with no bio_vec space.  bch_bio_map()
> then fills in bio_vecs from bi_size without looking at bi_max_vecs and
> writes far beyond the allocation.
> 
> A single read bio of this size reaches bcache through an io_uring
> registered buffer, which the block layer attaches to the bio without
> splitting.  Reading 256 MiB from a cached device with verify enabled on a
> KASAN/KFENCE kernel gives:
> 
>   BUG: KFENCE: out-of-bounds write in bch_bio_map+0x132/0x420
>   Out-of-bounds write at 0x00000000cb5c6057 (132B right of kfence-#252):
>    bch_bio_map+0x132/0x420
>    bch_data_verify+0x3d2/0xc40
>    cached_dev_read_done+0x6d4/0x890
>    process_one_work+0xafd/0x1ee0
>   kfence-#252: 0x000000008ee01c90-0x000000001f8e8fd6, size=120, cache=kmalloc-128
>   allocated by task 12 on cpu 0 at 63.371786s (0.000577s ago):
>    bio_kmalloc+0x45/0x80
>    bch_data_verify+0x2be/0xc40
> 
> followed by a general protection fault and panic.  A 255 MiB read is not
> affected because its truncated count still exceeds BIO_MAX_INLINE_VECS and
> bio_kmalloc() returns NULL.
> 
> The verify path needs CONFIG_BCACHE_DEBUG and the verify attribute to be
> set through sysfs.
> 
> Check the segment count before it is narrowed and skip verification of
> bios that are too large, which is what already happens for every other
> count above BIO_MAX_INLINE_VECS.
> 
> AI tools assisted the source audit, reproducer construction and patch
> drafting.
> 

The fix makes sense. Thanks for the patch up. I take this for 7.5 submission.


Coly Li

> Fixes: 0f2e6ab851ae ("block: turn the nr_iovecs argument to bio_alloc* into an unsigned short")
> Reported-by: Seojin An <love09010224@uos.ac.kr>
> Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
> ---
>  drivers/md/bcache/debug.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> index 2691a5da3368..fa665b4628b1 100644
> --- a/drivers/md/bcache/debug.c
> +++ b/drivers/md/bcache/debug.c
> @@ -112,6 +112,14 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
>  	struct bio_vec bv, cbv;
>  	struct bvec_iter iter, citer = { 0 };
>  
> +	/*
> +	 * bio_kmalloc() takes an unsigned short, so a larger segment count
> +	 * would be truncated before its own limit check.  Skip verification
> +	 * of bios which cannot be represented.
> +	 */
> +	if (nr_segs > BIO_MAX_INLINE_VECS)
> +		return;
> +
>  	check = bio_kmalloc(nr_segs, GFP_NOIO);
>  	if (!check)
>  		return;
