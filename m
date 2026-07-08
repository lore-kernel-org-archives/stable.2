Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25D38757B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504854; cv=pass; b=XB2GDs/LoMMUu6LqnYuep2MYp0B4brSmBDTyvAa9aCY5Z1VA4QCqgs1eYG+urZhMyWnIiXDLLuTMdG+l+CbN/5Dv4WvNkPoMAuF42QqSndSGJ5yYhbagDCTAohSr7fSIJ296wmWTrhMGGVYK+n4VjPyyTE4hpINifxVC89BsQYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504854; c=relaxed/simple;
	bh=zMb4vGxKg5zXPjuNFFDp0IQHLFIs00h4Ggo7w7Y/6K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ3r718QTR5M5q0r691jvTtf2kULg3zUaVSWkYvU1S9rdcAzGpkSCLYDyS/PoA/30nbthBehDypwjA2nUsaJ+sSP9IwbIJp9fvUBdwI58vKS6R+PopzimdN84Ck8kRSLH/cshXzaep+h/iZgFfQgb4kfAf6TAjdqH4T+RddsKmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQpU+uQX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/duXRwU; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQpU+uQX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/duXRwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783504852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yE7SABVDqZevBVFAhiLXSdt8sJh3auncorNJpdn2UKg=;
	b=OQpU+uQXZAeU6KMN5D8P3eKyf5sMKBdZEc5E0F6/jeqQK3McVYrmJODNvF8NDIjoOZG08E
	rfMCvjMm+iQn/E/U1EDqfurN0U23W1Qtkq6gEMl/E6i2jutjbHgsPi2H17KT7b2auEb7JC
	yuIdlfIKfOKrSpRg+p1EKNIFaDFTZ4E=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-CSYrQhu3NIyVnYda1uAIVA-1; Wed, 08 Jul 2026 06:00:50 -0400
X-MC-Unique: CSYrQhu3NIyVnYda1uAIVA-1
X-Mimecast-MFC-AGG-ID: CSYrQhu3NIyVnYda1uAIVA_1783504850
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-80a11e0ffc2so19797157b3.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 03:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783504850; cv=none;
        d=google.com; s=arc-20260327;
        b=Alj4p5bRvBs96j3tSoYMdYKHPIafpI7tNW31jIjyNMOb0V+vkRmRvmru1Qr2p+imJd
         21pm3JvztYsg3ngH4+Dn2VuyVRu+HVvdP0YdzDHoq2SOS0NDJtrlrSyfJZzpYJRLGDu3
         jDIbRwhOAplvdP7Rpqge/oPHlVlFCe6xSnRh09V8hlgIfGCEtI4lDezhqtwhmSGLq8es
         i4tP+IP56fI+cQzXqUX6FKahkQ9v2C04vemuZK7SSFAdRVnMnG2tnRvbjEqAbV0bBWW7
         0FD5oM1fgWRLTDIOyoEx7jAvMVtMKW/DK7sNqccJvDmB+lJ3HZsIYdAaG954Bt/Ng/7z
         2FUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yE7SABVDqZevBVFAhiLXSdt8sJh3auncorNJpdn2UKg=;
        fh=QZsSAyNxcYz0zQE0mVbFhb6CpgWqeTef6z1iG2P2FdY=;
        b=S1TzXGFbcOjd/H9yEva3l01M8UWNchX0cCFCLzNDB4nkSy1sWNj7qfYeuMOVsJyoxJ
         MtB8iVKRBnyeGEld4EGrEZ9Xepvh0wPOWE6iKgNLSvZ/20LfFvuXHwwfy10m8Z6Co9du
         nSfMUruZxPVt5bZ7vn2DBHOU4epACsF2DCi02pRzX+wo8T8j73uNIxK3KY7Zvam+ZD6+
         hTr9bKHLTq7hfOHOV9sOkRW797fD1bgaks5kAiNos3FIwoYa+qi9JOvZCmFlUUA0vwAm
         b0eTBXa54HyAPJMgJcFf25lxQPHWKqCtm2xGhVLOWIahx8waespcJ9G5D+9YHIHBJ2zv
         RqNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783504850; x=1784109650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yE7SABVDqZevBVFAhiLXSdt8sJh3auncorNJpdn2UKg=;
        b=I/duXRwUdUkeaMJKZBTpJ4n2NG7T+DceBmmAIc65qRP6SLGiVIc7cYWgHnoCfI7ZIR
         CUNbAsZtXDsXw9Wykq01TMAK1Lmj/n++tcNWoH6AtUvJ9ATHSmTOvxTMgCHGVBTPICx2
         A7YKixdQXmGp2o3YWL4nZQX3i9DBFNF/AQcwraQKfwSnCodsao5dc9uuNVTVJU8azSlt
         ILlLfIpbDo3TKKIRUFZicGMnCb9tXtLDDA4honz2ZGDDj2JKW1bvPL5UBKbgPFWF5Z+R
         T8vfzzGpQLL0SRabtdqvSkQkj743mwR/9l95y9YriQNeZ2KHliKCvCRw9K7lcY9FUkwo
         nDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783504850; x=1784109650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yE7SABVDqZevBVFAhiLXSdt8sJh3auncorNJpdn2UKg=;
        b=XrTNvMo9xZoYvGoXOMjo8LFtWUm1BLOObP95hypMIXZLy0HdLCIl60CQhKLUJvbe9g
         eVM60mCr7ilav+etaUd6/EeLiHRL0P0CI44p6gop//aQ3Qsjz1/64SBYhrnKq/ABdmIY
         4ljAHRyaMqYrmMkLplPNIMPgU0C9Snpixp8owxWCuLFJHwSrar/J9Sby4QadkFtrN2mB
         uVjXDIW7DLBuWhorKOuHWe7Qs4ChcASqnoPO/U+wkInyPuEyWz90apBf1NEXTPk4ApOU
         FaO1inFNuQ1shbefb6uPaD7pHqw0y7OoD70eeRj6LeKEGFgSp9yIc4fL+OL8DRuu/2ug
         eFkA==
