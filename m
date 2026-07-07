Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728FB41A76C
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430283; cv=pass; b=mVdSzW7VG7/tncvNrsfDkLnt5j6XbVC1C2oFyQK5K1N8c8znis+Cu7qsdGOrH5maszx7L6k8vbV4ygrlprsLweov824eNRIFMY8tRybJGaynR/1viyQxW9hgJIxWIjQcqKT1MeNhs86bAdZ4sLwu1T+CCfst49z4XyECZgTx7fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430283; c=relaxed/simple;
	bh=HcHtACwu8/iGQkr2r+eW84TtzcCN38sbtol1tFCcY9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqipQb7eQWiL3nUXxFZ06lScEqgtZ7jROF6+KOatMaYYm4Q0lb6DQDF3k4O5U5tFO2Ca23aKD0a4lIIBux/KDNwnrXsFvb5Noj69eA6Vd6H9d77ggErvSW2rS2O1YtR8njBJY3+vOAzBBS38Zq7SjHbShnSYA3qN0vhQGJz4m9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dttDZBAE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2Iiq2ss; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dttDZBAE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Iiq2ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783430281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+ucBQNKh2u8TygJUyr/SqZFCxEUaj4Cx7Z/tP8WgQ4=;
	b=dttDZBAE6iJ+B3LV0BG15B2F1Idp5gz7oUo9XX0AWCkyQZlko3y4unMd/IgW+bB2HMgYNF
	hwZFQaj1cuQFh43q8yBMAaYxamenmsxeJGNdUcWLxCbuTLASNfTv81kWhOmqZvY9R+jckN
	RMaVzbNwzMluOB1aZi2UUukVkjLPMVw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-dIX_Rp-9NTa3zDyZhPzLsg-1; Tue, 07 Jul 2026 09:18:00 -0400
X-MC-Unique: dIX_Rp-9NTa3zDyZhPzLsg-1
X-Mimecast-MFC-AGG-ID: dIX_Rp-9NTa3zDyZhPzLsg_1783430279
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-48f680bda84so1913330b6e.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 06:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783430279; cv=none;
        d=google.com; s=arc-20260327;
        b=TRJ2tIMbR67DFxSkVDIW0k7XDY/TXQaXqUWPbNo/d3a0XVsWb8YvabfpML5DZNq9n0
         M1XRtmDNhUXXf1W3HgIkrBL9sAZS9bRltibPxYsNxpvAS2UriT2EeU0KVwvb1hp4vP38
         OlZVrIx8Wzq4qtU9qIQ9jyA0NjZ5w+dIMtJG7nI1W5/O5qbNC9B51VXCDPusfu+ifpKD
         3waVFR4ztKSVPHC4inddQy+TQPKgS6FKVpKq+dnvipWulvIMv1pGv+bvSFnho2j77Ghv
         DoPcIG1pCEj0aMCCJfiN6v6KE4QxYvHIXoeBUJCGHIHQUkrpRio8E8vcmcv94A+qqn4/
         67aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+ucBQNKh2u8TygJUyr/SqZFCxEUaj4Cx7Z/tP8WgQ4=;
        fh=Nr30+KqeA46EooJTRX9vPAQ8z9V6EbB7xQzrkJFUp3E=;
        b=rwwsGk/aG1iCa0dozFgKBCVc86YgPc7/c+3YPURYN6VUG4+5B7RWqgSLOzXNubcoI9
         IIbKI2yxB4089mjBV0Ews9n/B1AubQiSHQ/EPgcfak6vPKkSMediZob3V+Q48RNQWAOp
         Ng7RkkubJKJxmI1R7bu0aOTkK+spW2zHB/2a8tcI5PchV5rlmwfDd9xzK2jwh1u/usHH
         T9pgS9ozeEDp+XjL98MpT3/QDm9UDVTVcIfAxPOqS88/IOTSSGeavUgQp4WloxWQTRUW
         SIvrbdGFwDRF0jjw3HeOjE2SUAgOyJI2jS3XfePpbs6J3FbotqNKF6Dvi6onGLb6d72t
         H/SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783430279; x=1784035079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+ucBQNKh2u8TygJUyr/SqZFCxEUaj4Cx7Z/tP8WgQ4=;
        b=h2Iiq2ssMJ0lDFibn+ASfPsKWo0+pJevwyB3NgKJMuG3ExWF0//JcHC4TezJbjNE+P
         AopTMKa0wfRZp1+KIXGsKHUXgbxmMfAf0GOlCCH3bcpBF5xkW7qKDLSP2J1hKrO/o1Hd
         rYZu/DXpHypWQcKK1bMXarDjBJGAyR56Fr89r9wIQVkod6YE4UjkBZPT0DL4hzxtBQ4n
         tlfZJ+UVHCV9HHU64SEN1USqMYqdygLTKukNd1CqYwh+pHGJ2CZsAEIxY0rf7tQ681sl
         ZBHnszBX24gr/nFoLSqyFsGFFTTSnHEPRz7ia20MIYCShLZJFAk7PxszNiw3g0zBGx/2
         GeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430279; x=1784035079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+ucBQNKh2u8TygJUyr/SqZFCxEUaj4Cx7Z/tP8WgQ4=;
        b=dNgqIn64KfMRU2tMyHY3fkI9zzErvyOSR5VonWdv5Et8j+m9DVmbnzYRHpdVV08SCh
         uKyq1Ygtu5A5PZAEJeAEu7y0Nv9oFuNecmLqKn210g435HgX4scuGEN2QHroFHvB3DD5
         1LiwBxV7ubwSGxxZkFHx8lUqJZ8BPWFMwk1h7xrhq2VYQwXIZE/y/0UQ2kyFFDT2/EHY
         syesoYH/Mvoyjh5CgDfb+C9IeNWfQQi6hTnDJe1G4nTYYlqnJ3860+j3X3Dr4/zHyrgB
         J1rEvrpv6zGFITectyGPx6aI14AJlHP0yx5tydS+TvOJQgX5VDR46LdPW2LNk781HxH1
         lplQ==
