Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794778803;
	b=VHraiFOMUwt2t5KIxBPLA2D9lcD1B5gmCsxkp1ETIuZn3rhVpvMYbpmwD+mkplPAKz3o
	 99Rh87T4eAiaqn9RHV1vyIgYp65uXbdt9GVpwQPQo/zlaQecMyzyuJp3GPIjlvXITzVzs
	 aFdL2utc3oBr5CX0+jnRnNpjveMlGNHIKeM2ZC/hBmbLaT+DKMSX2gVVoF9x2m8D8XGyd
	 sfRtwKFm8ZcmtQgwvMw5fJZR+UIHtQ/SQN55OSCj2/XJtRO95BMQtAl/bvrucIouBHzki
	 HCrPHWKFbj4utg0TO7MzxsgXxTKtJlkEH4h6bJidz0Y33iX9PpD8DNxCgs55He4e8xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778803;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xNjAalZIzvUFa5Xbxji9aRdEkgxtocXL1VL40VOFD/c=;
	b=1owK+qDy/2RF+uKPsy84lehi4LXIGUT1iT3UT4BnYNBPTeaQcszsRurjYwJClr27hutt
	 jkDgBr94+ngITQw14oU/pspuZn0PxK7xmxRxRB065Qn3oa6eGAGuQV2HJgNXFsQctKYQh
	 a3xV3ZoyYOfnlKoJaZIefQ/o1s0c5h9ClaFgSi2RgedVYembufdv1hW8icofxFTw2lkzZ
	 k0NVDLDOPhcPGW9OWOVbpkuf1MN00FplDByzjo3ef3m6vGyUTAaNfMTCXlNqj2FEF9J/y
	 t1AH9z8UV2A+v1jbqyjkQ5GXibmHYHrOuTYtT0IdaV00AY+rnVr8epGA9+23D1MQLtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVYON9ny;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15544606A31F;
	Sun, 15 Nov 2026 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVYON9ny
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794778802;
	b=CftTzxgyLMJwm3bhBexRcZOHJBaFWxsp8vYFCWCinTzrCkITLfydDSr35THNXpJyiBF+
	 hOB1Ciuna76PFXLHMcjoAGDws26sj+vPx2r6xgNcfMowo+ai92ruy8njvPRZY7aSTZytx
	 coQSEXjNCdoVUfKK2IY9PVdAuKGAg1X+1Otv2PbC1sdTEvHnbRg0XVrAZ1QBVvgB1r2VW
	 NlEuN5pVlfkb/oe+iG+ei4XRYDEsYzHQz6F41kdj0KVt/HVNxMjfDa8QJF3q8NZoGaRBW
	 4nmAAHFLoQo7dw3qWYXkyW15n8tx6X4aJQcbzYfZoXVW5/RhY9qHWxiTUpq0GG9qU7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794778802;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xNjAalZIzvUFa5Xbxji9aRdEkgxtocXL1VL40VOFD/c=;
	b=0QUf1UOk33npcTZknKyyCBniXFHLnQfyiVsQ8cI6pBTBdgx+Rrw7MkPlgfvQ6eDMbqKq
	 ubkuxe7ee/pJli1LXzjmueEkChv6uipfvhckE9DyqnuziS9t0Vh+y7mQfs6hNjv8suT3r
	 nlRIZmBT1fUcpjp2kahqnJLm57QfEJD1TfV+E7s/BzKUzYKrtFvMRHpyT4BGPDMeS6NjU
	 3oPeIO3QOCAclHpkCGe7DunyT3PO/P6+3ZQFCRCdAvQWlnLZNR6hhd0EamhiYIMdIarUa
	 pH4BT+MM0VLzYmDKXW2kf3ONk9h67sP+tmolIaShnXVbOvlB29itfyM4rz+66aDPSvw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 200EB1F000C4;
	Sun, 15 Nov 2026 21:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794778802;
	bh=xNjAalZIzvUFa5Xbxji9aRdEkgxtocXL1VL40VOFD/c=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=bVYON9nyiNA1ScxrHvAukf882icY23Dl2rKcC1Gf4Zlmxw1gCWNzSz/UOVm9VWm4M
	 1x1cXO4Rrcu/6fV962cC2v92Yu4WBfsT3mvA1qiKyVIcSxw0wcnNZ2t/TX14CSv/Yb
	 9NvLtsjKEqCOt3FewQlx77UmOEcYtDNAnS0NE+QQmx0ABUYOQb3Yn1REQoYZPu24RS
	 7QO3AdP1fAG7fL8eXPjI35qjPtG60negVgJ+KALKsXfOlfEPtqAX9bqERldLBBBb7P
	 H5Px1YzwHY8R/h5tdw5OgEsCqn+AMwSAerrd9AqQClu1oe7vEfkMmNvGdxBzd6Kd7L
	 zre8Bx7aPBs7g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 92BB94A205;
	Sun, 15 Nov 2026 21:40:01 +0000 (UTC)
