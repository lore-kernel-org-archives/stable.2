Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794251066;
	b=mB7FLM9jqwpvAmQpSjbu0tvYwzCEEZmJLCC4b425YczZt5q0n7sRD90NeQV61xRCmHS4
	 woIS9C4jROg7R6WRkRdNqsOPrQ+WLu7E6URYfJ9SQyAsDBNjuAvZDh6epvk2D9xrSyZx5
	 VCFHCZmdS8RIMuV7ILu7f70OlnSZRkCc2WHJaxL2rCNOj0G1pY31LDcLjYFi9Yem1VGX1
	 3PSEcYCNyr7wkCZYnhWx0NCwRc3G+9IWnco0fRjHeYjhhyBRVcNA8JnlFr4dY1pUs81b5
	 fF+1s7+fPUbuDrbBRkMqu8WSSRXnbDeLV7JxbhnUohM/L2U/XowDgmoAqcc5suYkLQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251066;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4uA0ECMu2b55pwP9gfn3+qomka7S+BVxFd2I+0ipV0Y=;
	b=SWa1XAhdmBm94Hw1jzfV285P79Fr62xsqwrbEZDkfpnmj18NYebnwKAyxK1zGlGXSi2K
	 TkKm2rjyogbd5hTcgmKKAer09rD4mafoDUF5q8RJCOz9LShKgn83xCcnJsfzlNUo3fhYu
	 wOGFnKiHtnfErQsz6PggvPmGV7hU2hNtYbJLgA/fIipy4rbG4pZNlyXAVBG39SCoe77M7
	 uaBA49tGgUMMJmrLRw+9dQrQNm9/iqdqlaaV9oaFDpykZJyqb+lnX2ia0tBUth1WQZmKs
	 KZb0kzcYvuN86StfCvR13MLOpP/ifcsXlWAy9PXEH3WLITSVYDx+4ZfoEbSHRJjCsqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ6dbFCd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A560A2602;
	Mon,  9 Nov 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ6dbFCd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251065;
	b=gjO6dryt5hIaO9BijqNCjywwbgt45tdfI5ksyspLGPuLRdc7xVmrg602bp1Z3S8Vo351
	 j4IuwIHj/dRbK91zwlRPyIEQlmtMdwJ01yR/VbB9K4NJPI1Zsc9Q256a2eMvY3FX73FBM
	 jPcd+R/WPKZiulT+qzPlEbllN+5g41l+GC3HppYIQoFcT7Xc3PNPnkbPzTroXubbbkXhT
	 2xMEWE29b+vDzrZKmq5hEQ4MaV4hVzrJ0UsRims+SsjgPaaY/RcLZxHuhK+jeX1Kj90iq
	 YjphGjf9Qts00ob1NvdlgWaeWZkL5LFP+kdFbhwy9uNN9kBC6N68Pe31OC1LUZBkc5w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251065;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4uA0ECMu2b55pwP9gfn3+qomka7S+BVxFd2I+0ipV0Y=;
	b=I7EsGPpcxFz1NBALNlEmxLkMbWAs/+SkBJXPnSuJmhTc+9tuXqp4+hgWd1caVWptUgKn
	 DPj/3i8PNCimGTMAR3s6zpefUgDLMZ+IGXUcg7i4vLmgwv8oMu4AsIeCEDFeGk/dE7z/B
	 8L0o5tAiUWPEVlZWx3DUYTz8efnuc5CR/oIeF0mEaGTgR5xuS0B8kg4wIf0nGgNokjzC+
	 x3tmm8cTiPiPuZ0MAe3Uyn4K5p4qrYdgE5Pni1rfBvW0awX4nXg7VWQr66fq/2JdBTfwV
	 NbCQ4Tjk4OX9mFS5nADnimAHWFQFGIcj/OsRrPTtsbicNgZXFD4HBho9tilR+l+JCHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B02ED1F0089F;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251065;
	bh=4uA0ECMu2b55pwP9gfn3+qomka7S+BVxFd2I+0ipV0Y=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=WZ6dbFCdqhSg1sAOeA7dF8QlN8nglXJZBvSsLoFuYuCMM4nsguYwwFKpbVkHHGDnf
	 pyhUzI6hjyq7VCl5VF0xxzP3kYY+0l1ozFQ1i/5ziXI7UTmzN3hE6xmCmBhisuWRVb
	 QC4oz/khMXl9jOotmzFcHlQytPIUmA0GlfbH6ac2qqeufZcmzQC6z2SSswqCm7eGyt
	 YJmChJ0RrGvTzqwOIasUwyGLdFlnajfFK2T9ke871+vyKeZselSo4psBsMW29fSOr2
	 oNKJwUOyINSHxqtECkCuZe4d7EUwv499fvU5KWYWlPJlBrjmzG1alIe91Co/EnNzU2
	 Bu3SDDg4k+FhQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B33C485E2;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Subject: [PATCH v2 00/11] leds: ktd202x: Add Etek ET6326, hardware
 breathing and fixes
