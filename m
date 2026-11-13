Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588038;
	b=yVnBsd4kxdA7BY2tZEpClT9T6nDYLUbLsd0aAGUQNhmiNrVNXWR00spdWVCOu2MBDn0Z
	 huNcBk6qToV5t62RHXNKBOK87qQT//APS2SRYigVXqqk52OGEFxwt9G0wz9XLhrMXA56+
	 wuzZeFfcYeopmwLAGQD8bU6/SuDW5Kew1Y3o08lt4WOkoGR3iwz3HkA1+wP643S1rpUQ3
	 ID2OT+WCkcoGCKUFO0ucaow5/NVpV/5S10l77vcBfDLmCTcsnRbEsc6oiAaBP5FID9Gf9
	 Z7GP/8ogIwbitpMXbXKC8nqLpDAOZbKaTz/PkwxkPYJRBS0ut4/+kruqy3UyP4oNuWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588038;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OZCIHbTkBuyVirzrgZ0HMwGGiwpqM+aCNKiZrR08Zfg=;
	b=jTJpRTKRA1cKbvOfT/XqZH4e+L+mhIAXxsJtM1DFjYurfWb2SsYoaZIMvvoOqNzatihC
	 mxItmeDixVra8bUtf3WTD7VxQ4s49grM1C9yipGDxnRo4zLTISy26BFBHtAgAzu9GdKjM
	 l0/2skvoravO0EtfWWyF/6AJrwpK+LnVeV0zNRCIiPZICfUWpgt2tsqcBsIw7f6YtP6Zo
	 nr7H1ytiX6tIPmJtd84TU/PRpL30HdFJ/wgrJ5/S8ijTCKS81uGiDE48kou4pPAwCMBrm
	 wc4n/TxwSNOcDPFgL84Y8mjYcdCL5me0C3gaxq8Fm0/M6aKg8b/emfMSXjodqeqkAHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDr6mC19;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAD606EBFA;
	Fri, 13 Nov 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDr6mC19
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588038;
	b=Cg+s8CHiAmQqJZoMioaeQljye45tqVRsDCAsGSp7RLE6eVDJ/mBQHxvMpWflKarPAErj
	 matjhN4si/3kKe64b5e1/tKwhy6uz49bn1NcUijNvEL1u2T8EWSjvQuFjlKAm6yQjtweU
	 IMfJHgZ0g53SasroA7AX/Tm5yhonTnAeiPWfe4gQfywd4GyDQ/LRJFoRpiPiM5OJsk/hg
	 h4HGK53YgdY4uYqQKIqEDAhrYhxUiPeN3Q6QVRRQ8h+c53/8qDF+KHVmcJI1LQmauM+Yg
	 4XYTdpHv40L+9fVr6U0pus5b5WQAt/+I2865eez9UqyL5clSq9oHJtDd75E43ieLo/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588038;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OZCIHbTkBuyVirzrgZ0HMwGGiwpqM+aCNKiZrR08Zfg=;
	b=ttX0AO5rVs460U56d2z4VJtcm0WWGCdOyADekfrmiY8hTFcFobF8HtUkffjr2m35SjK9
	 PpgpaBWhUOhW4BmJJSvYchMGhTZNNyVZonN8oj/bmL9OKA0EFYmriQU/NVZwcF4ijynSO
	 cChAKqajsMhD3ica1YUIqaKUwVcRkv3u03wWjSR3awR1R1smU5AA/fr//PlnR1SwG5cAo
	 vTVejkumMTWrckEJG4bSLvGqJvAliRB9ITTPbBCJYfg+4WzmPNZincoqyr64oYy24rMgB
	 fQYkY6dbqxCcnTvguayHU8fkpNznHMpbBnfH3tWo2EWRWuYmjX2acFRYG0Y4CBI0hew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 492271F000C5;
	Fri, 13 Nov 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588038;
	bh=OZCIHbTkBuyVirzrgZ0HMwGGiwpqM+aCNKiZrR08Zfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VDr6mC19K6U45zJjmotPPcmT28r9SwydFqpl6tKBwAk7axBtVHBWYDm0fyM+KF912
	 o4eLqBqF5lFs6+//O4GN2e9iN6+r5grs5jbkMbtOx8qMJkEkxbGQhkXjo1KZTWGqPM
	 anJmPO1Xh1Vt9XJVWnrdAZgjVmefTklT9bs1nBFoLiWyj++fyILwzzI/cQW6x3kYtt
	 e/uChKntja2628R5vMbDxcGlBycZ8Yx9ySPcPSFL92Ix5NphjDgt3hqnF5RJEcg8eJ
	 dXQejC7cfoRHmKDZZ75/3rI9u7ahN7oF7jT+SOuY3kALUH2dnq5dgxoRc2H+5JlRcQ
	 kXrixRp6Ut8Kw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 25BC8499E7;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:36 +0000
Subject: [PATCH v3 05/12] media: verisilicon: Enable the Rockchip encoder
 interrupt again after a reset
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
Message-Id: <20261113-hantro-robust-v3-5-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
In-Reply-To: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
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
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=1763;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=+x7MAvTN4ercbfI9R+yr1fEuEHWiIaV4thCiEwGlL7Q=;
 b=DmmH1x6jQBsbYSOBHBaVgphBTbVvRTk3LmuShnbMWCcdllIPzSyNpvrxNu7zr7MgNbWCHasO4
 qoCujNxrwL7BC1hMjPTAFrPBIE+y6ju5hZnMRno+q5aS/5QDlT+FKWO
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The reset operations of the Rockchip VEPU1 and VEPU2 encoders disable
the encoder interrupt before stopping the encoder. Nothing enables it
again: the encoder run functions don't write the interrupt register,
only the interrupt handler does. Every later job on the encoder then
times out as well.

Clear the interrupt register at the end of the reset, as the interrupt
handler does after each frame.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..ce3dbea70a8d 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -475,6 +475,8 @@ static void rockchip_vpu1_enc_reset(struct hantro_ctx *ctx)
 	vepu_write(vpu, H1_REG_INTERRUPT_DIS_BIT, H1_REG_INTERRUPT);
 	vepu_write(vpu, 0, H1_REG_ENC_CTRL);
 	vepu_write(vpu, 0, H1_REG_AXI_CTRL);
+	/* Only the interrupt handler writes this register: enable the interrupt again. */
+	vepu_write(vpu, 0, H1_REG_INTERRUPT);
 }
 
 static void rockchip_vpu2_dec_reset(struct hantro_ctx *ctx)
@@ -493,6 +495,8 @@ static void rockchip_vpu2_enc_reset(struct hantro_ctx *ctx)
 	vepu_write(vpu, VEPU_REG_INTERRUPT_DIS_BIT, VEPU_REG_INTERRUPT);
 	vepu_write(vpu, 0, VEPU_REG_ENCODE_START);
 	vepu_write(vpu, 0, VEPU_REG_AXI_CTRL);
+	/* Only the interrupt handler writes this register: enable the interrupt again. */
+	vepu_write(vpu, 0, VEPU_REG_INTERRUPT);
 }
 
 /*

-- 
2.55.0


