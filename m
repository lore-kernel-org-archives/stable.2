Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EFF24DCF6
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948146; cv=none; b=hiOeuingOEAEVSrLZtHRl0dVdC6SjkwZhzcR1BBFsEtTUi/eTTNrx41lJjw6ieFENW9V1muZSVriTbrFhzg2LlMt3gZE1z9PXrmLSgYUJzTry/37jc+OPw5GF625FgeuwOZ8YK2A1/BS5Xr/JbIF7pVj2F9sEKytKty0lsl1N8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948146; c=relaxed/simple;
	bh=lMQmMsI6NESUnC9Kx4umf7FdQATWdGD+CG9btCbCLUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gO3SEKQ0fqt6Eyx5katHR4aEDR0J2XRybUujlS2q7n9c4wnEySmAnqlidsIoyTHqpuHWdmtjIxYuVg2UXLIJBGpdtSitYnissw4nWporiTAh4DIbOhlNlDA2ciwx8EO/b4WO5ql21NJMoPeUoL/fNHKljUAd6BM5qb4RiLwV7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=H6RYja6H; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="H6RYja6H"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-85845398586so21363167b3.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787948144; x=1788552944; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NvI2H7PobHESDZp6R8jIuA+Sv8hMFNQgqwyCoicMNzw=;
        b=H6RYja6H817J7kjArgpvFRu1hEKaxZiAiNsHsg8rVp9CbYeF4VIiO7B+jk9lCxb8gS
         ooBZmrM0sr2/iBb7if+9X3IPxrDnow4Nalx+vQ2vElAfTb6NOR2lTjJSCEGvhqk/MOM6
         Nk78QsAQXaH1bxifR5u4m+cjWk5MSwrE5ctlXd7gssmUpgyJi6mwcwrSP/MNWHCgXXZR
         BT9uxSax7/kuIx9iG86KI9QP7j90riyS9j2HwkO/Dt5IuoaDND3C/Z0B+15rrUU0okra
         ETMs4drbGX/HyFb0n50wC4lurktOIP2UHq85n1zJtUD/lTwuvIIKcRkNEQDBF8QHvBdh
         vhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787948144; x=1788552944;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NvI2H7PobHESDZp6R8jIuA+Sv8hMFNQgqwyCoicMNzw=;
        b=OMPuPAOOrvftoLMlUs5T1bMz40px/0jDaSWCLXaO8vrlDz6DF//JK6VhtZ5Bj9enVR
         lNdHZvpAKIdb7Qmt0GuaPF68WSaB04ehMVpTw1hgA5ml2OPe/DaKyuuAI8euSix5S0x4
         UvTqfhgE/5nHHoxBPBYRJlNyR30wtwqRNNcyeq7i7g9Qe15lpUWoiZAWZ6JnWFQXneto
         t/x4NQ+1POTU3//3XxmWl7HI8ARgVvulG2jX6U4fjBpc/bPFfvvQDQDL6PgVqklw25KY
         hSkU0lhiiZ6GG1ma8dJs8t+DjfVKJBGITJ+mEVhQ2O9BajltWxq5XIxszoAl2VsqsJ7t
         52lQ==
X-Forwarded-Encrypted: i=1; AKwUvBxW7JMG+hzUTM5gBfFDAiZ2g8CCFGvEjnSiHZ7ZjcpqUtcbhvzLb7mt/5SVauR37YE4WltMDjA=@vger.kernel.org
X-Gm-Message-State: AFuF++kudrJg4n9UF/cL0OxWSje8vWFfT7vgbGfH9LRCCd9A4oWJqniL
	qylyLJTzWaSLqJCXE89ElDmYRslHDpdnMV4nGn08z+SuLb1SBAQpbg0HrYVR/pyCjO4=
