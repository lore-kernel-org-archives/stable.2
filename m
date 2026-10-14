Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5453FD3C;
	Wed, 14 Oct 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987543; cv=none; b=i6GksR6YY/H4heO31Uu2EmZbx03GLeSoNwhmQ7QKrunh+kJ/exoy/maoCfdm/LC7MFPMtZxXKuQsLGkMZln9wBcPLKSqg2GkDqcA/tRVgQuq2elCafRE33EL3wZfiklxNM1Xq+2OHzfYyZwj9SVlwqHlHQI9b+PkXOI/4/Wuzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987543; c=relaxed/simple;
	bh=q5JuposwHjFRtZMuTeBzbe537NIELxEiBdy8ekiwPRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hq8CkV7Q63OTyC0zDxTWbOWBXqEn6RT597VcEpGNIf2sAcxi0hONvDREfk3cmu74eUo6howIT5IXHoBRUkO2yM64gGQjHKDoJKNlawRumhQ/OxicbWfYvFEUykqEHoQ0rvDD/kObYI9ts2kcopOp2tp9EnNciXSXpHUiKJdfbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=mPxAcAHM; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="mPxAcAHM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791987531; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=sVT5SNwcS1SOVxpwRDVBWffIqAkNaek6SFXcZxpZ/6A=;
	b=mPxAcAHMZz4zfD+bzpCyFTYNobvmo8Ou3tUJuARWOQPj7Brdbv3kNnxtvUibVnB1tIUtMFNDqkLGsns2V/UppYRKyssVS6yM45Y3nxTYU5tHddx26Y4NpBcL/fGt7ExFs+0EYV+gio5ehEo4qeCvWBH6gAFEIZPmmIOqOB49LWU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.103558|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0121972-0.00204134-0.985761;FP=9140339912034641652|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jdOi8se_1791987529;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jdOi8se_1791987529 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 22:18:50 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Wed, 14 Oct 2026 22:18:50 +0800
Subject: [PATCH] spi: jcore: fix divide-by-zero when speed_hz is zero
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-spi-jcore-divzero-v1-1-a8205d30f2d1@xiaopeng.com>
X-B4-Tracking: v=1; b=H4sIAEmPz2oC/x3MPQqAMAxA4atIZgNt/fcq4qA2ahyspFBE6d0tj
 t/w3guehMlDn70gFNizOxN0nsGyT+dGyDYZjDK1VrpEfzEeixNCy+EhcTjT3NimM1VbtJC6S2j
 l+38OY4wfD7MnN2MAAAA=
X-Change-ID: 20261014-spi-jcore-divzero-beb7d7925838
To: broonie@kernel.org, linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dalias@libc.org, 
 Guanglei Zhu <zhugl3@xiaopeng.com>, stable@vger.kernel.org, 
 Weibin Liu <liuwb@xiaopeng.com>
X-Mailer: b4 0.14.3

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
---
 drivers/spi/spi-jcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index a75cd61ec7a3..fc87ad98e4e7 100644
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

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-spi-jcore-divzero-beb7d7925838

Best regards,
-- 
Weibin Liu <liuwb@xiaopeng.com>

