Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795562152;
	b=d8aEOELWdMHXSaEfK7wnFL/Gzb4/UoUUATXKyAh5hbrNvWIRnNgnOE+3ZLlClzNappGf
	 aUufgFml4tTNSHudgt7Ksl2joNNYddHUjlPSKw79dGbP++One9CSEnYk9ZMlcbzuoDuYT
	 jehTwp13pHUcDc3PJj6kMYgKHYyjMMivqo+JSS5sNuZYT6oV4pcV8ApnRSHJA4Ldj9oi4
	 m90F/AZjwqll/kiy0NWW1zpNFvjcN/LVsYW9SweY+GhMPBgcTdh8MevcYX96qeIp/aORM
	 ruxuisAspHaBz7iTigRpHFeBJ+38kqQO8Jag7BeC5xxIXQDQds0Kc/az4gA/qgewrrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562152;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hXIJkRFkLK1sgfrE7S9Rm7dZKwK7LpK9n83lai1vrKA=;
	b=EPkfkgyd37skmERHhXTXwRiFTj0NBBthxNIqkofmbRa08efWSuDl5cefcJBTZ0UHrx43
	 9g9XWeyTkXUX8f3XD/MflJyz8KesxDcdjGf1fRhxJSzIwkDCYP7bBwgQQTRCSCXDH7x6Z
	 51+oj0yWE+8l7CSlS7f4LChGDAugBCpcDNemorbdcAnTwLiPKZ7T1IF1RfI+pmFh6LesK
	 dcEFEit15/n1isyZiSVQtXcQhyvN4kmcyLgkurY7FDrYQ+c1aczXWslBxRXewn5o1IHek
	 S2GMqq6Ei2TQ3CX9ZV2q2mGd91+xkAKZRLjE7uI0vzggoor9GbPUhFqPBVs8ob6cuxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhcOzQYc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87690606A31E;
	Tue, 24 Nov 2026 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhcOzQYc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795562152;
	b=y8uHO568j6sXcWTjqvrLNCcjf/8WUr2vuZqMhrCVF62HAvwXlV/u2gfd39f4dwP6eQDi
	 3vBfYAPsJSc0rNoZofkWb1o3vVVyb+l2wBghhnLdD7RWUfIn7OoY6NU2Yzy6njNsl0WE3
	 WaqcmthQabAiq0+fJupcWQ8+Nk1c7v0/Xm/2hnis6oaKPh1wASeleXPdEQQTzNJ0aCNYx
	 8VLDioO1LQ8NtB4FthSKKndkAKavh4FBots6MqpbVmnhuN1KtuXZjVseuf041mzpq+dk/
	 jBvhckMQgE8mQCzdOFTJWuSRxsKMN5Q6Fod7t/O2zpS3mVX8LrvI/8i6i1DeNTh73hA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795562152;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hXIJkRFkLK1sgfrE7S9Rm7dZKwK7LpK9n83lai1vrKA=;
	b=PNJ4Ci+aHo3m+xMFMBqPQSK5XEQEbJMiK1TbLFQgBS5P7dA1Vd7dmOThRWGR6m44joDv
	 iaFYYwmMLUedKR0SYEaizJTCkHUh8kkj4V17LYkA0ZpLkjx+HYWzLZCJcbY/Hd/kv9ZoA
	 QlWq50bkLsnXJIBNY/AaO7SrS/yf1C98ZTmb8RStDlg0ct/qqK/ZyVWVDx+j0y7XoNwQi
	 pyEEIOQtA5NE8uMO8BJKuTZ8oViFmEBrbGS8QCtFlKMDnGgB5C2wCP2ZIvUmfQtbxlKfn
	 Qto/2yL6BAv3nspWA80pWiln/XJYqkrDVP6WFOt3XZjxy6ywapCqbDuIydZGzcPxRyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 00B561F000D4;
	Tue, 24 Nov 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795562152;
	bh=hXIJkRFkLK1sgfrE7S9Rm7dZKwK7LpK9n83lai1vrKA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lhcOzQYce1NvH8AGSt0uGKVMP8SXEBVY+Or0XJxeejjz4J9j+uXyfgmLgh7704urb
	 tpUM2JvPj5AgL9Qj/WS5eB4+MMRMxGheqIR+Pb9elGQR5BMlBXRlaKFVN9NdXz9Tup
	 a+x1Qm0Xq4ErYQ38pd/rcpCH63ehOVRZQ0akesY+QLU7CXzAGXIuycNTXGN5c2BDis
	 qkldeSYTU7yJ0AkO1AGbchWSLf3MSsPiPsU37aHStVwzNbipM2Afv2pXgWGwmDN+F7
	 pxUQeXnKwvdtACA2sOUU060CtnjKNBE8NP7j5RNojr8M9S84fVe4IhOe2REgc46MEs
	 K2/aKB7fzJ/tQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 51DCA4CC1C;
	Tue, 24 Nov 2026 23:15:44 +0000 (UTC)
