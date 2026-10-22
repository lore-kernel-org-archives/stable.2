Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.236.72.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689804;
	b=S1/OS+LKXw0SQ+aI5CgSYNLMHTxxfpDBoqWcWdqXeWgcJBAZRCPdC+KXBCX0ZmCTkz8H
	 tp/fzDjFlGWVQv+XxBtG1hADi0eJGUZEV89uItzVDXSJ7vV7Gw46/Yb6+p8DAxqMDef69
	 lCQe+hdedHx2Tar5XzwnPNZYHBiOI/F2+rgoOxV8/ZfnXcQALjhjE09ux2pDjV/yW5UgX
	 VQXxN5YuyhuMYLC5554f3qX+FTqGXXfbv51hp4rvpE61A6DgeuOwVJyVoYmev9ggXq0wF
	 Pz9GLAcXQZQvcIsWd1z/bnpEn6ozKHjsbtfLeUk36EuyDqkepUw66tdebOJ7y3HGdyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689804;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=thSJ3bCn/tf8G8rEiYpl8FC1iITEPQN8q2L25+07Du4=;
	b=f5rZRDhUSH/f1p73E4wKzxbO6k9E4s4RgY2WH6CXfeuW6Vndqe1p8hKvRKED280+IRhe
	 42hW/NCJUYdVgHxr4OHkcH4bnEtQM40FKuMngKsM9gCkRoyCU2HlY1VSTbiqpp9k6mABa
	 Vg9qGRzK9T5cP+Q0w3hvCwQMV4CMrOSmIGItj0vnH7xgNzFGY8fHEQeOSaMkv6jD73bzD
	 0kj57J5YJ3t8XdcG/TMBD2a0mr7BW8g5SpxDIDmQcamy3IOxzd5uDyEZlPN6Q+Mf9Ho2r
	 ILeaKMCW+BarPuIcdco/LBtME6+xZHGtxuj2csw/MAT+XvJZnwiMBJlzlkOjCfRlmOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tpz.ru;
	spf=pass smtp.mailfrom=tpz.ru;
	arc=none smtp.remote-ip=109.236.72.118
Received: from mx1.tpz.ru (mx1.tpz.ru [109.236.72.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1288606A31A;
	Thu, 22 Oct 2026 17:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1288606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tpz.ru
Received: from lvc.d-systems.local (unknown [109.236.68.122])
	by mx1.tpz.ru (Postfix) with ESMTPSA id 4j9Xzf4l6Xz10QYQ;
	Thu, 22 Oct 2026 20:23:10 +0300 (MSK)
From: Ilya Krutskih <devsec@tpz.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ilya Krutskih <devsec@tpz.ru>,
	lvc-project@linuxtesting.org,
	Sergey Shtylyov <s.shtylyov@auroraos.dev>,
	Kees Cook <kees@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrick Boettcher <pboettcher@dibcom.fr>,
	Olivier Grenie <Olivier.Grenie@dibcom.fr>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: dib8000: validate SNR exponent before shifting
Date: Thu, 22 Oct 2026 17:23:07 +0000
Message-ID: <20261022172308.224576-1-devsec@tpz.ru>
X-Mailer: git-send-email 2.43.0
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

Decode the SNR exponent as a signed value instead of storing it in a
u32. Subtracting 0x40 from the unsigned exponent currently causes it
to wrap around when the encoded value represents a negative number.

Keep the signal and noise mantissas unsigned, as they are used in
unsigned fixed-point arithmetic. Check exponent values before
shifting by check_shl_overflow().

Return the existing invalid SNR value when the exponent cannot be
represented safely.

Fixes: 77e2c0f5d471 ("V4L/DVB (12900): DiB8000: added support for DiBcom ISDB-T/ISDB-Tsb demodulator DiB8000")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
---
 drivers/media/dvb-frontends/dib8000.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index d291113291e0..442ec06e34dc 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <asm/div64.h>
 
 #include <linux/int_log.h>
@@ -3873,7 +3874,8 @@ static u32 dib8000_get_snr(struct dvb_frontend *fe)
 	exp = (val & 0x3f);
 	if ((exp & 0x20) != 0)
 		exp -= 0x40;
-	n <<= exp+16;
+	if (check_shl_overflow(n, exp + 16, &n))
+		return 0xffffffff;
 
 	if (state->revision != 0x8090)
 		val = dib8000_read_word(state, 543);
@@ -3883,7 +3885,8 @@ static u32 dib8000_get_snr(struct dvb_frontend *fe)
 	exp = (val & 0x3f);
 	if ((exp & 0x20) != 0)
 		exp -= 0x40;
-	s <<= exp+16;
+	if (check_shl_overflow(s, exp + 16, &s))
+		return 0xffffffff;
 
 	if (n > 0) {
 		u32 t = (s/n) << 16;
-- 
2.43.0