X-Forwarded-Encrypted: i=1; AFNElJ9A/2klNOevrfYL4znXkSWRraMQ3R++x6BWnXrVGQZshLNXzG9hOROKIdCJt3sUrNAiJSUOxAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/patW/BsfhJvp7jTRWT3PKNDe1VZYJUrWWmwTBVBKgba7jFz9
	V0z6LGU+3ZPSUsgPz6jJuUYnsFjfUjA6saIj1dB4GEaDYg8PPAMzqJwPiYQK00ECeM18/Uj9jVv
	8MB3RQlPIhjCa0aXxk0BNww3wzaT5w9YYJC3J6uY+Ax+D85ZCVBqsQmsqw9vNLi6Rl4IweC9TvM
	XeLIiKFpKF0OXJqUyvf78fQRi5h9MNHUbp
X-Gm-Gg: AfdE7clGdkF1jmJzm0O/3HAGJvifDttHJMznl3l4S6gkwuJjBJWQwUGWtMkx6v58T4T
	+eXbP/T6bMJs23k8Xa4gRUp8QuaVwKc3951yLpuDMvN2oDjVwGk/FrYzWrhXoetkNz7OuAph8A3
	uMRuczErbX1nUJhEFjBcuREKJ5gT9N/K+IoGFSUrSxt7Bp3+SHPdG0oEFlzZmWWhz42kw=
X-Received: by 2002:a05:6808:4701:b0:495:effa:f06e with SMTP id 5614622812f47-49fdf307c8cmr4281338b6e.42.1783430279235;
        Tue, 07 Jul 2026 06:17:59 -0700 (PDT)
X-Received: by 2002:a05:6808:4701:b0:495:effa:f06e with SMTP id
 5614622812f47-49fdf307c8cmr4281307b6e.42.1783430278702; Tue, 07 Jul 2026
 06:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707125837.57256-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260707125837.57256-1-bartosz.golaszewski@oss.qualcomm.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 7 Jul 2026 15:17:47 +0200
X-Gm-Features: AVVi8CcyzJYF53EZRdJRAa2OjT7bI6MDT1HI0t6HzQ3B3Epg4HnpwPsiwafwkSc
Message-ID: <CADSE00JrbEXXczJUwT8Lpn4MkMdSjcHWOsX+7F1Z_hkzjMos0Q@mail.gmail.com>
Subject: Re: [PATCH] bug: fix warning suppressions with kunit built as module
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kees Cook <kees@kernel.org>, Alessandro Carminati <acarmina@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 2:58=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> CONFIG_KUNIT is a tristate symbol but the warning suppression code in
> lib/bug.c is only built if it's built-in. Use IS_ENABLE(CONFIG_KUNIT) to
> enable it for a loadable kunit module as well. When using a plain #ifdef,
> the suppressions only work if kunit is built-in.
>
> Cc: stable@vger.kernel.org
> Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning bac=
ktraces")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  lib/bug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bug.c b/lib/bug.c
> index 292420f45811..b9820a0226f5 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -219,7 +219,7 @@ static enum bug_trap_type __report_bug(struct bug_ent=
ry *bug, unsigned long buga
>         no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
>         has_args =3D bug->flags & BUGFLAG_ARGS;
>
> -#ifdef CONFIG_KUNIT
> +#if IS_ENABLED(CONFIG_KUNIT)

Hello Bartosz,

Thanks for the fix! While it is correct, I think we could just drop
the guard completely. kunit_is_suppressed_warning() already has a
correct stub in the #else branch of include/kunit/test-bug.h when
CONFIG_KUNIT is not enabled:

    static inline bool kunit_is_suppressed_warning(bool count) { return fal=
se; }

With it, the check in lib/bug.c is redundant.

BR,
Albert

>         /*
>          * Before the once logic so suppressed warnings do not consume
>          * the single-fire budget of WARN_ON_ONCE().
> --
> 2.47.3
>

