Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227A24BBEB
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784472826; cv=none; b=sRzn194LQbnSSS24VvfcPfdSPKGq4dcquD6SJjfQl4kix95Tet1EAwyYWAzONWiVvmxUKOxQFu2XK1oTcMSbzjgKT9FpzSxc7iSTV5cjur9XpmYNAikBmKYQt3me1G/P9EdD8sdci2MAtQ2CCwNZEGXf78ZUn4xIPGFhjPILKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784472826; c=relaxed/simple;
	bh=LYdgYlPiAVBVZIA9CELxGKKSHN5juHME5MRNF5aMdgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UykTW554Y3tvu6Gyosuo2c2YQ7EWUUjq7AmJJJfOfwyup9YfDKGKssb9atYzdH1dPDHfpXXKESOrbf4oXwiehlGgUIn2eqax7OyxpTP74wptwrKmMwHyYDkSAbipGZnZwG2M9mVB7aCUra5s1zaOr0cRZ4l56ZvjbdAf7/ocxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po3/lsXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po3/lsXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDF61F00A3D;
	Sun, 19 Jul 2026 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784472825;
	bh=eBLys2dfRLymAJveOBrLW+IwIPZFYDSZVyeiMLTZEQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Po3/lsXJ1KHSTGdO9t9vCRKEA0sccMjge2JQA87zHdRzMgggSkZZevTl1AKBWCOsX
	 DO6miKpR+tNeGzJ4n+F/Ug6SvI3hzS6TtDU5NxzjJMXrn28SdkAhJk52htbFkdm06l
	 DCmHNy2Clp/1bfQzBYBJwLWR9X5qyzWE3qnZoGVfCARNyRLkmKdTWzckEjOtAFQEwb
	 UOFvHMfnPAZivZfV+DS1ESoX/jUVX/UabYvut+T6sBE1hWGFAjP6KGegtzO9kvgei0
	 XjQabsMIuMXbraBOmVVHeSNV9faH87279o/GmW13rM/nUFc8JlqKpD2Drpy4/k1EaV
	 Filzruy1pSW1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: gadget: f_printer: take kref only for successful open
Date: Sun, 19 Jul 2026 10:53:42 -0400
Message-ID: <20260719145342.5397-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719145342.5397-1-sashal@kernel.org>
References: <2026071412-epilepsy-clerk-af1b@gregkh>
 <20260719145342.5397-1-sashal@kernel.org>
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
index 8a65094c421e3b..473206c0362d47 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -358,12 +358,11 @@ printer_open(struct inode *inode, struct file *fd)
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

