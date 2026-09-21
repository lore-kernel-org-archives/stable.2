Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5A3C1998
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977466; cv=pass; b=gB1Sh2DDIqPiQD/xcHK0ZEOj6Doctq/NNR1TLbodP1o1yRzFxCirVp6vS0ru/ZjQSVbC4PnJ8R12SZnGQpzFKEk93TS3CQvytpJvz+xht1IO2CgF9ExhiFOtfnELRjFPvHv1qXNST+fQ1y4LiSktn8s86joeKaNjjemhQ7k3RcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977466; c=relaxed/simple;
	bh=wTKF3GJe24qvlJZnP3fb1zIfYdXZhI1ydDoNfbeg+Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViRwjgO/RbYEr3KqvyAyff89pTsJ9taMCcTMpcznGrfWkPBGv+FHiTqwRxHV5k3tbR9no/O17e1HK6aeH1psrFcqGaPl9XLKIFxjeNwNx/WlXzzpeG8UTQmPj2xqfeY0swtoj4kJxzq+B5cjZcvLj9kdZO22HpBe/NnCSlWBmf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyTFUwMD; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyTFUwMD"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74dbc7359so1906648e87.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789977463; cv=none;
        d=google.com; s=arc-20260327;
        b=LpGmIkMseTHTXVoWH+3/Mu7ASiH4yTc6r3deipvhbMFks44R98A3Qf5DX21R4Xgx57
         uzon+hLTO0IblRb4ctVUmgLb43tmxO10yWo1LJUq33eht797e8CAMS0sih3Jd1BvOYe4
         sDBXkoLbqv5CUNC6nU21X+VTviR7vhJZLFiSMxWGJrmpRqFN3hSvLtPUNAoZjBY2vJdO
         nDqfCTi5F2IJSJMeJ94BytrOR+EJHOO/b/O11A4xuN0pU97247Qv759U1hnC7laF9Vrn
         m3hzac7IEGvvADAS9gfNy3IfqjuJwRhJoRrpq3XptjPPeIUVLDEVdzP0nADcdlcyTamm
         ERsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g9IsRdNBpVaOm+BvbZJMl+aEIv6TVvsoIWi27r6K2mo=;
        fh=QdZWPdUBeBmRKSXOBN5azr3IGpCQHBeGM8+HXxvkPx4=;
        b=KHuYggIR3GP+3QJY+wvYv73odZA3S76sbGb/ltHbPfslylXGAvY4ij5H/LzxpLdIJZ
         t9knHuT3LCJ4diweCsaMDZt0b0llX2ix8UQLQfHtu1lo2+gzxjDZ6KJfYi8JovlIVGgm
         mKk1l60MWT4PE6q3apckMXI7DoybUK0RwxFG64wrztSfkrt4fHO5j9Gq7j7WuRD+MwPz
         zZO9xHLup9anwzsc6SwmAn7hRock/p/6WTxG4fgZyueFCtcUUYQUz+SADvHB/dCVweZk
         P5+rNiKwyKZ+ILnCQz2hiQI9nwZEbWAZfqxPJm/CoGoZ8nFSTUyJwdXvex4EbTVYBHzV
         aocQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977463; x=1790582263; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9IsRdNBpVaOm+BvbZJMl+aEIv6TVvsoIWi27r6K2mo=;
        b=TyTFUwMD52pQ7pvfOyEWc8t0oxQfnnzHHwXPj/YQJnvHrnKVUsbyFk8nLSLZ1iAi6y
         jNxRCNTSD43Z5qnYVlt2kZA8fHuhrVHfY92UOvyWCi5yzuTzJm2snPzZUDzAJ7/yHjK9
         Sa36CZSjmjhYNRD2/x8ql0YAseikz+xopXGA0fJA7KOHLmArz5Bh35fYXi0qUmYmecF+
         tPjoVE+JZ9WCscOacYaGA/lfrRkUAQoMUMGfAvI78WiJcN/XcfCAuVZfq0TV46NxZBeR
         DoVJgFFV63pBFONub790eXeWkw0nKejfYG5+ccKCWLRkSsmO+8r6RB2mVC+4OzmUtCrB
         gwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977463; x=1790582263;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g9IsRdNBpVaOm+BvbZJMl+aEIv6TVvsoIWi27r6K2mo=;
        b=01F3I2Xvi4u5oXuhW2IXZDBlfEhvmsKG/KrQHqMqyeONapruzKZQZokKebMyj0EZ9z
         hdWAQPm1tor/2Y9DeQ0S26ToUSUucdax0pBiBQ++K/jgPANlaLLLX9ZQD1Apvp5iXPKL
         CnF0MPWLZbPAd3eyr+R36Ud6kPR4h7dbXSjSKr94+1oRL1IPD7jCO1PMvv5L5b9mIBPe
         9Hrj54nI+qqvwVnPMDw6niJ0D+TYm2sH0lLkP+lNwGm7shsLj5Tlk0gygeqYnWJ2CieP
         Koot/xP7bLfF2LY8nv6xfnnZN3wrJ19/dkeJ4fbRH/SXfefODAZDrYmfHtveMl6YelwD
         XM3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzqqEDMTN83pXjvUA+7xlaymlxmBXuwW4WqO6IdmpWupgAkzclWdm2kya6gV4O+G+jf5/rtJSA=@vger.kernel.org
