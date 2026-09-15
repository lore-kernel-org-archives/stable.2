Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B62369D74
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471820; cv=pass; b=Y2hsAY9V3WEohZ+xP4roLU4PIimI4NetNwxmYZ7WQhrlmDLBDZcFXRXS1wBKKq/vFf3Of792yh1ADzm0cDNDbDnIevUeT1sMkUJZ5RTfIJS2Tx6u/Eu0gA4NUvOIHNT5IsKK6p3qWu07Nawcirz+DGq8Qc88PeNHsxyBGag3G24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471820; c=relaxed/simple;
	bh=ctN51SscDl96yAfOoCtwrpkHTXHsrI3e9yoxIIut26E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2W5desd2haAeCFj2fqcG7hH8WLidxgTgDXoKvQ0c2kR4Cr96xQhYiTyM6am5SWyEMfBVHSRE52lAkwfJY5hssP6czMSbBaXaMAtLjh4nq2yvA6xTJawzvw8LZ+ae8fTQCOi8NGbJmgaMWhzGeUCHeCZ6D15orT4njW3PtAbJ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llbUV/Qe; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llbUV/Qe"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66d20bdfe60so425976d50.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789471817; cv=none;
        d=google.com; s=arc-20260327;
        b=bZdca4iJjc3lUaEheP1F/ab6HMoJk/I7HXwrAjirVuiLCrkQS3eEBdJretjKBb8v8I
         eSrwhVncLBgVAuJUG2ceOUF8uhs765yI9iFEOTpGuGiNhKcK5qnA7iGjNffagjrxUklP
         04wUDhUmuHvmxsiamrZIiQOKJECL1JNJ5oZRphwwLZ6Pf3gooYHsEP8ZAeTbcuQ/Q0LF
         nBS15K2oFevwTVyqKF59EN5EOkOiY+MIProVlLihvQMfZbg+BjRK1qjM68ZNlfdgkxt4
         A65RcogEr2ii4J88+/ikfDMJfkCn/0ZePHPxtyQGW8Akx4Eppu95Vs3kyggWvtKDlQE0
         IeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctN51SscDl96yAfOoCtwrpkHTXHsrI3e9yoxIIut26E=;
        fh=JnNSKZEEQR2ZPqLm+sQdggglGVHNuAYTq8m9f+Cjai8=;
        b=IKMqCAEUfko4iBwX7rwzVRGCOUJRAIfjd1TlL7Lfs3VGRp4ckDg2f97GHMBEV1wQFT
         NLLfJsjv4ExuBX9WIIlgi03jItttXdCUHhrYkxbryY4pWg7y4sYMxetpmtKlDesx82to
         WhPrNOOhi7lpzAgctN4T+qrV1TGs1dLqNlrFLt4gOjwZpci0HRTXAAkOukaDhdc5Qi2/
         4eahAnqpaaNvWBlgCKkZ5oaEQohxQGFwffZgMuOTWwvd9QMhwNETTGHiAOomLGuBiw2v
         TdsB28isFwBZaYHIs0Vx2MuWiAGPjvDwMoFA9YBocFXgKut8dQ7UTO7c2iX0UAZGzS3g
         H/yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789471817; x=1790076617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ctN51SscDl96yAfOoCtwrpkHTXHsrI3e9yoxIIut26E=;
        b=llbUV/Qe/21I2MRiJL560Pr7jqUDuY6QgOFqdnbeOiDNII5TXqOIsFB0Drca94j2JA
         ZX2CGSuGp6B/5CYysoEQ1P+k01FCMqiimSqgv3LyVjXekjDtRD+qB0rZ/msX27+x4lUQ
         5oaQ3EfFdNbaehr8sX58+5tTMliH5IV5ttCCneFc/mPH7O1t9B+hM8zGMx+nUH3y8MkT
         i6sDVEQjlfvZ/x/fKsfobl1hf8xQ58zUaPZHdUBqReJIJ63ApIQPZOGyB2heKrsDixz/
         d5aOKSkbKSQgNrXmwLhpzscvQjNKob8T+UNttYn1CMXHwwvKckSfGsDlswjwzYTSiNt5
         xuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471817; x=1790076617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctN51SscDl96yAfOoCtwrpkHTXHsrI3e9yoxIIut26E=;
        b=PGoDpUjY+jBD57hMXNvynGNRZ/B0ESiiLo3Id6B615mo3ZCsV8lECQ7LVaUrDCWONb
         b5UzhxuG6vD25QDLypp28GC8LgT8buYbQmEfhndCOCv19YXm2wS1n7sLdamkcuiX0pHC
         023SnI3txlWO1dIzsrlvyXIsYTBlCLAVqi1OecVVeEaBdn+sXt0sdQt8jShfEDipY9YU
         OxT0rKZ8OSfcbvevGKK+nOY+OkVG/xJwjeT5bKpw3lxfkxyxWsiWrzAUGyj9UyNSm1KZ
         XuQWDulB4G3txq4vWT/r+LX9Dwfo9M2vKEbu/c2fRaEYsdbNpnWh974LL5S0neLd785s
         /bfg==
