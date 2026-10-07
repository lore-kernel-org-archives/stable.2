Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B43F9F25
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401507; cv=none; b=qXa4bcSBcjrB5D1GYW/Zn7G/GSJzHbED8olKBEGy/GOtj2M6Irim1r67JmhldgreNtkkgtwe+r6170WRlF+xuM/S5ubl8xCW5UHkRUjJCVhOcRmXRUNynvTPxKThkvc5ShtZbPmghlgR8sNpu96Jhr4C+fjVuT0zrT1NQUxijRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401507; c=relaxed/simple;
	bh=WMmfvhpb4HXYOdp8x/Jizy6EJ1+6WBUTBh5oXzne/N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0tLUz6BqCVMAcpl3oEf2UhCK6qZEkOj+26oCL3HyTRVv0+ZmEWJF91IxgQING/P6MZmivOXGwa8XHqUO0jJw/HQyN2uwhojTLr+RWqqhHcjSH/T/U4vKt8yuloxeuSGmbq9agF2/dqY2a3Wf0Um2V9POzFsmjAZxoaz4JcpAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TzTMYYAJ; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TzTMYYAJ"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4d192643dso1026118a12.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 12:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791401505; x=1792006305;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=18Rh8EjYFDoO8uBunrVRWK7jB5z6PfjQQY6DV0hczi4=;
        b=I2sf2mXAlkf+wCTMS+x6BWbMAZiAgcQkdLh3CqosNcKPndcEQDiA0QlZDn0vTPrxOm
         s3OvzA3CxQ3dj95vaQ6Q5hyizEuB/CDBALqn8XMBT3c1HJG03B629droC4m2tA28dquc
         ws5QFVonJutFHbD/wbrLqzEaHnzor3O35DgORs4rIHy9C/iEgmiNwhzDGavI+UXs9SuG
         XPb2D8wCxrHWWxwreSKBzkmWDMjk0NYWC9dD9jd/nqHWTekH+lmaf7DRehigppuVl648
         tb8eDAoI6h7ElYGIP4VlvYDvQ4KsZbwrXJxozdkzjuoWgA/PiPBOCyKUTgKIDmhL0Kfx
         tQbw==
X-Forwarded-Encrypted: i=1; AKwUvBxdBYxiacYOMBSBPo+HGH4ec8XFKJY3NLFBquOB5F7nYM/66O19Zk6FC+7tZFfYu6+OSMtHZSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdcxMdKU5vlCVhjvl4NIbw8b9DjO/Uf9ypUugVnEOIgqrAhm8r
	dyLku3jGyV0TrIAUSc5nFgOEcUFZcCWLGYCs8DUrOcPRXJvGowXMZUqhIH60p3AlyFunaOtFAI1
	4ninHFu34wJUUveqNY0xFMu99AP7yLY5wQih1MBQEJv3i2f4ZIqZCIXLxZwOFCCGHFr6V/QmcLI
	I9KUXKu9nurajOcd8tavXgd4KH5+PnR2zR5luP7fuwR6hO4oGHacChOiggSuHJ/P8Rsl6yjWgS/
	o9dLT7Q
X-Gm-Gg: AYBFou0krehIUMjQiiNk0rW8PLvVJBrMpJWo1M2W6SMH7R4Lik3mhkkY3WRS/Ae1hwj
	+Tz9TWtHzE3bBFs1Vkbo3+BHvTHoOmHtDQjgLeGC4jxALYTUvUIw9tctWM/4l44UrikOstftpXB
	SA6/I4RKTVbiHRruage+48EAzbVxxi1W5DwLYAJ+wtBoin3vZo7lyk3vUNSxZNboC/3nHSjcmmm
	nwM8kRnZdcXRiUBZW5oJHmTRHKnKf9K7p6erKb9gv3h6G3gOvdbsZaNkunsqi21WiPIQ+cRqSr7
	kuwB8xqc3QGZPpQPwsBrca9GT/aJgBiz6VCAOm4hGyv/mG5ceIyKDPWCteFGYUgWidbLS8KW3pS
	fFbDeew/sQ9GMhkFmysqMkSLIKZu1Jannt2UJhjKUXxgL2dGUGppIW/HadhF42ATuDKbmU4rNY8
	DeAXuwDW6LpfYpGV3rZyFg+V47cDxjduXPpzg=
X-Received: by 2002:a17:90b:3b4a:b0:3a8:5543:5572 with SMTP id 98e67ed59e1d1-3a89f687904mr2151344a91.1.1791401504822;
        Wed, 07 Oct 2026 12:31:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a9f38c7173sm223542a91.3.2026.10.07.12.31.44
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 12:31:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5b14d51dae1so2046382e87.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791401502; x=1792006302; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18Rh8EjYFDoO8uBunrVRWK7jB5z6PfjQQY6DV0hczi4=;
        b=TzTMYYAJTbauXwIDvcpGwWW+l0X1yziWOQjJ8wTHtsm5TBfkOLxtUCzUYs7otBlIwC
         +Y2oWLgoUPzZzplIm1LcqM8CdquAT5IzvRpffVobDyvEEslhucm5K4kwf1++wUTfwHS4
         cgW34fui8lzQB4fkgxskGI3fp6r0myigKE2+8=
