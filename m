Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116532;
	b=zjf2jCQ5R9vciq9gC0IM70fM89kvER9+RuACrP3o1OMpoHAn8/jyJfGKtNu75BCv8BdH
	 11Spkfs9Jx6YKnCev6skIX9vHibityHiF0AHhBH+jcEU9u53HWpcbXdhauDdcroqDBoer
	 bLnkqOVu2hAhavmOIIX/63r/QrgRpHT9PQnwzH0gmB4V/qBS9pA+3VxCV+soL0toTP7zp
	 sDYhdbilGsyZMEAZBmIV7BeSwUQgPRSSb3T3dZJoA0/bcXZb+ZbhQtznEWkYh8reH53L6
	 +52BPFy8VQGE1HVI8LM3R1QubcnB0fxr3wpQVPt7TeuVvFnyjzf4fZ2y3CkvnUn8zNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=xppnKgi4kFZOZh7Zfae1BSLo1JzIIBwXzu5v89JWnQE=;
	b=QKzPh6NhVo4wnTabRKhrjcBdb3qYAOnWxjlJY0kH1ttpr5/01eSfNyI3/U57BuOVDkgK
	 lkWq2vAVhd4qcvRD1CFNfWlDur0iksyCNbElasdhcUy1nkQIqyjKcD/X/FUdNNJ7aM9GN
	 xue69BtyAilQRcXS5nBdAshhQDpfkUN3cvWEVTGRxxEXvS9gOL+AY5HIVREqnHGlC7OLI
	 R7A6yFAe91PXG6lVXD3Jyw/COhGuUo2x1bF+fDo7DmQSPVYboU7QetxxilK4kgoY1IPYd
	 zcGSZDOSB8egM5LNRQZ+c9kxBHb7+hvtqMP10W6uYtyMpjY0u8eOi5sNVFIGyyfnP9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CDzOpn2B;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2B606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 19:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD2B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CDzOpn2B
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4ea3c5afaso942897b3.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795116530; x=1795721330; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xppnKgi4kFZOZh7Zfae1BSLo1JzIIBwXzu5v89JWnQE=;
        b=CDzOpn2BSz2DPVuAkxIEXR32DFgENFSPDIb/LGpEr8Tl9NAZMcsC2JwCNkAtLLbt5s
         lecVGzC93DjbRnbySp81+vXN8koWfUd31K++3Saa5pOhDY4iFFPEglhYwg2KXGvTk5d7
         VQXUcxK/TgUKGtwhe4umw9tyVdeM9zFO/atsepk/2WJ0pHN8ma14iTgnJkLGIQ4rrMA+
         eVA6XNNMxHJjA2sVzhD42iDwbh6ZexsHLcYGcjxDGFlzbFq1BgqPJior8dz2xMje/VSG
         JkLmxa7ZdoRKLoVoOWFsaX6IoBbRj2I2QNS8KuVQPB0DMvP2aL2KRaa0Dq5It66f5dSF
         fBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116530; x=1795721330;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xppnKgi4kFZOZh7Zfae1BSLo1JzIIBwXzu5v89JWnQE=;
        b=KXgn3PxhJFhYczJMXXycmaBZs2CVMF60IizetHkWaLU/Xn4cZV+dF6vH46BdBIIvxG
         vz6TI6OdwdO1tdvEFhxaF5H2GpodtmifiGP+Q2wdTK+aFmyTLmLepbcr2rwcoMj3Lrjt
         xjXGcRsmUP4F4a6zTygZwvfxZlL1hF11EQIMOwXcRpKwg4yCPnGweObz8ZeOqRCnBa6f
         2hMV4CmpFfOiWHh/OOR0UWHTfN/rTspFQQa3ZbTLXVuLexW3jIg/GtYM2VMieWeyAPtT
         7VpN/cXRWxH4Xqb+Lx+YUTwVkCrVpBTThZqqne1IRtR/VUmdWo4G48cwmFwiF/0PCIm8
         YegA==
X-Forwarded-Encrypted: i=1; AL+hErFz1ByxEHgq+VuzjevkgEVc3gi7nsCJbop+TZeHvZ5Qi3A8gTzaQLdVg3AVS52ms71ALOxZvbk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DI8W+FLY3nemHQ0IPo0bWC6djnSUkhd2MqlJs3/mxVflF5FKB
	KuxS4EZKROH6Cz7VwuUbXTyfG7UCKuIainFUJAyp99Q0hFbHFc8KYKUu6mz1fOsrYWs=
