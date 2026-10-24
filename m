Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.236.72.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841766;
	b=DP8Od/SudFRnMd94X5RQeAhIrXiWavmxLfkNzb5V9LUeWvOyoO1tr3osVZ9CN9ViQN5J
	 5IFNIWxYJdv5JO0x7R+RtzaUQqLJAejUSnZg8EX1hGKIYronLDT9TbbFeSolet27ka8Dc
	 ZSjGpPqG9+2RNahUBue9iJAlx/Y2DFEVM8OSjhcM11jJEV85kn/pq2UhNe8O6SSDozuOB
	 9Nj12NfP9SsWdbdCpaCi/ZEGcnjrW9bwwMezQBReV/WZVBvPzLgOhkmSqaGI8EP2kcsi4
	 MfjDnxTtevRU+YchtQ86/jhbaaqzzGjLfkFUP8okvWzezxtQOiP3S1XbvLKB9dTqu+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841766;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j5d8On782HfoO/9+wDcAK56o/QoENDdGAy0pdb+WDBw=;
	b=x36kgNF8bKUhLDi8s1azDkXDDkxEuQWWyQcGWm5wpWd3HCUes+rIKWMeW4yQ/pKvFkZ6
	 7KWYox5oyKNGnF6Gsvzt1jCdrdXm1dpKQdA9shlHofxi0uPqb7+Rt759hDcjZgETBqik5
	 xblwOVICH1/k6vFzYxRqc+eOM/g35GEri1C7MHxD8AtaYbvXWhBEEjSEoZCM5AF33uMBH
	 Nij7sNT5b48hwCiE2OAo2hVvyAGcwwaJeUDa36UDkg6irIxKvTZUupO4GEnMKpcjYRdc8
	 TF10AtEdjyu7M2HwO3g/qZHO53xhaGUGijNlR9qyh53xwaRnKdHDGO155yMXdBxqUZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tpz.ru;
	spf=pass smtp.mailfrom=tpz.ru;
	arc=none smtp.remote-ip=109.236.72.118
Received: from mx1.tpz.ru (mx1.tpz.ru [109.236.72.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99549606A31A;
	Sat, 24 Oct 2026 11:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99549606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tpz.ru
Received: from lvc.d-systems.local (unknown [109.236.68.122])
	by mx1.tpz.ru (Postfix) with ESMTPSA id 4jBdB11Vpnz10VFG;
	Sat, 24 Oct 2026 14:35:53 +0300 (MSK)
From: Ilya Krutskih <devsec@tpz.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ilya Krutskih <devsec@tpz.ru>,
	lvc-project@linuxtesting.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] media: dib8000: validate SNR exponent before shifting
Date: Sat, 24 Oct 2026 11:35:48 +0000
Message-ID: <20261024113550.542776-1-devsec@tpz.ru>
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

The exponent extracted from the hardware register can produce a shift
count outside the valid range for u32.

Keep the signal and noise mantissas unsigned, as they are used in
unsigned fixed-point arithmetic. Check exponent values before
shifting by check_shl_overflow().

Return the existing invalid SNR value when the exponent cannot be
represented safely.

Fixes: 77e2c0f5d471 ("V4L/DVB (12900): DiB8000: added support for DiBcom ISDB-T/ISDB-Tsb demodulator DiB8000")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
---
v1->v2: fix unsigned value checked against zero warning

 drivers/media/dvb-frontends/dib8000.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index d291113291e0..c9873659d5f5 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <asm/div64.h>
 
 #include <linux/int_log.h>
@@ -3869,21 +3870,23 @@ static u32 dib8000_get_snr(struct dvb_frontend *fe)
 		val = dib8000_read_word(state, 542);
 	else
 		val = dib8000_read_word(state, 544);
-	n = (val >> 6) & 0xff;
+	n = (val >> 6) & 0xffU;
 	exp = (val & 0x3f);
 	if ((exp & 0x20) != 0)
 		exp -= 0x40;
-	n <<= exp+16;
+	if (check_shl_overflow(n, exp + 16, &n))
+		return 0xffffffff;
 
 	if (state->revision != 0x8090)
 		val = dib8000_read_word(state, 543);
 	else
 		val = dib8000_read_word(state, 545);
-	s = (val >> 6) & 0xff;
+	s = (val >> 6) & 0xffU;
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

