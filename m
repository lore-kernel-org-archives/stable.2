Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BD52E061
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174298; cv=none; b=HFoN5w3o/ej27my7gfHONx6x/vgvm3f6cKZWHCLwtyIfFVmMCCntEwhba969TOrKeeHXI/GJBgHx9Zqdh/gIeGnlG4X4zwpoDTGxOMBEhBAXwIfDY3Oria6VLQH6a8M0Xcaj8bXdcApCp0vytU4KkbsRNFjIHrfDCZpuxXFIO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174298; c=relaxed/simple;
	bh=958hoA3Y+O251+BaOtGpUqQEIEQO1XKIUZL2YE+f708=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AP7p9tYiNOJKIQOkQ3ZHrPZVBAvY9Hwsh847+dj3o0OhQTSt5MzvIIgcFQNUbuxE/ITEDjOgQK09lFi3Qg4BqS0AJHo5C7wrLxO+OWhXKLewwip7Qvhl+ycP0epSZHgO8DHO1oHcmiLPNFuLIkbQRHAm0fWMsEl8pL2DiuJ7AfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GLQPxv87; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GLQPxv87"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1430044a91.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174296; x=1790779096;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwZTZFrF70yBaRedoattuxlkjfQ8fOQkDkkzXE8T0kU=;
        b=tODtrRGpkxZTWW26VWDmLpgSujk4or9/3P54P4Gzrrm9o1qlLBJmC0ncgCbjz2WRVg
         HPiReIh5QpVxBNaZ8OBREk9XFoNTR9+HDhquCwxqhjjs1uXoxDT+korZS5Pf8x3u1hUL
         wSjWVzztMYQGUgRUIz+CNM65f+8JLbiyLbEfx1nya27Q/7f08F5XLu3g+4dPNn2DJ0qG
         XOvmBbv4oCZN2VsvREAx0ho9wVwFTS2gZgKoGIUdW4pKSRCZFwkOVgyOai7bRxhOSXZ+
         i4D+uc2U8GwtwxtUGuFsYCqFkrVPXGK45DqOhpPrQETCCdy3wy/gS0CJpu74myNXx92i
         prXA==
X-Forwarded-Encrypted: i=1; AKwUvBx09Tt9ze7r/QIBNcbxerMl3x7QnbVYc+s0rtoy6G1e9cKuHraB95jHHXG/FwdUE7633qSCT8o=@vger.kernel.org
X-Gm-Message-State: AFuF++n7pl+75vnv+hWulbuAajI8aA3hUgBkyJD8wx7c/nJbaBhmwG/y
	+vXUrioqHnyCXmoentSnlPTdv48sT2S6bSm5rbWSUj42Xrpbk2x30HedCmLiZ6SB9J5UKqnS7+u
	yee8uKBWNqTbF1GnaZqdCee9oNSLcEB8dDEb+13IttpYc6nf3rOiWCyl4gXsmYfr/SutpkGq0n3
	d5tUXkot239aMlNP+7xR8G8Xg5K/Vb+sgAgKGrYcWhV6VEDWxWm9IFe2JLBRllgo1rQUaICeqUv
	9rk/Lvf
X-Gm-Gg: AYBFou0qbhWgiuE19Mb+jfLSiw9hzUrAc5d34UhOsLNkcmk2nNYYeXdjHX9QAWXihhM
	5W/etByfJPmngxiddKhTkzmDWneyZV+eTxQrpnSyGXqk9/KvC7EOotLEHYNMOSKdhkCcZCpGI7W
	SoIPwc+8TCq/132L1dVeu52d5jA3fAsif1BznY/soK7gD8M2CtxVwQDvtzLhX+01kqIJiPadSJz
	2jmCVV0ILGhLesKdqlGx8u5pm8O/jrOEsqKPrw8q1KFCKXbTN4GLoCt/wXS3gUwQeZQOkp+dupA
	o2epVzji2819rozypt0jlXn/9UN9b1t7Ra2SY0FRKST4rZVPhfyfMPA1LeBJWMn7709etRfVGUq
	ipacVoYX8j4cXw1Xi763uaKLWG/ztzSoqhU4jmctj9RmKqOpabJP8YMQtyhuG0F1q1DYXfadmGX
	ZHItLOnWOrI8N6S+PWi63557ah6pfOVz7c
X-Received: by 2002:a17:90b:4ec7:b0:3a0:7238:70eb with SMTP id 98e67ed59e1d1-3a0731e00a5mr3467183a91.32.1790174295648;
        Wed, 23 Sep 2026 07:38:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc75f4b7322sm1080768a12.4.2026.09.23.07.38.15
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2026 07:38:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33bb08e80a8so941399eec.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790174294; x=1790779094; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwZTZFrF70yBaRedoattuxlkjfQ8fOQkDkkzXE8T0kU=;
        b=GLQPxv8759M98scA0ee8u4feKhCoxuz7+OXxyp4zk6I1AFF+jNWc9n0SQystRbwpxb
         NSu5m96eThPK1YSUywqMsh9B2MJGJo8kqjWQZC6t7+PZZ42NRXLtb0TL2kvKffD2Fe6f
         D7Gc8mU3bAVKquOQtyslk5I5P1pvt0ia4aS+s=
X-Forwarded-Encrypted: i=1; AKwUvBw3dCSHJ92U+UPx4eb9lmq1G65ewMUNGaOY4e7tjGCrASyM7tkSLhZe+tGxx7jzJmcrEDzQXJE=@vger.kernel.org
X-Received: by 2002:a05:693c:8812:10b0:33c:1e4c:151d with SMTP id 5a478bee46e88-33e5c8903a9mr2696463eec.7.1790174293678;
        Wed, 23 Sep 2026 07:38:13 -0700 (PDT)