X-Gm-Gg: AZFdTZfLVS7KePgHYJUx9omqAFgUP7L8jX1myIIvjUa/6e8ZtVP3NlXWD9WnpD142ev
	aSLbqdDuNkjnudOrhnd5W50gGpcbgLmDsabkyQ5DUFhLlqocZ6vxv5I82qBMtTzHKW8PQx3it1Q
	6wlP6wNkGtG3Enk/dG1nFVL36mbbbF9p2mPy8DPAt60XNjBNrD+7Q8RoI6Bebqre9oFIfhjUl77
	ax5V7ojy+QDdAnkYaedLkuO6jA8v5KCSWcIZFaIVYH99WOnmOMiXDxnrdMdKjfGTMvHlfr6RZEd
	4KB8I/3dViBpkMrLlhc3iFL44rLXmejv85Dihqn1sX2/GsrSuc800lRB0M0hK+5/UojKk4+5ZrD
	bNedJQvz2Ukrb62lZVZNemJ3/ZC1x5lADkAAxonA5drTkEVrcwr9WkS48FUvCBviqvZtTNLdFnJ
	zkkrY8Ttn6lDdc53OK28g1lWD9bNaKpVyZEu7EAFzG4zr7kmQGoPLt7ZtkcAXPTSnrU9tJ/8MWZ
	ZpLZGb2WtQVInTirewH/EEwig4iT3PoMrIoEV+RWe07uvTRghJDUhAvfj1xPkLyMISsuJ27JijX
	5qW4vGX+ASue/8nFpexu5O2594BKltkcGxUt4oB0SC2iS+d37n9pA4AQEqFmN6jh65p0NGgEIl3
	DfqFixPre1kNtmZuCPhItsjb/DYEfSWVFw4X82RboGJKJd/GkYtx1q6V0Czzdst2FyIz/IX/CvW
	wotdLYarB27L0VELsX
X-Received: by 2002:a05:690c:29b:b0:8b3:38f3:8644 with SMTP id 00721157ae682-8b52032afb0mr3569157b3.11.1795116530384;
        Thu, 19 Nov 2026 11:28:50 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520354770sm4225287b3.42.2026.11.19.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:28:49 -0800 (PST)
Message-ID: <2bdd75a116a2b4c355b24d54f119c2de8f574035.camel@dubeyko.com>
Subject: Re: [PATCH v3] hfs/hfsplus: validate uid and gid mount options
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Lei Qiu <750592120@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 19 Nov 2026 11:28:48 -0800
In-Reply-To: <tencent_F0BECCFBD52CC861F260A0F6169273C41209@qq.com>
References: <85c26064db32f34da57b313a2e5d505f60ad1df4.camel@dubeyko.com>
	 <tencent_F0BECCFBD52CC861F260A0F6169273C41209@qq.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-19 at 08:54 +0800, Lei Qiu wrote:
> The conversions to the new mount API declare uid and gid as
> fsparam_u32
> but consume result.uid and result.gid. This bypasses make_kuid() and
> make_kgid() as well as the validity checks in the old parsers. As a
> result, both filesystems accept the invalid ID 4294967295, and IDs
> supplied through fsconfig() in a non-initial user namespace are
> treated
> as raw kernel IDs instead of being translated through that namespace.
>=20
> Use fsparam_uid and fsparam_gid so the shared parser translates the
> IDs
> and rejects invalid or unmapped values before storing the typed
> result.
>=20
> Verify both modules with W=3D1 builds and a before/after QEMU test
> covering
> fsconfig(), legacy mounts, and a filesystem context configured from a
> user namespace mapping ID 0 to ID 1000. The fix rejects invalid IDs
> with
> EINVAL and preserves the mapped ownership and valid mount options.
>=20
> OpenAI Codex assisted with identifying the issue, implementing the
> fix
> and reproducer, and running the validation.
>=20
> Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
> Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount
> api")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lei Qiu <750592120@qq.com>
> ---
> Changes since v2: drop the build.log artifact that was accidentally
> included in the patch; no functional change.
> Changes since v1: realigned the new fsparam_uid/gid entries with the
> existing column style in both option tables (no functional change).
> ---
> =C2=A0fs/hfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0fs/hfsplus/options.c | 4 ++--
> =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 5e6d66ff4..5ff04a7c4 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -203,8 +203,8 @@ enum {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct fs_parameter_spec hfs_param_spec[] =3D {
> -	fsparam_u32	("uid",		opt_uid),
> -	fsparam_u32	("gid",		opt_gid),
> +	fsparam_uid	("uid",		opt_uid),
> +	fsparam_gid	("gid",		opt_gid),
> =C2=A0	fsparam_u32oct	("umask",	opt_umask),
> =C2=A0	fsparam_u32oct	("file_umask",	opt_file_umask),
> =C2=A0	fsparam_u32oct	("dir_umask",	opt_dir_umask),
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index 9b377481f..28717b6c7 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -33,8 +33,8 @@ static const struct fs_parameter_spec
> hfs_param_spec[] =3D {
> =C2=A0	fsparam_string	("creator",	opt_creator),
> =C2=A0	fsparam_string	("type",	opt_type),
> =C2=A0	fsparam_u32oct	("umask",	opt_umask),
> -	fsparam_u32	("uid",		opt_uid),
> -	fsparam_u32	("gid",		opt_gid),
> +	fsparam_uid	("uid",		opt_uid),
> +	fsparam_gid	("gid",		opt_gid),
> =C2=A0	fsparam_u32	("part",	opt_part),
> =C2=A0	fsparam_u32	("session",	opt_session),
> =C2=A0	fsparam_string	("nls",		opt_nls),

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
