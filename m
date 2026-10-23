Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768706;
	b=uNjBDIguHI914ZujZZ8129pdateb5/JzWV9dRl9porpLwEszcKLKuBAOdEfrvIeFSD3j
	 NsOobIsQW8gqWpzTbV8w3W+n7dEw3drGJuhOWeZ4MNeE30/8ckPojHPKA6G9rDeodNxyn
	 iqoDUKKKEA/iWoHld4E9m3GohNtK/8FlT7Nm+UsqOmKJylpqft1MmaSMfW2NLQU70ST06
	 yYZnd0La2W/ESgq6V6TOroRarGVXabsG5DCXldiP7EMM9UlVpmJHBpZWQhyZeZQRztJBQ
	 g+X/h8hMdA14JqeQicoWzsWMCdR4vpCgdSRpH3ZIUnT3f6BOPn3+JJt7+JZglrQ2Ulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768706;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NpThbeRLenQaZEbopJ3XwRa198kGN+iMvl5nVTX+bg4=;
	b=HiKlELJpvvQ56+h074+Kd+OZ3ru2t59ltcae/hqE2d1efkUTlKz1r9+kMELlssWz4eFH
	 7L/epZer+XUK0HFtY+OZ44rcZMtbvaufDv+N7VrDk1vdC3qBB2cEDmWva8k5vhexB73rU
	 FEMO8BWAlMG+bBDB1iPHBuheigTc9kx+GZwYM+9MCXa08ijy5ARqrR60SHJMZL+CJr9E2
	 0axOZOku18KH3uQiPaDwtz/tWyLskcE+yllrnhjYRB+kJWMlfwjOVycfxTtNaZaYmGl3t
	 JyO+QxYkuamJDTeQ+85fRcC/FipYlaKjWQvglekKLbkqkP7f8IVkto3TnIwOeZQ+7Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6D606A31B;
	Fri, 23 Oct 2026 15:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA6D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: "Felix K." <fk@mutemail.de>
Cc: linux-wireless@vger.kernel.org, "Felix K." <fk@mutemail.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH ath-next] wifi: ath9k_htc: fix beacon slot selection
 once TSF exceeds 2^42 us
In-Reply-To: <20261022105656.4175421-1-fk@mutemail.de>
References: <20261022105656.4175421-1-fk@mutemail.de>
Date: Fri, 23 Oct 2026 17:18:21 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tsmcqwci.fsf@toke.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Felix K." <fk@mutemail.de> writes:

> ath9k_htc_choose_bslot() derives the beacon slot from the TSF reported
> in the SWBA event as
>
> 	tsftu =3D TSF_TO_TU(tsf >> 32, tsf);
> 	slot =3D ((tsftu % intval) * ATH9K_HTC_MAX_BCN_VIF) / intval;
>
> TSF_TO_TU() truncates its result to 32 bits, so tsftu is
> (tsf / 1024) mod 2^32 and wraps every 2^42 us (~50.9 days). 2^32 is not
> a multiple of the beacon interval (2^32 mod 100 =3D 96 for the default
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

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
