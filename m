Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF236B917
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734287; cv=none; b=CO0u9nMZvSMScztArV2Tvcm8hyKBzb/Nn7j341np/W9tNVG0lEe+XY1DnKQHmDWuFTREzI2V4OB1YUn9C3CnF/6xKflpslPym9EwXFXhUZhYoBDZBXq9ucEUpeIZpVSLhpKYF3v0F/ZEMNHpmn7lFKRlZeFsnN8sFA+zCy7YFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734287; c=relaxed/simple;
	bh=25eR6IORAeg+BJ95HEQGj2JLdVumdAVnM5WJNvg0pdI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=lieNiJ2JfuAh6G6mGyb1ybXETEFLQdDaadWH67E3xWI29Vs3tTBTSDFsP5nQhboLs6CFBQN0qgCxv0SjaVKHxRKYLBiQX5omiZs8HBn44DIVgykY6FRlDuxeQArVI2JzkdbZFMxW2qXftvixpzXts5URzf7uXVh7gFjI27G7m/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz3hcZcJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz3hcZcJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954d383e64so30861675e9.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734282; x=1785339082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EGApyBTE5b4jGTRLUHAvD3BADA1gtPfspkpd7xsnlDo=;
        b=dz3hcZcJlg6klD3BkJ6FGqtn2AQrWF8ojoFfm+hmDvL9vskA4sG6VENrDkhXvmVSvz
         dPekpiEYHEO6F0oimWMMeBUaSzuDA0khgM92+iM+O8lAv0oZ9FCxoRhVJR+OVugwHFhR
         ZEZJG8izGAZXSGgyYCoDg00Fv97kr1yXX/NNkhGczYREwmMhn2rGzBoaEU5C5npDlMv3
         vHUzP32/A/cNAbrcdLr5YYgvsqkdywK/EityFnmLVaU3HCeo81vFlmylgcA+cz9VCiJx
         eisnMZ5EXwoMcvJPR+o05pBB7VD1IceQ30uoyqgXFgKaBMXw/kdm8ZfiNCl8uj8PlpiA
         uJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734282; x=1785339082;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGApyBTE5b4jGTRLUHAvD3BADA1gtPfspkpd7xsnlDo=;
        b=ZjdfsO3u4vYkP9ck23bEjpHlam7Gpt/WT5L1YosEOdSyDbZwWysKtD6/6vhIcJs5JO
         w4JtO+97GrDsEEnxB/Sdo/IlyLSJDMrbcnhMylIWY3/gSni5atsUP9t6uHSHVv8THB4p
         SmiSjfyib6gpoLbbLRieonukAKl9MnH3n7Bo9yO6Xb+YaOiOrclCC6K+BMUyOH6qOeO4
         0aqTUWPmfIIe5WnRHxFo5VuiTv6Q1MyxpbUw/E2+WbTtIzUx8D74973a+s7pBaSvGT1N
         lqIzHx0wSn7GhCHwbcgLjuy9IAAt1iciLnl9Od+p+ROU8wVqSre1+VxySCECCTzzGC7i
         s9nw==
X-Forwarded-Encrypted: i=1; AHgh+RpOhbzA5pHiP0FE0gSf2okZWRHhGkLSf31U14CbWjbnhGrNh/e0fwpTGDgntcmlxPV+bELRgpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygKy2k5gFqpo5KCCa/IslDsOoExoUDwpm4Ezk4fPR41Q5q+p9U
	wdS4O4J1njVWzIt9hhilhGjYxTokWQYCaC8Xi3i0sx0zUyxfhlIyVgE6
