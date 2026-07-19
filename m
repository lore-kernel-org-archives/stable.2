Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD05277818
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470597; cv=none; b=KSQV02gMNur/s53+hsNfDeXlfCTS+wnTF6y8sS/BTSrP482fGBIqxIBjJkBc4eWy1nmhDv2tZ8rrtgyb+E+KTOHhT+H9o1UtcujMYDH44aNNRgQc4bCm5XSeHBAgEEgBV17YNtSfMgPgPWLm5RNA5u2vLWisBFxabRkcGj4Dwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470597; c=relaxed/simple;
	bh=1H7ZTeS6jkKVPK1zkkqD+EGX9mtvMf9/RAjVG2cBM0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnhVJ0pmBbXHopBUcnBfXW545/tks5SZDBzOZrt+YdWVCgj5PCMUPs/WUqNr8t5VqT+sdxiHrQcfPymSX3n8218usl0Z6aVhCBTg2DZ5iFbaQYIqfJk+Mk94UHzabjqD5mIAWSe8Jhsa87zrkASyBWB4F3+tAiZhUfdTXU9pMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHSJK8ub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHSJK8ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7385B1F00A3D;
	Sun, 19 Jul 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784470596;
	bh=Pd/3OVTiBG2e9czHFOg6FSliqt1meumjK0aBX/unJqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bHSJK8ubfEKqL+1rcNlqpQ5m9E+mKVNU1B8Ovl/vyIIuNErn2YqKMcJGvfPIH7fra
	 WDBeI+vIzkESxIWJDN2Zo0qWmbO6nPLaidpmOci2vxncZrjT1eibWD9CxhNcjx2E1B
	 L5GpPhGlwh/4geZ1EXBQsJVMKQSwvFMWHG+MSt3bqJ8/MtdVKHOhEBln+GP10G8olY
	 IGj/nX/RUrVt7JCgVC6OmK1yi51X/MvPm+3+ciXH2EVeP1aUwmgeYRRRLVQZM+uR74
	 RKAge2Gt2t5JTOGJOtYZiTTZ8qSol7Vyf5jbqNE774n0trqmy72rA7Iqe3DfqeRMoV
	 vm1pKEoQb4MiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: gadget: f_printer: take kref only for successful open
Date: Sun, 19 Jul 2026 10:16:32 -0400
Message-ID: <20260719141632.4057531-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719141632.4057531-1-sashal@kernel.org>
References: <2026071412-chop-overreach-6861@gregkh>
 <20260719141632.4057531-1-sashal@kernel.org>
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
index 6f995b87aa5743..fe87f551b8f30e 100644
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

