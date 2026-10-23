Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754101;
	b=pYvFvWRbkJEPVXsAEKy+Q9V41m1BSY4+OAkFCvNOU13BeE0Rl7xXs/Oz9/Aigya0/L9o
	 XJfUKsymzR0oQhJqF9QWIYW3mouG/VEfdB0YCIc5JrI6HU3/R5HG6IMIoLA/raU1EXM0/
	 kO4JJ/RJgAfzRyTpJjX/eGQcihi4TECjC8azdVh63nbRGgr1vQpBt7cEE2Cl2yW2Ne0op
	 /E7hj99veoIzAz++Ct/QjoX3CwE1jrC4wEp76sxiGVROG17xlbdFtR4hxPPgJlhIrayE1
	 sY+eMPBrhJdJ4ws+tawAyTmyw5zzOev/I8u6lklKL1/Yoy4jWokLE/cxPP1PKFIptZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754101;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type;
	bh=d6ctJQVdfwzPyzLh7u9IbSQ8qfT/ynOKvYsexp8Ns94=;
	b=5VulXKx8SswpkYeCmb6i2OJjb/fQzzwwUGV4+Y4PKSRYZkGwD5BqsIvegodOmbcdNWBn
	 ciCy+eb+OyFrB1dGv3G8FDYn49O98PRXoqJmuN5R4avvAgt+WEGDFQIW/4J6izT4m7UOM
	 QtPJNuCnP3BHvrVQi5EgEzLyAwqd7a5/7a0adxuvv3hKNMLteRv5wsfwZrViv9AzuoCIY
	 16Ye03XeZ8l6S1ixheigqxtkwSomEa0LjD7fG9+aY5a4oT5SlhPfx2mCeipelhzqgh/IR
	 jvsEjzBz6f4Hl+z4XBUHX56dRozmJScm4gawn9uQe7yX4NeyzUu02Lkm+0/vGHS4bBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99B606A31B;
	Fri, 23 Oct 2026 11:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D99B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: "Felix K." <fk@mutemail.de>, Mehmet Fide <mehmet.fide@gmail.com>
Cc: linux-wireless@vger.kernel.org, "Felix K." <fk@mutemail.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH ath-next] wifi: ath9k_htc: fix beacon slot selection
 once TSF exceeds 2^42 us
In-Reply-To: <20261022105656.4175421-1-fk@mutemail.de>
References: <20261022105656.4175421-1-fk@mutemail.de>
Date: Fri, 23 Oct 2026 13:14:55 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8733twsm6o.fsf@toke.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Felix K." <fk@mutemail.de> writes:

> ath9k_htc_choose_bslot() derives the beacon slot from the TSF reported
> in the SWBA event as
>
> 	tsftu = TSF_TO_TU(tsf >> 32, tsf);
> 	slot = ((tsftu % intval) * ATH9K_HTC_MAX_BCN_VIF) / intval;
>
> TSF_TO_TU() truncates its result to 32 bits, so tsftu is
> (tsf / 1024) mod 2^32 and wraps every 2^42 us (~50.9 days). 2^32 is not
> a multiple of the beacon interval (2^32 mod 100 = 96 for the default
> of 100 TU), so every wrap shifts the computed position within the
> beacon interval by 4 TU. Depending on where in the interval the SWBA
> event arrives, the wrong slot is chosen after one or more wraps. The
> state only recovers when the TSF is reset.
>
> Compute the offset within the beacon interval from the 64-bit TSF
> instead. For TSF values below 2^42 us and an even beacon interval the
> result is identical to the old calculation. TSF_TO_TU() in htc.h has no
> other user and is removed.
>
> This is the same issue as in ath9k_beacon_choose_slot(), which is fixed
> separately. Compile tested only, I do not have ath9k_htc hardware.
>
> Fixes: 832f6a18fc2a ("ath9k_htc: Add beacon slots")
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix K. <fk@mutemail.de>

Mehmet, any chance you could test this one? :)

Thanks!

-Toke
