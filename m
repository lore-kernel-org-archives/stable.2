Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416862;
	b=xDXgtBZRsb6+0mMA28M3fC6R+Z39qd3ORMi0GMaxFMVBCkbvyM93NO/XPrfUDDUgano4
	 VmKoMebq8CKfRLO7aapmxb0iAoHYJXHzHdVgI1Kiio+61zbUB0ylaJEDWkPFyTXH72L2T
	 oW9wdSh3KzgpiUtKMc1LRUH7i5sAP3K89ez5/9u3rPPWopJhwTH2FizyuR9l9+tiWUQeB
	 fiHcv3kmcDt9kHH+98NXB3nEhdHxVwCgVtofszg6D3WkNGUSw5Mm+o0O/UADiWyDr+0lQ
	 VUxLQaO3Ec87BfKFKHMV/0M4MddITucWpYSC+qCsF5uanN+Hs6hKaIj9AumTTiSHu9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m8C3iSuJZb/bfGc8EsYwKela7J4KFddbxGMaPc1LKNI=;
	b=gsYfGY88upNlJ9vmF7MHr5cvi5o/RlEN2IvAONsVIxSsRZ0+frUCi9tIg9HcPa/fnRqG
	 AP4TbLK5iI52tCBXIPSUocOlxK2++5f4dYj5Lg39Shc8uf4mx7ZGslKsIVxk6zKwLt6xv
	 UkmoaPkt9rhftNiNKjZmmRuNPPWXM3jIIB2/G77Jo3aMSo/yjWxZAF6052MTNt8M7gsgn
	 /H56e3t0LjixKgMQhGmkZxZcweM6/DIn9CibqhFwY5YNQLkyMrQ8XD8BeR+w+YG0JDGH2
	 DctnRDaFTzoax3M5IYiF2t7vq2B1sQRLpKfKEjvWG3cO/tR581eDo3VXVh5VSlxixKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yu0tahuo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1250606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1250606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yu0tahuo
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-376a4059061so90751eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:07:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416861; cv=none;
        d=google.com; s=arc-20260327;
        b=QfzosVuA7weZu4tczzIbwSfZH6r0VhyCeRfHgpOaeeKsOUmcl8aSF9wd+E6bkkxUO1
         pcevmSlVTgwe5QgHCRA61sU9WBdlB7KOfc7lLZq9fDqZXsFJiGKpYBT3uY4kiwrdOzjs
         YTMcczDt68k4bq3rE6NERAjoKq0NeM9HOiId1mbIrNoAXLwXNNTGR9xrFnCTt5orbKcA
         FUWdGAjbCG5ZYAiYJO1BukiySmCcqQGbKQgCKo1YEw10Osdy4kdDxAiAGv9RKKUMF4b2
         50x/2GfKbI97NFHDLaENd2RehHEZzWs6665+Cnh3zuP/cdkTmzHxZAbe/oB8baeb8u8O
         MtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m8C3iSuJZb/bfGc8EsYwKela7J4KFddbxGMaPc1LKNI=;
        fh=uqJiogodRPxAgzROAofBE62rwf689rbdBVP5upNyRrM=;
        b=i5/J+wCHErEbc2zwdlsNbgF72k5mSBww3Wo7NFVIR5AGrlvJiN6ZNvwOc6k9oHyBld
         2kc/wi+t40cXyBjK2G7kG8ASPLzLjeOyoQhZUYjvfbXaKyWzeTDU7tcNGiBhV+mpMUFo
         zU00H/pri/lO0SMbAV+DQNVC1GtMPChWdxFru402beIn5BmssT8tOTWnT/aWBA85V1YI
         sQXOE83QIkEO8mTWhftNBIwDk0L5Ynvx4LjfnpbNuVkKJ4qZe/jJt2qwzM4pfCMXHEd9
         89xCH0+m4FmRzQ+diU+Y3MuN9CW6PiuOmk7jliCfh6zjtvNY3XzbGJb557PS3nL4MV9r
         Qfow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416861; x=1795021661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m8C3iSuJZb/bfGc8EsYwKela7J4KFddbxGMaPc1LKNI=;
        b=Yu0tahuocuESYqefq+y7fSQYzAxt4lPHSsg5PGKLsWgwc3nznCgyZoywvLPhsnWXaL
         naTEK8iktIklEsNs6WGYObHqJmu/w/VY5IxwuHHnJU8DdKNH6RS+5MSDELQhLRfPbJN7
         U6khKuJMZ6CmYJYj/TiGT50rf1I6yS2tca1y6tLxdM8jXW8R/+XwwtLonfE6zrMyXDeQ
         54ScTlscyGh73yv9Gg2joc4Qqvrmb8Xf+b5cQ3d0XSzwYmmKneN9p2fbsDvPZA/sjCAK
         +hmhfjJaSH21k1NVqzl5XRhA8F8l2/QZD2M7ssSNUHE1mC3vzZxMKc6gYcx6Q19DmKKR
         mx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416861; x=1795021661;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m8C3iSuJZb/bfGc8EsYwKela7J4KFddbxGMaPc1LKNI=;
        b=zQe+o7dEE3e1d4gW9qDx/KLXLhXTqcRCPNoNfP1otENwqkfX/a1tUD8QnKR60qCu5a
         jgsF+vUSKUqT8sXsxJFPbHXNVG6NBgCkVSLuJoBIEaABUNK5NXmi8H8Ov0s4hVHJcOwS
         Z4GXiR0u+zlzj0V2xzns5UExeoMX8cbutNn+J8p+TejLSp27yzqA0+2wLJTiVnowcWdi
         VLYZE0R4Pbu+txT5Ywvn/Aiwz8niUsd66wE1hidUkWmRmWlwNEK6CVilFRNGIGBuMQYk
         xxyaEgpaAw3ibqeyyFDnLhfwapNt4EdlC7tLCebMBGFE5NbOcC0lLSXDnC80pTnx7zRJ
         /OIA==
