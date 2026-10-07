Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8D3DA5AE
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401398; cv=none; b=OCGN5GqY6lrNAV1HVxbP71cGorqa68gIatqvdVYkdAum6qEfMyBVUfu2yjQ6JfBqCYMx+7UuK6YLLeQiPLva9UvJc7u6gZ4eLmu/woryOmsqoxePoqZQJ0Eow4SbTtvbaDtei5D7hvJE8OdYtkL9lDP2/2w3lNX6Qd6n/MHEqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401398; c=relaxed/simple;
	bh=3ulVL3wxch8Uz+hU23ghFnUn9Uuw4HRH1V3IKmY9slM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmKe2JwPuEUDuGU+OTz0of1+oMyIMJdjxYJo94q9vU+nxGE8pBeDeGPnQchs0SVoE9F7k9aE4Go5iUIFsv/rRpaDuotCRQHu/Dh6y+8z9+LNFShts8LIXRILNEUpIzT1kqB2QMgShUop4n1s+g684wTEr9t1heRrQoyub7h/MJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d45X/mpb; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d45X/mpb"
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-6dfc4510440so1433527eaf.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 12:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791401396; x=1792006196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jF282/rltFU2/Dd0v0J8mawM++hTmhJPEvwnovsxUPQ=;
        b=aQm853u3Qrne1G7jHjhlpsZC4STyelV771+cKRTgY01NPM+Gt8sob7kDcmJvxl4PkE
         N/F6GNnlnCF8R7uupqhSmGHt6oeDTmRoWyy/GC59uC/lULRIWVRpWhz+ugNmrJqpAZ15
         E1+YlkZhynIBAFO1vx2D16IvwV6sfuT2c9j3ja3if3nbZxOhdQALDXHvQd197tZJDmUK
         lSNBNmhdlqdRjO4wtQzfDtWpbmMGxDwkAr21NdxyEFw8G7E0xl+OUtKr0N8B1caR4O90
         1txFBeo1sjomV9OeNA3OqKH1zytiqrKrItxuxqzYqux4hCqdP/s1mhFblBCrxuyjs/1R
         +WLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtCHgsEIChKmHpPJykkmeldeigHFlqFqxRmd7O+8i071KOshjNdM7rXFTBfbhYwO2TLZeysKw=@vger.kernel.org
X-Gm-Message-State: AFuF++kThig6KNRYVF5ngA9myUnmCo9fAZE58s2sg3Wxxgw+qyPmLuit
	ZO9BeX0dr9oyDKRSFEXaz1LQBOLn187qVL461SAr6LXFMGxGuizfKOgu7IHDpmMVgASgxdTufPA
	Jt5wQ8JLHnbl5N+S71DnPLWcsBnRTN8aC1GUPnhOfiwGF3Avj3mM8nMyz1meLBZbubKcLIMXTkT
	2gEMpun/tsztOE4HlUOcMBXdWq2smFujkbiubNzQVRXun29Gajy9vf51dXQXDyi97oS2gI5Q4sa
	V4GGPVV
X-Gm-Gg: AYBFou3MS2IZkPKRHshVkToqmkduWoOt1J83XOh5g2wzxYj+2q6ov5y15tt0GtWSt8W
	R+XUsDT5OfJ45U9FysZd04NenqTYGsi7Kx2woZZLUbGASoo/re9pJxjA8qz4gZnOp/WmENbXYJs
	51WrFmBWa94v/O1W10CnGxXOcor5FzEV1Jyi0wMKY9KzNOBDMTUZWZP2X15HRB69CbGm0054gq/
	ZTlH/cduaXPSWVj/7Jwk+M4+tuRIeKAmvCWAWWU6+pZxUhKtxu07yMS+rcv52fV/Zosxasy7DaA
	MQSQKXh+0VmfH+yArnImN9REYLVf5oz9mwIB1tVKI1N6OqPtLR2bfVbx3Y67IRE97QYqobUBEkL
	A3JHbDpkqxKdn0UzOF9xBrSWfm2rWfFFhjQS7PO6fCHOE/MFdFzKDEWE3A7FbFCMdaJelYGvtsu
	0IDd3CHj0YpDC5g/TkS0r3Dh1mOafrTR5nLig=
X-Received: by 2002:a05:6820:811:b0:6b5:ec2f:3568 with SMTP id 006d021491bc7-6eb2b4d058fmr114698eaf.25.1791401395528;
        Wed, 07 Oct 2026 12:29:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4a274cf7200sm45714fac.22.2026.10.07.12.29.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 12:29:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5ba3b187b35so3138828e87.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791401393; x=1792006193; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jF282/rltFU2/Dd0v0J8mawM++hTmhJPEvwnovsxUPQ=;
        b=d45X/mpbCiFYnlcQwV6deBEPy4sHRO3O33r6XJiWv7GicgpXXP2fGmHWaxBE0I7HxX
         DCsFDsWauyYjo+3hwPgakUZ1zOp7DNgxPJo5+hjAZwsDvNgVUV8BwjxO23sDdswr17Kj
         XvaX6JnqCEeDSQRZVRY8SXtXDqlDyeapwOUm8=
