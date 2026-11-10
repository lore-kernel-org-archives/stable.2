Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341173;
	b=ccJesHq+aNYlHAhWnNi4pR8jFrG2auTw1UmVxBaP3dq/iG+DNyjQQZ/lUOwY8sFbiK5h
	 dSAbqilwA0Kx0ENbdlzO7Q8BgbHykxFFfqEzLcgMyKhAtJGd6AtF+womcE03J25B60iMN
	 jjJFoyxnQ6cRMXMxE9KyGxsGk+dDE0XvJTOX7gtSfcoQkb0xF10SMA2hwaqAnK9dpoEEr
	 cccfBMuwQJW/C8Xu7nMW0jPbtSlWF38M02a+xteypFkQUHhT+YAMIumCllg1rALNoT6TY
	 /nX5YCfIfCjesOlTsKPe/mdrsrq1rkYYnhnGj43FInE7k1GLcqhOClY74Nn2AtGZr3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KZGJWkyvhvP8YKb3kTpWUYosyjpHtA7DPWE3l6Qa3G8=;
	b=rS58tVTdpwseNx7Y1w2IAntcD2cgWk6kfx83atr0n++nDj4lkuTOHY2w+wCduqVHdOCS
	 4sqViRgPMb3F4f243Lhtfnna5RVlmGY4k94LWOS3zZlrCaVgKc49hOZCPSVCWouqiAl5n
	 aWm6kGDUAnPUOUX9xqoJB3vlgeN9Mf2kL8CKCfNrjdCiJjOrpZ0fJkZ1ASq52a5H7Svxw
	 DjgIPCozfzup320FrF08qh+HGBtKYwv0bGknpmQDEzt91OBexxPO9i85IwSLXphLuSl2d
	 X7LChMRkJBTxhgEknIJYWWPcsMs88m5b31OXiJgG0xjDIEhbDldXAqviZdk1nnuCT2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5ywWIbu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F86606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5ywWIbu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5CC1F008A3;
	Tue, 10 Nov 2026 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341172;
	bh=KZGJWkyvhvP8YKb3kTpWUYosyjpHtA7DPWE3l6Qa3G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e5ywWIbuuq+O3N0KCIh1CibLbR49Bik/aQIw4ftwEWRAKtDfUutI2NGCxKaKQLdlY
	 hGeSdoEywRYuMEWDSPdYmMcDGpKipbYRwkYVqWlWQ2aJzSQCAu9WWmuXRUxnX50tCq
	 GThgxe9J/Hhfm7Ei8B1qvccXIWihC42KhEWisSjViUPjhEsgm5rATIvmVbzx1+kq3c
	 vo/8PU/NW/uobA5pD82zsQ51PXV9bFaXDKuLu7mMZmyahROOstj31Bq8QcBLQejh9L
	 GHtt82Lj5c/Vlx7DZYOldQqqFe2xM0sK2efr/XRg3ZC8PhXKxzyWhe4NCKKb7DzZt8
	 aKZIptTUlT6tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] spi: jcore: fix divide-by-zero when speed_hz is zero
Date: Tue, 10 Nov 2026 15:06:10 -0500
Message-ID: <20261110200556.3714524-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200556.3714524-1-sashal@kernel.org>
References: <20261107062350-failed-5.10-7db773075501@kernel.org>
 <20261110200556.3714524-1-sashal@kernel.org>
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

From: Weibin Liu <liuwb@xiaopeng.com>

[ Upstream commit 7db773075501248893c22b11bedc6745d6d0be45 ]

jcore_spi_baudrate() computes hw->clock_freq / 2 / speed without
validating speed. The SPI core fills transfer.speed_hz from
spi->max_speed_hz when it is zero, and jcore_spi_probe() never sets
host->max_speed_hz, so the clamp in __spi_setup() is skipped. A
spi_device created via the sysfs new_device interface (or a DT node
without spi-max-frequency) therefore has max_speed_hz == 0, and any
SPI_IOC_MESSAGE transfer reaches jcore_spi_baudrate() with speed == 0,
causing a division by zero and a kernel panic.

Clamp speed to a minimum of 1 Hz before the division so the divisor is
never zero. The computed divider then truncates to the register field
width and the transfer simply runs at the slowest supported rate.

Verified by inspection of the __spi_setup() clamp and
__spi_validate()'s speed_hz handling; the division-by-zero path
requires the J-Core controller, which was not available.

Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Fixes: 2cb1b3b3ac0a ("spi: add driver for J-Core SPI controller")
Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Link: https://patch.msgid.link/20261014-spi-jcore-divzero-v1-1-a8205d30f2d1@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-jcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index 74c8319c29f17..e8b8e160d2e34 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -84,6 +84,8 @@ static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
 {
 	if (speed == hw->speed_hz)
 		return;
+	if (speed <= 0)
+		speed = 1;
 	hw->speed_hz = speed;
 	if (speed >= hw->clock_freq / 2)
 		hw->speed_reg = 0;
-- 
2.53.0