X-Forwarded-Encrypted: i=1; AL+hErEzikDojA7nN9voMptH6JGcTsggSmfGBBpma4YxIubFsLBTbweb5yPYw8BNHSRTzFD5isuJM20=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gX0g0QM+CHb5YY92n6XbK0iWzWj84UzIeIWCUVbvcGNhviP7c
	Z4Vz7nimEwgPMDG7mq3icDqlIn8lSsJDPmut0kXcNh2N9F03ypCu3mZMSE9qdAGQP/2/sqI/adI
	vu9tM1ETqm8X2nEFhlv683OZab8NzP78=
X-Gm-Gg: AYBFou2np6qznGVqZLvf/XX9tqN7TYlpvFTXOZ0cfazC2qfX7slwR8PDPvgGUYEV9uu
	N5iJXqGZKZhnpHchgd6HImfzBvG9m2lniCOLhxGPGPA2RJNeEhLPpjxhvYN2D8DNTRd77l47MKs
	tftpOcQgIz5+XIleGdYBY3PH73mCcrJIEcD1jWevxFL5NSEaRet4WmGjMI0VwXSBnZTE/0BDbSv
	omiUqmSljp1aWOaMIRlQ8ZoJGX5FJBBV7HleAsqdedPiu7wXvfd5m6/+gXfhGBHAX5nzCPFka3/
	2kP9BI2Wde8Rhu0eXBmDoBMkbHgeunkkozEu8YnpIGa1kmwkkwbWb6O6Gi0M0r5SbcMlUPXL70L
	6pxAMHnD4T5W9TPmvwGSA+fC0qt23y0v7nEionsPgaTHobC7YIWzJ1h8Qa/WOT8mrDIim9+GybG
	iXam8G7YA2X/sM5fzfk4WfBs+iKpOIiB2yCZqEohMQHgZqoDlOwYJV1zBXsZA=
X-Received: by 2002:a05:7022:3a86:b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1b3c01600d4mr4530976c88.0.1794416860548; Wed, 11 Nov 2026
 09:07:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109155215.3946844-1-amisiurov@cloudlinux.com>
