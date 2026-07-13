Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33B376481
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981097; cv=none; b=dIEA9NvG/qk3PKFRgaMcpld36T5XgXPO3jUdTZVD9nups8+UVZx+bT/0bRCy0i93ALy4ZFtJiJSpaLDYFql5B2yLRkFdjA7B8JdBdARSP5XCdWSVsgeiwR9QYzgIax+HDW0pyYQ5TSHsmc33y/yeLMAtG18oKLPGWx2ivg/8bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981097; c=relaxed/simple;
	bh=oeI3Kt/oLN83aiTdZRHAV7sAwB0A30e6bwrN7cjSOrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZZ+dS370UmLFMSkswkgRYB2bUB66xQ+HZPDfi2psYcUHzwkjSIA75n5SM6nfzXvEqIbUvcKGeX2YCxh8TTtK4qUSoLskJMo3VMT52TZQYhf/sThAS2ucTmRZBQe1yMHjKzixabjikU+i1nPHvqEzOLY2VV5MWRbzwI98hwX50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=N9Qz1kWR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="N9Qz1kWR"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e70159a27so3977167b3.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783981095; x=1784585895; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pqaK3Z8YRCEFnaHsTzpcKOTWIVBfZiTGCGeSlpmO3nI=;
        b=N9Qz1kWRJqMNHM69hE1pd3tGzkqAbu14cXaicuNIODF1ULMmDiN0ahmavyW2hTBkUi
         zAoCqsZ+KA986UVLIve5sSJQiwVR7jOvXA6YqV73yKt/TkOE383tRfzmHhgzssWPBguE
         z4TcN5aZWZVs5NTlSTFWtW93oBbm4gzJR5WiTQDH9ZzVkd6H0wjq4/Dvg0Vzblzrq6b8
         IcpznlbGh3Whniygtd11KMBsx4ywabMBhd5Hl65HDv+j52wxTaCxQzfm5b3JHIbnMF/g
         YB1l78aP83sNLwHw8BOetC6BbNOA17KZexgHahn5uZsgx1WodSbKHlZPx6OUGHMXSLit
         IzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981095; x=1784585895;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pqaK3Z8YRCEFnaHsTzpcKOTWIVBfZiTGCGeSlpmO3nI=;
        b=JbCYxBNHHwAQAdJhn5Z2jsQ0rC696K4joTYCdJe9IWRG4qv+sZOMBauSvmDlQ00qPx
         E8ZkWRsVBrLfZkXRIdziMq29ZlBQvuabr/FWb8t8WB8yZ0TztM8G9Gkat4CwXGajSWBz
         5QkjOF/m0USCWD99CVg57GF9JK4gI8pJnbfx4ikfzfLev/ICowYsH93hP4fvi6a0fnJy
         rx2Th1nZmLYoVHwwc9BnDYihSe2j84cG8AGln9Zn8+5iVbZM0KXRKXBYltLGZW6g9T+6
         CMG1FfoNoH+vdfjQDQV23KHlV+e5YBO2Jj+XBnvP6gNT+PEjiMm8pj/+s62XE1GSJfoq
         qp6A==
X-Forwarded-Encrypted: i=1; AHgh+RpZ1iB4kvymJdXmSUE+9c89GB7ymUlHv8q8tJGVYgrga2UDQ6toVy65Fv5/GTayYryjSaAdiHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fWw3QPFUP3fuBtknxO/EwueFQxkDRtH6LI/AEjk0xVs7L3az
	8U5f+KcL4li8pFjvAdSj5haXF0jT0IOpQ9tpQfyTZUR5Um16XXTEpfxCdHiAIs8PX60=
X-Gm-Gg: AfdE7clFxkA5//6CaIUCnXiPPh3i92rfUhQn1j2eUEaSjeActFXVwdx7VGaXopR1gQo
	2SAaNPoue2RnZsaJpq8Rp0dBO+13jr/l7Mf0g1dwK86RR6ZKQVy5m6xY8t3u1se7jV/HprBD7uG
	xppPxWgONXF69BAohxBDX01tBvTGT7tn6APyM7WKZJPRNkSxaCcnsImhxK+ff6M5y8W+SAQ2bBh
	lY8OuEMJoN4EBBtGkr04E0iK3RXeMaJADmPNTigzNiVxZkpgJ5bedOZDMST/KFDkIXqMl//2lnO
	RNy4+Ntzc7BXbiASQPhoKKfRaJRDYRa0Fqj+Vu9YSPpucZ0y4Qbafs6z/YSZUe0yk82BLKhvVHV
	FBnRWvq3ODJ2Vw3qSD3JAJyYTg1H5eHaWhtIamduoOopcfXYutc56ttGmaLrT8IRSL12L22aV/i
	QZff87zIzur25f5IjzmPzk16a91WIuA40Y+L0jnVH30NmkF/5zy5wMnnesCzy9+kGtcxTz9LAU5
	RjMqN1gWQvjXCZfHohvYMrzWZruETl1qoU3u8gp773pV+nseoAvM4oorTiyZ+gw7RR+H8e0CzeI
	+Pxi2vzmB/R2OiNR
