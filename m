Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792992124;
	b=jqENm5dtURkCzewvFrYairpmkxGBFeySk6VO1hKuoaFw3Xg+G4mWsfaWX9qo+0mgvgR6
	 gqwpKnzNnKXaFsli8pQqXr/Tn22ArcDNskdfrj8Q5Pgku0C9nO8aUriZSYHn/I9KpuAC5
	 dkdV3vvT1FR5IdGox1XQLOt4VufBZeTw5dDjFvDZCcu3mdyTYKRBYY6OdldgYjFwenCAo
	 A7ixVxncH04AlOP1caMSExBuM3/YUvSL2M1WcEG5kqxkCKFV6d+xzumcGiaA+NUQbvzLA
	 i36s5DPnmpeLitrGhp5tHXkuLLG17Ne8CW8X/STxXMOh8F5tL3VDtjHGHQBVAVJc7iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l+o7YHaaQtyvRVJCVlFIVIOOyJjpcMnJTZEtbdzMaE4=;
	b=j92Lj55x4vQezAOsERUoirvChWFGpFvBPVdUL8dlXHzNXagiOwMIykMFRgoE4JKb+OIB
	 7PbPEaryBz/Wc0/41faQL1iHjRI4MBQRavap3Qv4t61Y48lXacIjUADjsAb53fg/n/IFU
	 WTl00BA/BdSuZ6qqXjlkZdMBd7MZCPZoQSl6LfnRPAn1v6at/mXiruLzdlifPZyQIxXP2
	 5KTMbFmw9gZt0M8IuqRjBn1KF6BkChjvdWubUJkYCXKGsDE3O32LcGynyZGvqg3UcmfLH
	 6RAjVtpdoWLXMCv1DDJqkjX9JN4FVAjBx008iRmICPqpOyegkQvRVMmLGBNqSsZWBIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bc5WQdyH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C42606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C42606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bc5WQdyH
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9906870a9baso1366544241.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792992122; cv=none;
        d=google.com; s=arc-20260327;
        b=mAnxIaI4b2Lap8Bo/b1loIVRKw5/TAO29GtCU4/g2+WZTTs7u7eR4Z5FA1nHXAopzL
         gIHbP6KRdsELDbv9NCA0OFhvo+kXW2bt73GL5RjxlatvAPycxLyuVQOILBdODBlDihW8
         IH3vOMGNp+eid4veBwajCxPN3aylP7AdnMO3KQkER1qbywr3dIq/5XlC1ORQsjYl6BXr
         v1vrUF/0rjuDAuEXiiKjahBr85nPGZaSEkRBGuUmka0q4C/SemYFfKbqlZfeUOoSR9oX
         r+nphH7JMjVbRl9wTe+ldAQOswirDQJL4YVU0ChwdHUtGzVzdKXPd4RNJCdktZkcIvIF
         E6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+o7YHaaQtyvRVJCVlFIVIOOyJjpcMnJTZEtbdzMaE4=;
        fh=9FvvMOp2mPjBbpX21Y7LtnEfNhJ/fZaZCTJ7USbnTKc=;
        b=efB4vUZfBPuv9bbfM95RHG57YM6E5kAfcvo0He5QgTWeaAgA/ojSrZPOmBx2jfSsgD
         tJ78TLhSvr/rb2HElVYAnfBU6Hvc8jjo8ar7RmsH9T2Laz7b4KqAtr14de9/wMt38B2P
         ZL6sDWt4YXSmk1+YjabQl4Wc4OIVwlcefAXkb5Cx8gpoQExi85YkU66KwhQ23a/SiEy3
         E2BW/5p1H8rfITKxIDKPzk/+nZUmq1mYQi2mpHua8j99FRbfrlK6kPRGAyepaZWRBdhA
         0xZUPB2fDKqHodKX2o6CqrYjXV78wgbHG2pl6uEmBkIL2u79K1xpBDdclHTnINgdnBn1
         oyMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792992122; x=1793596922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l+o7YHaaQtyvRVJCVlFIVIOOyJjpcMnJTZEtbdzMaE4=;
        b=bc5WQdyHexz4RjeU1UmexokrezFYsyEkH7XDhWDE5Rekp300eoYEGKUzutj/Abz+Ap
         130hK1mybqk7/RYOiVz8rO4pjETDiCOdb1mbjh1EfkFp/J2uG+nvzN1twhPzvtAuMlvm
         7oTO8r2Yw+xnDVtYkOTPf9WAdlWQgsZNl8Z3RXEZxlptLx2xtZP1CyHAXl4QyWqWs7Q6
         RYLfGTPLvRxdQC7LIXe9lJ2FkLXVRl/JGannVzJDRVhjHwRi1LVrZKSKwijcxPjxGOHj
         HretMb9Z/JRAoCuvsqLwPKDsAbjl6ySjY+pMjkmqbiySJ/Y5AQVN0Z7b5Zgh+6sLS1td
         NkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992122; x=1793596922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+o7YHaaQtyvRVJCVlFIVIOOyJjpcMnJTZEtbdzMaE4=;
        b=eVQtGA08T2IpJCeV43iJnJTr0v/RWy3i7h/QoVmljaG9hpybZiCcPPzhH7FsTOSrfW
         q2aK/4439sI9QCNtEDywVTHpcyqZv1LqSbInRNpBJaufOj+MoIZ+ApnClM0GjpgBJJV6
         ozSIzQMKJHlJNtbolby8+owKb8sZ504IAB8me5Hdo3HicT00JOnxSuoLzRUcYYcEHbRZ
         l2Wh4EgvcPXN4EDy57IO/RYWvw8pXs1JCeo8Gm9Op8nh5tvaxD8G0SM3oS27pbil0SiJ
         aQhpMcEiCHtxVDfj6obLb4ublo1KdL+zmTkWrvWH2CyKXA0W+D570nZ9xbwQl6OCavyu
         qarg==
