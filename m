Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768722;
	b=oOJJJ12sk6oMz5zerbACO581oni9HQq5oao9pKdoiyrvtnaLgDYgeYQMLfr55jbXtLbv
	 tARrR905cw90xSHnuc2qDAnWdHpB1ja+xD/iuVTSFnba1nrwktc/o0U1IHF/uSgPWk2RR
	 JskUJJ2y/GNoCz71sjbpMU3iZ3XCQ7yzEs+Ri77JbGJuPJyfNa6D7Meg54OPid8gFDc7t
	 dhklgrDw/R1m8+YYv5ucZa4Q92LZqelnwNDrv4tZXLTpwxc/2xoqOL4US8wh7W2kD7gwU
	 Ur1FiuaNmESPwzZtoFilpc28pYuBntGbYdbW9wYyfs7zdu9I9SR/6lrTbZzOwjtZxnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768722;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=54U2YWkn8dZgUs6TPxV23ygtvqSfh3hYkr8iX2Wh1BQ=;
	b=IUqTRTbS8FBNGvm5+dF8LDb9y4uqJbwXNQxmznmhUc8ywLdY8JkFSCqeGFxSHwUvl32l
	 NSLh3s/Jo18CnGHGiRV5g8iGiOTLSgBFuHuMgAMC+ApdAfBWDhI77CiSXJR74H+TmyNu+
	 E0+6YpebGxNdUvNvJaDl1F6FB8Vr/5V0RFYsDbRkRWI4FhU7Z72/3PQiho0lM6yK5dH6W
	 3N+znu/PPoNyF2yXC+ZHBi1Rx5mqSuE1MZ1HcYL5FtR+1AHyMl0IyjCWpv+G/Pg/+r1Aq
	 l49nV6SOzHIFCVpqS6BUj7hjdo+gWYFiqKdaBqCO9NmtUI0cBnHDholrQokdQJS/2Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DC606A31A;
	Fri, 23 Oct 2026 15:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 084DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: "Felix K." <fk@mutemail.de>
Cc: linux-wireless@vger.kernel.org, "Felix K." <fk@mutemail.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH ath-next v2] wifi: ath9k: fix beacon slot selection once
 TSF exceeds 2^39 us
In-Reply-To: <20261022105552.4174828-1-fk@mutemail.de>
References: <20261022105552.4174828-1-fk@mutemail.de>
Date: Fri, 23 Oct 2026 17:18:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87qzhgqwbz.fsf@toke.dk>
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

> ath9k_beacon_choose_slot() derives the staggered beacon slot from the
> TSF as
>
> 	tsftu =3D TSF_TO_TU((tsf * ATH_BCBUF) >> 32, tsf * ATH_BCBUF);
> 	slot =3D (tsftu % (intval * ATH_BCBUF)) / intval;
>
> TSF_TO_TU() truncates its result to 32 bits, so tsftu is
> (tsf / 128) mod 2^32 and wraps every 2^39 us (~6.36 days). 2^32 is not
> a multiple of intval * ATH_BCBUF (800 for the default beacon interval
> of 100 TU, 2^32 mod 800 =3D 96), so every wrap shifts the computed
> position within the beacon interval by 96/100 of a slot.
>
> After the first wrap the SWBA handler therefore picks the vif of the
> previous slot: every BSS sends its beacon one slot (12.8 ms) late,
> while its timestamp is still corrected by the tsf_adjust of its own
> slot, so clients see the beacon 12.8 ms after their expected TBTT.
> After n wraps the beacons are n slots late (up to 89.6 ms), until the
> error wraps around after 8 wraps (~51 days). This affects every AP or
> mesh setup, also with a single vif, since 8 slots are always used.
>
> Internal resets (e.g. on stuck beacon) preserve the TSF, so the state
> only recovers when the interface is restarted and ath9k_start() resets
> the TSF.
>
> Compute the offset within the beacon interval from the 64-bit TSF
> instead. For TSF values below 2^39 us the result is identical to the
> old calculation. TSF_TO_TU() in ath9k.h has no other user and is
> removed.
>
> Observed on a TP-Link Archer C7 v2 (QCA9558, AHB) running OpenWrt
> 25.12.5 (backports 6.18.26) with three AP interfaces on 2.4 GHz. The
> TSF was set via debugfs (regidx/regval 0x804c/0x8050) followed by
> "echo 1 > ath9k/reset", and beacons were captured with a second device
> in monitor mode. Beacon timestamp modulo beacon interval, identical for
> all three BSS:
>
>   TSF                       offset
>   3.40 days  (0 wraps)        384 us
>   6.36 days  (1 wrap)       13184 us
>   25.45 days (4 wraps)      51584 us
>   44.54 days (7 wraps)      89984 us
>   50.90 days (8 wraps)        384 us
>
> With the beacons 89.6 ms late, a power saving IoT client (EV charger
> controller) went from 40 ms to 1.4 s average ping RTT (max 7.2 s) with
> 1.9% packet loss within 9 minutes. Most other clients were not visibly
> affected in that time.
>
> Tested with this patch applied on the same device, using the same
> debugfs TSF method: the beacons are no longer delayed. The offset stays
> at 384 us for all three BSS with the TSF set to 0, 1, 4 and 7 wraps,
> and with the TSF set to 7 wraps the EV charger controller stayed at
> 40 ms average ping RTT (max 117 ms, no loss) over 5 minutes.
>
> ath9k_htc_choose_bslot() in htc_drv_beacon.c uses a similar 32-bit
> TU conversion (wrapping every 2^42 us, ~50.9 days); it is addressed
> in a separate patch.
>
> Fixes: dd347f2fb2dd ("ath9k: fix beacon timer handling issues")
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix K. <fk@mutemail.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
