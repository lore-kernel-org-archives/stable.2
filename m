Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730204772A4;
	Tue, 15 Sep 2026 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461188; cv=none; b=Pm38mGf1PyxKnEOfgaCzxQv3RsdFqKBbfY/2Rlv5/PqHLwSwagbfO1+k5ipO7//9+F80grc1cDeK/AuPXnXDAijOgrFrZyzB33L5c7miCD77OizYP6Seu+G/C12xFijTnI9On0B+fUNTxhASTpzf9Ld5hH5GtMnnKkoaaZ9wwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461188; c=relaxed/simple;
	bh=RCzmVR5nKblaNJ6RNGAmHUUCM7Igg9ZLLONFiT3MVrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oihPuNGO7RGrg6FxLQCcq4H4edWgF2yBUCAcz+G2cUTfW2alsfGu1lSR9K7sTe8cW96h1YQZfmhtLhNTYt/BR2sJj4Qpp/E7JK2joQUuNDBd63TUfMSKB+cdgw2WOkTZRRjSB62saReSSsSmPNc7KrIhiyjTXC873a3fzzZzwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=hsE9KTiz; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ocSBUl/m; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="hsE9KTiz";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ocSBUl/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461184; bh=RCzmVR5nKblaNJ6RNGAmHUUCM7Igg9ZLLONFiT3MVrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsE9KTizFhRMXswkGNdcrp33R5bgnqDWKohWlRcIxQXsEu4ewQLT6WaLiaSdsc+il
	 LvZkZfSsGK6KZQRhrW2tnb0BhbcZWYk4xYFrAjDmO/RcroBWza9FV3h6IRxe+AJ7b2
	 ZITqkkRNsq8DQGEVqgpgRJZMM4Vc+XiKbwThNA0UC6sa8PTESPicPQsbyGjQiBF4k8
	 OPSxHeaj4fZVwygMxaqoHEIqKZg9jUzag/XzdigJzuGNMjPjVHNPyEkaFcrqjLw8OZ
	 wWMtRPzHlhiQF6TosTTTXfrdQ8A9BEHRoZi2O/HsLHW5WcQa4vj0WW0kByejmpLNBd
	 1rEY/WNMxdrPA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 9481140B87; Tue, 15 Sep 2026 09:33:04 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461183; bh=RCzmVR5nKblaNJ6RNGAmHUUCM7Igg9ZLLONFiT3MVrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocSBUl/mZN90LBso7rCOc434pz/AOUJ6UFzS4qengI5fLwV349QXxkpmAToAToVKj
	 RNr8UXwbzfooBUx0YE0i2n+nxCU2crOakTg5lNv56QpNwkvLbpYgudA8U06DkkmZsR
	 wHqgzSLqKXlcW7dQlloO0c+oL32XTvYeVaaSlIWxhsGv4XilDh24oTH+uPoVqX/vc5
	 C3emNKGYt9q4sufWonIwJiPAi57FAxiE1AOpjWxMlmugQE/CWk5q0m1T4SmCsEbcG0
	 Zu++5Q9EntgOxbUvvN74vaVPTecA0AQ9+FSJAW+CT54WDld0oFWQT1UZdSWl2++oFS
	 /O7CD/2nMNEog==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 789AC40BA4;
	Tue, 15 Sep 2026 09:33:03 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 06/20] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
Date: Tue, 15 Sep 2026 09:32:16 +0100
Message-ID: <a6e028d16704a606a6439aab0f65df888d9c84b7.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
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
index 67d86b8ea5e0..37ba19164875 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2056,18 +2056,18 @@ void rc_unregister_device(struct rc_dev *dev)
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