X-Gm-Gg: AYBFou3J2Mzt6oEAhCPIC1Xb0vZp3BzU8s9YeYPtcpe1X4PgxMvt9HAEvmThlzbpTSM
	wAD4CWWcbHODk1xJ3pJIN2R5lguZymskqL6pwgTC5k/QKHeK5s36PY53D/7hHbBhg/PxpJ6Q703
	j895BrxXOKHViRc7rjBtY4IY/ETnTzCRcwdv21oGTNa6nqkLVwkbUfFstBWUggbb5RA+HSf1pbB
	HUWSYXwo2R0alVqKIaVzT8lGSbUpSGGaEzftd0gf1cypJdFNbEUuQ8i5Key88og70zCHi7Tlre/
	sJxk5E8mEaIGwT1HNZZo7RYZ7suROX03IvObZww8TyEYENZOvo3beCtdEfVjb3X4r20+X5KDuGn
	A7G4LKrxon625CSUpbwcfVej7zoxi96zRWnnxYvUw+gJXv5fSaI25fexiB0VNht9FVY8HLSR/xm
	Ma/2rTITZ2dUam0gem29ORG5N40QQbiTesPrIjkcVH4mN7RopWf6ivOFehMAm5FaQvo3nwL+bmD
	lgODAB73lLE598hWnXDK/YVfoyuGAppXMNsx3/+fzo/DLv2yqsV6CV8YBBW58a06slAGayZa87T
	mf1oS469xWe5bs7oAA==
X-Received: by 2002:a05:690c:a1cd:b0:85a:634:169f with SMTP id 00721157ae682-85d6d4a8561mr34088607b3.28.1787948143021;
        Fri, 28 Aug 2026 13:15:43 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:ea83:524e:5ab7:94d1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5e180b20sm11971547b3.3.2026.08.28.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:15:42 -0700 (PDT)
Message-ID: <14ac44cb09ba3a7f22f14fb4d5c6818d235c0297.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix truncated xattr names in listxattr()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: maurycy@maurycy.com, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, Kees Cook
	 <kees@kernel.org>, Justin Stitt <justinstitt@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 28 Aug 2026 13:15:36 -0700
In-Reply-To: <20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com>
References: <20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-28 at 15:38 +0200, Maurycy Pawlowski-Wieronski via B4
Relay wrote:
> From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
>=20
> Commit 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use
> strncpy")
> changed copy_name() to build names in the osx. namespace with
> scnprintf().
>=20
> The supplied buffer size includes room for the prefix and the name,
> but
> not for the terminating NUL:
>=20
> =C2=A0 $ python3 -c "import os; print(os.listxattr('/mnt/tm/.DS_Store'))"
> =C2=A0 ['osx.com.apple.FinderInf']
>=20
> The truncated names cannot be passed back to getxattr(), so getfattr
> -d,
> rsync -X, cp --preserve=3Dxattr and tar --xattrs etc. seem to lose all
> Apple attributes on hfsplus volumes.
>=20
> Names in other namespaces go through the strscpy() branch, which
> already
> sizes the buffer correctly. That's `why xfstests generic/377 does not
> catch it.

Do you mean that you can reproduce some issue for generic/377? I don't
see any issues with this test-case.

>=20
> Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use
> strncpy")
> Cc: stable@vger.kernel.org=C2=A0# v6.10+
> Signed-off-by: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
> ---
> =C2=A0fs/hfsplus/xattr.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 21a1c196c71f..4a3c97373682 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -515,8 +515,8 @@ static ssize_t copy_name(char *buffer, const char
> *xattr_name, size_t name_len)
> =C2=A0	memset(buffer, 0, name_len);
> =C2=A0
> =C2=A0	if (!is_known_namespace(xattr_name)) {
> -		len =3D scnprintf(buffer, name_len +
> XATTR_MAC_OSX_PREFIX_LEN,
> -				 "%s%s", XATTR_MAC_OSX_PREFIX,
> xattr_name);
> +		len =3D scnprintf(buffer, name_len +
> XATTR_MAC_OSX_PREFIX_LEN + 1,
> +				"%s%s", XATTR_MAC_OSX_PREFIX,
> xattr_name);

I don't quite follow how this could solve anything. If we have enough
buffer size that was defined by caller, then this buffer should be
zeroed and NUL is already there. If we have not enough buffer size,
then we write out of available memory. Could you please explain your
fix? Have you tested the fix by running all xfstests?

Thanks,
Slava.

> =C2=A0	} else {
> =C2=A0		len =3D strscpy(buffer, xattr_name, name_len + 1);
> =C2=A0		if (len < 0) {
>=20
> ---
> base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
> change-id: 20260828-hfsplus-copy_name-fix-a6e2a0a4485e
>=20
> Best regards,
> --=C2=A0=20
> Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
>=20
