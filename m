Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B1451044
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834108; cv=none; b=S4dSqJWESZZdF9QoYbb0JPqoXrD9czfbas257NBN6WvVP2s8XGYC4ugq1HH4SQ03HkfLwQkoL5Nc5huIV7bkkiXWQX+yz0Gd5XVFHPoFakNi0OqqxrmWpMKkhFQlFld67nETKhvV2oZfS6uCjrRe/DX8zJTRVn7A6+cCotImZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834108; c=relaxed/simple;
	bh=Vb1CCUoo8ZAPNZnywEnukJbTq/+nRfz4pbzLxTU577A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=boDQIRipaSJfgYL90H+o94mpjOINKsxZaqBCBd+JYsl1MXarX7KOxvas5Y14Gg5glMKENjcx4q0OCPRxZp/msh4YFML3jfQV04q3S/Jt9NHs2bS3KFRhwcHT8I4zpfJGn8IEbffQRZbdtyRTcssPijr4T77adNl4cRGZaPalRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=CyvSW2uC; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="CyvSW2uC"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7fe36f1be74so54382517b3.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782834105; x=1783438905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1nC5ZFgwdx+CyplTR7dZSuu+BpaY20kDn4ud+dMIlNI=;
        b=CyvSW2uC3CFljgbzp4KozRmDftYSe6u6bfkZ13AadS1XKTEvNSRq1YwcuboBRkH6a2
         Xm1nF3BKPH53ZVNe/CZZ/FYPJZF0WYuUvUbTAyMbKYyyfVYAm4rMFiAxUUi+VELLK2s8
         POpR87SF5jbB3aEJkUno/EIlGRG60AEohCgELfgsKN1ZCOI14+Wpd/MJv+A8uscA27Hc
         rWoJQaIbV7F90O0355jq8roL7mi7mG9Nr/Ph5rQayYWm2YuFVNHLSgJ8GOL8+RDz4bxj
         JFvsygXg4X5vFlaXru1UfGNc0oIbQQp7Fncdc5RdE6PRmuccfIoAurqEl7ZN3BXL4CSH
         Lmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834105; x=1783438905;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nC5ZFgwdx+CyplTR7dZSuu+BpaY20kDn4ud+dMIlNI=;
        b=hLgJZuyv3aFGr++MIl4xE/axx+lc+cQxJqnYl3J+xRBp4D08TPREtwh7L1yoaaMVr8
         cCgGTvqYj2BWrsGBOV9MgeaLSPA/AaDcM02TvxlhT8SYArjWzvkYbxRiGNrOg/IZtFk2
         RTHgVQKPdPqkv/JHRE0sBOJxEvVRrNE4QNtsGPQWURPpdcRj3cvK03bQaEt1NLA4vqtf
         MmbdLQ6y2NRm525mz1HWIUubZ1/oq5Eayf/kg5UgTk2ZOE2sGT7tur9OAh7O5VHS9Kzl
         3bamvJgGVU0Z+8mmCfN1KyUoV4Y3wtAci2zPzPWnpD1HjgUQqiXo1nOrZctQMwLudnre
         X7TA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0+91/2LxbL83HBRrdxvZW1PXDcRXgBCsM8/qrDz5PFBDK2YQJPFoCFtKAYxDRynEg56GtHCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrI/EG3QfL7vS7xvWCbkPQAGdNDJC0KP5dYaMydy/5FgmSnPqM
	mzQv1kaOjq2q1xapplcgG4Z0566NJlxWVAs0OIQOGNl3KP213IQsg+obFh2yQFw3AAQ=
