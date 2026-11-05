Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846211;
	b=QPjZY8HxF2UFGcX5RhPP//X7Xhm7O7p9s7AF4kfxDSAQa/cZxLl2OKI/PAa5JL02n9tX
	 vFHFOYVmD4ZH9rhVmq2sXELLAxTaDtKkH0N6OUeglIYo9K7sWpHXomYD0Y54kzy7T3vli
	 uYvS1HfWtO3g8v2JbD+GR6VwXfdDXeY7D7xX1dmdr8X2MKqbnzZ7rUyhKsw2QMzl3CxT6
	 UMlmynioMfQKFjvzSwXcRd8j7oGwSicAzIrpYSzJILpyVnRlkJ7lvqX5z8v4acCivPfUm
	 mYOXhWML/K4Z2x80cMkmykzMWXFBKrM+rayT83ipZkUGigO/JzsPNjn7ZA4FqQyqXZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846211;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=SG3mnPTkUQ4F9za/w8XE+qK/ulAJ5xkH8LniqYdvqGs=;
	b=QXNeALGMfq7zTD1qDHh8nEGen2oF7C2a8RrFlfqFyZLO9x7NOF+M3eDsG5/wzyGUM5Zs
	 2zQotD7Y+omeHBbf21mfBCJPbLGKd+cVX265bk09H5XSC73nHMYqTIqsyNBjGtEgzMSVv
	 sa+jLqr2wYFdSQBFm37k0h7lKs+zEvq7NuXx/AlsL2Q6FNU/OKKuCV1oaFS7DOjIm8dz1
	 24vuflRBPh/j8S/QmA/UbIuuXdaTu47H4oVQsmB3j0rKtB99O6jc4tw3hM01XnNN8RAv8
	 hbzzU7ievikYecskXiVpvpue9zYSysWkSCPPIpY2bSEyQQrutkPlBbVnQhjQUoT6zvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Ohp/quh6";
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB33606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB33606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ohp/quh6
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso958086a12.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846210; x=1794451010;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SG3mnPTkUQ4F9za/w8XE+qK/ulAJ5xkH8LniqYdvqGs=;
        b=EqqFaLJgLV6MV8dwylv4FYwTXqi529U6hsvJdBzH1hz/J7ETrbp79Y7ikEQzIk9vuk
         /gIsuiLW0RHPS3kOLWIdjMvrQ6J/wGJPsrafiDZWscTBIL97NVzpgz1reF8nWMyJZOeN
         dJEHRkukMqsE1GXFKiKbQ1hKkbhdMEozWikCSCgzdZ1OG0prPwKyWqYaOTGteHDHeG0K
         oWiSQDcSbZ5L/eMynZI7N6vs/HyRNkLVfg5ZvlgoBsPHL7m0Ec43QXdGiy6si3cepjDs
         1rbtuLnlumpcOLtyGziKJtLeqSAa8luZtTcpZpnVLKQlPNxSlD7p5y99g/l68TqlGNnb
         IM8A==
X-Forwarded-Encrypted: i=1; AKwUvBx1DglTGSu1nelTS2JsfzXQkRAbo4VYYPCZXFRD/mK+AdwbD9UgTHX5J2Fa3GckjeSxwlpLLnI=@vger.kernel.org
X-Gm-Message-State: APuU4Z953qVGFHN/AxFI0GwMD/mLVCInNZeMGlL3R2fD++X8RKR40hxR
	5bzEE62GdEnBrUuFZXuKdufLgfHvqZbQ/TlTazHCS/73MkRaPOchwkTbsIcZTWG/bqOEVZuyAtC
	REKqeyjAbnYAe+GlZL9W/StmBh/ekrNw0aqSJ3lMr6YEwvVafM3ny+q4uBkfNaXn+zAmBXTnhYx
	QnlhR+uSMyfZLIcltI2LvU/uvrrL39Nw7lc6NlgseqTwrjdH8fuUnt9e/e/iSIL2YYphipa7u/n
	AWgRRSFhATtKK1v
X-Gm-Gg: AYBFou0lop4IQS7ivxUUPaiUXHQ/ac4PjckyahTYdjICG8JGeAjeV0ZTASBVajt46mx
	AOpnVSq0643r98W+DyGVUzW/sZEv5AEdYzMOj1s08nHl/QVtmA0L1Ea7iWDh58p++gAtiWtfRfZ
	tyrGdRiBa0XgoJDpj6E1whk53ytOFgeA5S/T1cnO0a6bKwaG2vEO5hHD3s+yELiRhaIMNMC3Gpa
	sL+BUdQ5XjbRyGiFN5TvATrUiHa7LS2L5YCgtcIHyoyfZh3/HB4r1vZY2/2+JZKbiF7DKAe1Ee5
	FNTscGX3OOrVqPqw8gh6FVADvu0A7xqjooozUfT2Aq+AG3k3TLjrzpOsRCpRFlTup7rLA3aWK80
	UkQU0fwPajXruT+E40H7r0dbuviEqxafVTozdfQa1tZYKhanlU79prHT61PJy76NSjMvMBXFzsY
	BBvzTqJTUujPmlPXXGggntB7gCNBiCZDrwl2wbqMo9
