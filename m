Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795031377;
	b=bMC+xMDk2Z41lcz06U3oDMgGEFl3slrdz2Kj1uMyzIJXNbqTseZtnAHKorvKUokM+BUQ
	 zeia+sWIzlJ7BFkSe60315zQwpgzZi//lnvC5g0eFiky5TnD4U4NoBrrt9UV+tf1Fd09o
	 elD20NLSGg642MYTtb9a4+aqQlPmwQBeNujwFHzs5Tl5QWNfjzu4mMDgE5KPkWae3/G97
	 R1j5AAdO1PzoZ1wBKlnJojdhViJQ6GOSKHUuz7jR2Kp1jY5aXKNkLBv+yzeOQZvBt5mla
	 x16yvPI7jSNkWA371OJqLadize4XCj1mc/eYN3fdqKjaxFLCSz0bAkbKvJeECsb4qjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
	b=H/53zkQEZSnLxcTqPeJAHOMXn5kLD0RIt2UUhQUSj4rUkg9gtyddWxnIDYSUynOgBid8
	 BIs8lb7tpGuwFffHgUKQPeq12RBCKaTPdngOXWWAesdEBAj2ptkWDdiMlqzdCnHU0jgR5
	 monFcYgbl9gTlcC2fry/zRXTKCZkL2m1ul41MPb50VeUNHzwfwhhhBmeOHIJS3BZRrzJc
	 qFtjKfjI0uF/KWFAQuU0GJYy5oR6iKG/CS3yKE5Zm8NFYktvKYu5BYKxakHys3GmfjFm7
	 KTnfBf4xWkCYxVmdPcrHWKzTTqdcLlT7qkJLW1J+fEsbw4jX5J0h6UnmBNCmg2c/AdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbDnePoq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F6606A335
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 274F6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbDnePoq
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ed2f163a2fso402012e0c.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:49:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795031376; cv=none;
        d=google.com; s=arc-20260327;
        b=dV2ByeumUtpmk22SocO5evzPrDan0yMmyo/LHDH0thiGVxahZiJ1wX2xl95ldZqB2C
         B6RSubNAsWd3tvOJ7tuM1nqLnf2hF646yAL7EEPsF+8yfxAL+wQD+l0U4917lvIu63PX
         I8SZ/Cjwz0JvsxpGOsXBLCbBnZN1XTQlG0fUiuAFQtVysh1BbVNnxhjn91XUP6kQSfmm
         6wmXIJFDExbpngFBQPa0I4snJtrnL5+6ZyfRhsggyuBoBKwYTA85Ixw4JBcZgq1/5P35
         1u98TvEcfmtNNcs6vb6P7tBsKVcUWJFP539y4n2P37TPUibqiAqdTHYLcGkRn4CtuOCu
         F2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
        fh=lCIfAuJHG8EW9LvDnEEDhYofeXidV7SgEohgi0rvpJ8=;
        b=omboO2VEwmS/RR6A0l2Fy/bdsHFLJYkg2cS12F5UrZSrwNI6jenoiSe+kGBgs+1ibW
         VQO1gB8coKdKLtFjh0tgAGMTJXRDMfouGipCD31oJ0YNmyqI4lqxtg6qdBqEKEkijoWk
         MS4Z7txCjN/Zn1XY4wSoqiUmtad6z9LP+eev/GGm/WO0LWd4DsWIj+9pS/IvWBwcujGZ
         J1Ycq9O43CQdlZAHnSJ5ozUKV3Us4OWR9fyGZzbCZ3aMoWOxDoJTazOXHLbNYfZpMkIO
         ro9vgaXOV8YYdTeCrs5spa3A+RexkDDIJS0nTH6HuaCJ3i3IPJ7+wZB+6SOI6+eo2aVF
         L+iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031376; x=1795636176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
        b=XbDnePoq6DsByY3QSv8Yqd2N9+SZCm8SypoJX5QTgiR/wvTBm5x77uN/IQHuPqxsV1
         Tq3OdsaRncEDawaGopXT9MkConSZzJ7OTqmZno1fJLy2L1KFQ+czOqyy18eBvEWQDbK4
         q0Esz2XAfkSmB+wIGHhNBxr6Qk44tMfbiEbmO222Y19ZUiCRgH4fEsuTUWcGppBC0RPw
         l1xggxKFWgZ4mR8q7QVh+m+4cWKXj73rxPSOuysgwfwweXkhcg3/I5KgYo3Kot1ruaQr
         8Q7B0fLtz3y9ujiOIMA+QObcnkJcnuTzJlF4zLfSIBSElxpBRIyic/XxyKVARPpJ7Lb6
         5kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031376; x=1795636176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
        b=r0V5EWdN83k5UCIAktfF94xSn0VmxQnN5MPOCrMzFeJSUcwopb2jpDNy75dpMIHLqh
         EgdEVbe88pfSursjOt3IqfFgpn/SC6iMJl+UfCm6ztj8syS9HNE0x1KxGfr7zDaQ4/Dz
         c/7Ksq8zniXl2kIWI/DnPuNAr+jNp8WuGYzE3Z/vTarDoGChvl8BV5iZfgzyjetaq/SB
         TWQj/xM+KwPYWrSGJfrQKjc7rCHRjGOxKZ2LqgptOnrsh38IAbeQS1WjHxgspBPzojmx
         zv1lAzDgjQx02f2Log4Q9BHSoiGHbif974Wj0bWKQDVHzGKsWNurqu+SExuBd6STJq2s
         QnkA==