X-Forwarded-Encrypted: i=1; AKwUvBzCMMH5aS4I6JmsveAxgc2XrYYjwKf9w32Hp0MW9nIiK0TZoQWmwf1AhRCkG0ht56tCIktjM9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbXSFycVaqoFrvI/YPI3TPoXupFX1HXqM8Cq5ZGBv1N3U+QsZB
	TxrFdFx7p1oyzhoyAzw8PwWoSv+wHyoZ5lajYD2fWIPZ4jhEbxkY6YzcGfwHeNH82oVpR/8Ia+F
	QGGAjTPN0PusBOJSkItAcGJ+2fgZUhcE=
X-Gm-Gg: AYBFou1PP+7bRa8/5Y/9SWHQjajIlvhd907ujf2821nTE3Gnfjd7HuDmHs7xzmTQ728
	uVw9pMeuyq+LDlXC/Il/Zs//vAcpJyfUuKfB2MksO8IWwsFlEPzpc+ylQzLF7Y4BKOsUzsgJAp6
	9t5i8XqMFp1Dn3Uw7bReqwJRmjqw5KL8mKs2z042Y7Sw0EMsKJ7U0nBLmKDBpw9Yk4UCCLUjjcq
	/XdJFhSdIB6g2OIvjsFbHTrWn45K/msAO+V8VNCzCwZ+7FNI3STGWnuPLgXOf5F8JHtH1V5C7C7
	Lj+bufKkFyslwz0edDqxWknSCFR+gNnqU4uaBvXUq9IsBRRmJTDjZxlwBOd5bYGPemiupFUxlKL
	Ps9LEOQ7rWuv2yjbIv681f6clzPjLwq3AqEGIUk2vtWJLtRYR+lwA/AYzcY981J4C1cQDzmqfCJ
	D3ZZDFXdLDfBVyF/pU9gILwg==
X-Received: by 2002:a05:6102:2c85:b0:7c1:9f20:36ad with SMTP id
 ada2fe7eead31-7ce5ca07ad7mr2086245137.2.1792992122575; Sun, 25 Oct 2026
 22:22:02 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024172641.19424-1-meatuni001@gmail.com> <at5d__q_RzGad7zt@ashevche-desk.local>
 <CADqcGBmOxJ1ns87pNmaSNVfCc-LNsTsf6YgnnZ5i+x4+dH+AMA@mail.gmail.com>
In-Reply-To: <CADqcGBmOxJ1ns87pNmaSNVfCc-LNsTsf6YgnnZ5i+x4+dH+AMA@mail.gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Mon, 26 Oct 2026 10:21:48 +0500
X-Gm-Features: AclHuK8vkB7NkckOpl2d0PlrXPWMHOQGPhx797u89umaHfztF2B1Jpqb3Rkh5mc
Message-ID: <CADqcGB=ok=Mr=EkhqjEspqMGOrE_ZSj4v8PkoKosR_=8wfUxjw@mail.gmail.com>
Subject: Re: [PATCH v7] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jorge.lopez2@hp.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	linux@weissschuh.net, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the review.

Link v8: https://lore.kernel.org/all/20261026051740.88791-1-meatuni001@gmai=
l.com/

Thanks
Muhammad

On Mon, Oct 26, 2026 at 10:16=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> Hi Andy,
>
> No particular reason. I removed them while trimming the diff, but
> you're right that both comments are still useful. I'll restore them in
> the next revision.
>
> Thanks,
> Muhammad
>
> On Mon, Oct 26, 2026 at 12:52=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sat, Oct 24, 2026 at 10:26:41PM +0500, Muhammad Bilal wrote:
> > > The input is copied with kstrdup(), which stops at the first NUL, but
> > > the full write size is passed to hp_enforce_single_line_input(). With
> > > an embedded NUL the helper reads, and can write one byte, past the
> > > copy. Use strnchrnul() so the scan stops at the first NUL, and return
> > > -EINVAL for a NUL or newline before the last byte.
> > >
> > > Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> > > followed by 4093 bytes of "B" to current_password 100 times returns
> > > -EINVAL every time, without reading into the heap.
> >
> > ...
> >
> > >  - Drop the trailing comments
> >
> > Why? At least The first one has the same meaning as before, what's wron=
g with
> > the second one?
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
