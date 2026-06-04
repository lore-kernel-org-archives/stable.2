Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE753367B90
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600919; cv=none; b=QA4nyHgMe3oG+1lAAIUAwv4xbJ8Z/tGfviTnNdrULGimkpb2XyG+3j7/S1N4aCkYZddM47KTcV2nLyxj8ZTUGivTXLSgLXxh/K6cL5+sYMIinDFkRtw+8ksnOxvWzMNLj8mvd8IlSoeor/GG9Duu6M2XE1K7oFNJDacu1Opfn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600919; c=relaxed/simple;
	bh=D+B46+kztZoRfRolR7Jt51wzkhaDVreQ7b6TY6p0T2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLxVcQS38PHvSxmxVauWdkEm6sRcgI5HmODaeSYiM3VaLlt2GQhjN/mFNGOF9FE/WRBQoTrnmSuVV5OXnjSVbpMIvfR1NtgCvV2wA5QiCjzvolqgGXT7iA4PYf3eSqY7NThkc3XyumqrEfInk69Nzu0C56hvEkUUwoJX/mTc920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=VHwNmPOT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="VHwNmPOT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dee6b76a73so11143897b3.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780600917; x=1781205717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+coeGXnnITnN1q6Wtsx1WTv71YYvQ9kaZogeVQjE5sc=;
        b=VHwNmPOTciMymZxKURuTPzC5VqERX0GsP6QgQi4NEYMIppulAon0pkr20Hd8PvL1nK
         2LF3UJEZvi/gzEZAt+uh4XnVFf8NOFM0DOoJE0M1kU5R2hHJrS7jyPiGM+6vrZ5nJ+wN
         OjbUWhyZqCbnqWVzI12N/QEeIqxes8r58nxbafISdKTZtLXT9jW0LeT+39J9a4kppLC7
         ShwQrYvzljVdYcT7S0NmlUdcTtDfTB04X/fwfREBrHoqToaut66xtHZdUA8HjoHNklbX
         Qeq4r1HbgvdlN7NxP3QV295ayEqKK+KN7wqZEC7XnsfnDYaw6wCaCubMATS7a5+botLa
         XGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780600917; x=1781205717;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+coeGXnnITnN1q6Wtsx1WTv71YYvQ9kaZogeVQjE5sc=;
        b=rB1aQCuwR01EaLljwngd06GDfBoe6titCQG68V61vlerMPlSk6CLYJOEINCmvop+q6
         mb5cE2aoOc1iZBTqtPp86eC14krEg9shpmpO3GbtcPMC6F6C/4weNQFHzBj4gHrwMF1Y
         6yc/Lqz+h+b8USXM0fCC8MelXit9K1RtAsMtij/qU9/4HEUziyEFCSGCL6VvYc/fa4Ao
         iQqalgja1MOYD7RUjaPW+PRWhuPS5YXpTaRrmIQ6NUX3RHPtV8+OE361ytnwUPS2/U17
         R9aPcW05dmX48aHS/ugsJEjXNUaxN/1KGkMXieJLi9p5bHu13SXJgk0336rt9O3lAMsY
         KVsg==
X-Forwarded-Encrypted: i=1; AFNElJ97bhiyOultCpGpippPMHv6wHPtHwk6snvxylXwC8TTX78zustaD1HI6qmDjLrXCVf02Oou6DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgP99xc5lK3QbbMlA3EoweCnCRmfU7NGkAXby1fZVRAoPDdGIp
	yq9M3T0WLmXnhqwSy6TxzM6WRTezuUBj4wNEA0G0CRAnWsJ4cUMLUKJndOzdn3Y4fm0=
