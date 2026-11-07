Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046052;
	b=yKZYFOnsDOxpvdokFg6LDRWrISawcsbj11/V9KC3l/OvkKjUW1dq37ZEZ74lC8rlMp3x
	 GuFKroFGoITYXOQiznQbDlJ0K2Cb/9HE1qPmGg577kxBiQIn4DH2O0UGYND/xBKQc/7+Y
	 /VEKFPfy/1mlvywMoU43tG5gwZZg9EzFsz1EZWTCAZRDq1d1CpJ7OS1aCRyT2h3Nh0g56
	 sKwfxBAhxdYLuKn8XLnNs+iCDd2x005YqLYErqzZtIJFWoere1yqZhT3sVoUE5skbfH/J
	 VjwVOdk6alMpvsJMWXS9P/W++4MgmsckjGvW//M8P9GUqr9ZwoBE+JNVPRiY6BYQr9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5MOk0AuN+y/C1q4WPBVNtNoSv9iSQJ/bUFfHxduS3JU=;
	b=Gc7Z1Y+ZK1luhh+NG2NI4Fczy2IGAE1s6ybkkoNkLIEAA+jB6RrEBSXVMB7Op+HtfAF+
	 yxJl09RlEN9VYwEGxWraTHlk9aHzqTTKEgsh2bGnDN2jVKviSt6QoDBt9C1lL+9BV0oTZ
	 AtHyrBx0q8RHClsd2H5G58Bxhizuvmi+JDY3e1V3Op95kPsYjSBYNsdY8rj1+/dhpIx4k
	 ICekI+Ci5KiM9FnV+WYKX/bKLjTZ1CtWGTM4MiusPKNyGbyuab/2xJgwCtBV/SNlPIitr
	 pBfu+kALS7lCGT2/gJRe+wJCx5BsJGCFKLij8LldOPaTbcvLrt0x/E71SOi8xuZLUrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czyq9SxC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A5606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czyq9SxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E627D1F0089F;
	Sat,  7 Nov 2026 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046052;
	bh=5MOk0AuN+y/C1q4WPBVNtNoSv9iSQJ/bUFfHxduS3JU=;
	h=From:To:Cc:Subject:Date;
	b=czyq9SxCd02RYspKBHtRRc58CesWxaO5p3qGAWDFzZlhNeMz4vfbLOs0KMza03G5g
	 ft42qklMB7+sgHQFdRkIwWJInUSQOGqZGJSCElAamhvQ9zqPPuFpDVBJ3RkYbTBL0i
	 0MKt1MA1tiD9l/WDHw0Uy7vXjQEhjRI8H5AFr4u/Tzf3qF3weE0k4g5WLrKNOoCjbI
	 Kr0BvwCkVkoN0SWm7nvTK2bo6L43x5zPE8lXtArxkh8+ufIlAtpq51x0W903awTErp
	 292wsXakRZ2URGOZd8lgM5ZC60JFYzDa7KG51fiMDQQ/bEZuQGF/kmiTP8Bsd+coaF
	 7WwY0eJdfLcjg==
From: Sasha Levin <sashal@kernel.org>
To: antoniu.miclaus@analog.com,
	nuno.sa@analog.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: adc: ad4080: enable address ascension for chip identification" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:30 -0500
Message-ID: <20261107050730-failed-6.18-c051d08d9877@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c051d08d98771132868abf0cb95b6de95ab3060a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050730-failed-6.18-c051d08d9877@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c051d08d98771132868abf0cb95b6de95ab3060a Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Tue, 22 Sep 2026 14:09:58 +0300
Subject: [PATCH] iio: adc: ad4080: enable address ascension for chip
 identification
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The two byte bulk read at AD4080_REG_PRODUCT_ID_L expects PRODUCT_ID_L
followed by PRODUCT_ID_H. After a software reset the AD408x defaults to
descending address mode, so the second byte comes from CHIP_TYPE (0x03)
instead. CHIP_TYPE reads 0x07 on all AD408x parts, so an AD4080 reports
0x0750 rather than 0x0050 and every part logs "Unrecognized CHIP_ID".

Set ADDR_ASC along with SDO_ENABLE before the read. This is the only
multi byte transfer in the driver, so no other access is affected.

Fixes: b66cddc8be72 ("iio: adc: ad4080: fix chip identification")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad4080.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 4843ecdd91a83..4ed82aa42400b 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -710,7 +710,8 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 		return ret;
 
 	ret = regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
-			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
+			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE |
+			   AD4080_INTERFACE_CONFIG_A_ADDR_ASC);
 	if (ret)
 		return ret;
 
-- 
2.53.0




