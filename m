Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED04430CDD;
	Fri,  4 Sep 2026 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516248; cv=none; b=Bc7ScyWZF856i1C8oPk51FvbCWo+xQyisvV+RCBbY9S77tyTUsPqKW57Ial+KZ21fJNh+S6De/R+Jy1DgiFJ3suukpI3C0V349S5pDvxnfOc3QMXuDuq5mynTtsLyMUR4TTvthkG6fsSysF+Q9NA5CIfrujWj8Gj5jMS/LtQFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516248; c=relaxed/simple;
	bh=hbEHNZjNb2+Ld3Mkt0yA0iOhtAQ67RA2zuLHvbusUTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJgCQ2uOsGb55deZIqlapdvo9eZzBSFuoUBmEqEgTW8YgzOuXtL3G+cSddfryRz8+UE3K+21fFnxPrOSE39f++t3/+5jdeyZN+R84RcqwB1inMaaRI11uKCrjvN5AdHqK9i05JI7b/5fTdRBpv99DNJhdeS/lD29bUM8olCoIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ATsOQn+E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ATsOQn+E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mMGMmTBPnv/kImMcTLVTQXomXRkjMP0R6Sz7NE/gcLA=;
	t=1788516246; x=1789725846; b=ATsOQn+EFB9KwZQo7drrxpezyN2pxgFDqc0Yjfws10lSx4D
	lB+8Ifkw8ajYhK3E9kNbP1c4i1qHxihBbhShgJMCbqxYAxUaoZYdbabsvzwUE02np8oPjc+0kwWA5
	Bpxll3pmBU032V0atM8YOllm5yTVYSuCcD7sXUk5EZc13OcCbnn2B1HzbB08+XIKaR+vL+DYSTi9Y
	FazLKdAZ8xkFcdJTH4ov+Q4vJ1BxeNdW1tx5YSfSQLk8o4Edlrgn9/UQd4Jj+zoCMGq/I8LFqnM5H
	xY06v6HTPNKO2lBQWiYMvD50N/yoVIqrFESo9nlGqo0bmwMZ0PPUE2FLp4Jr+Khw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x2Qm9-00000001JsI-2cN9;
	Fri, 04 Sep 2026 12:04:01 +0200
Message-ID: <bad8369e7e41339f443c0d018bfa7243e8c284b9.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mwifiex: validate HT/VHT capability and
 operation IE lengths
From: Johannes Berg <johannes@sipsolutions.net>
To: Doruk Tan Ozturk <doruk@0sec.ai>, briannorris@chromium.org
Cc: francesco@dolcini.it, kees@kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 04 Sep 2026 12:04:00 +0200
In-Reply-To: <20260814134707.85925-1-doruk@0sec.ai>
References: <20260814134707.85925-1-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-08-14 at 15:47 +0200, Doruk Tan Ozturk wrote:
>=20
> Assisted-by: 0sec:multi-model

If you're going to use LLMs anyway, how about you ask another instance
to review your patches? :-)

>  - Use sizeof(*ptr) for the length checks instead of naming the struct
>    type, so a check cannot drift from the type the pointer is
>    dereferenced as. bcn_ht_cap/bcn_ht_oper/bcn_vht_cap/bcn_vht_oper/
>    oper_mode are all typed pointers.

> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -721,7 +721,7 @@ mwifiex_set_sta_ht_cap(struct mwifiex_private *priv, =
const u8 *ies,
> =20
>  	ht_cap_ie =3D (void *)cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies,
>  					     ies_len);
> -	if (ht_cap_ie) {
> +	if (ht_cap_ie && ht_cap_ie->len >=3D sizeof(struct ieee80211_ht_cap)) {

missed that, ht_cap is in scope so can be sizeof(*ht_cap).

johannes
