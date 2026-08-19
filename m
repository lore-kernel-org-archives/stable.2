Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD322EEE8A
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143399; cv=none; b=a8rGttafD7WLqC25Afml1cEqak01nKpPhETXFH9ua+fgU4Dtz/lRYK4KBZ6mMShkrXUeLNudpcvnoD8LbjYnPvYChw0QE07BapU1Lh18B/bGBrZzXy7MxDSswpPjVNlstQI2CNWH5CrhPqs1xlhvRvizj4RRSM234enyhdMMzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143399; c=relaxed/simple;
	bh=8NSAxoKdj2CImo9K22dfQYC4bFvoKWOqEIYItODfF5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFXas+cj3EVr6AYqclz0Ec1YWTbqUQ75WofKDwRm9gej1IiTvfG9+lh3Lgs8JI8LyQNm7XKQgZ6f8CZ+7m0dXd4inAzwHKVxB7lRvd/+e2VphGYiwhgZCgwyjZ75GYoSmCcTuZ9zpUdczUSQW2pz8ab7oT6IjBRv3nvl9lPM+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvmU4GOx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvmU4GOx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so5615235e9.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787143396; x=1787748196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4s1/nRtlK2r1n/sIa7tXaH0u1v7OW/0NCvTyRnewdHY=;
        b=IvmU4GOx5uxjbcrNTwDxpnLcX/wtGyNcGu1+KwW44C11Msd9Yp/Xhy2CW98OsL05bE
         jNgUpxTiwHxZ9SW6G52rINZPopaLimDByK2RofILJlRJz9MZ8qtJuGU/77ws9bFy2WiX
         FlOLpG40e2cqKh5UGCIcVhNWOrTGFhouWrlUofeo/wxmBm+lmITAsvzolAf7F5ytzYaJ
         Wqb9n3iZ8tsCg6YKMKeoX6QwwH1YpqqR1dwuXd06OAiuc6Gszak2qOOK9ZABnvt7hT5X
         jGCNgz/uRuPl4qMVtUsMYJDxFte/xw2uaASryUZbkIH+saveyAJ3X7dJB4KFBEUP2qP9
         6E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143396; x=1787748196;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4s1/nRtlK2r1n/sIa7tXaH0u1v7OW/0NCvTyRnewdHY=;
        b=j/wjx9DUq3asfqJzClL1eF1BQ0bgGCbXRZzRRT8F32cT1b3athdFEF4F6u/fdJF42g
         3JBNS+W5hePVRZJYiqFfdPnHrEAI5urSU/GJ320dhCsyVN3Q7qKPAm1cOYnzg3uZUn0p
         ouHfyaPWhSdsLGD1RbcD14WLTUM77aGLetAjFJ6OCcR2qNhTwHaTDLp5Ln0jMWFRpTcG
         wWydDkiZs9rSc0ocOw/pk9Y/oPE/DEd04rsDw6+HDDyJ4ybIKow3mGsRQFXXQqpuVl2Z
         i2yumgv00vQgVZ1KzK2VucpDgO1dWKZB2LZ3oFt0MdKm9WzANPhkrQpjPHzFwQ837S4P
         +8Ug==
X-Forwarded-Encrypted: i=1; AHgh+RrYG+dHaAUWwaK1BQrhHpnWln7QYz7z83hUL4uW1Mzt7VDlb0iDwYf0Ddjln8CAUfEj2liH/f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0yKEbJhdoMHx5tT2k6sEsiQoj3xrq41RWr5GQuswTfFQIcoh
	97g2ow765vhpe27c2dfo2+j4D2mJKT0BOOiVFRiw761CsDoyLFyVL1x5
X-Gm-Gg: AR+sD10ZJljWz2HB/3t12pgi5im9xwe4hpdLwyA4GdSlsFgYIEDcajvKk9ITwncEBTA
	A8L2DFRiwOqi5rfP2JXFNDVbTumh2C9+MipXvK6YI5DyztxiWbaW/a3ncd2i3p9VadXeaWZasjp
	+x4SumtR8gbJOTO2M9/PyFpY7m20B7L/g3VErvailQAJ9lTT7SjSNUw3OgKPjdUqumsYz0u+And
	XSoZUtiG/kT9FjS/jhfODWkkqiAysAWw/gpNRgTgGJ46acc8W55xETl/59lt5RtxBnUhCrZF5yK
	SCsNtCSdB/SrPFUi6cvoOy5sg/Z7MvptuySLQ6z7LKJpoxai4iDAlx7iac1c910m1zeCY7DCCPA
	HksqIuvg6D2zvaJPXSOHpbtX9aFt0iMhf5zs2tNtKlMKwY/J+R3+qac/ZBtb2ypNV77gyADzK2K
	R0oeVqEPtQVsaqvU4XFG/Zw1wKo9xavu7ftdMfkh6OoSTIrQvOA0j8q8Wj6cXOpbCu0Io36BPah
	FrwwC6EcfNr0es25oZzFr/2Pg9FGtiroRI=
X-Received: by 2002:a05:600c:8b06:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-499aa0dca0emr89422975e9.0.1787143395650;
        Wed, 19 Aug 2026 05:43:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9dffa59sm79314665e9.3.2026.08.19.05.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:43:15 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:43:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark"
 <derekjohn.clark@gmail.com>, Hans de Goede <hansg@kernel.org>,
 stable@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix current password length
 check
