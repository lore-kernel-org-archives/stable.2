Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A455245005;
	Thu, 17 Sep 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640275; cv=none; b=TnW1v97JJ7UUl+hQfe5lVWBboOPVK4Bo5gxz/MvuUSCJr6kv/q2ze3732tt11gxRbx9JMuKbbkyIiFkVWyuCwCxNfcGWAabM6c0kG9MW61x2L1jBAOuwCH0yxLdQZJDuDlb4jKJaU9+bo/i8Np+omGzm6iWw9HxOnPSxcRflw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640275; c=relaxed/simple;
	bh=vtRekRg8P98A4qQ208H3oAEDpTCMbBdy41kPqohf+8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DxojtoKSV2ETls91YY/TbsGfa3ZFLJSGSBsrMfx7RSe8Wr9Xk6MlNcthp82s2ngxBMhdkQBkYCnR3Jp8s1AICXqbI+3JCp+uta1CcAVm/c7qhIUw4HMfjySYD4iru3W5sCT4ATDPa8v8k2HD8LT8PAcK3KR3HEyBZAckf+ptY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD9OvqtqInV+CA--.454S2;
	Thu, 17 Sep 2026 18:17:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hansg@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	s.hauer@pengutronix.de,
	ulfh@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: Fix OF node leak in mmc_add_card()
Date: Thu, 17 Sep 2026 10:17:50 +0000
Message-Id: <20260917101750.2146473-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD9OvqtqInV+CA--.454S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw47WFyrKw13XF1rZry5Arb_yoWktwc_Gw
	15uF9rXw1xWFZ2kw4agF45Z393KF4v93s3KF4FvFWSgrWaqFy7X34aqr98Z347ZrW8CFy5
	GrZrZFnxXrW7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j0wZcUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qrrRk-TgAAsI

mmc_add_card() stores the OF node returned by
mmc_of_find_child_device() in card->dev.of_node before calling
device_add().  That node carries a reference which is normally
released in mmc_remove_card(), but only when the card has been
marked present.  If device_add() fails, mmc_card_set_present() is
never reached and the cleanup of the failed attach cannot release
the node, so the reference is leaked.

Release the reference on the device_add() failure path.

Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mmc/core/bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index be5cf338bdeb..4d862d9bab23 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -379,8 +379,11 @@ int mmc_add_card(struct mmc_card *card)
 	device_enable_async_suspend(&card->dev);
 
 	ret = device_add(&card->dev);
-	if (ret)
+	if (ret) {
+		of_node_put(card->dev.of_node);
+		card->dev.of_node = NULL;
 		return ret;
+	}
 
 	mmc_card_set_present(card);
 
-- 
2.34.1

