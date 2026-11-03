Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687576;
	b=Kwa/0D9OXy4TmBhuivK+ebQoGO6NVSZiaBf2oEi9ZZEIQD0MxgWH4LQmfTbkErt/tvvz
	 kHEGM7XdVWU0r8hw4Ife0qAm8Uocy2fA05eKRGvdewy3s1ogGMIf/u+/P26jg06pA9X8/
	 kXVb2iNDGnfTjNmpmSZavqQolT8MIuRtN5KELl2oAYKLN78uQz8DJQ82IZrI9X1o1N6R4
	 4b8z43qf+VnY68JgGIjpKeArfZX/bYFrhlvZecUCAWYp2okNwZ5nucnlmXR/8xDvdKjn0
	 e52xv0xdwe2e1b2MJdQKyP/TbDgt4mPn/zP7Z7FL/1cLT1lyX/lz0BQUlNRxmZcntiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687576;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=LCV06vaBbD7pZm7HR8b5uypIVhlDZcGEq/Q2UKnSARI=;
	b=pNUvDtcDQi8K32eRUTQNNOalINfcWMiIL4wRWJtYpXj1AzZuGgbykz/P0LbDj31PcHJK
	 J6fne318XqB15ga4p42FqC9E1AZjjlSgYr3AIs782OhRWv9ycteRrXIWm0QxxDEZ6M14M
	 1wlacR5EjjUo1Bwwqnk23oUz0F4klXp8+8Ht3wsgWqUyFo48i/aSvYcZiP+4iN3/8yVf8
	 L0B9HDGmH9z/LAinv+ShcM0Hf5QZMIebgaa+EBhlbFX08CQtNpYyRCm12e3vpviowhTCU
	 wNKuNzzHzkcp+R1GYJooxHq4SJNxPVmt2k7++Ixq988XWUntsY2FZwNt6VniVYE1Wvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DE606A324;
	Tue,  3 Nov 2026 06:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 672DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnOJkUgOlqLmU5AA--.431S2;
	Tue, 03 Nov 2026 14:32:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Cc: linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: comedi_bond: Track opened devices independently of subdevices
Date: Tue,  3 Nov 2026 06:33:01 +0000
Message-Id: <20261103063301.1025860-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAAnOJkUgOlqLmU5AA--.431S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4xKw4kXFWUGr4DCFy3Arb_yoW5Xr1rpF
	4rua4YyrW5GF43GF4UJ3yUGFn5Xw47tay8Gr18Z34FkwnIyFySvFy8tFyYyw43AFZ2vF43
	tFy3XFyUCrs8CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiL05
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQAA2rpWtl5PwAAsG

bonding_detach() closes devices by walking the bonded subdevice array.
If a device has no digital I/O subdevices, do_dev_config() never adds it
to that array. Its open reference is then lost. The same happens if
configuration fails before the first subdevice entry for a device has
been added, for example when allocating that entry fails.

Keep the device returned by each successful comedi_open_from() in a
separate array indexed by the configuration option. Close those devices
on detach, including attach failure cleanup. This also removes the need
to deduplicate closes for devices with multiple bonded subdevices.

Fixes: 3cf840f65ad5 ("Staging: comedi: add comedi_bond driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/comedi/drivers/comedi_bond.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
index a10cfbd04c72..ac8937550ce9 100644
--- a/drivers/comedi/drivers/comedi_bond.c
+++ b/drivers/comedi/drivers/comedi_bond.c
@@ -55,6 +55,7 @@ struct bonded_device {
 struct comedi_bond_private {
 	char name[256];
 	struct bonded_device **devs;
+	struct comedi_device *opened_devs[COMEDI_NDEVCONFOPTS];
 	unsigned int ndevs;
 	unsigned int nchans;
 };
@@ -215,6 +216,8 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
 			return -ENODEV;
 		}
 
+		devpriv->opened_devs[i] = d;
+
 		/* Do DIO, as that's all we support now.. */
 		while ((sdev = comedi_find_subdevice_by_type(d, COMEDI_SUBD_DIO,
 							     sdev + 1)) > -1) {
@@ -312,24 +315,28 @@ static int bonding_attach(struct comedi_device *dev,
 static void bonding_detach(struct comedi_device *dev)
 {
 	struct comedi_bond_private *devpriv = dev->private;
+	unsigned int i;
 
-	if (devpriv && devpriv->devs) {
-		DECLARE_BITMAP(devs_closed, COMEDI_NUM_BOARD_MINORS);
+	if (!devpriv)
+		return;
 
-		memset(&devs_closed, 0, sizeof(devs_closed));
+	if (devpriv->devs) {
 		while (devpriv->ndevs--) {
 			struct bonded_device *bdev;
 
 			bdev = devpriv->devs[devpriv->ndevs];
 			if (!bdev)
 				continue;
-			if (!test_and_set_bit(bdev->minor, devs_closed))
-				comedi_close_from(bdev->dev, dev->minor);
 			kfree(bdev);
 		}
 		kfree(devpriv->devs);
 		devpriv->devs = NULL;
 	}
+
+	for (i = 0; i < ARRAY_SIZE(devpriv->opened_devs); i++) {
+		if (devpriv->opened_devs[i])
+			comedi_close_from(devpriv->opened_devs[i], dev->minor);
+	}
 }
 
 static struct comedi_driver bonding_driver = {
-- 
2.34.1