Message-ID: <20260819134314.54a6f835@pumpkin>
In-Reply-To: <aoRgl4fG_t07FqVK@linux.dev>
References: <20260813082049.41209-2-thorsten.blum@linux.dev>
	<daeefbce-83f6-f161-71f5-38730fe9c9d5@linux.intel.com>
	<aoRa_PwLxneo9Juv@linux.dev>
	<dddaae9d-88d4-bf7b-3bc1-76cd115742c2@linux.intel.com>
	<aoRgl4fG_t07FqVK@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2026 15:39:35 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On Tue, Aug 18, 2026 at 04:20:10PM +0300, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 18 Aug 2026, Thorsten Blum wrote: =20
> > > On Tue, Aug 18, 2026 at 02:28:50PM +0300, Ilpo J=C3=A4rvinen wrote: =
=20
> > > > On Thu, 13 Aug 2026, Thorsten Blum wrote: =20
> > > > > current_password_store() checks the password length before removi=
ng the
> > > > > trailing newline, which can reject valid passwords that are exact=
ly =20
> > > > > ->maxlen bytes long. =20
> > > > >=20
> > > > > It also passes ->maxlen to strscpy(), which truncates passwords w=
ithout
> > > > > a newline.
> > > > >=20
> > > > > Use strchrnul() to measure the password length up to the newline,=
 then
> > > > > copy that many bytes and add a trailing NUL terminator.
> > > > >=20
> > > > > Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface =
support on Lenovo platforms")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Keep and reword the newline comment
> > > > > - v1: https://lore.kernel.org/r/20260810132018.156868-3-thorsten.=
blum@linux.dev/
> > > > > ---
> > > > >  drivers/platform/x86/lenovo/think-lmi.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/pl=
atform/x86/lenovo/think-lmi.c
> > > > > index e215e86e3db7..d0ceb6aaa69e 100644
> > > > > --- a/drivers/platform/x86/lenovo/think-lmi.c
> > > > > +++ b/drivers/platform/x86/lenovo/think-lmi.c
> > > > > @@ -438,14 +438,14 @@ static ssize_t current_password_store(struc=
t kobject *kobj,
> > > > >  	struct tlmi_pwd_setting *setting =3D to_tlmi_pwd_setting(kobj);
> > > > >  	size_t pwdlen;
> > > > > =20
> > > > > -	pwdlen =3D strlen(buf);
> > > > > +	/* Strip newline; setting password won't work if one is present=
. */
> > > > > +	pwdlen =3D strchrnul(buf, '\n') - buf;
> > > > >  	/* pwdlen =3D=3D 0 is allowed to clear the password */
> > > > >  	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting-=
>maxlen)))
> > > > >  		return -EINVAL;
> > > > > =20
> > > > > -	strscpy(setting->password, buf, setting->maxlen);
> > > > > -	/* Strip out CR if one is present, setting password won't work =
if it is present */
> > > > > -	strreplace(setting->password, '\n', '\0');
> > > > > +	memcpy(setting->password, buf, pwdlen);
> > > > > +	setting->password[pwdlen] =3D '\0'; =20
> > > >=20
> > > > Hi,
> > > >=20
> > > > I don't understand why is this strscpy() -> memcpy() conversion req=
uired?  =20
> > >=20
> > > It's not required, strscpy() would also work.
> > >  =20
> > > > Wouldn't it work with:
> > > >=20
> > > > 	strscpy(..., pwdlen);
> > > >=20
> > > > ? =20
> > >=20
> > > However, strscpy(setting->password, buf, pwdlen) wouldn't work because
> > > pwdlen is the number of characters to copy, but the destination buffer
> > > size also needs to include room for the NUL terminator. Since there is
> > > no NUL before pwdlen, it would copy only pwdlen - 1 characters and set
> > > setting->password[pwdlen - 1] =3D '\0'. =20
> >=20
> > Okay, I was thinking in my mind if I've a off-by-one error in my=20
> > suggestion but didn't want to spend too much time on figuring it out.
> >  =20
> > > strscpy(setting->password, buf, pwdlen + 1) would work, but since we
> > > already know that exactly pwdlen bytes need to be copied, memcpy() is
> > > sufficient. =20

No that overwrites past the end out the output buffer.

> >=20
> > It may work, but since you then go to nul terminate it yourself, I thin=
k=20
> > using the existing function is way better than memcpy() + custom nul=20
> > termination code. =20
>=20
> I used memcpy() because we already determined the string length pwdlen,
> which strscpy() would have to determine again internally.
>=20
> The performance difference shouldn't matter here, so it's mostly a
> matter of style or personal preference. I'm fine either way.

Personally I'd always use memcpy() if the size is known.

Whoever added the strscpy() should have used the size of the array not
the soft bound for the password length (which is limited by the array size).

In any case the code could be:
	pwdlen =3D count;
	if (pwdlen && buf[pwdlen - 1] =3D=3D '\n')
		pwdlen--;
	...
	memcpy(setting->password, buf, pwdlen);
	setting->password[pwdlen] =3D 0;
	return count;
}

I'm sure there could be (might even be) a helper to copy some
characters and append a '\0'.

David



>=20
> Thanks,
> Thorsten
>=20