X-Forwarded-Encrypted: i=1; AKwUvBwSypy85PuM/SR4nzjBQ2DwK3ZJuQr38PO2+lv8xGDPsqtppX9ylKcVmJPqP27IHaIwzFmuFUM=@vger.kernel.org
X-Received: by 2002:a05:6512:ac8:b0:5b6:19c9:d7b7 with SMTP id 2adb3069b0e04-5bcd06ad842mr1106517e87.26.1791401393412;
        Wed, 07 Oct 2026 12:29:53 -0700 (PDT)
X-Received: by 2002:a05:6512:ac8:b0:5b6:19c9:d7b7 with SMTP id
 2adb3069b0e04-5bcd06ad842mr1106509e87.26.1791401392877; Wed, 07 Oct 2026
 12:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910165221.7558-1-michaltoma@sicoop.com> <20260910165221.7558-3-michaltoma@sicoop.com>
In-Reply-To: <20260910165221.7558-3-michaltoma@sicoop.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 7 Oct 2026 15:29:40 -0400
X-Gm-Features: AclHuK9szXVhXziyRSH3KZ3-xYzz3YLU8TTvRktN3bkH9vjXnH8pBTxlZjP70b0
Message-ID: <CABQX2QMOJs24-YL8vD5oiFy3sZj0DkbZPy++z-HYeOi-OApy9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/vmwgfx: Release PRIME import in the BO destroy path
To: Michal TOMA <michaltoma@sicoop.com>
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ba75d4065d45230e"

