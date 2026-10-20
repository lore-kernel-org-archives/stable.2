Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.165.235.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494926;
	b=yfR5naZOp/pAFdkyqbniyTC/0WGmQStw1Qww6mL6InZCcdzNpvO81X2lDh+vks5nUbkF
	 IsRY9nIzbAjK4Zo5Nh1Tt30nTKJJR3uMYkGIg0TM2eQIs/yb/HRY4N/+ddMD+ej9qmLue
	 VS8cSOT/sSJUypKsyt1ddqAEY+fyeEzp1ymrZ055nPz5N4UhUSwPDhmcLoSisB2E/2iJE
	 mnvbUN1doQYXSHPRPnAfESp2YfC2J3KyN86p72nDV9gIo9srTqkuY7EnR7dLncaxbciQ6
	 /V93L073iOZNEMbFCwNQBIhueLPaiTW9Iss19lAmNfce6rkmQMRzW9Z2QKo1OEUbcig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494926;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yQkQbbajxJs9ic68pd6bUQHnIJkpqAvbMwyFnVe+2yg=;
	b=ofsDgAbrzVrPsDvGqeo7nHsLclKdelse9rDfxzJGpL+95mcSSl/6NcipgUmN2Tj13dUI
	 3SmTZ/P7JmXrHXbU/ysBGK87J11SMVOxNe02uKs7H1p7KXNXfVSSDNyZ7oXxq3oFqSLZC
	 WpWIEh3VqrF49JygSBYX0E0F4IdzP0k3E/HoWBfYBQO69AKwnlfDk7f4H7KsUIbgqychL
	 gCAOTk3LpU6TuK28lL42eZoUGLXz0vQecldqzJkp1A0iVK6aqV1nsd8dK05yTOB1OI5iZ
	 xbz+z08APDvxoRhK2A5S+qTEMakif/6DaLuPME7MRWSgu1ORPGmqU9x3UCfmb2cr36g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mutemail.de;
	spf=pass smtp.mailfrom=mutemail.de;
	dkim=pass header.d=mutemail.de header.i=@mutemail.de header.a=rsa-sha256 header.s=2024 header.b=OIfkN7U0;
	arc=none smtp.remote-ip=188.165.235.121
