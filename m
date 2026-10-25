Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792968617;
	b=YW4Ru38j0EtSGfiKmDLaKQddns6+vfZXfmyd51UUKd+T9AhEnOWNYLZpLTNgXWPfwG7X
	 Ih7o7GX+KHmOY0GVNik+ByaI+CiAB1YbOfrb+sVaXJQEsBR3IIJ9BGSpkDASmgBCT/Vic
	 QM+4ZMOaAdNl+jzvyY+sLqaSzSqkBh/OlWzuV6BiH/veurStI0YiG9L1fsE/jNuPxaZ1T
	 Y21Yz57NUiJH6Q60aerKBBPsvPmVbuKimTSjfLNlHCawLasMa4qwvYkk+tJbQw1XOIlVz
	 05HSSl0cg7z4SjyTOVzYrBBNi51qFj94t3rzt6cs2dldM/gYOmhM4PlEXUFm6gMTy+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968617;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M4JfuQ+Msvav2X1dVxO39CxfzfONFoSGhNqMG6zkrTY=;
	b=yFzvNam0fp9FLuDc+GagJ6ij3rCmO1tofxxiImOcyRuqrnQ0ez6WyhYOr5jEW3v5DsDx
	 ws/j/b5Jqnc47avOxDT3Iy8S8K/Sn38+vapqhsq4dASODffxF6dIyz+G/0xorqTUi/FTp
	 u5UtRALeMmoCD31eFFhF+8GUE7Py6w4XypfpHWmUhi/BWZJF0guBGqYr16aGlsTQX21+T
	 J2mg4Gqa5PfXj0OQ2dm3wzRS85ww6AlkCimOAkkLJJCwz2/UAUJjoph3fxMlraGPr1GWZ
	 OaZ2qPTMTy7qWP+/3fHDuhYtBsIdv2B88StRqfO88J1J0fh2uTMa/wk+gx+4Pe06wWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFwyJDoR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CB606A321;
	Sun, 25 Oct 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFwyJDoR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792968616;
	b=JJKHokXBdjgGW9NuXUubfkLPmiW0ugAu9T4yRM8E34+DKKGDnqxJuW72ujB+PxJ42A9g
	 VP/Kcmfmzf5VtmHSIOP2++SzxidgwBK9o39AlideRTWNQmUgjQqCFUTeZdORJmyGIKPLc
	 kXalmNLWa3j+Z6fxzN6SJ41feu9eRDaMDYfjAv1DEY3SftuJJkjusWQ3ogBpeGBpXORfP
	 n1PCI22rcoFEl3Tyb8kWvlhe3KBu4QD5koT2b/9Y3w5G/wX6nR6HL5NrcVzZOGwriA5dd
	 WMcX9jWQt64+8+aoRtXnEkEgpct+PWZIpnHnx4WZR32bwkDA1Lv8+aWW4PwXQAQaqIg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792968616;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M4JfuQ+Msvav2X1dVxO39CxfzfONFoSGhNqMG6zkrTY=;
	b=1hxkaifTt4DMopyWq/EgGlcniebCmuKdEBYT/t0/KUk2bmMsWjPl1Pc553bn+Isig4RY
	 Cr9ue8w8L1sPXVXs1QF1REAz9akfEVgkLl2VEhhkF76z3Z79f7a2dCl8Jr4bKzSALMwY1
	 0hRNM4I+0zOIEvWa9M8VH+YPMkC7IlUlN/IQX52pNP1XX5Wb/MLDBV6cWd4CyhIs09JD4
	 lx3bVQrzjKR6GxdcXMDDVjryDKiOrtrpSzPIt31javXadyn3y7RqhN1e4c0Bv8MR3g2GE
	 qh8Aam94IuEiusbQfzFgKopyi/0rSVq0sFbb+9sNEPNmvrGz5qRLTErtAtPFPM2HC7w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 425521F01825;
	Sun, 25 Oct 2026 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968616;
	bh=M4JfuQ+Msvav2X1dVxO39CxfzfONFoSGhNqMG6zkrTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JFwyJDoRmHYN/yhZFl1u6qW0QjjKQNCotYZy7gUWqSaVmoW2XYX/RGkF9uMOy/pUK
	 n07FXmbcvZuVqOpXP0TrSp0Hz1zVLxt5L4/pYNWNAjh5sTnEi0CCpwgSEN8DPOoSLa
	 e1ZcK/Vo2HUJy+ahtWYMb02d3ZGeVK9P1LC76sKWnWChw7Kiuv181Yibx9xus5uWDF
	 oXIshT/mk9lya/6QVRZHp1rWDhHJqL1xuyPlvEHFcElgeaj0JDINNiCF01d6RPb/5h
	 cBIdFXtLc+/+AH/vyXPbPoPm0Ub02WUL0LLwOS+YLfHhw+N16OvWO+yF0OlPubb4Iv
	 S98r4WX97EoBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C86AB44B0F;
	Sun, 25 Oct 2026 22:50:14 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sun, 25 Oct 2026 23:50:04 +0100
