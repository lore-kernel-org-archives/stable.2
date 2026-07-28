Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDD2DCF57;
	Tue, 28 Jul 2026 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208106; cv=none; b=XHFKq7giAaskn0NLu6eEHT+ehScAA3JoEA6JeDZokv8Q5/aoO3oISOEZ47wPoZWvE3BnjTqTAxqJgfT4w/wyQZyk6xxlMa5A/sDUG+buLav6x6MF1Qn3CBBjpaxlfvDnp0qbU51Up5vYIn3q6745IQX1pe3QJDsPRlf4DF3EuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208106; c=relaxed/simple;
	bh=aHCzfYpYUEmHit4qAlCqfvyFpxy6UxEiGDc6f2IaHbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J+cVa2vzRWfB8g+QN2xUmaP/8XZ1MBZR68A7bW5zKvnhqv1yO7Ex97tC0s90rsdTwYvisvv9bPdN5oOZuFnicLLNCXxURZ2qRDflv61DO6X0KL6lSABjDhVE357HD5xT2vxDQTHqVup+Ip64pVou0AiyKaIzcTFCpQd7xn0C/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDX3y8cHWhqT2JGAA--.2335S3;
	Tue, 28 Jul 2026 11:08:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgAnl8wcHWhqDy5HAw--.57582S2;
	Tue, 28 Jul 2026 11:08:12 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	david@ixit.cz,
	mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net v2] nfc: trf7970a: drain timeout_work and keep trf->lock valid across teardown
Date: Tue, 28 Jul 2026 03:07:16 +0000
Message-Id: <20260728030716.230626-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAnl8wcHWhqDy5HAw--.57582S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?ZYHA/QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0ehKhht0Ab00um4zGWfdpP9ED8i3dNWVazX1emWYn8OxNI
	7Bz3XDcm+0nSxBmFi8Op9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1UuFykuFy5Wr1rWF4Utrc_yoWrJFW7pr
	sxWFyq9rW8CrWjyFsrZF4IqFWrAa18J3y8C34qga4fJan8JFyxJry8Ja4Y9Fy8CrWkZ3ZF
	vrW5ZayfuF4FyFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU7rcfUUUUU

The driver never drains trf->timeout_work with a blocking primitive:
every cancel_delayed_work() in the driver is the non-blocking variant,
kept that way on purpose so the timeout handler can consume its return
value for the ignore_timeout protocol. A timeout handler that is already
running and blocked on trf->lock during trf7970a_remove() therefore
survives past the teardown, then acquires the lock and dereferences trf
-- a use-after-free.

trf7970a_remove() also calls mutex_destroy(&trf->lock) before the devm
chain frees trf, while the threaded IRQ handler trf7970a_irq() takes the
same lock at entry and is only synchronised by the devm_free_irq() that
runs after .remove() returns; it can thus observe the destroyed lock.

Fix both by draining timeout_work with cancel_delayed_work_sync() and by
dropping the premature mutex_destroy():

In trf7970a_remove(), cancel timeout_work between
nfc_digital_unregister_device() and nfc_digital_free_device().
nfc_digital_unregister_device() flushes the digital core's cmd_work,
which invokes the driver's in_send_cmd/tg_send_cmd/tg_listen entry points
and arms timeout_work; cancelling timeout_work before unregistering could
let a final in-flight command re-arm it after the drain. The handler also
dereferences trf->ddev, so the drain must precede freeing the digital
device. On the probe-error path the device was never registered, so the
cancel runs directly before nfc_digital_free_device().

Drop mutex_destroy(&trf->lock) from trf7970a_remove() and from the
err_destroy_lock probe-error label. trf is devm_kzalloc()'d and
devm_request_threaded_irq() is registered after it, so devm reverse-order
cleanup runs devm_free_irq() (synchronising the threaded IRQ handler)
before freeing trf. The mutex is embedded in trf, so leaving it valid
until then lets the IRQ handler be drained before the lock goes away.

This issue was found by an in-house static analysis tool.

Fixes: 165063f1dac4 ("NFC: trf7970a: Add driver with ISO/IEC 14443 Type 2 Tag Support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes in v2:
  - Move the cancel_delayed_work_sync(&trf->timeout_work) in
    trf7970a_remove() to after nfc_digital_unregister_device() and
    before nfc_digital_free_device(), so the drain runs after the
    digital core flushes its cmd_work instead of racing it. The
    probe-error-path cancel and the mutex_destroy() removals are
    unchanged.

 drivers/nfc/trf7970a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index f22e091..9dc6931 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2207,13 +2207,13 @@ static int trf7970a_probe(struct spi_device *spi)
 err_shutdown:
 	trf7970a_shutdown(trf);
 err_free_ddev:
+	cancel_delayed_work_sync(&trf->timeout_work);
 	nfc_digital_free_device(trf->ddev);
 err_disable_vddio_regulator:
 	regulator_disable(trf->vddio_regulator);
 err_disable_vin_regulator:
 	regulator_disable(trf->vin_regulator);
 err_destroy_lock:
-	mutex_destroy(&trf->lock);
 	return ret;
 }
 
@@ -2228,12 +2228,11 @@ static void trf7970a_remove(struct spi_device *spi)
 	mutex_unlock(&trf->lock);
 
 	nfc_digital_unregister_device(trf->ddev);
+	cancel_delayed_work_sync(&trf->timeout_work);
 	nfc_digital_free_device(trf->ddev);
 
 	regulator_disable(trf->vddio_regulator);
 	regulator_disable(trf->vin_regulator);
-
-	mutex_destroy(&trf->lock);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1

