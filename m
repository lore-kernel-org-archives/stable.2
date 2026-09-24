Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874774BD0F1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286151; cv=none; b=KCfrpD/AQj0LiOjEJYwVcYXuO6jVMe1bx5yWaT7BiBJ77jJ2VlA4z0KKxz1I515kxwWvQl5niccrZnUmDOer2iG4Mmlne58FYYyAhE7xgmq624yHtnGvwyGyV8fUlMHp3yiVyl18Wgpu3v2MyRQ6G2ulupJin7/o0fIOzSc2V2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286151; c=relaxed/simple;
	bh=BHB+VOqRtxslGCBRJ4CCSTdUD6RmUvN+GLZLNLAE89M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obuB8KL6Oy4bgXvB5ABZO4DaXAHeOEJO39vgu7+vOCB8qn5Cxp8J5IRia15F9NB9MfUP4AQQ2hg0SXwAgYeTdGAJImVCdUPQEUut6+Y/zJbVktYeAkGWag+TEO2h6KilNBfOW+Aiv4t4tMjFj2nK1FStp3KxFQbFhsOBcDwXXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=HvHBcQu4; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="HvHBcQu4"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e5505aso2294627b3.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790286148; x=1790890948; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mmw5/2UpceFkGfvGYqJ0+zxqUAxMBH43eNw69LuBZyI=;
        b=HvHBcQu4E+8aaHLGkzRArCDXoDN6wbODgVYhxt01A9edHuPN9Eis3AacFiVZIjRZel
         nS8YzXXsRl3/Y++aL1NkS2EcMLj4ZsOrzT/riAhHns6PVWja1gbOHM6cfksPUdHEzHot
         oJvdS43R0ZiEJz0ECsE4LNQnkc4PhKHZCLYONs+WHBtxLXfH1zOugu4j3wwe9bY4uNGM
         IkQ3/A+0fQOjsXAaQCWDA01xkHJ0APxH/z0jTw5bNSZdsBFD4mVPFut/HWA25pTHYsBl
         MgyBvUo36wXsngIRBbBs1a0DOGAJb912lIAKlz1uiyuSahpxdt5dDk7e/KQvQscuiS5W
         /Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286148; x=1790890948;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mmw5/2UpceFkGfvGYqJ0+zxqUAxMBH43eNw69LuBZyI=;
        b=FFNQdl+hhQrNDv4BnohVcQIeLnUr5j0X18wl0bd1ADYsoEP9NetxVjZfTn9xIn5XHx
         6cMPtV3UYB2ye+wMC39o8hEpeq+Mhy1QS0BB90uJv3wu4vLXdlkO9JSUndhwvpTGguZB
         63mAZaLMeRrmH1TqSeSkWGmgnPQfwSwneM5asSqknC1eEt79jB+FKZW4IHdRvCfp7cA6
         0Ezvt1BrR03FwBk0V346NyEpk0BUdsfoZEL+SgRxBguSC0Oxu4ogEH21RexYIRKkYFvI
         Am/MsQrsTpeWqQltBRqH/Zt0qABKKlsd4hP3Mxeb4mGk0NIgDEu+mxRGl8ejOeYUE1t6
         WWag==
X-Forwarded-Encrypted: i=1; AKwUvBwUHzbxzXX0OtmQR2n0IeEFOFVnCIP8fWCGKJABwUyUtoeZQe1UxJeBn5qlYITTSAu/u5D1d4M=@vger.kernel.org
X-Gm-Message-State: AFuF++kVVadBElDYPcJ6k8JVPRMRgGvOjtGmXod8FdjzZ+1z9/Qky3Ey
	+l8HDq+XMSe3Xn8bu652lkGGMM+w70jqHrGSlZfCDr9+hF+3LVA6M1LN6N0OATKJeMo=
X-Gm-Gg: AYBFou25RZMarsQlbHPULQEriAdJQP4q5J9OLQW/hBU4bkpmPpYPXbMmy94AVuGr5P6
	0YzUjrGlF1zcgGn9+EB1HgrllfpywGR0UffoXx8nErPQuUEvh0+Eu0yBTZmbKOh3fGwrWfcxCCf
	pJDqjXNiPZ7bHkXhWnUOhRth78FvlIbKd+AZwXwWYx84b1YDFlxJLZfdESlQzWZI/aEhXx81txX
	UQG+HwEqNqIFkEgKQzcdDUhw9Y35805tdE4NmJ9yCkoeeN4UYf6p70FgG4+1VYZ/DwwTA79q+eA
	t2lTUsP5NEq8EUEbzBCZIn1rDb+meqaUWukSFYLAwpJUxG1elM6SP988C065N14PQObGC6or/YD
	1tQ1rhH1F+7RiWzYQXYolvTHrALP4zYpYWt2zhAS4VZ86SLCraU3Ukm9AfFRamnJCQqR9H0k3D3
	kI6Ucfk4/n6CMxhKmDTk5AUgMv8tEvrYB1ADKrlMw5XW5mWqVROupS6duPSTAjuy+R6Zp7bhUGe
	C4mpP9ndcNybkbtK+5vl5PPc6UEalhO0nN+uZ0mxx2HZNx+2nWR3sIw1ilvGzp6fhHJ3/EIUs0c
	CIzT8oTsWYKccBWv0bXtlUpxATjNL+7Wm9q32QvQfgwW2mBis7Nou9bCA7BR2rE1
