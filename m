Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472251;
	b=q6HjLFmS1IKnQnPjOInXmOIrqgPfvSF+iWWpbMjVL7EmWN0deN9dast7JF+XuWzoa2LH
	 o/2y8EvKYAeFftOR1HtvdlXxcOxOJlO9ZODcbRG8PJZVrypwVTCrhCsV5XGr1HMyMkWpi
	 pA5PWIra13s+KKtBXvwgEv3Oc0GFTp0dbcvz4Am1SraYKION8KjaSLIpRRHh6humsaqaX
	 WBbmRAxefx4shYCHYdqQwrskex+0K6xF0KcYWTXO4M3HF4hDo9ITt/QMkWIdhEIbJ+CAv
	 x+rdFnVIxJ1/9Xkp0uZl9I8p/OlD3udv/ZtIuMfIPszKHUbfaXRgWwaJqeAHJa1rnkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472251;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=mMIvcPvFqCSYPQj2FU9GTgu9elQHAqrDdqf8k26Hkxk=;
	b=pxbXhmTadd/JLs8OyESwJDVZFU2mzOoi1jDrbgBaN/frNGr0cD8AEo7uEVq3LUpTCiYW
	 hKm7yg87YiLnb1T9F3i+H1RmI6T2eIKiXCOvNUrCxzDD8RcrM+83T/rO2uhQ0PI4PR1OK
	 j+F7eVXeC+J6Wl3qdIJtmWuR8Jxbidqieg2v1e8IXC4w9/3k9PUKqXsSAuLmq6hBYBn8T
	 94/NukKHGNMzlXxCAfNvvaLZFebVue8AuZcOwCntOZO0D+c+gsnfFFtG+GfVFCxggUi6b
	 FOOfsIeLFBR0HhI2obQF2vxo/tvmH5wqKiPvTrKf681QduZ/4q9AmrUTak7OKPH+Mmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHYjcDCY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5764606A88F;
	Thu, 12 Nov 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHYjcDCY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472250;
	b=Nafxj7xWh5/sBkFQ4QTXJmWvH+Scw06fewEFGPoOs1ArhsxDqMlzOXLFossl3Xe1RjjC
	 PWvsE2cbP1J7YPSikLRhlqjfpPvE0siW4GS2Brb0Q3u6+eXGqjOlEUGDY/Y+K2NrqWtsX
	 iI/CyuaF9Glke3HMFHijVlM40EcGLkTQsm+CzISH/8js4GdjXwu4n6gewdJAhTNi7oiwQ
	 6BZ55QQ/I1l6gnr5JKZ4MoWvQAyUnRhnL/Nu+YZp+FUV8KNe8dsHcpvxIngZEtvoWmGW8
	 AiO88kbxMO+U98mq9fUoUs8KK/5v3ChfVNXM1HrYDeynNMZILvd8sHDiGMVo6gCcrIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472250;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=mMIvcPvFqCSYPQj2FU9GTgu9elQHAqrDdqf8k26Hkxk=;
	b=Q4bLi53RWYLSnt2OwEqV2sdPhcojR5O34mYQWQScZPIU2nubzVUJchKnVeaWDhh43zXU
	 NuxB0qqKKR3qiE1uxHRRfVQMMF+6hGCjdxuI50kH5IqhhmIY1wFJcvzM9ysKhpBvgOPIJ
	 bsgu6BO4Cw5/4uDTqmHC+LGLw9wgFYs58UVbq/bJ2LQY51HUljHmimHIV3o7kQWb45csn
	 vkAqQD4Z09k2c8ur2mnHFVEw0PqYrhx0m2u7EIAaUmrVZ7vCJ05VuLBtmAvp42DXY3n+r
	 0P1I2t+SjRF+wxLh7+rPLbseFwFI1ZwAKI4FRZxejlWZ+66cVryboNF5m/h3+Fx9g8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 855621F00A06;
	Thu, 12 Nov 2026 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472250;
	bh=mMIvcPvFqCSYPQj2FU9GTgu9elQHAqrDdqf8k26Hkxk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=NHYjcDCYwN5r8+CRb7bqJNjl3lXeSJJn7+NyzORRcF3ZVEKGJan8sXL8Bgsj81x+u
	 qBrcNWczGg4wascGdXDiz06398MtwsW0Jqm5cWET+qU5hpwwRGxa/3F7rCaDmyBbxm
	 aaxAEQkV7iJw1cXQZ6GoeqBkPoF2nhS4p0b6tkoYbBMO93IzdER60PTDHd62wZC+vx
	 D5lL/bGTW8EYucClose5vwZDBTApJhjJGhY2eWkAtFg76s/rNcBNV5mZJ7HX+Nm9rj
	 x7cH4238SOC5mQh0vj5cNdjN+jsAx0Km8ox1Abz/thkxg/D/L2U7pnQdCPb0FRxB6W
	 5LyYs4oZTTifQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D5F5349379;
	Thu, 12 Nov 2026 08:30:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/6] media: verisilicon: Recover the Rockchip VPUs from
 faults and timeouts
