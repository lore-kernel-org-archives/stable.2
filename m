Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598F4E2F3A;
	Thu, 17 Sep 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654717; cv=none; b=qym1YTDY0K1fgiy13INEZFD1jf3BWRyKbfisiktc+WceW+m4LZAvCi7MVVqZa3ZqTiKctgjWksxtsxBRAa80Zt/n7f1gNLtcgldlBR9MT0NY6/6jFXNXjWsfCyoLoglTfvhVxxNYY3xn7KXMuuQqP+LsMoUCON7qd/wlfDxEUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654717; c=relaxed/simple;
	bh=sBxu93ntkSf2EUgxRcvdCDlKltgmL/NyoVJM9Ujl5m4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nt6aXQiTYKAlzZ2WagQapnkSyIRoj6cB1aDwe01F+y9nsNMM+AIrh3qG9zuQ2Fmh+24d+Ofe9pXo0iyRfkwzzVIPsx5Yct+SgTnjNev8dh8xXsLEPoxKUdu+44UlOJr+wGb3cTg62ExyAyIaLhFMZfXGZ6z5l1kf8bEjE+YnuX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YB2/eWbt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YB2/eWbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789654715; x=1821190715;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sBxu93ntkSf2EUgxRcvdCDlKltgmL/NyoVJM9Ujl5m4=;
  b=YB2/eWbtAckReLPI0wvr4qCdFrvlytjx0kzQRbunq4lO5X2sVfcl2PJC
   Sgo+DpFDteYBn7IyY5c0kfh8jzScR62yzy95S9gF0SiewHEdPQjAOgsoZ
   9Sy/VGdIN+j9VQ+q7BEboatayEJoopTLSLwKWlBQ9cvz4fuJR+ZNNwQal
   EG7zf+FPZ+bfrWGw3/HE4/QKaVQNx+hjmbc5fSspiKjhXmzceORZzKzl2
   rgXjmln6bWi2001O38GFMO/MQnj7VxaXWZ8VfuaVXwnYPC8yEnKXEbOcs
   CNA0FE5nQheei7qM33Kp1SV8bIXajQAzzvOkdGc0p6pjnujD5bxz3uy85
   g==;
X-CSE-ConnectionGUID: ZnYTVbupRWeyhErdDlUlvQ==
X-CSE-MsgGUID: kcKNP4bzTUKkstwHmSnKwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100744295"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100744295"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:18:34 -0700
X-CSE-ConnectionGUID: uDgtl66KRI6dxI0+WkYCmQ==
X-CSE-MsgGUID: yfJsfrAnTmGpXHOdP5UFMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2043329"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:18:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Sep 2026 17:18:28 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] platform/x86: hp-bioscfg: remove dead bounds
 check in audit_log_entries_show
In-Reply-To: <20260818191120.38556-3-meatuni001@gmail.com>
Message-ID: <248467bd-0f04-0588-4680-871f6e34ca2f@linux.intel.com>
References: <20260818191120.38556-1-meatuni001@gmail.com> <20260818191120.38556-3-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1652208460-1789654708=:1179"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1652208460-1789654708=:1179
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Aug 2026, Muhammad Bilal wrote:

> audit_log_entries_show() checks "count * LOG_ENTRY_SIZE > PAGE_SIZE"
> prior to entering the loop. Because "count" is already bounded to fit
> within PAGE_SIZE, the inner loop check "(LOG_ENTRY_SIZE * i) > PAGE_SIZE"
> can never be reached and is dead code.
>=20
> Remove the redundant inner bounds check and eliminate the unnecessary
> "else" block after "break" to clean up the loop control flow.
>=20
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v3:
>   - Remove the dead inner loop check completely instead of adjusting
>     the boundary arithmetic, as noted by Ilpo J=C3=A4rvinen.
>   - Remove the redundant else block after break.
>=20
> Changes in v2:
>   - None for this patch; resubmitted as part of the v2 series.
>=20
> Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.c=
om [v1]
> Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.=
com [v2]
> ---
>  drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/=
drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> index b57e42f29282..3b20757a3e74 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> @@ -93,15 +93,12 @@ static ssize_t audit_log_entries_show(struct kobject =
*kobj,
>  =09=09=09=09=09   HPWMI_SURESTART,
>  =09=09=09=09=09   audit_log_buffer, 1, 128);
> =20
> -=09=09if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE) {
> -=09=09=09/*
> -=09=09=09 * Encountered a failure while reading
> -=09=09=09 * individual logs. Only a partial list of
> -=09=09=09 * audit log will be returned.
> -=09=09=09 */
> +=09=09/*
> +=09=09 * Encountered a failure while reading individual logs.
> +=09=09 * Only a partial list of audit log will be returned.
> +=09=09 */
> +=09=09if (ret < 0)
>  =09=09=09break;
> -=09=09} else {
> -=09=09=09memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
> -=09=09=09buf +=3D LOG_ENTRY_SIZE;
> -=09=09}
> +
> +=09=09memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
> +=09=09buf +=3D LOG_ENTRY_SIZE;
>  =09}
> =20
>  =09return i * LOG_ENTRY_SIZE;
>=20

Patch 1 didn't apply without special trickery, this patch 2 doesn't even=20
get that far:

checking file drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
patch: **** malformed patch at line 65:         }

:-(

--=20
 i.

--8323328-1652208460-1789654708=:1179--
