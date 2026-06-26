Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAEE37B3EB;
	Fri, 26 Jun 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487559; cv=none; b=qVpQBY9sFYf50wjwA+6qNQy2Zg/m9/c0VsiLTB5fSuPeQbB9PpEihLqtclRhKEHlqkRXsA54K80iKSObXlmFgofJiCl4urfvbsE0+W5qHXNa+fdAggtFR/XYHrjqiRATZ6TG9YKk9rjh5OTJUyXXFrOhChkr6MSLZ0tcM4qii1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487559; c=relaxed/simple;
	bh=oNmoOvbDAWPpIITyeweeRIMxe4JNxNU31IwxDUOfEjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsY3ahHBvF1zCGslSSeL/pSIkv0oRRVZ0uyJ+g8jGaDe7gQcXfJ4CGb8A2uMKpd3LC4akO7+unYkShOB+frkybC8zYNz/DDIu+ObhavNDxtHD24j2G4LKOaXphSS9SzmgE/6d7r05YSwdb6u2e+ZNkHGzhEXGuB6SBfsVbgn3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAXsMj+mT5qTxlsAw--.16794S2;
	Fri, 26 Jun 2026 23:25:51 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: netdev@vger.kernel.org
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] fix: net: renesas: rswitch_mii_register: fix double of_node_put after   of_mdiobus_register
Date: Fri, 26 Jun 2026 23:25:50 +0800
Message-Id: <20260626152550.51911-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260626152430.51835-1-vulab@iscas.ac.cn>
References: <20260626152430.51835-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXsMj+mT5qTxlsAw--.16794S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rur15AFWkJFyDXr43Wrg_yoW8Xr43p3
	y5KFW7ZrykXr42qa1kGw4UuFZYyayrKrW5uF1jka9Y9ws5tF95Jry0ga45ur45GrW8C3W3
	trn0yw18ua4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjZNVP
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQKA2o+h0E1pQAAsJ

After of_mdiobus_register succeeds, the mdio_np reference ownership is
  transferred to the mii_bus device (released via fwnode_handle_put during
  mdiobus_release). The success path calls of_node_put(mdio_np) which,
  combined with the automatic release via bus teardown, results in a double
  put and refcount underflow.

Move of_node_put so it is only called in the error path where
  of_mdiobus_register failed. On success, the bus driver manages the
  reference lifecycle.

Cc: stable@vger.kernel.org
Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for Ethernet Switch")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/renesas/rswitch_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 6fe964816322..d5f1b5fd5817 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -1387,15 +1387,13 @@ static int rswitch_mii_register(struct rswitch_device *rdev)
 	err = of_mdiobus_register(mii_bus, mdio_np);
 	if (err < 0) {
 		mdiobus_free(mii_bus);
-		goto out;
+		of_node_put(mdio_np);
+		return err;
 	}
 
 	rdev->etha->mii = mii_bus;
 
-out:
-	of_node_put(mdio_np);
-
-	return err;
+	return 0;
 }
 
 static void rswitch_mii_unregister(struct rswitch_device *rdev)
-- 
2.39.5 (Apple Git-154)