X-Gm-Message-State: AFuF++l77KGlQiRltUllT9ygF1tvDZVMaCNO7+2X01KY9bDgpYtMommw
	CYqG+S1M6Uf8WlrfLaICMWcSzTiCARHreodGiSDos90C8RSAQG6Liy6ZoaXNcd9EYbTf+/cRG8G
	NYuGrDd1iYS5frH3yHOrQE2RxY9Fq8w0=
X-Gm-Gg: AYBFou0PRgHZLGQvJTZen8JufuEM+C8sUw1+GCd6lv33LeExehn/fIDBboJqK4S+mfN
	W9Gd8I5RetOQEgaloeDsbOfcpAp/bhFR2ijpEY71bxXCoZ5EZARbLjtLKT2H5VckFET61BscBD5
	+S+cEU26axIrJk7xYqZx6eJc5omH9l20HNPRtLw07Q7u1/vt62j6Z4EGA5G/bDUZrv9XuFfVkwt
	TeGLHwMg+Q0Wysus5qo3M2E1+Kjox3httUtdJ87xucwndr3ie0SksTGJGj743F5Xka6Zb5jLC9S
	+ODnKJJxSten+O5V0dUB6/xxd4/FfjKHpUty/c77bVOk60edJ/IWG/U=
X-Received: by 2002:a05:6512:104c:b0:5b8:9ef4:2bdf with SMTP id
 2adb3069b0e04-5b8c1809487mr2756705e87.26.1789977462770; Mon, 21 Sep 2026
 00:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920025955.31209-1-zenghongling@kylinos.cn> <04255390-4133-4e8e-81ad-4d2402498431@163.com>
In-Reply-To: <04255390-4133-4e8e-81ad-4d2402498431@163.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 21 Sep 2026 16:57:29 +0900
X-Gm-Features: AcwNN1XT333aOgbhzPsm-JYe6T_jxFAvajhOncAJFvThd79_ZeNb3_O9r7eZWKk
Message-ID: <CANFS6bYLBPr+FmE_MVWxBBMw+Qz55EFfy1u6UmBgkTak2CMyvA@mail.gmail.com>
Subject: Re: [PATCH v5] ntfs: mount hibernated volumes read-only regardless of errors=
To: liubaolin <liubaolin12138@163.com>, Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Baolin, Hongling

>    If you agree with this approach, could you please incorporate it and
> send another revision? I'd appreciate feedback from you, Namjae, and
> Hyunchul.

I agree with this approach. It looks sound to me.

>
> feel free to add:
> Suggested-by: Baolin Liu <liubaolin@kylinos.cn>
>
> Thanks,
> Baolin.
>
>
>
>
>
>
>
> >       if (unlikely(err)) {
> >               static const char *es1a = "Failed to determine if Windows is hibernated";
> >               static const char *es1b = "Windows is hibernated";
> > @@ -1581,12 +1594,25 @@ static bool load_system_files(struct ntfs_volume *vol)
> >               const char *es1;
> >
> >               es1 = err < 0 ? es1a : es1b;
> > -             /* If a read-write mount, convert it to a read-only mount. */
> > -             if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
> > -                     sb->s_flags |= SB_RDONLY;
> > -                     ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> > -             }
> > +             /*
> > +              * A Windows hibernation image is not a filesystem error, so
> > +              * this is a safety interlock rather than something the
> > +              * errors= policy may downgrade.  The super block is already
> > +              * read-only here: the temporary flag taken for the check
> > +              * above is not restored when the check failed.
> > +              */
> > +             ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> >               NVolSetErrors(vol);
> > +     } else if (unlikely(temporary_ro && sb_rdonly(sb))) {
> > +             static const char *es1 = "Errors were recorded during mount";
> > +             static const char *es2 = ".  Run chkdsk.";
> > +
> > +             /*
> > +              * Errors were recorded during the check or earlier, e.g. when
> > +              * loading the LogFile.  Stay read-only, like ntfs_reconfigure()
> > +              * does for volumes with recorded errors.
> > +              */
> > +             ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> >       }
> >
> >       /* If (still) a read-write mount, empty the logfile. */
>


-- 
Thanks,
Hyunchul