X-Received: by 2002:a05:690c:6982:b0:80c:85b6:7651 with SMTP id 00721157ae682-81e902e2eaamr71357287b3.70.1783981095063;
        Mon, 13 Jul 2026 15:18:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e472:ff2d:20b0:742d? ([2600:1700:6476:1430:e472:ff2d:20b0:742d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c23939fsm126683337b3.46.2026.07.13.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:18:14 -0700 (PDT)
Message-ID: <39b2049e2143e72d8b22e3db39a53a4ac1fd88c0.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: bound copied dentry name length in NFS export
 get_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 13 Jul 2026 15:18:13 -0700
In-Reply-To: <20260711150706.2915970-1-michael.bommarito@gmail.com>
References: <20260711150706.2915970-1-michael.bommarito@gmail.com>
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

On Sat, 2026-07-11 at 11:07 -0400, Michael Bommarito wrote:
> ceph_get_name() copies the MDS-supplied name into the caller's
> NAME_MAX-sized buffer with memcpy(name, rinfo->dname, rinfo-
> >dname_len)
> and then writes name[rinfo->dname_len] =3D 0, without checking
> dname_len
> against NAME_MAX. A malicious or buggy MDS that returns a LOOKUPNAME
> reply
> with dname_len > NAME_MAX overflows the buffer. __get_snap_name()
> copies
> rde->name / rde->name_len the same unchecked way.
>=20
> Impact: a malicious or compromised Ceph MDS overflows the NAME_MAX
> name
> buffer in a client's NFS-export get_name path, a slab out-of-bounds
> write
> reported by KASAN. Reachable when a CephFS mount is re-exported over
> NFS.
>=20
> Add ceph_export_copy_name(), which rejects lengths above NAME_MAX
> with
> -ENAMETOOLONG before the copy, and use it in both ceph_get_name() and
> __get_snap_name().
>=20
> Fixes: 19913b4eac4a ("ceph: add get_name() NFS export callback")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> =C2=A0fs/ceph/export.c | 26 +++++++++++++++++---------
> =C2=A01 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index b2f2af1046791..debb9634b9e3d 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -442,6 +442,16 @@ static struct dentry *ceph_fh_to_parent(struct
> super_block *sb,
> =C2=A0	return dentry;
> =C2=A0}
> =C2=A0
> +static int ceph_export_copy_name(char *name, const char *src, u32
> len)
> +{
> +	if (len > NAME_MAX)
> +		return -ENAMETOOLONG;
> +
> +	memcpy(name, src, len);
> +	name[len] =3D '\0';
> +	return 0;
> +}
> +
> =C2=A0static int __get_snap_name(struct dentry *parent, char *name,
> =C2=A0			=C2=A0=C2=A0 struct dentry *child)
> =C2=A0{
> @@ -513,9 +523,8 @@ static int __get_snap_name(struct dentry *parent,
> char *name,
> =C2=A0			BUG_ON(!rde->inode.in);
> =C2=A0			if (ceph_snap(inode) =3D=3D
> =C2=A0			=C2=A0=C2=A0=C2=A0 le64_to_cpu(rde->inode.in->snapid)) {
> -				memcpy(name, rde->name, rde-
> >name_len);
> -				name[rde->name_len] =3D '\0';
> -				err =3D 0;
> +				err =3D ceph_export_copy_name(name,
> rde->name,
> +							=C2=A0=C2=A0=C2=A0 rde-
> >name_len);
> =C2=A0				goto out;
> =C2=A0			}
> =C2=A0		}
> @@ -580,8 +589,8 @@ static int ceph_get_name(struct dentry *parent,
> char *name,
> =C2=A0
> =C2=A0	rinfo =3D &req->r_reply_info;
> =C2=A0	if (!IS_ENCRYPTED(dir)) {
> -		memcpy(name, rinfo->dname, rinfo->dname_len);
> -		name[rinfo->dname_len] =3D 0;
> +		err =3D ceph_export_copy_name(name, rinfo->dname,
> +					=C2=A0=C2=A0=C2=A0 rinfo->dname_len);
> =C2=A0	} else {
> =C2=A0		struct fscrypt_str oname =3D FSTR_INIT(NULL, 0);
> =C2=A0		struct ceph_fname fname =3D { .dir	=3D dir,
> @@ -595,10 +604,9 @@ static int ceph_get_name(struct dentry *parent,
> char *name,
> =C2=A0			goto out;
> =C2=A0
> =C2=A0		err =3D ceph_fname_to_usr(&fname, NULL, &oname, NULL);
> -		if (!err) {
> -			memcpy(name, oname.name, oname.len);
> -			name[oname.len] =3D 0;
> -		}
> +		if (!err)
> +			err =3D ceph_export_copy_name(name,
> oname.name,
> +						=C2=A0=C2=A0=C2=A0 oname.len);
> =C2=A0		ceph_fname_free_buffer(dir, &oname);
> =C2=A0	}
> =C2=A0out:

Looks good from my point of view.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
