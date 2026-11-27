Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810287;
	b=5H6ljc+J8idey7rxKzSrpNW92mwJoKi0JDC8mqb/03pk20QhZpN6mCYsvxBs2LMtxwvQ
	 xj/LlI+VzYqT4zbQAqPLsRilWU+ascsk6AIpoWKLWNF1c1qbcemMlhcLsdAfK4k5+fXQv
	 JVCWT8yXFcxrpBxxHYjYSppTeUcv5RDVASR1EeGe3txZItTFiRnh5Q6ONHSV5PY10DPqG
	 +4GD/KQqtSohxQPS3xJJXVdWAGKTbBUzseJDjLh39pFDBrn+w2eOK6nGS8+d346oRFtGD
	 rxcQAXlI1xWo+8aBz0yCrSUry9XgmZJ1AVFzneRJuoj3Jy60iKehhu89ceiu/SjMgyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mo4WhXD7sJwoAbEmIqpXQBkgqGcghx9tZqnuJBnC6Ao=;
	b=HiDsHdLUBgShuGBnpLd0irzHZcLK3TbsElzKvHgW6eYZiSp4v/HkG+NGv2FfNucRjbqr
	 u6ylyxHEGNnWfRa1K9kwD3Ip/uzp8j4a4WsvjH1aUnA8+PZGo5wXvi76+xSrV+Bvla2Oa
	 lK5pZGLRSEfvbWjDBz3P4XhQul0f7vM4X/h2Ozwd9JLnauMiaX6rEkcITXXaQgKYUJftV
	 UsUONZlm2qArxg7KXXnYuah1Pdsm+pJiZz+QIBdZXPx5SaGsL12K5q3yHENLvjeKmcMpP
	 wki0yifYi5wvBbcJPK4x+adJjxpJmGHAObVOXMNk6BjpRZMpvO4F+lQIbLui6lh00YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojvD6shL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EC606A321;
	Fri, 27 Nov 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojvD6shL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318131F0089B;
	Fri, 27 Nov 2026 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810286;
	bh=Mo4WhXD7sJwoAbEmIqpXQBkgqGcghx9tZqnuJBnC6Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojvD6shLMJRjsEp8CVwUxJlykpzzeKV+xPxxJiKFFx4ljuXqZ3N1XTgI9nbM3T0B6
	 BavDcbocZ9Qvj+uMIzQ+SeE4SreCW88EvzGMP8lyeHpIpRhzqNIkg//T1+rratwrdr
	 X+f2tR43jiPzQ+N5J+dsbtZDZ9fbHIAgY1O9d0VJG7TvrzQZIknbECh8JK0SNyQG6N
	 hIY2IwKk6oP69bP4+WvYEbUFrXadIUElt4jG8Kou3hXaNniAEiK/NZDlRxrs3E/2fO
	 3C3a/GyixrJOo67Q2f7xayFN8qjvpRbN6UBivkBSgzx2EK7JzBBOgnWLtB70tCmRjv
	 tf68rxB1K1PgA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] Input: aw86927 - use devm_work_autocancel() for haptics play work
Date: Fri, 27 Nov 2026 20:09:58 +0000
Message-ID: <20261127201050.3532488-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
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

aw86927_probe() initialises haptics->play_work with INIT_WORK() and
relies solely on aw86927_close() to cancel it.  When the input device is
inhibited at unbind time, input_unregister_device() skips
aw86927_close() while evdev flush can still schedule play_work, allowing
aw86927_haptics_play_work() to run after devres frees haptics.

Use devm_work_autocancel() before registering the input device so devres
cancels play_work after input_unregister_device() and before freeing
driver resources.

Fixes: 52e06d564ce6 ("Input: aw86927 - add driver for Awinic AW86927")
Closes: https://sashiko.dev/#/bug/linux-819bee30-4290-430a-b9a3-7dbb99d73505
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/misc/aw86927.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 0657c52b4c79..2d6bfb57afe1 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -10,6 +10,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -826,7 +827,10 @@ static int aw86927_probe(struct i2c_client *client)
 	if (err)
 		return dev_err_probe(haptics->dev, err, "Failed to request threaded irq\n");
 
-	INIT_WORK(&haptics->play_work, aw86927_haptics_play_work);
+	err = devm_work_autocancel(haptics->dev, &haptics->play_work,
+				   aw86927_haptics_play_work);
+	if (err)
+		return err;
 
 	haptics->input_dev->name = "aw86927-haptics";
 	haptics->input_dev->close = aw86927_close;
-- 
2.56.1.839.g22a8290db9-goog

