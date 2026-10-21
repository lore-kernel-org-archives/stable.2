Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616730;
	b=UDplStV+Uv65kEh+xzByFIhhmgAIA8YDSA+qSPk7pbY9705SNv1bKQDhY7AXOH+tJN/g
	 QUIZyxHptN5dVVSIIWU7SjnNvU5LFLT8jPcx2YXfT3Jozvwpk/zpEE6JFEdp9dSGCNFRX
	 peDCB/4Vs3ehT67mJqi2A1u0YKFkmpURkWb3iAS3xJ0pee5+PWqXPfSPzAYLAMtIql4J/
	 0T6bAnJv+VR5fz8bxNJoP8VG01Sce+nEN/T1StBfrIcbCiaMXrBIBT6UrGeJFt4afRd5o
	 X+f5FEFCjP23vmk1C+fNj3huA6mSvkmGpg4pIrSPyc0YHuGa9w3088KY8GwldvjhDAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LT1JAf9kkvowqyH9kJf6IgurjXnQY9I3ALSM776jlXM=;
	b=PCXHdSCK9XyQD1zo4DTFuwLAtVTYqIVQmWaFdgXAxvrxPzVqiTxQ3V6BZ5uaPRFdxffP
	 rkQYwtRnMcEP6QkWssIPrR3mfDWVkZHPZKyfd/5ufeNRsmq7WZ2qBsZmp0Ttuz/68nhNC
	 BDh205pliGr7Sy4ZwQJOCZB7pEataFoXyE1TG2klplXOtdKZgSI24LndWAhdc0jw6UQoo
	 niMczyFjRmvFSHsDq99/VIceTIHgcFWh+rZfOgcdWEjNH7x4ZV7QjVEBXWYrXopBue+Fo
	 1hLANoTTe7wwqUdBQnSkW61Wiv4adF+RJW3CIrF4OyvUNmV66vsm6kfl6ncaWrUsprQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=0CRe+VKB;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49C606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C49C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=0CRe+VKB
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6798eb0d190so904447d50.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792616728; x=1793221528; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LT1JAf9kkvowqyH9kJf6IgurjXnQY9I3ALSM776jlXM=;
        b=0CRe+VKBniDCapVbK9i9be9jLGijRJhke917oUr2GAO20usiOZSS0G0Qe+fc1YIaUc
         IHDFAQcwNKH334Y8zXCRnO4771kZI6U5iXe1QhtiKlnP9bAwI09w6r3KRsYicXwV7gvF
         EQHR01vmMDbGIdb1rrp4xGkvsOE3h8E4pom9gJGKrwWcOPij7IHJILjFnOGAsMBpdOTo
         PsAARc/w0BgfPCir1lK/sEVwnGgCOfKzsxDjuqsbZt+d6PFL1jsmqbJEAh+7IHFrOHkg
         Pxh4S28voc25eB1swyWJxoE1fPTkhChZo3hQh9Bed3jgpc/5Gb9XyKmgytylVnL+JcUj
         ZFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616728; x=1793221528;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LT1JAf9kkvowqyH9kJf6IgurjXnQY9I3ALSM776jlXM=;
        b=WcKJ8xsUvqfCgn+mH3QfLC/hZfIvrSVIXPA3nyqyy1VQ0DIUS60kZbiwNWi/v3Hxxa
         COykyX0qWLLp6pR+7UYlxMKa8yWnNBRGz4BzOS3uAtF0qx1D3g10ws+XjnQNl9O9xmpb
         z73TrNiP1kxgchBenUksRKp8sAWM7/01Q7oNxFhKObT8tvHDLjKROtTmmejLtrZLLjmB
         7zrCHrmD8FmnVevjroJ2O3f+4sdopItj5A9k0g3CM7J5GJbaqZlwHH8gg6lN88WlDkaR
         5zpidhYPLZe1A5C80GXCNcbCbfuqTTYT3SPNJ0q+BSX3oZLR3HhYmzO4kQ02kJzq0Y4y
         3B3Q==
X-Forwarded-Encrypted: i=1; AKwUvByriNqn0rT0HESaV/D+GicoInjhKMffBeAmxQPvjUHqu0Ab6XvoZcMlq8ob1Tv9At6nVsVFIiQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0duwyi9kyGyDclx+yhkjVl8Mvttx2Y4yrA6lAr7yNAuVrP04I
	ZV7G77xBpcOwsTcw5SS26lmUsqjuxufIvYkpKWBqG5D3dQ6cCwQWHLEVsRNDYKloPEE=