Subject: [PATCH 1/2] serial: tegra: Fix overflow in
 tegra_get_tolerance_rate()
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
Message-Id: <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Shardar Shariff Md <smohammed@nvidia.com>, 
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792968614; l=2309;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=gJnftTJ6jB1jgdWypz21lUHPmEbydEvI3zikNjoJOxA=;
 b=85/ZmKHsXEBUB4ErFANq04SO6vKwA0ekArL5/pX4906QeA+JXgLi9gupwXcRW8pZdRbd+HyVo
 x/XKjCDg41oBgSsBgY25ZFYxvz4TGqPhbtp6TtrDbrgzHZsyB5XNXZz
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

tegra_get_tolerance_rate() raises or lowers the UART clock rate by the
tolerance from "nvidia,adjust-baud-rates", given in units of 0.01 %. It
calculates rate * tolerance in a long, which is only 32 bits wide on
32-bit ARM. With a tolerance of 136 this overflows from a clock rate of
about 15.8 MHz, i.e. from about 1 Mbaud, and the rate ends up adjusted
in the wrong direction.

The Tegra Note 7 (Tegra114) uses a tolerance of 136 for 1 to 4 Mbaud on
its Bluetooth UART, as in the downstream device tree. For 3 Mbaud the
driver asks for 47.79 MHz instead of 48.65 MHz, the clock rounds that
down to 408 MHz / 9 = 45.33 MHz (-5.6 %), and the WL1801 controller
stops answering after the switch to 3 Mbaud (HCI commands time out
with -110). The same overflow gives 23.31 MHz instead of 24 MHz at
1.5 Mbaud; both rates were confirmed on the device.

Do the multiplication in 64 bits. With that the driver asks for
48.65 MHz at 3 Mbaud and gets 48.00 MHz.

Tested on the Tegra Note 7 with the tolerance of 136: Bluetooth comes
up at 3 Mbaud, scans and connects to a paired device, and the HCI
counters show no errors.

64-bit platforms are not affected.

Fixes: f04a3cc8d455 ("serial: tegra: add support to adjust baud rate")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/tty/serial/serial-tegra.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b0fc4ae3686f..cc09fbc3aad8 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pagemap.h>
@@ -368,8 +369,8 @@ static long tegra_get_tolerance_rate(struct tegra_uart_port *tup,
 	for (i = 0; i < tup->n_adjustable_baud_rates; ++i) {
 		if (baud >= tup->baud_tolerance[i].lower_range_baud &&
 		    baud <= tup->baud_tolerance[i].upper_range_baud)
-			return (rate + (rate *
-				tup->baud_tolerance[i].tolerance) / 10000);
+			return rate + div_s64((s64)rate *
+				tup->baud_tolerance[i].tolerance, 10000);
 	}
 
 	return rate;

-- 
2.56.0


