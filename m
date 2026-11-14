Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.209.137.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672933;
	b=zQCv3278krrhNppTeoqjmOf9C3gxXP3xyfVl0bPNVx8N2h7wAuniN1aaZTq6WywQnw/w
	 qluVR936gsMc4cZP9J/bO7a03wSZat7aHPxk4TV2QZjd+wFFcQM7LYP3mGmxiAEhkT+ut
	 hmKgmltvbBzklP/kN0xmlM4mVIxl2CvecTnzy3hQWiQWv9c5kUdWULHwiHo7NBUwC0RD8
	 rtbE1CBxcKmlQnSsmib6/6F+Z6qs71HJazBObLYzQqtc9QlzFZa5Pr7bRxo6wVMZdHJtA
	 0vh/h1ym4VzzGaB1PfssQ6NoPKfornjjlDhQdz+dF2FJTQxoLQtrufczNM2wcFSp4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672933;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Filter:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding;
	bh=AQwsp/5IH5feaYxthFmLwwSod7DU5YkNOprXmU/SPgk=;
	b=a3jwscT04zM0DbZogW2+8ymKzlGXlzB5aB5ZLfUdHEMEOuONFAPcLoM4bQ6Y8dFE+p6D
	 qGfseldBpwNiBAae8hha/LXfN4WwWlBZfk1SBIQSow/J8ppFZ9KI2sC0B0dl5dQxettUQ
	 S80YyqfgEkcoAZ1eFpiFcYWzBfACEZRcqXdKZAgaXXU1UNTI64+0Oshb8fQPG3jSoiqcU
	 6YD32xkrPRj/t3UB5ayx2MBzLF18ZNjf1DazlOEnNe+xnRdUnkxYjcUPgqwXTOKklvc+H
	 O1gxOhzNTFFs4EqyO7k9muPf97aTpk+bxx12QTYEGBY1pMpJaRXA9Cyxoo64DQ9n0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vivaldi.net;
	spf=pass smtp.mailfrom=vivaldi.net;
	dkim=pass header.d=vivaldi.net header.i=@vivaldi.net header.a=rsa-sha256 header.s=default header.b=n47Y1VXx;
	arc=none smtp.remote-ip=31.209.137.12
