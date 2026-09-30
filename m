Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529551B196
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793539; cv=pass; b=ob66Wgd+ujqPVNANJPNe/3xcYKxdYMCGIqoKSOByMWeJfVY4T5xAexr5ObEb2hkqroC44lCMFeHzRJ9ljAZkGZslYkC2hIHMxsgk8gXiBZc6Rg6VTz5yiXLWwBO4glKfX88ZtUy4aVRpMGLJl1ub2GTupoyrHO76w1CQ04vz1oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793539; c=relaxed/simple;
	bh=NHeV94WugdmVD28bFMrZnAa3jDv81zue6/05rbrEI3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpFUGEzP0g6VmOl4rnapwcCfZWE28BKznLLsMYneIG4c8xtlZPKDgGYEQWeAZRMQ1/9HLXyY8JvopbmzOflxp70Xkm5gMtQvBPFQZ09DxCXlLfNSeDvQJvuCXajOzwmlxFEi3Yl9Qynj7m2+LJu9JDWa33bRVKG7+bJjkMZgx68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAg/Modx; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAg/Modx"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e27d11f43so51395266b.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790793536; cv=none;
        d=google.com; s=arc-20260327;
        b=VnlOslNLitpXh/sRDnL7Y9gXNUzEgFyO2Wn54zlN+d6SvOEkjYAthTfk+UId+0yD4Q
         RP9MmFDYxRcDuYvUodcAJtp5fx+OM2OvoD8UtSOsIkITqiwW/pdXceXEkikuW169TqzX
         UgAliizUSz2PnuJgpHpXYZLYu4eOZsgkLE3vC18RHaP27O89zvA5+35X26vtv8b+OS0S
         3Ki6XIiXTs20XQRCtCq0db3FiYBMAgP8P2oH82f0St+qBcBazcWIVaJvvWLlsyGKZ9lE
         IZV7l0EkcSNSGybUShkVC1erMxnyA9dAvaO2tw07jjePX0a0LAijUX2uz52pT2euLCVx
         Eu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HI0jJLmE0KCx7SJ67izympvHFVqsl1F6acyVdnNn58o=;
        fh=Rs0zqvOI/8PXJGmhX7lkeqjgK0qWN0YmBAn3H18/7bU=;
        b=kiph97MKp3EhmNWNXJOv8mHgLNedS5ybWnYeb3/pUjgw5VVz7b+V9+A5/CfGmsKlZt
         lIJNoGwdWGBbJ594PKZhZb1+sXbvZMmGufaD307X8eWmzSr211iBDEtRiLt3Y5L5bUph
         n0C82dPGUyxw8pYNMdcyUwSzIz8jcYKlbtOKizO+sbFZPGQr4DmqW78apDDMdE2rVhDU
         2czFKQIkGP1wL4CwoZzKvsbYYbS/EGesUr+pDnOwVfFl6wGD2Y5zwvXnh8f1hC40dJms
         kQ3t9eqzEE7IbZf+ksa4kr3FGtXW8z77eU9rbl6OM7yZD2frzvMW0E9/xwI5iL2DM8CD
         zphA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793536; x=1791398336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HI0jJLmE0KCx7SJ67izympvHFVqsl1F6acyVdnNn58o=;
        b=bAg/Modxf0k68QX6jyn9V1xldXMPhone3+S4H+AL7uQ5fGFBfBTgxPg6jB0TdTVlNr
         yaSRPnUOzciQ1ttDaEuZ9RM9CW1pdWk4LyfxMAkFu/9vcbgXH9KqEYfGpkwdZoDA2wxi
         Smxa4Td2TO/TaAnVPCA14donfWy+bDTIyGlVA/CfYL8SOpercVLRoeYGCeiOw86V30eq
         U+L+ZiRXcx0IWFfIaIDiflAXQ8UKuL6o0+4ohEsu9UpqKK3agiiZHJC5E+32usS0Kh4u
         JGl5p7UVkwD4g/QLixUina1vv/1iFtDm7rosEc+I9GXqhTRK3CAPigIiTb/xrx0bObNm
         ptYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793536; x=1791398336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HI0jJLmE0KCx7SJ67izympvHFVqsl1F6acyVdnNn58o=;
        b=vBbwc/JeCf/gqwCIBC9Hs0MyIqwznL1zTblyXp04sKuK3cLVsZhw9aRT4Uftl9mj8Q
         YmjYLW3wrTRxhnFPMM8QHXHXS5vfDfFgiPgRe1KPwZ0G9BId7GSTC0F4kVegTRXtmloV
         8uCn50Q3jDWFC+Usmvq5laaeJ8J8yJGVn5e0Ln6j9n63CRYFzxCX7e/Xr+924ZP2Q1Qv
         kVsrdaQnpMHSienef6cIdHJilMZt0GMa8j4ErXFx3UBWm3ByVGhqyd19fb2PKI8jIosC
         utSPHJoSQPcbx6rNMkKfGTfTIjVFiWT1l6Hmn+88JJ+Q19RB0lvIoKLUt+pAnfZd2UzR
         TEUg==
