Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341172;
	b=zShVpGl+BxGQJul1Xdc+YC8tMHQ/HBA0w3LipVzTNHW36PyhKSOkIOSbn/effkUEE0gc
	 VsCU4lUDtFsqLn/16vU+/A2grOS3pliy/di1vKrLExNjABcitAAwXM8vMUGtLVrq4QJjQ
	 js+BcPZE/gLi8BiK3430ONWXgjDzYEAx5ySIqPlgnwDX4ESobcD9oMCSpecpTC/pPXzw9
	 9xg4HdlFFQrrVeO6IDGygJhxWpE6LRolNSfrnUOH9cRPsN5HXcrcCCJFMOGSmNSKwMbN1
	 tjl4zV1vvhjlLN8VpFiriIrQaqxLXxsVIODkB31jruMjhdCjh4+EU7hjXwB3OyIi/UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K4vavFCjLBnw4DIrtaZ0Pdf8Zg9541MQX36ciN7kd2A=;
	b=uF3ce5tpHyAOK0b7THuhPiYtY6s7q3IdDHgf/1beWOa/CxsfeCt7r1U5GDY82zyo9Gpm
	 wjjgVJ9zWr0iOWyTnmvVWKa1Eb1x+UEIMMPwG3VV8cFVcV3GfzQAHA5vc9T0EqRosFTom
	 /9Hcfl3O03aGTu4yDGjo4anEQbOj1DuBCz3weomolW/HxKcY3DpYoWZvpa6AhJjqJa9tU
	 EfooD7qjc/OD+mYbR77nBgXst8aWZgRXjK1gIImXjYBoRRUAjRVG5jkskIi9wFWuwsl+u
	 RESS1LvPJTChOy6uTVja/M6ASTCqgh4YviQNL3QcVk7eZLH2DmLMiLCVDvbsc9WYrZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp3e6RWN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45F606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp3e6RWN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2281F0089F;
	Tue, 10 Nov 2026 20:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341171;
	bh=K4vavFCjLBnw4DIrtaZ0Pdf8Zg9541MQX36ciN7kd2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gp3e6RWNHD3xOBXR5nAZbP1cUbKZWllg19fgAhfGp590qKRslwJANA2i6l6hZRlmR
	 1/1kA5yPkWKE9Pp97YJb09TLSPBmpkn24IP6Ne5QtQEDX5Ch4RaFzzunLKJ7sVFYqD
	 QTu9r7t3ov9YRgO6xDe8oJ//zIgQpZC4kSkJs5Wql72SnT76+fTMKq2tpy/vKh01H2
	 mLOse0KGgHB/e1p543WNHs7FnWTGaYVB/qEZmfC0gEkgZ8kuxNKizyM6ZLB68g90Uv
	 WnkRsWFbOx1J1IIVeSMF6lQXjNvAqTH5p+vA8SbF4bYPDWluuhIzBENkpH/wQUsK/H
	 zxkbqF1tZtanw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jay Fang <f.fangjian@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] spi: jcore: Fix trailing statements should be on next line
Date: Tue, 10 Nov 2026 15:06:09 -0500
Message-ID: <20261110200556.3714524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062350-failed-5.10-7db773075501@kernel.org>
References: <20261107062350-failed-5.10-7db773075501@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Fang <f.fangjian@huawei.com>

[ Upstream commit 45793de7bf89fbd0fd1e2db9dda4e58a9c1395ee ]

Fix checkpatch error:

  ERROR: trailing statements should be on next line
  #85: FILE: spi-jcore.c:85:
  +	if (speed == hw->speed_hz) return;

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
Link: https://lore.kernel.org/r/1616566602-13894-9-git-send-email-f.fangjian@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 7db773075501 ("spi: jcore: fix divide-by-zero when speed_hz is zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-jcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index bba10f030e33d..74c8319c29f17 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -82,7 +82,8 @@ static void jcore_spi_chipsel(struct spi_device *spi, bool value)
 
 static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
 {
-	if (speed == hw->speed_hz) return;
+	if (speed == hw->speed_hz)
+		return;
 	hw->speed_hz = speed;
 	if (speed >= hw->clock_freq / 2)
 		hw->speed_reg = 0;
-- 
2.53.0

