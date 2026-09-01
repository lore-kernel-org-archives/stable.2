Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785D38E8CC;
	Tue,  1 Sep 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272729; cv=none; b=A9QzRvKahFhJqiSRAqjxVrCVEZhaF9/KNNVwS/TPwmoDRky8UqHAek1IBRDNRmPx1Tnwr+sjjlv+Xb+reTWUkPx2iDLRU2hp8+LzfxG/BE+qOIUQyPENwfe+p1jUJGvoyhhzBrztDwjeA7Q02rjK+k+Eg8FjnMWUKYAZ4NtEZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272729; c=relaxed/simple;
	bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEFQ8tLaYLmdAquy71nFcztec7IVM4n7g5QeT8C/oBVoGZpisXxa6mweArOUiDGR4Ze/JVxqhQ7f7IN+GAWETyTUKxIHsktvt7xRAhFtA7DvLbqbGw09oW9VTyAxifr2HPKilpBbIHwXKmwfpnuymBux40PtW+urIS6x5AID3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=s6swvN7o; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=kcBwlKHc; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="s6swvN7o";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="kcBwlKHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272726; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6swvN7oQZbxGyPrdOE9METD9UDHkCUWv4JwqJmgHOFkdSZM/pIIu0vDln0P9CJVj
	 IPka10I1MY6V1mb/N3hMYKmiz6mOjuCoLBKWIiJwTUt40PxqllsB+zk3qWchBS9TLH
	 1ttCciZw9yW9zZ+4QppYDSWcVPviv0U5zmK4rQgsiKMNr0wC1osUNo0vstqy3XRKmf
	 RsAF/LwDnSTZuR1ZU/AnDyRucmxIEYvDargVsDF7nRS7wHnDGUfdMMm5P5n3KzbSxs
	 57HYPmP9TVUYSkOIfPP69EACHGP70pWDO4pra0/ND9IHEtYb9SRODZy0xFSqbI/mWa
	 QhAPtHOjha1KA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 0201841447; Tue, 01 Sep 2026 15:25:25 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272725; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcBwlKHcLPI0dQOsq9q0udZTFAtsLPSrDizFaRht6bkbknl4eaJcMVCkrm2KomzOL
	 RHMuNej6UZO0GKTXeBnCGkjTHz8ZQQlEm5LWQS2TatLmT5CCGpBNZ/IYg4ciJUjhJW
	 tgPaVe14pN5e8E6WUZQRTvsODoPCn/U9SNZV4Izt8QzZaBBP5GPyPktyPueCSQDhvW
	 XKSHVdM6ivDfv8RqvRbsSBGl7xnLXdydXM/D095GVEsCjwjf3tVT33w8fHyo+Zar/4
	 +156CU2dzrlByH3x466RIpKqhk+0I03bk0hSoIsXyVeWwlsNA9kQfQsZhNVXrvg94v
	 f2a+o+mwls+mA==
Received: from maru.home (host86-128-233-22.range86-128.btcentralplus.com [86.128.233.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 3950341444;
	Tue, 01 Sep 2026 15:25:25 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] media: rc: Ensure registered is cleared in error path
Date: Tue,  1 Sep 2026 15:24:51 +0100
Message-ID: <c1f1990e3610766e6f08215a6a7dcd1bec6cfc2c.1788272198.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788272198.git.sean@mess.org>
References: <cover.1788272198.git.sean@mess.org>
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