From: Phil Williams via B4 Relay <devnull+phil.williams.advisoft.co.nz@kernel.org>
Date: Wed, 25 Nov 2026 12:15:44 +1300
Subject: [PATCH v2] iio: imu: st_lsm6dsx: set ts_sensitivity on parts
 without freq_fine
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
Message-Id: <20261125-st-lsm6dsx-ts-fallback-v2-1-ea0ea2512070@advisoft.co.nz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOTQ6CMBCFr0K6dghTIzGuvIdh0Z+pVJGaTm1Qw
 t0teACXX/Le+94smKInFqdqFpGyZx/GAnJXCdOr8UrgbWEhG9kiYgucYOBHa3mCxODUMGhl7mC
 sRIcWad+QKOVnJOenbfjS/Zhf+kYmrWtrovecQnxv5oxr7q8kIyAclSkS5bTTh7Oy5XJwqTahH
 j+iW5blC89ElLnTAAAA
X-Change-ID: 20261116-st-lsm6dsx-ts-fallback-cd21f1d1e30e
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Mario Tesi <martepisa@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Phil Williams <phil.williams@advisoft.co.nz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795562143; l=2777;
 i=phil.williams@advisoft.co.nz; s=kernel; h=from:subject:message-id;
 bh=fGzBxiYeqCVBJr9qUvLqytWRj2H3OFvl+kp4md9filo=;
 b=QpdXAjVXaPivFOUs6AdlJsF1sw2wxLPu6S1QzQ4gahR365MCZy6WI57iOzhxSM82kWsGkHoc8
 lQw4Ov9aivoAmSu6UnA89XcMVmwtTIXb5o7kagE2LCOa1H9boLk45UD
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

Set ts_sensitivity to the previous fixed scale of 25000 ns/tick on
those entries. They have no freq_fine register, so ts_trim_coeff is
left unset and no trim is applied.

Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp calculation")
Cc: stable@vger.kernel.org
Suggested-by: Lorenzo Bianconi <lorenzo@kernel.org>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Phil Williams <phil.williams@advisoft.co.nz>
---
Resending inline. The first copy went out as an attachment.
No code changes.
---
Changes in v2:
- Drop the ts_gain fallback in st_lsm6dsx_init_hw_timer() and set
  .ts_sensitivity = 25000 in the LSM6DS3, LSM6DS3H and LSM6DSL settings
  entries instead (Lorenzo, Jonathan).
- Leave .ts_trim_coeff unset on those entries since they have no
  freq_fine register (Francesco).
- Link to v1: https://lore.kernel.org/r/20261116-st-lsm6dsx-ts-fallback-v1-1-8ace30afbfb5@advisoft.co.nz
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 823f8ac66..dffaf76b5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -434,6 +434,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x09,
 				.mask = GENMASK(5, 3),
 			},
+			.ts_sensitivity = 25000,
 		},
 		.event_settings = {
 			.sources = {
@@ -601,6 +602,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x09,
 				.mask = GENMASK(5, 3),
 			},
+			.ts_sensitivity = 25000,
 		},
 		.event_settings = {
 			.sources = {
@@ -802,6 +804,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x09,
 				.mask = GENMASK(5, 3),
 			},
+			.ts_sensitivity = 25000,
 		},
 		.shub_settings = {
 			.page_mux = {

---
base-commit: fa2933aac170dd19c6a7f0d7b81a8f537e40915c
change-id: 20261116-st-lsm6dsx-ts-fallback-cd21f1d1e30e

Best regards,
--  
Phil Williams <phil.williams@advisoft.co.nz>