X-Gm-Gg: AYBFou0N79trB+50R2Wv7oY/D4Wp00np1eS5UAZmIRQmfcQoWjZymE5UQDsD8QsN5vL
	8XhWzIz9YVxndl4tXJszE8eFhqQJzO/N86us9U0EoDS46EMOAQX5dkddGxkClW3JBLFkQEa+KoQ
	iCQUI21OE7d9O2OiT/YoHIz8cKRRE72T/eJEwjfTCF2ZzZazgY/XFnKWZVeUMgWGx99GhnwsJO+
	f5VXyndhw26fmweFU4XD2w2vJDf4tgV1vUWjR4Mytr4QtTNvMSQp5eTuXPLjTFedXDySi/+VVVJ
	R4gvuW6tUsEuc7NEWbBaXhbh+W0NcIiF+LEUAlxsgUnkR3cjc3YH0ReTsWSFEihDzULbTIFJbZc
	05Kgz1ShN/wE9g+mnNqlzcJaMV4KaPwdx1Exhoi3VJV6xqSP+RjK2+SsDGc85CqByjAF0t+oR7O
	tjZ0bqUYMQqyTfucG3URLwMsi43W1iHtu/jgg/GicUyWRGR0/+jtGjTBVhJy/v8I/+dthO7HwXI
	VEEW2HydawPAMX3oxpHN6tyn549QDOvI67wxK4W0Q9ZNwHTu+fEQohDiPA0O+qJ1tUWvVLcxDbi
	5QwDndKq5KtwgeGpM5/s+ircye78R/N8pYckrbCM/ejyzux3kdOdIQg2lqtYfHePUkRxuaNzSc5
	3OjuZsvDq
X-Received: by 2002:a05:690e:4553:20b0:675:6168:8be3 with SMTP id 956f58d0204a3-67a0e4bf2a0mr1281644d50.24.1792616728244;
        Wed, 21 Oct 2026 14:05:28 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:de6:d01d:526b:32a4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e4e5f3esm1621957d50.12.2026.10.21.14.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:05:26 -0700 (PDT)
Message-ID: <dc187921249a3f6716b829624853e64c10321cd1.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: preserve FinderInfo when listing extended
 attributes
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 21 Oct 2026 14:05:24 -0700
In-Reply-To: <20261021174534.482192-1-hengyul@cs.unc.edu>
References: <20261021174534.482192-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 13:45 -0400, Hengyu Liang wrote:
> Commit aef507847129 ("hfsplus: fix generic/062 xfstests failure")
> made
> hfsplus_listxattr() return zero when the inode has no records in the
> attributes B-tree.
>=20
> However, osx.com.apple.FinderInfo is stored in the catalog record,
> and
> hfsplus_listxattr() has already added it to the result at that point.
> Setting the result to zero drops it. As of now, a file whose only
> extended attribute is FinderInfo gets an empty list on a volume with
> an attributes B-tree, which mkfs.hfsplus creates by default.
> getxattr()
> still returns the value.
>=20
> The issue can be reproduced with:
>=20
> =C2=A0=C2=A0=C2=A0 truncate -s 64M hfs.img
> =C2=A0=C2=A0=C2=A0 mkfs.hfsplus hfs.img
> =C2=A0=C2=A0=C2=A0 mount -o loop hfs.img /mnt
> =C2=A0=C2=A0=C2=A0 touch /mnt/file
> =C2=A0=C2=A0=C2=A0 v=3D0x54455854$(printf %056d 0)
> =C2=A0=C2=A0=C2=A0 setfattr -n osx.com.apple.FinderInfo -v $v /mnt/file
> =C2=A0=C2=A0=C2=A0 getfattr -m - /mnt/file
>=20
> Without this patch, getfattr prints nothing. With this patch, it
> lists
> the FinderInfo entry.
>=20
> This patch keeps the result of hfsplus_listxattr_finder_info() when
> no
> attributes B-tree records are found, as is already done when the
> volume has no attributes B-tree. A file without extended attributes
> still gets an empty list.
>=20
> Fixes: aef507847129 ("hfsplus: fix generic/062 xfstests failure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Tested in KVM with KASAN on a804c5742bff, without and with this
> patch:
> - The commands above, and a C test of listxattr() sizes and buffer
> =C2=A0 lengths: a file with only FinderInfo gives 0 without the patch and
> =C2=A0 25 with it; a file without extended attributes gives 0 on both.
> - generic/062: 10/10 passed on both kernels.
> - Full fstests (805 generic tests): 186 passed, 11 failed and 608 not
> =C2=A0 run on both kernels, with the same failing tests. fsck.hfsplus -fn
> =C2=A0 reported no new errors.
>=20
> With this patch, getfattr above prints "osx.com.apple.FinderInf". The
> last character is lost by a separate bug in copy_name(), which
> Maurycy
> Pawlowski-Wieronski's patch fixes:
> https://lore.kernel.org/all/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f3=
78c@maurycy.com/

Somehow, discussion went nowhere. I am still waiting answers on my
questions. It will be great if you could revive the discussion or to
resend the patch addressing my comments.

>=20
> =C2=A0fs/hfsplus/xattr.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 71364e093fa7..c74c81966f12 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -838,7 +838,6 @@ ssize_t hfsplus_listxattr(struct dentry *dentry,
> char *buffer, size_t size)
> =C2=A0	err =3D hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL,
> &fd);
> =C2=A0	if (err) {
> =C2=A0		if (err =3D=3D -ENOENT || err =3D=3D -ENODATA) {
> -			res =3D 0;
> =C2=A0			goto end_listxattr;
> =C2=A0		} else {
> =C2=A0			res =3D err;

I think the fix makes sense. Maybe, we need to slightly rework the code
here:

err =3D hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
if (err) {
    if (err !=3D -ENOENT && err !=3D -ENODATA)
        res =3D err;
    goto end_listxattr;
}

What do you think?

Thanks,
Slava.

>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
