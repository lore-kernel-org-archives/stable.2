Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19040B367
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679853; cv=pass; b=n6ShdJ6us+68T9ZRmz3TwDacwNkj0m1/eHZxN5yTOq7scJtPrpkieVxpbW0MygoF1TnuR+fp9wGp40UmAS4++qJYwFujDGtohYYdNYLRhhIuRzlqXeKC1pViDAb/g5vyg7sW2KXdDUiRrvJQtFPhxcf1aXT+Q7LJD2VW/uYTL80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679853; c=relaxed/simple;
	bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pUBtueeYFk6Muixe/aYQSfrUCz5hyl2JNGoiVXwoPUaQEkjS4YQ0lgRhlbtW9KVOcXlQmP++3vo31xwUtAxBE/kcG4praEQJ+rYWYAKbhMVfty2todIMxIRaI4iHCNiKlFPm5xsOoPaj+IeM2YNUKX1lcnbRrT3zJg0ijO5dL3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnt3ZsV0; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnt3ZsV0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e771226b0so11302417b3.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783679850; cv=none;
        d=google.com; s=arc-20260327;
        b=HFJDEhiKq+N/+taCen4xVPsDeK+7HQLDxuGrvH4DWMQifIw4Ag2PjEIURPksDyQkFG
         qh0w+kkFRXhCf6zxgUFDZt3MZbk89s3j6QfAL0r1IvGWTz92SezvJkif1k7GsfBU12ZZ
         9owAQ1pq/FfJ9h9QJADipMm1Ji80aGVshV2WcY95XP72WLHHlrxllJe/Df6maXIlNWlF
         8eGcPW4QveiUAoO3BMu8TJ5GJoXfGWbnjWREedvIZynR3l7xU47jdD8cfxNBHu/q/gmo
         kFitUOQnPAwXa/yB2xS+TxACcBAEhiMeCiSy/dm6DXstZubzTsk1YyqMUpGCP36UzmEC
         r5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
        fh=RGs3bzzWTcmgd9o5cSnTZ0l+vx77LbQ9p/uPb9Uqoqc=;
        b=lJm0RmW0g79k0mxHonRZUBd+zQzs3R5bZ4Pa3vta5wMMldvb7H7ghDUuuqeFDeKdgl
         cNwjogK30nknnrhJ0fCmI94/eqEhsph9i2/9YxVuKTw0DuQ+7grdcI+HYNcyY3g2PUTt
         SqPm1xtuBJqSzdKJdFvTjGAQXj8vOplkTAnHYuCvbkDQ3eZT+7xIY/0nxPiJaQGewJfr
         ILYIuowZrITfbYJJkSzN/bton0pqxgYv6C5cYTxLRJdQNKMdcNxmd1e5Xfp7EopOS3iv
         23Epo2X6ueKoHAR3mjmxnBvmpopTiH0+vG+RMQK/wmHPdN/vBD/d2XmWErodyGH2osQ5
         aOTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679850; x=1784284650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
        b=Wnt3ZsV0k0q/s96jYmc5AYt/Es1Q4i+EAM1TnM3T+cFftI3HMb25mIt9+Kzfyebv9p
         OuFKzFSJBy/oinJ+b/sw9EHVcPoWCtIgjXoRDlaUA0sCxxVJGGELTV5QE3tA9Hl2fD/0
         c1swxRsQQQsP0DTkHSJQ/eFt/pN2iCPVeSuwmfXIN83NmIjHmgeCmGjNgsOOQhs9ykOG
         l4Lc4O9lPA60EZlmg1gbr60Ub1vk2rN0//hiDl3ql9MpczaHBGhSRt+aFAcrejoRx++R
         4NMyl10gl+XJM+/swfb9GCmKRgMalfqlI31RKNm0T4BQI1+QKrryg9eLW5wuM4qM3v9H
         9y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679850; x=1784284650;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JCCK/TG0jvCYWzkXuH2FOsoNpOIN0Oi1w32Ig5m1gU=;
        b=azsb6Q6hnz+dBQVvsHblx1ILtMEJfngQknBsZ3A+pLHG+06ptMYyxBujcJCAoP7z8G
         jNSI2BY7Kat3OA6r85hnwMxoWPnNfGCh0aEhcgTbSPHR83VqDvFeR8LAF+5vkNV0AH2B
         AH/4vtOeXtDsAp1YiOiDYnS6GD6pe7mE3FxHxXNxuA84fZc8liKIM1ZAO+z6JxgWc1Ob
         9KGwghl6sY4KYg5C4Fkj+Zp1XWWLWah2nlQYQLiO3pe5JcSdnH71mggAdC+AP33m5CO6
         rl/DvgxxGHF7xCdYQqy0ug32M4F4SwFLWIcVBj2AE6CdKmk878rkAWXVEa6hEIPfjO/E
         /XhA==
X-Forwarded-Encrypted: i=1; AHgh+RoD8gVd9paDLJzg2r2Lj/r320hn9LYNnXuV7S0rG8mEaMuxcFxxhkcKRx1e1Ey5m26acFQmg9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IeitksSaqAcFFV5h2YS8GhwqebzmRj/NZ74GA4iMcdU4F9rc
	GDKyhbMaqp1iahpJcBRwJnud1+/BPs5b4UcXq+qHnvyq84Gc/RCZVsoZBOSBlp7fBsUDZJrCNH2
	FDb/jzy8DxetNy1QmrdzpljbO7cENLWw=
X-Gm-Gg: AfdE7cl+wyJzLyPKPUoan8sazRlvX+Z79MLmA7Nqt557Jqa6dV+atjZhcqiHEQwe3Th
	3f2ryTuu+lThsd7OYs878wPrbhM0LrWrJP3cezIVwF8hxNt/itwRwFlj8R2GlJoGi55MzxH8Gui
	pzVsg5h4Ro9vg/vHIYgJ3xbnQcXzRVmGQXwpjbYeksbKmLvprDfR5vYG3BL4If6gyAgJ+uada1T
	xTZr6v6z/HOxpknr43S+pxZu0LZ2DdJOaTDy4txc0KjUkN7vYPieUrw1RHfVTUUwP0o8T6j5yKz
	ZEQNjwuGavH5V7w0TA66CJdPXg==
X-Received: by 2002:a05:690c:e0a:b0:80c:85b6:75b9 with SMTP id
 00721157ae682-81dbf56ec3dmr90488607b3.66.1783679849851; Fri, 10 Jul 2026
 03:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710023036.3745254-1-michael.bommarito@gmail.com> <alBcDlPeV8IPEngL@debian>
In-Reply-To: <alBcDlPeV8IPEngL@debian>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 10 Jul 2026 06:37:17 -0400
X-Gm-Features: AUfX_mxE85m0PgKq6exSlea8kQElVFjkZ94OrrDgW-o3O-BKH0z00Einlr7_ibU
Message-ID: <CAJJ9bXyTZRNUzSy5Y10zbx+1LyLguobgGm7FdGPO0foSzunLpw@mail.gmail.com>
Subject: Re: [PATCH] erofs: cap LZMA stream pool size
To: Michael Bommarito <michael.bommarito@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:42=E2=80=AFPM Gao Xiang <xiang@kernel.org> wrote:
> like CONFIG_EROFS_FS_LZMA_MAX_STREAMS, since I assume there is
> the different setting between the embedded systems and servers.

That sounds like a much nicer solution.

Do you want to wait for any other feedback, or should I send a v2 with
that approach, and if so, what do you want for the default value?

Thanks,
Mike
