Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E039D3DA;
	Tue,  8 Sep 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860200; cv=none; b=n4nZWK2Hd/wEv/PIZU8xnXNpbsLUZhQW2vaxWditJBc84tQjuiX1PKfhj0U2bfi/UWHPs43XBoXM9RGqK2YODDVDSOXskHXmAYqQAMsRemEiteqJXP4v7Hvd3jz/0kg7YyRVM2HaJT/01BsKftKOhxx+AquAHec26giu3zLv/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860200; c=relaxed/simple;
	bh=W+2anHyHRU14MUZi9nWeel6a7Klgj+ZAIu1ugPIti40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L53V2o2ZS5Fcdkv+WHCtSbHtQyvMg2VXB1WR3rVrnMvtCl3vBBNtj7f/VDt7Zl9vc4MCyZLGtTuVSGBpNVPRDjjHVmbh84v5jus+s/zGl6mjAh+wJJ0AhOpDQD8omQ62VakNRKtUiPnx83nlVrk/ONHLBIMApkU3i2BXpDOMK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=akQ3zzA6; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="akQ3zzA6"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1788860188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpq/dM2FXhmvz9NaLq2Y/fYUID515C4TuKswVMl89ZE=;
	b=akQ3zzA6kD3+HP+5X1KO9yuE5SqmCkAyFixh0Y1O+cR364HtHxkmSMFjtzrpkBBVmEH3DJ
	SZWY73qeSesmuQA56ZtslHc234GiiDLZbYtgftg9zWebNEf2qdM/hldYSPTqxK/kXPr9S1
	+a/yYGOdbjeV/fptF/YlhatHlk1r92U=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Artem Shimko <a.shimko.dev@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 5.10] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Tue,  8 Sep 2026 12:36:22 +0300
Message-ID: <20260908093626.15492-3-arefev@swemel.ru>
In-Reply-To: <20260908093626.15492-1-arefev@swemel.ru>
References: <20260908093626.15492-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stepan Ionichev <sozdayvek@gmail.com>

commit 10fc708b4de7f86002d2d735a2dbf3b5b7f65692 upstream.

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier. If
clk_notifier_register() fails, probe returns the error but leaves the
8250 port registered. The matching serial8250_unregister_port() lives
in dw8250_remove(), which is not called when probe fails, so the port
slot stays occupied until the device is rebound or the system is
rebooted. The devm-allocated driver data is freed while the port still
references it (via the saved private_data and serial_in/serial_out
callbacks), so any access to that port slot before a rebind is a
use-after-free hazard.

Unregister the port on the clk_notifier_register() error path.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260514143746.23671-2-sozdayvek@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Denis Arefev: adapted for 5.10:
- system_dfl_wq is not available here, use system_unbound_wq instead]
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Backport fix for CVE-2026-53384
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-53384
---

 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 629eb24166b5..0afcfe4ff56a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -610,8 +610,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_unbound_wq, &data->clk_work);
 	}
 
-- 
2.43.0

