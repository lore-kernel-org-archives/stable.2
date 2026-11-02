Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793585583;
	b=lgiiYLqzWpGz9QY4PtSKUpqLRBKY8UOuIX3ZYmU9GDLwp5JrNK0EOG7Vx73Kw+lJU07R
	 Qij2DEy8jqPXmrDMyKRnRaS8KF3sDldLKGU9yfT6n3KC+cP2p7B2+zJTzd31EWvxKd1fN
	 4V2C9uNWzHJyD3dge4dUtfXveAqtlVsjmWp7ZaZf3HVpS95ec1iKgSaJ2zy8JbQHu/Hr6
	 He1LK3FBPFvEP34nyE592G0W5zQpHBJwhkB7rUakfBx5IBgq3IFjiVl5ed/N5tCJQvpce
	 Xx9gBjsr+01B0Dkubzhm56eIjMU8P/o/mZaFViZW50z6g08mJbKVEN3Nqd4/YA3wrIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585583;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=m+k6QOx2WMlJwxbMEddQAaW2QkgCRdHnyuopLFhNx/o=;
	b=edXrJreyGOgBC3gIpmhSEiwpgfYpgdizdYepcRkOHWkU0+r0CqBAiQaZ29U+XlhrywKr
	 Cw1NuQTojAKG5OI1tgyJxYAIP/aIH8Rroj7hRu9OwM7V5tELAJZ/GtfyMuZSvOg3Xr+41
	 PdSE9cEuhGiV3B8w0o2Hxgkzl27QSOzo9T15bw6J7ufonyIUB/dO9b4szUmuTK4dbVhdc
	 M4Ldf2pPOQ8aK3E8vZnwUfbt1ap4llIRNRv6bzLBpPwCNhDWQHoTIWyQAH/+CTLRBa2Y0
	 3ZWLgeJu68E4hv2tPOxwn6bVGDdeem36uWyVutIuWe009nOq48ksqq1Wr2cciX9nokA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vvw5jENX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5CB60A2629;
	Mon,  2 Nov 2026 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vvw5jENX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793585583;
	b=jSuRc0diXHvHrBnGrML5pFG7YTAUUcoxAVhyq1OajM4QsmTvhZLSzzui1j/DJNvp9Nc3
	 m/gilja1+qTzuDcJntHFxFp+CshHlVZ5/yd8C5r9TOvXUGWnVtEznXQ67xHjG5S5yM2Zl
	 XETS/4qvfkRUItsqZNVwqhEyMcYxon3/bRhWvJJxKsSSpirb/SKlFNx7JYs2lhNkbhvMd
	 bSv5K3x9Ozu5RQkJqv7sckeebXLEIpk3chzAJZc/7nZgN2ww0RH0jZ4ATbiK6pCpnVkKK
	 49vp8KyYg+ZMs3/YreJltXdCPIdn54wQRAPzNlD/OWUUteekHUmJXDCYbXLjTCBRv2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793585583;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=m+k6QOx2WMlJwxbMEddQAaW2QkgCRdHnyuopLFhNx/o=;
	b=gD9gjK0KsurrTZ96RxxDzoN9jDi3dQAjvnnf1IlU/sxwV4lmMGL3Um8zbJ8kOL5FEUSI
	 kIjwYEaXw3Q6A3GA5JVR3roJQBfUw+v82DgcPJyGhrdiOEXVUenqFyPabykRC3PzxzlPK
	 F9ETpqUwPqgDakmbGVjQ1fgFSHxIGSy5BYUCihVgE0b5EPaX23rxl6l1UbJh8/CA2AmiG
	 B6WcNCuw3Gjhfe+ANay4r5CQDe5GAE1xp+9WdsK+BX/7S+Dr4TlR6jQGU/Ld9NdDSP1bi
	 xBFuchvMD6ovmlWXas2geJ8MZ4lkKpLuur9OkMrT2ATu3aHISnMe6D9ETFvJanbsp3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 67F701F00A1F;
	Mon,  2 Nov 2026 02:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585583;
	bh=m+k6QOx2WMlJwxbMEddQAaW2QkgCRdHnyuopLFhNx/o=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Vvw5jENXfKA/z4BiJCngywx7bHZTbEleXdWEEMZGa6u9jMRnxAzdfeSCIeZ1P960r
	 5v15JnfMTRbQqEXO6C5oCv7BfxRQY+jauk+Rw75amgsDHkYKd9UVc0KXcWjhqs7KNe
	 +e1vPPRtKAf/9BtbFZ3ywX4qX+8bZHGq/w806iKRoD8HvDr/iTjn0gaRgGpNzmspN5
	 YxEh7weaSKAHU5HjLrezsWbnhRKbwFvkZTVLgKP4YATwtzob1LKBju9lzgjlHecDty
	 cLclg+EBTegSXngURvVrS8++oBYhu8pHD6GeLSocXWtIHByUAphqbOtGI9siGqDWdm
	 nizzGKeiCLNuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BB9AD4630E;
	Mon,  2 Nov 2026 02:13:00 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Subject: [PATCH 00/10] leds: ktd202x: Add Etek ET6326, hardware breathing
 and fixes
