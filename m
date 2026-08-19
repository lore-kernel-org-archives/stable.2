Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6C32BF5D;
	Wed, 19 Aug 2026 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144497; cv=none; b=Lw4FVBb0n7C8fj6PEjp3CKMmrYsNcEbWpwUkmpgNkv12KcNseWPd+Sj6qmZJ6fEUkEzn3OIXubj5U2IE9rz3IAv/4id1MbbqUWaYzhfPHnhaMLh8Oe9gDyt+/Zxqm6MxN01p/mwCXhsHs6e/QZv6pVwnpL6XKO2KqAYxTQj45dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144497; c=relaxed/simple;
	bh=xxLMFYpzzwZpgMQLDu9GPeOAJIq9pDUJ7rjie4FR0Xg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qyE6JFj43RRdPRaA/FQv0Aw2Dloo2DQphzTO1noYFmKvLuSh6B0NtT0s8/f4Q/zfXdHUuJe4Pv1qkMiJj2DMKenKa+2TpER7Veb0knDGzpQuhcCl9gWuva9jzh3pM0m0AQ6A3qbTFJhKGoLJ+uUgNRBxupBgR0NzoLvxfEjRXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cW1nQSZq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cW1nQSZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787144495; x=1818680495;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xxLMFYpzzwZpgMQLDu9GPeOAJIq9pDUJ7rjie4FR0Xg=;
  b=cW1nQSZqhOIjbfYPCE2BTn92siUKg22QTzomZEi7oISYiAvl7MW9On+y
   Htf6ZfzCj3Pnq1N8Cpgbf6FpOOSX/XWcme7iRUBTTGKBnctRDWJlmhHwt
   sLWI2aOKJgMq8/79moE38LD4+nz8z46fHYLf2v/urBV9me+ZTscvNjMob
   qMbtKxeMTCShFp87eaiBlXg4+ZRmK1S1WWypeoOJHVQRNrW0pBfDx2SbL
   II+mOFWsrIClF1FM2k1X3vQwVBPZHpkI/E9KaGDDtFqqA4Y0euJsZUXbA
   4iMa3IHdcQLij0lPyUNSuh6+JncEQ+SejXKwEMlICoiAcwRNlX5bTomvB
   Q==;
X-CSE-ConnectionGUID: 2pf4NlS1ShCtHgdpTwGlFw==
X-CSE-MsgGUID: fX/NStm9SRySQob8h4jOyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="97992290"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="97992290"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:01:34 -0700
X-CSE-ConnectionGUID: heavkqUnTJeWG3HwI3ik6w==
X-CSE-MsgGUID: 9XqHon8WSD+em/PWWOVSIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="265087405"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:01:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Aug 2026 16:01:25 +0300 (EEST)
To: David Laight <david.laight.linux@gmail.com>
cc: Thorsten Blum <thorsten.blum@linux.dev>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, stable@vger.kernel.org, 
    Mark Pearson <markpearson@lenovo.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix current password length
 check
In-Reply-To: <20260819134314.54a6f835@pumpkin>
Message-ID: <b17089a0-7c51-1f53-24d4-93a1e13f557c@linux.intel.com>
References: <20260813082049.41209-2-thorsten.blum@linux.dev> <daeefbce-83f6-f161-71f5-38730fe9c9d5@linux.intel.com> <aoRa_PwLxneo9Juv@linux.dev> <dddaae9d-88d4-bf7b-3bc1-76cd115742c2@linux.intel.com> <aoRgl4fG_t07FqVK@linux.dev>
 <20260819134314.54a6f835@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2123993934-1787144485=:1169"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2123993934-1787144485=:1169
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Aug 2026, David Laight wrote:

> On Tue, 18 Aug 2026 15:39:35 +0200
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
>=20
> > On Tue, Aug 18, 2026 at 04:20:10PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Tue, 18 Aug 2026, Thorsten Blum wrote: =20
> > > > On Tue, Aug 18, 2026 at 02:28:50PM +0300, Ilpo J=C3=A4rvinen wrote:=
 =20
> > > > > On Thu, 13 Aug 2026, Thorsten Blum wrote: =20
> > > > > > current_password_store() checks the password length before remo=
ving the
> > > > > > trailing newline, which can reject valid passwords that are exa=
ctly =20
> > > > > > ->maxlen bytes long. =20
> > > > > >=20
> > > > > > It also passes ->maxlen to strscpy(), which truncates passwords=
 without
