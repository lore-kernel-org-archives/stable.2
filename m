Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1D3B3C1B;
	Tue, 18 Aug 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045815; cv=none; b=Z0zxsCZupYX5h8OljBincauWfvG2+Sezlhuy0lfyWblKr7WWIathJc6MKgvHKWI1Hhew8jPskZcISBBsPevCGOK4hbJegKPZB+rb+k0ejyQF++NTTHKI3tiyj/x+X7fyOJ0qJRQZB7GbBEu2w8sABgaus3YD6uyBhMI8bOVXlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045815; c=relaxed/simple;
	bh=IDmPjIZF6DGbe59zSIl8J8Qdh0UwrvT74JqAfHA68iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXUNb7xHRveLZeXJFJBdCju3Fy3j1rwy4Qi1kzmG03MNKJ5n6YaoWSTAI25o2f4KUI3BlTQDNte/O2qfVnrs3bpLAdQlDN6u2gM6sEO9ePTO+42BFm8dgx/+0jpysHbRE0JqHlI55o2FII6YdwZxCiyUrC3t54PdY+TaJB8bd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=WcU2U6BP; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=CrItDQX5; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="WcU2U6BP";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="CrItDQX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787045807; bh=IDmPjIZF6DGbe59zSIl8J8Qdh0UwrvT74JqAfHA68iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcU2U6BPx+jICbnhd7JOi/TKQ/kaOxpZYMdepCk5SddPS22KCyz2oyvaleAh/01DX
	 QQTiMQzWoJYm+3h0+R6V5PWKsS44UPuftnPDI3Ggz4TaLoiwSdMbupYHNHIUHV9iet
	 g3yyuxZPLG8+x9yZuT0jeZHAhDDaDQPvU2Rjo22fXOQMm3BgDdHiJOunqEOhuZhj/R
	 a+86RYc9Cxr4CJ5Up84A4/9GzvdSzgr+Jpo2ePnKhlMInilyj9LSycXj/RS+TG9XYv
	 YFKDm6SJ2XvWGnNH0FFgfI0tnUyfGM4UvILCfz1mwcl6pvs2uaUsdr/pFeD+z6L5Bc
	 80CwTZOSK/Yrw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 4023C408BC; Tue, 18 Aug 2026 10:36:47 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787045806; bh=IDmPjIZF6DGbe59zSIl8J8Qdh0UwrvT74JqAfHA68iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrItDQX5TtK9EKgEZE5yGrCVhXumXdKIsdu7hb0yMGJFgfBSMHcqcxguHKguX2MBp
	 06DJMoabQDnd4NgExIoZr5Pnjw9ZfFHzWN/qsA/fUAcfux3SwVmeYtU4ZK84pZ+wqM
	 Q/QTWpzoIm2ZyUz80Q6pleoA/DX+bXbl24Y701tXuG980/jvtioiFgsqHMUW2jvchM
	 dMYdOSkeAZCHRvF6YKzd/2ZCQyvwW4V8/F5KY5ldfVZYgBf/cnZfrLJa0RX/D2TIGn
	 A2Ro3SllUQshW19NIvwJ1uavxsGmz1yW1ElobmsewRBCkPNVErG7QkzOfXKRuQ1hdj
	 zWLfIsum5I4QA==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 4C1AC40192;
	Tue, 18 Aug 2026 10:36:46 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] media: rc: Ensure that rc_unregister_device() does not free input device
Date: Tue, 18 Aug 2026 10:36:32 +0100
Message-ID: <a90d7282986835c48b11b88d8263b46fb1b293f7.1787045579.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787045579.git.sean@mess.org>
References: <cover.1787045579.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During or after rc_unregister_device(), IR may still be reported which
results in a input event being reported. This could result in a null
pointer deref in rc_keydown() or a use-after-free of the input device if
the pointer was read before it is set to NULL.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 1f99540456f1..10b924186826 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1723,6 +1723,7 @@ struct rc_dev *rc_allocate_device(enum rc_driver_type type)
 			return NULL;
 		}
 
+		input_get_device(dev->input_dev);
 		dev->input_dev->getkeycode = ir_getkeycode;
 		dev->input_dev->setkeycode = ir_setkeycode;
 		input_set_drvdata(dev->input_dev, dev);
@@ -1753,7 +1754,7 @@ void rc_free_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
-	input_free_device(dev->input_dev);
+	input_put_device(dev->input_dev);
 
 	put_device(&dev->dev);
 
@@ -1891,10 +1892,8 @@ static void rc_free_rx_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
-	if (dev->input_dev) {
+	if (dev->input_dev)
 		input_unregister_device(dev->input_dev);
-		dev->input_dev = NULL;
-	}
 
 	ir_free_table(&dev->rc_map);
 }
-- 
2.55.0

