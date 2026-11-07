Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015851;
	b=cpteDmnRijuCdUeODkwGDZaJrPrA1qbEzYz+fL6bPaoQKzyQjB7YhoggIBnoGcRCGYNh
	 uBy90Q6rdZDdVxsW8dDZu7EQkspPl8EETl3b+f5GWr+7lKq9HtHRjW8GiYRkb4tnIeF1L
	 tr0VGfzlvPRMZInBq6f1u5U8OiL6E9Fbf5IWhl3YJTN5lrcfKTqYg15lbbh3FxDVK92Yo
	 WP80YbtROYD5WZzsESS7LWDTpdBqp7fjqcZHDn6L1KuFYWnijCmxHcZT/3VtW3oYxiU/A
	 BbVd7j7sEsKUykNZu6MTd2GhqhaooeDYbn3dRjTWu5itORSJO1mKqIOV0ntY+ZLDrEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015851;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=iDcqyIwHyLPNpA9Nc/J7uqunrD7SXYBun6M1IGZNqHs=;
	b=bHfBXBrISsBDHiyVpXB/CDPlj+dYl0pCbYKmMY/yugzzxOar/HbWpIhdLwwhTA38SZHo
	 h0Gvo+MVO8eHGQmccxKbRS4gHzlIdz5oFpmYaopi0PoXao70ygM75UbzkLDcA3iLyGKdT
	 D4X9UoBo8Iw85ZP44xGRKx2FRGaxqhY/8COCSkXmNFSp0yBi4QQZe9ZYptHcAf6Yjh5YP
	 6voa3dPVw6eM1VRgbtJWwd0zn3dTNCQFmp1cl6R9K+Fm9TRk4x10j1hGgAkChFtK255CF
	 8YYhR615nc/Oy00j3nYbRJZob4ApQ4+r7cGdPIHwN+9b2vgPHMXCL2jpMg+FCxQxVwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WQEsFKzf;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA323606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 01:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA323606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WQEsFKzf
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso585375a91.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 17:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794015850; x=1794620650;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDcqyIwHyLPNpA9Nc/J7uqunrD7SXYBun6M1IGZNqHs=;
        b=ITJmCjmdfUNOQTSK2ydWEiFJmy9W2Hj4pO+cN3xxr1vZ3ldj4FfAf9GqQCG00hJdjs
         DQSM/4nc0O3d0/UWI7tEyNaCU8utUZZKq3EsQSuXp8OqhhaiYke4yCvJ0irwbdJJ/QRA
         Mh/XUnFRrxKioB4eXXqGp8yjUsbjML4rGDciffEwEB5oyDRLY7stboXnyW96L0+8nt7e
         X5kUcJYF11BbAuY4lWSn9hf3v7kbvHn7M4z0mlyB7jzQP5UwcrUQdCgk8BleWj8OEi7+
         4N1XjIMRb0NShWJZrH5J0gIjLGa2IN+Jn9neFxJScLK/ONlnzrZ6nV4hEL3zKp5+KoOr
         oYrA==
X-Forwarded-Encrypted: i=1; AL+hErHcGRGeXcgt6//08GafY+pxb9/RHIqC91z+RrGoBTIuHYrCcOEkLwd2KUk5VvBMqJLde+O/2sQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z92VcZNGpxSfiRPIZGawYUDmVYIDrveJdSN+JHQwlLjFueQVyVL
	nIS9ei9W5O7xrO2Ui1fW4Z4b5ULNGyZ8Y02fFmhQjPnhHdonUTJcMO4gIBXii4IhY4X9Z5GxEko
	wqfhfbTHe9SselK71NN8Y/unVN5QCb3vOk+Fbji5qXmG0OSPvl57WPJPgAvXFBep0K3RcjQoHne
	NyvnXeG05VXEIgsGq7Z8/Llltqoh98EY3O0gXMIgdv3iX5h+ELwHIBdmzivWmRXmn0vtJYR0yTY
	NZxI8og