Received: from mail.mutemail.de (mail.mutemail.de [188.165.235.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC86606A319;
	Tue, 20 Oct 2026 11:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC86606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mutemail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mutemail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mutemail.de header.i=@mutemail.de header.a=rsa-sha256 header.s=2024 header.b=OIfkN7U0
From: "Felix K." <fk@mutemail.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mutemail.de; s=2024;
	t=1792494922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQkQbbajxJs9ic68pd6bUQHnIJkpqAvbMwyFnVe+2yg=;
	b=OIfkN7U07CLMtNCicMsZj/2k7yAtmyxsQ4fX/IREo3/JjGmOzBH9WVKm0LWeUtn2JpoJrE
	tHc6hicq11y4bW67Ppgij198YCHPiytKTTbDFmbuOybsakMVoWH8uNNhCPDjvgTh25iklh
	dQCzDcRsOgf2feG8i2a3c5rhKFPWsV+kZqRSrvzPQSbZL2J7S+K42RzeRLUUusowP8caC1
	wtbU/QL90yeHybROYILPbF502HMyNJIZb4WXx43zHU829dAvitooXuAdBxajw4m35nAPNs
	9nLSXHD33ojYVjnjYRiLxQLL3MNcjQmBA+YBmWJsyOm2K/5YP9lSZUFz1qFQeA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=fk@mutemail.de smtp.mailfrom=fk@mutemail.de
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	"Felix K." <fk@mutemail.de>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath9k: fix beacon slot selection once TSF exceeds 2^39 us
Date: Tue, 20 Oct 2026 13:14:53 +0200
Message-ID: <20261020111453.3500566-1-fk@mutemail.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath9k_beacon_choose_slot() derives the staggered beacon slot from the
TSF as

	tsftu = TSF_TO_TU((tsf * ATH_BCBUF) >> 32, tsf * ATH_BCBUF);
	slot = (tsftu % (intval * ATH_BCBUF)) / intval;

TSF_TO_TU() truncates its result to 32 bits, so tsftu is
(tsf / 128) mod 2^32 and wraps every 2^39 us (~6.36 days). 2^32 is not
a multiple of intval * ATH_BCBUF (800 for the default beacon interval
of 100 TU, 2^32 mod 800 = 96), so every wrap shifts the computed
position within the beacon interval by 96/100 of a slot.

After the first wrap the SWBA handler therefore picks the vif of the
previous slot: every BSS sends its beacon one slot (12.8 ms) late,
while its timestamp is still corrected by the tsf_adjust of its own
slot, so clients see the beacon 12.8 ms after their expected TBTT.
After n wraps the beacons are n slots late (up to 89.6 ms), until the
error wraps around after 8 wraps (~51 days). This affects every AP or
mesh setup, also with a single vif, since 8 slots are always used.

Internal resets (e.g. on stuck beacon) preserve the TSF, so the state
only recovers when the interface is restarted and ath9k_start() resets
the TSF.

Compute the offset within the beacon interval from the 64-bit TSF
instead. For TSF values below 2^39 us the result is identical to the
old calculation.

Observed on a TP-Link Archer C7 v2 (QCA9558, AHB) running OpenWrt
25.12.5 (backports 6.18.26) with three AP interfaces on 2.4 GHz. The
TSF was set via debugfs (regidx/regval 0x804c/0x8050) followed by
"echo 1 > ath9k/reset", and beacons were captured with a second device
in monitor mode. Beacon timestamp modulo beacon interval, identical for
all three BSS:

  TSF                       offset
  3.40 days  (0 wraps)        384 us
  6.36 days  (1 wrap)       13184 us
  25.45 days (4 wraps)      51584 us
  44.54 days (7 wraps)      89984 us
  50.90 days (8 wraps)        384 us

With the beacons 89.6 ms late, a power saving IoT client (EV charger
controller) went from 40 ms to 1.4 s average ping RTT (max 7.2 s) with
1.9% packet loss within 9 minutes. Most other clients were not visibly
affected in that time.

Tested with this patch applied on the same device, using the same
debugfs TSF method: the beacons are no longer delayed. The offset stays
at 384 us for all three BSS with the TSF set to 0, 1, 4 and 7 wraps,
and with the TSF set to 7 wraps the EV charger controller stayed at
40 ms average ping RTT (max 117 ms, no loss) over 5 minutes.

ath9k_htc_choose_bslot() in htc_drv_beacon.c uses a similar 32-bit
TU conversion (wrapping every 2^42 us, ~50.9 days); it is not changed
here as I cannot test it.

Fixes: dd347f2fb2dd ("ath9k: fix beacon timer handling issues")
Cc: stable@vger.kernel.org
Signed-off-by: Felix K. <fk@mutemail.de>
---
 drivers/net/wireless/ath/ath9k/beacon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index 4a27e3753..8a9bd23d3 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -308,7 +308,7 @@ static int ath9k_beacon_choose_slot(struct ath_softc *sc)
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath_beacon_config *cur_conf = &sc->cur_chan->beacon;
 	u16 intval;
-	u32 tsftu;
+	u32 offset;
 	u64 tsf;
 	int slot;
 
@@ -322,11 +322,11 @@ static int ath9k_beacon_choose_slot(struct ath_softc *sc)
 	intval = cur_conf->beacon_interval ? : ATH_DEFAULT_BINTVAL;
 	tsf = ath9k_hw_gettsf64(sc->sc_ah);
 	tsf += TU_TO_USEC(sc->sc_ah->config.sw_beacon_response_time);
-	tsftu = TSF_TO_TU((tsf * ATH_BCBUF) >>32, tsf * ATH_BCBUF);
-	slot = (tsftu % (intval * ATH_BCBUF)) / intval;
+	div_u64_rem(tsf, TU_TO_USEC(intval), &offset);
+	slot = offset * ATH_BCBUF / TU_TO_USEC(intval);
 
-	ath_dbg(common, BEACON, "slot: %d tsf: %llu tsftu: %u\n",
-		slot, tsf, tsftu / ATH_BCBUF);
+	ath_dbg(common, BEACON, "slot: %d tsf: %llu offset: %u\n",
+		slot, tsf, offset);
 
 	return slot;
 }
-- 
2.53.0

