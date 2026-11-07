Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049218;
	b=IFxfP6FDpgWJuA9wlTMGpEpUYroRdgSI273UWK+y7S4E9g6C/at5PUPCpHhkH0KpH8TW
	 n+P8o0HRJ95RxID7MaLtUeCLNax9DPF3e215wq0W8s2PlXiCorw/MAS0UIl8Hs0ZCqv48
	 nNcKFGcSwLN+GaEPjzV5sR+bKlQvZS65Oi5cdMh40Dq5NzSvXy3kw3H/mQADseuSp45T2
	 Mgep+KSGQFAUs1hFv6G61OBqU+9M0yhupglb7KUuC7tI9Xzgf14xqobcgdJtUby05bK2j
	 AMnLoBrJRZoSEa0xK3eWbw6m62FbVfGNDdz1XtalY4pzCWtAPaHhvRPWTamPHfjcfbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aDuT/GESes1/AAVtpRQDJhhfEjAz10zaTc6op7bdl3o=;
	b=gSlEZNUms+dLw/BkNQdSvQPas2ZirbwUmj94Yz6gB7LGCDyf2y497BpEDO4LrY2TfjsT
	 UN1hmg+QgRwNLNXldMAMOHWfv3FKzTYB7HXKlD5ApJLfK7Rcs77FvBrVEhfYihPbG/u9C
	 BMhp7rM+4US+Md1YIOurvdGFVV640Mw7GkrapMvfoxGEnheZ/Svvkx5CSosIX7fhd5P1t
	 QEVdNya2HYhq5+t8xWezAdYxhiK1xrY23T09wFaktXQ+MzxmGl4yypshf0z0r30enEqsp
	 ub3gBeaa0TmYLFG9i5/bl8ApNoivTG3S9As9u+FcnpaVybKuMpZmxvnIfPUCiB8Rc2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ii3Zcsds;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8B606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ii3Zcsds
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C7F1F0089F;
	Sat,  7 Nov 2026 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049218;
	bh=aDuT/GESes1/AAVtpRQDJhhfEjAz10zaTc6op7bdl3o=;
	h=From:To:Cc:Subject:Date;
	b=Ii3ZcsdsX2fmdLOluPAgAUKXJvzKqHEOL8bhJ74SWTzmboyoBAFl7yUxGA3AL99+K
	 6sPHoOQx3vB/t2Ar58nU629RAwBjvL35tEo14r1HkkbzagnZK1bvPWVZBLl2AyH0WX
	 RhrZVdoFewoN65aMKGE8J/65sYAjBKsN+2JvJGs7Rnmm7DJp7wcs4zoJCSG7meD08F
	 sQHZdlfpTiAwEr2mJkhWA/lFU1abfuBuNqVTHctRhuLJlD0ZGCG0AHR7k4w5QofNxr
	 Z/+AYaRqYh5kIaFi4tM4lXpSry9ol+IbgSzmF0XBUpY7uGDWiR+l7n+RVk7t1HNZMt
	 1EBqzJulAKnNg==
From: Sasha Levin <sashal@kernel.org>
To: khurana.ridham222@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (lm70) Fix rounding of negative temperatures" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:16 -0500
Message-ID: <20261107060016-failed-5.15-eddb0aaacce4@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x eddb0aaacce4baa9d8176eb2f4bd9e99e867f8fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060016-failed-5.15-eddb0aaacce4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