X-Gm-Gg: AYBFou0GMORYLIstWdjALpjiCI1uEvhVK4JKeHGRlh2VstkAqsmRk8m1mw/EiHZb4BV
	yU+90+5medFs4Vs551Ev2fOv/VCSsLLAU2pO+7iOdfumfvOsbkv9p3rbMJ3+SOwXS2nLgwXEFwI
	sW9krgQWAjCuujlttdLwZkNI5yJyMNwhxRYvCEngG4Uj2kV+GAhnHFx5Skyd5Bq/ReLMmAprpEz
	/cB4rmD+A3Aegk15cL8ew9btp7E4I2L0dWiFeYdC+8efa3ZlgzskF034TPdb3/ShLXkkW6NPMaX
	NhiPTyAl3GnVIvbnHUgSfpEwlv+jmRt60Rz97aWmvPPwmfMf/QbMIrKuE7qg9XYCwg3BSDG8orL
	ZFXKAMz4UXGYFDzID22e8TXUqbP/U+7EnpPFU5YvThGO4TkmmPSTqq+mSNBH3zgoSWI1Nu8GBi8
	vkSnSRED/xoE7dXM4TiHSUqxMjou9OoUUT
X-Received: by 2002:a17:90b:270e:b0:3b0:ac2c:1619 with SMTP id 98e67ed59e1d1-3b0db70a2b5mr4005315a91.39.1794015850078;
        Fri, 06 Nov 2026 17:44:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1059079f2sm588267a91.6.2026.11.06.17.44.09
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 17:44:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3ab3061668eso839421fa.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794015848; x=1794620648; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDcqyIwHyLPNpA9Nc/J7uqunrD7SXYBun6M1IGZNqHs=;
        b=WQEsFKzf4cI8l5OMEP98RGCwtSfOfbTOJlCWdVkGAY+UfX6qEDxBSZbpudw1lFHuYO
         XRlCLQ6i1BYYCQwTwcVGOUCKXldnsXQPQZrRzS9/D99NDpYEZkmf0zuBIrsRNUUrzXts
         KI/KHFpxVWpGYEmkDQ1a2r4MOSdSyyI0Y9Fkg=
X-Forwarded-Encrypted: i=1; AL+hErGXfvvHqBWQlM+qRYkvrVQTgMqQaUernsE5I/RWoAz/AoEJb6tLZqZIGbSXw0c/rBUfWtZm8Bw=@vger.kernel.org
X-Received: by 2002:a05:651c:150c:b0:3ab:ac4c:186b with SMTP id 38308e7fff4ca-3acfd85be36mr894221fa.9.1794015847670;
        Fri, 06 Nov 2026 17:44:07 -0800 (PST)
X-Received: by 2002:a05:651c:150c:b0:3ab:ac4c:186b with SMTP id
 38308e7fff4ca-3acfd85be36mr894161fa.9.1794015847188; Fri, 06 Nov 2026
 17:44:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-3-zack.rusin@broadcom.com> <DMMXFS0YGX39.56J0BV2Q2ZNA@broadcom.com>
In-Reply-To: <DMMXFS0YGX39.56J0BV2Q2ZNA@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 6 Nov 2026 20:43:54 -0500
X-Gm-Features: AclHuK8EEW8o2ePm6hJ2sKuTWljLp_T4riJfS5fGQc4Au8CWgv2onX7ThVt5_7o
Message-ID: <CABQX2QMfQ2TS9Jg4=RewpYStMFOOn1YL1XV4caVnc_dgduWRFQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/vmwgfx: validate GB-only cursor command limits
To: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>" <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	ian.forbes@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000057f0fb065fa5dd19"