X-Forwarded-Encrypted: i=1; AKwUvBx7TCMwRQKspVDHsWtUE87JTMJEqGTV+qLD3NaVmBBaGRirMX8LIFuENtJtIs9Fbk8WNoNHRPU=@vger.kernel.org
X-Gm-Message-State: AFuF++my7YFXSOlzPW3uQ18JGrSyYW2rIC1st074oP5ZFg7JSii1TZH5
	9hjwUDXPlEWIvBYiqkp+Et0zLDS81TOl8TktTR+QNIXs/wTe76Oc30VN5mLCpvXR96zPYVW0k5t
	l0cqXgko1fKomiQsKSdLuWB6ci6jp9z4=
X-Gm-Gg: AYBFou0JBjY/DZklVKhMioruyww3pnnNXxRH9k1G7GVFoc6kehjE++AkQIfhO4TS+FF
	k3Yc8zWOBAeP5wHII6BkswsCULisK9VZbP1/ciOI919IJNAXr+OM++KUm4BGwzdBU0TIZuTxGwX
	kQJQndADOGgjjDvee7XZj2Fj2M1FSVYIlMLHAULZYuPDpr7Mc20afAz0rXGViq1pwVmgazbOBZh
	l/mOEmbAADtU66G82EHGXs3AYSELg8J4I9n4v4ktV4VS8ddiDw7S4OV6hwM/x942lxfbQDR4JeG
	sBTDuKNIRPxF4OxvHwGPPfY0ekkdpNVrNRL7Dda5zIVZFCkfuWILx5q3Wq6bMezW4czfdpMKSX6
	P95CKaMgEnM+QSfaUsqkZhl68UqiLLgaLPW6HEDQ=
X-Received: by 2002:a17:906:f583:b0:c2d:c57e:fab5 with SMTP id
 a640c23a62f3a-c2e33cec3c6mr41556566b.7.1790793536002; Wed, 30 Sep 2026
 11:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930183018.49629-1-meatuni001@gmail.com>
In-Reply-To: <20260930183018.49629-1-meatuni001@gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 30 Sep 2026 23:38:44 +0500
X-Gm-Features: AclHuK9lQpT-wa7Q6XhMKeuCXwZ9qOLPqpfv3FTdw2GVk1xkzBB_NuWLafKSDzQ
Message-ID: <CADqcGB=tjzMS4xP8yDQrO5hKyoq0n=wDJNTBohdnDErDwK4gBg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] platform/x86: hp-bioscfg: string buffer and
 password fixes
To: jorge.lopez2@hp.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Please Ignore this patch series, as I noticed an issue.

I will send a fixed v4 shortly.

On Wed, Sep 30, 2026 at 11:31=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> Fix string parsing in hp_get_string_from_buffer() and make over-length
> password writes fail.
>
> Changes in v3:
>  - Drop Suggested-by: Andy Shevchenko from patch 2, tidy its includes
>    and declarations (Andy)
>  - Return -E2BIG instead of -ERANGE in patch 3 (Andy)
>  - Drop a blank line in the declarations in patch 1 (Andy)
>
> Changes in v2:
>  - Split the hp_get_string_from_buffer() fix in two (Ilpo)
>  - Drop the lib/string_helpers patch, use @only of string_escape_mem()
>    instead (Andy)
>  - Add patch 3
>
> Muhammad Bilal (3):
>   platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
>   platform/x86: hp-bioscfg: fix non-ASCII truncation in
>     hp_get_string_from_buffer()
>   platform/x86: hp-bioscfg: return -E2BIG from validate_password_input()
>
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 79 ++++++-------------
>  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  |  7 +-
>  2 files changed, 28 insertions(+), 58 deletions(-)
>
> --
> 2.43.0
>