> > > > > > a newline.
> > > > > >=20
> > > > > > Use strchrnul() to measure the password length up to the newlin=
e, then
> > > > > > copy that many bytes and add a trailing NUL terminator.
> > > > > >=20
> > > > > > Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interfac=
e support on Lenovo platforms")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Keep and reword the newline comment
> > > > > > - v1: https://lore.kernel.org/r/20260810132018.156868-3-thorste=
n.blum@linux.dev/
> > > > > > ---
> > > > > >  drivers/platform/x86/lenovo/think-lmi.c | 8 ++++----
> > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/=
platform/x86/lenovo/think-lmi.c
> > > > > > index e215e86e3db7..d0ceb6aaa69e 100644
> > > > > > --- a/drivers/platform/x86/lenovo/think-lmi.c
> > > > > > +++ b/drivers/platform/x86/lenovo/think-lmi.c
> > > > > > @@ -438,14 +438,14 @@ static ssize_t current_password_store(str=
uct kobject *kobj,
> > > > > >  =09struct tlmi_pwd_setting *setting =3D to_tlmi_pwd_setting(ko=
bj);
> > > > > >  =09size_t pwdlen;
> > > > > > =20
> > > > > > -=09pwdlen =3D strlen(buf);
> > > > > > +=09/* Strip newline; setting password won't work if one is pre=
sent. */
> > > > > > +=09pwdlen =3D strchrnul(buf, '\n') - buf;
> > > > > >  =09/* pwdlen =3D=3D 0 is allowed to clear the password */
> > > > > >  =09if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > sett=
ing->maxlen)))
> > > > > >  =09=09return -EINVAL;
> > > > > > =20
> > > > > > -=09strscpy(setting->password, buf, setting->maxlen);
> > > > > > -=09/* Strip out CR if one is present, setting password won't w=
ork if it is present */
> > > > > > -=09strreplace(setting->password, '\n', '\0');
> > > > > > +=09memcpy(setting->password, buf, pwdlen);
> > > > > > +=09setting->password[pwdlen] =3D '\0'; =20
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > I don't understand why is this strscpy() -> memcpy() conversion r=
equired?  =20
> > > >=20
> > > > It's not required, strscpy() would also work.
> > > >  =20
> > > > > Wouldn't it work with:
> > > > >=20
> > > > > =09strscpy(..., pwdlen);
> > > > >=20
> > > > > ? =20
> > > >=20
> > > > However, strscpy(setting->password, buf, pwdlen) wouldn't work beca=
use
> > > > pwdlen is the number of characters to copy, but the destination buf=
fer
> > > > size also needs to include room for the NUL terminator. Since there=
 is
> > > > no NUL before pwdlen, it would copy only pwdlen - 1 characters and =
set
> > > > setting->password[pwdlen - 1] =3D '\0'. =20
> > >=20
> > > Okay, I was thinking in my mind if I've a off-by-one error in my=20
> > > suggestion but didn't want to spend too much time on figuring it out.
> > >  =20
> > > > strscpy(setting->password, buf, pwdlen + 1) would work, but since w=
e
> > > > already know that exactly pwdlen bytes need to be copied, memcpy() =
is
> > > > sufficient. =20
>=20
> No that overwrites past the end out the output buffer.

Hi David,

So are you suggesting ->password cannot hold a maxlen long password or=20
what?

> > > It may work, but since you then go to nul terminate it yourself, I th=
ink=20
> > > using the existing function is way better than memcpy() + custom nul=
=20
> > > termination code. =20
> >=20
> > I used memcpy() because we already determined the string length pwdlen,
> > which strscpy() would have to determine again internally.
> >=20
> > The performance difference shouldn't matter here, so it's mostly a
> > matter of style or personal preference. I'm fine either way.
>=20
> Personally I'd always use memcpy() if the size is known.
>=20
> Whoever added the strscpy() should have used the size of the array not
> the soft bound for the password length (which is limited by the array siz=
e).
>=20
> In any case the code could be:
> =09pwdlen =3D count;
> =09if (pwdlen && buf[pwdlen - 1] =3D=3D '\n')
> =09=09pwdlen--;
> =09...
> =09memcpy(setting->password, buf, pwdlen);
> =09setting->password[pwdlen] =3D 0;
> =09return count;
> }
>=20
> I'm sure there could be (might even be) a helper to copy some
> characters and append a '\0'.

Are you perhaps looking for strscpy() ? :-)

--
 i.
--8323328-2123993934-1787144485=:1169--
