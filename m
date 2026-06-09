Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00E23F40D;
	Tue,  9 Jun 2026 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965991; cv=none; b=RWbxv8e0cGwKrqLv47z8YLT3SijR2AHkdraU6qy7c8uvrKscyciMyIfM2QtZVE6yP+1QceUg2zDKyObLrc2BXIxPQfPQIYlPTILReKPLyl6WgV3VmswgocH+OgVsL1muW+JRj7FdPA48e8+ABwgt3hU4SCzMck9mNt3NUBX9Cg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965991; c=relaxed/simple;
	bh=MEPOiFeJIPRR7zMMt87L2VjDx8EzEnrkRRET0EX6XlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmjGmmjccw23JxYpvaD7v0/a/hpznrh1AvNqLqobJFuUyQaRbg0RAeVsgmCCMjzLmiBLuh/BW17C0xDuXcO5Kno+NKvaIVX1xVkUUQ6MYjMux1L7SRciyujvHE0Pko632UbdcfQTzshKI1OHd1bvApHtp6OMWnnkMsl6uaC9E+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADXYQVgYidqw6LDEg--.8726S2;
	Tue, 09 Jun 2026 08:46:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dmitry.torokhov@gmail.com
Cc: sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Input: cyapa: fix runtime PM refcount leak in cyapa_update_rt_suspend_scanrate()
Date: Tue,  9 Jun 2026 00:46:17 +0000
Message-Id: <20260609004617.175476-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXYQVgYidqw6LDEg--.8726S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKrW5uw48JF13Kr1UJFWUArb_yoW8JF4rpr
	WjgFWqkryxXw4Ut34qyr1DZFyru3sxK398GrWkX3W8Zw4rGa4rtr15JF9a9F10kr98urZ8
	Xw1vkayavF4YkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS
	14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5u
	c_DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoNA2om2m7-UAAAsU

pm_runtime_get_sync() at line 901 increments the runtime PM usage
count. If mutex_lock_interruptible() fails at line 903, the function
returns the error immediately at line 905 without calling
pm_runtime_put_sync_autosuspend(), leaking the PM reference and
preventing the device from ever entering runtime suspend.

Add pm_runtime_put_sync_autosuspend(dev) on the error path before
returning.

Cc: stable@vger.kernel.org
Fixes: 672865080a8f ("Input: cyapa - add runtime power management support")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/input/mouse/cyapa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 6e0d956617a1..5edf4fdbb373 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -901,8 +901,10 @@ static ssize_t cyapa_update_rt_suspend_scanrate(struct device *dev,
 	pm_runtime_get_sync(dev);
 
 	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
-	if (error)
+	if (error) {
+		pm_runtime_put_sync_autosuspend(dev);
 		return error;
+	}
 
 	cyapa->runtime_suspend_sleep_time = min_t(u16, time, 1000);
 	cyapa->runtime_suspend_power_mode =
-- 
2.34.1

