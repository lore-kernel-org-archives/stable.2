Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1839B4AE;
	Tue,  1 Sep 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272852; cv=none; b=r5c9MybvRl6LOyo+PT7dyq4kfZmeGUz9wW3cWBJQFo+KZIhSOWOERjUU5HxX5L6p43o9MB4tlW82phIptnyE+5lQlIO0lV2khBF7H/O+LZNxmAzcYkVClx/ZZLgCFoUxqF+qzQFCfUvf1xpJdMv0Qaj32AcKHt2OFpSHeLNydsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272852; c=relaxed/simple;
	bh=ayXG/jvgjksUsoG5Zuky6iIAa4acDBqzBWCCEmft+nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YGU+6+7ZlVZvJy5gJgrGgTHBBFSABKxs+6Pdt91seRUAMoEIAYxjS3gQC/y8NCztSIj+BBrl27bN+WMpVqQZaktmAv5aH8hQFMdzDInqQOiA/xwh2Ona1oM8TW+YG9oMyJH0eHZtHsVBeH4tABLoy1yqnd0gC8thLq/pZleaYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTHsXZ18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTHsXZ18"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5172C2BCF4;
	Tue,  1 Sep 2026 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788272851;
	bh=ayXG/jvgjksUsoG5Zuky6iIAa4acDBqzBWCCEmft+nU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qTHsXZ18zeT8pkOYni7a8myFwZ9SCUcUccGE+cOBYEiy7Se/I9L+orcucaYVV91gk
	 CCssl9BgWOt40RNiQ1kiQd+gC1QJdB6XA4HfxMiLLP3Unmdc8pxOHNgPrstW3Mlrxf
	 VwoAdaFGPqHSt5ry+zfxG9D0F17+igruFP9MAhKbfnJFhGoa/kp6i+7FSRKresP6fA
	 ANnPbCea4i2OhDphD2PYtFIRY4ydA9nj2ltMK06M+DP2sljyTqooaq9mURUSydDyR8
	 bIXEgFfj70xq6QXfkW9n1zj4oXyGMCEKbUX2DeRPuOEvIKmXCdu/dfmYgGTeZGfwQd
	 5EdxYI9G1sFmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23ADC624D3;
	Tue,  1 Sep 2026 14:27:31 +0000 (UTC)
From: Ji-Ze Hong via B4 Relay <devnull+peter_hong.fintek.com.tw@kernel.org>
Date: Tue, 01 Sep 2026 22:27:19 +0800
Subject: [PATCH] can: usb: f81604: fix use-after-free on disconnect
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw>
X-B4-Tracking: v=1; b=H4sIAMbglmoC/yWMQQ5AMBBFryKz1mQqNLiKWFRNGQukRSTi7gbL9
 3/euyBSYIpQJxcEOjjyMgvoNAE32nkgxb0wZJgZrFArX2qDufJ8qipHJKvlKgyIsAaS+Ys17c9
 x7yZy21uA+34AizRzPW4AAAA=
X-Change-ID: 20260901-f81604-fix-9400ea120256
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788272851; l=1272;
 i=peter_hong@fintek.com.tw; s=20260824; h=from:subject:message-id;
 bh=OrmVvmr1snDnaMTisWi/0+p/lhxiIIgiSJYL9JzLpr4=;
 b=XxfwAoT2qzgD1EcOdZuJy4uyNCRmVLd5sYBtJb2g9t8gVAedH+Hu4tvDhomxjSWAzawGHXY/B
 8cOYq9PH3ScD3YgIOhmirZwZUdGJfj/BzwZtrsOYfZNM1CpM6UUl57b
X-Developer-Key: i=peter_hong@fintek.com.tw; a=ed25519;
 pk=8sYixQfVOzNMM+g53fxG9d3MHOFC02ZggNS0OhG5LMA=
X-Endpoint-Received: by B4 Relay for peter_hong@fintek.com.tw/20260824 with
 auth_id=973
X-Original-From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Reply-To: peter_hong@fintek.com.tw

From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>

Unregister the URBs before cancelling clear_reg_work to prevent an URB
completion handler from scheduling work after cancel_work_sync() has
returned.

Otherwise the pending work may run after the netdev and private data are
freed, resulting in a use-after-free.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20260824133009.CF85A1F00A3A@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
---
 drivers/net/can/usb/f81604.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index 4c147b9d6d69..bb155b876924 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -1075,10 +1075,10 @@ static int f81604_close(struct net_device *netdev)
 	f81604_set_reset_mode(priv);
 
 	netif_stop_queue(netdev);
-	cancel_work_sync(&priv->clear_reg_work);
 	close_candev(netdev);
 
 	f81604_unregister_urbs(priv);
+	cancel_work_sync(&priv->clear_reg_work);
 
 	return 0;
 }

---
base-commit: 475cb4ea138f4b0e7f43ff79220f4013a6a840b8
change-id: 20260901-f81604-fix-9400ea120256

Best regards,
--  
Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>


