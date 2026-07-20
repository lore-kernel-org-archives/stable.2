Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9825B0B5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514345; cv=none; b=lsNoC6eGu1aYwbY9RIrqTkMBokxt20yUgOipYRE6VrIXz43iCBJ/gJEhbaNNgCWhYUCxYoCtemJmPEwulra5sgWxIfQBiE0ywCkRVUybSwrurE7wO2AULt5SgIkrFIHZfL3NRfUTK1PUGPFU6XPCxWL2D2XawlIY6Fq2/8nQT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514345; c=relaxed/simple;
	bh=wuGRmU2hTrO8TR7cjwX08dS7CHmP+HJk8TT1d0j9suc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4BMIXVe2nbzDvCwqmWrCrJbm2Zg8Hc9zFvWqqdmyzncKTM0WdU84UZJt3jy/To/a30bRcSY0zYtlINH/wjI4P7d0ExvDC3iW9euOVnTkbtVxeY+St3zj4o7HaL66rNRGkZfpLNOnqLmlqyVZcCG6E3i4zwslX8K5QYuHw8UwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntC5N0TH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntC5N0TH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F2B1F00A3F;
	Mon, 20 Jul 2026 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514343;
	bh=L4H5x18UogLTp3lORPjPMYzfd5lMCJZ9B+9qjJC1wdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ntC5N0TH+mUUmEQVsSuvd+N5jHilw6kAZEGiaytFu3BMADl7KjRArCu57i8HlwA4Z
	 Vm2EX9w1uxmymBu7u8Mj/S4AHoyGb6d7RsGNVtFlaX+AwhvcZEu1luHUxHwpVNoB3N
	 RSkssONKBapVnHiWwTAhkWpuPAEFdCQ4FBzk5StsePo84R/4HRO0rPvz/EBVqi6xR7
	 2d6fTO7DeGbcf+zVWMrX7XaleRTq5XM/Rh0titlT6KBpdV5Io3xFqAfwI6TFYTRrYn
	 QhHZWVwFo7x8qvx5YZoZpQtoblLIcIVFGyTILopBpU8WVFjPqYWMqvF+yvI4bMNLOc
	 QeP/h7D60UFig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove
Date: Sun, 19 Jul 2026 22:25:37 -0400
Message-ID: <20260720022537.2927284-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720022537.2927284-1-sashal@kernel.org>
References: <2026071422-comment-stardust-654c@gregkh>
 <20260720022537.2927284-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 1f0bdc2884b67de337215079bba166df0cdf4ac5 ]

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
Cc: stable <stable@kernel.org>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260616132011.103279-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 68a693d92dd05a..8d69bc5bff20a9 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1418,8 +1418,8 @@ static int ucsi_ccg_remove(struct i2c_client *client)
 	cancel_work_sync(&uc->work);
 	pm_runtime_disable(uc->dev);
 	ucsi_unregister(uc->ucsi);
-	ucsi_destroy(uc->ucsi);
 	free_irq(uc->irq, uc);
+	ucsi_destroy(uc->ucsi);
 
 	return 0;
 }
-- 
2.53.0

