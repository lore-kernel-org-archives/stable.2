Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588034;
	b=BRyLyuDQL+NCpEe6kTovpBmTHdcL8OHLEYRRoke1I9QuV+MRwmZyu7uPCmY9ox67D40B
	 OmxsLWsWwJjFL8U+6cCf68TiNYKVlB+lkH44SgQWYcVJMxIvmLNivBC0IN1C2fHVstHOa
	 Hc30BLt4s7sTvWKjjqFZ6VHwG+Ad3oQ9d1ChqgsCF+fdMAWJkpyLus9hcH08YxjHc0NFD
	 gdepVdQTwNSo/3upGZXcF7I/IhvKXAuRenBcae9OkEZO0QAkfDj79qnM0BNuyqG5grjaJ
	 qAHiV9gSwVtxVBVMrZd2SU2PoPlDv0w25nQVcz3eHjSD6V6msP1rRPWSR7CEYaZOabw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588034;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=WVd4kSEPcUDB7qokuhjA49SJwxaGFhZI6Dzv7ZInj+U=;
	b=BWe+Su6J8Y0D/ouR2kFDWVbS55Dj47TlsGEWGKCx5HXm4I9QPPrmBCh948OL/lWSNLcf
	 k646nqRDFFqRKm3OOX53qqg4W0F8tbgH8dJIUMIdu1NIzcgHhnOlucP5wk+v35CmLJZPS
	 DalnQq6p7TTIFDOr1cSzJss9ScvXzjAC6Y3ZRLIdi0jYWHdbn+bUDy8K3s1mdyLiHvSqO
	 /kFV0GNsIQiaWwHNm1eMm0jM4ueHAJD5fRcBuQd+a6lb41D11dG4amr++c9TVKQLHZGNd
	 lbc8zs5TX4lvGlNZZhOOG+A6cdQEQDDZvZgbwRL3sXZBfz4TMiDIO4BIkzyJauorY9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj5eNSjU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D060A6F70;
	Fri, 13 Nov 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj5eNSjU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588034;
	b=hE0uZF0VHxiW8sU53GfquPPg2Th3aVnC4qAdMYeiKNv1c1PMa//0A6bVu815kSJhhcq6
	 vKndoVIUGe+FyUwdMfj1P0eZI6W7Bomj9RRJzzteyJcgWUtJLzc2oa5vNVRCQwiKJtAW/
	 Sjfr8JjRWaCDA5vDQcH0ZJEaho3HYdsA4HPVsqipeS8zYnXYs16+deD9mBOG03z7W7aVL
	 wz2vtFDcAK64JjfwBm6TxDHle242fLtwiPXOpNjG5wYyqLi8/2Q8BH3oChp0znStPjlkX
	 r/tNXskZegTGG+Km8lWp0V+WqEjFCDkfcrq6jLKxPb9Xuj5GwN4ZjPVhTrNE2IJpO/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588034;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WVd4kSEPcUDB7qokuhjA49SJwxaGFhZI6Dzv7ZInj+U=;
	b=fBKqG/xP82hcWT0oLr7Qhv3M4DXGubK7EZ7yKgK8rNuRVlYxPco8ZaBe1c4xBDlI017b
	 D+eueRK+nnPHRp2RmaUIL8msRaqvwM7I+pGklYG7eqAs5ThJuqjQHanNlrj5PtAKBzCEX
	 6uvpo5bqQ5TltUiwDgDevYTsdLNUiZFU/4QovKAG7sueAIdjMetMZ41cLFr8X9D1E9hCf
	 6Hg+QYV9mM+EeScdspu9ZaJJXbLM5YaT+RpgXnuSOdBuEzL3MDxZ2HVaAuCB/4x2zEdGC
	 OLUlxOWrFiG1Q+eW1bbNTwvhtPYse4lXuk9yqV+/dPmQYPGsGJaGZIXUVnUYDv32GCw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 124721F000C4;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588034;
	bh=WVd4kSEPcUDB7qokuhjA49SJwxaGFhZI6Dzv7ZInj+U=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Tj5eNSjU1eqEV/+NFQNxQ7GKd764TeISHj/fhOXD2mNkfWqHSlSUrQWXiLfynYPbJ
	 GiI/U67X3xlkOEi++Iwp9Vwk0/H0ImKllxM99+N103t3/MFXm8tdjhlJwnW8Zms3QR
	 VKqvc7O5JiwpuAbfw+k7kOXnEK2Cmx3nv+zCDmWS7pVz13hJVV1KLVJ30/tXl82QZT
	 nwl4YsVDwwvAOEhUn9Kqofzyi7gK2/1gYlWxJ085EXhlyOJT+EJsOmJxpE9D7w2b7y
	 smHJ105rjhZInJDNObsTNjixLCd7cO/BH0fkUcKbOrSqzJVCBiuY7MIO3Ll+UKE5gm
	 r+BoN20ftiiTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 96061499BD;
	Fri, 13 Nov 2026 16:40:32 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v3 00/12] media: verisilicon: Recover the Rockchip VPUs
 from faults and timeouts
