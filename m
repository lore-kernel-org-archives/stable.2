Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708865;
	b=s4ZJ8aXcIjXbTjaBJNCJ49Rdjvtw8/luEcoB7gNMGY/1VAkD3wKT0iwbOLXFH8IYQcsQ
	 IUGrhsP3skiOE1g9lYw6inxhptiHrL77RgG8I4FKrogxUwo4Q/meNysQraEuX0PhuDBv9
	 LQe+w5DYh5OFqWciMBiPullwIVjCY/Aas/6P9jGouGcnM2+kWgsPJR4HPs62FReBFfBKa
	 2cgeMlNQM9WcDv4JLTjTQZs4rUwCZOI2E9Jfv0lB98w0zuvK4fpWK1EV1AtJXhTl6DRic
	 qG3BPgwJgEv0zkAP3HKpzD2/ld0kKIgFWOruTdGtk5kJ0ickvAEhI6a1AShTSPS2g+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zOS3auQleOCi/8KrQAgmGKC8GcN7UFPzhW62l4NzWpw=;
	b=q8fSp6lhcgMr6KobRqlBWAyIs65OTwnOGZQYhji3ON1BG7HDLtB+MS1lPVLWTkRPueYN
	 PtZZ0I7IxtMVcng+1+w/Zx42Coos+tGT3Qp0GklVOtCTXPW0WTXE2VQNP0FeaxNCQB2aD
	 Ov7pFtxfg/9k9dlt/r/TJkhlq/QuOKxDNR13POw5r2+xCcPM1GuiWqqimDYVOybuOLqTh
	 sULnO7cR787qR9wADO9kjzzybwnFAKkOPSrK8Wn+AFCK8xU1kkTyAgpCvxLVL+4FaewtA
	 CmRvt4xn/sI9jFyH7dfZHUzCjrAmA/ruTpeIcq8y7q2JN3a39MSCIzAoEih2w7n8stw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rNc1v1ct;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E50606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E50606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rNc1v1ct
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6798d4ab549so399829d50.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792708859; x=1793313659; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zOS3auQleOCi/8KrQAgmGKC8GcN7UFPzhW62l4NzWpw=;
        b=rNc1v1ctu48X0YyAHIGHbLnUSeBlLmFFG1q2KpB+8S6FgiiGUcYkTC9P+ngX11aT9y
         ncGMJK0Sw553ICjc7iW3yQCjJqT4cLJVgf5CYh4EESHoqxqgmOPSyFB5AZYTwGBpzu8h
         fQIFpRKQMq3C1SGOpP8DmSef2vmAGsAo9drJMhdltqHB1zl6X15UNaloXdfUwXFitF3m
         rbSH40Y0xyC1CB7R+jL9ulezK3+wdh/apl3jfuXbHUv7ths7C6v+hXt8kW/tp8pFzXqC
         Us5ivVC+rL5E+dGIqHJHwGncMiH/CT/V0jm/qw9TuOVT24nPa4nxuKFXsUuBzjR1A3pV
         dX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708859; x=1793313659;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zOS3auQleOCi/8KrQAgmGKC8GcN7UFPzhW62l4NzWpw=;
        b=EvTKu8kzf3O22/IsV9Q5EfBi6mSyj6og/ROFAPMbVJDyi4Vc8I1S8s6M9ybhsiF/oW
         TdoXuAadmi0sJY/UMdmkYBAP1iveNeK+BonwUit0whtDQ5pUrF8clNLJ7Ts9zdv6Vmve
         IyEagUkbtlsnXmQbJaTGoBSOYVp2vFTIr855iJoJ63qoOEpjsCEhsjBuJ3f9GNp3SP8d
         a3l0e6bWGC8C39rWG7mIMv8wnxQ1+d6rfpUEeZRHd3+0HNpo7eTxQUmSQmBAoBtExVvR
         raNfajp5fvdVXjh/NWi64TBn6ets4v81NxaMN5YxdiALV5HY5NBhVH8Ph6leQkS0LRWr
         MX9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzvzCZoaIrwJx3nGQjvjbr0/tUeTEaruqd0AQdB3j/ND4SHYClnd9ii4Nl10TJvFCWzlLa6gJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwu3p0hygx90WgAo/pH75R4CmJSD9P7q0nMQIouAYNdbER4z/k
	g63jA2EWJ+WYswmo42V684KXZTH8fsNmffowvQJPoeCAutNHyyefHEKgLRD9uGLQwZI=
X-Gm-Gg: AYBFou1RjtC5u6lQ0EeEAKMasKi0eymvdwpOuvcgKEZ3xFmuQbihBWmolbfkUdun8F8
	CvtnrwQCD17V9ZaIG/Lu0i23B2qPm9QYXmtCBzmsVFAdMefq4sUWGuznlgnVUujFxYKmFXBczQs
	Tu9BrucyFtqiK3xFsOPrlDwpzEgWkyBD2eIxjJw0wLgeasye+g6483a0286cHoi03Vjm09gytgd
	Uz/6gJy+4/qxtaRLvN3kv2UWShF3cO08ejXFM11M2uyMJ1fkLDYWNzWrElPgiABdr7QmasFDlGS
	7bY557+zVqKx+SMI4ZuwnmcpdCnPYJOv29Y+JdxFyuEBXLuqOymabhuXNS+08IRdwsF5HQHad7p
	vDEJ0z1saWZ3N1bQLBuUf6K5O2hQbwjR23noGyhKWDFlQZl1rJWvk6Wv1sJk6CRmFu0bz2rByiM
	NSaPpwWc0uMXTUl+gnkZ9l9LXQfPY2Z6lqa+K1Jv8PuvJv30pnUIFhi3C2fYHHm4ZD4BpFdlnGM
	JruNccWfNRhn65hiRcKD28ClSo8ibDLVdPIpaelFJsdVXtrvVqFuLMNPYHoUFw9dbd/FLqlEB/k
	gOCWPsELq5+7g3R5aPPVjoQPdzIuTvBi82Zrxwz4ZUT8UrwIwZl4LmQekfTxZ18B5GQGpkfCpIg
	v5DER+kwpU6+c5fspmHyCneY2VBtMiAU=
