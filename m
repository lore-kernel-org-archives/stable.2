Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319923195FC;
	Tue, 16 Jun 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616100; cv=none; b=G2h3nlzlQ5EpPAkT8Ad4LA2mb9RYDo8qmjgqfgeAtEWCaI+x3X2WZfryfCl6hfmg3HmUas5R9rg1AvEL+Mm2MSAoIZ7aEXUrOizlSO5OZOn8fBIPV7dvN5vkpPUOZGauSJa59BkB9VWXE/sBxUHOrj5FC+uOomgSf4VBDhAZKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616100; c=relaxed/simple;
	bh=xYo44AF5Yfod+StgKVtatg/QGVfjn4U6Fl5uwbcFhDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AuXzZTFqqlJG9f86Vr87MkJLqnzsLQaoRP7ZS6zHXnU3SiXnoAhVXPDZveUNTe8PJNkgBqR5o5i2ZX4/A3iZoVYeGiAG5eWZP5iwsvMc3WjZWanQwPBgKWbMs7Eo+oe7XK0NUO9QgL2aU0negSAAo9prw8Mu/Vz+qw2N9sJNQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wB3nKbVTTFqEG2wAg--.61962S3;
	Tue, 16 Jun 2026 21:21:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgDH+TDUTTFqiguXAQ--.44550S2;
	Tue, 16 Jun 2026 21:21:24 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove
Date: Tue, 16 Jun 2026 13:20:11 +0000
Message-Id: <20260616132011.103279-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgDH+TDUTTFqiguXAQ--.44550S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?ND0nYAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwohKw2SZcbPewIttoX0xtNb7pduqu6xNQ7nX8+qX39pR2n
	mPgDSnrqtblu1gT9C2HN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxJr43JrWrGFy5KFyrtr4DJrc_yoW8Cr18pr
	y2y3y2krW8XF1aga1DZ3Z8XFy8uF4DAry2k3y2gwnxGan8Aw1j9a40ka4YgFy5Xr9rGF1q
	yr43J3y5AFW5CwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The threaded IRQ handler ccg_irq_handler() calls ucsi_notify_common(),
which on a connector-change event calls ucsi_connector_change() and
schedules connector work.  In ucsi_ccg_remove(), ucsi_destroy() frees
uc->ucsi (kfree) before free_irq() is called, so a handler invocation
already in flight may access the freed object after ucsi_destroy().

  CPU 0 (remove)            | CPU 1 (threaded IRQ)
    ucsi_destroy(uc->ucsi)  |   ccg_irq_handler()
      kfree(ucsi) // FREE   |     ucsi_notify_common(uc->ucsi) // USE

Move free_irq() before ucsi_destroy() in the remove path.  It is kept
after ucsi_unregister(): ucsi_unregister() cancels connector work whose
handler issues GET_CONNECTOR_STATUS through ucsi_send_command_common(),
which waits for a completion that is signalled from the IRQ handler, so
the IRQ must stay active until that work has been cancelled.

The probe error path already orders free_irq() before ucsi_destroy().

This bug was found by static analysis.

Fixes: e32fd989ac1c ("usb: typec: ucsi: ccg: Move to the new API")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index d83a0051c737..c089000bd448 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1513,8 +1513,8 @@ static void ucsi_ccg_remove(struct i2c_client *client)
 	cancel_work_sync(&uc->work);
 	pm_runtime_disable(uc->dev);
 	ucsi_unregister(uc->ucsi);
-	ucsi_destroy(uc->ucsi);
 	free_irq(uc->irq, uc);
+	ucsi_destroy(uc->ucsi);
 }

 static const struct of_device_id ucsi_ccg_of_match_table[] = {
--
2.45.2

