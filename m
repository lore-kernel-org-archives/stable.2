Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBC3DB311
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393887; cv=none; b=ND/Jlx8GBWi3qJnXbWiLt6M4bkz9vroTi/mx/+Fd3AAFQEh7lfDBK9FuJwYtMwBSgZ2CqPCEzJ9wHxQhTVXNo5GFWKlhMcsgPLpnsOHuPHQV2co7HJUbpSVXcF1yxKmSMys+3t91iUGGRjq842Yjy16DLkFsy3byIiFQaSmiXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393887; c=relaxed/simple;
	bh=wiFTrAPjFS9gmbJCSQ/1I7iXYeoivekIboTXxjOxEzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBVwaIy6Opb1adrPMDIoDV4oTiY9ONvU04ArukFLPpKhJCWUlcmSZw6+qAAcJCeUwjTQaisJq2PKKUQcRETBTYrVIEwU2156G3Tpa5TskV/ulS7riyeStEWetJUvqtRAtbkcF3+OC7dyp3YmEOAHwA/O7NE8A92mlEHgLtmkySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BZHOn4jv; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BZHOn4jv"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-677aec6ddfcso2156023d50.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 10:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791393885; x=1791998685;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dv3ldutDF+RHA9yeSrQTW5i+/Yg4pkwTTRD25td7ZTg=;
        b=KSm1TYZpa1mekZHw046A/e4J7yuYL5w7PJY7J7eoNfCN3bLIV1K367LU93tpMh2cdc
         dxc3yWdJFPGjf6lduXmoXLFwrF+lXneBPsAmiwKc9XxDRUi6fORqNn3WyfdZ86loSSq+
         GPOigE8OYudfHqtQJeaf7LAV/TbFb1kZDMOWjrW14VMHCeHdO40+gaXXnFvJLKe9NP91
         OwEY3Iv7PZOh2wjuC8VN2dmNO6JpBQ/y3R5FmocCxuz88RTqd5QuIEIoRzLBPklyd1kU
         oa4WMryk5U11yqhe9A+uZYg6MY07jjx1QZUfpmzzZ1bzwLkm7Epzs8E8pluB+/Z6e3Jb
         I7xA==
X-Forwarded-Encrypted: i=1; AKwUvBxH00+jvXESFxAY3LI5iNytVG6CCUsWJbFJvExjgA/kdN0nqRp29eCi2Vy761x2/vSMkPlq+i4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKY8lT4zYzdLCQdxdQ2EV0V2xZkhfRr3erOuNvsjBas7f1kA/Z
	04ooGrYcFeXMACqCWC9G/zY9LhgMeMT00NWYoURWM6ZujxbrBMmii7MzcNaH473bDQk7kcVCdC8
	tClEz2ccI5nKwHyt5seVBCUAL2sJ85gj+VlcKk666BDWPu4htWhn7V9KAJhPOjYL+0fDQ9fpTDe
	tKBZziBkjv6CwDJ9OqNeDNoxBkkDbtRl81n9qsZbRj2RR2LxwAan5TGErgTRoIdTJZR0NRrpDOF
	IduNIhD
X-Gm-Gg: AYBFou2vxyqtGd5BE4t4DshRBFWdaiWN+o4Pb4rQ9Lc+RMF6uJsriFFq/GbMlTmq3jz
	Q4bfrdJnk4yG8AblW40go0YxffL/GGIqfk68LkDDb2xE52fCYT9x6PZZCUGFycbJk29K98Vs9HG
	RozsFOqGAJKI+src3SBts0k1/32dtb5Kld0U3Xn15wUBW41OharDT7XwT79s6WELPa7We/fr+ge
	Sz5+Hu/a1QROygB1BxjF5Rvya+cteK56Io7XLzqooMqzbM9k0fL6rLwqHpd7hj0kMkaekLBkvWE
	x41+OXvWWvmRKGQ4BfpSQvS8fwQtTCHinNUXgy72aJcfAV/D/7+zIJXs8LrUf6lrBrZpVpXtG/A
	W1wjQ62ZnqHSvaWU01c+JRmjN6cNwtlqiMJg7X1ss84attsiHmPL7bx8ucLqGQZiY+eQzSwqzJP
	r4tdc2f+mULc8c4L30da3o87PZnyVICJvC5hA=
X-Received: by 2002:a05:690e:4199:b0:677:b923:dbd3 with SMTP id 956f58d0204a3-6790a49aef4mr1075882d50.154.1791393884451;
        Wed, 07 Oct 2026 10:24:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6791b071af9sm48605d50.17.2026.10.07.10.24.44
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 10:24:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso8189524eec.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791393883; x=1791998683; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dv3ldutDF+RHA9yeSrQTW5i+/Yg4pkwTTRD25td7ZTg=;
        b=BZHOn4jvd4LXoUnxY4J9M/41yUru0Z5bj6cJWKMvSozmiWBu8vzdYw1fh2hn/3KQ8f
         y2fmW+2n14U16vOpd8nNZvR5+DLEnWLk4oC7HgC9TiGe7L5Bih4DSqTASfcWn5T0caUN
         3U9+VhsYEcQmhP6WLNB7vXpkJk1l+8zzWSEsY=
