Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417841;
	b=YEYC20Of2HLh201YNoMOFmh5g7/dMPbOASb/9RfQeG4z7Okb92xK4PVwW6IZ653u14ES
	 vKXk1/7X/4JYC/QS2JzxaMrSEevZEetTvHwXsVI3K6g7drnVKK2yC5jeG2v7lGFvYo+lq
	 2fTOaos4F3ADbFHNzpUcxPbVzAr7GKNmb9148PlQbVZ5z/0DwPlzhpIS1CzWW3aKJS3ny
	 82RJzdO3TTl20JKE2fxhBHIi8ScCCTXVLkYiIIaR+hHzW6sY3I8ltpRyvdrriqqLGChc4
	 vKaQBielmTWwvUktsWZ87WIxl37po34FE4xQw1WUkVVk23HChYmuV+2blym20DRXUGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417841;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=l/KlXQXMuTLIq/0nUUA2btCJ2Qij7M1OVSLbyCu2qiY=;
	b=vl1kASpWUPxX/zYoxOm9kWWGxycd5jowsTf8x3dY3ivfPnVh+HM4anHt4sEcJ75muAp9
	 +S9eUGkdRJbYpGexPPWPcXIPSAoLPcaYJEFTl9yJnod8ILCpnIytwxWYpUNm+pmyRTioE
	 p60Q/v4AOAbUPtQfjf9yysgUax815LSRJn15n3Y4w1WzKM0UXaI1d2D+jR6U6pHFInZfP
	 9Aa2VK+ea4KDE6lPV0LVYRGQasDlbJMHBAyDMpUhce6DCD1X5d1eV0eKA/hDdirrGHM3C
	 zr3fOjTKf11gZwuothD/uBRCqRc92sTzv2jfrhSDc6M6zDdsFASj3uLeeC3F4xmxIVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmY2f4ak;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F6606A8B3;
	Wed, 11 Nov 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmY2f4ak
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794417841;
	b=gbNW2RmYzhLriuxX8703D6UQM+femXAQohbEWMRUHt5hyPVdQxG0EASFu0lTvC/OV/xa
	 /1VhkGhelps9v1RLpkqBvtWPOEWjdkOw9wCVP3YMX/fyFnIqXhucbT1xC1RMOOqgR/r8+
	 a5zMTT2zSp2V1DfYUCEoyFL3mmLG5F3kwRznVXUmkcxmogK9BXD/J7ds9tmb+88QE/jSh
	 OKotyAt7eHX7St/1noT2mSrtOjaiTHgol81GuuQAPVBzhEV0Yk26G73HjcIQdnQ67xwsf
	 +V+upE9B75n1aqRT2JznfMXaoZNlwWxH52xf812AJvI+boGfmSa/PlNAOV6Pwz4Pr4g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794417841;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=l/KlXQXMuTLIq/0nUUA2btCJ2Qij7M1OVSLbyCu2qiY=;
	b=goT3bWjzKKSJRX6ylVHpW42jHKNNnuJrL6P8CIPvz2eZk5aocjON8CxK140521vBPlQW
	 YZTW+ewgQxCkd4bIB6fKjF9G5fQRjvafGuzfsbK1LIu8PQNXk95O+VCo9OU46LrbDkyeF
	 Kv4IhKEYRijG63WRjs72wqSR4dYQplEchf44cMl+IhlfdwQuxJP0gFb8DCBQ521IUiEg8
	 iGBnguXNNs6xSLjp6EoiMXRmWdvlI/1EPQ89ym9PNkt52xsmKI91NrUSUCMqn3U+VjGV0
	 cIAwN4+IlXv+cswfgtA5p+MN2bkUJ51eEa2REwbNyQE4oONMMfTGOeGqTRUJKEIOCSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 831801F00A05;
	Wed, 11 Nov 2026 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417841;
	bh=l/KlXQXMuTLIq/0nUUA2btCJ2Qij7M1OVSLbyCu2qiY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=CmY2f4ak0lrY+LokFe92Iyed2p34SUhv6xPwpxyxwTquUbsCJfQAzT7zljVGAUt+f
	 rshs0ZjahkMuALc/EWZgK/NrfJaZf7s72c2DIIwoAuu7qJbNdW1qxHvBYmkCCFYhKm
	 9zuaSnw/ZMYvFkfyIxL/3o7/KnTh5VefIiAjij/IHXa2vpl4t1wXYJ6EzuljlFYSOX
	 0qT1dLp2cuNayrWyc3gqLmlCJVrnN4iYjf98R1sYkMpMP41VDmN80IEoODKwP18VlC
	 WskpOlN6vwQoPy7ZWx2wY38HMvrEAodHnjgNFtA6TPJX471uPaHrSrizKAvdtDfK11
	 zxU/XFuoKw6UQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CC8274904F;
	Wed, 11 Nov 2026 17:23:58 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] can: kvaser_usb: validate values received from the
 device
Date: Wed, 11 Nov 2026 17:23:57 +0000
Message-Id: <20261111-kvaser-usb-validate-v2-0-193dc10ca19b@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2k9GoC/32NSw6CQBAFr0J6bZv56ARdeQ/Dogca6MjHzOBEQ
 7i7IwdwWS+peitEDsIRrsUKgZNEmacM5lBA3dPUMUqTGYwyTmut8JEoK/iKHhMN0tDCaG1t2J6
 8s76FbD4Dt/Leq/cqcy9xmcNnP0n6t/7vJY0KW+OcL89EF1XeupFkONbzCNW2bV9ZfaaetgAAA
 A==
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794417838; l=1654;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=xx6KoRG8pHta6iZo+MzyuW/1BziusnRXyXorD/1oFmM=;
 b=jO7IM++jqzS8buM6ErxiVZmK1Ojp+dt0W8rNGZYFRHnpaOXp/XUc2R+p49nGR32/Eyo6bnDrj
 qot04vOMFDwCa4/fF9AQeh9JWzUxWs40baGH858bVwdNDwUC7KBEpPv
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com

Two fixes for values that kvaser_usb takes from the USB device without
checking them.

Patch 1 rejects hydra commands whose length is shorter than a standard
command.  A length of zero otherwise stalls the command loops, and a
short extended command makes the handlers read past the command.

Patch 2 rejects devices that report zero max outstanding tx, which
otherwise leads to a division by zero.

These issues were found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fixes myself.  They are build-tested only (W=1, arm64); I
do not have the hardware to test them at runtime.

---
Changes in v2:
- Patch 1: require at least sizeof(struct kvaser_cmd) instead of the
  4-byte header, so that the extended command handlers do not read past
  a short command (sashiko review of v1).  Subject changed, it was
  "can: kvaser_usb: hydra: reject commands shorter than the header".
- Patch 2: unchanged.
- Link to v1: https://lore.kernel.org/r/20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com

---
Joas Antonio dos Santos (2):
      can: kvaser_usb: hydra: reject commands shorter than a standard command
      can: kvaser_usb: reject devices reporting zero max outstanding tx

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  | 6 ++++++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-kvaser-usb-validate-33c2e34b63bf

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