X-Received: by 2002:a05:693c:8812:10b0:33c:1e4c:151d with SMTP id
 5a478bee46e88-33e5c8903a9mr2696422eec.7.1790174292822; Wed, 23 Sep 2026
 07:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923122601.438892-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923122601.438892-1-qwe.aldo@gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 23 Sep 2026 10:37:54 -0400
X-Gm-Features: AclHuK9I1sPWruKdTZ2g86ZtrDjy2iD85ODd7q3CWFNwDVQGdDpeOH1SDBnweS0
Message-ID: <CABQX2QMUUf1ETuLmvrzQ9_rsX4+KG32YAQJ-9hV3uakAyPiYrg@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e43028065c276e57"

--000000000000e43028065c276e57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:26=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> vmw_gem_object_get_sg_table() returns vmw_tt->vsgt.sgt when the buffer
> object has already been DMA mapped.  vmw_ttm_map_dma() sets that field
> to &vmw_tt->sgt, which is a member embedded inside the struct
> vmw_ttm_tt allocation and not a table of its own.
>
> The core owns whatever .get_sg_table returns.  drm_gem_map_dma_buf()
> takes the table and drm_gem_unmap_dma_buf() destroys it in full:
>
>         dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
>         sg_free_table(sgt);
>         kfree(sgt);
>
> Both are ops of drm_gem_prime_dmabuf_ops, so the core ends up calling
> kfree() on &vmw_tt->sgt, which is not the start of an allocation.  The
> preceding sg_free_table() also destroys a scatterlist that vmwgfx still
> considers its own and frees again from vmw_ttm_unmap_dma().
>
> drm_gem_unmap_dma_buf() runs from dma_buf_detach(), including the
> importer's error path, so a failed import is enough to reach it:
> exporting a bound buffer with DRM_IOCTL_PRIME_HANDLE_TO_FD and
> importing it on a second DRM device with DRM_IOCTL_PRIME_FD_TO_HANDLE
> is sufficient.  Both ioctls are DRM_RENDER_ALLOW.
>
> Observed on 6.12.101 with KASAN, as uid 65534:
>
>   BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf+0xb3/0xf0
>   Free of addr ffff888008290450 by task poc_mm04_sgtabl/321
>   CPU: 1 UID: 65534 PID: 321 Comm: poc_mm04_sgtabl Not tainted 6.12.101 #=
4
>    kasan_report_invalid_free+0x94/0xc0
>    check_slab_allocation+0x116/0x120
>    kfree+0x103/0x360
>    drm_gem_unmap_dma_buf+0xb3/0xf0
>    dma_buf_detach+0x165/0x510
>    drm_gem_prime_import_dev+0x33e/0x430
>   which belongs to the cache kmalloc-192 of size 192
>   The buggy address is located 80 bytes inside of
>    144-byte region [ffff888008290400, ffff888008290490)
>
> 80 is offsetof(struct vmw_ttm_tt, sgt) and 144 is sizeof(struct
> vmw_ttm_tt), which identifies the freed pointer as the embedded member.
>
> Always return a table the core can own, as the other drivers do.
> Reusing the cached representation would require copying it into a
> freshly allocated sg_table, never returning the alias.
>
> Fixes: 8afa13a0583f ("drm/vmwgfx: Implement DRIVER_GEM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_gem.c
> index 39f8c4655..a0233729b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> @@ -73,10 +73,13 @@ static struct sg_table *vmw_gem_object_get_sg_table(s=
truct drm_gem_object *obj)
>         struct vmw_ttm_tt *vmw_tt =3D
>                 container_of(bo->ttm, struct vmw_ttm_tt, dma_ttm);
>
> -       if (vmw_tt->vsgt.sgt)
> -               return vmw_tt->vsgt.sgt;
> -
> -       return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages, vmw=
_tt->dma_ttm.num_pages);
> +       /*
> +        * Do not return &vmw_tt->sgt: the core owns what this returns an=
d
> +        * drm_gem_unmap_dma_buf() sg_free_table()s and kfree()s it, but =
that
> +        * sg_table is embedded in the vmw_ttm_tt allocation.
> +        */
> +       return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages,
> +                                    vmw_tt->dma_ttm.num_pages);
>  }
>
>  static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map *ma=
p)
> --
> 2.43.0
>

Thank you. Because of the influx of llm patches it's very hard to
reason about what's valid and what's not if it comes without a
reproducible testcase. Could you please add an igt testcase for this
and then include the full igt results for vmwgfx before and after this
change? Same for your other change.

z

--000000000000e43028065c276e57
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIIS0
rNNE9P30sw+FBt+AjjeL3Lj6F3KC3ngaSJqAlgF+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkyMzE0MzgxNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKOIiln/jacE5WFE7GbKUmLkyYyO3A2kfbpawb+g
XEFbn5agBMJYo2amjt1m0elR7ucmC6WWtUukHq7RqllngQRPq6PwSjeAZoHWefGZWlj4ALB88QQk
PFjxWLFqxMiMZIGKgpbZBOFRRSWBv3qnKQoeahEr7VoRS9g6j/30VZ7i6vo0AiH9RWCkyekpHFiL
u8bQ79I3PkgIdRIQ+VQSbh8hwYoTWw+ME6e4+tzz+0hQRgtgRUoa5eULIj227nyniR+nrGXnsVsP
SmRo6KYPS8i1mh0/joQ6dGFyFlSalzsNzDUp5jTYSG2TiPwcxFqG6ybpGYSBCspyG7w4qkOKSGM=
--000000000000e43028065c276e57--