X-Received: by 2002:a05:690c:6d84:b0:873:5bb2:6c03 with SMTP id 00721157ae682-8a64d8f6e29mr22693437b3.45.1790286148427;
        Thu, 24 Sep 2026 14:42:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:4935:3bd4:e0b7:fd95? ([2600:1700:6476:1430:4935:3bd4:e0b7:fd95])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86101e30fsm2064417b3.38.2026.09.24.14.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:42:27 -0700 (PDT)
Message-ID: <d83716d649bb32a5902edd53616aedcc742d36b5.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: validate inline xattr record size against
 entrylength
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hui Peng <benquike@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 24 Sep 2026 14:42:26 -0700
In-Reply-To: <20260924070757.2646279-1-benquike@gmail.com>
References: <20260924070757.2646279-1-benquike@gmail.com>
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

On Thu, 2026-09-24 at 07:07 +0000, Hui Peng wrote:
> In __hfsplus_getxattr(), record_length is read from the on-disk
> hfsplus_attr_inline_data header and only checked against
> HFSPLUS_MAX_INLINE_DATA_SIZE without verifying that fd.entrylength is
> large enough to hold the inline header and record_length bytes of
> raw_bytes. A corrupted attribute B-tree node where record_length
> exceeds
> fd.entrylength causes hfs_bnode_read() to read past the end of the B-
> tree
> record (and potentially across the bnode boundary).
>=20
> Validate fd.entrylength before reading xattr_record_type, length, and
> raw_bytes.
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted HFS+
> image
> containing an inline xattr record where record_length (100) exceeded
> fd.entrylength (4): on the unfixed kernel, __hfsplus_getxattr() read
> past
> the end of the B-tree record; whereas with this fix applied,
> __hfsplus_getxattr() rejects the malformed record with "invalid xattr
> record size" (-EIO).
>=20
> Fixes: 127e5f5ae51e ("hfsplus: rework functionality of getting,
> setting and deleting of extended attributes")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Drop the hidden_dir cleanup hunk (already covered by Deepanshu
> =C2=A0 Kartikey's patch series) and focus solely on the
> __hfsplus_getxattr()
> =C2=A0 entrylength validation, as requested by Viacheslav Dubeyko.
>=20
> =C2=A0fs/hfsplus/xattr.c | 15 ++++++++++++++-
> =C2=A01 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 21a1c196c71f..10aae766ea42 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -649,15 +649,28 @@ ssize_t __hfsplus_getxattr(struct inode *inode,
> const char *name,
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (fd.entrylength < sizeof(xattr_record_type)) {
> +		pr_err("invalid xattr record size\n");
> +		res =3D -EIO;
> +		goto out;
> +	}
> =C2=A0	hfs_bnode_read(fd.bnode, &xattr_record_type,
> =C2=A0			fd.entryoffset, sizeof(xattr_record_type));

We need to incorporate likewise checks in the hfs_bnode_read(). Frankly
speaking, I don't think that we cannot read __be32. But if we cannot,
then only hfs_bnode_read() knows about the failure.

> =C2=A0	record_type =3D be32_to_cpu(xattr_record_type);
> =C2=A0	if (record_type =3D=3D HFSPLUS_ATTR_INLINE_DATA) {
> +		if (fd.entrylength < offsetof(struct
> hfsplus_attr_inline_data,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raw_bytes)) {

The struct hfsplus_attr_inline_data defines maximum possible size of
buffer (HFSPLUS_MAX_INLINE_DATA_SIZE). But its doesn't mean that every
record is 3802 bytes in size. This check should fail always.

> +			pr_err("invalid xattr record size\n");
> +			res =3D -EIO;
> +			goto out;
> +		}
> =C2=A0		record_length =3D hfs_bnode_read_u16(fd.bnode,
> =C2=A0				fd.entryoffset +
> =C2=A0				offsetof(struct
> hfsplus_attr_inline_data,
> =C2=A0				length));
> -		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE) {
> +		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE ||
> +		=C2=A0=C2=A0=C2=A0 offsetof(struct hfsplus_attr_inline_data,
> raw_bytes) +
> +		=C2=A0=C2=A0=C2=A0 record_length > fd.entrylength) {

Frankly speaking, I don't follow this check. It looks pretty
complicated.

Thanks,
Slava.

> =C2=A0			pr_err("invalid xattr record size\n");
> =C2=A0			res =3D -EIO;
> =C2=A0			goto out;
