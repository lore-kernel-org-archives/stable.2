Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB946D540;
	Tue, 18 Aug 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059218; cv=none; b=SwoP6bfAZfmEuaswxw4d9Vyji3ASvxKJan0Ws1aXR2jelvINJ8bvUhsc6fth0c/bvJhA8zF4xbxez1waRzP8O+nDXt7/m0GMgo8qEnWSEAtus2JMkWxya/7kLaAYfZ/su6PnMBj+8tMZe6C66QaQ+VU6b4aKv+/V6w1t+17JNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059218; c=relaxed/simple;
	bh=2Dxfea+kxrncUMNEaRi5COMeVYYhJ0LJ7uya+soIV1o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bLrFmsxInmMb3aaV9ZjtqWMJ2EBIYtcqc+LWPyjwiKoX978tC5wuHM7R541HVlp7Bddj7Tew6psNNHbV4826UpQtCahbxPbXt+WIOHqAfIJkGRGXoGL0Z0MWSYkbneAPMXShyOX5jKC+kdsGJkD6tBcmSMO+nziwdbNos2epMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAvqMbTC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAvqMbTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787059218; x=1818595218;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2Dxfea+kxrncUMNEaRi5COMeVYYhJ0LJ7uya+soIV1o=;
  b=dAvqMbTCU8GBZ401tjDKconCvmVjc4lONK93T4qM6SPeVS8W9rv7WD3z
   jkoBmXtyFoM8BBByP93nzNgk/i2mYdCXuI4ZbiCJUxVwqpTGh94LUBKSN
   W9duuGnMsBv6TV12a2YN3+MjE7Id6iqhtg3UdDKHTQl/rb4aZ7z8aUxwt
   hWVxuucGHGGZRI2EaZT7lrK1mhEmp2KKM0bcNRL/+kM98b0MkkPtnWUkC
   zgedeFDhH2Ps+eOFnKfrT76azgr02/HanJs1Z40PyBUZn/A1ILyJiWBWu
   hA+DVCqkMBinYW03Ss0Rsm+kzQrtgYN5dQzF2OiDHKO4nGgypfJkuQWIZ
   Q==;
X-CSE-ConnectionGUID: O0F+NdbYQca6FPrl0SyKzg==
X-CSE-MsgGUID: +iS2pc1iSf2J6AQ8nJe2TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87756301"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87756301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:20:17 -0700
X-CSE-ConnectionGUID: ZnKkCSXlSb2urRrpcWkIQA==
X-CSE-MsgGUID: 8M7fekzVSuashiYMI9AGRQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:20:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Aug 2026 16:20:10 +0300 (EEST)
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, stable@vger.kernel.org, 
    Mark Pearson <markpearson@lenovo.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix current password length
 check
In-Reply-To: <aoRa_PwLxneo9Juv@linux.dev>
Message-ID: <dddaae9d-88d4-bf7b-3bc1-76cd115742c2@linux.intel.com>
References: <20260813082049.41209-2-thorsten.blum@linux.dev> <daeefbce-83f6-f161-71f5-38730fe9c9d5@linux.intel.com> <aoRa_PwLxneo9Juv@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-501368272-1787059210=:9077"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-501368272-1787059210=:9077
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 18 Aug 2026, Thorsten Blum wrote:

> On Tue, Aug 18, 2026 at 02:28:50PM +0300, Ilpo J=E4rvinen wrote:
> > On Thu, 13 Aug 2026, Thorsten Blum wrote:
> > > current_password_store() checks the password length before removing t=
he
> > > trailing newline, which can reject valid passwords that are exactly
> > > ->maxlen bytes long.
> > >=20
> > > It also passes ->maxlen to strscpy(), which truncates passwords witho=
ut
> > > a newline.
> > >=20
> > > Use strchrnul() to measure the password length up to the newline, the=
n
> > > copy that many bytes and add a trailing NUL terminator.
> > >=20
> > > Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface supp=
ort on Lenovo platforms")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > > Changes in v2:
> > > - Keep and reword the newline comment
> > > - v1: https://lore.kernel.org/r/20260810132018.156868-3-thorsten.blum=
@linux.dev/
> > > ---
> > >  drivers/platform/x86/lenovo/think-lmi.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platfo=
rm/x86/lenovo/think-lmi.c
> > > index e215e86e3db7..d0ceb6aaa69e 100644
> > > --- a/drivers/platform/x86/lenovo/think-lmi.c
> > > +++ b/drivers/platform/x86/lenovo/think-lmi.c
> > > @@ -438,14 +438,14 @@ static ssize_t current_password_store(struct ko=
bject *kobj,
> > >  =09struct tlmi_pwd_setting *setting =3D to_tlmi_pwd_setting(kobj);
> > >  =09size_t pwdlen;
> > > =20
> > > -=09pwdlen =3D strlen(buf);
> > > +=09/* Strip newline; setting password won't work if one is present. =
*/
> > > +=09pwdlen =3D strchrnul(buf, '\n') - buf;
> > >  =09/* pwdlen =3D=3D 0 is allowed to clear the password */
> > >  =09if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->m=
axlen)))
> > >  =09=09return -EINVAL;
> > > =20
> > > -=09strscpy(setting->password, buf, setting->maxlen);
> > > -=09/* Strip out CR if one is present, setting password won't work if=
 it is present */
> > > -=09strreplace(setting->password, '\n', '\0');
> > > +=09memcpy(setting->password, buf, pwdlen);
> > > +=09setting->password[pwdlen] =3D '\0';
> >=20
> > Hi,
> >=20
> > I don't understand why is this strscpy() -> memcpy() conversion require=
d?=20
>=20
> It's not required, strscpy() would also work.
>=20
> > Wouldn't it work with:
> >=20
> > =09strscpy(..., pwdlen);
> >=20
> > ?
>=20
> However, strscpy(setting->password, buf, pwdlen) wouldn't work because
> pwdlen is the number of characters to copy, but the destination buffer
> size also needs to include room for the NUL terminator. Since there is
> no NUL before pwdlen, it would copy only pwdlen - 1 characters and set
> setting->password[pwdlen - 1] =3D '\0'.

Okay, I was thinking in my mind if I've a off-by-one error in my=20
suggestion but didn't want to spend too much time on figuring it out.

> strscpy(setting->password, buf, pwdlen + 1) would work, but since we
> already know that exactly pwdlen bytes need to be copied, memcpy() is
> sufficient.

It may work, but since you then go to nul terminate it yourself, I think=20
using the existing function is way better than memcpy() + custom nul=20
termination code.

--=20
 i.

--8323328-501368272-1787059210=:9077--
