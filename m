Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F43246F4
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569597; cv=none; b=uqablvVaBbi/y82/Jo65ac3nnmsWwa8vI6NMojxHbn1Whpi2xl5UVAvtnMn72S5uav6jx+0NDbfyM4yMsEmYHpefL9bdPPd/LVNChJgxmP06T5w9RrRZcbLuhnFpEp2k7wVYvBQZI8J/qjkQ9i8f1pAo/Dv46sb1acJznbg29m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569597; c=relaxed/simple;
	bh=PO+CZFuw7AzFdnkylbVpMYHdrNqxaq4rVizh+SGjfTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9vKf8zvbBWlKmXHysnsoI5NKMxtPWBKFy7ys+WATXKuFYkgWAibypQ4ytRpuR0e4Pyjgv7asiJK5uWnXqdcpwkHfrUDrQZk5e0NA/uwJW8HoREX4eNaAfPF4F8l2ZsN4PzDvb18zf82zBg/yhBo8vJHPPoRZBVEQUktLrAk8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8jRwKQU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8jRwKQU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8fd3b729dso14375585ad.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788569595; x=1789174395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zjNoznvpAzRJV6AZniUkD2TZWS4lsVrBNwzt7oLX2kU=;
        b=e8jRwKQUasaho7Wl2ZMKIfkNMPVE7DynhVB0/mjbZhyl83Xd/ykREnUEQ4KQJxA7yr
         3AcEeRIEayqHYw4REavuQAFIt/A9F0vbPh0V3Zb3lAIqeru7qh5R9gcOSHA+6w3cAi6R
         4ppU5PDvnR2xNve9oxhnTDSMRe3bLdK60bM0ev1RB2+vEZw1kKyWGjcn/oPlqL3EBCj8
         6fqPHjF9tugoiKZK8ceqRZCVf1CGE1ZJABOs9f8hrmGffqRxz8mgn/09MsEx1xTqMGyi
         Ca7yAwj/ZaDG03UeZ0vx34kzz+fg6rLV/pwDeTdOLUs/e60jNP+TSZ9XNvjzaMNP09mW
         nPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788569595; x=1789174395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjNoznvpAzRJV6AZniUkD2TZWS4lsVrBNwzt7oLX2kU=;
        b=kggpYGSeJrkAojr4G/zzwIsMp5DS7aGMBEBFS/7OaIl8BbRZKdCgqxTpyRXb2p2Rm8
         cLCYPPHauTcV8GP7eU/gcZo7Jqu5agffx1DRqc5hTH4mAA1Bin/Zux4XoYW5ujptyaJh
         q9njWUXYgEh5czyu6gVMJi+Ek90bWzlNc6Y6o9NJW/tJHPJBl2CBuxruO/3ileO+83o3
         w6FscTsfeu09rF3Go/Nqfqys+l6OiqGaefUOrOfzkmVkKzEMFTP91QoH/U8C8BzI1ZUF
         qKgRqDb07zh+8E7czYiZ3lK8ck7yJe1eHHnUa3eAoS2CbeznnXiCkhfIJXdgK4SItBNJ
         Z81w==
X-Forwarded-Encrypted: i=1; AKwUvByN20leYFr7DqWLoOhTMaeiJsVu/49aq2G8hNse2UV4XBPBPkncxr637CZ3P/mc6A81GlBE7PM=@vger.kernel.org
X-Gm-Message-State: AFuF++kqR8kLyl6jJKGS8g5/L09UF/vOl8poTypeZlHzXPf2Za2ebW+t
	TnQ6Ebd0iWqzdzUE07zImnKZmkEV7M2UDu42cvOWgWqg2LoBuhLrqgEHLqd0xtJpDg==
