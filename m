Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047420;
	b=2TbpM+/nKP2bC9+bZFQpyVfn4JXnxNAb+CPnJpkw5sDqNwVz0FLUVwjXMv5IuUQEZFW9
	 s35AlMzge0Vw8TMWvLBuC14R5pufbgW0pmVRQ0BvvTK9TqigBn1ytfiLnvGyGTLTaLpqY
	 0Xe8wSAH4TwuMFwPMcyNg3FVZjZ9ZMMz4w1OZtEXp+wKcN2CvUyzyJOhQUEuYiZ9aD3vY
	 TbhYc0valh8K57WFGGCIcSUngg+9aYZetgtN8JxyfEQGs86GgYoIugG7/vQS4CegQWp/t
	 pL2S+jSE4WwuChqNdxL8vvp1VzaczF3cUDZmESmHs84ehUxRzaNwNUDD83oLAvO3tmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UawmO9XHgs0LRk3ffIhBzXX6O3N2lWljxFX4+xI0nwU=;
	b=QuLc4cwl9MNNEs2Sgp5emJnGAxPjJghxAZP+3sLBnlP6DjYba5nDmlxp6J7zVu8p6JfK
	 qdG64LA9ddOgzODbz7P6dzfTDqClSgo4d/rP121y9zOx0S9Q1qIpvxxPHN245G1ZFkZ9/
	 r/b0fNauPJP5zYs3V8Pcrq0mqsryhbqvUF2zJ5X8qOcAymTmCUzoVK4br0BDWqyyoyQrr
	 ps+FUhbTMbrqfTgs446HXwJHIDzVtO88NUrgRhdkW/5fZ7Spm5h2Bz4TYAoy8GP9z1tqc
	 ryQ46ruNBq2nvpp4vQ1iVhVNWYBJooAtkfNiwtjc0An2d2w7ZfZzVVt1slNza47mpZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkEUreXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51A606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkEUreXs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E10C1F0089F;
	Sat,  7 Nov 2026 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047420;
	bh=UawmO9XHgs0LRk3ffIhBzXX6O3N2lWljxFX4+xI0nwU=;
	h=From:To:Cc:Subject:Date;
	b=DkEUreXsOZ5rziQISMRBz3VjymhIPvoMkbQlPnLgrKh3+dF21GXVaHPpRemPO2e+3
	 7NUl436Ufc36Lq6SoYcn0FPRFvma7O+q/nbj62mvwN7SkF1fqQV6rbS68mf0IqVtb6
	 oZtaA9RlVqPbYpxAbNEMUtop/ZFS/JNtSDu37gWPoeEPNUXUOhw0IbrlXjmXHTagk9
	 xbWr5c2BiUJa04hbvkGPiQA6GJnHdskpap4MJ0izil07Jj/RNg8iRKAmr6t80RzFUQ
	 Ww3AF/c7+0EuRsX3FMBdiNoUxKgYVhn3hxDSHaJ7fTS9tRqqCea+OYXK+MA62DE/VV
	 V+bCWaeIPyFTg==
From: Sasha Levin <sashal@kernel.org>
To: khurana.ridham222@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (lm70) Fix rounding of negative temperatures" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:18 -0500
Message-ID: <20261107053018-failed-6.6-eddb0aaacce4@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x eddb0aaacce4baa9d8176eb2f4bd9e99e867f8fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053018-failed-6.6-eddb0aaacce4@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




