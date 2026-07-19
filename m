Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906939524E
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471183; cv=none; b=X6tpsdA9cwN7Zc+/MvgSjsWKoYWZTF+85opTaVhUWLNxS8nb/Mcbpq5M/n80ZDdMRsxgI61s34YRq39OGgNkzvb9eEFGH4d3VCAqOBawArKsxkHj2boSHEqa7fRHhOYPB0mKvtO9DRtC0fbjSoyYm3bjRAc5QfpaClglHpab7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471183; c=relaxed/simple;
	bh=YBmvtpxzGC5TaZBzNqkF3l9D88yLUxnyY4CGXYSaxFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjUknuQ3geqMtCG9qCLrcjxgU4lK62LICIwM+x/QoZUSG9X7QQ3TgrNFk2ujfEgr9/a4rAWryZs7BiodXiEsAnBKuGQt75UUe2M9g/8/IdUGyV1so/IVA5xx4dRQ7lDfuwcRNXa35EoZhFa6EtcVJcXVY17qdKVfnIOMy+p+Ujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuuqw4dY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuuqw4dY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243501F00A3A;
	Sun, 19 Jul 2026 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784471181;
	bh=0XiI7tlFkLro6X9hs7Fnrs+JlO9gy+fncsmalYQEzZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xuuqw4dY0b3RNb8Us2bUf8KMQ/i2Ka2aj2EhDoXDpm0TCN/PDsb770k5B/Um3MIRd
	 j4rOsila05OF+V+mq5PHZ9e9dK9VJ5y3F5b6B5QZtKFjP/ixv7JUzAmIemfgbT2FSy
	 xGyxJJR9GDORarPFSdt+2lRetQqSS9fpEAoU7jA9ArIpKRNbxzYnIuS/YlqFrt4o74
	 Tus3i/Km7g02Hej4jGOtchXTBNp5DvplbgmX3SfonheUSYDM8DaCbZEtR/xGticS6S
	 zZrosaKdMwQVxDU9h1g6wU4W5BQT892DAsw83YDwJfQwI4SxysnGd2m0chsCuNuBOl
	 6Kq7N0koSR+5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: gadget: f_printer: take kref only for successful open
Date: Sun, 19 Jul 2026 10:26:18 -0400
Message-ID: <20260719142618.4094375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719142618.4094375-1-sashal@kernel.org>
References: <2026071412-palpable-underuse-1c58@gregkh>
 <20260719142618.4094375-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit 30adce93d5c4a5a1ec29d9249e3fdfcc391d406b ]

printer_open() returns -EBUSY when the character device is already
open, but it increments dev->kref regardless of the return value. VFS
does not call ->release() for a failed open, so every rejected second
open permanently leaks one reference.

Move kref_get() into the successful-open branch.

Fixes: e8d5f92b8d30 ("usb: gadget: function: printer: fix use-after-free in __lock_acquire")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/80295742B820DA9B+20260626064617.4090626-1-raoxu@uniontech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_printer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 60e833bd75f8e6..4b107c26e0d7eb 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -360,12 +360,11 @@ printer_open(struct inode *inode, struct file *fd)
 		ret = 0;
 		/* Change the printer status to show that it's on-line. */
 		dev->printer_status |= PRINTER_SELECTED;
+		kref_get(&dev->kref);
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	kref_get(&dev->kref);
-
 	return ret;
 }
 
-- 
2.53.0