X-Received: by 2002:a05:690e:812:10b0:679:a366:1ac0 with SMTP id 956f58d0204a3-67a35b6c6admr231491d50.40.1792708858803;
        Thu, 22 Oct 2026 15:40:58 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:5551:17ca:f374:dc57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a33fd78fasm428121d50.5.2026.10.22.15.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:40:57 -0700 (PDT)
Message-ID: <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 22 Oct 2026 15:40:54 -0700
In-Reply-To: <20261022120658.1328124-1-hengyul@cs.unc.edu>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu>
	 <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com>
	 <20261021153141.311425-1-hengyul@cs.unc.edu>
	 <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
	 <20261022120658.1328124-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 08:06 -0400, Hengyu Liang wrote:
> Hi Slava,
>=20
> On Wed, Oct 21, 2026 at 03:26:10PM -0700, Viacheslav Dubeyko wrote:
> > I think I see your point. So, I think that fix is much simpler. We
> > need
> > to add the thread records processing here [1]:
> [...]
> > The current logic simply misses the HFS_CDR_THD and HFS_CDR_FTH
> > cases
> > processing.
>=20
> Thanks. I tried this in KVM on a804c5742bff. It fixes the example
> from
> my last mail only in part, for two reasons.
>=20
> First, a thread record's own CNID is in its key. rec.thread.ParID is
> the CNID of the parent. In the example, a's thread is (17, "") with
> ParID 2, so taking rec.thread.ParID sets next_id to 16, and the next
> create fails with -EEXIST on z. Taking the CNID from the key gives
> 18,
> which is right.
>=20
> Second, even with the key, the scan still stops at the first record
> it
> finds, and the last record need not hold the largest CNID:
>=20
> =C2=A0=C2=A0=C2=A0 operation=C2=A0=C2=A0=C2=A0 allocated CNID
> =C2=A0=C2=A0=C2=A0 create a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 16
> =C2=A0=C2=A0=C2=A0 mkdir y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 17
> =C2=A0=C2=A0=C2=A0 create b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 18
> =C2=A0=C2=A0=C2=A0 mv a y/
> =C2=A0=C2=A0=C2=A0 rm b
>=20
> The last records are now (17, "") for y's thread and (17, "a") for
> a's
> file record, with CNID 16. The scan stops at (17, "a") and sets
> next_id
> to 17, which y still uses, so the next create fails with -EEXIST.
>=20
> File threads are also optional (HFS_FIL_THD; hfs_cat_move() already
> handles files without one). If a (CNID 17) in the example has no
> thread, the next create gets CNID 17 as well, without an error,
> because
> hfs_cat_create() only checks for an existing thread.
>=20
> Result of creating the next file in each case:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpatche=
d=C2=A0=C2=A0 thread ParID=C2=A0=C2=A0 thread key=C2=A0=C2=A0 patch
> =C2=A0=C2=A0=C2=A0 example (z, a, b)=C2=A0=C2=A0 -EEXIST=C2=A0=C2=A0=C2=
=A0=C2=A0 -EEXIST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18
> =C2=A0=C2=A0=C2=A0 mv a into y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -EEXIST=C2=A0=C2=A0=C2=A0=C2=A0 -EEXIST=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -EEXIST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18
> =C2=A0=C2=A0=C2=A0 a without thread=C2=A0=C2=A0=C2=A0 17 (dup)=C2=A0=C2=
=A0=C2=A0 -EEXIST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17 (dup)=C2=A0=
=C2=A0=C2=A0=C2=A0 18
>=20
> So the scan needs the largest CNID over all records, not the first
> one
> it finds. This is what the patch does; the cnid - 1 lookup only
> avoids
> the full scan in the common case.
>=20
> If this looks right to you, I will send v2 without the !=3D change.
>=20
>=20

I have refreshed my memory related to HFS's Catalog b-tree mechanics.
And I see that my confusion was related to expectations that threads
records should present. As far as I can see, folder threads are
mandatory, but file threads are optional. As a result, we cannot play
the "dirty" tricks and, currently, we can only rely on existing search
functionality in the b-tree. And I mean here that after every delete
operation we need:
(1) Check that deleted CNID is the previous to the next CNID. If it is
not, then do nothing.
(2) Oppositely, we need to execute standard b-tree search in the loop
by decrementing the CNID.

This approach could be not very efficient if we deleted a lot of
records in the between. So, what can be the more optimal approach?
Potentially, we can consider to have a small bitmap of allocated CNID
in every b-tree's node. Any other optimization ideas?

So, let's discuss the proper solution at first. If you still believe
that your patch approach is still correct, please, convince me by clean
explanation of the approach.

Thanks,
Slava.
