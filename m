Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795142955;
	b=gmQSwlgUYH1KRt2IxZPEq8txbEdARGL1UJUryVeB5Al0z1chA7Y0O+ugaoni+zQ9utAY
	 ZFCgIxCJ/wVp4HVl6gQgmjKaHmOrD/iMJrN1Dyp98aU6lum0OLXpL47OdOQYP0Ffuck7P
	 QAwPvUJxeyvXs0vBlEwo85hAUZ8Mj/zd9NLTOWV3HC3QAjKEg7vGTzPEFknJVF9GybHkk
	 3eHoFO67PZW8/1baDodz33c+gRboDK+lmet+kOp2vHF82ZXrZu5f1jyllMmBjrbuwOZ+C
	 XVZUWHBiEa2cle+jeXh2/OWyfSE3pxarf41U8Fp1FW6Vuk/2M8vsLw1qr8tcxJsHLHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142955;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=CQl2SvQWLVhrrF+rgxKWAOgk0VZ5T5baWvxZ2m1vTk4=;
	b=JMRh6HVxP8ApSBgQk+Ylfn9QsHNO448/eVPyv0Q2VBddA8q/peXELGzY0w4IEpAi+uLV
	 POp6jP7fVVqlByTccKkerUtzPUa9Azn9jNs7kH8ktikTSLeWpBOPdGidOle9i+3uyazV4
	 riPF4FkuwclG3yg5fwutiA/4ae4CxpU0rbShcgIk1C7Lu6yTwyEMV/CxfyNGDKsFqkQoE
	 QcoJefyB+2D8Tvd2AgFZ1i6J7hECy/9nD+NyO6pk4eZp+U+Xkx/In3Dfn6DCiKtRkqVYg
	 0wk8vKUfiJFzfcVCL+yOaBYOcz19mQ0Gdc0WSAc0Qx4vyuQvXRmpjCNsvxXVVkrLBiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N47Ecp42;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DC606A326;
	Fri, 20 Nov 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N47Ecp42
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795142954;
	b=bAZL82/NGYB57OCKwcvaL90hdPKlNcM1pK3kyavHP5kpWQNtpJrX6kd0sqpUCo6JwAU9
	 vVkP9QE3e2L2imPx9RMeylFftzm++PH31+OGrgZ+X83iiMLyY8kAOxb0IEvNp8/9YcEd2
	 S++e1RlYm3Fj9KvcvXf0+lCHzJKTpODdgwLX8Y5+C3B3OX6rwqS3F+nDLWCBGSsULcwAp
	 TlCXiV+8bM2xQXlGor618sIishzotwI3EKuvZTaFOnofgaE3WAqLVJx1KJyGn7g25S6Lc
	 RqGfr2gpCpgEc4Sk2NFKWIlqWh9AtEx6HbBNUo1cP0crVZJIndgc6hWP9Sp219aK3Dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795142954;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=CQl2SvQWLVhrrF+rgxKWAOgk0VZ5T5baWvxZ2m1vTk4=;
	b=cvPQuophWFeDOUAhetGCCxWFuHp4XqClU+Fm60f19wN6oRpg5/s1UX8RoHtYhff/nBqM
	 8J+F35+5UCXRVX6CVc2kTKAHmCayy39qcSWW4KCOGvngeI//O4Y/3OZxC1xOPjNovhbqZ
	 kvq3zP/A8aIxIVi7cdWPFR4QLqUOySE8+fb18R6UBOMePZzajfnu5lliDJzR3632XpTBE
	 kHAUjuImbDofandbHixyB29Fqoe7m3FqVKEAmo5d7/FV7Pt9rkFL4xlCPwIECKh8L0NsK
	 CMlLScN7AHG0IwQWvGquxU0QpvCX6x9tzBDgavc103yUDNpFpFQI/t3dBklzsq09DiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D4141F000C4;
	Fri, 20 Nov 2026 02:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795142954;
	bh=CQl2SvQWLVhrrF+rgxKWAOgk0VZ5T5baWvxZ2m1vTk4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=N47Ecp42XNCgB1A/TRdRC2XV80YsdBV9YKDQEJPT/xr2ReBkfnYfCP3ftCBoeMmbJ
	 MsQ1SLtA/7/LYD2DEXeiR7gylxvuyNzqDeCxpd8jqjJhZShNt/6ifBI+k4Rp3AlbY2
	 Q15jw3k2tPJmMCIX78Cjd0mt/MHdaS7aHCWd2CQ+VmbheMtGrcKt7pLhSj/57HsEjt
	 VbzIXAm9fImqlaMvfaVbezb/hPnVlnUJwdq2xradnXnEs5ztk6Xn+d8KiMIMjeiHed
	 vfS9rJcc6S0Tu5XaZIzOPG1Ch2+4Qh97yTfhpbwhScjHcI1FxmlK1n/crMkSLgqUtg
	 QEayeH7cvLq3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AE2704263C;
	Fri, 20 Nov 2026 02:49:13 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] media: verisilicon: Fix VDPU2 decoder error
 handling
Date: Fri, 20 Nov 2026 02:49:13 +0000
Message-Id: <20261120-vdpu2-errreset-v2-0-8f4ef55e6dee@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBBFf4XM2po+FIsr/8OwKDDAGKFkCo2G8
 O8Cxo3Lk5x77gwBmTDANZmBMVIg36+gDwmUresbFFStDFrqVCl1FrEaJi2QmTHgKGxq7UVKkxl
 nYB0NjDW99uA9/3KYigeW41bZjJbC6Pm9P0a1eb949h+PSkhR29qdpClSZ9yt6Rw9j6XvIF+W5
 QPt8b64vgAAAA==
X-Change-ID: 20261115-vdpu2-errreset-8688700393a3
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795142953; l=1549;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=236hsCejcx3sS9x+HFSJjCRXf+BV1f1+zibsBZf0JVg=;
 b=+ScOgDQeEaI5FZeSrS1ngM1Vh5HeTVe1p8NGZR8cjcXzNPcKHKCVAGU/ex+lwBGdM2kHJUuCi
 3ZpiTcU5blgAZD4G9tSKHLAmAsOsrEeaAqfLZAxw7WU3d/sWWcCRDiu
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The VDPU2 decoder reports failed decodes as done, and its interrupt
handler can finish a job the decoder is still working on.

Tested on Orange Pi 5 (RK3588S), v7.3-based KASAN kernel: 72 H.264
fluster suite runs, 50 error-stream runs, VP8 61/61; no IOMMU faults or
timeouts. The decoder was still enabled after 72 buffer-empty
interrupts; a later interrupt ended each of those jobs.
With a TEST-only patch (not in this series), the IRQ_NONE path ran
200 times on real registers; bus error and timeout, simulated 5 times
each by injected status bits, were logged and ended their jobs at once.
VP8 stayed 61/61 bit-exact.
Build-tested on media next. MPEG-2, RK3399 and RK3568 untested.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v2:
- Patch 2: no reset after an error; handle the interrupt like the G2
  handler instead (Nicolas)
- Link to v1: https://patch.msgid.link/20261119-vdpu2-errreset-v1-0-f8fa403b6a3a@gmail.com

---
Arun Iyengar (2):
      media: verisilicon: Don't report VDPU2 decoder errors as success
      media: verisilicon: Handle VDPU2 decoder interrupts like the G2

 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
base-commit: aa0f4c41d4870a18e65772a1817af16427200371
change-id: 20261115-vdpu2-errreset-8688700393a3

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


