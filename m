Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442891;
	b=B/aoePx2R1cPRZe4J1Kd6WB36MBQyihu+bEDXud9XG/IaU5qMwZI9z8vIVvL6K08bBiJ
	 ZO1r9dlRdRvdjsn7RmlZgw63G0ifwclqCHRmH/lk5Rs12p+2ApZ03kSNoTNUlCq9bHfSq
	 vxII76uwdwptHRW6gnjIgmE8ZxR3SQka4XxcdSEW3xFhFoKbgqQn0APBotso3xGWzUPhs
	 3FkOgVvSIuJOw6o989MvPPwXGay3DZJsgwn0YFG6WQDiH/Tf2oAjVAs1V8NicwJ3PQ8dV
	 VC98cC5VtAmqMRk+vB1Dv9rZhMYbxP1plMpY65nOvIEfv6l6Tc5YmOhA6srtFyh8V4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Uz1t2WKqlXJVIyc0jqpnA6TrFMwUBuQ3w8Lin5TW0wo=;
	b=XfAo0XUIije/GJuA8n4IKbOXApCtxv40pbC5OZjUQb7GNNyYrCeKz32DhRlQ9/rJxxDC
	 z7STpIs59osga75C9C2ldsyfbgG4oHe9UWn+7f45wdm7YNDsPaIPWnigHrCIH0aqHtrHh
	 tp+M5q9A84oxYDtW5OZ1g9A6CAkyFILq07C+Y7rDgbEamGbuoYBjX0qF55Hk6hK9ktcSi
	 5CZMP1dEm/8lQQZj0vsFduVpp44gwMOY/kZob/ybmcI3IETQ0lyCmhryrd3j4lZV0Rs31
	 QKfZn1hIy/vRIi31zz+rF7ijgg3szXrIu3/sJVZq4/DRLtXB3gC72BFvciGBBlk2u1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=o1duoT41;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5D606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F5D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=o1duoT41
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so29237145e9.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795442889; x=1796047689; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Uz1t2WKqlXJVIyc0jqpnA6TrFMwUBuQ3w8Lin5TW0wo=;
        b=o1duoT410yfYPOkeOEqglCp3ucRjy9hZ52w3OD/hNUBkzgp8+marZhEP9j2b9DSsKj
         rvOlrGrueumhV3qIVTe5RlKFFtSIlZx2CsoCJzzjIBoG7aQ6K9ckODNMmnM3CqWt/swZ
         HI0sYk1bTW6+xdK0aGcFvkAbtCYUPkyU6wy4fWN88qieSUneMUodWPbyRMiN9uEHWQuc
         pt1G6pPI6l9hZSZe3Y9ulmQzEvNpjgGvOSGZU8OS08J1C5wukblXL4yFduVFZOwPcofk
         QvWoOCyZq1RMKWUQiak2+o6FMkhizRkFnRTKSM/m8uFrNG0VOG3qeuN9myw6wFupglGA
         KNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442889; x=1796047689;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uz1t2WKqlXJVIyc0jqpnA6TrFMwUBuQ3w8Lin5TW0wo=;
        b=UYLGaE5mRG192XGk+Sw2lCu3RszJ07W1F3BAGuya/BOqFCsxKwHW5GdQYP9HHVS5th
         f5B79zTVgUu4VphGIBtGZJpXqo5RaGK8NLAc06+4w/VlItrK53nKXECmQ2Ze1pj5wmVG
         3e8SB4qcVrGjJKRh/FSBLv3hPTkM34sECGnfksT9v1QcrbfI6WW66v2AkLmST9JFYxWM
         2wtnZ5rvXeKLFCXe0SBuI2iHZjzYf3xLlxFxDpiZeRTX3649yS9Dm+j3kh2tmcU/TRSH
         BdYANs/kDJK3hBy0DDnpeLURQTh/WvhPa53uMuV/HQDI6Ica+2bH7TGfRCfsQpikB+Ez
         K5Dw==
X-Forwarded-Encrypted: i=1; AL+hErGCjNkdupPoR1AyD45helSxu2T3dB4PU615TNl0dxeZZrhoYpXc6yZ+KCqCIPox+lyWhjEnUHo=@vger.kernel.org
X-Gm-Message-State: APuU4Z85TXuLRWFAOLHeq8rK25yLWxyT4PxFuyNU+UsyKkKlwO0rFlsn
	/aU8QXJQrDYbtSOtNBVm0Uedog/MR1c3EdL18JkzvpTJV5MS2QGljIpTr+THhPHh2tMS
X-Gm-Gg: AZFdTZdaqVVExs7SXar+RuADVrAYtUbdrljpGfzw80jLJucbR5iib8L5p9cBptqt0+o
	Dn/7nFGg8RrjCUjoogE0fdMMaeK6MlbMcIs5A3k2MNrfgiJ+ILXH3CsU/jMFu+TCfpnWk0qjQ7Q
	mfakZMxITlWDXqEEhHj55NRfUnxoQKuigw1uPT0jwH0/566jUQhDKuQcPruq2q6g7uzkDsYZWgI
	dWqorR+u60/kru7ee7Icp2PZAdbit/1nV+dEqoSwD9ReXV4Uj5GTSlbL5CZW57FUvpI8kZg5pp4
	YrTODy2KAFnwOBSP0lnZW4waxL9WE+Z6T2fHgTT82hiuT0LjV3rkpNMTeMVus6Nh1Ow63Xnmj1n
	/fxJPZz2GfzxdB/erBmUtE3VOrg0BPHr/5kHXsnZbGlHBWBa47DFftHDOvKP0jW+qk3Mjm97mPY
	XUHE55RRuVXF/YwmB0vJgkYqomBCApeW246Nw164GofivgAk7v2tt1FV+fU7+BYNhfDJ1N0KxvR
	TXwZshau3ZZSyL4uCsExBeFPWpSAjyUi9mby7b3s5DSg/QOvCZz/Q7y7FFpCb7dprqQ4qcKhphl
	IIrBRnUuG12DiXG6V6HwCxrCiPtYxuiC0kufEJlbWBWtiG64nmikdQRwCwUizRVDIEPu5t4jKE5
	D6gfc4MzQecpazFVV5A69u3RFR7dIyzi+j9slhe6kbSu03y8fjN8=