X-Received: by 2002:a17:90b:28c5:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3ae897c652dmr14373452a91.20.1793846209808;
        Wed, 04 Nov 2026 18:36:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b31cfb16sm855662a91.6.2026.11.04.18.36.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:36:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91e81083140so15674066d6.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 18:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793846209; x=1794451009; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SG3mnPTkUQ4F9za/w8XE+qK/ulAJ5xkH8LniqYdvqGs=;
        b=Ohp/quh6ZDgZb/ITkc3V7/IGLtym4XoeMnbnx3nw30tNn0Kvk74RgO0Dgvkn0FJfgm
         caa/3NprRpRIYNbqkaXlQ/U+hBj03vTq5NEGagu80Z1lk6sHa9Kle3lUU2HtVhsOSN/b
         1Nb3QEE5Kay/8bMZik81IiVSm8Nvg83eBH7Ew=
X-Forwarded-Encrypted: i=1; AKwUvBxApOPiqI7Yqb+zllTWRGNSgxdh/wDWsjKyPZ+Nu09IlglKoZFQuOVc8uQ715TRkDM4DcoNtxw=@vger.kernel.org
X-Received: by 2002:a05:6214:5c43:b0:91e:9699:5f05 with SMTP id 6a1803df08f44-91e96997eaemr14886866d6.31.1793846208787;
        Wed, 04 Nov 2026 18:36:48 -0800 (PST)
X-Received: by 2002:a05:6214:5c43:b0:91e:9699:5f05 with SMTP id 6a1803df08f44-91e96997eaemr14886616d6.31.1793846208186;
        Wed, 04 Nov 2026 18:36:48 -0800 (PST)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e7b1e92sm35327436d6.45.2026.11.04.18.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 18:36:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:38:07 -0800
Message-Id: <DMMXFS0YGX39.56J0BV2Q2ZNA@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/6] drm/vmwgfx: validate GB-only cursor command limits
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-3-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-3-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue Oct 27, 2026 at 2:17 PM PDT, Zack Rusin wrote:
> Guest-backed devices without cursor MOB support define cursor images with
> SVGA_CMD_DEFINE_ALPHA_CURSOR. SVGA_REG_CURSOR_MAX_DIMENSION belongs to th=
e
> cursor MOB register class and reads as zero on devices that do not expose
> that class. Applying this register to GB-only cursors rejects every
> nonempty image submitted by KMS clients, leaving Xorg without a hardware
> cursor.
>
> The submission transport also limits the command size. A 96x96 image fits
> the 40 KiB FIFO image limit, but exceeds the 32 KiB command-buffer limit
> and causes a device command error when submitted through that transport.
>
> Validate GB-only images against SVGA_MAX_CURSOR_CMD_DIMENSION and
> SVGA_MAX_CURSOR_CMD_BYTES. For command-buffer submission, also bound the
> whole command by SVGA_CB_MAX_COMMAND_SIZE, including its header. Calculat=
e
> the image byte count in 64 bits and keep the register-based dimension and
> MOB size checks for MOB cursors.
>
> Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB curs=
ors")
> Cc: stable@vger.kernel.org
> Reported-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
> Closes: https://patch.msgid.link/20260830151619.2452307-1-yunfeng.li.nb@g=
mail.com
> Assisted-by: LLM
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 23 ++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index 942d07079ef7..14490ead99cd 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -778,8 +778,27 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *=
plane,
>  				 "surface not suitable for cursor\n");
>  			return -EINVAL;
>  		}
> -	} else if (update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY ||
> -		   update_type =3D=3D VMW_CURSOR_UPDATE_MOB) {
> +	} else if (update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY) {
> +		u64 image_size =3D (u64)new_state->crtc_w *
> +				 new_state->crtc_h * sizeof(u32);
> +		u32 max_size =3D SVGA_MAX_CURSOR_CMD_BYTES;
> +
> +		/* The command-buffer limit includes the define-cursor header. */
> +		if (vmw->cman)
> +			max_size =3D min_t(u32, max_size,
> +					 SVGA_CB_MAX_COMMAND_SIZE -
> +					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
> +
> +		if (!new_state->crtc_w || !new_state->crtc_h ||
> +		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
> +		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
> +		    image_size > max_size) {

We should have a separate message for image_size > max_size.

> +			drm_dbg_kms(&vmw->drm,
> +				    "Cursor dimensions (%u, %u) violate command limits\n",
> +				    new_state->crtc_w, new_state->crtc_h);
> +			return -EINVAL;
> +		}
> +	} else if (update_type =3D=3D VMW_CURSOR_UPDATE_MOB) {
>  		u32 cursor_max_dim =3D
>  			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
> =20


--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