X-Gm-Gg: AfdE7ckkehQHGeihKifs6f5u6b99f3AAe5GYcbfKxZKF9hJkhSsRbXIgH9nLS8oi56f
	dB8c8K2E8LWQe/PD3gw7UbV7Xuzv8vp1Q5T5viuh0+t3IdP42uYkGHMI25ecOv3JIYBFDGnD9aU
	yFe0ZquzpyqIiDucrwSUJrKxDyzVAgOvSUe29IFOaYNj5xP/RDPOj6gxUQbiCjHaF+y784PX7sC
	6y9VI3pOupA1OMCZkKsPeWGLyo8gixBi7lC4Yoq5Gn9Kn5djI2QXr0XPavzdP86MFHIsXMlSdxz
	c72dfj6RIOigBDKLlsy8YhlTkjDFa/g141Kdt+kl2g8/WEoFeTGtgE/FSPIYAYh/4ktGuaeSO4I
	F34wyGhLxJgu+ha1i8t4DqT3z+n0Sb/GmocHbC+i8zJG0vCEnwEGw+vhz/o5kLvIvbymncQ8cwJ
	+swiq0jMEakEjatDh6NtpgzCCtaJ9CDHC357Lyiugn37YI+Q1uo11bFKtJUDQLWaHyAeZXIOhTj
	cDBp0XgGs38jfeZFviMdaAIca7/DgcK4AmFrF2itncW1csaXx2XIbehh014ijODXV5iLJy2xej9
	uBXgHpo=
X-Received: by 2002:a05:690c:6c07:b0:80b:fb24:4571 with SMTP id 00721157ae682-810d8ee5661mr46231837b3.28.1782834105323;
        Tue, 30 Jun 2026 08:41:45 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e728a009sm12907937b3.5.2026.06.30.08.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:41:44 -0700 (PDT)
Message-ID: <134825f322b5e1833350ce9a54d7d2e5b450a9df.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: fix refcount leak in ceph_readdir()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: WenTao Liang <vulab@iscas.ac.cn>, idryomov@gmail.com, amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 30 Jun 2026 08:41:41 -0700
In-Reply-To: <20260611144007.88851-1-vulab@iscas.ac.cn>
References: <20260611144007.88851-1-vulab@iscas.ac.cn>
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

On Thu, 2026-06-11 at 22:40 +0800, WenTao Liang wrote:
> The ceph_readdir() function allocates a ceph_mds_request via
> ceph_mdsc_create_request() and stores it in dfi->last_readdir. In
> the directory entry processing loop, if the entry's offset is less
> than ctx->pos or if the inode pointer is unexpectedly NULL, the
> function returns -EIO without releasing the reference held by
> dfi->last_readdir, causing a refcount leak.
>=20
> Fix this by adding ceph_mdsc_put_request(dfi->last_readdir) before
> returning on these error paths. Also set dfi->last_readdir to NULL
> for safety, matching the cleanup done at the normal exit.
>=20
> Cc: stable@vger.kernel.org
> Fixes: af9ffa6df7e3 ("ceph: add support to readdir for encrypted
> names")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0fs/ceph/dir.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 27ce9e55e947..ef9e92e362d3 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -546,11 +546,16 @@ static int ceph_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0			pr_warn_client(cl,
> =C2=A0				"%p %llx.%llx rde->offset 0x%llx
> ctx->pos 0x%llx\n",
> =C2=A0				inode, ceph_vinop(inode), rde-
> >offset, ctx->pos);
> +			ceph_mdsc_put_request(dfi->last_readdir);
> +			dfi->last_readdir =3D NULL;
> =C2=A0			return -EIO;
> =C2=A0		}
> =C2=A0
> -		if (WARN_ON_ONCE(!rde->inode.in))
> +		if (WARN_ON_ONCE(!rde->inode.in)) {
> +			ceph_mdsc_put_request(dfi->last_readdir);
> +			dfi->last_readdir =3D NULL;
> =C2=A0			return -EIO;
> +		}
> =C2=A0
> =C2=A0		ctx->pos =3D rde->offset;
> =C2=A0		doutc(cl, "%p %llx.%llx (%d/%d) -> %llx '%.*s'
> %p\n", inode,

Makes sense to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
