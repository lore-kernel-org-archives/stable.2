Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795862288;
	b=uXA2bpqy3yrDTtNDzJmXCIPflARguMdIN0XvDCUPJ74ujub9IwDqSk2bpR4jjqLhogMI
	 t7ZuRu50coINEBRVar55HmeT6IJVrBQtKKgsRZkK+8MbzisIlx4arVmtYlacoyyeWkY4d
	 Wa+UOmIZRhcTL7ILYPHGzvGBOq2uOo2Zs+RzoVo3ecdFQDgjoMH7k0RyCNYkbCfZv2vbj
	 zrp5w0WzYyNZA+9COYfO7yTKTPdSp5ZylYrDawXLV1Il8bShAPVnurFQaWTzQ6U5Eg1fS
	 Vh07RVHKEKywndGTQ0FRtCVcRA1Jm58EXSvK7XoCFftDNj/TEmsZbHuevQL6Gz0XzAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795862288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
	b=IOXoB9d7/y8zy959sJhW/vJJBWhY3rcIJicIupZm59dmLYF2HvMNHW0B7iOoccFqN15h
	 UoZligP0YU5dIJNx+UZ1kPpEyPMELyX31ucEux27N910y4LWHE7kuQn3HROliM25Nx5SK
	 bsALJr6TYa7idd8CJQ9lP9ChS5T1WxMsVp7xSBwkP4bcNqKlCo4EYSl57GwQbFuSHruH6
	 3GVbFHrKRhqV8hjwpnetBrzxpWGmd3PJd5S6Ftci3v8k55t5jupTlMgaqwIaD3afVJsBJ
	 Z1+0zV59cxSdyVNOPMDsCHiJEI8bPLBCQ+ZZjIs3wuNfP9G9IrzaGWrGV/PpBWzzFBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDwvR9BB;
	arc=fail smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4656606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4656606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDwvR9BB
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b10d24345dso80244127b3.3
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 02:38:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795862287; cv=none;
        d=google.com; s=arc-20260327;
        b=FVJaR51XLjJJztFWfYaeYIXyo5cPoxIB5vRKM7KS9jDUtJZQH+/LM5UHcIoaJM7IXG
         WahfJXc6PALnBq/vOWPD+x9X79GQRoTono+hi0QaYrZu5PN8dAYXkprwGFiBCznF7mYW
         L3ORVV9Y14azoiW/Ya4mNuNz79RBbBX2er+Uj5vawImRMPanXr7FhXtqJxaNE7E8OwV8
         AylxSccjGcQfeZtxfQ6ojov4XXpyposwKJRoT2HhCcjEB9HCGrb0pGU/vuIpOYHCFfJp
         KHdrqlYZXjKQUvpL+59QgcVoiklJW/S0VWt45q/+ngQ/jchAKxqAC2acRMDfpcXimY/3
         iolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
        fh=3GezOlOiRBwKv6IM8G9DYmV0Vam1lWFCvOYI1SqNmyE=;
        b=aW39dzckWSzvwWezbreMrpGGGUYJaG+PJaI+eNQgB1RdEf9LWJ1wbrJSCr4gml6ITy
         3Nz2SUwyN2yi2QzFRRBqSg+nd1Gbftb7qHUTuCx0mGIsQrzdZEZog4brUppt3jhEHYrQ
         C6oNOqDk5KedchUQoNUJ5jMwt+5Dd58FsU7nc/N4Yy2AnS1aI/e/7oVFBTZAP4ijSC+x
         ejy9DXJrkOgQZpjFwdSBoXW2Dl73SN8NANQEJrZE5f+28VaPppuwDgZCf+rcaOGMWcrH
         G59u0ivIZ3E9AQWdMZigMjiaeQ/QtOj54Ix3H52gAETmq1ABo+r2sk23O4nynHnFOb9X
         3Xdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795862287; x=1796467087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
        b=vDwvR9BBdpjQ3G8joaGDJRaUV5jS124HvjZGLj7uHk8NKri2VFFDC2exXnj6FYJlXC
         goC8qD9we1ivYYYQjQ7BoUbbJnOWTkoEsSFiEI4kxV2O8GjTTkV2IOr5PADmXWcIFKAz
         zbn8LsXtyYafRkO07aOMoORp3uxZU8xyDtOFRR07M6RVWLWasiJSah2QVcE0YMNkZJAS
         nDgAaqySwgTVCmjf6oGYMBdlMlJTFl7dYR+cv4LXk4Zqz97/7qRnb/dGKYK06bxJdmj8
         mFLAlw+EVv3mhauzIJb35S35NLzOmfjRcj9igT8N7+ujAqdntfnf6xIOOkCfcOUBFN9q
         U//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795862287; x=1796467087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwyHdZrIt37fPawafrGp2eMQQXYbv+RrBkeaiIqXtM8=;
        b=nq1M/bfBeStjhG2iZPr0ejWiKhVdzUhK2oAYl/8eUFcjtDk/52QEUSF3sD4doZLEoC
         Cqk7t/V8wkpttyT1ZVKy0U7MdE82CN8NLQ+5vBEiK2PPj6c6VQYN7Bn/sZXQl0PLwmEI
         vz4QDg1aENDkKirfWNSNcyLpRdlt/CjaYo73fOcyM/1TiC1rbraoxkRrGxgjvAkTpUK7
         dwBaBvz3puNJ/3mM1CP80Q8kF+vUi5tuj30cbqtYhZFpXqPSLm150iDCKBT0vD3/6IG3
         xdcqtGd34jFqQbLbRThYPbm3D/JReMKs8F70/H6vfnxqN7UbmtIQnyL24gD151ohtHsn
         M8qg==
