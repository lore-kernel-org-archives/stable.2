Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4C3FF1DC
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051020; cv=none; b=mClAPIPjLcCAuQYugXEW+t24v0PcUDe7CmXOE7ApbyU/x/U8LzkAKlfB+AND4SJwRde/FqzMvW2spUvzyS9/UY0HaSSd7636jNidj4oYIHfXeQQwXNURVIys8dDp7S3Emjrtwl5rPEvQW1wPIRmwjPzhlLAANJIDE7qV1SX712s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051020; c=relaxed/simple;
	bh=rrheX9zLnTW0q9CUdPKHOxyibv+wv7jJL8WMfHrf2G0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyEdBQaEwl4v/GsC+/gBQdF35+oS+Tur8MqhOgHHaETMFkYelNW06ZMJru7QnUMBSKiodgZmzPDNl6pu255UV+vkfdnIyDfNnY262MISNE23yZlqb0l15bt9kZA5ctF+B/gEwr54sh5yHz5fr+A5h+rbk3f+JAxpWoXE8FAIiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=QXod+ipn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="QXod+ipn"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8111c0c7561so60827277b3.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784051012; x=1784655812; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G9wlwE1qc1NCTa5GQJy5k8lqlcIm2ec1yJpzofB80Ug=;
        b=QXod+ipnxSKfyJ6+TksfrOr0XbppMP8+9VZlmW6ZH9jmJ8gvYip+5uu7HYGBmrUX8O
         l2y329JroToourITPBLwgoE2NcaPMLSTg5UAcaa5VprxxY9VOW1V+02aZS5M4LdOf4ug
         nHc21DWY1o5sP5GXpZXBq1hMLZP7MBnnteON6rKksDFPnGxpGmHq5XgmZAvs1XfQMPlB
         Yt3t8TDpliYJ9Ii/jMsTyWIM5jilqklMTkuq8zoD5yCbXLYPjJjfUj0E1Y+ZwYTnytZO
         iphFFvk80L4q/x/WRcpi4exmKdSWzRKBxhz0SKvAzp+OO48+oLOYxLad7VZwkLqVGdNk
         /xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051012; x=1784655812;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G9wlwE1qc1NCTa5GQJy5k8lqlcIm2ec1yJpzofB80Ug=;
        b=me3dYvKRuds6oAbCIjmZcTxpu6+ndrfCwSy0/lP+NpNuSJHfRkwT2OjhMyo97xyHT3
         7V3lPjRXzeqJLDRQu9k6bMIZhaoqNo3i8Ueuybkyl6vLpZkO101dXFLj7RRj9F4ZirEB
         +vKoFXGJ19f+G64NuUccjXERAWgQ9GCHTghA+Ea46V3b/Oiqy01BMwGwKMLQNwAbHSaf
         okgZJkYKKPk/B/LbADg28tj2JBtg0dpPH5baSfFxcz7cJjg8RjnSjNXChbuvuBAB4o2Y
         zd1waCy4E2RC3QXusTe+I6CPqeM5gN1dU46bpC8UT/KvECkEC+SsoJ3CjE3wCpFJoTCw
         Lw1A==
X-Forwarded-Encrypted: i=1; AHgh+RqxYARH2NWqfzbY+o/TLu0h1NWdVJWWFVwB9NI/hbCkikdQ1ShsaTLvnvIB+Wp8h2xpaJBVXtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3c91DzciNViFwZ5+7BFW26akVku1q+WuuQOVJCc1KW01b0dQq
	bpxXgBV+Gm19+Tq00l+mOf7EEqgxsCcm8ko7zrg6txnOEXunsbb3NCfdRuaNGTka7vA=