--000000000000ba75d4065d45230e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:52=E2=80=AFPM Michal TOMA <michaltoma@sicoop.com=
> wrote:
>
> drm_gem_prime_import_dev() attaches to a foreign dma-buf, takes a
> reference with get_dma_buf(), maps the attachment and, once
> vmw_prime_import_sg_table() has created the TTM buffer object, stores
> the attachment in obj->import_attach. Drivers that import this way have
> to undo it by calling drm_prime_gem_destroy() when the object is freed.
>
> vmwgfx never does. The TTM destroy callback, vmw_bo_free(), only calls
> drm_gem_object_release() and kfree(). For every imported dma-buf, the
> sg mapping, the attachment and the dma-buf reference are leaked when
> the last GEM reference goes away, and the exporter's backing pages stay
> pinned until reboot.
>
> Any process that can open the vmwgfx render node can hit this by
> importing a dma-buf from another exporter, for example with
> DRM_IOCTL_PRIME_FD_TO_HANDLE. It showed up as a memory drain on a
> VirtualBox VMSVGA guest running a Plasma 6.7 Wayland session with the
> host's 3D acceleration off. KWin 6.7 wraps wl_shm client buffers in
> udmabufs and imports them through EGL on llvmpipe, and it keeps many of
> those imports referenced while it runs, which is a separate userspace
> problem. Restarting the compositor did not give the memory back,
> though: with about 1.5 GiB of client buffers imported, killing KWin
> left 211 udmabufs in /sys/kernel/debug/dma_buf/bufinfo with a refcount
> of 1, still attached to the vmwgfx device, after every userspace
> reference was gone. Their pages are no longer mapped or in any page
> cache, so reclaim and swap cannot free them.
>
> Call drm_prime_gem_destroy() for imported objects before
> drm_gem_object_release(), as amdgpu, radeon and nouveau do in their TTM
> destroy callbacks, and include <drm/drm_prime.h> for it. The check is
> safe on the import error path: drm_gem_prime_import_dev() only sets
> obj->import_attach after gem_prime_import_sg_table() succeeded, so a
> buffer object destroyed before that point is not unmapped, detached or
> put a second time. ttm_bo_release() tears down the TTM backing and
> drops the reservation lock before calling the destroy callback, which
> fits the _unlocked unmap done by drm_prime_gem_destroy().
>
> The leak was found by walking /proc/kpageflags, which attributed the
> missing memory to orphaned shmem pages. Those matched the udmabuf
> objects in dma_buf/bufinfo, and the remaining reference was traced to
> the missing PRIME teardown. It was confirmed without a compositor using
> a small reproducer: create a memfd, wrap it with UDMABUF_CREATE, import
> it with DRM_IOCTL_PRIME_FD_TO_HANDLE on the vmwgfx render node, close
> the GEM handle and every file descriptor, then check bufinfo.
>
> Build tested on drm-misc-fixes (4600b4d1a9ee) with the openSUSE 7.2.3
> config and W=3D1: drivers/gpu/drm/vmwgfx/ builds without warnings before
> and after the change, and checkpatch.pl --strict is clean. Runtime
> tested on a VirtualBox 7.2 VMSVGA guest with kernel 7.2.3, whose vmwgfx
> sources for the files involved are identical to drm-misc-fixes, using a
> vmwgfx.ko built from them with this change. With the reproducer, all 8
> imported udmabufs stayed pinned without the change and none with it,
> with 3D acceleration both on and off. With KWin on llvmpipe, killing
> the compositor now released 84 of 92 udmabufs (610 MiB) within 10
> seconds, where the same test on the unpatched driver released none.
>
> Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
> Cc: stable@vger.kernel.org # v6.6+
> Assisted-by: LLM
> Signed-off-by: Michal TOMA <michaltoma@sicoop.com>
> ---
> Reproducer (results and environment are in the cover letter). Compare
> the 4 MiB udmabuf entries in /sys/kernel/debug/dma_buf/bufinfo before
> and after: without this patch all 8 remain, with count 1 and still
> attached to the vmwgfx device.
>
> #!/usr/bin/env python3
> import fcntl, os, struct
> N, SIZE =3D 8, 4 * 1024 * 1024
> UDMABUF_CREATE     =3D 0x40187542  # _IOW('u', 0x42, struct udmabuf_creat=
e)
> PRIME_FD_TO_HANDLE =3D 0xC00C642E  # DRM_IOWR(0x2e, struct drm_prime_hand=
le)
> GEM_CLOSE          =3D 0x40086409  # DRM_IOW(0x09, struct drm_gem_close)
> render =3D os.open('/dev/dri/renderD128', os.O_RDWR | os.O_CLOEXEC)
> udm =3D os.open('/dev/udmabuf', os.O_RDWR | os.O_CLOEXEC)
> for i in range(N):
>     mfd =3D os.memfd_create(f'prime-leak-{i}', os.MFD_ALLOW_SEALING)
>     os.ftruncate(mfd, SIZE)
>     fcntl.fcntl(mfd, fcntl.F_ADD_SEALS, fcntl.F_SEAL_SHRINK)
>     create =3D bytearray(struct.pack('IIQQ', mfd, 1, 0, SIZE))
>     dfd =3D fcntl.ioctl(udm, UDMABUF_CREATE, create)
>     ph =3D bytearray(struct.pack('IIi', 0, 0, dfd))
>     fcntl.ioctl(render, PRIME_FD_TO_HANDLE, ph)
>     handle =3D struct.unpack('IIi', ph)[0]
>     fcntl.ioctl(render, GEM_CLOSE, bytearray(struct.pack('II', handle, 0)=
))
>     os.close(dfd)
>     os.close(mfd)
> os.close(udm)
> os.close(render)
>
> The same loop without the PRIME_FD_TO_HANDLE/GEM_CLOSE step frees
> every udmabuf, so the leak is specific to the vmwgfx import.
>
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b..56bc94edc 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -30,6 +30,7 @@
>  #include "vmwgfx_drv.h"
>  #include "vmwgfx_resource_priv.h"
>
> +#include <drm/drm_prime.h>
>  #include <drm/ttm/ttm_placement.h>
>
>  /**
> @@ -69,6 +70,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
>                 vmw_surface_unreference(&vbo->dumb_surface);
>         }
>         WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
> +       if (drm_gem_is_imported(&vbo->tbo.base))
> +               drm_prime_gem_destroy(&vbo->tbo.base, vbo->tbo.sg);
>         drm_gem_object_release(&vbo->tbo.base);
>         WARN_ON(vbo->dirty);
>         kfree(vbo);
> --
> 2.55.0
>

This looks right to me, but it must not be backported on its own:
without patch 1 and the unbind fix above, releasing the import turns
the leak into a crash. Please spell that dependency out here, not just
in patch 1.

z

--000000000000ba75d4065d45230e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIOJP
C24vtsqdlKUwkuWmyUYl4NFvR6EkTGETdyaZ23MWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAwNzE5Mjk1M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFwB5xHsqoeJHOhxqFAzZMbcIX6wlg+V8n7zdy1G
dxHtLuFBO5FeSdvSlRU95r2AUmBLHRyBUZP1Nfiq92D6p/8CLeWEkR4MJK6akCmBP+WVtI1plzkg
LQwDJBTMP7uTVFpBJofDvwhNSn5hpJ6PN0Y5+UNvzUgkikulEYtoudDGe8uwyQPRVohhho0I72Tq
j6aBWgh8ubMqtNXn9M1u4H0wnejYvcFn7aEfO9jxxwCIR8m0TypfcY8LcHpRcDau4AfINZKjH7Hu
PGmK79Jxwq0tgn7F0QbhvGrEiQ37lQPcPQtRQhhUS3jRLu37VCmL4jxWOj2klQWEjhQd6ffEy6M=
--000000000000ba75d4065d45230e--