Date: Fri, 13 Nov 2026 16:40:31 +0000
Message-Id: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ7CIBAFf6XhLAZou0FP/ofxABRajC0GKNE0/
 XehXhoTj7N5M7ugoL3VAZ2rBXmdbLBuylAfKqQGMfUa2y4zYoQBpZTgfIzeYe/kHCIGAYo3Rkt
 JAGXn6bWxr613vX05zPKuVSyRshhsiM6/t4eJlt2/dqKYYJDA4KRIK4249KOwj6NyIyrtxPY2+
 7VZtilvgZqu4bzme3td1w/AVxFU+gAAAA==
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
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588031; l=4890;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=AkkpZ+LzE3TI1DSPHQD95rroQvGeE01mP9oQsvvu9Z8=;
 b=Kb/N48draMY3CGgfyjmit/qt8xxtPSYAF59vR/1Q6hrsglNElhsPerE2qwinJw62QJxWRLYHX
 rJvWMwqphWhC8Fp/eeQQutkZ6NlXXq3wL+jZ3A8Q6Ch5hOMWVf2XXvH
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

On the RK3588, a VEPU121 encoder core that faults on an unmapped IOVA
never becomes idle again, and every later job times out. Patch 6
pulses the reset lines of the core on a timeout, and patch 7 then
reinitializes its IOMMU like rkvdec does. Patch 5 re-enables the
encoder interrupt after a reset. Patches 1 and 11 describe the optional
reset lines; patch 11 can go through the Rockchip tree.

Patch 4 stops asserting the resets on remove: the RK3588 AV1 resets
also cover its IOMMU, which then faults (SError) on runtime suspend.
It touches the same lines as Sergei Khomenkov's remove fix [1]; the
one applied second needs a trivial rebase.

Patches 8 to 10 and 12 describe the AV1 resets on its IOMMU too
(Philipp Zabel): vsi-iommu deasserts them on probe, and both drivers
acquire them only while using them. Patches 9 and 10 can go through
the iommu tree; patch 12 needs patch 8.

Patches 2 and 3 fix older bugs found by Sashiko: a NULL match in probe,
and a request left queued when the VPU can't resume. The ->run() error
paths are left to Sascha Hauer's series [2].

Tested on an Orange Pi 5 (RK3588S) on a v7.3 based kernel with other
out-of-tree Hantro patches (no 556ab0b2741d or 8e26d4c20ed2); v7.4-rc1
is build-tested only. AV1 unbind/rebind hit the SError before patch 4
and is clean with it. Provoked encoder timeouts and unmapped-IOVA
faults are reset and the next jobs encode.
All VPU cores still probe, H.264 fluster is unchanged, v4l2-compliance
-s passes on the JPEG encoder, and a job refused after a failed IOMMU
restore completes its request. Patch 3: code reading only.
With patches 8 to 10 and 12: AV1 unbind/rebind 20/20, AV1 fluster
unchanged (203/242), s2idle 3/3, encoder timeout recovery unchanged.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/r/20261106-hantro-remove-v1-1-d0a4678886d7@gmail.com
[2] https://lore.kernel.org/r/20260824-rk3588-jpegdec-v1-0-180a30a2852d@pengutronix.de

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

---
Changes in v3:
- New patch 2: check the match data in hantro_probe() (Sashiko, v1)
- New patch 3: complete the request when the VPU can't resume
- Patch 7 (was 5): complete the request of a job refused after a failed
  IOMMU restore (Sashiko); fail the probe if the empty domain can't be
  allocated
- Patches 4 to 7 (were 2 to 5): shorter commit messages and comments
- New patches 8 to 10, 12: the AV1 resets on its IOMMU, released
  reset controls (Philipp Zabel)
- Patch 11 was 6
- Patch 1: Acked-by from Krzysztof
- Link to v2: https://patch.msgid.link/20261112-hantro-robust-v2-0-18561fd48838@gmail.com

Changes in v2:
- Patch 2: never assert the resets on remove or on the probe error path
- New patch 3: re-enable the encoder interrupt after a VEPU1/VEPU2 reset
- Patch 5 (was 4): restore the IOMMU only from the Rockchip encoder
  reset, only with reset lines and a DMA domain; refuse later jobs if
  the attach fails
- Link to v1: https://patch.msgid.link/20261110-hantro-robust-v1-0-6b6269c05bfa@gmail.com

---
Arun Iyengar (12):
      dt-bindings: media: rockchip,rk3568-vepu: Add the reset lines
      media: verisilicon: Check the match data in hantro_probe()
      media: verisilicon: Complete the request when the VPU can't resume
      media: verisilicon: Don't hold the VPU in reset after remove
      media: verisilicon: Enable the Rockchip encoder interrupt again after a reset
      media: verisilicon: Reset the Rockchip encoder cores on timeout
      media: verisilicon: Reinitialize the IOMMU after resetting an encoder core
      media: verisilicon: Acquire the reset lines only while using them
      dt-bindings: iommu: verisilicon: Add the reset lines
      iommu/vsi: Deassert the reset lines on probe
      arm64: dts: rockchip: Add the reset lines of the RK3588 VEPU121 cores
      arm64: dts: rockchip: Add the reset lines of the RK3588 AV1 IOMMU

 .../bindings/iommu/verisilicon,iommu.yaml          |  10 ++
 .../bindings/media/rockchip,rk3568-vepu.yaml       |  10 ++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  10 ++
 drivers/iommu/vsi-iommu.c                          |  16 ++++
 drivers/media/platform/verisilicon/hantro.h        |   5 +
 drivers/media/platform/verisilicon/hantro_drv.c    | 102 +++++++++++++++++----
 drivers/media/platform/verisilicon/hantro_hw.h     |   1 +
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |  44 +++++++++
 .../media/platform/verisilicon/stm32mp25_vpu_hw.c  |   4 +
 drivers/media/platform/verisilicon/sunxi_vpu_hw.c  |   4 +
 10 files changed, 188 insertions(+), 18 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-hantro-robust-6a6c84febb06

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


