Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C34A21;
	Wed,  7 Oct 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331740; cv=none; b=N4DGnfAHk2xY3hMQKsBllRqZJxW8zCZroUVcWbqlrYLlK/kK+i7ytHxWTCI2OR4YCSRPmDGjlspmuMqloLmF1xU8SC2fL9lGtUCNV32v0qJdsVpZlKed5sm99gNBwBJwajXNuh71g+r4YfGUvQlsyO2oTCgN0QYOOsEjFRtXv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331740; c=relaxed/simple;
	bh=6FMO/MUVeuOy+RF5o0Mw3PgDXQG82wcSkicn2xjrMwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fs2C8+3T0iU/S8g8VDRNop7KD1nOu8FjQOqNPZlzr4fCdgn3BwHTR8brN/QOcwJT/Ny1Oh8NOHBGtecnmKf3xlLMuOHdhJ032GuClzVY3/86LuKC10KkM+4cdnjPaAXmBTqwCAOkA8FHa7kD+yu0LyIJKEqRBF6vT11PZx0Xn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghcm7i09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghcm7i09"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F4077C2BCF4;
	Wed,  7 Oct 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791331740;
	bh=6FMO/MUVeuOy+RF5o0Mw3PgDXQG82wcSkicn2xjrMwM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Ghcm7i0970+LgKMfgKM/yejDCtA4c282/k/+N+7Kfk2s8JsXsCyZLG6v6AmXHUlpA
	 Mb429VPRzBE9m1wQZFCqZ/09l5jC+7gZxj997Qs/k4C5W45qeZaKQVfDuAWKTmYuJ6
	 K42QNsoZjWT7030UrJXQLuerbslydgq3kj51Cn4ESPczCkm6rsAUOKt4SdYeLJ2IFM
	 UlYJ2ENZi/vxx42+VI4QH1YaHaRjYUbCniY3100R9yfbUqDsEpUP1JOI71K5p4tZ8N
	 88EXNzwGlPbZ7oMlEvY00TBGJoK5iDgKIlrEFzBF+TAxKpAr5cbvYbITVy/fubiSSg
	 /roQBjP+zALpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D018DCA5FFF;
	Wed,  7 Oct 2026 00:08:59 +0000 (UTC)
From: Alexis Bouzigues via B4 Relay <devnull+BouziguesAlexis.JohnDeere.com@kernel.org>
Date: Tue, 06 Oct 2026 19:08:58 -0500
Subject: [PATCH] iio: accel: adxl313: add missing buffer selections in
 Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-fix-adxl313-buffer-deps-review-v1-1-386006c407be@JohnDeere.com>
X-B4-Tracking: v=1; b=H4sIAJqNxWoC/x2NzQ6CMBAGX4Xs2Y2UBoi+ivHQ0q+wiRay9YeE8
 O4Wj3OYmY0yVJDpWm2k+EiWORUwp4qGyaURLKEwNXXTmbruOMrKLqwPayz7d4xQDlgyHzK+3Fv
 v276Fgb1QiSyKYvwHt3th7zLYq0vDdGRnlVHS+enyC0r7/gN+GNcUkAAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lucas Stankus <lucas.p.stankus@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>, 
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791331738; l=1476;
 i=BouziguesAlexis@JohnDeere.com; s=20260527; h=from:subject:message-id;
 bh=gbu02fd2W/FS8UIxm6fAoJMm+koqglcQ0EhO5bkhZZ8=;
 b=aM0IxXrihUruryRo/sFfJMcP+dSYBm+MLY8Aga8qddV3/keMLgppU7zpQOzmIWW8Mm9FttHdX
 FpsssHAhyeKAgZ/B11Xav3gVAkJHH0X6NETGnoLyUw+Z0ZwGYz652zR
X-Developer-Key: i=BouziguesAlexis@JohnDeere.com; a=ed25519;
 pk=5KJ7ArL00x5flpPhi9zRLC2p88V1rZXDQ5SXhpRvTDk=
X-Endpoint-Received: by B4 Relay for BouziguesAlexis@JohnDeere.com/20260527
 with auth_id=797
X-Original-From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
Reply-To: BouziguesAlexis@JohnDeere.com

From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>

The FIFO support added to the ADXL313 core uses
devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but its Kconfig
entry does not select the required buffer support. Enabling either
frontend without IIO_BUFFER or IIO_KFIFO_BUF causes undefined references
to devm_iio_kfifo_buffer_setup_ext() and iio_push_to_buffers().

Select IIO_BUFFER and IIO_KFIFO_BUF from the shared ADXL313 core symbol
so both the I2C and SPI frontends have the required dependencies.

Fixes: ff8093fa6ba4 ("iio: accel: adxl313: add buffered FIFO watermark with interrupt handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
---
Add the buffer selections required by the ADXL313 FIFO support.
The shared core symbol covers both I2C and SPI frontends.
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 4094299e2ed8..7b5c1ce66e95 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -32,6 +32,8 @@ config ADIS16209
 
 config ADXL313
 	tristate
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 
 config ADXL313_I2C
 	tristate "Analog Devices ADXL313 3-Axis Digital Accelerometer I2C Driver"

---
base-commit: 69f80fef3153299d9c72c53d1d71eef6354b6926
change-id: 20261006-fix-adxl313-buffer-deps-review-73bb575e1e39

Best regards,
-- 
Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>


