Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D846313E31
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782561947; cv=none; b=cu5xF0zer3E/7MYXxGrYUXSnJTihSRgP7OPIJMCx3kyC5pvJchSHCOzUYOWc5QVIkpkFF6NdZITaHedIKvCyET55bQDDeFBgpjVbe6StnXs4qiDBQY9tse+wpdZY5XoQIpt183V5sGumcF9upKWqqF46lYNmo5wIjQtV22IAcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782561947; c=relaxed/simple;
	bh=305pDADChAkwm0KBlyaPLtqzfeYppM8yGtxTK+jbZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRqCv1RpOe+acRWWuvorCx1PEGOaE+MVj4J40HzAErve9ogG/x+DY7WuH5iM4NegGbCbFbLpJiBUwS7J60pkZjm7QlPPnKHMR18rHB3vMOOGxzYoTlekLZHXjr2Tez6xvS/mp5PTwlpJeRwPUINV3gt0R1p2y05FR1hRqibvikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ywby2RbY; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ywby2RbY"
Received: by dvalin.narfation.org (Postfix) id D121C1FECA;
	Sat, 27 Jun 2026 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782561944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8KWviT29stvgYD5ay7PcMajFqBUMZfzkXWLD9zkhpo=;
	b=ywby2RbYirDWRDDUMBxs6O5bTL1Ucmjy4GXBTuR9u5PvXVYSSjeh5KlGua1zONUK+c6YVr
	tbomiFBu1mW97BOUqzd6Sv/jHHMz9WZ1GBb0JO6S/5Lcy6KtvDVY2ybxhj6RTTf+qurI+8
	zDJ71tCXldLmeDwCVJ8xEo6D8TUD1OE=
From: Sven Eckelmann <sven@narfation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject:
 Re: [PATCH 5.10 10/23] batman-adv: prevent ELP transmission interval
 underflow
Date: Sat, 27 Jun 2026 14:05:39 +0200
Message-ID: <2307937.irdbgypaU6@sven-desktop>
In-Reply-To: <stable-reply-item015-batman-adv-elp-p10-20260627@kernel.org>
References:
 <20260626160952.123713-1-sven@narfation.org>
 <20260626160952.123713-11-sven@narfation.org>
 <stable-reply-item015-batman-adv-elp-p10-20260627@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14078849.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart14078849.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Date: Sat, 27 Jun 2026 14:05:39 +0200
Message-ID: <2307937.irdbgypaU6@sven-desktop>
MIME-Version: 1.0

Hi Sasha,

On Saturday, 27 June 2026 13:26:17 CEST Sasha Levin wrote:
> > @@ -939,7 +939,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
> >  #ifdef CONFIG_BATMAN_ADV_BATMAN_V
> >  
> >  	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
> > +		u32 elp_interval;
> > +
> >  		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
> > +		elp_interval = nla_get_u32(attr);
> > +
> > +		elp_interval = min_t(u32, elp_interval, INT_MAX);
> > +		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
> >  
> >  		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
> >  	}
> 
> The backport computes the clamped elp_interval but then stores the raw
> nla_get_u32(attr) again, so the min_t()/max_t() clamping is dead code and
> the underflow this patch is meant to prevent is still reachable. The store
> should use the clamped local, matching the sibling orig_interval block just
> above it in the same function:
> 
> 		atomic_set(&hard_iface->bat_v.elp_interval, elp_interval);

You are correct. I copied basically this backporting error from 7.1 up until 
5.10. This makes this specific patch invalid in each patch series from yesterday.

Correct one (as you already wrote) should have looked like this in each stable 
kernel version:

--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -939,9 +939,15 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
-		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		u32 elp_interval;
 
-		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
+		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		elp_interval = nla_get_u32(attr);
+
+		elp_interval = min_t(u32, elp_interval, INT_MAX);
+		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
+
+		atomic_set(&hard_iface->bat_v.elp_interval, elp_interval);
 	}
 
 	if (info->attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]) {

Do you just want to drop this from each patchset and we deal separately with 
it? Or do you propose a different approach?


Btw. If anyone wants to do range-diffs of these patchsets against the upstream 
patches:

git checkout -B reference 1e2fa2b10c234578d3c98c70f89c04a7aba4db92
git cherry-pick df97a7107b16375a10a36d7a63e9b4291a8ac680~1..edb557b2ba38fea2c5eb710cf366c797e187218c

# here just my own batadv/lts/7.1 branch:
git range-diff stable/linux-7.1.y..batadv/lts/7.1 3bd64ca11d9a1672d67d3130a7264c2cf7f93cdf..reference

Regards,
	Sven

--nextPart14078849.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaj+8kwAKCRBND3cr0xT1
y0DuAP4yVAIMpFhQrmJF7jwRwgc/BeS4wNacHl4ZqX95dZanlgEAk8daM7dfpV0x
KdiSnOtOUSHaKbOkqMC5rjiSUla9XQw=
=4gpv
-----END PGP SIGNATURE-----

--nextPart14078849.uLZWGnKmhe--