Date: Mon, 09 Nov 2026 14:03:36 -0500
Message-Id: <20261109-ktd202x-et6326-v2-0-56e97c226658@telaak.dev>
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
X-B4-Tracking: v=1; b=H4sIAAgZ8moC/3WNyw6CMBREf4XctTV9QDWu/A/DovRepWKAtLXBk
 P67Bdfu5iQzZ1YI5B0FuFQreEouuGksIA8V2N6MD2IOC4PkUgvBBRsilrwwilpJzU6KUPFa20b
 VUEazp7tbduGt/XF4d0+ycbNsjd6FOPnP/pjE1vsrT4JxRl0jCNEgP9trpJcxwxEpQZtz/gLqU
 V1LvwAAAA==
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
 Joseph Telaak <joseph@telaak.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251061; l=5730;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=mo03YxdyCyet1fAfFCpijqknmNkkvOo45gFPE/4DdII=;
 b=8o5GsehNbtdbJDEauQSnyKEEbRzyOecIqDfdJvlt6QzPHhlP1u6mhGOfcI1dGuZ9K02tTs4Ad
 Qvig0Ewm5B7C4rcJolgmBAk0W/r3YyUZ1ZhHUQGglwFvR6n3YjxRL0p
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev

The Etek ET6326 drives the status LED of the GL.iNet GL-SFT1200 (Opal)
router. It is register compatible with the Kinetic KTD2026, except for
the flash period: Reg1 = n is (n + 1) * 128 ms on the ET6326 and
256 ms + n * 128 ms on the KTD202x. Patches 6 and 7 add it with the
KTD2026 as fallback, so older kernels drive it with slightly off blinks.

Patches 1 to 5 fix bugs that have been there since the driver was
added, and come first so they can be applied on their own:
- a blink shorter than 256 ms became a 16 s blink on 32 bit
- with fewer LEDs in the DT than channels, as on this board, the driver
  read past the end of its LED array
- a blink with a very short on time was programmed as never on
- delays from the timer trigger that add up to 2^32 (or 2^64) divided
  by zero, and long blinks overflowed the on time on 32 bit
- a blinking multicolor LED also lit its colors at brightness 0

Patch 8 lets the pattern trigger's hw_pattern use the chip's rise and
fall ramps, so a breathing LED needs no I2C traffic. Patch 9 honors
led-max-microamp on single color LEDs: the GL-SFT1200 drives three LEDs
in parallel on each channel at 1.375 mA, and the driver's full
brightness is 24 mA. Patch 10 fails the probe when nothing answers at
the address. Patch 11 stops a second blinking LED from silently
retiming the first: it shares the flash timer only with the same
timing, and otherwise blinks in software. The second PWM timer is no
help, since in the timer slot the driver uses it repeats the first.

ET6326 datasheet:
https://www.etekmicro.com/wp-content/uploads/datasheets/ET6326_datasheet.pdf