X-Gm-Gg: AR+sD109Rp9hNdkMy58rPhG6by4momZDeB2LgRQRIs7phD9scT1TTxk3CcjwEm0pCxa
	uvazYVC4dYTckke/paY2U/P0YDVrjlG/LiIYg9Kf1dgXJbmbwigx14aGgtwsMTOoDb6+kSq/Iu9
	CKgULhrDKpafe5Ah1EpdrqX70cW5vSDr2rqhZHk2b6/B9f8HdoB8HM0vYZINVvkOZoB8G87AwHe
	n35LaFyjDp653tlzp9o7QFJGkEurNtNEQ5so4YiMpcXH+cJQPVUUINPZdqvlBHM+BzuMI7t/CNC
	HiN8oJJN8pyTTmN9lMckssNwEKnAXS5hqdLmd2EvxR10fp+FCGZV2iFAj/mMZ9DO4UxNMXVYhio
	qtjUrrbgtRFBOtQHcg9MYklFXGUMUSm8nxes0vkJHBImWD2ZO1p7qz/zT3D5N7okx1X40pdlDhe
	n+H0a1
X-Received: by 2002:a05:600c:c84:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4954a3e6ed0mr255571095e9.3.1784734282446;
        Wed, 22 Jul 2026 08:31:22 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b021fa6sm51073175e9.2.2026.07.22.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:31:22 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:31:21 +0200
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: fix out-of-bounds read in
 joycon_ctlr_read_handler()
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260715115253.91029-1-security@auditcode.ai>
In-Reply-To: <20260715115253.91029-1-security@auditcode.ai>
Message-Id: <1Z0LP5TPL7LU9.3C7JC6QACT6RW@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

heyhey!

Ibrahim Hashimov <security@auditcode.ai> wrote:
> joycon_ctlr_read_handler() casts an incoming HID input report to
> struct joycon_input_report and parses it, guarding the cast only with a
> 12-byte length check:
>=20
> 	if (size >=3D 12) /* make sure it contains the input report */
> 		joycon_parse_report(ctlr, (struct joycon_input_report *)data);
>=20
> struct joycon_input_report is 49 bytes: a 13-byte header followed by a
> union whose IMU arm is 36 bytes. For an IMU report joycon_parse_report()
> -> joycon_parse_imu_report() walks that union (struct offsets 13..48),
> so a report of exactly 12 bytes with data[0] =3D=3D JC_INPUT_IMU_DATA pas=
ses
> the guard yet is read up to 37 bytes past its declared length. The
> over-read bytes are decoded into accelerometer/gyroscope values and
> forwarded to userspace through the "(IMU)" input device, leaking
> driver-internal memory. data[0] and size are fully controlled by a
> malicious or spoofed Joy-Con/Pro Controller.
>=20
> Receive buffers are sized to the maximum report length, so this is an
> over-read within the allocation rather than a slab OOB, but the decoded
> bytes still reach userspace.
>=20
> The sibling subcmd path in joycon_ctlr_handle_event() already bounds the
> same cast correctly:
>=20
> 	if (size < sizeof(struct joycon_input_report) ||
> 	    data[0] !=3D JC_INPUT_SUBCMD_REPLY)
> 		break;
>=20
> Use the same sizeof(struct joycon_input_report) bound here.
>=20
> Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller drive=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>  drivers/hid/hid-nintendo.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

This LGTM!

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

Cheers,
Silvan

>=20
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1..11b5fe05acf4 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2607,7 +2607,12 @@ static int joycon_ctlr_read_handler(struct joycon_=
ctlr *ctlr, u8 *data,
>  {
>  	if (data[0] =3D=3D JC_INPUT_SUBCMD_REPLY || data[0] =3D=3D JC_INPUT_IMU=
_DATA ||
>  	    data[0] =3D=3D JC_INPUT_MCU_DATA) {
> -		if (size >=3D 12) /* make sure it contains the input report */
> +		/*
> +		 * The whole struct is cast and parsed below, including the
> +		 * IMU/subcmd union, not just the 12-byte partial header this
> +		 * used to check for.
> +		 */
> +		if (size >=3D sizeof(struct joycon_input_report))
>  			joycon_parse_report(ctlr,
>  					    (struct joycon_input_report *)data);
>  	}