In-Reply-To: <20261109155215.3946844-1-amisiurov@cloudlinux.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:07:28 -0500
X-Gm-Features: AclHuK-_9BWEPd6xXKjNjzph_kbOJc93rFAg-o-qHWWs0SN7OfCKCcfKPgpijZs
Message-ID: <CADnq5_N=v=k0e=+aqwohNMoKEmoCbMj5PyEM38_fKa=h6O1Z=A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Bound GPIO I2C table entry count from VBIOS
To: Andrey Misiurov <amisiurov@cloudlinux.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed and applied.  Thanks!

On Tue, Nov 10, 2026 at 3:41=E2=80=AFAM Andrey Misiurov
<amisiurov@cloudlinux.com> wrote:
>
> radeon_atombios_i2c_init() derives the number of GPIO I2C entries from
> the size field of the VBIOS GPIO_I2C_Info table and stores a bus for
> every valid entry in rdev->i2c_bus[i], which has RADEON_MAX_I2C_BUS
> (16) slots.  A table that claims more than 16 entries makes it write
> past the end of the array into the rest of struct radeon_device.  A
> size smaller than the common header wraps the subtraction and the loop
> walks far past the table.  radeon_lookup_i2c_gpio() uses the same
> calculation.
>
> Reject undersized tables and cap the entry count at
> RADEON_MAX_I2C_BUS.
>
> Fixes: f376b94fbc0a ("drm/radeon/kms: unify i2c handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
> ---
> Found by code inspection.  Not reproduced at runtime; it needs a VBIOS
> with a malformed GPIO_I2C_Info table.
>
>  drivers/gpu/drm/radeon/radeon_atombios.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/r=
adeon/radeon_atombios.c
> index 3dd9724..c4e1272 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -125,6 +125,22 @@ static struct radeon_i2c_bus_rec radeon_get_bus_rec_=
for_i2c_gpio(ATOM_GPIO_I2C_A
>         return i2c;
>  }
>
> +/*
> + * The VBIOS table size is not checked against the image; cap the
> + * entry count to RADEON_MAX_I2C_BUS, the size of rdev->i2c_bus[].
> + */
> +static int radeon_atombios_gpio_i2c_num_entries(uint16_t size)
> +{
> +       u32 bytes;
> +
> +       if (size < sizeof(ATOM_COMMON_TABLE_HEADER))
> +               return 0;
> +
> +       bytes =3D size - sizeof(ATOM_COMMON_TABLE_HEADER);
> +       return min_t(u32, bytes / sizeof(ATOM_GPIO_I2C_ASSIGMENT),
> +                    RADEON_MAX_I2C_BUS);
> +}
> +
>  static struct radeon_i2c_bus_rec radeon_lookup_i2c_gpio(struct radeon_de=
vice *rdev,
>                                                                uint8_t id=
)
>  {
> @@ -142,8 +158,7 @@ static struct radeon_i2c_bus_rec radeon_lookup_i2c_gp=
io(struct radeon_device *rd
>         if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_o=
ffset)) {
>                 i2c_info =3D (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + d=
ata_offset);
>
> -               num_indices =3D (size - sizeof(ATOM_COMMON_TABLE_HEADER))=
 /
> -                       sizeof(ATOM_GPIO_I2C_ASSIGMENT);
> +               num_indices =3D radeon_atombios_gpio_i2c_num_entries(size=
);
>
>                 gpio =3D &i2c_info->asGPIO_Info[0];
>                 for (i =3D 0; i < num_indices; i++) {
> @@ -176,8 +191,7 @@ void radeon_atombios_i2c_init(struct radeon_device *r=
dev)
>         if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_o=
ffset)) {
>                 i2c_info =3D (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + d=
ata_offset);
>
> -               num_indices =3D (size - sizeof(ATOM_COMMON_TABLE_HEADER))=
 /
> -                       sizeof(ATOM_GPIO_I2C_ASSIGMENT);
> +               num_indices =3D radeon_atombios_gpio_i2c_num_entries(size=
);
>
>                 gpio =3D &i2c_info->asGPIO_Info[0];
>                 for (i =3D 0; i < num_indices; i++) {
> --
> 2.43.7
>