--00000000000057f0fb065fa5dd19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:36=E2=80=AFPM Maaz Mombasawala
<maaz.mombasawala@broadcom.com> <maaz.mombasawala@broadcom.com> wrote:
>
> On Tue Oct 27, 2026 at 2:17 PM PDT, Zack Rusin wrote:
> > Guest-backed devices without cursor MOB support define cursor images wi=
th
> > SVGA_CMD_DEFINE_ALPHA_CURSOR. SVGA_REG_CURSOR_MAX_DIMENSION belongs to =
the
> > cursor MOB register class and reads as zero on devices that do not expo=
se
> > that class. Applying this register to GB-only cursors rejects every
> > nonempty image submitted by KMS clients, leaving Xorg without a hardwar=
e
> > cursor.
> >
> > The submission transport also limits the command size. A 96x96 image fi=
ts
> > the 40 KiB FIFO image limit, but exceeds the 32 KiB command-buffer limi=
t
> > and causes a device command error when submitted through that transport=
.
> >
> > Validate GB-only images against SVGA_MAX_CURSOR_CMD_DIMENSION and
> > SVGA_MAX_CURSOR_CMD_BYTES. For command-buffer submission, also bound th=
e
> > whole command by SVGA_CB_MAX_COMMAND_SIZE, including its header. Calcul=
ate
> > the image byte count in 64 bits and keep the register-based dimension a=
nd
> > MOB size checks for MOB cursors.
> >
> > Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB cu=
rsors")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
> > Closes: https://patch.msgid.link/20260830151619.2452307-1-yunfeng.li.nb=
@gmail.com
> > Assisted-by: LLM
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 23 ++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu=
/drm/vmwgfx/vmwgfx_cursor_plane.c
> > index 942d07079ef7..14490ead99cd 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> > @@ -778,8 +778,27 @@ int vmw_cursor_plane_atomic_check(struct drm_plane=
 *plane,
> >                                "surface not suitable for cursor\n");
> >                       return -EINVAL;
> >               }
> > -     } else if (update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY ||
> > -                update_type =3D=3D VMW_CURSOR_UPDATE_MOB) {
> > +     } else if (update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY) {
> > +             u64 image_size =3D (u64)new_state->crtc_w *
> > +                              new_state->crtc_h * sizeof(u32);
> > +             u32 max_size =3D SVGA_MAX_CURSOR_CMD_BYTES;
> > +
> > +             /* The command-buffer limit includes the define-cursor he=
ader. */
> > +             if (vmw->cman)
> > +                     max_size =3D min_t(u32, max_size,
> > +                                      SVGA_CB_MAX_COMMAND_SIZE -
> > +                                      sizeof(struct vmw_svga_fifo_cmd_=
define_cursor));
> > +
> > +             if (!new_state->crtc_w || !new_state->crtc_h ||
> > +                 new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
> > +                 new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
> > +                 image_size > max_size) {
>
> We should have a separate message for image_size > max_size.

How come? And what kind of a message? I'm not sure if we want to be
printing all the limits here because it's not like those are forwarded
to the users apps, or that the userspace would adjust its code based
on kernel warnings and for the gui apps that respect the drm api
cursor already has the max size set. Therefore, I'm unsure if printing
the exact case (width, height, total...) that caused the request to
error out would help anyone.

z

--00000000000057f0fb065fa5dd19
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILf1
5tO2ov3e9PhE7VK+2FLC35TeGvSSM78Z/gvNcnYHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTEwNzAxNDQwOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJm1a7xJobAbSBv3KjqJxA8n1GC/V4paEiqknQU8
vP1+00EtFC0nmG7YdmspZaaQhx7/XomrcuK2Wxl+S25r+l07vIV3n575am/E5NGwB5OCYG82JyHX
Z5XbHhDDTN+sKe+nuNTwX7J27OR+2mW0IuqyBuyzSrUpT1N2D9Yl2QXgKhrZ6f02Erv25BUWi7x/
6JGefiJF8Kfqx1dY62Ksn3DzG52ggsygLSUEOlYRnljEtxkH98rduXw25Cp7E29uGpUmr3QMCRzq
ab3hBV2H+TccQ+F7sYxWvi5wMSnE+QogkuZwNmD1Cm4w6JEUMEvBjnnpro2EX3ypacAhTtkN78U=
--00000000000057f0fb065fa5dd19--
