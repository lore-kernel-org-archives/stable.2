Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7FD17BCA
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217506; cv=none; b=thwieYvOPXreKZ6BPM20zHROJy486jYW2A7jwPR3XOFu5fmy0RP+X6uffjprvr6XltEu2IVouLl/hqjDbzM0CvQKVPXveii4BXq6W5s/5MmhqyKxCNd8gKHhK3TwONEB+ONAz6BHAo0L1DJD6JhCiKQKjxXt5DP2Ju/v8xho3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217506; c=relaxed/simple;
	bh=G1Gh/J9szhIw28N7s/kWHb1YC2dKxHsnoLcQZ7POOR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzAK3Ug9j4na9PMaDoaZOX+HqrsEH9C7RWtaCCYpQX0LqKZyI9cm5jemWuB9aXA+0+a4Z3J3Y/Ut4Pvsvt3RkibLpPJTd4zO+FZfw176AKyoJBpNK/wF1KGBofco1QXTSZ5cCt5wF8c8ImI6JnYtmz0tcG+y3wHFviZASsX/HZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FksRGx7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FksRGx7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1861F000FF;
	Mon,  5 Oct 2026 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217504;
	bh=eVrcmIRnQsA21kDHqEWqQ1g6c2R/nTh3IMD2CU2bLIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FksRGx7RuXJPKOTaV+ap/nuLTpuhkENQyTrbuL0BFJ156TG2wEy5DBOaU9nWa/mVx
	 kjwG9q+bAKnOk5i1gj2c/qdi6EKZo5Zw+LkL6SQv2xW4tH4sINzqlJDLLbPp4XBgtd
	 4RGy4TGCD9Kc9eL3ovHAOu/j1ItdIUW5dCTB+SnCjPHlNpML6Tj0O63v0hqC3vRysP
	 YX7kYhni8dHWlEBJ64zBnqCO/0BQ2bnH0ZYgGHfxHwYgbxQnh7qOba/jCgEY5AvJYh
	 MU2k8YVhMk5Tw46rt/mcxmZnK87yBtuU7IkeIOzzYA/mfGSYLgspeBzYTIwVClF2UI
	 vZsUs922JTERw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Sicong Huang <congei42@163.com>,
	Song Li <songl@zju.edu.cn>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: cdns3: fix use-after-free in cdns3_gadget_exit()
Date: Mon,  5 Oct 2026 12:24:59 -0400
Message-ID: <20261005162436.3062564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100534-purging-uniquely-0db7@gregkh>
References: <2026100534-purging-uniquely-0db7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit ebe9b68c396792c15d0ac690d592e449e74ed804 ]

cdns3_gadget_start() arms two works on system_freezable_wq:
pending_status_wq for the deferred ep0 status stage and aligned_buf_wq
for realigned request buffers. Both handlers use the cdns3_device the
works are embedded in, and cdns3_pending_setup_status_handler() also
calls the ep0 request completion.

cdns3_gadget_exit() does not wait for these works. It frees all
endpoints and aligned buffers and drops the last reference to the
gadget device, which frees priv_dev, so a work queued before the exit
can run after the free.

Fix this by waiting for both works after the gadget driver is unbound
and the IRQ is freed, when no new work can be queued, and before the
endpoints and buffers are released.

This issue was found by an in-house static analysis tool.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Reported-by: Sicong Huang <congei42@163.com>
Closes: https://lore.kernel.org/linux-usb/7f5719b.8700.18f67b324d3.Coremail.congei42@163.com/
Suggested-by: Sicong Huang <congei42@163.com>
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260909095655.694527-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index a64302acdfe6d..d0378ecd0c981 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -3254,6 +3254,10 @@ void cdns3_gadget_exit(struct cdns3 *cdns)
 	usb_del_gadget(&priv_dev->gadget);
 	devm_free_irq(cdns->dev, cdns->dev_irq, priv_dev);
 
+	/* The works can still be queued until the IRQ is freed. */
+	cancel_work_sync(&priv_dev->pending_status_wq);
+	cancel_work_sync(&priv_dev->aligned_buf_wq);
+
 	cdns3_free_all_eps(priv_dev);
 
 	while (!list_empty(&priv_dev->aligned_buf_list)) {
-- 
2.53.0