X-Forwarded-Encrypted: i=1; AL+hErFnNMahLnsRfWUQrnwDlYvtoFSxJqR7z12EK1StBuxxvvo1kHn7tWskIn/IwHYYjzDLhlAfs0Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UXHdYfRiqdzAEpapBteEQIFmOS7wI7yYuOJN5M61AjcYAXPaG
	eKzTgvPRpWOf1ZenF+AaP0k22EHj9vj3Q5ixfffBwS+Hmb8swBslGBEbBdGlO1dllN3DRY4aJiD
	SPHR4GMI56Zc1korXxr5M6CyjKzsymnw=
X-Gm-Gg: AZFdTZfezkhEeSbthjNg+l7hmbeJB5QnjMzqNYPqKk1x1Lmri2LRYU4rZSOBG5mAARG
	mBtYOqywMWpzxka7Xk+goAecLoE2+LHLHIyEbdhkdtRE78XPopp9k/nSXAOhAXLqwu0OySLH3rt
	5pweSA4xhgJ1RWr93xBijU+R3ORzZAdbXsKw1FytV0rYT1GXklwwX6GpKcHcAJ3TK3TllKZPJQj
	Xzu2rYRhBFCKd+Pulpoz1sEeapXZPaW1IIxudgdtb9Z7A4WB7Ipz+HlusTAodCdW1nmxMzRQjxZ
	l2Th35u7crNATHnlpMqLeJZzLlgDhKFUoy23MFzOSMNS+cwlmZnd5vZTpUgrOCr4oy7N/thiyul
	Hx/aPc5gK1dik5j4QHaQcw8lTmLcLnzK78ghRIYs=
X-Received: by 2002:a05:690c:7348:b0:8b4:cba5:fd6c with SMTP id
 00721157ae682-8b52044065amr126739297b3.22.1795862286628; Sat, 28 Nov 2026
 02:38:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261127080132.266236-1-congnt264@gmail.com> <20261128030319.3205806-1-maguicai@kylinos.cn>
In-Reply-To: <20261128030319.3205806-1-maguicai@kylinos.cn>
From: =?UTF-8?B?Tmd1eeG7hW4gQ8O0bmc=?= <congnt264@gmail.com>
Date: Sat, 28 Nov 2026 17:37:55 +0700
X-Gm-Features: Aa3M54oYapQM524laP5MxH1c1g8R2EyRuvG3jfItLB1ggZgI1yiJdWq_mT0z3GU
Message-ID: <CAJpJ=Gs5hzFGeR_qmrtfL94LCWWo5HCUhkHewMG285gR98ZyHg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: return 0 from unpack_tag_headers() on success
To: Guicai Ma <maguicai@kylinos.cn>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 10:03=E2=80=AFAM Guicai Ma <maguicai@kylinos.cn> wr=
ote:
>
> On Fri, Nov 27, 2026 at 03:01:32PM +0700, Cong Nguyen wrote:
> > unpack_tag_headers() returns int, where 0 means success and a negative
> > errno means failure, like unpack_strs_table() and unpack_tagsets() whic=
h
> > unpack_tags() calls next to it. On success it returns true, which is 1.
> >
> > unpack_tags() tests the result with "if (error)", so a successfully
> > unpacked "hdrs" array is treated as a failure: unpack_tags() destroys t=
he
> > tags, rewinds e->pos and returns 1. Its caller, unpack_pdb(), only chec=
ks
> > for "< 0", so it continues without the tags.
> >
> > Return 0 on success.
> >
> > Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagg=
ing")
> > Signed-off-by: Cong Nguyen <congnt264@gmail.com>
>
> Looks good. Because unpack_tags() rewinds e->pos to the start of "tags"
> before returning 1, unpack_pdb() leaves that section unconsumed and the
> profile fails to unpack (-EPROTO) rather than continuing without tags.
> Since tagged profiles cannot be loaded at all since 3d28e2397af7, this
> probably wants Cc: stable@vger.kernel.org.
Hi Guicai,

Thanks for the review and the test. Agreed, the profile fails to load
with -EPROTO,
and this wants stable@vger.kernel.org. Adding stable to Cc.

Thanks, Cong
>
> Tested on mainline (f4585067150b) on arm64/KVM with KASAN and
> CONFIG_SECURITY_APPARMOR_KUNIT_TEST=3Dy: the existing 30
> apparmor_policy_unpack tests pass, and a local KUnit test passing a
> minimal profile with a "tags" section to aa_unpack() fails with -EPROTO
> ("failed to unpack end of profile") before this patch and passes after.
>
> Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
> Tested-by: Guicai Ma <maguicai@kylinos.cn>