X-Gm-Gg: AfdE7cnZgy/zX4Fs0jlWPIxEWpVoC9v8OKKeCuyUxwswfj30/m5qAht927wjiK5SHQW
	JF+zMeS3TkJR+gzNcyBnFSDxvhojOB+orbfJnfp1Od0ZlsLbOx2QeVdzZAq9WqI8wVkyiCpKPF0
	/Kv8R4isLB0RYvQl07N8KpY7t8ip5tbHHwNf02HmhrAk1LhHViXMgD41lWC4YffsYCPyEuTtmDE
	/xnfEv17kxKYZoePQFxGwA8lzCLL2GmzaYiTtFo/eykdjHN2vrtOtVLrgG6Cs/C/oi9gqXZooKf
	eZjqCI+pDKp/1wL0DDLeDexLGjNZssUngRb5fhSKGKpsCAnawiEgFcklqg5LZEcC10r8ANRbRm4
	rnm4aUzB5ZpHC/Gqc2ORPuiE2oyHRPKCKtyjhQ816ls49LYXnPvCuuINBAo5XwpZ2c2AHYqkYK7
	1MUwoDHzpX4hUbuqldogDC21tH0jHIUKIPpIjosPunEp3neIZQI6sOYPAyv0+enMP7QrMsrmNe4
	bwE1Cea7iyFfRvU1xpdmd9mdd/BIheFDcBJ173jmMIv1Gu2ebZXLKrCOlpgryGdb/DuSe3YABXz
	MUl0YgyOL5ddM7d9
X-Received: by 2002:a05:690c:660a:b0:81e:6d9b:1556 with SMTP id 00721157ae682-81ec0076513mr23814757b3.42.1784051011994;
        Tue, 14 Jul 2026 10:43:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b87:2209:14fb:1802? ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be98397sm147788057b3.6.2026.07.14.10.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:43:31 -0700 (PDT)
Message-ID: <94afbe7aab19700afa9ec7200675e6c15cf344af.camel@dubeyko.com>
Subject: Re: [PATCH v2 2/2] libceph: add KUnit coverage for OSD sparse-read
 extent validation
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 14 Jul 2026 10:43:29 -0700
In-Reply-To: <20260714115141.3768034-3-michael.bommarito@gmail.com>
References: <20260714115141.3768034-1-michael.bommarito@gmail.com>
	 <20260714115141.3768034-3-michael.bommarito@gmail.com>
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

