Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258766;
	b=12U9UoZN+SYnD5RI4xqV5I+y2lMWvHHNUFLbX84YRzZFOniAvfxqLH2u4cbo9FgfwI2l
	 TguyEqS+r2haSiW02Tc36og0pwc470yOjpKyjisgYH2qMmn3Ff2XIgBAZEAPoWzU5ZuDG
	 K1gVZL8wLB9a4js1dQIBOv6A+yNKg0+S/fRBCbkTPVOIEYaELExM1ZkbWYU1Y4IS9zLd1
	 qDBWiY+4+EC2y9jLVY9StCCsjcso+Lo4A3DHRkZkF/KWTiFVNPKnwP/x5310oMIhaOZ6Q
	 91hF6SA8irOwT5MB68r0AKiv29uJgC1KAnQrAa067ctx7mldeI9+M7oIKV3orP6BItw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258766;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KfTmqV1ZRBoeeX2MvP1wgx+YgUBgfae9dIpdFcZDNUU=;
	b=yz8Kj7RDDJEdoR0LiOPTkY6QO56QYqrH6L2AtAIqOeyP8CEaCTu+Uwwzlm6xz7BxlGc6
	 M0ANVwKsyFHXP5sC3X2dAFltBi3aHMgytQpaq+jkTajhg/rmdU3q+RJjhoLoU4entZQvX
	 WeibyjsM+huSKWyLChYk7ldwkjYssoKZws6qHJz4P++SbLbztLl9uOwEGRznp2Y0HVKzU
	 4s3OhykpfiFSYlrhrw5i9NRR/ZOGdcy+sEGcWLZohTJz6S5+c9xNicJoHNETe6OvmcKyj
	 llhAIf8+BfoRWT/VRCp7NlUUlqRtjlZdzD8fZb4B/u+vsrwKJzwhu03BLZ0NjsDaVnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Y0E5wm04;
	arc=none smtp.remote-ip=115.124.28.219
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB1606A323;
	Thu, 29 Oct 2026 07:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DDB1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Y0E5wm04
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793258756; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KfTmqV1ZRBoeeX2MvP1wgx+YgUBgfae9dIpdFcZDNUU=;
	b=Y0E5wm04S3lz83urXcWWOWCCanocrQoMkjRDV9AcYnWibQqGEXB1JX8VyuOk4HGHNuWn/9xZi3Li46cDeoGnV362kRnShXIKH1MwLpujsWfMYV6OysRmw5Hx930G07CDY0nYADnM/113K5MN2Xa5YCwc+QGKpH43bXT6DUgUXTE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07677579|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00397865-0.000802535-0.995219;FP=16677390569107637430|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.js5ME5r_1793258755;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.js5ME5r_1793258755 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 15:25:55 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Manu Abraham <abraham.manu@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: tda665x: fix stack overflow in get_status()
Date: Thu, 29 Oct 2026 15:25:54 +0800
Message-ID: <20261029072555.4133415-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

tda665x_get_status() declares a single-byte stack variable and passes
its address to tda665x_read():

        u8 result = 0;
        err = tda665x_read(state, &result);

tda665x_read() builds an i2c_msg with .len = 2 and .buf = &result, so
the I2C transfer writes two bytes into a one-byte buffer: the second
byte, controlled by the tuner's response, lands on whatever follows
result on the kernel stack.  The get_status callback runs on every
FE_READ_STATUS ioctl, which frontends typically poll in a tight loop.

Verified with a userspace copy of the two functions under
AddressSanitizer: the 2-byte write into the 1-byte buffer reports
"stack-buffer-overflow WRITE of size 2".

Make the buffer two bytes wide and test the lock bit on the first
byte, matching the register layout of the driver.  The buffer is
zero-initialized so the unused second byte stays well defined.

Fixes: 3e978a828408 ("V4L/DVB (13797): [Mantis/Hopper/TDA665x] Large overhaul,")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/media/dvb-frontends/tda665x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda665x.c b/drivers/media/dvb-frontends/tda665x.c
index b2201ec14..7b876c16a 100644
--- a/drivers/media/dvb-frontends/tda665x.c
+++ b/drivers/media/dvb-frontends/tda665x.c
@@ -66,16 +66,16 @@ static int tda665x_get_frequency(struct dvb_frontend *fe, u32 *frequency)
 static int tda665x_get_status(struct dvb_frontend *fe, u32 *status)
 {
 	struct tda665x_state *state = fe->tuner_priv;
-	u8 result = 0;
+	u8 result[2] = { 0 };
 	int err = 0;
 
 	*status = 0;
 
-	err = tda665x_read(state, &result);
+	err = tda665x_read(state, result);
 	if (err < 0)
 		goto exit;
 
-	if ((result >> 6) & 0x01) {
+	if ((result[0] >> 6) & 0x01) {
 		printk(KERN_DEBUG "%s: Tuner Phase Locked\n", __func__);
 		*status = 1;
 	}
-- 
2.50.1