X-Gm-Message-State: APuU4Z/TdeNVJMOmXvN515gcYBht8ilmAuaHWO6Gkqsf7jqgbuKvebim
	dR22mnSjFixMX7fmG3/0CTECtJR6p7EDYptBZN6bQqlFITzHlqMxwOFAkcNl+7hDlwkUwaLSHo5
	KQ3JrH3U0KIP+porwQpQXz4IdYs01zJw=
X-Gm-Gg: AYBFou1FpiDn08DmhgAhIsl6Ztfy0h5gxQVwS+DuqMRLT137uE3o2i0nGt96F3Qvn7y
	Iv4vCeOwNdTqkrMWe3tj/2idsI9yhFeHVG4QItq9tdMUm6SQ+LviPIfsR5uoXGjQHf537+7wn29
	sp6mLY4aqFJhpskpfAqq49YHzJfm7afLKtBGFbg6PC8bAJeLUbMfxDqJ+dvO2x3+LwUdEtdUZM6
	eLT70dGJUXVGAWdC6BgQjpnDJAevQvIABFiz1TJt55+O7wLKaowpK3tKKOw88pVZEuWgl3Ipnyf
	p01H2LJbTX/e+da8c7f/6mYI1yp0KuWn+j9d/FNW/r2zhzliSaT94Ub8HmjGQRdxfgapM0QcRiW
	/uI5AiKgTnvtpdyJdyG9IlNvFvYEs3pNLNEETcjynlFnEWCvkfqRi9FXookrXgdMzZPoBViE=
X-Received: by 2002:a05:6122:2904:b0:5ea:c6c1:8dd4 with SMTP id
 71dfb90a1353d-5ee646c5cf3mr1948277e0c.5.1795031376028; Wed, 18 Nov 2026
 11:49:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <PR1P264MB1805408F7C4A11E6F4D2F6BE887B2@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <PR1P264MB1805408F7C4A11E6F4D2F6BE887B2@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 18 Nov 2026 20:49:23 +0100
X-Gm-Features: Aa3M54prgxEXH0QcaUK7iYZlymmO2L-4ErNwF_OHban9EuEDft3ZnhOlXfVpab8
Message-ID: <CAOi1vP9P71i62s+Lm8zRF+FK-qgaQaZu4YB34--oC5mPLpmj0g@mail.gmail.com>
Subject: Re: Request: backport libceph CEPH_CRYPTO_AES256KRB5 support to 6.18.y
To: =?UTF-8?Q?DESNO=C3=8BS_Jordan?= <jordan.desnoes@francetv.fr>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:07=E2=80=AFPM DESNO=C3=8BS Jordan
<jordan.desnoes@francetv.fr> wrote:
>
> Hi,
>
> I'd like to ask whether the following libceph series, merged in v7.0,
> could be considered for 6.18.y:
>
>   0ee8bccf7396 ("libceph: generalize ceph_x_encrypt_offset() and ceph_x_e=
ncrypt_buflen()")
>   6cec0b61aacc ("libceph: introduce ceph_crypto_key_prepare()")
>   b7cc142dbafe ("libceph: add support for CEPH_CRYPTO_AES256KRB5")
>   8356b4b1103b ("libceph: adapt ceph_x_challenge_blob hashing and msgr1 m=
essage signing")
>
> I'm aware this is a new feature rather than a fix. The reason for asking:
> a Ceph cluster can be configured to only accept aes256k cephx keys, and
> the 6.18 in-kernel client (rbd, CephFS) cannot authenticate against it
> at all. As 6.18 is an LTS kernel, users of such clusters are left with
> a userspace client or a downstream backport (Talos Linux carries one [1],
> and one is proposed for Flatcar Container Linux [2]).
>
> All newer stable trees already have the series. It does not cherry-pick
> cleanly onto 6.18.64: 6.18.y already has 821365487aa5 ("libceph: Fix
> potential out-of-bounds access in __ceph_x_decrypt()"), which landed in
> mainline after this series, so patches 1 and 3 conflict in
> __ceph_x_decrypt(). The resolution is trivial and gives the same code as
> mainline. The CRYPTO_KRB5 dependency is already in 6.18.
>
> I tested it on 6.18.58 against a Ceph 20.2.4 cluster restricted to
> aes256k: rbd and CephFS via ceph-csi, map/unmap, reboot, and 24h of
> I/O across ticket renewals.
>
> Ilya, would you be fine with this going to 6.18.y? If so, I'll send the
> backported series.

Hi Jordan,

It's fine with me -- like you saw, a backport to any kernel that has
CRYPTO_KRB5 dependency is going to be trivial.

Thanks,

                Ilya
