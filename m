Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699171;
	b=cRHcOoL4KLFbkmb4U/pV1Kq+0c8YPksg0UzV+2PuHmNlSh85iWSEU1Tba5snzqh8OfTz
	 FVCELYYBYzAdsJZM6KAgzijOG7eKjI55Si+n4fejjxlpcnta+VSDLjr8r5/Dc8TPgX2jT
	 qJ13zJ2vxQDnAeg5LSJDrp/03cvsLC1yz60ixNNCYmCjOKXcybRYkunFTbu7xTyhxxw3C
	 k6hC9dEALmtJEl8N7wXIG4AS/mFZeRACWg7FZavzaB43TAzHygnDMGduZe2FEhH9tseBP
	 yH532wEFz0W910oPNQSZ7eJM+Ysh8nGccZUiqGst5OnR1+Q/wC1YqiwQXgUNz8hBHLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699171;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=IpkmDYaV7snRprh1mk9UbQICCs1yiNM3RBG520IwuaM=;
	b=AjNRTquWrU4+9LgDNzQUrVUC4f23humqpIO+FJKAlkjgKq/LDw2UZwTps3LKukauEKic
	 YrbgU+h7Xf4/UckQMhQqcLUpQj5j9d1vaRa5Zq8NqngU3MgmlpMba0YvFqYrz3ehAMqkB
	 vqpBqVvX6FryVIN4j3RBuNAPmxQg5zVB0DbTyj8s/5SUfX26kC45z2Sa2kbd+EZVUjsCi
	 5YHjAZ1autoi+LOmrvC7eB2nQCrwATqMq43Lw1yOutcyUTNJLwF+Dw/7/61QmP6YB7H5O
	 3gdBPCRyIQVHhpq0cxql5Qsn4su0pMKDzNxAActI0ZJtI6rsANtopkMcRYfABnPeYlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FF606A329;
	Tue,  3 Nov 2026 09:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E0FF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHk5RerelqyE47AA--.5864S2;
	Tue, 03 Nov 2026 17:46:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Akihiro Tsukada <tskd08@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: pt1: Detach the frontend when registration fails
Date: Tue,  3 Nov 2026 09:46:15 +0000
Message-Id: <20261103094615.1289328-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHk5RerelqyE47AA--.5864S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4UAry5XF4ktF1Dury7Awb_yoW8Jw1kpr
	Z8AryYyFWjqw4UXrWqyw10kF9IkF4fK3ykCa1xKw4fArn3GFWxK3y5ta47Xrs8Kr4fGan0
	ya15Xryfu3srAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1YsjU
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpnOFO9QAAsJ

dvb_register_frontend() allocates the frontend private data and sets up
two references: one is released by dvb_unregister_frontend() and the
other by dvb_frontend_detach().  If registration fails,
pt1_init_frontend() returns without calling dvb_frontend_detach(), and
the error path in pt1_init_frontends() only releases the tuner and demod
modules.  The frontend private data allocated by dvb_register_frontend()
is never freed.

Call dvb_frontend_detach() before returning the registration error.

Fixes: 4d1f413e820c ("V4L/DVB: pt1: Support Earthsoft PT2")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/pci/pt1/pt1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/pt1/pt1.c b/drivers/media/pci/pt1/pt1.c
index 7cce6576b4cb..4bf9db375173 100644
--- a/drivers/media/pci/pt1/pt1.c
+++ b/drivers/media/pci/pt1/pt1.c
@@ -947,8 +947,10 @@ static int pt1_init_frontend(struct pt1_adapter *adap, struct dvb_frontend *fe)
 	fe->ops.init = pt1_wakeup;
 
 	ret = dvb_register_frontend(&adap->adap, fe);
-	if (ret < 0)
+	if (ret < 0) {
+		dvb_frontend_detach(fe);
 		return ret;
+	}
 
 	adap->fe = fe;
 	return 0;
-- 
2.34.1