X-Forwarded-Encrypted: i=1; AKwUvBxXwlMxq/YWGQhVEHOfiMVJXQ3bD5zkDOVjWo8Ee9RrLwqyPtR3PGCX9M/1/Th9aTNDENogRGI=@vger.kernel.org
X-Received: by 2002:a05:6512:6696:20b0:5bc:d39d:99a7 with SMTP id 2adb3069b0e04-5bcd39d9a1dmr111691e87.35.1791401502401;
        Wed, 07 Oct 2026 12:31:42 -0700 (PDT)
X-Received: by 2002:a05:6512:6696:20b0:5bc:d39d:99a7 with SMTP id
 2adb3069b0e04-5bcd39d9a1dmr111686e87.35.1791401501965; Wed, 07 Oct 2026
 12:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910165221.7558-1-michaltoma@sicoop.com> <20260910165221.7558-4-michaltoma@sicoop.com>
In-Reply-To: <20260910165221.7558-4-michaltoma@sicoop.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 7 Oct 2026 15:31:29 -0400
X-Gm-Features: AclHuK_p60bvym_o76BpD0hlyr7UPkU5DEwSb2zlk7Wvj7QoYLhaMk-u3APgIZY
Message-ID: <CABQX2QOKv_E=Yq9z=eMPp+5kHZR4rXw=S_HtuBGmF2jnOvsTfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/vmwgfx: Don't leak a GEM handle when
 referencing a surface by fd
To: Michal TOMA <michaltoma@sicoop.com>
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000387735065d452ae6"

--000000000000387735065d452ae6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:52=E2=80=AFPM Michal TOMA <michaltoma@sicoop.com=
> wrote:
> For a dma-buf from another exporter, such as udmabuf, this is an
> actual import: drm_gem_prime_fd_to_handle() attaches to the dma-buf,
> maps it and creates a new GEM object. The surface lookup then always
> fails, because such a buffer never has a surface.

It can have one. In the same file:

  PRIME_FD_TO_HANDLE(fd)                 -> handle H
  GB_SURFACE_CREATE_EXT(buffer_handle=3DH) -> surface S
  GB_SURFACE_REF_EXT(fd, HANDLE_PRIME)   -> S

The last call works today because drm_gem_prime_fd_to_handle() returns
the cached H, and the surface is on that BO's detached_resources.

> +       /*
> +        * Only buffers exported by this device can have a user surface.
> +        * Look the buffer up through the dma-buf, which holds a referenc=
e
> +        * to it, instead of importing the fd into file_priv: the GEM han=
dle
> +        * that would create is never returned to userspace, so nothing
> +        * would release it (or a foreign dma-buf) until the file is clos=
ed.
> +        */
> +       if (!drm_gem_is_prime_exported_dma_buf(&dev_priv->drm, dma_buf)) =
{
> +               ret =3D -EINVAL;
> +               goto out;
>         }

This makes that last call fail. For foreign dma-bufs, could you look
for an existing import in the caller's file instead, e.g. walk
file_priv->object_idr under table_lock for an object whose
import_attach->dmabuf matches, and fail if there isn't one? A fresh
import can't have a surface, so that loses nothing and still never
creates a handle.

Also, the commit message says every call leaves a handle behind, but
the per-file PRIME cache means repeated calls with the same dma-buf
reuse one. It's fresh dma-bufs that leak. The WARN_ON removal and the
base ref fix look good.

z

--000000000000387735065d452ae6
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIDgY
XMLoisLF0OgqxQGtwy8nSuhrB1bhysCmIG4stWEvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAwNzE5MzE0MlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJLYiEv6fXaf4f4agM5cAMBNrCPRP+6b+Xr1Gg3I
YBrUO//ClEjHSH4xzLZTmMwPZyxotxIrVVkORroJmI3f2/eDiJW+KdjIfZCrwQUxphA4b+IjbmbQ
CChITYVchzBMwLQz1BtVEcWsb5X10fQvHUleU9EW3zNenmlaBf8tLEidAss0sbj06FY1kWDTe+OH
28x80hrvESQFPMq3rpqWZc96XieWCVyMKH55aFwFt2OCpoJOZDq+lgPWq0x5TPiD1v9BdJbfVzv7
mkF3QJx7ckbhICqFznxYbPcEl9USxNiNE2jjMqE9OvEZmpnfj+lEpTF2CLVUFu8I6D/Q8bYkfN0=
--000000000000387735065d452ae6--
