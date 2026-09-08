Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC556E053;
	Tue,  8 Sep 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882860; cv=none; b=p9qjoyGTuWcXQw8xVs1XIhsIGKlvXvUzAEJ/wIvy5cHHGihYMPdS1qpeZRmTYqVkFj2lCy0m5iGWjEdCelCvDRHi3pb4WQK4yDZEZYbI+UWTbl6SPNhbi4kUs017Y131TAeP/3OM0N0lx1Zt6iZDsgXOj5GrGGgzSqQKmGMXWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882860; c=relaxed/simple;
	bh=knl9K8P7DwwSxVkOS5n9sh72AjW62Q/s0/VL+riJqKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuQhkUHOOZypR3HS+ED9sgYAg5ZH+aTPFroWIBuBg+1Ke84tep2LZ2olvj8UW++NolEXAGcdu23lsNe/Y2TcNUK9Ti2fjVlN496lrDduz3ZS86Uj1WvcFYogUWDq7t6Xk9ZZETIhyyFU797mc+OZMq/25Poj7wNV6flF8EO9x58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=LjDt7h8O; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=PopA1IGE; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="LjDt7h8O";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="PopA1IGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882851; bh=knl9K8P7DwwSxVkOS5n9sh72AjW62Q/s0/VL+riJqKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjDt7h8OGyy19I+GC25H5T9cRNZOpUwDsYX4fhpHdmb8g6aMf8BpOnCNG8M+U5kN2
	 /HiV134fka7pW+miZbEx8BMTiciZRm5WK+i6wWBs1LFQIU8y7rtrylTaweikX8OU8j
	 0+CDTXFcn016QPoWyMYJ8H8HtAxVcnqm7pYsVGYYVpqvSJvWX6QxHqU4bMxWGXIFaB
	 phDIMhJQkzY8q7w6/u1kwpq79ZXHQP3czFqO+ZDKSJqgUERL/KLiikV5gn+zkzxMO6
	 blO+n0gKoB14nOX5bVPMfxOMTwAmh51Xai0v/aW+r8A2vl5BCd+gA4CGRFhzWWg23F
	 R5LcXseHN84Gw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 4E58141455; Tue, 08 Sep 2026 16:54:11 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882850; bh=knl9K8P7DwwSxVkOS5n9sh72AjW62Q/s0/VL+riJqKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PopA1IGE7ZOyjL2einaM6GJcZUSUV//F+X8PSsJbeNMHx6HtIs2ZthfnNlSNCBSlW
	 us+2f2Legs6GBtd6Co+cQR+HQ4aBGFbHDelhZlmwbb+9jhoS6aVnncOERKWsv8Xp1N
	 nhmKBhfq++YNcDOfRG/iNEaQrKHTnzc+QprLYvFZivLh6O4LG+fO1y2kz48XrcyJ5H
	 MOtQzQ3laOtMlvs/MtRSn24PmdcuvUEf68nKyt37YV0VGQn2MwCaq01hI3w+BrsPMf
	 5zTddp+eAfMnoWsJaXzspbBuHTGTGY901X4fgoPynorDH+k8m2Hqlb+iYqLWS/8/kX
	 B8+JobpAIf3WQ==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id CA1E741450;
	Tue, 08 Sep 2026 16:54:09 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 05/19] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
Date: Tue,  8 Sep 2026 16:51:53 +0100
Message-ID: <e3a4d95659d373050abe9da495f417e16d7def37.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788882189.git.sean@mess.org>
References: <cover.1788882189.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark the device as unregistered before tearing down raw IR/bpf
state, so that racing bpf(BPF_PROG_{ATTACH,DETACH,QUERY}) calls
cannot slip in between ir_raw_event_unregister() completing and
dev->registered being cleared.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 04204559959f..924b13fff753 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2050,18 +2050,18 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
+	mutex_lock(&dev->lock);
+	dev->registered = false;
+	if (dev->users && dev->close)
+		dev->close(dev);
+	mutex_unlock(&dev->lock);
+
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
 	timer_delete_sync(&dev->timer_keyup);
 	timer_delete_sync(&dev->timer_repeat);
 
-	mutex_lock(&dev->lock);
-	if (dev->users && dev->close)
-		dev->close(dev);
-	dev->registered = false;
-	mutex_unlock(&dev->lock);
-
 	rc_free_rx_device(dev);
 
 	/*
-- 
2.55.0