Tested on a GL-SFT1200 (SF19A2890, MIPS32) with OpenWrt and Linux
6.18.60, with the two LEDs of the board (blue and white, three LEDs in
parallel on each channel, led-max-microamp = <1375>):
- brightness 1 to 11 (max_brightness 11 from led-max-microamp), and
  waking the chip from sleep
- the timer trigger from 1/1 ms to 500/500 ms; a camera measured a
  0.917 s period for 896 ms, the same 2.2 % slow oscillator as with the
  stock firmware, so the ET6326 period encoding is the one used here
- a 1/200 ms blink, which keeps blinking after a new delay_off, and
  delays that add up to 2^32 ms
- a second LED blinking at another rate falls back to software and
  leaves the first one alone; with the same delays it shares the timer
  in step with the first; a LED that blinks in software takes the timer
  over at its own brightness once it is free
- the timer programmed again after the chip slept
- breathing through hw_pattern, written right after selecting the
  pattern trigger
- invalid patterns and finite repeats rejected
- the same pattern on both LEDs shares the timer, and a pattern that
  cannot get the timer leaves its LED off
- 240 writes to one LED while the other stayed lit, module unload and
  reload, and a reboot while blinking
The bug fixes were also checked with a simulated chip under ASan and
UBSan, and the series builds with W=1 on x86_64, i386, MIPS and arm64.

---
Changes in v2:
- New patch 5: a blinking multicolor LED keeps its colors at brightness
  0 off. The bug is older than the series.
- Patch 6: add Krzysztof's Ack.
- Patch 7: report delay_on rounded to the nearest ms and at least 1 ms.
  On the 128 ms ET6326 period a short on time read back as 0 ms, and the
  timer trigger's next delay_off write then turned the LED off.
- Patch 8:
  - skip the colors at brightness 0, and build the channel list under
    the mutex
  - use GPL-2.0-only, not the deprecated GPL-2.0 SPDX identifier, in the
    new document
- Patch 10: the KTD2026/7 does not ACK the byte that resets it, so v1
  failed the probe on every KTD2026/7. Ignore that write again, and fail
  the probe when the write that puts the chip to sleep fails.
- Patch 11:
  - write the timer registers whenever no other LED uses the timer, so
    they are set again after the chip lost power, and release the timer
    when the write fails
  - hold the chip mutex from the brightness to the timer in blink and
    hw_pattern, and track the timer from the brightness being set, not
    cdev->brightness
  - blink at blink_brightness, not max_brightness
  - check the timer before a pattern touches the LED, and leave the LED
    as it was on -EBUSY
- Link to v1: https://lore.kernel.org/r/20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev

---
Joseph Telaak (11):
      leds: rgb: ktd202x: Fix the flash period of short blinks on 32 bit
      leds: rgb: ktd202x: Fix an out-of-bounds read with unused channels
      leds: rgb: ktd202x: Never program an on time of zero
      leds: rgb: ktd202x: Fix a division by zero with long blinks
      leds: rgb: ktd202x: Keep the unlit colors of a blinking LED off
      dt-bindings: leds: kinetic,ktd202x: Add Etek ET6326
      leds: rgb: ktd202x: Add Etek ET6326 support
      leds: rgb: ktd202x: Add hardware pattern support
      leds: rgb: ktd202x: Limit the LED current to led-max-microamp
      leds: rgb: ktd202x: Fail the probe when the chip does not answer
      leds: rgb: ktd202x: Don't let a blinking LED retime another one

 .../devicetree/bindings/leds/kinetic,ktd202x.yaml  |  15 +-
 Documentation/leds/index.rst                       |   1 +
 Documentation/leds/leds-ktd202x.rst                |  51 ++
 drivers/leds/rgb/Kconfig                           |   3 +-
 drivers/leds/rgb/leds-ktd202x.c                    | 578 +++++++++++++++++----
 5 files changed, 546 insertions(+), 102 deletions(-)
---
base-commit: 59cf91cf87abb67a49b1bb7b9d3b06486abde8cf
change-id: 20261101-ktd202x-et6326-73ed3046c534

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>


