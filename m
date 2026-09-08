Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830DD56C624;
	Tue,  8 Sep 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882856; cv=none; b=ozmpSodFiPMEfJCmZN4KAcbSxSEfHUBzjilGGqrIC+bSXDodDdY+7PLmrPACn2JxkmR41LsA2xqhhWnzhM5a67Gd/CGpO54+P4QZPMQZfj6Bho0W8oRQ4Uiup7OqSq+h2MpRZuy7jJJfTitAC/FllpWhsbepw6BPFxIFtj785Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882856; c=relaxed/simple;
	bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jegHKa+P4R9U5yvdWmOtfWqDZSVwAIbtH7V9xoKJGYgCw8GUl2l80kMpJ+yprmbfzFp94BnxTRsvZbkcY5Yua39UzchHUcj1pZLgmZiQqIESDVK4RI3ttN/DY25ixNHJihcymBEgIDh7Wf6EyM3MnBr1/DiQ35vN18qb+pG4uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=o4/Tyw2E; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Rc8FjQ4i; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="o4/Tyw2E";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Rc8FjQ4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882847; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4/Tyw2ElA1SWXjXNbfuPfthQpWRezTb4FVmSJ2vA9cm9PwTtXIdd54Ytr1Dpd3OS
	 eXyVRZijfMm9J49qfigyq2o5y8YUDPSSR4a2mU6AJ8b/rdVZtU+s0orT1FsodruO6b
	 QUYjJbvrd0kfGMoEapoYwQaPagHuP/wrZRFaxw7856HpiV8a5qcQrOOsmmLKQKj3z6
	 /E4BicT4BNPFRI1K9bxWlk8ATTAh8bIizTYSv8p64yVqlEkKuk2xD70WxS2eR+XiP7
	 v8EinCJ0rjoVl54M+Nnb6vRYb1gKN1ZQIf5LxLKjFiwAzK12Fa8ZRJFGvoYGZ18pdT
	 AiA2UPD7h+Jmg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 1EF444144C; Tue, 08 Sep 2026 16:54:07 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882846; bh=/8v/KW7+ptUdl1t9WICdp/3hPCwialykjU/Ai9wNdgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rc8FjQ4iv5sHBKceFGgXab1OQlKNuubNSB1F2b/fn+4P6qXtfLHbwA8PxLVir+PcF
	 vX77NsxFc35XzkNYfQxtdxoVKD10zT1/CMfdmhDVg2Mb98bv1ukJGaiUcad+ub6SnG
	 4VAy/MKiDG0sfoT6Hz23y7znN6El1XJMe4bQ4wfIj9Cr0LOcXcT7V19feK8osQ4BIu
	 ZZc32S8Ko5pKAtv83Y0aOzuHK0tKUsbGLlOJLVIbfehtAQCN6cdHapLCkMMhVWgCl2
	 WuFMT+saArY3hf26xxXlSqlsFNUC7DFHbsyYsNR0/2348Y8j+kSKe2YV3X4sTyCyMA
	 f2S4IOfNdqoQg==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 4A8C041444;
	Tue, 08 Sep 2026 16:54:06 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/19] media: rc: Ensure registered is cleared in error path
Date: Tue,  8 Sep 2026 16:51:49 +0100
Message-ID: <abfff8cffac8899a26cb258150b5c17b7a2009bc.1788882189.git.sean@mess.org>
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