Date: Thu, 12 Nov 2026 08:30:46 +0000
Message-Id: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ7CIBBEf6XZsxggulFP/ofpAXBp19higBJN0
 3+X1rPHN5l5M0OiyJTg0swQqXDiMFbQuwZcb8aOBN8rg5YalVJS1DDHIGKwU8oCDbrTwZO1EqF
 uXpE8vzffrf1xmuyDXF4la6PnlEP8bIdFrb1/7qKEFGhR49nJo/Xm2g2Gn3sXBmiXZfkCyBWcG
 bwAAAA=
X-Change-ID: 20261110-hantro-robust-6a6c84febb06
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472247; l=7383;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=m+13bdShTWeHrSiZD216tmi9lGJSIdBZ/1vqbkocIZg=;
 b=Kso7ZS+UtrZ2ZE3zhCKTvb2uz3i2nS4D0DH4M+OHRde87WIrqQowlY5rVeubZt89EwoVq0/Re
 ubjTXyh2c6eCKE2MYQXx0W48byJbYWUmMKzY1DCbyqO+a+rzLmdHZdI
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

This series makes the Hantro driver recover from a job that times out on
the Rockchip VPUs, and stops it from holding a VPU in reset after
remove.

On the RK3588, a VEPU121 JPEG encoder core that reads an unmapped IOVA
faults in its IOMMU and never becomes idle again: the register-level
stop in the encoder reset operation isn't enough, the IOMMU can't be
stalled anymore ("Enable stall request timed out"), every later job
times out and unbinding the driver can lock up the system. Patch 4
pulses the reset lines of the core on a timeout, and patch 5
reinitializes the IOMMU afterwards the way rkvdec does. Patches 1 and 6
describe the AXI/AHB reset lines of the four VEPU121 cores in the
binding and in the RK3588 device tree; the driver already handles
optional resets, so device trees without them keep working.

Patch 3 clears the encoder interrupt register at the end of the reset
operation: only the interrupt handler ever clears it, so after a reset
that skipped the handler (a timeout) the interrupt stays disabled and
every later job on the core times out. On a core with reset lines the
reset pulse of patch 4 also clears it, but a VEPU1/VEPU2 core without
them (the older SoCs) relies on this.

Patch 2 stops asserting the resets on remove and on the probe error
path: the AV1 decoder resets of the RK3588 also cover the bus interface
of its IOMMU, and holding them asserted while the IOMMU driver
runtime-suspends hits registers in reset (SError).

Patch 2 leaves the rest of hantro_remove() alone. Since 556ab0b2741d
("media: hantro: release runtime resources when device_run fails"), the
runtime suspend that hantro_remove() triggers runs after the driver data
was cleared and the clocks were unprepared. "media: verisilicon: suspend
the device before unregistering it on remove" from Sergei Khomenkov [1]
fixes that. Patch 2 doesn't depend on it, but both change the last lines
of hantro_remove(), so the one that is applied second needs a trivial
context update.

Patch 6 touches arch/arm64 only and can go through the Rockchip tree
independently of the driver patches; it is only useful together with
patches 4 and 5.