X-Gm-Gg: AYBFou0I7FXB4KC5xBGby1BS+PePBZzXlBXQH77JHmPPmVVtF7B6uWAST79ABu5TChJ
	BAptGP+LJJd7DEuukFa/WM/DpXV/SjJfxFrOMYqUz99mVk1mLCUToIvrD+wPIe5msa+7I3q1qPu
	8NGY/sxg+My4DlpHpT2RuIk9aWpjEgx+W1kvAkaC3XWgG+qPlqyKutGk9MgKuinUvc+sunMYUNM
	2hV+MgA77DHk3ARvLAes7Wv8R+bawsLVB1jKuxfIn6f9yY+yIb6pUVy7HFiPRzE2Y8yNgSnqIB2
	Bh3cHDqtq/A9KP+hhJeNhuqj/kXSnyMOaWnBpG9DpmP81+Aw91ZHUKETQX2mxEDY9AP3bCoiklv
	9mLMGbEZp2j6810d3nAl/V0tx8NQ+vL7YkSqK93eCwA5najlPnC2akmbdFKLRxBa7TONOUieCAC
	5zuKgQsSb7D7wUAaN+eZbofNNxDwkr6hfcSJ6AtucCT5hMlV52Dz6lLGkm1TobGNtgqVPLE95/R
	hssqBXE2ZnEI+tW+ONJkg==
X-Received: by 2002:a17:902:d987:b0:2db:257c:9fd5 with SMTP id d9443c01a7336-2db257ca020mr59087085ad.16.1788569594266;
        Fri, 04 Sep 2026 17:53:14 -0700 (PDT)
Received: from google.com (51.86.127.34.bc.googleusercontent.com. [34.127.86.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae4b5bsm15704015ad.77.2026.09.04.17.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:53:13 -0700 (PDT)
Date: Sat, 5 Sep 2026 00:53:09 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array
 index
Message-ID: <aptn9eUDt6Q63gWF@google.com>
References: <20260904234401.2339633-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xz9YC2TuYFrKA6LN"
Content-Disposition: inline
In-Reply-To: <20260904234401.2339633-1-jthies@google.com>


--xz9YC2TuYFrKA6LN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:44:01PM +0000, Jameson Thies wrote:
> The UCSI displayport driver indexes the connector's port altmode array
> with the GET_CURRENT_CAM response after checking it is not 0xff. The
> port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
> returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
> not equal to 0xff, the kernel may crash with an array index OOB error.
>=20
> Update the UCSI displayport driver to verify the current cam is less
> than UCSI_MAX_ALTMODES before accessing the port altmode array.
>=20
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
> Changes in v2:
>  - removed 0xff alt mode assignement when GET_CURRENT_CAM returns an erro=
r.
>  - return -EINVAL when alt mode index above UCSI_MAX_ALTMODES is returned.
>=20
>  drivers/usb/typec/ucsi/displayport.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucs=
i/displayport.c
> index 7067f2561b84..572da7bbd29c 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -71,11 +71,14 @@ static int ucsi_displayport_enter(struct typec_altmod=
e *alt, u32 *vdo)
>  	if (ret < 0) {
>  		if (ucsi->version > 0x0100)
>  			goto err_unlock;
> -		cur =3D 0xff;
>  	}
> =20
>  	if (cur !=3D 0xff) {
> -		ret =3D dp->con->port_altmode[cur] =3D=3D alt ? 0 : -EBUSY;
> +		if (cur < UCSI_MAX_ALTMODES)
> +			ret =3D dp->con->port_altmode[cur] =3D=3D alt ? 0 : -EBUSY;
> +		else
> +			ret =3D -EINVAL;
> +
>  		goto err_unlock;
>  	}
> =20
>=20
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> --=20
> 2.55.0.979.g7e5102b832-goog
>=20

--xz9YC2TuYFrKA6LN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaptn9QAKCRBzbaomhzOw
wuz0AP4ySOCZSKB0lX/BLT1e8/Gxw+FmZz9zlFsHRLCuTHqxTwEA0ep/a7o+Y1+Z
WeFFII1ounnwUqeO6lfrbG5OHio4tgU=
=SXpO
-----END PGP SIGNATURE-----

--xz9YC2TuYFrKA6LN--