X-Received: by 2002:a05:600c:3e1a:b0:4bb:6814:7391 with SMTP id 5b1f17b1804b1-4bb8881921cmr230462625e9.25.1795442888314;
        Mon, 23 Nov 2026 06:08:08 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:799:2965:d32:cc64? (p200300cf572c2800079929650d32cc64.dip0.t-ipconnect.de. [2003:cf:572c:2800:799:2965:d32:cc64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm659142555e9.4.2026.11.23.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:08:07 -0800 (PST)
Message-ID: <9de7d49b52769206709d87749085cc453aabf104.camel@amutable.com>
Subject: Re: [PATCH] xattr: enforce the name and size limits for in-kernel
 callers
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Chris Mason <mason@kernel.org>, 
 Christoph Hellwig	 <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>, Carlos
 Maiolino <cem@kernel.org>, 	linux-fsdevel@vger.kernel.org,
 linux-unionfs@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 23 Nov 2026 15:08:06 +0100
In-Reply-To: <20261123113513.1910906-1-amir73il@gmail.com>
References: <20261123113513.1910906-1-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 12:35 +0100, Amir Goldstein wrote:
> The xattr system calls refuse a name longer than XATTR_NAME_MAX and a
> value larger than XATTR_SIZE_MAX, but the VFS helpers do not. An
> in-kernel caller may pass a name or a size that it got from another
> filesystem, such as overlayfs copy up from a lower layer.
>=20
> Check both limits before calling the xattr handler of the filesystem,
> and fail with the errors that the system calls return for them.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> =C2=A0fs/xattr.c | 31 ++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 0705801a62cc5..824e8349e8c10 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -178,6 +178,18 @@ xattr_permission(const struct mnt_idmap *idmap,
> struct inode *inode,
> =C2=A0	return inode_permission(idmap, inode, mask);
> =C2=A0}
> =C2=A0
> +/*
> + * The xattr system calls refuse a name above XATTR_NAME_MAX and a
> value above
> + * XATTR_SIZE_MAX, but an in-kernel caller may pass a name or a size
> that it
> + * got from another filesystem, such as the lower layer of
> overlayfs.
> + */
> +static int xattr_check_name(const char *name)
> +{
> +	if (strnlen(name, XATTR_NAME_MAX + 1) > XATTR_NAME_MAX)
> +		return -ERANGE;
> +	return 0;
> +}
> +
> =C2=A0/*
> =C2=A0 * Look for any handler that deals with the specified namespace.
> =C2=A0 */
> @@ -209,10 +221,17 @@ __vfs_setxattr(const struct mnt_idmap *idmap,
> struct dentry *dentry,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size, int flags)
> =C2=A0{
> =C2=A0	const struct xattr_handler *handler;
> +	int error;
> =C2=A0
> =C2=A0	if (is_posix_acl_xattr(name))
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0
> +	error =3D xattr_check_name(name);
> +	if (error)
> +		return error;
> +	if (size > XATTR_SIZE_MAX)
> +		return -E2BIG;

Hi Amir,

> +
> =C2=A0	handler =3D xattr_resolve_name(inode, &name);
> =C2=A0	if (IS_ERR(handler))
> =C2=A0		return PTR_ERR(handler);
> @@ -416,6 +435,8 @@ vfs_getxattr_alloc(const struct mnt_idmap *idmap,
> struct dentry *dentry,

Don't we want to have xattr_check_name() in vfs_getxattr_alloc() too?

Kind regards,
Alex

> =C2=A0	error =3D handler->get(handler, dentry, inode, name, NULL, 0);
> =C2=A0	if (error < 0)
> =C2=A0		return error;
> +	if (error > XATTR_SIZE_MAX)
> +		return -E2BIG;
> =C2=A0
> =C2=A0	if (!value || (error > xattr_size)) {
> =C2=A0		value =3D krealloc(*xattr_value, error + 1, flags);
> @@ -434,16 +455,24 @@ __vfs_getxattr(struct dentry *dentry, struct
> inode *inode, const char *name,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *value, size_t size)
> =C2=A0{
> =C2=A0	const struct xattr_handler *handler;
> +	ssize_t ret;
> =C2=A0
> =C2=A0	if (is_posix_acl_xattr(name))
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0
> +	ret =3D xattr_check_name(name);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	handler =3D xattr_resolve_name(inode, &name);
> =C2=A0	if (IS_ERR(handler))
> =C2=A0		return PTR_ERR(handler);
> =C2=A0	if (!handler->get)
> =C2=A0		return -EOPNOTSUPP;
> -	return handler->get(handler, dentry, inode, name, value,
> size);
> +	ret =3D handler->get(handler, dentry, inode, name, value,
> size);
> +	if (ret > XATTR_SIZE_MAX)
> +		return -E2BIG;
> +	return ret;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(__vfs_getxattr);
> =C2=A0
