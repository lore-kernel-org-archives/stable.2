Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046671;
	b=CmNXaQTMUSxVOmM06diW6XE/uLE63Q+IlSZIYnR5TBDFemmdXr8Mju1/pWB9HQfGqJWO
	 xdwPd1ZvMab979LqdGYiah/JTPatFjaOPJXiK2AMFFhRwxOFe3WmJRMm+WWv+CiYUve45
	 oId5Lja0Y5U80vWoZQLT82srVD9as25b7/2moUDnjmRbDKLdkH479hT5vvI13kjBA6XbO
	 Iojv7dhp/TGMqIXp2wO+XAN5QmBm+M2VGMY+uyDP9m+6lSllz3+IIr8psePitULHZ1ON7
	 CcECrIFUySxSvDMMudpFjh+1UZrG0vDCpctXuxf7fUyLTyXB4kEfMrHdPLFGWoRWBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v2AUulRIrJt3X/iwAown2O8VnRC75H+EsLLiOPdtWsQ=;
	b=UcpLIeGcoItu3em7jf2qh/2T0QykKBzCtWaV+DssjSZwijJ9nDxuB8x5ZcK/vI3LqL5n
	 Wts9XQztRaD2mBmk9WExaGP9uLkXwQvwRIYx5jzg4WUNcSpX2CumO7l0+RTvxbKGeufjx
	 SbbPLJXqxhDPF8N5YYVsEOb1rcmWKq+hV4VwXC5VTAeJCxsCp6gWazujkLJWu71H9ajAc
	 0BgZfs1f+cuEheIuUxL91rFG7QRsqkVFyj/ub8I1+ZM9jXqh5D4yylbrV71dTZ/jll9XF
	 UvtPyg3fqbUNG9YMQqCelSHj2PLjhhmdCQru8Er9M3uZ7oG7wNJbpgZ3x83+Ka/p1Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVnsWFKj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D97606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVnsWFKj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAEF1F008A3;
	Sat,  7 Nov 2026 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046671;
	bh=v2AUulRIrJt3X/iwAown2O8VnRC75H+EsLLiOPdtWsQ=;
	h=From:To:Cc:Subject:Date;
	b=HVnsWFKjJMeoJdA+tujpATzO7XOX5nPQDR9a/sTbAsXVYASxaCV95fyLHY8tfJQqk
	 pgsbwBTgwNqUqCYgYrbF9YvrBCvWatD0a8g5KquUlhIoGCCG+LhbtAAEU69vnaTAUF
	 Jn4WbK5M+Qhs5T8BLzw5Gkr0qQpmbZSWuNv5dCMED33Vibk0biv5kp/rIZHBB7/ixm
	 QiffvcOfMkLEjCY25Z6/+anZyj8iCroj8+nWiEZaZ5Ck2XDrcvgpv+O1I0XJy9xRkR
	 0jOqRZvmkPMm+N/FcWF/P5FK++/GyAfnw9uK/PNeodBjLr/KG+Qe5zux/eW5xT32lS
	 XB1/61pWIyAJA==
From: Sasha Levin <sashal@kernel.org>
To: khurana.ridham222@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (lm70) Fix rounding of negative temperatures" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:49 -0500
Message-ID: <20261107051749-failed-6.12-eddb0aaacce4@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eddb0aaacce4baa9d8176eb2f4bd9e99e867f8fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051749-failed-6.12-eddb0aaacce4@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eddb0aaacce4baa9d8176eb2f4bd9e99e867f8fc Mon Sep 17 00:00:00 2001
From: Ridham Khurana <khurana.ridham222@gmail.com>
Date: Thu, 24 Sep 2026 20:53:23 +0000
Subject: [PATCH] hwmon: (lm70) Fix rounding of negative temperatures

temp1_input_show() drops the low bits of the temperature register by
dividing the raw value (raw / 32 on the LM70). These bits are not part
of the temperature: the LM70, LM71, LM74 and TMP122/TMP124 always
return some of them as 1, and the TMP125 fills them with copies of the
temperature LSB. Division rounds toward zero, so a negative temperature
with any of these bits set is reported one LSB too high.

For example, the TMP122 returns 0xffff for -0.0625 degrees C, which the
driver reports as 0. The LM70 returns 0xf39f for -25 degrees C, which
the driver reports as -24750.

Use an arithmetic right shift instead, which drops the low bits and
rounds down.

Fixes: e1a8e913f97e ("[PATCH] lm70: New hardware monitoring driver")
Fixes: a86e94dc946d ("hwmon: (lm70) Add support for LM71 and LM74")
Fixes: cd929672a9ef ("hwmon: (lm70) Add ti,tmp125 support")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
Link: https://patch.msgid.link/20260924205326.1739229-1-khurana.ridham222@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm70.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 8b525725fef4f..b29bac7a4cc14 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -96,21 +96,21 @@ static ssize_t temp1_input_show(struct device *dev,
 	 */
 	switch (p_lm70->chip) {
 	case LM70_CHIP_LM70:
-		val = ((int)raw / 32) * 250;
+		val = ((int)raw >> 5) * 250;
 		break;
 
 	case LM70_CHIP_TMP121:
 	case LM70_CHIP_TMP122:
 	case LM70_CHIP_LM74:
-		val = ((int)raw / 8) * 625 / 10;
+		val = ((int)raw >> 3) * 625 / 10;
 		break;
 
 	case LM70_CHIP_LM71:
-		val = ((int)raw / 4) * 3125 / 100;
+		val = ((int)raw >> 2) * 3125 / 100;
 		break;
 
 	case LM70_CHIP_TMP125:
-		val = (sign_extend32(raw, 14) / 32) * 250;
+		val = (sign_extend32(raw, 14) >> 5) * 250;
 		break;
 	}
 
-- 
2.53.0