X-Forwarded-Encrypted: i=1; AHgh+RpFyWDmZsx/6inWeIm949Je0+sXxMMHlglWnwBFAmGOv6sV32lYN1QMUqYigc4OldCbvgHhTGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYUtKh8jlzyzG7mT+kbLyoFX4Y/mtuRvKLQFnP5fxsuvNlyGa
	ocNybHjfbfze1kLisDrcrCy51ZMf5og9g/gN5SUaPuLbwoZ+AfNX6aeQFHmlit6+MReUsduIExu
	r8WRUD7lRvVZlcRkXSn3h+c+idXTQmS4KK8/lRI5wxiqJ+sPyaSTk8webFEgEUYEoG0XRkxdO79
	+XByUt1e2bSHPofnb17kLk8zDkWkQcIPKw
X-Gm-Gg: AfdE7cl1eaOEpVMUWYriJ1xJ/iuNf3Nvj/bxOaE598y22C7g8rMGDztbpMDSF/3URBv
	Dg6ehJ1z5/lGWaua3+RLWRD/99NPfptRPV24dbhWlys/yexKo464PwySOizonLiDgYK2/lubX9v
	RaXoQIvlhGUvFgzywVGy6wZfYNjemssbkohTh0FQXgwx1O+SWNvx/Yox/2udALdH4eP9Q=
X-Received: by 2002:a05:690c:e14e:b0:7e9:ea36:f256 with SMTP id 00721157ae682-81c5e30d111mr44250537b3.17.1783504850115;
        Wed, 08 Jul 2026 03:00:50 -0700 (PDT)
X-Received: by 2002:a05:690c:e14e:b0:7e9:ea36:f256 with SMTP id
 00721157ae682-81c5e30d111mr44249947b3.17.1783504849163; Wed, 08 Jul 2026
 03:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 8 Jul 2026 12:00:38 +0200
X-Gm-Features: AUfX_myplwdTWk12ZF-d1YhVEM7RbTmMzfkKP0RwsoDr62uWCGQBm8ctL06w_no
Message-ID: <CADSE00Kt0rnC6bOsLDodpfvpdUC=KBk7reJ=NC2wo_y7w4iNUg@mail.gmail.com>
Subject: Re: [PATCH v2] bug: fix warning suppressions with kunit built as module
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Kees Cook <kees@kernel.org>, Alessandro Carminati <acarmina@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 11:55=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> CONFIG_KUNIT is a tristate symbol but the warning suppression code in
> lib/bug.c is only built if it's built-in due to it using a plain #ifdef,
> rendering warning suppressions broken for kunit build as loadable module.
>
> kunit_is_suppressed_warning() already has a stub for when kunit is
> disabled so drop that guard entirely.
>
> Suggested-by: Albert Esteve <aesteve@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning bac=
ktraces")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Albert Esteve <aesteve@redhat.com>

Thanks!


> ---
> Changes in v2:
> - drop the guard entirely instead of switching to IS_ENABLED()
>
>  lib/bug.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/lib/bug.c b/lib/bug.c
> index 292420f45811..7c1c2c27f58e 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -219,14 +219,12 @@ static enum bug_trap_type __report_bug(struct bug_e=
ntry *bug, unsigned long buga
>         no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
>         has_args =3D bug->flags & BUGFLAG_ARGS;
>
> -#ifdef CONFIG_KUNIT
>         /*
>          * Before the once logic so suppressed warnings do not consume
>          * the single-fire budget of WARN_ON_ONCE().
>          */
>         if (warning && kunit_is_suppressed_warning(true))
>                 return BUG_TRAP_TYPE_WARN;
> -#endif
>
>         disable_trace_on_warning();
>
> --
> 2.47.3
>

