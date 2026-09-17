Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18101559C84;
	Thu, 17 Sep 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653312; cv=none; b=Y/r7KWBNRqMTO40qhl95vMGvEwtSC/TgHIHDFR6TKllp2w04eGoZT6B06Z86SSDRLxYyn3e9Ixp8YKg3UdA5C9/QCIuuXhxExUCoXtF7QZ9TlnXw/Fwm90EEtrzR9w5OZ0GoBKPj1vGrzEB+zxe/80cbtsmQDkf/5I+sc+qkqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653312; c=relaxed/simple;
	bh=tAd5jRQW1MuK32N+LAIe11aQsRo22duPh8kQNsJ7+tU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IqBQ08RCW9otFaBLyIGqSW8yJrM/C+PnwtBIvCwMh5m2D/4ERBd7VvitmlejeIJt7OtEdrvJKDQEUrw8FLcWNfYwo+Zf94MSNu9Az53D/JGjkpX4vaE39rKSq1gmixL5nDDGeyUd2Ip4Lx+UjiKB3f54HoV+NT4E6UqHvvSRO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHtD4r8atqj+GBCA--.4034S2;
	Thu, 17 Sep 2026 21:54:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bcm-kernel-feedback-list@broadcom.com
Cc: florian.fainelli@broadcom.com,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	uajain@igalia.com,
	wahrenst@gmx.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/raspberrypi: Fix service use-after-free in vchiq_blocking_bulk_transfer()
Date: Thu, 17 Sep 2026 13:54:51 +0000
Message-Id: <20260917135451.2154073-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHtD4r8atqj+GBCA--.4034S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rKrWkZFWUKw1xurWUCFg_yoW8ZrWxpr
	WUurW0yr4rtF1ay3yUXa15CryF9393t3yfur97AwnrZrsxZF9IvwnFkFyYqF4DArn3Wa9x
	trWavw15u3yUAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	AIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07bbXocUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qrrRnLTwAAs7

find_service_by_handle() returns the service with a reference taken,
but vchiq_blocking_bulk_transfer() drops it immediately and then keeps
dereferencing service->state to reach the bulk_waiter spinlock on the
"not a retry" and "cancel the signal" paths.  Once a concurrent
vchiq_free_service_internal() releases the last reference the service
is freed, so those accesses use freed memory.

Hold the reference until the end of the function instead, as
vchiq_service_callback() already does.

Fixes: 12cc5f92c159 ("staging: vc04_services: Move spinlocks to vchiq_state")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c b/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
index e78641703252..10f33a04e22a 100644
--- a/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
+++ b/drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c
@@ -588,8 +588,6 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	if (!service)
 		return -EINVAL;
 
-	vchiq_service_put(service);
-
 	mutex_lock(&instance->bulk_waiter_list_mutex);
 	list_for_each_entry(iter, &instance->bulk_waiter_list, list) {
 		if (iter->pid == current->pid) {
@@ -619,8 +617,10 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		}
 	} else {
 		waiter = kzalloc_obj(*waiter);
-		if (!waiter)
+		if (!waiter) {
+			vchiq_service_put(service);
 			return -ENOMEM;
+		}
 	}
 
 	bulk_params->waiter = &waiter->bulk_waiter;
@@ -645,6 +645,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 			waiter, current->pid);
 	}
 
+	vchiq_service_put(service);
+
 	return ret;
 }
 
-- 
2.34.1

