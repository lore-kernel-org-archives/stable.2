Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B335972;
	Sat, 18 Jul 2026 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784340773; cv=none; b=I+rcc0ivLwqsRSc3lSc49sCCryGQH2kxg85wP4eBYNSdLi2BpohC3RKrNIRuZGM/kMgpge1wk3ptsTynBop+yzXjuUhPy7IGTJ1bDbmMiQpe8r0P9HyKVsAsd+Dbf4bVE+BNQ99uxOPqI1H/CKEUxAdSZGcc2MxVDKkmvLtNmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784340773; c=relaxed/simple;
	bh=FQAxCInk2AF8mBO39ha0IVg7+b8kN4qIDSfhr6AwqeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=epEdM124mPBV3h2ACsvGpRDZcKc6vHEFxyftBW+ER+Q38xm/WGVzvJW/vzHSQAPm9SAa8BY4GeNxsjV6eNTL2CeLxML16W9mJqvi49bNspmgeAknMASNkHlmA7cC+UbBXryXbTYBm7dG1u+z4Kb+oEDIaskwt5hGfNXgAFQKvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDn738V4Vpqo_8KAA--.4374S3;
	Sat, 18 Jul 2026 10:12:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgC36jEV4VpqssxhAg--.22301S2;
	Sat, 18 Jul 2026 10:12:37 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] usb: typec: ucsi: acpi: Fix use-after-free of ucsi on remove
Date: Sat, 18 Jul 2026 02:11:42 +0000
Message-Id: <20260718021142.3146566-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgC36jEV4VpqssxhAg--.22301S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?IIomyAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZz7YkbJ3AoyGBdg4rUAvmX1NnfkbRhgWhLC2J6tQB0GXIUi
	MA23mPTTVIkZA5npcoqp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxCw4xurykAF48ZFyxuF45Jwc_yoW5XrWxpr
	WIk3y0kw40gF1Yga1kXwn5XFy8uF4kZry7GF1Ig3yxGws8uw1UXF93t3W5CFy5Jr98Wanr
	Ar48Ja45Zay5AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnKsUUUUUU=

The ACPI notify handler ucsi_acpi_notify() calls
ua->ucsi->ops->read_cci() and ucsi_notify_common(), both of which
dereference ua->ucsi with no NULL guard.  In ucsi_acpi_remove(),
ucsi_destroy() frees ua->ucsi (kfree) before
acpi_remove_notify_handler() is called, so a notify dispatch already
in flight on another CPU may access the freed object after
ucsi_destroy().

  CPU 0 (remove)                    | CPU 1 (ACPI notify wq)
    ucsi_destroy(ua->ucsi)          |   ucsi_acpi_notify(ua)
      kfree(ucsi) // FREE           |     ua->ucsi->ops->read_cci(...) // USE

Move acpi_remove_notify_handler() before ucsi_destroy() in the remove
path.  It is kept after ucsi_unregister(): ucsi_unregister() cancels
connector work whose handler issues GET_CONNECTOR_STATUS through
ucsi_send_command_common(), which waits for a completion that is
signalled from the notify path, so the handler must stay registered
until that work has been cancelled.

acpi_remove_notify_handler() drains in-flight notify dispatches before
returning: it calls acpi_os_wait_events_complete(), which flushes
kacpi_notify_wq. Because ACPI device-notify dispatch is deferred to that
same workqueue (acpi_os_execute(OSL_NOTIFY_HANDLER, ...)), the flush
guarantees any queued or running ucsi_acpi_notify() has returned before
the function returns, so ucsi_destroy() frees an object no handler can
reach. This mirrors commit 1f0bdc2884b6 ("usb: typec: ucsi: ccg: Fix
use-after-free of ucsi on remove"), which moved free_irq() before
ucsi_destroy() with the same ordering rationale.

The probe error paths already order acpi_remove_notify_handler() (or
omit it, when install failed) before ucsi_destroy(), and are unchanged.

This issue was found by an in-house static analysis tool.

Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 60b12961e..1d56eadc9 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -257,10 +257,10 @@ static void ucsi_acpi_remove(struct platform_device *pdev)
 	struct ucsi_acpi *ua = platform_get_drvdata(pdev);
 
 	ucsi_unregister(ua->ucsi);
-	ucsi_destroy(ua->ucsi);
 
 	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
 				   ucsi_acpi_notify);
+	ucsi_destroy(ua->ucsi);
 }
 
 static int ucsi_acpi_resume(struct device *dev)
-- 
2.34.1

