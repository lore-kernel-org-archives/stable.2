Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDB134CF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514947; cv=none; b=o/6/WoSqhA9rOhPV01Thf1D+FKYiih7t+9UCWHyHoKF/mgXTkAUvCMdW6JSUwhtM/OirolVRSmmIAzUIiRAj8DihGI0u0M7O23/qJipQyZCDT3Gg58ATAhT8qD0IMYjeV1XMY7N9ahsRZezGXotWX7Q8HR/DgEIzn60Pjj/XFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514947; c=relaxed/simple;
	bh=wuGRmU2hTrO8TR7cjwX08dS7CHmP+HJk8TT1d0j9suc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIDOrie7RqfoWIDD3HnBDLsiJBGWzwzm4if0++752w4NkWwZzt78z/DEtrPOnfBGekPXV2Yt18+zaCSo0gQCfdGxogDEHVaMF6oZ2PVqTNeywt/I38FR1fpoOVa5kn5im+nqYHEI8BcVAAoRDK7tSlfEA7dOZ6hG3lExM4Bo3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzTLD2qn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzTLD2qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DF11F00A3A;
	Mon, 20 Jul 2026 02:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514945;
	bh=L4H5x18UogLTp3lORPjPMYzfd5lMCJZ9B+9qjJC1wdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzTLD2qnEdF6aXjkCzqI3KRszQxq6qe9pN/M1TplRi4j3j/A6FvfXvgbfCdEvz452
	 KHu+cOwoXCzvgace8Kda9N6sDW4V92vD+ejog2Z+4F+Ktl/inAtCpxsBpTLDYhVWSl
	 EmWbkERpypE3V3nSWTTKaRxzHa9CYEIMr6OPEBulhPRdatznFMRxg6QMwhfhITCofR
	 Irb3kmipRqrFfxkFpHbUrbnVQxWNU+Mt5AqpBZj2pJ3ghh+6PFGcGpkzt0mg+JUW0O
	 HsrcZOsD8VWHGvrvuO0QCzupd9RSI5q+i6v+BRQPMr/ctjvHuCEVZk/uXvP+3460/c
	 Nq3GYkvaTKylA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove
Date: Sun, 19 Jul 2026 22:35:39 -0400
Message-ID: <20260720023539.2968115-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720023539.2968115-1-sashal@kernel.org>
References: <2026071423-employed-mankind-78ba@gregkh>
 <20260720023539.2968115-1-sashal@kernel.org>
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

