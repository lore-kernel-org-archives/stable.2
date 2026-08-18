Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCF4477E8;
	Tue, 18 Aug 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045817; cv=none; b=OTN7q3pYRPvfnx2DAA5gezqEUVRjPrH9uVrCMn7vTs7QZ+loFQtZqs3cxDHVoHqzWj77d3kNM5QlZAs3KxnLZXAlat9EK/fSB3seMrtYKlhuGUg7t2syJkxVobxCdE1A6ijba9KQCnR7XcMEnEeD2CkclSE935XHbgf3SgLqUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045817; c=relaxed/simple;
	bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaeExjiNmrLpr/kHJSlHUvGOv538PziN+PmGcuo8cr9q3uYtnVm3BjGmonlNNKvNYThS941JmUDXR17tXBS5EGeYtUOWrrnnB0lLW2Urh+Iw2bbem+uLqpdKnD9HLQso/toxsog8uIb/RCjJInDSF/SxC3dy85u1iH2COC7l4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=G0iwWRxd; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=GSjSIo/Q; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="G0iwWRxd";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="GSjSIo/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787045806; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0iwWRxd+71HmGNDaX+6UHBsfy0h3q723D1KJh5l4Yvi0E+3lf8v6dNg2SmYn7Nd4
	 /UkHjBCXgZaX8+lZkMsZZQhZH1VViK/nLOUf3TSM1Rwp3bxdBVFbuBMHFHWemKDmx3
	 iqqE8MnufdBO+tUQwHrLdRSDyeDXzZMogjSMdEVTCW347wUiaI6709MnaZN17aWRTI
	 oIoImqj9weRuTi1sKgQm+ivy0OUTPv1mWutAOGBdXQfwq5WXiqx69BWk9SuUBb0qdW
	 9eZIekLlD3uHtIMxjB7maf/35ZcoEVIGP9stG/Mrt7BO1gjGD+KaH4F9sUVH9eVGIb
	 l3dmlClY3Ev2A==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id C76ED41D26; Tue, 18 Aug 2026 10:36:46 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1787045805; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSjSIo/QkGhvbnwsppZaMVOew6Q+zfsAMG1O6DCyW59hbBZbCN+Nyax5zA5c6l2k+
	 33E9DY5eYHhTnA19OuU36G+4hFP9HCyqvGd1pZtNZlz8C4wiQedtGEoFGG5JWNc8Q+
	 ItQGLPHw6h95AUfnjlSwm0gVdSkGMhNEQ7Rg5vzDw3C66sA3jZcHwtlclzVRfqvRee
	 3MDiqlWez0R/fogP2TrUMphMzBflkcL8SmJmfDAWxIWCL3lHtoykidm3dUDe+NMd0d
	 pq+1fY+Kkwqx9K7NnOkrCQ8tVRuZ8yfQu+kM01jnX0v57qiHdcVQIjQhn656uMnlNv
	 gTigjoo9Nd73Q==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 00535408BB;
	Tue, 18 Aug 2026 10:36:44 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] media: rc: Ensure registered is cleared in error path
Date: Tue, 18 Aug 2026 10:36:31 +0100
Message-ID: <1d5591e11daff7d42ef86c5e53d0ae421f6bb7d7.1787045579.git.sean@mess.org>
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

If rc_register_device() fails, ensure that registered is not set to true.
If lirc_register() succeeded, then userspace could have an open file
descriptor open. This leads to a use-after-free.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index d93e98189c1a..1f99540456f1 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1934,7 +1934,8 @@ int rc_register_device(struct rc_dev *dev)
 			goto out_raw;
 	}
 
-	dev->registered = true;
+	scoped_guard(mutex, &dev->lock)
+		dev->registered = true;
 
 	rc = device_add(&dev->dev);
 	if (rc)
@@ -1982,6 +1983,8 @@ int rc_register_device(struct rc_dev *dev)
 out_dev:
 	device_del(&dev->dev);
 out_rx_free:
+	scoped_guard(mutex, &dev->lock)
+		dev->registered = false;
 	ir_free_table(&dev->rc_map);
 out_raw:
 	ida_free(&rc_ida, minor);
-- 
2.55.0