Date: Sun, 01 Nov 2026 21:12:24 -0500
Message-Id: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMSw5AMBSF4a3IHWvSB5XYihjQXlwSpC1pIvaum
 J1vcP4LPDpCD3V2gcOTPG1rgsgzMFO3jsjIJoPkUgvBBVuCTTsyDFpJzSqFVvFCm1IVkE67w4H
 iF2za3/7oZzThrcB9P/LXpm5yAAAA
X-Change-ID: 20261101-ktd202x-et6326-73ed3046c534
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793585579; l=3791;
 i=joseph@telaak.dev; s=20261102; h=from:subject:message-id;
 bh=5szKME+RGUgTgRCPG18UXULk6pa/gRroJHRqBmosyr0=;
 b=INmn57vmR2Y+hFB0wQpY4QXWmisJAw7xElGPF+GR1w2yRrNievb3OzDiT6s7gU0SmNV5OHd8m
 or7ArLy4GBTBSabguA3yK+Ec8Cyr84LUTdRU9pBITbFPDZWGPC3vVnV
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=OmwSusdK4grZpiuZVfCZAvYyqz9FBkNemsV1EnHyVr4=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261102 with
 auth_id=1382
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev

The Etek ET6326 drives the status LED of the GL.iNet GL-SFT1200 (Opal)
router. It is register compatible with the Kinetic KTD2026, except for
the flash period: Reg1 = n is (n + 1) * 128 ms on the ET6326 and
256 ms + n * 128 ms on the KTD202x. Patches 5 and 6 add it with the
KTD2026 as fallback, so older kernels drive it with slightly off blinks.

Patches 1 to 4 fix bugs that have been there since the driver was
added, and come first so they can be applied on their own:
- a blink shorter than 256 ms became a 16 s blink on 32 bit
- with fewer LEDs in the DT than channels, as on this board, the driver
  read past the end of its LED array
- a blink with a very short on time was programmed as never on
- delays from the timer trigger that add up to 2^32 (or 2^64) divided
  by zero, and long blinks overflowed the on time on 32 bit

Patch 7 lets the pattern trigger's hw_pattern use the chip's rise and
fall ramps, so a breathing LED needs no I2C traffic. Patch 8 honors
led-max-microamp on single color LEDs: the GL-SFT1200 drives three LEDs
in parallel on each channel at 1.375 mA, and the driver's full
brightness is 24 mA. Patch 9 fails the probe when nothing answers at the
address. Patch 10 stops a second blinking LED from silently retiming the
first: it shares the flash timer only with the same timing, and
otherwise blinks in software. The second PWM timer is no help, since in
the timer slot the driver uses it repeats the first.

ET6326 datasheet:
https://www.etekmicro.com/wp-content/uploads/datasheets/ET6326_datasheet.pdf

Tested on a GL-SFT1200 (SF19A2890, MIPS32) with OpenWrt and Linux
6.18.55, with the two LEDs of the board (blue and white, three LEDs in
parallel on each channel, led-max-microamp = <1375>):
- brightness 1 to 11 (max_brightness 11 from led-max-microamp), and
  waking the chip from sleep
- the timer trigger from 1/1 ms to 500/500 ms; a camera measured a
  0.916 s period for 896 ms, the same 2.2 % slow oscillator as with the
  stock firmware, so the ET6326 period encoding is the one used here
- breathing through hw_pattern, written right after selecting the
  pattern trigger
- invalid patterns and finite repeats rejected
- a second LED blinking at another rate falls back to software and
  leaves the first one alone
- 240 writes to one LED while the other stayed lit, module unload and
  reload, and a reboot while blinking
The bug fixes were also checked with a simulated chip under ASan and
UBSan, and the series builds with W=1 on x86_64, i386, MIPS and arm64.

---
Joseph Telaak (10):
      leds: rgb: ktd202x: Fix the flash period of short blinks on 32 bit
      leds: rgb: ktd202x: Fix an out-of-bounds read with unused channels
      leds: rgb: ktd202x: Never program an on time of zero
      leds: rgb: ktd202x: Fix a division by zero with long blinks
      dt-bindings: leds: kinetic,ktd202x: Add Etek ET6326
      leds: rgb: ktd202x: Add Etek ET6326 support
      leds: rgb: ktd202x: Add hardware pattern support
      leds: rgb: ktd202x: Limit the LED current to led-max-microamp
      leds: rgb: ktd202x: Fail the probe when the chip does not answer
      leds: rgb: ktd202x: Don't let a blinking LED retime another one

 .../devicetree/bindings/leds/kinetic,ktd202x.yaml  |  15 +-
 Documentation/leds/index.rst                       |   1 +
 Documentation/leds/leds-ktd202x.rst                |  48 +++
 drivers/leds/rgb/Kconfig                           |   3 +-
 drivers/leds/rgb/leds-ktd202x.c                    | 423 +++++++++++++++++----
 5 files changed, 419 insertions(+), 71 deletions(-)
---
base-commit: 59cf91cf87abb67a49b1bb7b9d3b06486abde8cf
change-id: 20261101-ktd202x-et6326-73ed3046c534

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>


