Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050632;
	b=2B74FpUWonyQ5uew5+RQDSIHUfMcgpBENfOZ1mQxJiA9U1g1hXWFlLw43Iad9hNdR9/X
	 YUJhyln66J07c+VNJqO/4z1HHUimgmhzHUqjg5Cs6q3otgxRpyCmvslrHYziCvOvtG58d
	 mQdFuoH0vkbcyH3UkunT5qTlZhToFeO8DkpgbrCOqoj4GW01fUBF3RMumhXuHlM9RQz+W
	 GbQh4Bk+uHpGLPJ66XDjkrkv7gfL4oTZZ2Yw5Vhtl9BPKxHtOVcV4NkvmR2vhYUGUbDkX
	 ALyvRW1VL99wLrKq/hdHFFK+IFXbgGvwtzs8RPe8CjuLecAe2j+v8FdZUZO6QPzDLDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CKys/iQCGEDkHBOdDbf1oON5YhXKMtORS8a5pxr1OcA=;
	b=H9tLPpV+I74qf63+d5M8AY3anekqyAYvv/6LFcnrzbA1c37xXshpA5HwxOSDDPNzTkRT
	 JQtI6/hP7eKif0CLgucuS6HtaXwUH3IWbOFGNMlw/UVkWbt75lORnWEVvzwrOWbwJTPzs
	 i3Z/W7uhF/w3U9KHNkQixgPjjm21NDBgAw1TroKkIaz0vAbE+5GSsdgtD/GCc5IPdLMjS
	 7GCH9C+AzCxuKHClHxpPVSRZrd9LZuKq2jPdRTnVuNM6GJbKEgWOXxCYkp9Jxg4pmY45/
	 FtjgCO4m6xeAY9Osf2y5Wnp+f84NoLjigmO6lMu/uj/HjMe7eEiT7dXGzpzL3S9zuIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMM1enWM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98600606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMM1enWM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBDE1F0089F;
	Sat,  7 Nov 2026 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050632;
	bh=CKys/iQCGEDkHBOdDbf1oON5YhXKMtORS8a5pxr1OcA=;
	h=From:To:Cc:Subject:Date;
	b=oMM1enWM2UDjmbE3iX324V2Yzom2udgbDzgD6qNz28TTYNWEOcc07i0pnkJqpdHDo
	 YcnMvwmz9jdm5XikkV5L1+ipDgHxAFOqKiJpMctglsvJ9Fokci7E3Mlba4ydA1eBOC
	 TPVnhfMPSPony0N2MH5rGwRmAWsjSJ2SuT2cdU9O8nZm6ktVjPBovxxGwB7AAtJ1yX
	 BbBN6ht8Xr5BHSgZAu7vAl3g+/ApecbIzeqw9LWQdckKeqSA/L9Sinm8Po1GhA3vZc
	 kBW6T0F4bR7dWz1a8P+RUtIRWkrV4Nj0C/TLutJlsy6mpZ725O7TR1jG33eBeBseSN
	 I3mUDKcNn4Fsw==
From: Sasha Levin <sashal@kernel.org>
To: liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: jcore: fix divide-by-zero when speed_hz is zero" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:50 -0500
Message-ID: <20261107062350-failed-5.10-7db773075501@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7db773075501248893c22b11bedc6745d6d0be45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062350-failed-5.10-7db773075501@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7db773075501248893c22b11bedc6745d6d0be45 Mon Sep 17 00:00:00 2001
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Wed, 14 Oct 2026 22:18:50 +0800
Subject: [PATCH] spi: jcore: fix divide-by-zero when speed_hz is zero

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
---
 drivers/spi/spi-jcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index df82e8adb7c61..347f14f7568a0 100644
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




