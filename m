Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71435374A1B;
	Thu, 11 Jun 2026 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180079; cv=none; b=G0U10NTbe3nUusHDPWKoBw9qy0/cfimZL5GrPiKwETRmOh/oZoo9kMlG0LVHqcV2wqnDu49H8Xwrc0nqrA9mrEErSP/Nc94+ix5EFidP5YKlzHf67tvknI9HHUtEKj2hk8p/YQ1A0cIIhn26CoG2ZV/KH1w7vMNtkJX3I7pwlMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180079; c=relaxed/simple;
	bh=pZBwQN/SvU5hzocJ4ERPh0p5USb9OMY5oE+FNcAeqgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYg7nN0cVBPsgyzkAgZ0QEEGfMtVzbL8WWZKPsw/Cl/0w+kKTddfsFhrmG/gzLLS119zn/PX1Iky+iHJQ77p0ZB+48yd7vo4CSmY4G8dfF+iTK5v4JN71lGtPVqLHCEPPPgfRXfk4BMfbze7eGAepqNzi1cRFyYtmolexk6nG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h/ysCyGJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h/ysCyGJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WXxj1mkeB6TWeJTqqo+Z4AllTELSelgmZsAG2liQDH8=;
	t=1781180077; x=1782389677; b=h/ysCyGJgxtIUNEOryO/jkwCnHmzUzjepqzxd/B5HXPGsLh
	99dZlltXiRp4JyQTEdAM/6spEVbWaIChXWPGf29u2Bq/9sbeQGuDDlSQ6133lsqd0wYPQnYaDlOoH
	eLc3DFzrGizE8v3I8u43JCKaQSRuybyHfpGRETzZnlmZDgewYt+V4eWJrpzsDklbd1gnUALwQbPvv
	CL24zbpFIlNr6NVBTkNbzvHyfRnpcZIBkCMcWdLaU05YAHP/fTgIIdWGZRHNo/JypYecuQM55tymX
	2u0R+hZVrdDh67LloYPGypEpHoboF0npBSchif3wdUKsRvVJemHmyUhorAiKoIXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wXeIt-00000008zcj-0fJF;
	Thu, 11 Jun 2026 14:14:35 +0200
Message-ID: <caf46af4de722bd220fc934dd0b94e5090c5fe10.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ieee80211: validate MLE common info length
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 11 Jun 2026 14:14:34 +0200
In-Reply-To: <20260610154303.37079-1-enderaoelyther@gmail.com>
References: <20260610154303.37079-1-enderaoelyther@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2026-06-10 at 23:43 +0800, Zhao Li wrote:
> ieee80211_mle_size_ok() verifies that the advertised common information
> length is large enough for the fixed fields that are present, but it does
> not verify that the length also fits in the containing element.
>=20
> Reconfiguration and Priority Access MLEs also carry a common information
> length octet, but currently skip the common-length check. Reconfiguration
> additionally fails to include the length octet in the minimum common size=
.
>=20
> Validate the common information length for Reconfiguration and Priority
> Access MLEs, account for the Reconfiguration length octet, and reject
> common lengths that exceed the element body.
>=20
> Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link ele=
ment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
>  include/linux/ieee80211-eht.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.=
h
> index a97b1d01f3acf..d875045abf6cc 100644
> --- a/include/linux/ieee80211-eht.h
> +++ b/include/linux/ieee80211-eht.h
> @@ -878,6 +878,8 @@ static inline bool ieee80211_mle_size_ok(const u8 *da=
ta, size_t len)
>  		check_common_len =3D true;
>  		break;
>  	case IEEE80211_ML_CONTROL_TYPE_RECONF:
> +		common +=3D 1;
> +		check_common_len =3D true;
>  		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
>  			common +=3D ETH_ALEN;
>  		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
> @@ -893,6 +895,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *da=
ta, size_t len)
>  		break;
>  	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
>  		common =3D ETH_ALEN + 1;
> +		check_common_len =3D true;
>  		break;

You just made check_common_len redundant, it's now always true.

I originally introduced it because variable[0] wasn't always common_len,
but that actually got fixed in later drafts, and we should've adjusted
that when we added +1 to all of these, e.g. commit 19aa842dcbb58.

We should probably more comprehensively change the whole thing so that
common_info_len is a separate u8 rather than variable[0], but that's
going to be much harder to do.

A smaller but probably better change would be to use the sub-structs
here that are defined, e.g. struct ieee80211_mle_preq_common_info,
struct ieee80211_mle_tdls_common_info and struct
ieee80211_mle_basic_common_info. But the layout is a bit stupid even
that way, dunno.

johannes
