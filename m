Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743299;
	b=C7iGMz8iLWspGU9/AeMiAmFEqtuDdaQIHIMn0iR7s+34sZ/KyHCt9Qvrs2NnZFN/r3AB
	 6cxNByf3Yby++la697f2vQK0i7S/eayk4il9tKzhB4h0hFlnUQBM/SYBf1OOXRsnqqnnz
	 bfOl/9hV1oBtg7tbRX/4pRu8Ew4SpWDTa6ZahhlIekK0uSHf4i8wEET9EoL5yS6Tt2fEp
	 I4d1XeHS/5oR5FF125PqWVnubqVTjrDILYHlvPX2LdkuvgcRxCZxbV2ad2HthtcHHxgLm
	 rO4WEiYp4dSTmuo8sKRBxP8wkjT9RXoEna8h6ZkwKw/kxwgQxvm0zl39AxLHcL8zwYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743299;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=T/tfABklWN2msD5UL/BpDjitz3m2XZP3X7bUqHvYmY4=;
	b=js0N2H3esFcO2wIquW6/AtqeVWfSflVkjYFZvqrl4J3gvBwTYVkarw7I62awtr5B1UfD
	 YLLKZpiPP+dHUpxXQeQnofKyoaZRwTEZvcq1znUz8xY6fwrBxAZNSVofeNI+U0tWNng/r
	 eTE94RiLSJVRx0LRIzFF5ZdBL+kr0Oc/rO7zqYl89IoEpH194bs0tZyp3jvO1cUMIoEf/
	 8LitnYwl7C+ErOg1076c5DdM07o/YCuJvFywH4Rwy1H+3Yv3hNnCq9aDD7jBWhKWehULp
	 oDwWxzmvcQiJUtYJOZ5kPfQaA77hYRUK3sydvAVr5zvcPyImoASiF8zj0PzyK9DLhkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=FaOR5SMo;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A160A2608;
	Sun, 15 Nov 2026 11:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 600A160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=FaOR5SMo
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04f5;
	Sun, 15 Nov 2026 19:48:14 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 [PATCH v2] Input: lm8323 - drain PWM work and finish with outputs disabled
Date: Sun, 15 Nov 2026 19:48:12 +0800
Message-ID: <179474329214.103840.17616107855531843241@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df095af703a1kunmbac61c98bf7bf
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEpIVkkYT0gaHxlKShlOS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=FaOR5SMoLJzF0w3+Eln03ym+K+iXAuS9othQYqpuuenhi8Yf008/hioHXeHTKBWnkSXDE6Ss04adVg8h0Ly9w61MDpilDH62v/KQcYyryczbvO/g071G8wwTfv7WE3GHlvTP8Yz501iyrqzoQM9NoxmiohDpuTeSCCaZ/Gl+dCk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=T/tfABklWN2msD5UL/BpDjitz3m2XZP3X7bUqHvYmY4=;
	h=date:mime-version:subject:message-id:from;

A PWM brightness callback can leave private work pending when the
managed LED and chip state are released. Merely cancelling that
work also discards the final LED_OFF requested by LED unregister.
Flushing alone is insufficient if an earlier fade is still
running: the worker waits for an IRQ to requeue it, and the
managed IRQ is released before the LEDs during teardown.

Install cleanup before registering each LED. Once LED unregister
and IRQ teardown have stopped the producers, cancel its work and
use the documented single-END shutdown sequence: put END with
RESET set in unused script slot 59, stop the channel and restart
at that slot. Do not overwrite a running brightness script. The
engine then disables its output autonomously without another IRQ
or a worker accessing freed driver data. A current long RAMP can
delay completion, as documented by the device specification.

Found by the author's in-house static analysis tool.

Fixes: a48b2d4a0091 ("Input: introduce lm8323 keypad driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260728065518.489-1-getshell@seu.edu.cn/
Link: https://www.ti.com/lit/ds/symlink/lm8323.pdf
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/input/keyboard/lm8323.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 4b87d39..e13bcde 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -548,6 +548,21 @@ static struct attribute *lm8323_pwm_attrs[] = {
 };
 ATTRIBUTE_GROUPS(lm8323_pwm);
 
+#define LM8323_PWM_SHUTDOWN_ADDR	59
+
+static void lm8323_pwm_shutdown(void *data)
+{
+	struct lm8323_pwm *pwm = data;
+
+	cancel_work_sync(&pwm->work);
+
+	/* The normal brightness scripts use only slots 0 through 3. */
+	lm8323_write_pwm_one(pwm, LM8323_PWM_SHUTDOWN_ADDR, PWM_END(1));
+	lm8323_write(pwm->chip, 2, LM8323_CMD_STOP_PWM, pwm->id);
+	lm8323_write(pwm->chip, 2, LM8323_CMD_START_PWM,
+		     (LM8323_PWM_SHUTDOWN_ADDR << 2) | pwm->id);
+}
+
 static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 		    const char *name)
 {
@@ -569,6 +584,10 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 	pwm->chip = lm;
 
 	if (name) {
+		err = devm_add_action_or_reset(dev, lm8323_pwm_shutdown, pwm);
+		if (err)
+			return err;
+
 		pwm->cdev.name = name;
 		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
 		pwm->cdev.groups = lm8323_pwm_groups;
-- 
2.50.1.windows.1