Received: from smtp.vivaldi.net (smtp.vivaldi.net [31.209.137.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B54606A330;
	Sat, 14 Nov 2026 16:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B54606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivaldi.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivaldi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vivaldi.net header.i=@vivaldi.net header.a=rsa-sha256 header.s=default header.b=n47Y1VXx
Received: from localhost (localhost [127.0.0.1])
	by smtp.vivaldi.net (Postfix) with ESMTP id 3DDD2FC446;
	Sat, 14 Nov 2026 16:15:25 +0000 (UTC)
X-Virus-Scanned: Debian amavis at smtp.vivaldi.net
Received: from smtp.vivaldi.net ([127.0.0.1])
 by localhost (mxo-1.viv.dc01 [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuOZdbRINRPN; Sat, 14 Nov 2026 16:15:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.vivaldi.net D36F6FC4F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivaldi.net;
	s=default; t=1794672922;
	bh=AQwsp/5IH5feaYxthFmLwwSod7DU5YkNOprXmU/SPgk=;
	h=Date:From:To:Cc:Subject:From;
	b=n47Y1VXxyfIznn+R7exjhk4ZMWJWLMFdkKvbWe2L6rHajyuiYcwBU9Y5L2HPcOTvL
	 WWrVcauaLe5GLigP26H5pL7H/UtPtawXhVqH92vIxNZ3qVrcAVUfcza8bolC8y91YZ
	 IhxyA1AWyJfZ0tasmVY8cKSqRmC8BDUinW1IwUHXajvjxjJefEdK6jFxewOSk82ejY
	 GJZ2TK0EQs0RhqeV3ihDuDg+0YAj1KIysg9tL8m1ZmmQycTJUSKVEvoX142yGJjygp
	 Enbl3Pk8PsiYCI7cDWxjicxvljawgkl13WAXTl6+rdlCpntYi5NatAfJaQ82cChKkG
	 pfZf4IdimIyMg==
Date: Sat, 14 Nov 2026 16:15:22 +0000
From: Martin Moosbauer <martinmoosbauer@vivaldi.net>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: =?UTF-8?Q?=E2=80=A2_=5BREGRESSION_6=2E18=2E54_-=3E_6=2E18=2E63?=
 =?UTF-8?Q?=5D_cfg80211_/_mt7925e=3A_Invalid_=22Country=3A_EU=22_beacon_fo?=
 =?UTF-8?Q?rces_regdom_to_98_and_breaks_AP/5GHz?=
Message-ID: <8db36875c56cd9703dee42c7a00b81c9@vivaldi.net>
X-Sender: martinmoosbauer@vivaldi.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Hi all,

I am reporting a regulatory regression on a MediaTek MT7925 (mt7925e) 
wireless card caused by neighboring ISP routers (Vodafone Germany / 
CommScope-Arris RDK-B) broadcasting an invalid 802.11d Country IE set to 
"EU".

This worked cleanly on Arch Linux kernel `6.18.54-2-lts`, where the 
system stayed on `DE` even after scanning the neighboring `EU` beacons. 
After updating to `6.18.63-2-lts` (and also reproducible on 
`7.2.8.zen1-2` and `7.3.4-zen2-1-zen`), the regulatory domain 
immediately falls back to `98` (`DFS-UNSET`), enforcing `PASSIVE-SCAN` 
across all 5 GHz channels and breaking AP/hotspot startup as well as 
manual scans.

### Problem Description
1. Neighboring Vodafone Station routers (OUI 4c:12:65, CommScope/Arris) 
broadcast `Country: EU` in their beacons (both on private SSIDs and 
public "Vodafone Hotspot" / "Vodafone Homespot" virtual BSSs). Note: 
Neighboring Vantiva/Technicolor Vodafone Stations (OUI 98:9d:5d) omit 
the Country IE and do not trigger this issue.
2. On kernel `6.18.54-2-lts`, `cfg80211` / `mt7925e` stayed on `DE` when 
seeing these beacons alongside valid `DE` routers. Both AP/hotspot and 5 
GHz STA modes worked without issues, and manual scans (`iw dev wlp8s0 
scan`) succeeded.
3. On kernel `6.18.63-2-lts` (as well as `7.2.8` and `7.3.4`), as soon 
as background scans pick up the `Country: EU` beacon, the active 
regulatory domain is overwritten with `98` (`DFS-UNSET`). All 5 GHz 
channels are restricted to `PASSIVE-SCAN`, preventing AP startup and 
causing manual scans (`iw dev ... scan`) to fail with `command failed: 
Device or resource busy (-16)`. Manually running `iw reg set DE` is 
immediately reverted on the next background scan.

### Expected Behavior
An invalid or non-ISO country code like "EU" received from an 
unassociated/neighboring AP beacon should be ignored/discarded by 
`cfg80211` (matching the `6.18.54-2-lts` behavior) rather than 
overriding a valid active regulatory domain (`DE`) with `98`.

### System Information
- Distribution: Arch Linux
- Last known working kernel: `6.18.54-2-lts`
- Affected kernels: `6.18.63-2-lts`, `7.2.8.zen1-2`, `7.3.4-zen2-1-zen`
- Hardware / Driver: MediaTek MT7925 (`mt7925e`, ASIC revision 
`79250000`)
- Firmware version: `HW/SW Version: 0x8a108a10, Build Time: 
20260813113015a` / `WM Firmware Version: ____000000, Build Time: 
20260813113118` (`linux-firmware 20261019-1`)
- `wireless-regdb` version: `2026.09.03-1`
- `iw` version: `6.17-1`

### Regulatory Output (`iw reg get` after boot on 6.18.63-2-lts)
global
country 98: DFS-UNSET
	(2402 - 2472 @ 40), (N/A, 20), (N/A)
	(2457 - 2482 @ 25), (N/A, 20), (N/A), PASSIVE-SCAN
	(2474 - 2483 @ 9), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
	(5170 - 5250 @ 80), (N/A, 20), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
	(5250 - 5330 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW, 
PASSIVE-SCAN
	(5490 - 5725 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
	(5725 - 5730 @ 5), (N/A, 13), (0 ms), DFS, PASSIVE-SCAN
	(5735 - 5835 @ 80), (N/A, 13), (N/A), PASSIVE-SCAN
	(57240 - 63720 @ 2160), (N/A, 0), (N/A)

### Relevant Scan Dump Output
BSS 4c:12:65:ba:9b:8c(on wlp8s0_2)
	SSID: *SSID Deleted for Privacy reasons*
	Country: EU	Environment: Indoor/Outdoor
		 * OBSS non-GF present: 0
		 * BSS Transition
BSS 4e:12:65:ba:9b:9c(on wlp8s0_2)
	SSID: Vodafone Hotspot
	Country: EU	Environment: Indoor/Outdoor
		 * OBSS non-GF present: 0
BSS 4e:12:65:ba:9b:bc(on wlp8s0_2)
	SSID: Vodafone Homespot
	Country: EU	Environment: Indoor/Outdoor
		 * OBSS non-GF present: 0

Any guidance or patch to restore the `6.18.54` behavior and prevent 
unassociated invalid "EU" beacons from poisoning the active regulatory 
domain would be greatly appreciated.

Best regards,
Martin Moosbauer
