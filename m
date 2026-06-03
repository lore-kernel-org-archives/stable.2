Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B813D51E
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506044; cv=none; b=GDHM0ykh941rdi4PYYQECaK0adBNPkv7Kq286RBbuOYbljvE3FvpKkXZ/Zhw2cjhQiVaIa9kwimcCIYK1E9Qkk6P+oS+nS6kX6KJZCflspq69XKeISACoWEfpD0/b+tGj6PVqEC1/KrtjZxVPGZCfrUOQLfOHZjlhpiSq33i2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506044; c=relaxed/simple;
	bh=C+atMj8E0VeFS8Jwo86eg+YRLRoqAUV9YsabUhuPPBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1vM/5syJ7zOvkqOIe7/7ePqXhel7lYfJ9WzKV/vXwNiKwVcExQdMvQcs4wFYH/6Z1OOpwSXxwS3/UG0Fp3mbKj+3FQLnIcCBZQWdgkVOdS94vzPe/UfBCNFSiaocB0sQ357fiPVfG02KZITqKHBdpP9tmPVf7lYM9RxIdaFdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=sbHvG4Ic; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="sbHvG4Ic"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6da33a561so1400295a34.3
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780506042; x=1781110842; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8BNbn8Gw6ErCpk7zWof03GfRzDK3VA/rjGXDP/C41+8=;
        b=sbHvG4IcfVxwht39DzOpBoHp3xl3f3VolmILIYYFrenie2UtYcTmT0BCofCVn6gYo3
         xS/QgmwOZBOloGR6vqYzAKuKBt80I0MCP+yTmrKq05xM7NQtA7vB+5K/dMTlFtdS4ocu
         Mme/sCJAY7BuSyCMCQNksXauoZz78WWvn5TPj7J5fnoS0IGxq57IVCYvTub5USk87Vpw
         BDBP5vpSk+8mBDF2Hxgh+NbFUAVXk09wqLGYooP1GFkqY+rm6aAZ5khbQ16gNcwNKeCH
         NVlZlPXhnq6MYS4VyBLhTvJN3j/TUKFsvrZhm5vs4TJKhErOmG2eo3e8KGc3xtqs6G80
         NzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506042; x=1781110842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BNbn8Gw6ErCpk7zWof03GfRzDK3VA/rjGXDP/C41+8=;
        b=I1PT10y63Z8kALkGD6o9aQ+a0eHN8fwdjfSpMIEQdGCbPjln6erLJ2s0G06npgNipd
         31qB9s3Fx/asNLE4q5uHkmC8QHQ4cXxKA3t1m5jrsHe0XkAhxrcJahoPLT5NDxvu1YxG
         q45YLAIYtdHdR7fyOpLgZGxJwkAlVkqRkUEMwZlWVyZ38lizQQfqMpyyy5BdFzUvTgJw
         hH+7KLeO9jCJgYGZKfW2134lIPWg6RYFjkmC70nBjC2ZhOxtQARwIvN278dHBKnVDD4o
         ypZRxY5Q+HYmDsX0i0qSCEFnq+uRs2jFpVCOSdlAD6BMNlWe4CQhMuS0HwYuwCyu0xfv
         YoFg==
X-Forwarded-Encrypted: i=1; AFNElJ/BWypzy5HBAlPP6+fTSQSOeRlSpt0K5t/oYsvBQX3Wmql3bJgyoXeYpKg4YUBfvF+wDQzfMxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57v4/zLACI8T4BgCVAaM/B/AKynY0sk6k5LsKAH6PN8+FsSVj
	i4MAXPZswwkPAHO5I/CDF09DNEq9aangxgo/vHEXEwkgXschzHLPZnSMok9bFhfa3vQ=