Tested on an Orange Pi 5 (RK3588S) with the series on a v7.3 based
kernel with other out-of-tree Hantro patches, which has neither
556ab0b2741d nor 8e26d4c20ed2 ("media: hantro: disable runtime PM before
hardware teardown"), so its hantro_remove() still asserted the resets
before the runtime PM teardown. On v7.4-rc1 the series is only
build-tested, and I haven't run the unbind path there. The results below
are from v1. Unbinding and rebinding the driver with the AV1 decoder
bound and a 1 s gap hit the SError before patch 2 and was clean with it.
The reset and the IOMMU restore ran on every encoder timeout: a trace of
a wedged VEPU121 job shows hantro_watchdog() ->
rockchip_vpu2_enc_reset() -> the IOMMU re-attach with no stall or paging
timeout, the next jobs on the same core succeed, and the IOMMU
runtime-suspends cleanly afterwards; ten JPEG encode jobs with an
unmapped input address were each reset by the timeout and the following
jobs encoded normally. The reset lines of patches 1 and 6 are present on
all four VEPU121 nodes of the live device tree; dt_binding_check and
CHECK_DTBS are clean.

The v2 recovery was reorganized from v1 (the IOMMU restore now runs from
the encoder hardware reset, the interrupt re-enable is its own patch,
the remove path no longer asserts the resets), so it was tested again
on the board with v2, on the same v7.3 based kernel: a provoked encoder
timeout was reset and the next encode succeeded, a job with an unmapped
input address logged an IOMMU page fault, timed out and was recovered
the same way, and unbinding and rebinding the driver gave no WARN, BUG
or Oops (on that kernel the unbind runs through the out-of-tree
teardown).

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit messages, and I reviewed and tested
every change as described above.

[1] https://lore.kernel.org/r/20261106-hantro-remove-v1-1-d0a4678886d7@gmail.com

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v2:
- Patch 2: don't assert the resets on remove or on the probe error path
  at all, rather than only for a device behind an IOMMU; the AV1 BIU
  resets must not be asserted while the device is not IOMMU-mapped
  either (Sashiko). The hantro_reset_assert() helper is gone, and the
  subject changed with it
- New patch 3: clear the encoder interrupt register at the end of the
  VEPU1/VEPU2 reset, so a core without reset lines re-enables its
  interrupt after a timeout (Sashiko: the H1/VEPU2 reset left the
  interrupt-disable bit set)
- Patch 5 (was patch 4), IOMMU restore redesigned after the Sashiko
  review of the restore path, with a new subject:
  - run it from the Rockchip encoder hardware reset, right after the
    reset pulse, where the core is known idle, not generically from the
    watchdog (Sashiko: the watchdog restored the IOMMU without stopping
    an AV1 core). It no longer runs on the AV1 decoder and its
    vsi-iommu, where Sashiko found a race with concurrent mappings, nor
    on the Allwinner H6; rockchip-iommu changes and walks the IOMMU list
    of a domain under its iommus_lock
  - only with reset lines and a DMA default domain to return to, via
    iommu_is_dma_domain(); not with an identity or ARM32 dma-iommu
    domain (Sashiko: unconditional domain swap, -EBUSY on ARM32, check
    iommu_is_dma_domain() in hantro_alloc_empty_domain())
  - on a failed attach, mark the core so every later job is refused
    rather than running through a bypassed IOMMU (Sashiko: a failed
    attach left the IOMMU detached)
- Patch 6 (was patch 5): the commit message follows the new subject of
  patch 2
- Patches 1 and 4 (was patch 3), the bindings and the timeout reset,
  unchanged
- Not addressed: the NULL match->data dereference in hantro_probe() that
  Sashiko reported on patch 2 as a pre-existing issue (a forced bind to
  a device without a matching OF node); it is independent of this series
- Link to v1: https://patch.msgid.link/20261110-hantro-robust-v1-0-6b6269c05bfa@gmail.com

---
Arun Iyengar (6):
      dt-bindings: media: rockchip,rk3568-vepu: Add the reset lines
      media: verisilicon: Don't hold the VPU in reset after remove
      media: verisilicon: Enable the Rockchip encoder interrupt again after a reset
      media: verisilicon: Reset the Rockchip encoder cores on timeout
      media: verisilicon: Reinitialize the IOMMU after resetting an encoder core
      arm64: dts: rockchip: Add the reset lines of the RK3588 VEPU121 cores

 .../bindings/media/rockchip,rk3568-vepu.yaml       | 10 +++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  8 +++
 drivers/media/platform/verisilicon/hantro.h        |  5 ++
 drivers/media/platform/verisilicon/hantro_drv.c    | 81 ++++++++++++++++++++--
 drivers/media/platform/verisilicon/hantro_hw.h     |  1 +
 .../media/platform/verisilicon/rockchip_vpu_hw.c   | 46 ++++++++++++
 6 files changed, 144 insertions(+), 7 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-hantro-robust-6a6c84febb06

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