X-Forwarded-Encrypted: i=1; AKwUvBxGVglyS5PD2cNyYWZbnSkt9dLQkvB4TYHqQ83u6gYnNoaAMO4/TOp7wcBUSNVP1mteWvXgnsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kUEgoTozVLLAU7+d6GLbF5+Sa5W3wnF67tcElL2ZWZhHWFeZvO
	2fhqBgsVRPkKYVNzqhTddX4MbtMTk3Ez8KsdX7NrtRzlnelBq84ofrThJ0ZziifrCOp9DjwAz8H
	jCMJJl79YYm+ywqergphEZqs/kdKMedE=
X-Gm-Gg: AYBFou02LcgWRJXMLB9v21JGIMcPFQBwzA0shd5fVE06wz3by0rrLArJ7C2Y+RKiv7Q
	98US7WX8bJ1zz/KmaMwU3vMsy07W3AFUphxKH6B9vPp991BD2271y9GbUmYldYjVUYelTOsHjCE
	eV7zInAqt9z5/9eigor34H6BpI0oymvKRd3eo4IBQlj1wg40jM+oT8zm1GnfyezyBs0c8PtCuz1
	P+v50BwlbiXNxddQlfGAd0rOYZbSvIvN7TqWhNx1ZJENchLWnuZMUIC/y+V4qkN9XAxba+LRRSE
	Ou0n4DdZEDQag+aVkezE1tC55VGOntVrT3kkWZXw/4FaNikcIpXxAN+d
X-Received: by 2002:a05:690c:630e:b0:870:48aa:473e with SMTP id
 00721157ae682-88d19058869mr28240767b3.0.1789471816696; Tue, 15 Sep 2026
 04:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910184452.895485-1-itai.handler@gmail.com>
 <20260910184452.895485-2-itai.handler@gmail.com> <20260910190139.BF6231F000FF@smtp.kernel.org>
 <CAFpOueRqaQ=C3u+br6AsCDPeeFwqVUmCG6JSCu90noowVCfd=Q@mail.gmail.com> <DLEWE24XEKNU.1Q1JD8PFVRJML@kernel.org>
In-Reply-To: <DLEWE24XEKNU.1Q1JD8PFVRJML@kernel.org>
From: Itai Handler <itai.handler@gmail.com>
Date: Tue, 15 Sep 2026 14:30:05 +0300
X-Gm-Features: AcwNN1XZV_KcXpgrsqVgDP23cMB0wTyq2Xl7FjPYm5C4oFYJ8HJyICxhmV6sUvM
Message-ID: <CAFpOueSTBSipye_1VmJBBJSXsn-KBYoKUL=JTA4Ker3nMhFPQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: take the flash lock in spi_nor_shutdown()
To: Michael Walle <mwalle@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, pratyush@kernel.org, 
	linux-kernel@vger.kernel.org, takahiro.kuwano@infineon.com, richard@nod.at, 
	stable@vger.kernel.org, miquel.raynal@bootlin.com, 
	linux-mtd@lists.infradead.org, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:31=E2=80=AFAM Michael Walle <mwalle@kernel.org> =
wrote:

> So is this now two AI agents chatting with each other?

A fair hit. I do use an assistant, and I should have said so up front
rather than leaving you to guess. Answering the bot on-list at that
length was a waste of your time as well; sorry for the noise.

>
> Sorry, but please be more precise and on point and drop that wall of
> text.
>
> And please annotate your commits with the Assisted-by: tag.

Understood, and both are addressed in v3: a single patch, a much
shorter commit message, and an Assisted-by: tag. I will not reply to
the bot again.

Thanks,
Itai