From: Phil Williams via B4 Relay <devnull+phil.williams.advisoft.co.nz@kernel.org>
Date: Mon, 16 Nov 2026 10:40:01 +1300
Subject: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without a
 trim
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
Message-Id: <20261116-st-lsm6dsx-ts-fallback-v1-1-8ace30afbfb5@advisoft.co.nz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz1jCQcrQq6AOIXFaQ6BVnFZIi
 LuTlvEN/++gnIUVbs0Omb+i8lorqG3AP936YJRQDaYzlogsasGkiw26YVGMLqXR+Rl9MBQpEPc
 dQ43fmaNs//Fwv6yfcWJffjc4jhNT60DqegAAAA==
X-Change-ID: 20261116-st-lsm6dsx-ts-fallback-cd21f1d1e30e
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Mario Tesi <martepisa@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Phil Williams <phil.williams@advisoft.co.nz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794778800; l=2231;
 i=phil.williams@advisoft.co.nz; s=kernel; h=from:subject:message-id;
 bh=uHlYPZd4leaL6BZM5UhiWipgD8U4U669fNKN8B6lxPA=;
 b=swvwjnWL3dHnjOwF5N49mxp+jQkSzO5f8iKsDykvNkJoG9nL5N9gOV1dfEDQAgYLgtVenSNDn
 mmz43EWAIvwD7R8bnl+BqLxRMaYraCgYT3m1eKkeiSTLJO89BB/7Zg6
X-Developer-Key: i=phil.williams@advisoft.co.nz; a=ed25519;
 pk=t0M8TApJRlA/rHh3lIu1XTiWO2+evmU8VnO43/qqLPk=
X-Endpoint-Received: by B4 Relay for phil.williams@advisoft.co.nz/kernel
 with auth_id=1538
X-Original-From: Phil Williams <phil.williams@advisoft.co.nz>
Reply-To: phil.williams@advisoft.co.nz
Content-Transfer-Encoding: 7bit

From: Phil Williams <phil.williams@advisoft.co.nz>

Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
calculation") takes the FIFO timestamp scale from ts_sensitivity.
That field is only filled in for parts that have freq_fine. The
untagged-FIFO parts are left at zero:

  LSM6DS3
  LSM6DS3H
  LSM6DSL, LSM6DSM, ISM330DLC and LSM6DS3TR-C

st_lsm6dsx_read_fifo() multiplies the raw counter by hw->ts_gain, so
every sample is published with the timestamp taken when the buffer
was enabled. The accelerometer and gyroscope values still update.
Userspace that integrates attitude from the timestamp delta treats a
stuck timestamp as dt = 0.

These parts have no freq_fine register, so there is no trim to apply.
Use the previous fixed scale of 25000 ns/tick when ts_sensitivity is
unset. Entries that already set it are left alone.

Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp calculation")
Cc: stable@vger.kernel.org
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Phil Williams <phil.williams@advisoft.co.nz>
---
Resending inline. The first copy went out as an attachment.
No code changes.
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 823f8ac66..98db90a30 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2525,8 +2525,14 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 			return err;
 	}
 
-	/* calibrate timestamp sensitivity */
+	/*
+	 * Parts with no freq_fine register have no trim and leave
+	 * ts_sensitivity unset. Those parts used a fixed 25 us/tick.
+	 * A zero gain publishes every FIFO sample with one timestamp.
+	 */
 	hw->ts_gain = ts_settings->ts_sensitivity;
+	if (!hw->ts_gain)
+		hw->ts_gain = 25000;
 	if (ts_settings->freq_fine) {
 		err = regmap_read(hw->regmap, ts_settings->freq_fine, &val);
 		if (err < 0)

---
base-commit: fa2933aac170dd19c6a7f0d7b81a8f537e40915c
change-id: 20261116-st-lsm6dsx-ts-fallback-cd21f1d1e30e

Best regards,
--  
Phil Williams <phil.williams@advisoft.co.nz>