X-Forwarded-Encrypted: i=1; AKwUvBwR+yzrOB/CVvzdYCd+hKelFGqlXcaANeYBda4oTihXodjLeO/pxZNGCgR3SX+0uVy407tILX0=@vger.kernel.org
X-Received: by 2002:a05:693c:6391:10b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-3515da5dd21mr2968913eec.4.1791393883105;
        Wed, 07 Oct 2026 10:24:43 -0700 (PDT)
X-Received: by 2002:a05:693c:6391:10b0:34c:d1f2:b552 with SMTP id
 5a478bee46e88-3515da5dd21mr2968887eec.4.1791393882356; Wed, 07 Oct 2026
 10:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923135012.1823971-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923135012.1823971-1-qwe.aldo@gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 7 Oct 2026 13:24:27 -0400
X-Gm-Features: AclHuK8Rtk0VCGvLWwuukn9V5BNplvYIe1zYZb_CQF7GhcBv2ea2umqr_KEADvI
Message-ID: <CABQX2QOhT_wzq=EVE-cqjAADYKOvM8t64nxyDgB-Q8-k+89X-A@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: close TOCTOU on guest_memory_bo in surface
 reference ioctl
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Ian Forbes <ian.forbes@broadcom.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000015e24c065d4364ba"

--00000000000015e24c065d4364ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the patch. Just a quick note: I'm not a huge fan of patches
like this because they attempt to fix a potential issue, usually at
the cost of introducing real regressions, which is not a great
tradeoff. Especially nowadays when writing code has become much
cheaper, patches that don't mention the type of testing/validation
that has been done are going to need to wait a long time because they
trade the part that's cheap to reproduce "llm please fix this sashiko
bug" for the expensive "run the full test/validation tests". However,
lacking proper fail/skip lists for igt in the kernel for vmwgfx,
explicit testing instructions, or a public CI machine is our fault and
we need to fix that.

On Wed, Sep 23, 2026 at 9:50=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> vmw_gb_surface_reference_internal() checks srf->res.guest_memory_bo for
> NULL and reads its buffer_map_handle and buffer_size outside the
> cmdbuf_mutex scope that protects the backup pointer.
>
> A concurrent surface eviction can NULL out guest_memory_bo between the
> check and the use, causing a NULL pointer dereference in
> drm_gem_handle_create(). The post-mutex reads of vma_node and base.size
> race with any concurrent backup change.

Thanks, the locking change itself looks right, but the description
needs adjusting. A successful eviction keeps the backup. A concrete
racing writer is a backup switch, e.g. from
SVGA_3D_CMD_BIND_GB_SURFACE: vmw_resource_unreserve() drops its
reference to the old buffer and installs the new one under
cmdbuf_mutex. So the unlocked check can see a transient NULL, and the
reads after the unlock can see NULL or return another buffer's offset
and size. The new handle keeps the original buffer alive, but this
ioctl holds no reference to that other buffer. A further switch can
drop its last reference and free it while we read it. Please describe
that instead.

> Move the NULL check inside the mutex, and read buffer_map_handle and
> buffer_size while still holding it.
>
> Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and=
 reference")

afaict the unlocked check and the reads after the unlock go back to
the original ioctl:
Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")

> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd05637..fff4402 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -1718,15 +1718,21 @@ vmw_gb_surface_reference_internal(struct drm_devi=
ce *dev,
>
>         user_srf =3D container_of(base, struct vmw_user_surface, prime.ba=
se);
>         srf =3D &user_srf->srf;
> +       metadata =3D &srf->metadata;
> +
> +       mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->guest_memory=
_bo */
>         if (!srf->res.guest_memory_bo) {
> +               mutex_unlock(&dev_priv->cmdbuf_mutex);
>                 DRM_ERROR("Shared GB surface is missing a backup buffer.\=
n");
>                 goto out_bad_resource;
>         }

This touches the same lines as your "return an error when a shared GB
surface has no backup buffer" v2, and this branch still returns 0. I'd
treat them as a series and just rebase this one on top of that patch,
keeping both its ret =3D -EINVAL here and its surface-reference cleanup
on failure.

z

--00000000000015e24c065d4364ba
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINxZ
Pv1ePkB1fJHwbRMFJ5N7Qa+Hubfs5Fy3QWDEwpaBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAwNzE3MjQ0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKXWzvScZ1la5WIwpbKbEZ2xGJfIVdOvfNOzb27s
qNaGlobSDkF9nHZR+jU5R215V0Kk/1uRJYSpR0ynmv30CzrZcLew8gSuH9S24WXJpR2zJgpT2Kzo
OXWlxEIFlumG5zBxb85ZPMzvsCJXMWwsVa41Rr2AvYMf50r7VjWXiNmbOaaqaEcfp0LwFBlrPgPg
Y1ttE6lRGbkWkkarm6WcSuPpl3k+bJ/S/9ptVgTGCei7SxhSZXxYR5BEQcQ18g90/pHBd/LKE/xb
6bdI9EDfepjir7PK5OrFOXT+n19lW1s/YaeLOoCdjC/V4chwUgRcj91MDCkypDsaqklRlaDwUQY=
--00000000000015e24c065d4364ba--
