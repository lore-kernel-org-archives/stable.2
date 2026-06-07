Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1771A9F96;
	Sun,  7 Jun 2026 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848211; cv=none; b=QCwk1zmntmURJ6qhmnO0zWwlm0pWzt8LGgPu2+Vhiocov+abROo7nCdGUzSNaqnmQq3A8F2eeGWczeKLYDkSD7kAMkMrm4Bn2elqtYp+bLIGj5jMStiT0sO0kKOId2YWOAX5qdeiL5YILUtDJc2Zp6bKTETvxVkAW3O8pjvhVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848211; c=relaxed/simple;
	bh=D+n393191TsGTgI/wtMhvoe3XTU5uih8PIf/wLuusSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dazlpqNmG0dXnybVbYaG68wgM282l99/OucbKayBfzl1ZuY+qwwsXKkEEHUa8o/mGvwvp3FX/h0e8YM5xPkd1tb1Ngsb1vqmmyDzjhi2gzhEg8m0jv8buH8afiCIArJgqq9a5a831piCrcTlj/h8sMu1OaNdmEcb+rtPxJbIGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.15])
	by APP-01 (Coremail) with SMTP id qwCowAB3HdZEliVqOeXSAA--.381S2;
	Mon, 08 Jun 2026 00:03:18 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Clinton Sprain <clintonsprain@gmail.com>,
	Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Input: appletouch - fix offset caused by smoothing
Date: Mon,  8 Jun 2026 00:03:11 +0800
Message-ID: <20260607160311.2192061-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3HdZEliVqOeXSAA--.381S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw45Jw1UJrW8XFyxZryrJFb_yoW8GF18pr
	WFgFZrKr1DJas3K3Wjqw47ZFyF9wn8Zry5KF1vgwn5Zwn8KFy0yFyktFW7XanrCw4rCF42
	qFn0vrZ8ua97W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

The smoothing code introduces 4 sensors of margin on each side of the
input, which is not compensated and leads to a offset of 4 * factor added
to the calculated coordinate values.

However, the maximum value reported as ABS axis parameters are
calculated with the sensor count multiplied by the factor, which leads
to the coordinate values going beyond the maximum value and get ignored
by libinput.

Fix this by subtracting the index by 4 when accumlating the smoothed
values. This makes the reported coordinates in-range again, and libinput
stops to drop touch events in the right and down side of the trackpad.

Fixes: 739204bc9577 ("Input: appletouch - implement sensor data smoothing")
Cc: stable@vger.kernel.org
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/input/mouse/appletouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index eebeb57515e1c..174762d59f87b 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -415,7 +415,7 @@ static int atp_calculate_abs(struct atp *dev, int offset, int nb_sensors,
 		 * by scale. Mostly noise.
 		 */
 		if ((dev->smooth[i] >> ATP_SCALE) > 0) {
-			pcum += dev->smooth[i] * i;
+			pcum += dev->smooth[i] * (i - 4);
 			psum += dev->smooth[i];
 		}
 	}
-- 
2.52.0

