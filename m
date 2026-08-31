Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B524A3D2A;
	Mon, 31 Aug 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194327; cv=none; b=o3O4xWeIFvqH4vKt1krtOYpo0BVtSy0gYNvQ1IXdX1Gu+PFW93ZHdokucVUVCEb+1ByMtnG/BTI01tOHv8Fj5inFQyNOJyjLFv2AjVGeHtjyduVowdZM45eITXwrmVfzl7dspD/9PC9y1miw4GYkc4zFzb4NJ0FAnVkJ3W6FGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194327; c=relaxed/simple;
	bh=i9ll7kBErqBM32dx1j2Yb2lDfPt0V062fU/unvBDnIw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qhGtQiA860uNH8ut93Tao0lC4C37U0jy3dVEsFlj04nvHGZGFgDU0t47SPLt4vxZtlp1SsobXgAR47u/UmpjvVHcKM3DjXAMXUP+VM5pdgMuXy4c4QA70TZE0UBYAGrR1V6Typ9O7X8gV82741ODEuD5QBJqJaRbuAvphTcTUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+6vZ1sB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+6vZ1sB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788194327; x=1819730327;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i9ll7kBErqBM32dx1j2Yb2lDfPt0V062fU/unvBDnIw=;
  b=S+6vZ1sB79rxPw77FTov6s5bqdnqsRv8GVCiywRYxRO2ouhlEouyUDZ9
   XEh7JjPe7a6uVUgcKb3COE+qZOx9zQJpSHxKgyVUZA5D1/zYnouD65uHS
   PSfOalUoIqnY46jkNIVk2QGqFlyP9kybsuxokPTjx4tzXHJEl7TykTpC5
   l+qTdI5crlVWCUMWIIxs+CMtPvQU8bN+Adv7mLObvlVjYbqc6GpUReXgs
   WRypPWfJSTe2f+13v4FBcgPGu/VkM1rH7kdfauSi8IEzmTcNDNIPx2T9S
   2knMBWmwO0Nw8D9Bsppgg2gJvamElmSo1/yCl9osflcpsmcAwslJg0BQY
   g==;
X-CSE-ConnectionGUID: 4YS9oOOnTzuv2Jf7mAu9VA==
X-CSE-MsgGUID: Q3KtfCv3TMKXm5imjnfrnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99957455"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="99957455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:38:46 -0700
X-CSE-ConnectionGUID: VE03psLdTB6kjGBhozlsPA==
X-CSE-MsgGUID: n8TeEG4fQH2GCUeQ2ya0lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="266264884"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:38:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 19:38:40 +0300 (EEST)
To: Krishna Chomal <krishna.chomal108@gmail.com>
cc: =?UTF-8?Q?Arda_Do=C4=9Fu_Ari?= <arfeliousheres@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-wmi: Fix board_params typo for 8DD6
 board
In-Reply-To: <apKKuL5lh2OK-6lq@archlinux>
Message-ID: <8cc78401-cc88-3136-5d72-eaab779a8690@linux.intel.com>
References: <20260827235139.154462-1-arfeliousheres@gmail.com> <apKKuL5lh2OK-6lq@archlinux>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-636132106-1788194320=:2637"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-636132106-1788194320=:2637
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 29 Aug 2026, Krishna Chomal wrote:

> On Fri, Aug 28, 2026 at 02:51:39AM +0300, Arda Do=C4=9Fu Ari wrote:
> > When adding support for board 8DD6, &omen_v1_no_ec_thermal_params
> > was passed as driver_data instead of &omen_v1_no_ec_board_params.
>=20
> Hi,
>=20
> When I added support for 8DD6 [1] &omen_v1_no_ec_thermal_params was
> indeed the correct quirk. But because Radhey Kalra's board-specific
> feature data patch [2] was accepted first, my patch probably lead to a
> merge conflict that had to be resolved manually, which is why this is
> subtle bug got introduced in the first place.

It's my fault for not catching it (though to my defence, I got sick around=
=20
the time the merge window ends so I had less time for handling the patches=
=20
in the first place and I only now realize compiler won't catch this=20
problem for me because the old structs are still there).

> > Because active_board_params expects a pointer to struct
> > hp_wmi_board_params, dereferencing active_board_params->thermal_profile
> > results in a type confusion bug and invalid memory access. Update the e=
ntry
> > to point to omen_v1_no_ec_board_params.
>=20
> Thank you very much for observing and sending a patch for the same.

I've queued the patch to the review-ilpo-fixes branch already. If Krishna=
=20
wants to give a reviewed-by tag, I can still add that to the commit.

--=20
 i.

> [1]:
> https://lore.kernel.org/platform-driver-x86/20260623141314.33947-1-krishn=
a.chomal108@gmail.com
> [2]:
> https://lore.kernel.org/platform-driver-x86/20260615091034.987029-1-radhe=
ykalra901@gmail.com
>=20
> > Fixes: a7320d6eb9c42 ("platform/x86: hp-wmi: Add support for OMEN MAX
> > 16-ak0xxx (8DD6)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arda Do=C4=9Fu Ari <arfeliousheres@gmail.com>
> > ---
> > drivers/platform/x86/hp/hp-wmi.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/hp/hp-wmi.c
> > b/drivers/platform/x86/hp/hp-wmi.c
> > index b2773fc1aca4..615b4cf6fc45 100644
> > --- a/drivers/platform/x86/hp/hp-wmi.c
> > +++ b/drivers/platform/x86/hp/hp-wmi.c
> > @@ -337,7 +337,7 @@ static const struct dmi_system_id
> > hp_wmi_feature_boards[] __initconst =3D {
> > =09},
> > =09{
> > =09=09.matches =3D { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
> > -=09=09.driver_data =3D (void *)&omen_v1_no_ec_thermal_params,
> > +=09=09.driver_data =3D (void *)&omen_v1_no_ec_board_params,
> > =09},
> > =09{
> > =09=09.matches =3D { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
> > --=20
> > 2.55.0
> >=20
>=20
--8323328-636132106-1788194320=:2637--
