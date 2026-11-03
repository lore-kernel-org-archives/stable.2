Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699173;
	b=WbLw8fA9Oh8+dG8VGsADymJUCLHHtUB9k7elIDeMa2ShtaeWAOd2QAhD0tDO8MIOvSH8
	 JW8JtQCFvUn7+NNwl7SXeOkTMamJmImUMQxP6/9WPsgQ7jREyxK8CQZKbcE/zOXUrs6m0
	 i3rBPq9EF5HT8CBJC0cuSXK+QD645pfNxxYib9ncYvQTv/RVdoXBnrDYjGYRrT5FpASfK
	 8gORWm/SSkB5zetQBo2nzT3aQ3vijlfIJ+DcCt8l7CQf0peL65jCFRyoZooQttodSmCHv
	 QbvkqqisI8AWQw0m8AwxQxn0xxZZa2QWTVeKusajPz9WrVDi36fUi5+TdOkpDW1xcNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699173;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bmFdjXQUpeOr3xa+2oeO0CnV18ZN7c6OltV/r75e4go=;
	b=HEOuy6itaPP/23fXo1MYO2LrRQmgEEZkm6Xn66rZp/6ZWtS6NGlC0aw+Lgt110SoG/PN
	 1THZKtakr80RSyE1+urxHU9sSd9V6oawXiW4mL9gbst8nYpV1xvSsMH3VXUGzaKakqu1j
	 ZXjYc+30AZRaM+wTfLwwt1kWlRtEJv0Lk5aaeRctIq5Xvu3huFjhkXO2Vv5drq8ROFPcr
	 Q/HyXv1ZZZqdIg6LsMdN2B5PIzSOjRL0aaLB1qZ0wwJ5Ur1s+LIGznyVQ5327o0zMMtxo
	 R+wMnq+3qFmu7hRthdSmO3Jz4YK2W6aRtfcGYSSygD6qDd5Uww7CrhoFevW+cXANHqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67524606A334;
	Tue,  3 Nov 2026 09:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67524606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnt5hhrelq6U47AA--.2323S2;
	Tue, 03 Nov 2026 17:46:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: radio-isa: Unregister v4l2 device on probe failure
Date: Tue,  3 Nov 2026 09:46:18 +0000
Message-Id: <20261103094618.1289428-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACnt5hhrelq6U47AA--.2323S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWrAF45Kr1DtrWxXr4fKrg_yoW8GF1fpr
	WUZas0krW7Xw4Ivw47XFyUWFy5Cw4SyrW5CrW7Wwna9rnxWFyIyrykWayjq3WDtr4xWa42
	vrnrXr1fAr18ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXID
	7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYAA2rpnO5OMAAAsN

radio_isa_common_probe() registers the v4l2 device with
v4l2_device_register(), which takes a reference on the parent device. If
creating the controls, calling the driver's init callback, setting up the
controls or registering the video device fails, the error path frees the
control handler, releases the I/O region and frees the card, but never
calls v4l2_device_unregister(). The reference on the parent device is
leaked, and radio_isa_common_remove() does not run after a failed probe
to release it later.

Unregister the v4l2 device in the error path before releasing the I/O
region.

Fixes: 137c579c12bb ("[media] radio-isa: add framework for ISA radio drivers")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/radio/radio-isa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/radio/radio-isa.c b/drivers/media/radio/radio-isa.c
index 1a144536ffa7..dc905c57e3e7 100644
--- a/drivers/media/radio/radio-isa.c
+++ b/drivers/media/radio/radio-isa.c
@@ -267,6 +267,7 @@ static int radio_isa_common_probe(struct radio_isa_card *isa,
 
 err_hdl:
 	v4l2_ctrl_handler_free(&isa->hdl);
+	v4l2_device_unregister(v4l2_dev);
 err_dev_reg:
 	release_region(isa->io, region_size);
 	kfree(isa);
-- 
2.34.1