On Tue, 2026-07-14 at 07:51 -0400, Michael Bommarito wrote:
> Add KUnit coverage for the sparse-read extent-map validation added by
> the
> previous patch. The tests drive the real osd_sparse_read() state
> machine
> over a synthesized OSD reply (no OSD or network): an in-range single
> extent is accepted and advances the cursor, and an extent whose
> offset
> lies outside the original request range is rejected with -EREMOTEIO
> before
> the message-data cursor is advanced.
>=20
> The suite is included from osd_client.c so it can exercise the static
> sparse-read parser and cursor-advance helpers without exporting test-
> only
> symbols, guarded by CONFIG_CEPH_LIB_KUNIT_TEST.
>=20
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> =C2=A0net/ceph/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 12 +++
> =C2=A0net/ceph/osd_client-kunit.c | 146
> ++++++++++++++++++++++++++++++++++++
> =C2=A0net/ceph/osd_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 4 +
> =C2=A03 files changed, 162 insertions(+)
> =C2=A0create mode 100644 net/ceph/osd_client-kunit.c
>=20
> diff --git a/net/ceph/Kconfig b/net/ceph/Kconfig
> index 7e2528cde4b94..6b78fe4a0f8a4 100644
> --- a/net/ceph/Kconfig
> +++ b/net/ceph/Kconfig
> @@ -45,3 +45,15 @@ config CEPH_LIB_USE_DNS_RESOLVER
> =C2=A0	=C2=A0 Documentation/networking/dns_resolver.rst
> =C2=A0
> =C2=A0	=C2=A0 If unsure, say N.
> +
> +config CEPH_LIB_KUNIT_TEST
> +	bool "KUnit tests for the Ceph core library" if
> !KUNIT_ALL_TESTS
> +	depends on CEPH_LIB && KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	=C2=A0 This builds KUnit coverage for selected Ceph core-library
> parser
> +	=C2=A0 and state-machine helpers. The tests exercise internal
> libceph
> +	=C2=A0 behavior with synthesized state and are intended for
> developer
> +	=C2=A0 validation rather than production systems.
> +
> +	=C2=A0 If unsure, say N.
> diff --git a/net/ceph/osd_client-kunit.c b/net/ceph/osd_client-
> kunit.c
> new file mode 100644
> index 0000000000000..713f24675f68f
> --- /dev/null
> +++ b/net/ceph/osd_client-kunit.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit coverage for net/ceph/osd_client.c internals.
> + *
> + * Included from osd_client.c so the test can drive the real static
> sparse-read
> + * parser and cursor-advance helper without exporting test-only
> symbols.
> + */
> +
> +#include <kunit/test.h>
> +
> +struct ceph_osd_sparse_read_test {
> +	struct ceph_osd osd;
> +	struct ceph_connection con;
> +	struct ceph_msg *msg;
> +	struct ceph_msg_data_cursor cursor;
> +	struct ceph_osd_request *req;
> +	struct page **pages;
> +	struct page *page;
> +};
> +
> +static int ceph_osd_sparse_read_test_init(struct kunit *test)
> +{
> +	struct ceph_osd_sparse_read_test *ctx;
> +
> +	ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
> +
> +	ctx->req =3D kunit_kzalloc(test, struct_size(ctx->req, r_ops,
> 1),
> +				 GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->req);
> +
> +	ctx->pages =3D kunit_kcalloc(test, 1, sizeof(*ctx->pages),
> GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->pages);
> +
> +	ctx->page =3D alloc_page(GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->page);
> +	ctx->pages[0] =3D ctx->page;
> +
> +	ctx->msg =3D ceph_msg_new2(CEPH_MSG_OSD_OPREPLY, 0, 1,
> GFP_KERNEL, true);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->msg);
> +
> +	osd_init(&ctx->osd);
> +	ctx->osd.o_sparse_op_idx =3D -1;
> +	ceph_init_sparse_read(&ctx->osd.o_sparse_read);
> +
> +	request_init(ctx->req);
> +	ctx->req->r_tid =3D 1;
> +	ctx->req->r_num_ops =3D 1;
> +	osd_req_op_extent_init(ctx->req, 0, CEPH_OSD_OP_SPARSE_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, PAGE_SIZE, 0, 0);
> +	KUNIT_ASSERT_EQ(test, ctx->req->r_ops[0].op,
> CEPH_OSD_OP_SPARSE_READ);
> +
> +	insert_request(&ctx->osd.o_requests, ctx->req);
> +
> +	ctx->msg->hdr.tid =3D cpu_to_le64(ctx->req->r_tid);
> +	ceph_msg_data_add_pages(ctx->msg, ctx->pages, PAGE_SIZE, 0,
> false);
> +	ceph_msg_data_cursor_init(&ctx->cursor, ctx->msg,
> PAGE_SIZE);
> +
> +	ctx->con.private =3D &ctx->osd;
> +	ctx->con.in_msg =3D ctx->msg;
> +
> +	test->priv =3D ctx;
> +	return 0;
> +}
> +
> +static void ceph_osd_sparse_read_test_exit(struct kunit *test)
> +{
> +	struct ceph_osd_sparse_read_test *ctx =3D test->priv;
> +
> +	if (!ctx)
> +		return;
> +
> +	if (ctx->req && !RB_EMPTY_NODE(&ctx->req->r_node))
> +		erase_request(&ctx->osd.o_requests, ctx->req);
> +	ceph_init_sparse_read(&ctx->osd.o_sparse_read);
> +	if (ctx->msg)
> +		ceph_msg_put(ctx->msg);
> +	if (ctx->page)
> +		__free_page(ctx->page);
> +}
> +
> +static int ceph_osd_sparse_read_feed_one_extent(struct kunit *test,
> +						u64 off, u64 len,
> u32 datalen)
> +{
> +	struct ceph_osd_sparse_read_test *ctx =3D test->priv;
> +	struct ceph_sparse_read *sr =3D &ctx->osd.o_sparse_read;
> +	char *buf =3D NULL;
> +	int ret;
> +
> +	ret =3D osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
> +	KUNIT_ASSERT_EQ(test, ret, (int)sizeof(sr->sr_count));
> +	KUNIT_ASSERT_PTR_EQ(test, buf, (char *)&sr->sr_count);
> +
> +	sr->sr_count =3D (__force u32)cpu_to_le32(1);
> +	ret =3D osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
> +	KUNIT_ASSERT_EQ(test, ret, (int)sizeof(*sr->sr_extent));
> +	KUNIT_ASSERT_NOT_NULL(test, sr->sr_extent);
> +	KUNIT_ASSERT_PTR_EQ(test, buf, (char *)sr->sr_extent);
> +
> +	sr->sr_extent[0].off =3D (__force u64)cpu_to_le64(off);
> +	sr->sr_extent[0].len =3D (__force u64)cpu_to_le64(len);
> +	ret =3D osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
> +	KUNIT_ASSERT_EQ(test, ret, (int)sizeof(sr->sr_datalen));
> +	KUNIT_ASSERT_PTR_EQ(test, buf, (char *)&sr->sr_datalen);
> +
> +	sr->sr_datalen =3D (__force u32)cpu_to_le32(datalen);
> +	return osd_sparse_read(&ctx->con, &ctx->cursor, &buf);
> +}
> +
> +static void ceph_osd_sparse_read_in_range_extent(struct kunit *test)
> +{
> +	struct ceph_osd_sparse_read_test *ctx =3D test->priv;
> +	struct ceph_sparse_read *sr =3D &ctx->osd.o_sparse_read;
> +	int ret;
> +
> +	ret =3D ceph_osd_sparse_read_feed_one_extent(test, 0, 16, 16);
> +
> +	KUNIT_EXPECT_EQ(test, ret, 16);
> +	KUNIT_EXPECT_EQ(test, sr->sr_pos, 16);
> +	KUNIT_EXPECT_EQ(test, ctx->cursor.sr_resid, 16);
> +	KUNIT_EXPECT_EQ(test, ctx->cursor.resid, PAGE_SIZE);
> +}
> +
> +static void ceph_osd_sparse_read_rejects_out_of_range_extent(struct
> kunit *test)
> +{
> +	int ret;
> +
> +	ret =3D ceph_osd_sparse_read_feed_one_extent(test, PAGE_SIZE +
> 16, 16, 16);
> +
> +	KUNIT_EXPECT_EQ(test, ret, -EREMOTEIO);
> +}
> +
> +static struct kunit_case ceph_osd_sparse_read_test_cases[] =3D {
> +	KUNIT_CASE(ceph_osd_sparse_read_in_range_extent),
> +	KUNIT_CASE(ceph_osd_sparse_read_rejects_out_of_range_extent)
> ,
> +	{}
> +};
> +
> +static struct kunit_suite ceph_osd_sparse_read_test_suite =3D {
> +	.name =3D "ceph_osd_sparse_read",
> +	.init =3D ceph_osd_sparse_read_test_init,
> +	.exit =3D ceph_osd_sparse_read_test_exit,
> +	.test_cases =3D ceph_osd_sparse_read_test_cases,
> +};
> +
> +kunit_test_suite(ceph_osd_sparse_read_test_suite);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 76ba3abdad9b1..b9ab9608ec88e 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -5951,3 +5951,7 @@ static const struct ceph_connection_operations
> osd_con_ops =3D {
> =C2=A0	.handle_auth_done =3D osd_handle_auth_done,
> =C2=A0	.handle_auth_bad_method =3D osd_handle_auth_bad_method,
> =C2=A0};
> +
> +#ifdef CONFIG_CEPH_LIB_KUNIT_TEST
> +#include "osd_client-kunit.c"
> +#endif

Usually, KUnit test requires .kunitconfig file and I don't see it.
Because, there are several ways to run Kunit tests: (1) python script,
(2) running kernel module.

The osd_client-kunit.c should contains:
MODULE_LICENSE()
MODULE_AUTHOR()
MODULE_DESCRIPTION()
MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

The tested function needs to be properly exported:

EXPORT_SYMBOL_IF_KUNIT(<function_name>);

Thanks,
Slava.