X-Gm-Gg: Acq92OG0mv1eiXYLYxKWEEXmwE8mNYHNlE2J3OddUsbcPleijzvd086RI5q7CwTOt2U
	0qMMc+xrkMmcKwIkiSL2P+f8kYP52AN/TXoyZRWU/tmi8N69y+6JWRuuWUQSdXKqV1FYXN/rmvO
	3YVp4nhS5BJSYJRfiUJy/lSjLuaGKBVNZErgoUGuE1REWRy+qcyMJXTNkL3KK8xeZQg//zmKegu
	pumKebmQTiPkqipHUprBHlUlGG/Ya0sWLhQDuDAWbQlQ1OyNGi5shbStaIa7oylZ5/jdiqq+6kZ
	Mkvw00+KTFSMwkXEJNqyFQpAy6wlaHhWyOs8uILjMzI9aWhvWDID0JEBCh5JuC3eqnA5ilRUmWn
	wRMN9Dnqj575wYfEv2hXs8iNJEUDMhpfPda5MFwtaWGG/4rBdzRoMciVafLuN5OPB6gY63Lcju+
	T7ZNqZIkMgltLVt/7SrO+elpj+3dglUCsQaf5oNKby/dAGiUFEsw6yXQOjE+J6ePHPF45QZ8/JP
	V+LNIThXNFbgJJ7nA3KdZwunOzw8OabqyR9/cSkwSl/IMj+HJA6HuK4wy3EFIZBqXxK
X-Received: by 2002:a05:6830:628c:b0:7dc:e30d:6498 with SMTP id 46e09a7af769-7e6e9460e83mr2502186a34.1.1780506041996;
        Wed, 03 Jun 2026 10:00:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9912:77fa:9c5:3949? ([2600:1700:6476:1430:9912:77fa:9c5:3949])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e7f9csm2086785a34.17.2026.06.03.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:00:41 -0700 (PDT)
Message-ID: <f4c297b40c443347dde71e4d7ee3d08b9c95c0be.camel@dubeyko.com>
Subject: Re: [PATCH v3] ceph: fix writeback_count leak in
 write_folio_nounlock()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Wentao Liang <vulab@iscas.ac.cn>, idryomov@gmail.com, amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 03 Jun 2026 10:00:40 -0700
In-Reply-To: <20260603012500.3688976-1-vulab@iscas.ac.cn>
References: <20260603012500.3688976-1-vulab@iscas.ac.cn>
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

On Wed, 2026-06-03 at 01:25 +0000, Wentao Liang wrote:
> write_folio_nounlock() increments fsc->writeback_count to track
> in-flight writeback operations. On several error paths where the
> function returns early (folio lookup failure, snapshot context
> allocation failure, and writepages submission failure), the function
> returns without calling atomic_long_dec_return() to decrement the
> counter.
>=20
> Each leaked increment keeps the counter above zero, which can prevent
> the filesystem from cleanly unmounting or suspending writes.
>=20
> Add atomic_long_dec_return() calls on all error paths that currently
> return without decrementing the counter.
>=20
> Fixes: d55207717ded ("ceph: add encryption support to writepage and
> writepages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>=20
> ---
> Changes in v3:
> - Also clear write_congested flag when decrementing writeback_count
> =C2=A0 on error paths, as suggested by Viacheslav Dubeyko.
> - Fix typo error.
> ---
> =C2=A0fs/ceph/addr.c | 12 +++++++++---
> =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index a606378649c3..7fab73874068 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -790,7 +790,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0				=C2=A0=C2=A0=C2=A0 ceph_wbc.truncate_size, true);
> =C2=A0	if (IS_ERR(req)) {
> =C2=A0		folio_redirty_for_writepage(wbc, folio);
> -		atomic_long_dec(&fsc->writeback_count);

Patch is not correctly prepared. Because, current state of the code
hasn't atomic_long_dec().

Thanks,
Slava.

> +		if (atomic_long_dec_return(&fsc->writeback_count) <
> +				CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +			fsc->write_congested =3D false;
> =C2=A0		return PTR_ERR(req);
> =C2=A0	}
> =C2=A0
> @@ -810,7 +812,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> =C2=A0			ceph_osdc_put_request(req);
> -			atomic_long_dec(&fsc->writeback_count);
> +			if (atomic_long_dec_return(&fsc-
> >writeback_count) <
> +					CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +				fsc->write_congested =3D false;
> =C2=A0			return PTR_ERR(bounce_page);
> =C2=A0		}
> =C2=A0	}
> @@ -849,7 +853,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_vinop(inode), folio);
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> -			atomic_long_dec_return(&fsc-
> >writeback_count);
> +			if (atomic_long_dec_return(&fsc-
> >writeback_count) <
> +					CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +				fsc->write_congested =3D false;
> =C2=A0			return err;
> =C2=A0		}
> =C2=A0		if (err =3D=3D -EBLOCKLISTED)
