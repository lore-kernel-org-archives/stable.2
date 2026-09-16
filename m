Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9464DD3B3;
	Wed, 16 Sep 2026 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578201; cv=none; b=rgz0aJGpXwVvg0xF3wCxoKBgU2GvN+PQUmUi6DVjq9g9UmEBo+JK/FWjIlL8OZrZxHwTJrJftHHwKBz1FKeC0gCwxeNI5RlxUQlMduf6hfdabjdHnqa9BjcdcdY7uPurnqGLRVWFnK9plf2NKKgSzczKDZVZikIhjUxI0m8q2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578201; c=relaxed/simple;
	bh=egpHKK3rUO8XGJfotucEXzJvOQqBkYRqxh/ihaUiBXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KHeD08qgTR830Z8P0dMnB21sl7W36zlOrjaogVma77tWvjrEWrSOG+bvoS1BVj2KOOLZoUlUlzTJ+pMKkapxGt4ZwXojNPABlfjPkSWusPpsq5FbJBcaN8gZdAIgcFBcLrZR1U4siYm4HYqm+Bb+xOCm/BDEZf0KMheABHQdnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXiELMy6pqKS5uCA--.22650S2;
	Thu, 17 Sep 2026 01:03:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mikew@google.com,
	wim@linux-watchdog.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] watchdog: nv_tco: Fix pci_dev reference leak in nv_tco_getdevice()
Date: Wed, 16 Sep 2026 17:02:40 +0000
Message-Id: <20260916170240.2086046-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXiELMy6pqKS5uCA--.22650S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4DGr4kGr45Aw4ruFWxWFg_yoW8CF15pr
	s0yFWYyF48Kr4vkF4UZrn7CFyFk3y2y34SkwsrK3s5ury5C347t395ua4FgF4UJrZ3K342
	qr10yFyfZw45J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	USLvNUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYMA2qqpVhYDQAAsm

nv_tco_getdevice() leaves the reference taken by for_each_pci_dev()
stored in the global tco_pci, but nothing in the driver ever drops it:
the error paths of nv_tco_getdevice() (bad BAR, request_region()
failure, SMI/NO_REBOOT failures) return with the reference held, and
nv_tco_cleanup() never puts tco_pci either.  Every failed probe and
every module load/unload cycle therefore leaks one pci_dev reference.

Release the reference on the error paths of nv_tco_getdevice() and in
nv_tco_cleanup() after the last use of tco_pci.

Fixes: 456c730153fe ("watchdog: Add TCO support for nVidia chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/watchdog/nv_tco.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index f16cee5173d5..9ce8325b4d3f 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -324,14 +324,14 @@ static unsigned char nv_tco_getdevice(void)
 	if (val == 0x0001 || val == 0x0000) {
 		/* Something is wrong here, bar isn't setup */
 		pr_err("failed to get tcobase address\n");
-		return 0;
+		goto err;
 	}
 	val &= 0xff00;
 	tcobase = val + 0x40;
 
 	if (!request_region(tcobase, 0x10, "NV TCO")) {
 		pr_err("I/O address 0x%04x already in use\n", tcobase);
-		return 0;
+		goto err;
 	}
 
 	/* Set a reasonable heartbeat before we stop the timer */
@@ -373,6 +373,9 @@ static unsigned char nv_tco_getdevice(void)
 	return 1;
 out:
 	release_region(tcobase, 0x10);
+err:
+	pci_dev_put(tco_pci);
+	tco_pci = NULL;
 	return 0;
 }
 
@@ -443,6 +446,7 @@ static void nv_tco_cleanup(void)
 	/* Deregister */
 	misc_deregister(&nv_tco_miscdev);
 	release_region(tcobase, 0x10);
+	pci_dev_put(tco_pci);
 }
 
 static void nv_tco_remove(struct platform_device *dev)
-- 
2.34.1