X-Gm-Gg: Acq92OHbDHHsGEoIWcJY3PrUvEm6PmTAZADA5sFrlfRwfkJmrwqM/sEgQNX8fOCwp1L
	dBBuxMONKlfEyqxOseKijnNgnxqosZbFHe/l7r6KCPD7QYJ3YCrMIGOaUCm/HK94DUFaUDAmzuR
	6QiaIv89MsPZgFiWxeUnc7IFsbzAth7TOWW7VJzJRIluW46//wq42nVGlVh2GszOm8fGJoJrVVi
	ZkdZAWUYH4rwFuHl+GfVqHSArD5+ZOAmjeU38Hzs1jTaGx6NiuEyG2UyyLD1w4/lMe2iHE7JoML
	kyRbo8Mku4DKXhR7zwrSJBOBjqcvhmB48yS4E1R659JbQFSeswXFw0ANOsovHvupOuz8DXVZxpB
	b38g18HjEBmxLqFLtlY8Jy/wYnd2QsMzVqaqXcySDzme33+16ayBcR/FzhzyHwfEj7xgNDmbKC4
	m2T+6scvvqEIChKLR6fwQrc8KkAz0830DBjzrF4556cp4lU0Z8gA6cpzi0Xq3x+v8F3hJ0gfqAZ
	+aFDX5Ma0GmFVMwmy202lSqHY35xsfs1ADPdncuRPg5CFBipS9wOiQ/kyEYXvC0cVsBGEE=
X-Received: by 2002:a05:690c:48c6:b0:7dc:de6a:da63 with SMTP id 00721157ae682-7ed0de8d7bfmr2666637b3.49.1780600916810;
        Thu, 04 Jun 2026 12:21:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ae19:b6b2:5990:ed2a? ([2600:1700:6476:1430:ae19:b6b2:5990:ed2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23492a24sm38618937b3.27.2026.06.04.12.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:21:55 -0700 (PDT)
Message-ID: <da52131887fd085e7d21036a6b67d6795a64bb6b.camel@dubeyko.com>
Subject: Re: [PATCH v4] ceph: fix writeback_count leak in
 write_folio_nounlock()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Wentao Liang <vulab@iscas.ac.cn>, idryomov@gmail.com, amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 04 Jun 2026 12:21:53 -0700
In-Reply-To: <20260604021951.3761714-1-vulab@iscas.ac.cn>
References: <20260604021951.3761714-1-vulab@iscas.ac.cn>
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

On Thu, 2026-06-04 at 02:19 +0000, Wentao Liang wrote:
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
> Changes in v4:
> - Also clear write_congested flag when decrementing writeback_count
> =C2=A0 on error paths, as suggested by Viacheslav Dubeyko.
> - Fix typo error.
> - Fix diff error
> ---
> =C2=A0fs/ceph/addr.c | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 0a86f672cc09..7fab73874068 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -790,6 +790,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0				=C2=A0=C2=A0=C2=A0 ceph_wbc.truncate_size, true);
> =C2=A0	if (IS_ERR(req)) {
> =C2=A0		folio_redirty_for_writepage(wbc, folio);
> +		if (atomic_long_dec_return(&fsc->writeback_count) <
> +				CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +			fsc->write_congested =3D false;
> =C2=A0		return PTR_ERR(req);
> =C2=A0	}
> =C2=A0
> @@ -809,6 +812,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> =C2=A0			ceph_osdc_put_request(req);
> +			if (atomic_long_dec_return(&fsc-
> >writeback_count) <
> +					CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +				fsc->write_congested =3D false;
> =C2=A0			return PTR_ERR(bounce_page);
> =C2=A0		}
> =C2=A0	}
> @@ -847,6 +853,9 @@ static int write_folio_nounlock(struct folio
> *folio,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_vinop(inode), folio);
> =C2=A0			folio_redirty_for_writepage(wbc, folio);
> =C2=A0			folio_end_writeback(folio);
> +			if (atomic_long_dec_return(&fsc-
> >writeback_count) <
> +					CONGESTION_OFF_THRESH(fsc-
> >mount_options->congestion_kb))
> +				fsc->write_congested =3D false;
> =C2=A0			return err;
> =C2=A0		}
> =C2=A0		if (err =3D=3D -EBLOCKLISTED)

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.
